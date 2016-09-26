From: Ioan-Adrian Ratiu <adi@adirat.com>
Subject: [PATCH 2/2] hid: input: add HID_QUIRK_REUSE_AXES and fix dragonrise
Date: Mon, 26 Sep 2016 05:58:39 +0300
Message-ID: <20160926025839.2790-2-adi@adirat.com>
References: <20160926025839.2790-1-adi@adirat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33828 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941262AbcIZC6s (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 25 Sep 2016 22:58:48 -0400
Received: by mail-wm0-f65.google.com with SMTP id l132so11931347wmf.1
        for <linux-input@vger.kernel.org>; Sun, 25 Sep 2016 19:58:47 -0700 (PDT)
In-Reply-To: <20160926025839.2790-1-adi@adirat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Commit 79346d620e9d ("HID: input: force generic axis to be mapped to their
user space axis") made mapping generic axes to their userspace equivalents
mandatory and some lower end gamepads which were depending on the previous
behaviour suffered severe regressions because they were reusing axes and
expecting hid-input to multiplex their map to the respective userspace axis
by always searching for and using the next available axis.

Now the result is that different device axes appear on a single axis in
userspace, which is clearly a regression in the hid-input driver because it
needs to continue to handle this hardware as expected before the forcing
to provide the same interface to userspace.

Since these lower-end gamepads like 0079:0006 are definitely the exception,
create a quirk to fix them.

Signed-off-by: Ioan-Adrian Ratiu <adi@adirat.com>
---
 drivers/hid/hid-dr.c    |  2 ++
 drivers/hid/hid-input.c | 16 +++++++++++-----
 include/linux/hid.h     |  1 +
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-dr.c b/drivers/hid/hid-dr.c
index 2523f8a..27fc826 100644
--- a/drivers/hid/hid-dr.c
+++ b/drivers/hid/hid-dr.c
@@ -274,6 +274,8 @@ static int dr_probe(struct hid_device *hdev, const struct hid_device_id *id)
 			hid_hw_stop(hdev);
 			goto err;
 		}
+		/* has only 5 axes and reuses X, Y */
+		hdev->quirks |= HID_QUIRK_REUSE_AXES;
 		break;
 	}
 
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index fb9ace1..1cc6fe4 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -633,11 +633,17 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		/* These usage IDs map directly to the usage codes. */
 		case HID_GD_X: case HID_GD_Y: case HID_GD_Z:
 		case HID_GD_RX: case HID_GD_RY: case HID_GD_RZ:
-			if (field->flags & HID_MAIN_ITEM_RELATIVE)
-				map_rel(usage->hid & 0xf);
-			else
-				map_abs_clear(usage->hid & 0xf);
-			break;
+
+			/* if quirk is active don't force the userspace mapping,
+			 * instead search and use the next available axis.
+			 */
+			if (!(device->quirks & HID_QUIRK_REUSE_AXES)) {
+				if (field->flags & HID_MAIN_ITEM_RELATIVE)
+					map_rel(usage->hid & 0xf);
+				else
+					map_abs_clear(usage->hid & 0xf);
+				break;
+			}
 
 		case HID_GD_SLIDER: case HID_GD_DIAL: case HID_GD_WHEEL:
 			if (field->flags & HID_MAIN_ITEM_RELATIVE)
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 75b66ec..0979920 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -320,6 +320,7 @@ struct hid_item {
 #define HID_QUIRK_NO_EMPTY_INPUT		0x00000100
 #define HID_QUIRK_NO_INIT_INPUT_REPORTS		0x00000200
 #define HID_QUIRK_ALWAYS_POLL			0x00000400
+#define HID_QUIRK_REUSE_AXES			0x00000800
 #define HID_QUIRK_SKIP_OUTPUT_REPORTS		0x00010000
 #define HID_QUIRK_SKIP_OUTPUT_REPORT_ID		0x00020000
 #define HID_QUIRK_NO_OUTPUT_REPORTS_ON_INTR_EP	0x00040000
-- 
2.10.0

