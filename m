From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 11/12] HID: multitouch: touchscreens also use confidence reports
Date: Thu, 21 Jun 2018 14:09:07 +0200
Message-ID: <20180621120908.16706-12-benjamin.tissoires@redhat.com>
References: <20180621120908.16706-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180621120908.16706-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mario.Limonciello@dell.com, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

According to [1] the confidence is used not only by touchpad devices,
but also by touchscreens.

[1] https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/touchscreen-required-hid-top-level-collections

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
[rebased]
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

no changes in v2 (compared to Dmitry's initial submission)
no changes in v3
---
 drivers/hid/hid-multitouch.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 36c8b67bb032..9c708aa261ee 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -734,7 +734,8 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 		case HID_DG_CONFIDENCE:
 			if ((cls->name == MT_CLS_WIN_8 ||
 				cls->name == MT_CLS_WIN_8_DUAL) &&
-				field->application == HID_DG_TOUCHPAD)
+				(field->application == HID_DG_TOUCHPAD ||
+				 field->application == HID_DG_TOUCHSCREEN))
 				app->quirks |= MT_QUIRK_CONFIDENCE;
 
 			if (app->quirks & MT_QUIRK_CONFIDENCE)
-- 
2.14.3
