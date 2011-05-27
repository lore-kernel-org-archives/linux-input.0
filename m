From: Austin Zhang <zhang.austin@gmail.com>
Subject: [PATCH]HID: hid-multitouch: add support for Chunghwa multi-touch panel
Date: Sat, 28 May 2011 02:03:47 +0800
Message-ID: <1306519427-5425-1-git-send-email-zhang.austin@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64745 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777Ab1E0R7l (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 May 2011 13:59:41 -0400
Received: by pwi15 with SMTP id 15so903861pwi.19
        for <linux-input@vger.kernel.org>; Fri, 27 May 2011 10:59:40 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, jkosina@suse.cz, dmitry.torokhov@gmail.com, benjamin.tissoires@enac.fr, chatty@enac.fr, rydberg@euromail.se
Cc: Austin Zhang <zhang.austin@gmail.com>

Added Chunghwa hid multitouch panel support into hid-multitouch.

Signed-off-by: Austin Zhang <zhang.austin@gmail.com>
---
 Kconfig          |    1 +
 hid-core.c       |    1 +
 hid-ids.h        |    3 +++
 hid-multitouch.c |    5 +++++
 4 files changed, 10 insertions(+)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 67d2a75..36ca465 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -305,6 +305,7 @@ config HID_MULTITOUCH
 	  - 3M PCT touch screens
 	  - ActionStar dual touch panels
 	  - Cando dual touch panels
+	  - Chunghwa panels
 	  - CVTouch panels
 	  - Cypress TrueTouch panels
 	  - Elo TouchSystems IntelliTouch Plus panels
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index c957c4b..f7440e8 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1359,6 +1359,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CHERRY, USB_DEVICE_ID_CHERRY_CYMOTION_SOLAR) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_TACTICAL_PAD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_WIRELESS) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CHUNGHWAT, USB_DEVICE_ID_CHUNGHWAT_MULTITOUCH) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CREATIVELABS, USB_DEVICE_ID_PRODIKEYS_PCMIDI) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CVTOUCH, USB_DEVICE_ID_CVTOUCH_SCREEN) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_BARCODE_1) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 0b374a6..82be975 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -173,6 +173,9 @@
 #define USB_DEVICE_ID_CHICONY_MULTI_TOUCH	0xb19d
 #define USB_DEVICE_ID_CHICONY_WIRELESS	0x0618
 
+#define USB_VENDOR_ID_CHUNGHWAT		0x2247
+#define USB_DEVICE_ID_CHUNGHWAT_MULTITOUCH	0x0001
+
 #define USB_VENDOR_ID_CIDC		0x1677
 
 #define USB_VENDOR_ID_CMEDIA		0x0d8c
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index ecd4d2d..8bc32a0 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -593,6 +593,11 @@ static const struct hid_device_id mt_devices[] = {
 		HID_USB_DEVICE(USB_VENDOR_ID_CANDO,
 			USB_DEVICE_ID_CANDO_MULTI_TOUCH_15_6) },
 
+	/* Chunghwa Telecom touch panels */
+	{  .driver_data = MT_CLS_DEFAULT,
+		HID_USB_DEVICE(USB_VENDOR_ID_CHUNGHWAT,
+			USB_DEVICE_ID_CHUNGHWAT_MULTITOUCH) },
+
 	/* CVTouch panels */
 	{ .driver_data = MT_CLS_DEFAULT,
 		HID_USB_DEVICE(USB_VENDOR_ID_CVTOUCH,
