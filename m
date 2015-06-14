From: linuxsea@163.com
Subject: [PATCH] Add driver for CJTouch touchscreen
Date: Sun, 14 Jun 2015 09:22:23 -0700
Message-ID: <1434298943-4961-1-git-send-email-linuxsea@163.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from m12-13.163.com ([220.181.12.13]:43208 "EHLO m12-13.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751476AbbFNQWJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 14 Jun 2015 12:22:09 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, nick.dyer@itdev.co.uk, bleung@chromium.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linuxsea@163.com

From: linuxsea <linuxsea@163.com>

Signed-off-by: linuxsea <linuxsea@163.com>
---
 drivers/input/touchscreen/Kconfig          |   12 +++
 drivers/input/touchscreen/usbtouchscreen.c |  116 ++++++++++++++++++++++++++++
 2 files changed, 128 insertions(+)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 80f6386..958297b 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -767,6 +767,8 @@ config TOUCHSCREEN_USB_COMPOSITE
 	  - Elo TouchSystems 2700 IntelliTouch
 	  - EasyTouch USB Touch Controller from Data Modul
 	  - e2i (Mimo monitors)
+	  - CJTouch
+	  - CJMTouch
 
 	  Have a look at <http://linux.chapter7.ch/touchkit/> for
 	  a usage description and the required user-space stuff.
@@ -826,6 +828,16 @@ config TOUCHSCREEN_USB_IRTOUCH
 	bool "IRTOUCHSYSTEMS/UNITOP device support" if EXPERT
 	depends on TOUCHSCREEN_USB_COMPOSITE
 
+config TOUCHSCREEN_USB_CJTOUCH
+	default y
+	bool "CJTOUCH Single Touch Touchscreen device support" if EXPERT
+	depends on TOUCHSCREEN_USB_COMPOSITE
+
+config TOUCHSCREEN_USB_CJMTOUCH
+	default y
+	bool "CJTOUCH Multi Touch Touchscreen  device support" if EXPERT
+	depends on TOUCHSCREEN_USB_COMPOSITE
+
 config TOUCHSCREEN_USB_IDEALTEK
 	default y
 	bool "IdealTEK URTC1000 device support" if EXPERT
diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/touchscreen/usbtouchscreen.c
index f2c6c35..e2908db 100644
--- a/drivers/input/touchscreen/usbtouchscreen.c
+++ b/drivers/input/touchscreen/usbtouchscreen.c
@@ -18,6 +18,8 @@
  *  - NEXIO/iNexio
  *  - Elo TouchSystems 2700 IntelliTouch
  *  - EasyTouch USB Dual/Multi touch controller from Data Modul
+ *  - CJTouch
+ *  - CJMTouch
  *
  * Copyright (C) 2004-2007 by Daniel Ritz <daniel.ritz@gmx.ch>
  * Copyright (C) by Todd E. Johnson (mtouchusb.c)
@@ -143,6 +145,8 @@ enum {
 	DEVTYPE_NEXIO,
 	DEVTYPE_ELO,
 	DEVTYPE_ETOUCH,
+	DEVTYPE_CJTOUCH,
+	DEVTYPE_CJMTOUCH,
 };
 
 #define USB_DEVICE_HID_CLASS(vend, prod) \
@@ -251,6 +255,15 @@ static const struct usb_device_id usbtouch_devices[] = {
 	{USB_DEVICE(0x7374, 0x0001), .driver_info = DEVTYPE_ETOUCH},
 #endif
 
+#ifdef CONFIG_TOUCHSCREEN_USB_CJTOUCH
+	{USB_DEVICE(0x24b8, 0x0001), .driver_info = DEVTYPE_CJTOUCH},
+	{USB_DEVICE(0x24b8, 0x0004), .driver_info = DEVTYPE_CJTOUCH},
+#endif
+
+#ifdef CONFIG_TOUCHSCREEN_USB_CJMTOUCH
+	{USB_DEVICE(0x24b8, 0x000f), .driver_info = DEVTYPE_CJMTOUCH},
+	{USB_DEVICE(0x24b8, 0x0010), .driver_info = DEVTYPE_CJMTOUCH},
+#endif
 	{}
 };
 
@@ -1063,6 +1076,89 @@ static int elo_read_data(struct usbtouch_usb *dev, unsigned char *pkt)
 }
 #endif
 
+/*****************************************************************************
+ * CJTouch part
+ */
+
+#ifdef CONFIG_TOUCHSCREEN_USB_CJTOUCH
+
+static int cjtouch_touch_read_data(struct usbtouch_usb *dev, unsigned char *pkt)
+{
+	dev->x = ((pkt[2] & 0x00FF) << 8) | (pkt[1] & 0x00FF);
+	dev->y = ((pkt[4] & 0x00FF) << 8) | (pkt[3] & 0x00FF);
+	dev->press = pkt[0];
+	dev->touch = pkt[0];
+
+	return 1;
+}
+#endif
+
+/*****************************************************************************
+ * CJMTouch part
+ */
+
+#ifdef CONFIG_TOUCHSCREEN_USB_CJMTOUCH
+
+static int x = 4095;
+static int y = 4095;
+static int old2State = 4095;
+
+static void cjmtouch_touch_process_pkt(struct usbtouch_usb *usbtouch,
+				   unsigned char *pkt, int len)
+{
+	int touch1 = pkt[1] & 0x01;
+	int touch2 = pkt[7] & 0x01;
+
+	if (touch1)
+		input_report_abs(usbtouch->input, ABS_MT_TOUCH_MAJOR, 1);
+	else
+		input_report_abs(usbtouch->input, ABS_MT_TOUCH_MAJOR, 0);
+
+	{
+		x = ((pkt[4] << 8) | pkt[3]);
+		y = ((pkt[6] << 8) | pkt[5]);
+
+		/*x = (x * 800) / 0xfff;
+		  y = (y * 600) / 0xfff;*/
+
+		input_report_abs(usbtouch->input, ABS_MT_WIDTH_MAJOR, 1);
+		input_report_abs(usbtouch->input, ABS_MT_POSITION_X, x);
+		input_report_abs(usbtouch->input, ABS_MT_POSITION_Y, y);
+
+		input_mt_sync(usbtouch->input);
+	}
+
+	if (touch2) {
+		old2State = 1;
+		input_report_abs(usbtouch->input, ABS_MT_TOUCH_MAJOR, 1);
+		/*x = (x * 800) / 0xfff;
+		  y = (y * 600) / 0xfff;*/
+
+		input_report_abs(usbtouch->input, ABS_MT_WIDTH_MAJOR, 1);
+		input_report_abs(usbtouch->input, ABS_MT_POSITION_X, x);
+		input_report_abs(usbtouch->input, ABS_MT_POSITION_Y, y);
+
+		input_mt_sync(usbtouch->input);
+	} else {
+		if (old2State == 1) {
+			old2State = 0;
+			input_report_abs(usbtouch->input,
+					ABS_MT_TOUCH_MAJOR, 0);
+
+		/*	x = (x * 800) / 0xfff;
+			y = (y * 600) / 0xfff;*/
+
+			input_report_abs(usbtouch->input,
+				ABS_MT_WIDTH_MAJOR, 1);
+			input_report_abs(usbtouch->input, ABS_MT_POSITION_X, x);
+			input_report_abs(usbtouch->input, ABS_MT_POSITION_Y, y);
+
+			input_mt_sync(usbtouch->input);
+		}
+	}
+	input_sync(usbtouch->input);
+}
+#endif
 
 /*****************************************************************************
  * the different device descriptors
@@ -1293,6 +1389,26 @@ static struct usbtouch_device_info usbtouch_dev_info[] = {
 		.read_data	= etouch_read_data,
 	},
 #endif
+#ifdef CONFIG_TOUCHSCREEN_USB_CJTOUCH
+	[DEVTYPE_CJTOUCH] = {
+		.min_xc	= 0x0,
+		.max_xc = 0x0fff,
+		.min_yc = 0x0,
+		.max_yc = 0x0fff,
+		.rept_size = 7,
+		.read_data = cjtouch_touch_read_data,
+	},
+#endif
+#ifdef CONFIG_TOUCHSCREEN_USB_CJMTOUCH
+	[DEVTYPE_CJMTOUCH] = {
+		.min_xc	= 0x0,
+		.max_xc = 0x0fff,
+		.min_yc = 0x0,
+		.max_yc = 0x0fff,
+		.rept_size = 14,
+		.process_pkt = cjmtouch_touch_process_pkt,
+	},
+#endif
 };
 
 
-- 
1.7.9.5


