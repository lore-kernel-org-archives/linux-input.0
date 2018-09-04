From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 1/4] HID: multitouch: fix Elan panels with 2 input modes declaration
Date: Tue,  4 Sep 2018 15:31:12 +0200
Message-ID: <20180904133115.5111-2-benjamin.tissoires@redhat.com>
References: <20180904133115.5111-1-benjamin.tissoires@redhat.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180904133115.5111-1-benjamin.tissoires@redhat.com>
Sender: stable-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

When implementing commit 7f81c8db5489 ("HID: multitouch: simplify
the settings of the various features"), I wrongly removed a test
that made sure we never try to set the second InputMode feature
to something else than 0.

This broke badly some recent Elan panels that now forget to send the
click button in some area of the touchpad.

Fixes 7f81c8db5489

Link: https://bugzilla.kernel.org/show_bug.cgi?id=200899

Cc: stable@vger.kernel.org # v4.18+
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-multitouch.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 40fbb7c52723..88da991ef256 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1375,7 +1375,8 @@ static bool mt_need_to_apply_feature(struct hid_device *hdev,
 				     struct hid_usage *usage,
 				     enum latency_mode latency,
 				     bool surface_switch,
-				     bool button_switch)
+				     bool button_switch,
+				     bool *inputmode_found)
 {
 	struct mt_device *td = hid_get_drvdata(hdev);
 	struct mt_class *cls = &td->mtclass;
@@ -1387,6 +1388,14 @@ static bool mt_need_to_apply_feature(struct hid_device *hdev,
 
 	switch (usage->hid) {
 	case HID_DG_INPUTMODE:
+		/*
+		 * Some elan panels wrongly declare 2 input mode features,
+		 * and silently ignore when we set the value in the second
+		 * field. Skip the second feature and hope for the best.
+		 */
+		if (*inputmode_found)
+			return false;
+
 		if (cls->quirks & MT_QUIRK_FORCE_GET_FEATURE) {
 			report_len = hid_report_len(report);
 			buf = hid_alloc_report_buf(report, GFP_KERNEL);
@@ -1402,6 +1411,7 @@ static bool mt_need_to_apply_feature(struct hid_device *hdev,
 		}
 
 		field->value[index] = td->inputmode_value;
+		*inputmode_found = true;
 		return true;
 
 	case HID_DG_CONTACTMAX:
@@ -1439,6 +1449,7 @@ static void mt_set_modes(struct hid_device *hdev, enum latency_mode latency,
 	struct hid_usage *usage;
 	int i, j;
 	bool update_report;
+	bool inputmode_found = false;
 
 	rep_enum = &hdev->report_enum[HID_FEATURE_REPORT];
 	list_for_each_entry(rep, &rep_enum->report_list, list) {
@@ -1457,7 +1468,8 @@ static void mt_set_modes(struct hid_device *hdev, enum latency_mode latency,
 							     usage,
 							     latency,
 							     surface_switch,
-							     button_switch))
+							     button_switch,
+							     &inputmode_found))
 					update_report = true;
 			}
 		}
-- 
2.14.3
