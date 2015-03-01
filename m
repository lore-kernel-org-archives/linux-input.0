From: Seth Forshee <seth.forshee@canonical.com>
Subject: [PATCH v2] HID: multitouch: Add support for button type usage
Date: Sat, 28 Feb 2015 21:34:30 -0600
Message-ID: <1425180871-5232-1-git-send-email-seth.forshee@canonical.com>
References: <1425070801-73595-1-git-send-email-seth.forshee@canonical.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:57345 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752425AbbCADee (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Feb 2015 22:34:34 -0500
Received: by mail-oi0-f48.google.com with SMTP id a3so21874410oib.7
        for <linux-input@vger.kernel.org>; Sat, 28 Feb 2015 19:34:33 -0800 (PST)
In-Reply-To: <1425070801-73595-1-git-send-email-seth.forshee@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Seth Forshee <seth.forshee@canonical.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

According to [1], Windows Precision Touchpad devices must supply
a button type usage in the device capabilities feature report. A
value of 0 indicates that the device contains a depressible
button (i.e. it's a click-pad) whereas a value of 1 indicates
a non-depressible button. Add support for this usage and set
INPUT_PROP_BUTTONPAD on the touchpad input device whenever a
depressible button is present.

v2: Add string for button type usage in debugfs.

[1] https://msdn.microsoft.com/en-us/library/windows/hardware/dn467314(v=vs.85).aspx

Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
---
 drivers/hid/hid-debug.c      |  1 +
 drivers/hid/hid-multitouch.c | 19 +++++++++++++++++++
 include/linux/hid.h          |  1 +
 3 files changed, 21 insertions(+)

diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index 8bf61d2..4b2a18a 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -165,6 +165,7 @@ static const struct hid_usage_entry hid_usage_table[] = {
     {0, 0x53, "DeviceIndex"},
     {0, 0x54, "ContactCount"},
     {0, 0x55, "ContactMaximumNumber"},
+    {0, 0x59, "ButtonType"},
     {0, 0x5A, "SecondaryBarrelSwitch"},
     {0, 0x5B, "TransducerSerialNumber"},
   { 15, 0, "PhysicalInterfaceDevice" },
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index f65e78b..b19d721 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -72,6 +72,10 @@ MODULE_LICENSE("GPL");
 #define MT_INPUTMODE_TOUCHSCREEN	0x02
 #define MT_INPUTMODE_TOUCHPAD		0x03
 
+#define MT_BUTTONTYPE_DEPRESSIBLE	0
+#define MT_BUTTONTYPE_NONDEPRESSIBLE	1
+#define MT_BUTTONTYPE_MAX		MT_BUTTONTYPE_NONDEPRESSIBLE
+
 struct mt_slot {
 	__s32 x, y, cx, cy, p, w, h;
 	__s32 contactid;	/* the device ContactID assigned to this slot */
@@ -116,6 +120,7 @@ struct mt_device {
 	__u8 touches_by_report;	/* how many touches are present in one report:
 				* 1 means we should use a serial protocol
 				* > 1 means hybrid (multitouch) protocol */
+	__u8 buttontype;	/* depressible or non-depressible touchpad */
 	bool serial_maybe;	/* need to check for serial protocol */
 	bool curvalid;		/* is the current contact valid? */
 	unsigned mt_flags;	/* flags to pass to input-mt */
@@ -334,6 +339,16 @@ static void mt_feature_mapping(struct hid_device *hdev,
 			td->maxcontacts = td->mtclass.maxcontacts;
 
 		break;
+	case HID_DG_BUTTONTYPE:
+		if (usage->usage_index >= field->report_count) {
+			dev_err(&hdev->dev, "HID_DG_BUTTONTYPE out of range\n");
+			break;
+		}
+
+		if (field->value[usage->usage_index] <= MT_BUTTONTYPE_MAX)
+			td->buttontype = field->value[usage->usage_index];
+
+		break;
 	}
 }
 
@@ -728,6 +743,9 @@ static void mt_touch_input_configured(struct hid_device *hdev,
 	if (cls->quirks & MT_QUIRK_NOT_SEEN_MEANS_UP)
 		td->mt_flags |= INPUT_MT_DROP_UNUSED;
 
+	if (td->buttontype == MT_BUTTONTYPE_DEPRESSIBLE)
+		__set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
+
 	input_mt_init_slots(input, td->maxcontacts, td->mt_flags);
 
 	td->mt_flags = 0;
@@ -1009,6 +1027,7 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	td->inputmode_value = MT_INPUTMODE_TOUCHSCREEN;
 	td->cc_index = -1;
 	td->mt_report_id = -1;
+	td->buttontype = MT_BUTTONTYPE_NONDEPRESSIBLE;
 	hid_set_drvdata(hdev, td);
 
 	td->fields = devm_kzalloc(&hdev->dev, sizeof(struct mt_fields),
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 06c4607..498ddad 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -269,6 +269,7 @@ struct hid_item {
 #define HID_DG_DEVICEINDEX	0x000d0053
 #define HID_DG_CONTACTCOUNT	0x000d0054
 #define HID_DG_CONTACTMAX	0x000d0055
+#define HID_DG_BUTTONTYPE	0x000d0059
 #define HID_DG_BARRELSWITCH2	0x000d005a
 #define HID_DG_TOOLSERIALNUMBER	0x000d005b
 
-- 
2.1.4

