From: Seth Forshee <seth.forshee@canonical.com>
Subject: [PATCH v3] HID: multitouch: Add support for button type usage
Date: Wed, 11 Mar 2015 12:29:11 -0500
Message-ID: <1426094951-44489-1-git-send-email-seth.forshee@canonical.com>
References: <20150311172525.GB136254@ubuntu-hedt>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:35742 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769AbbCKR3h (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Mar 2015 13:29:37 -0400
Received: by oifz81 with SMTP id z81so9209741oif.2
        for <linux-input@vger.kernel.org>; Wed, 11 Mar 2015 10:29:37 -0700 (PDT)
In-Reply-To: <20150311172525.GB136254@ubuntu-hedt>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Seth Forshee <seth.forshee@canonical.com>

According to [1], Windows Precision Touchpad devices must supply
a button type usage in the device capabilities feature report. A
value of 0 indicates that the device contains a depressible
button (i.e. it's a click-pad) whereas a value of 1 indicates
a non-depressible button. Add support for this usage and set
INPUT_PROP_BUTTONPAD on the touchpad input device whenever a
depressible button is present.

v2: Add string for button type usage in debugfs.
v3: Fix conflicts with 015fdaa9f8ed ("HID: multitouch: add
    support of clickpads").

[1] https://msdn.microsoft.com/en-us/library/windows/hardware/dn467314(v=vs.85).aspx

Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
---
 drivers/hid/hid-debug.c      |  1 +
 drivers/hid/hid-multitouch.c | 19 +++++++++++++++++++
 include/linux/hid.h          |  1 +
 3 files changed, 21 insertions(+)

diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index 8bf61d295ffd..4b2a18a8b7ec 100644
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
index a8bec33f4764..2e5bb788c0eb 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -71,6 +71,10 @@ MODULE_LICENSE("GPL");
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
 				* 1 means we should use a serial protocol
 				* > 1 means hybrid (multitouch) protocol */
 	__u8 buttons_count;	/* number of physical buttons per touchpad */
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
 
@@ -734,6 +749,9 @@ static void mt_touch_input_configured(struct hid_device *hdev,
 
 	/* check for clickpads */
 	if ((td->mt_flags & INPUT_MT_POINTER) && (td->buttons_count == 1))
+		td->buttontype = MT_BUTTONTYPE_DEPRESSIBLE;
+
+	if (td->buttontype == MT_BUTTONTYPE_DEPRESSIBLE)
 		__set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
 
 	input_mt_init_slots(input, td->maxcontacts, td->mt_flags);
@@ -1017,6 +1035,7 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	td->inputmode_value = MT_INPUTMODE_TOUCHSCREEN;
 	td->cc_index = -1;
 	td->mt_report_id = -1;
+	td->buttontype = MT_BUTTONTYPE_NONDEPRESSIBLE;
 	hid_set_drvdata(hdev, td);
 
 	td->fields = devm_kzalloc(&hdev->dev, sizeof(struct mt_fields),
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 69f9cf7f078d..0167e0e0bf88 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -270,6 +270,7 @@ struct hid_item {
 #define HID_DG_DEVICEINDEX	0x000d0053
 #define HID_DG_CONTACTCOUNT	0x000d0054
 #define HID_DG_CONTACTMAX	0x000d0055
+#define HID_DG_BUTTONTYPE	0x000d0059
 #define HID_DG_BARRELSWITCH2	0x000d005a
 #define HID_DG_TOOLSERIALNUMBER	0x000d005b
 
-- 
1.9.1

