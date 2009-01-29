From: Daniel Silverstone <dsilvers@simtec.co.uk>
Subject: Re: usbtouchscreen: Add support for Zytronic capacitive touchscreen
Date: Thu, 29 Jan 2009 10:55:15 +0000
Message-ID: <1233226516.29200.1.camel@petitemort>
References: <20090109121026.052643915@fluff.org.uk>
	 <20090111234903.ZZRA012@mailhub.coreip.homeip.net>
	 <1231751234.23618.6.camel@petitemort>
	 <20090112212907.ZZRA012@mailhub.coreip.homeip.net>
	 <1231838958.30531.3.camel@petitemort>
	 <20090114053515.GC4375@dtor-d630.eng.vmware.com>
	 <1231954613.9219.8.camel@ataraxia>
	 <20090115151228.GU15238@trinity.fluff.org>
Reply-To: dsilvers@simtec.co.uk
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from batfish.pepperfish.net ([87.237.62.180]:57404 "EHLO
	flounder.pepperfish.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751288AbZA2KzX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Jan 2009 05:55:23 -0500
In-Reply-To: <20090115151228.GU15238@trinity.fluff.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, vince@simtec.co.uk

On Thu, 2009-01-15 at 15:12 +0000, Ben Dooks wrote:
> > > > As I understand it; yes. (Some bits of hardware really are hideous
> > > > things) Indeed if the driver fails to load quickly enough, the device
> > > > might disconnect/reconnect before the driver can get hold of it.
> > > Geez... you sure it wasn't just broken device/batch?
> > Nope, the datasheet proudly proclaims this watchdog functionality.
> Would be useful to add a comment about that being the primary function
> for the irq_always flag

I've done this.

Here is a patch with the fake pressure support removed, as Dmitry tells
me there is now support in TSLib for that. It also updates the comment
as suggested by Ben Dooks.

Regards,

Daniel.

usbtouchscreen: Add support for Zytronic capacitive touchscreen

Zytronic USB-attached capacitive touchscreen support
within the generic USB touchscreen driver.

Signed-off-by: Simtec Linux Team <linux@simtec.co.uk>
Signed-off-by: Daniel Silverstone <dsilvers@simtec.co.uk>
Signed-off-by: Vincent Sanders <vince@simtec.co.uk>

Index: linux-2.6.29-rc2/drivers/input/touchscreen/usbtouchscreen.c
===================================================================
--- linux-2.6.29-rc2.orig/drivers/input/touchscreen/usbtouchscreen.c
2009-01-29 09:50:40.677710539 +0000
+++ linux-2.6.29-rc2/drivers/input/touchscreen/usbtouchscreen.c
2009-01-29 10:51:24.897709879 +0000
@@ -13,6 +13,7 @@
  *  - IdealTEK URTC1000
  *  - General Touch
  *  - GoTop Super_Q2/GogoPen/PenPower tablets
+ *  - Zytronic capacitive touchscreen
  *
  * Copyright (C) 2004-2007 by Daniel Ritz <daniel.ritz@gmx.ch>
  * Copyright (C) by Todd E. Johnson (mtouchusb.c)
@@ -68,6 +69,14 @@
 	int min_press, max_press;
 	int rept_size;
 
+	/* Always service the USB devices irq not just when the input device
is
+	 * open. This is useful when devices have a watchdog which prevents us
+         * from periodically polling the device. Leave this unset
unless your
+         * touchscreen device requires it, as it does consume more of
the USB
+         * bandwidth.
+	 */
+	int irq_always;
+
 	void (*process_pkt) (struct usbtouch_usb *usbtouch, unsigned char
*pkt, int len);
 
 	/*
@@ -114,6 +123,7 @@
 	DEVTYPE_IDEALTEK,
 	DEVTYPE_GENERAL_TOUCH,
 	DEVTYPE_GOTOP,
+	DEVTYPE_ZYTRONIC,
 };
 
 #define USB_DEVICE_HID_CLASS(vend, prod) \
@@ -186,6 +196,10 @@
 	{USB_DEVICE(0x08f2, 0x00f4), .driver_info = DEVTYPE_GOTOP},
 #endif
 
+#ifdef CONFIG_TOUCHSCREEN_USB_ZYTRONIC
+	{USB_DEVICE(0x14c8, 0x0003), .driver_info = DEVTYPE_ZYTRONIC},
+#endif
+
 	{}
 };
 
@@ -547,6 +561,39 @@
 }
 #endif
 
+/*****************************************************************************
+ * Zytronic Part
+ */
+#ifdef CONFIG_TOUCHSCREEN_USB_ZYTRONIC
+static int zytronic_read_data(struct usbtouch_usb *dev, unsigned char
*pkt)
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
@@ -686,8 +733,19 @@
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
+		.rept_size	= 5,
+		.read_data	= zytronic_read_data,
+		.irq_always     = 1,
+	},
+#endif
+};
 
 /*****************************************************************************
  * Generic Part
@@ -836,8 +894,10 @@
 
 	usbtouch->irq->dev = usbtouch->udev;
 
-	if (usb_submit_urb(usbtouch->irq, GFP_KERNEL))
-		return -EIO;
+	if (!usbtouch->type->irq_always) {
+		if (usb_submit_urb(usbtouch->irq, GFP_KERNEL))
+			return -EIO;
+	}
 
 	return 0;
 }
@@ -846,7 +906,8 @@
 {
 	struct usbtouch_usb *usbtouch = input_get_drvdata(input);
 
-	usb_kill_urb(usbtouch->irq);
+	if (!usbtouch->type->irq_always)
+		usb_kill_urb(usbtouch->irq);
 }
 
 
@@ -969,6 +1030,9 @@
 
 	usb_set_intfdata(intf, usbtouch);
 
+	if (usbtouch->type->irq_always)
+		usb_submit_urb(usbtouch->irq, GFP_KERNEL);
+
 	return 0;
 
 out_free_buffers:
Index: linux-2.6.29-rc2/drivers/input/touchscreen/Kconfig
===================================================================
--- linux-2.6.29-rc2.orig/drivers/input/touchscreen/Kconfig	2009-01-29
10:16:41.433707585 +0000
+++ linux-2.6.29-rc2/drivers/input/touchscreen/Kconfig	2009-01-29
10:16:51.301709658 +0000
@@ -342,6 +342,7 @@
 	  - IRTOUCHSYSTEMS/UNITOP
 	  - IdealTEK URTC1000
 	  - GoTop Super_Q2/GogoPen/PenPower tablets
+	  - Zytronic controllers
 
 	  Have a look at <http://linux.chapter7.ch/touchkit/> for
 	  a usage description and the required user-space stuff.
@@ -426,4 +427,9 @@
 	  To compile this driver as a module, choose M here: the
 	  module will be called tsc2007.
 
+config TOUCHSCREEN_USB_ZYTRONIC
+	default y
+	bool "Zytronic controller" if EMBEDDED
+	depends on TOUCHSCREEN_USB_COMPOSITE
+
 endif


-- 
Daniel Silverstone                              http://www.simtec.co.uk/
PGP mail accepted and encouraged.            Key Id: 2BC8 4016 2068 7895


