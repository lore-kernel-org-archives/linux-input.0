From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH] HID: wacom: generic: Send BTN_STYLUS3 when both barrel switches are set
Date: Tue,  7 Nov 2017 08:25:17 -0800
Message-ID: <20171107162517.1591-1-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:49216 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965221AbdKGQZ1 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 7 Nov 2017 11:25:27 -0500
Received: by mail-qk0-f195.google.com with SMTP id q83so15973769qke.6
        for <linux-input@vger.kernel.org>; Tue, 07 Nov 2017 08:25:26 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

The Wacom Pro Pen 3D includes a third barrel switch which is intended to
be particularly useful in applications where one frequency uses pan, zoom,
and rotate to navigate around a scene or model. The pen is compatible with
the MobileStudio Pro, 2nd-gen Intuos Pro, and Cintiq Pro. When the third
button is pressed, these devices set both the HID_DG_BARRELSWITCH and
HID_DG_BARRELSWITCH2 usages since their HID descriptors do not include a
usage specific to the button.

Rather than send both BTN_STYLUS and BTN_STYLUS2 when the third button is
pressed, userspace (libinput) has requested that we detect this condition
and report a newly-defined BTN_STYLUS3 event instead. We could define a
quirk specific to devices compatible with the Pro Pen 3D, but the liklihood
of seeing both barrel switch bits set with other pens/devices is low enough
to not worry about (pens mechanically prevent accidental activation of
multiple switches).

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Acked-by: Peter Hutterer <peter.hutterer@who-t.net>
Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/wacom_wac.c                | 18 ++++++++++++++++--
 drivers/hid/wacom_wac.h                |  2 ++
 include/uapi/linux/input-event-codes.h |  1 +
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index e3223b0c4f90..16af6886e828 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -2140,6 +2140,12 @@ static void wacom_wac_pen_event(struct hid_device *hdev, struct hid_field *field
 	case HID_DG_TIPSWITCH:
 		wacom_wac->hid_data.tipswitch |= value;
 		return;
+	case HID_DG_BARRELSWITCH:
+		wacom_wac->hid_data.barrelswitch = value;
+		return;
+	case HID_DG_BARRELSWITCH2:
+		wacom_wac->hid_data.barrelswitch2 = value;
+		return;
 	case HID_DG_TOOLSERIALNUMBER:
 		if (value) {
 			wacom_wac->serial[0] = (wacom_wac->serial[0] & ~0xFFFFFFFFULL);
@@ -2254,6 +2260,12 @@ static void wacom_wac_pen_report(struct hid_device *hdev,
 
 	if (!delay_pen_events(wacom_wac) && wacom_wac->tool[0]) {
 		int id = wacom_wac->id[0];
+		int sw_state = wacom_wac->hid_data.barrelswitch |
+			       (wacom_wac->hid_data.barrelswitch2 << 1);
+
+		input_report_key(input, BTN_STYLUS, sw_state == 1);
+		input_report_key(input, BTN_STYLUS2, sw_state == 2);
+		input_report_key(input, BTN_STYLUS3, sw_state == 3);
 
 		/*
 		 * Non-USI EMR tools should have their IDs mangled to
@@ -3300,9 +3312,11 @@ int wacom_setup_pen_input_capabilities(struct input_dev *input_dev,
 	else
 		__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
 
-	if (features->type == HID_GENERIC)
-		/* setup has already been done */
+	if (features->type == HID_GENERIC) {
+		/* setup has already been done; apply otherwise-undetectible quirks */
+		input_set_capability(input_dev, EV_KEY, BTN_STYLUS3);
 		return 0;
+	}
 
 	__set_bit(BTN_TOUCH, input_dev->keybit);
 	__set_bit(ABS_MISC, input_dev->absbit);
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index 8a03654048bf..69dda27e8dde 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -291,6 +291,8 @@ struct hid_data {
 	bool inrange_state;
 	bool invert_state;
 	bool tipswitch;
+	bool barrelswitch;
+	bool barrelswitch2;
 	int x;
 	int y;
 	int pressure;
diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index 179891074b3c..9b3a522f50d1 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -406,6 +406,7 @@
 #define BTN_TOOL_MOUSE		0x146
 #define BTN_TOOL_LENS		0x147
 #define BTN_TOOL_QUINTTAP	0x148	/* Five fingers on trackpad */
+#define BTN_STYLUS3		0x149
 #define BTN_TOUCH		0x14a
 #define BTN_STYLUS		0x14b
 #define BTN_STYLUS2		0x14c
-- 
2.15.0

