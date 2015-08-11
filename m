From: Jamie Lentin <jm@lentin.co.uk>
Subject: [PATCH 3/3] HID: lenovo: Hide middle-button press until release
Date: Tue, 11 Aug 2015 22:40:52 +0100
Message-ID: <1439329252-16809-4-git-send-email-jm@lentin.co.uk>
References: <1439329252-16809-1-git-send-email-jm@lentin.co.uk>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from marmot.wormnet.eu ([188.246.204.87]:60526 "EHLO
	marmot.wormnet.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753692AbbHKWTv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Aug 2015 18:19:51 -0400
In-Reply-To: <1439329252-16809-1-git-send-email-jm@lentin.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jamie Lentin <jm@lentin.co.uk>

Don't relay a middle button press to userspace until release, and then
only if there was no scroll events inbetween. This is closer to what
Xorg's wheel emulation does, and avoids spurious middle-click pastes.

Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
---
 drivers/hid/hid-lenovo.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index 265bfe2..629d988 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -37,6 +37,7 @@ struct lenovo_drvdata_tpkbd {
 };
 
 struct lenovo_drvdata_cptkbd {
+	u8 middlebutton_state; /* 0:Up, 1:Down (undecided), 2:Scrolling */
 	bool fn_lock;
 	int sensitivity;
 };
@@ -287,6 +288,53 @@ static int lenovo_raw_event(struct hid_device *hdev,
 	return 0;
 }
 
+static int lenovo_event_cptkbd(struct hid_device *hdev,
+		struct hid_field *field, struct hid_usage *usage, __s32 value)
+{
+	struct lenovo_drvdata_cptkbd *cptkbd_data = hid_get_drvdata(hdev);
+
+	/* "wheel" scroll events */
+	if (usage->type == EV_REL && (usage->code == REL_WHEEL ||
+			usage->code == REL_HWHEEL)) {
+		/* Scroll events disable middle-click event */
+		cptkbd_data->middlebutton_state = 2;
+		return 0;
+	}
+
+	/* Middle click events */
+	if (usage->type == EV_KEY && usage->code == BTN_MIDDLE) {
+		if (value == 1) {
+			cptkbd_data->middlebutton_state = 1;
+		} else if (value == 0) {
+			if (cptkbd_data->middlebutton_state == 1) {
+				/* No scrolling inbetween, send middle-click */
+				input_event(field->hidinput->input,
+					EV_KEY, BTN_MIDDLE, 1);
+				input_sync(field->hidinput->input);
+				input_event(field->hidinput->input,
+					EV_KEY, BTN_MIDDLE, 0);
+				input_sync(field->hidinput->input);
+			}
+			cptkbd_data->middlebutton_state = 0;
+		}
+		return 1;
+	}
+
+	return 0;
+}
+
+static int lenovo_event(struct hid_device *hdev, struct hid_field *field,
+		struct hid_usage *usage, __s32 value)
+{
+	switch (hdev->product) {
+	case USB_DEVICE_ID_LENOVO_CUSBKBD:
+	case USB_DEVICE_ID_LENOVO_CBTKBD:
+		return lenovo_event_cptkbd(hdev, field, usage, value);
+	default:
+		return 0;
+	}
+}
+
 static int lenovo_features_set_tpkbd(struct hid_device *hdev)
 {
 	struct hid_report *report;
@@ -674,6 +722,7 @@ static int lenovo_probe_cptkbd(struct hid_device *hdev)
 		hid_warn(hdev, "Failed to switch middle button: %d\n", ret);
 
 	/* Set keyboard settings to known state */
+	cptkbd_data->middlebutton_state = 0;
 	cptkbd_data->fn_lock = true;
 	cptkbd_data->sensitivity = 0x05;
 	lenovo_features_set_cptkbd(hdev);
@@ -781,6 +830,7 @@ static struct hid_driver lenovo_driver = {
 	.probe = lenovo_probe,
 	.remove = lenovo_remove,
 	.raw_event = lenovo_raw_event,
+	.event = lenovo_event,
 };
 module_hid_driver(lenovo_driver);
 
-- 
2.1.4

