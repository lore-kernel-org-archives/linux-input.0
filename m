From: Simon Wood <gitsend@mungewell.org>
Subject: [Patch-V2 3/6] HID:hid-logitech: Compute combined pedals value
Date: Sun, 18 Sep 2016 10:55:39 -0600
Message-ID: <1474217742-3992-3-git-send-email-simon@mungewell.org>
References: <1473461449-8060-1-git-send-email-simon@mungewell.org>
 <1474217742-3992-1-git-send-email-simon@mungewell.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1474217742-3992-1-git-send-email-simon@mungewell.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Edwin Velds <edwin@velds.nl>, Elias Vanderstuyft <elias.vds@gmail.com>, Michal Maly <madcatxster@gmail.com>, Simon Wood <simon@mungewell.org>
List-Id: linux-input@vger.kernel.org

Add support for computing a combined accelerator/brake axis for wheels
which don't contain combined data in their HID stream.

This includes DFGT, G25, G27, G29 and Wii-Wheel.

Signed-off-by: Simon Wood <simon@mungewell.org>
---
 drivers/hid/hid-lg4ff.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index 79d34c2..cc5c9ebd 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -332,6 +332,7 @@ int lg4ff_adjust_input_event(struct hid_device *hid, struct hid_field *field,
 int lg4ff_raw_event(struct hid_device *hdev, struct hid_report *report,
 		u8 *rd, int size, struct lg_drv_data *drv_data)
 {
+	int offset;
 	struct lg4ff_device_entry *entry = drv_data->device_props;
 
 	if (!entry)
@@ -353,9 +354,25 @@ int lg4ff_raw_event(struct hid_device *hdev, struct hid_report *report,
 			rd[5] = rd[4];
 			rd[6] = 0x7F;
 			return 1;
+		case USB_DEVICE_ID_LOGITECH_G25_WHEEL:
+		case USB_DEVICE_ID_LOGITECH_G27_WHEEL:
+			offset = 5;
+			break;
+		case USB_DEVICE_ID_LOGITECH_DFGT_WHEEL:
+		case USB_DEVICE_ID_LOGITECH_G29_WHEEL:
+			offset = 6;
+			break;
+		case USB_DEVICE_ID_LOGITECH_WII_WHEEL:
+			offset = 3;
+			break;
 		default:
 			return 0;
 		}
+
+		/* Compute a combined axis when wheel does not supply it */
+		rd[offset] = (0xFF + rd[offset] - rd[offset+1]) >> 1;
+		rd[offset+1] = 0x7F;
+		return 1;
 	}
 
 	return 0;
-- 
2.7.4
