From: Florian Echtler <floe@butterbrot.org>
Subject: [PATCH 2.6.30.2] drivers/input/touchscreen: Support for e2i
 touchscreen module in Mimo 740
Date: Mon, 27 Jul 2009 17:44:45 +0200
Message-ID: <1248709485.29786.29.camel@pancake>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from static.88-198-47-201.clients.your-server.de ([88.198.47.201]:48554
	"EHLO butterbrot.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779AbZG0Pvm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Jul 2009 11:51:42 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Greg Kroah-Hartman <greg@kroah.com>

This patch adds support for the e2i touchscreen controller used in the
Mimo 740 (and probably in other e2i touchscreen products). Tested on
Mimo 740.

Signed-off-by: Florian Echtler <floe@butterbrot.org>

---
diff -ru a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
--- a/drivers/input/touchscreen/Kconfig	2009-03-24 00:12:14.000000000 +0100
+++ b/drivers/input/touchscreen/Kconfig	2009-07-20 15:48:39.000000000 +0200
@@ -386,6 +386,11 @@
 	bool "GoTop Super_Q2/GogoPen/PenPower tablet device support" if EMBEDDED
 	depends on TOUCHSCREEN_USB_COMPOSITE
 
+config TOUCHSCREEN_USB_E2I
+	default y
+	bool "e2i Touchscreen controller (e.g. from Mimo 740)"
+	depends on TOUCHSCREEN_USB_COMPOSITE
+
 config TOUCHSCREEN_TOUCHIT213
 	tristate "Sahara TouchIT-213 touchscreen"
 	select SERIO
diff -ru a/drivers/input/touchscreen/usbtouchscreen.c touchscreen/usbtouchscreen.c
--- a/drivers/input/touchscreen/usbtouchscreen.c	2009-07-20 15:33:39.000000000 +0200
+++ b/drivers/input/touchscreen/usbtouchscreen.c	2009-07-20 16:04:28.000000000 +0200
@@ -118,6 +118,7 @@
 	DEVTYPE_IDEALTEK,
 	DEVTYPE_GENERAL_TOUCH,
 	DEVTYPE_GOTOP,
+	DEVTYPE_E2I,
 };
 
 #define USB_DEVICE_HID_CLASS(vend, prod) \
@@ -191,11 +192,47 @@
 	{USB_DEVICE(0x08f2, 0x00f4), .driver_info = DEVTYPE_GOTOP},
 #endif
 
+#ifdef CONFIG_TOUCHSCREEN_USB_E2I
+	{USB_DEVICE(0x1ac7, 0x0001), .driver_info = DEVTYPE_E2I},
+#endif
 	{}
 };
 

 /*****************************************************************************
+ * e2i Part
+ */
+
+#ifdef CONFIG_TOUCHSCREEN_USB_E2I
+static int e2i_init(struct usbtouch_usb *usbtouch)
+{
+	int ret;
+
+	ret = usb_control_msg(usbtouch->udev, usb_rcvctrlpipe(usbtouch->udev, 0),
+	                      0x01, 0x02, 0x0000, 0x0081,
+	                      NULL, 0, USB_CTRL_SET_TIMEOUT);
+
+	dbg("%s - usb_control_msg - E2I_RESET - bytes|err: %d",
+	    __func__, ret);
+	return ret;
+}
+
+static int e2i_read_data(struct usbtouch_usb *dev, unsigned char *pkt)
+{
+	int tmp = (pkt[0] << 8) | pkt[1];
+	dev->x  = (pkt[2] << 8) | pkt[3];
+	dev->y  = (pkt[4] << 8) | pkt[5];
+
+	tmp = tmp - 0xA000;
+	dev->touch = (tmp > 0);
+	dev->press = (tmp > 0 ? tmp : 0);
+
+	return 1;
+}
+#endif
+
+
+/*****************************************************************************
  * eGalax part
  */
 
@@ -702,6 +739,18 @@
 		.read_data	= gotop_read_data,
 	},
 #endif
+
+#ifdef CONFIG_TOUCHSCREEN_USB_E2I
+	[DEVTYPE_E2I] = {
+		.min_xc		= 0x0,
+		.max_xc		= 0x7fff,
+		.min_yc		= 0x0,
+		.max_yc		= 0x7fff,
+		.rept_size	= 6,
+		.init		= e2i_init,
+		.read_data	= e2i_read_data,
+	},
+#endif
 };
 



