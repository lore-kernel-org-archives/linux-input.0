From: cyruslien@gmail.com
Subject: [PATCH] HID: add ASUS AIO keyboard model AK1D
Date: Mon, 23 Jul 2012 17:11:51 +0800
Message-ID: <1343034711-11396-1-git-send-email-cyruslien@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:54960 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041Ab2GWJL7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Jul 2012 05:11:59 -0400
Received: by yhmm54 with SMTP id m54so5207281yhm.19
        for <linux-input@vger.kernel.org>; Mon, 23 Jul 2012 02:11:58 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org
Cc: Cyrus Lien <cyrus.lien@canonical.com>

From: Cyrus Lien <cyrus.lien@canonical.com>

Add Asus All-In-One PC keyboard model AK1D.

BugLink: https://bugs.launchpad.net/bugs/1027789

Signed-off-by: Cyrus Lien <cyrus.lien@canonical.com>
---
 drivers/hid/hid-chicony.c |    1 +
 drivers/hid/hid-core.c    |    1 +
 drivers/hid/hid-ids.h     |    1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/hid/hid-chicony.c b/drivers/hid/hid-chicony.c
index b99af34..a2abb8e 100644
--- a/drivers/hid/hid-chicony.c
+++ b/drivers/hid/hid-chicony.c
@@ -60,6 +60,7 @@ static int ch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 static const struct hid_device_id ch_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_TACTICAL_PAD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_WIRELESS2) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_AK1D) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, ch_devices);
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 4c87276..b767914 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1521,6 +1521,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_TACTICAL_PAD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_WIRELESS) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_WIRELESS2) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_AK1D) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CREATIVELABS, USB_DEVICE_ID_PRODIKEYS_PCMIDI) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_BARCODE_1) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_BARCODE_2) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 3203923..dcfeb3c 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -208,6 +208,7 @@
 #define USB_DEVICE_ID_CHICONY_MULTI_TOUCH	0xb19d
 #define USB_DEVICE_ID_CHICONY_WIRELESS	0x0618
 #define USB_DEVICE_ID_CHICONY_WIRELESS2	0x1123
+#define USB_DEVICE_ID_CHICONY_AK1D	0x1125
 
 #define USB_VENDOR_ID_CHUNGHWAT		0x2247
 #define USB_DEVICE_ID_CHUNGHWAT_MULTITOUCH	0x0001
-- 
1.7.9.5

