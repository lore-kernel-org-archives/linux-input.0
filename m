From: linuxsea521@gmail.com
Subject: [PATCH] input: touchscreen: add driver for CJTouch touchscreen
Date: Tue,  8 Oct 2013 07:21:55 -0700
Message-ID: <1381242115-9996-1-git-send-email-linuxsea521@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f67.google.com ([209.85.160.67]:32861 "EHLO
	mail-pb0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751682Ab3JHOWS (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Oct 2013 10:22:18 -0400
Received: by mail-pb0-f67.google.com with SMTP id uo5so2530656pbc.2
        for <linux-input@vger.kernel.org>; Tue, 08 Oct 2013 07:22:18 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linuxsea@163.com

From: linuxsea <linuxsea@163.com>

Signed-off-by: linuxsea <linuxsea@163.com>
---
 drivers/input/touchscreen/Kconfig          |    5 ++
 drivers/input/touchscreen/usbtouchscreen.c |   99 ++++++++++++++++++++++++++++
 2 files changed, 104 insertions(+)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index e09ec67..2640195 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -812,6 +812,11 @@ config TOUCHSCREEN_USB_NEXIO
 	bool "NEXIO/iNexio device support" if EXPERT
 	depends on TOUCHSCREEN_USB_COMPOSITE
 
+config TOUCHSCREEN_USB_CJTOUCH
+	default y
+	bool "CJTouch Touchscreen device support" if EXPERT
+	depends on TOUCHSCREEN_USB_COMPOSITE
+
 config TOUCHSCREEN_USB_EASYTOUCH
 	default y
 	bool "EasyTouch USB Touch controller device support" if EMBEDDED
diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/touchscreen/usbtouchscreen.c
index 721fdb3..cd3aa8c 100644
--- a/drivers/input/touchscreen/usbtouchscreen.c
+++ b/drivers/input/touchscreen/usbtouchscreen.c
@@ -18,6 +18,7 @@
  *  - NEXIO/iNexio
  *  - Elo TouchSystems 2700 IntelliTouch
  *  - EasyTouch USB Dual/Multi touch controller from Data Modul
+ *  - CJTouch
  *
  * Copyright (C) 2004-2007 by Daniel Ritz <daniel.ritz@gmx.ch>
  * Copyright (C) by Todd E. Johnson (mtouchusb.c)
@@ -142,6 +143,8 @@ enum {
 	DEVTYPE_NEXIO,
 	DEVTYPE_ELO,
 	DEVTYPE_ETOUCH,
+	DEVTYPE_CJTOUCH,
+	DEVTYPE_CJMTOUCH,
 };
 
 #define USB_DEVICE_HID_CLASS(vend, prod) \
@@ -251,6 +254,11 @@ static const struct usb_device_id usbtouch_devices[] = {
 	{USB_DEVICE(0x7374, 0x0001), .driver_info = DEVTYPE_ETOUCH},
 #endif
 
+#ifdef CONFIG_TOUCHSCREEN_USB_CJTOUCH
+	{USB_DEVICE(0x24b8, 0x0001), .driver_info = DEVTYPE_CJTOUCH},
+	{USB_DEVICE(0x24b8, 0x0004), .driver_info = DEVTYPE_CJTOUCH},
+	{USB_DEVICE(0x24b8, 0x000f), .driver_info = DEVTYPE_CJMTOUCH},
+#endif
 	{}
 };
 
@@ -1065,6 +1073,78 @@ static int elo_read_data(struct usbtouch_usb *dev, unsigned char *pkt)
 
 
 /*****************************************************************************
+ * CJTouch part
+ */
+
+#ifdef CONFIG_TOUCHSCREEN_USB_CJTOUCH
+static int x = 1;
+static int y = 1;
+static int old2State = 1;
+
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
+
+		input_report_abs(usbtouch->input, ABS_MT_WIDTH_MAJOR, 1);
+		input_report_abs(usbtouch->input, ABS_MT_POSITION_X, x);
+		input_report_abs(usbtouch->input, ABS_MT_POSITION_Y, y);
+		
+		input_mt_sync(usbtouch->input);
+	} else {
+		if (old2State == 1) {
+			old2State = 0;
+			input_report_abs(usbtouch->input, ABS_MT_TOUCH_MAJOR, 0);
+
+			x = (x * 800) / 0xfff;
+			y = (y * 600) / 0xfff;
+
+			input_report_abs(usbtouch->input, ABS_MT_WIDTH_MAJOR, 1);
+			input_report_abs(usbtouch->input, ABS_MT_POSITION_X, x);
+			input_report_abs(usbtouch->input, ABS_MT_POSITION_Y, y);
+
+			input_mt_sync(usbtouch->input);
+		}
+	}
+
+	input_sync(usbtouch->input);
+
+}
+#endif
+
+/*****************************************************************************
  * the different device descriptors
  */
 #ifdef MULTI_PACKET
@@ -1284,6 +1364,25 @@ static struct usbtouch_device_info usbtouch_dev_info[] = {
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
+
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

