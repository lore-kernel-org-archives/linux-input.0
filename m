From: Allen Hung <allen_hung@dell.com>
Subject: [PATCH 1/1] HID: multitouch: enable palm rejection if device implements confidence usage
Date: Fri, 20 Nov 2015 18:21:06 +0800
Message-ID: <1448014866-25348-1-git-send-email-allen_hung@dell.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Allen Hung <allen_hung@dell.com>
List-Id: linux-input@vger.kernel.org

The usage Confidence is mandary to Windows Precision Touchpad devices. The
appearance of this usage is checked in hidinput_connect but the quirk
MT_QUIRK_VALID_IS_CONFIDENCE is not applied to device accordingly.
Apply this quirk and also remove quirk MT_QUIRK_ALWAYS_VALID to enable palm
rejection for the WIN 8 touchpad devices which have implemented usage
Confidence in its input reports.

Tested on Dell XPS 13 laptop.

Signed-off-by: Allen Hung <allen_hung@dell.com>
---
 drivers/hid/hid-multitouch.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 426b2f1..13aeff9 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -448,6 +448,11 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 			mt_store_field(usage, td, hi);
 			return 1;
 		case HID_DG_CONFIDENCE:
+			if (cls->name == MT_CLS_WIN_8 &&
+				field->application == HID_DG_TOUCHPAD) {
+				cls->quirks &= ~MT_QUIRK_ALWAYS_VALID;
+				cls->quirks |= MT_QUIRK_VALID_IS_CONFIDENCE;
+			}
 			mt_store_field(usage, td, hi);
 			return 1;
 		case HID_DG_TIPSWITCH:
-- 
1.9.1
