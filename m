From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 11/13] HID: multitouch: report MT_TOOL_PALM for non-confident touches
Date: Thu,  7 Jun 2018 09:54:46 +0200
Message-ID: <20180607075448.5706-12-benjamin.tissoires@redhat.com>
References: <20180607075448.5706-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180607075448.5706-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mario.Limonciello@dell.com, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

According to Microsoft specification [1] for Precision Touchpads (and
Touchscreens) the devices use "confidence" reports to signal accidental
touches, or contacts that are "too large to be a finger". Instead of
simply marking contact inactive in this case (which causes issues if
contact was originally proper and we lost confidence in it later, as
this results in accidental clicks, drags, etc), let's report such
contacts as MT_TOOL_PALM and let userspace decide what to do.
Additionally, let's report contact size for such touches as maximum
allowed for major/minor, which should help userspace that is not yet
aware of MT_TOOL_PALM to still perform palm rejection.

[1] https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/touchpad-windows-precision-touchpad-collection

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
[splitted and rebased]
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

changes in v2:
- dropped the delayed release in case of palm detection. This is
  a FW bug for PTP devices, and should only happen with touchscreens
- move input_set_abs_params(hi->input, ABS_MT_TOOL_TYPE,...) into
  its own test so other devices can add MT_QUIRK_CONFIDENCE to their
  quirks.
---
 drivers/hid/hid-multitouch.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index a4a274ebfbef..36c8b67bb032 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -736,6 +736,13 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 				cls->name == MT_CLS_WIN_8_DUAL) &&
 				field->application == HID_DG_TOUCHPAD)
 				app->quirks |= MT_QUIRK_CONFIDENCE;
+
+			if (app->quirks & MT_QUIRK_CONFIDENCE)
+				input_set_abs_params(hi->input,
+						     ABS_MT_TOOL_TYPE,
+						     MT_TOOL_FINGER,
+						     MT_TOOL_PALM, 0, 0);
+
 			MT_STORE_FIELD(confidence_state);
 			return 1;
 		case HID_DG_TIPSWITCH:
@@ -958,10 +965,12 @@ static int mt_process_slot(struct mt_device *td, struct input_dev *input,
 	if (quirks & MT_QUIRK_HOVERING)
 		inrange_state = *slot->inrange_state;
 
-	active = (*slot->tip_state || inrange_state) && confidence_state;
+	active = *slot->tip_state || inrange_state;
 
 	if (app->application == HID_GD_SYSTEM_MULTIAXIS)
 		tool = MT_TOOL_DIAL;
+	else if (unlikely(!confidence_state))
+		tool = MT_TOOL_PALM;
 
 	input_mt_slot(input, slotnum);
 	input_mt_report_slot_state(input, tool, active);
@@ -993,11 +1002,20 @@ static int mt_process_slot(struct mt_device *td, struct input_dev *input,
 			orientation = -azimuth;
 		}
 
-		/*
-		 * divided by two to match visual scale of touch
-		 * for devices with this quirk
-		 */
-		if (quirks & MT_QUIRK_TOUCH_SIZE_SCALING) {
+		if (unlikely(!confidence_state)) {
+			/*
+			 * When reporting palm, set contact to maximum
+			 * size to help userspace that does not
+			 * recognize MT_TOOL_PALM to reject contacts
+			 * that are too large.
+			 */
+			major = input_abs_get_max(input, ABS_MT_TOUCH_MAJOR);
+			minor = input_abs_get_max(input, ABS_MT_TOUCH_MINOR);
+		} else if (quirks & MT_QUIRK_TOUCH_SIZE_SCALING) {
+			/*
+			 * divided by two to match visual scale of touch
+			 * for devices with this quirk
+			 */
 			major = major >> 1;
 			minor = minor >> 1;
 		}
-- 
2.14.3
