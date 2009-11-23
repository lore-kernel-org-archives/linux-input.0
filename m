From: Ben Dooks <ben@simtec.co.uk>
Subject: usbtouchscreen: Add support for Zytronic capacitive touchscreen
Date: Mon, 23 Nov 2009 14:39:52 +0000
Message-ID: <20091123143952.590982333@fluff.org.uk>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from aeryn.fluff.org.uk ([87.194.8.8]:39575 "EHLO
	kira.home.fluff.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753351AbZKWOkY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Nov 2009 09:40:24 -0500
Content-Disposition: inline; filename=new-zytronic.patch
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, daniel.ritz@gmx.ch, ddstreet@ieee.org, floe@butterbrot.org, jim-linux@nurd.se, Daniel Silverstone <dsilvers@simtec.co.uk>, Vincent Sanders <vince@simtec.co.uk>, Simtec Linux Team <linux@simtec.co.uk>

From: Daniel Silverstone <dsilvers@simtec.co.uk>

Zytronic USB-attached capacitive touchscreen support within
the generic USB touchscreen driver.

Signed-off-by: Daniel Silverstone <dsilvers@simtec.co.uk>
Signed-off-by: Vincent Sanders <vince@simtec.co.uk>
Signed-off-by: Simtec Linux Team <linux@simtec.co.uk>

---
 drivers/input/touchscreen/Kconfig          |    6 ++
 drivers/input/touchscreen/usbtouchscreen.c |   72 +++++++++++++++++++++++++++--
 2 files changed, 75 insertions(+), 3 deletions(-)

Index: b/drivers/input/touchscreen/Kconfig
===================================================================
--- a/drivers/input/touchscreen/Kconfig	2009-11-23 22:29:31.000000000 +0000
+++ b/drivers/input/touchscreen/Kconfig	2009-11-23 22:29:31.000000000 +0000
@@ -437,6 +437,7 @@ config TOUCHSCREEN_USB_COMPOSITE
 	  - IdealTEK URTC1000
 	  - GoTop Super_Q2/GogoPen/PenPower tablets
 	  - JASTEC USB Touch Controller/DigiTech DTR-02U
+	  - Zytronic controllers
 
 	  Have a look at <http://linux.chapter7.ch/touchkit/> for
 	  a usage description and the required user-space stuff.
@@ -509,6 +510,11 @@ config TOUCHSCREEN_USB_E2I
 	bool "e2i Touchscreen controller (e.g. from Mimo 740)"
 	depends on TOUCHSCREEN_USB_COMPOSITE
 
+config TOUCHSCREEN_USB_ZYTRONIC
+	default y
+	bool "Zytronic controller" if EMBEDDED
+	depends on TOUCHSCREEN_USB_COMPOSITE
+
 config TOUCHSCREEN_TOUCHIT213
 	tristate "Sahara TouchIT-213 touchscreen"
 	select SERIO
Index: b/drivers/input/touchscreen/usbtouchscreen.c
===================================================================
--- a/drivers/input/touchscreen/usbtouchscreen.c	2009-11-23 22:25:02.000000000 +0000
+++ b/drivers/input/touchscreen/usbtouchscreen.c	2009-11-23 22:29:31.000000000 +0000
@@ -14,6 +14,7 @@
  *  - General Touch
  *  - GoTop Super_Q2/GogoPen/PenPower tablets
  *  - JASTEC USB touch controller/DigiTech DTR-02U
+ *  - Zytronic capacitive touchscreen
  *
  * Copyright (C) 2004-2007 by Daniel Ritz <daniel.ritz@gmx.ch>
  * Copyright (C) by Todd E. Johnson (mtouchusb.c)
@@ -73,6 +74,14 @@ struct usbtouch_device_info {
 	int min_press, max_press;
 	int rept_size;
 
+	/* Always service the USB devices irq not just when the input device is
+	 * open. This is useful when devices have a watchdog which prevents us
+	 * from periodically polling the device. Leave this unset unless your
+	 * touchscreen device requires it, as it does consume more of the USB
+	 * bandwidth.
+	 */
+	int irq_always;
+
 	void (*process_pkt) (struct usbtouch_usb *usbtouch, unsigned char *pkt, int len);
 
 	/*
@@ -121,6 +130,7 @@ enum {
 	DEVTYPE_GOTOP,
 	DEVTYPE_JASTEC,
 	DEVTYPE_E2I,
+	DEVTYPE_ZYTRONIC,
 };
 
 #define USB_DEVICE_HID_CLASS(vend, prod) \
@@ -201,6 +211,11 @@ static struct usb_device_id usbtouch_dev
 #ifdef CONFIG_TOUCHSCREEN_USB_E2I
 	{USB_DEVICE(0x1ac7, 0x0001), .driver_info = DEVTYPE_E2I},
 #endif
+
+#ifdef CONFIG_TOUCHSCREEN_USB_ZYTRONIC
+	{USB_DEVICE(0x14c8, 0x0003), .driver_info = DEVTYPE_ZYTRONIC},
+#endif
+
 	{}
 };
 
@@ -621,6 +636,39 @@ static int jastec_read_data(struct usbto
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
+		dbg("%s: down %d,%d", __func__, dev->x, dev->y);
+		return 1;
+
+	case 0x80: /* up */
+		dev->x = (pkt[1] & 0x7f) | ((pkt[2] & 0x07) << 7);
+		dev->y = (pkt[3] & 0x7f) | ((pkt[4] & 0x07) << 7);
+		dev->touch = 0;
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
@@ -783,6 +831,18 @@ static struct usbtouch_device_info usbto
 		.read_data	= e2i_read_data,
 	},
 #endif
+
+#ifdef CONFIG_TOUCHSCREEN_USB_ZYTRONIC
+	[DEVTYPE_ZYTRONIC] = {
+		.min_xc		= 0x0,
+		.max_xc		= 0x03ff,
+		.min_yc		= 0x0,
+		.max_yc		= 0x03ff,
+		.rept_size	= 5,
+		.read_data	= zytronic_read_data,
+		.irq_always     = 1,
+	},
+#endif
 };
 
 
@@ -933,8 +993,10 @@ static int usbtouch_open(struct input_de
 
 	usbtouch->irq->dev = usbtouch->udev;
 
-	if (usb_submit_urb(usbtouch->irq, GFP_KERNEL))
-		return -EIO;
+	if (!usbtouch->type->irq_always) {
+		if (usb_submit_urb(usbtouch->irq, GFP_KERNEL))
+		  return -EIO;
+	}
 
 	return 0;
 }
@@ -943,7 +1005,8 @@ static void usbtouch_close(struct input_
 {
 	struct usbtouch_usb *usbtouch = input_get_drvdata(input);
 
-	usb_kill_urb(usbtouch->irq);
+	if (!usbtouch->type->irq_always)
+		usb_kill_urb(usbtouch->irq);
 }
 
 
@@ -1066,6 +1129,9 @@ static int usbtouch_probe(struct usb_int
 
 	usb_set_intfdata(intf, usbtouch);
 
+	if (usbtouch->type->irq_always)
+		usb_submit_urb(usbtouch->irq, GFP_KERNEL);
+
 	return 0;
 
 out_free_buffers:

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
