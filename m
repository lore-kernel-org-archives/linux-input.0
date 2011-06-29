From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH] HID: Fix small indent-issues in several drivers
Date: Wed, 29 Jun 2011 15:41:34 +0200
Message-ID: <1309354894-29127-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f52.google.com ([209.85.161.52]:43664 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752461Ab1F2NmE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jun 2011 09:42:04 -0400
Received: by fxd18 with SMTP id 18so1246287fxd.11
        for <linux-input@vger.kernel.org>; Wed, 29 Jun 2011 06:42:02 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: David Herrmann <dh.herrmann@googlemail.com>

---
 drivers/hid/hid-apple.c       |    2 +-
 drivers/hid/hid-core.c        |    2 +-
 drivers/hid/hid-elecom.c      |    2 +-
 drivers/hid/hid-lcpower.c     |   20 ++++++++++----------
 drivers/hid/hidraw.c          |    4 ++--
 drivers/hid/usbhid/hid-core.c |    2 +-
 6 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index b85744f..fdef449 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -234,7 +234,7 @@ static int hidinput_apple_event(struct hid_device *hid, struct input_dev *input,
 		}
 	}
 
-        if (iso_layout) {
+	if (iso_layout) {
 		if (asc->quirks & APPLE_ISO_KEYBOARD) {
 			trans = apple_find_translation(apple_iso_keyboard, usage->code);
 			if (trans) {
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 6f3289a..4c7ee91 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1932,7 +1932,7 @@ int hid_add_device(struct hid_device *hdev)
 	/* we need to kill them here, otherwise they will stay allocated to
 	 * wait for coming driver */
 	if (!(hdev->quirks & HID_QUIRK_NO_IGNORE)
-            && (hid_ignore(hdev) || (hdev->quirks & HID_QUIRK_IGNORE)))
+		&& (hid_ignore(hdev) || (hdev->quirks & HID_QUIRK_IGNORE)))
 		return -ENODEV;
 
 	/* XXX hack, any other cleaner solution after the driver core
diff --git a/drivers/hid/hid-elecom.c b/drivers/hid/hid-elecom.c
index 79d0c61..13dba8d 100644
--- a/drivers/hid/hid-elecom.c
+++ b/drivers/hid/hid-elecom.c
@@ -27,7 +27,7 @@ static __u8 *elecom_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		hid_info(hdev, "Fixing up Elecom BM084 report descriptor\n");
 		rdesc[47] = 0x00;
 	}
-    return rdesc;
+	return rdesc;
 }
 
 static const struct hid_device_id elecom_devices[] = {
diff --git a/drivers/hid/hid-lcpower.c b/drivers/hid/hid-lcpower.c
index c4fe9bd0..61ed0e6 100644
--- a/drivers/hid/hid-lcpower.c
+++ b/drivers/hid/hid-lcpower.c
@@ -28,16 +28,16 @@ static int ts_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 		return 0;
 
 	switch (usage->hid & HID_USAGE) {
-        case 0x046: ts_map_key_clear(KEY_YELLOW);         break;
-        case 0x047: ts_map_key_clear(KEY_GREEN);          break;
-        case 0x049: ts_map_key_clear(KEY_BLUE);           break;
-        case 0x04a: ts_map_key_clear(KEY_RED);		  break;
-        case 0x00d: ts_map_key_clear(KEY_HOME);           break;
-        case 0x025: ts_map_key_clear(KEY_TV);             break;
-        case 0x048: ts_map_key_clear(KEY_VCR);            break;
-        case 0x024: ts_map_key_clear(KEY_MENU);           break;
-        default:
-        return 0;
+	case 0x046: ts_map_key_clear(KEY_YELLOW);         break;
+	case 0x047: ts_map_key_clear(KEY_GREEN);          break;
+	case 0x049: ts_map_key_clear(KEY_BLUE);           break;
+	case 0x04a: ts_map_key_clear(KEY_RED);            break;
+	case 0x00d: ts_map_key_clear(KEY_HOME);           break;
+	case 0x025: ts_map_key_clear(KEY_TV);             break;
+	case 0x048: ts_map_key_clear(KEY_VCR);            break;
+	case 0x024: ts_map_key_clear(KEY_MENU);           break;
+	default:
+		return 0;
 	}
 
 	return 1;
diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index c79578b..98a615c 100644
--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -550,8 +550,8 @@ int __init hidraw_init(void)
 		goto out;
 	}
 
-        cdev_init(&hidraw_cdev, &hidraw_ops);
-        cdev_add(&hidraw_cdev, dev_id, HIDRAW_MAX_DEVICES);
+	cdev_init(&hidraw_cdev, &hidraw_ops);
+	cdev_add(&hidraw_cdev, dev_id, HIDRAW_MAX_DEVICES);
 out:
 	return result;
 }
diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 38c261a..f9a52e1 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -730,7 +730,7 @@ void usbhid_init_reports(struct hid_device *hid)
  * Reset LEDs which BIOS might have left on. For now, just NumLock (0x01).
  */
 static int hid_find_field_early(struct hid_device *hid, unsigned int page,
-    unsigned int hid_code, struct hid_field **pfield)
+			unsigned int hid_code, struct hid_field **pfield)
 {
 	struct hid_report *report;
 	struct hid_field *field;
-- 
1.7.6

