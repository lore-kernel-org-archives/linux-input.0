From: Ben Dooks <ben-linux@fluff.org>
Subject: usbtouchscreen: Add support for Zytronic capacitive touchscreen
Date: Fri, 09 Jan 2009 12:10:26 +0000
Message-ID: <20090109121026.052643915@fluff.org.uk>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from aeryn.fluff.org.uk ([87.194.8.8]:54817 "EHLO
	kira.home.fluff.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752694AbZAIMK2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 9 Jan 2009 07:10:28 -0500
Content-Disposition: inline; filename=simtec/simtec-zytronic-usbtouch.patch
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: vince@simtec.co.uk, dsilvers@simtec.co.uk

From: Vincent Sanders <vince@simtec.co.uk>

Zytronic USB-attached capacitive touchscreen support
within the generic USB touchscreen driver.

Signed-off-by: Daniel Silverstone <dsilvers@simtec.co.uk>
Signed-off-by: Vincent Sanders <vince@simtec.co.uk>

Index: linux.git/drivers/input/touchscreen/usbtouchscreen.c
===================================================================
--- linux.git.orig/drivers/input/touchscreen/usbtouchscreen.c	2009-01-08 15:26:04.000000000 +0000
+++ linux.git/drivers/input/touchscreen/usbtouchscreen.c	2009-01-09 12:03:39.000000000 +0000
@@ -13,6 +13,7 @@
  *  - IdealTEK URTC1000
  *  - General Touch
  *  - GoTop Super_Q2/GogoPen/PenPower tablets
+ *  - Zytronic capacitive touchscreen
  *
  * Copyright (C) 2004-2007 by Daniel Ritz <daniel.ritz@gmx.ch>
  * Copyright (C) by Todd E. Johnson (mtouchusb.c)
@@ -68,6 +69,11 @@ struct usbtouch_device_info {
 	int min_press, max_press;
 	int rept_size;
 
+	/* Always service the USB devices irq not just when the input device is
+	 * open.
+	 */
+	int irq_always;
+
 	void (*process_pkt) (struct usbtouch_usb *usbtouch, unsigned char *pkt, int len);
 
 	/*
@@ -114,6 +120,7 @@ enum {
 	DEVTYPE_IDEALTEK,
 	DEVTYPE_GENERAL_TOUCH,
 	DEVTYPE_GOTOP,
+	DEVTYPE_ZYTRONIC,
 };
 
 #define USB_DEVICE_HID_CLASS(vend, prod) \
@@ -186,6 +193,10 @@ static struct usb_device_id usbtouch_dev
 	{USB_DEVICE(0x08f2, 0x00f4), .driver_info = DEVTYPE_GOTOP},
 #endif
 
+#ifdef CONFIG_TOUCHSCREEN_USB_ZYTRONIC
+	{USB_DEVICE(0x14c8, 0x0003), .driver_info = DEVTYPE_ZYTRONIC},
+#endif
+
 	{}
 };
 
@@ -547,6 +558,41 @@ static int gotop_read_data(struct usbtou
 }
 #endif
 
+/*****************************************************************************
+ * Zytronic Part
+ */
+#ifdef CONFIG_TOUCHSCREEN_USB_ZYTRONIC
+static int zytronic_read_data(struct usbtouch_usb *dev, unsigned char *pkt)
+{
+	switch (pkt[0]) {
+	case 0x3A: /* command response */
+		dbg("%s: Command response %d", __func__, pkt[1]);
+		break;
+
+	case 0xC0: /* down */
+		dev->x = (pkt[1] & 0x7f) | ((pkt[2] & 0x07) << 7);
+		dev->y = (pkt[3] & 0x7f) | ((pkt[4] & 0x07) << 7);
+		dev->touch = 1;
+		dev->press = 1;
+		dbg("%s: down %d,%d", __func__, dev->x, dev->y);
+		return 1;
+
+	case 0x80: /* up */
+		dev->x = (pkt[1] & 0x7f) | ((pkt[2] & 0x07) << 7);
+		dev->y = (pkt[3] & 0x7f) | ((pkt[4] & 0x07) << 7);
+		dev->touch = 0;
+		dev->press = 0;
+		dbg("%s: up %d,%d", __func__, dev->x, dev->y);
+		return 1;
+
+	default:
+		dbg("%s: Unknown return %d", __func__, pkt[0]);
+		break;
+	}
+
+	return 0;
+}
+#endif
 
 /*****************************************************************************
  * the different device descriptors
@@ -686,8 +732,20 @@ static struct usbtouch_device_info usbto
 		.read_data	= gotop_read_data,
 	},
 #endif
-};
 
+#ifdef CONFIG_TOUCHSCREEN_USB_ZYTRONIC
+	[DEVTYPE_ZYTRONIC] = {
+		.min_xc		= 0x0,
+		.max_xc		= 0x03ff,
+		.min_yc		= 0x0,
+		.max_yc		= 0x03ff,
+		.max_press	= 0x1,
+		.rept_size	= 5,
+		.read_data	= zytronic_read_data,
+		.irq_always     = 1,
+	},
+#endif
+};
 
 /*****************************************************************************
  * Generic Part
@@ -836,8 +894,10 @@ static int usbtouch_open(struct input_de
 
 	usbtouch->irq->dev = usbtouch->udev;
 
-	if (usb_submit_urb(usbtouch->irq, GFP_KERNEL))
-		return -EIO;
+	if (!usbtouch->type->irq_always) {
+		if (usb_submit_urb(usbtouch->irq, GFP_KERNEL))
+			return -EIO;
+	}
 
 	return 0;
 }
@@ -846,7 +906,8 @@ static void usbtouch_close(struct input_
 {
 	struct usbtouch_usb *usbtouch = input_get_drvdata(input);
 
-	usb_kill_urb(usbtouch->irq);
+	if (!usbtouch->type->irq_always)
+		usb_kill_urb(usbtouch->irq);
 }
 
 
@@ -969,6 +1030,9 @@ static int usbtouch_probe(struct usb_int
 
 	usb_set_intfdata(intf, usbtouch);
 
+	if (usbtouch->type->irq_always)
+		usb_submit_urb(usbtouch->irq, GFP_KERNEL);
+
 	return 0;
 
 out_free_buffers:
Index: linux.git/drivers/input/touchscreen/Kconfig
===================================================================
--- linux.git.orig/drivers/input/touchscreen/Kconfig	2009-01-09 11:37:07.000000000 +0000
+++ linux.git/drivers/input/touchscreen/Kconfig	2009-01-09 12:03:39.000000000 +0000
@@ -342,6 +342,7 @@ config TOUCHSCREEN_USB_COMPOSITE
 	  - IRTOUCHSYSTEMS/UNITOP
 	  - IdealTEK URTC1000
 	  - GoTop Super_Q2/GogoPen/PenPower tablets
+	  - Zytronic controllers
 
 	  Have a look at <http://linux.chapter7.ch/touchkit/> for
 	  a usage description and the required user-space stuff.
@@ -426,4 +427,9 @@ config TOUCHSCREEN_TSC2007
 	  To compile this driver as a module, choose M here: the
 	  module will be called tsc2007.
 
+config TOUCHSCREEN_USB_ZYTRONIC
+	default y
+	bool "Zytronic controller" if EMBEDDED
+	depends on TOUCHSCREEN_USB_COMPOSITE
+
 endif

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
