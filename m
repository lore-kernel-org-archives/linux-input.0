From: linuxsea@163.com
Subject: [PATCH] HID:multitouch:add driver fo CJTouch MultiTouch
Date: Mon, 29 Jun 2015 10:04:50 -0700
Message-ID: <1435597490-3727-1-git-send-email-linuxsea@163.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from m12-14.163.com ([220.181.12.14]:48065 "EHLO m12-14.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751159AbbF2RFb (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Jun 2015 13:05:31 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linuxsea@163.com

From: linuxsea <linuxsea@163.com>

Signed-off-by:linuxsea<linuxsea@163.com>
---
---
 drivers/hid/Kconfig          |    1 +
 drivers/hid/hid-ids.h        |    4 ++++
 drivers/hid/hid-multitouch.c |    8 ++++++++
 3 files changed, 13 insertions(+)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index cc4c664..57c94d7 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -480,6 +480,7 @@ config HID_MULTITOUCH
 	  - Atmel panels
 	  - Cando dual touch panels
 	  - Chunghwa panels
+	  - CJTouch panels
 	  - CVTouch panels
 	  - Cypress TrueTouch panels
 	  - Elan Microelectronics touch panels
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index b04b082..591b7d0 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -236,6 +236,10 @@
 
 #define USB_VENDOR_ID_CIDC		0x1677
 
+#define USB_VENDOR_ID_CJTOUCH		0x24b8
+#define USB_DEVICE_ID_CJTOUCH_MULTI_TOUCH_0020	0x0020
+#define USB_DEVICE_ID_CJTOUCH_MULTI_TOUCH_0040	0x0040
+
 #define USB_VENDOR_ID_CMEDIA		0x0d8c
 #define USB_DEVICE_ID_CM109		0x000e
 
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 6a9b05b..5055008 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1138,6 +1138,14 @@ static const struct hid_device_id mt_devices[] = {
 		MT_USB_DEVICE(USB_VENDOR_ID_CHUNGHWAT,
 			USB_DEVICE_ID_CHUNGHWAT_MULTITOUCH) },
 
+	/* CJTouch panels */
+	{ .driver_data = MT_CLS_DEFAULT,
+		HID_USB_DEVICE(USB_VENDOR_ID_CJTOUCH,
+			USB_DEVICE_ID_CJTOUCH_MULTI_TOUCH_0020) },
+	{ .driver_data = MT_CLS_DEFAULT,
+		HID_USB_DEVICE(USB_VENDOR_ID_CJTOUCH,
+			USB_DEVICE_ID_CJTOUCH_MULTI_TOUCH_0040) },
+
 	/* CVTouch panels */
 	{ .driver_data = MT_CLS_NSMU,
 		MT_USB_DEVICE(USB_VENDOR_ID_CVTOUCH,
-- 
1.7.9.5


