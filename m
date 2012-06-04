From: Austin Hendrix <ahendrix@willowgarage.com>
Subject: [PATCH] Add Support for Novatek Touchscreen
Date: Mon, 4 Jun 2012 15:27:51 -0700
Message-ID: <CAOY97VZN2a36OBsacQS21P8G70L2tbtbWK5OMWhZYa=D74XO+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:41978 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756253Ab2FDW1w (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Jun 2012 18:27:52 -0400
Received: by weyu7 with SMTP id u7so3175300wey.19
        for <linux-input@vger.kernel.org>; Mon, 04 Jun 2012 15:27:51 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Add support for a Novatek touchscreen panel as a generic HID multitouch
panel.

Signed-off-by: Austin Hendrix <ahendrix@willowgarage.com>
---
 hid-core.c       |    1 +
 hid-ids.h        |    3 +++
 hid-multitouch.c |    5 +++++
 3 files changed, 9 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 8e3a6b2..0d6dde1 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1605,6 +1605,7 @@ static const struct hid_device_id
hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_NTRIG, USB_DEVICE_ID_NTRIG_TOUCH_SCREEN_16) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_NTRIG, USB_DEVICE_ID_NTRIG_TOUCH_SCREEN_17) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_NTRIG, USB_DEVICE_ID_NTRIG_TOUCH_SCREEN_18) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_NOVATEK, USB_DEVICE_ID_NOVATEK_PCT) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ORTEK, USB_DEVICE_ID_ORTEK_PKB1700) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ORTEK, USB_DEVICE_ID_ORTEK_WKB2000) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_PETALYNX,
USB_DEVICE_ID_PETALYNX_MAXTER_REMOTE) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 9373f53..734a2b9 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -564,6 +564,9 @@
 #define USB_VENDOR_ID_NINTENDO		0x057e
 #define USB_DEVICE_ID_NINTENDO_WIIMOTE	0x0306

+#define USB_VENDOR_ID_NOVATEK		0x0603
+#define USB_DEVICE_ID_NOVATEK_PCT	0x0600
+
 #define USB_VENDOR_ID_NTRIG		0x1b96
 #define USB_DEVICE_ID_NTRIG_TOUCH_SCREEN   0x0001
 #define USB_DEVICE_ID_NTRIG_TOUCH_SCREEN_1   0x0003
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 6e3332a..fae08df 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -951,6 +951,11 @@ static const struct hid_device_id mt_devices[] = {
 		MT_USB_DEVICE(USB_VENDOR_ID_PANASONIC,
 			USB_DEVICE_ID_PANABOARD_UBT880) },

+	/* Novatek Panel */
+	{ .driver_data = MT_CLS_DEFAULT,
+		HID_USB_DEVICE(USB_VENDOR_ID_NOVATEK,
+			USB_DEVICE_ID_NOVATEK_PCT) },
+
 	/* PenMount panels */
 	{ .driver_data = MT_CLS_CONFIDENCE,
 		MT_USB_DEVICE(USB_VENDOR_ID_PENMOUNT,
