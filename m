From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: [PATCH] hid: add appletv IR receiver quirk
Date: Mon,  6 Oct 2008 10:06:28 +0200
Message-ID: <1223280388-1297-1-git-send-email-jacmet@sunsite.dk>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:10801 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249AbYJFIGd (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Oct 2008 04:06:33 -0400
Received: by nf-out-0910.google.com with SMTP id d3so970086nfc.21
        for <linux-input@vger.kernel.org>; Mon, 06 Oct 2008 01:06:31 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, linux-input@vger.kernel.org
Cc: Peter Korsgaard <jacmet@sunsite.dk>

Similar to the existing IRCONTROL4 handling

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
---
 drivers/hid/hid-apple.c |    2 ++
 drivers/hid/hid-ids.h   |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index a808e57..fd7f896 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -359,6 +359,8 @@ static void apple_remove(struct hid_device *hdev)
 }
 
 static const struct hid_device_id apple_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ATV_IRCONTROL),
+		.driver_data = APPLE_HIDDEV | APPLE_IGNORE_HIDINPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_IRCONTROL4),
 		.driver_data = APPLE_HIDDEV | APPLE_IGNORE_HIDINPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MIGHTYMOUSE),
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index fa4e4fd..9fc2636 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -84,6 +84,7 @@
 #define USB_DEVICE_ID_APPLE_WELLSPRING2_JIS	0x0232
 #define USB_DEVICE_ID_APPLE_FOUNTAIN_TP_ONLY	0x030a
 #define USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY	0x030b
+#define USB_DEVICE_ID_APPLE_ATV_IRCONTROL	0x8241
 #define USB_DEVICE_ID_APPLE_IRCONTROL4	0x8242
 
 #define USB_VENDOR_ID_ASUS		0x0b05
-- 
1.5.6.5

