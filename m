From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 2/2] HID: multitouch: touchscreens also use confidence reports
Date: Thu, 10 Aug 2017 17:45:00 -0700
Message-ID: <20170811004500.13740-2-dmitry.torokhov@gmail.com>
References: <20170811004500.13740-1-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170811004500.13740-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Henrik Rydberg <rydberg@bitmath.org>, Jason Gerecke <killertofu@gmail.com>, Dennis Kempin <denniskempin@google.com>, Andrew de los Reyes <adlr@google.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

According to [1] the confidence is used not only by touchpad devices,
but also by touchscreens.

[1] https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/touchscreen-required-hid-top-level-collections

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-multitouch.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index c28defe50a10..1cb00de4bfd1 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -545,7 +545,8 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 		case HID_DG_CONFIDENCE:
 			if ((cls->name == MT_CLS_WIN_8 ||
 				cls->name == MT_CLS_WIN_8_DUAL) &&
-			    field->application == HID_DG_TOUCHPAD) {
+			    (field->application == HID_DG_TOUCHPAD ||
+				field->application == HID_DG_TOUCHSCREEN)) {
 				cls->quirks |= MT_QUIRK_CONFIDENCE;
 				input_set_abs_params(hi->input,
 					ABS_MT_TOOL_TYPE,
-- 
2.14.0.434.g98096fd7a8-goog
