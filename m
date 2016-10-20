From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH v3 07/18] HID: wacom: generic: Support and use 'Custom HID' mode and usages
Date: Wed, 19 Oct 2016 18:03:43 -0700
Message-ID: <20161020010354.4049-7-killertofu@gmail.com>
References: <20161006212231.31440-1-killertofu@gmail.com>
 <20161020010354.4049-1-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33904 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754445AbcJTBEc (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 19 Oct 2016 21:04:32 -0400
Received: by mail-pf0-f195.google.com with SMTP id 128so3847599pfz.1
        for <linux-input@vger.kernel.org>; Wed, 19 Oct 2016 18:04:31 -0700 (PDT)
In-Reply-To: <20161020010354.4049-1-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Ping Cheng <ping.cheng@wacom.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>, Jason Gerecke <killertofu@gmail.com>

Wacom's new "MobileStudio Pro" tablets are the first devices in their
branded product line-up to include a usable HID descriptor for the pen
interface. Like prior branded products, the device can operate in one
of two modes: 'Standard HID', and 'Wacom Custom HID'. Although the
first mode is usable by the HID_GENERIC codepath as-is (huzzah!), it is
subject to some restrictions -- most notably pressure being limited
to 2048 levels instead of 8192. To ensure tablets that include support
for Custom HID mode work optimally, we add support for its usages and
switch the device to Custom HID mode if possible.

The usages defined for Custom HID mode are often numerically similar to
their standard HID equivalents, allowing us to write a simple translation
function that takes arbitrary HID usages as input and which returns
the corresponding standard HID usage as output (if one exists). Switching
on this translated usage instead of the actual usage allows the existing
cases to apply to both modes of operation without having to explicitly
define every Custom HID usage.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/wacom_sys.c |  5 +++++
 drivers/hid/wacom_wac.c | 37 +++++++++++++++++++++++++++++++------
 drivers/hid/wacom_wac.h |  3 +++
 3 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 7b9bff2..b2e2471 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -166,6 +166,11 @@ static void wacom_feature_mapping(struct hid_device *hdev,
 		}
 		break;
 
+	case WACOM_HID_WD_DATAMODE:
+		wacom->wacom_wac.mode_report = field->report->id;
+		wacom->wacom_wac.mode_value = 2;
+		break;
+
 	case WACOM_HID_UP_G9:
 	case WACOM_HID_UP_G11:
 		if (field->report->id == 0x03 &&
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 3f4ba53..6c2f0e4 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1435,14 +1435,35 @@ static int wacom_tpc_irq(struct wacom_wac *wacom, size_t len)
 	return 0;
 }
 
+static int wacom_equivalent_usage(int usage)
+{
+	if ((usage & HID_USAGE_PAGE) == WACOM_HID_UP_WACOMDIGITIZER) {
+		int subpage = (usage & 0xFF00) << 8;
+		int subusage = (usage & 0xFF);
+
+		if (subpage == WACOM_HID_SP_DIGITIZER ||
+		    subpage == WACOM_HID_SP_DIGITIZERINFO) {
+			return usage;
+		}
+
+		if (subpage == HID_UP_UNDEFINED)
+			subpage = HID_UP_DIGITIZER;
+
+		return subpage | subusage;
+	}
+
+	return usage;
+}
+
 static void wacom_map_usage(struct input_dev *input, struct hid_usage *usage,
 		struct hid_field *field, __u8 type, __u16 code, int fuzz)
 {
 	int fmin = field->logical_minimum;
 	int fmax = field->logical_maximum;
+	unsigned int equivalent_usage = wacom_equivalent_usage(usage->hid);
 	int resolution_code = code;
 
-	if (usage->hid == HID_DG_TWIST) {
+	if (equivalent_usage == HID_DG_TWIST) {
 		resolution_code = ABS_RZ;
 	}
 
@@ -1472,8 +1493,9 @@ static void wacom_wac_pen_usage_mapping(struct hid_device *hdev,
 	struct wacom *wacom = hid_get_drvdata(hdev);
 	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
 	struct input_dev *input = wacom_wac->pen_input;
+	unsigned equivalent_usage = wacom_equivalent_usage(usage->hid);
 
-	switch (usage->hid) {
+	switch (equivalent_usage) {
 	case HID_GD_X:
 		wacom_map_usage(input, usage, field, EV_ABS, ABS_X, 4);
 		break;
@@ -1524,8 +1546,9 @@ static int wacom_wac_pen_event(struct hid_device *hdev, struct hid_field *field,
 	struct wacom *wacom = hid_get_drvdata(hdev);
 	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
 	struct input_dev *input = wacom_wac->pen_input;
+	unsigned equivalent_usage = wacom_equivalent_usage(usage->hid);
 
-	switch (usage->hid) {
+	switch (equivalent_usage) {
 	case HID_GD_Z:
 		/*
 		 * HID_GD_Z "should increase as the control's position is
@@ -1597,8 +1620,9 @@ static void wacom_wac_finger_usage_mapping(struct hid_device *hdev,
 	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
 	struct input_dev *input = wacom_wac->touch_input;
 	unsigned touch_max = wacom_wac->features.touch_max;
+	unsigned equivalent_usage = wacom_equivalent_usage(usage->hid);
 
-	switch (usage->hid) {
+	switch (equivalent_usage) {
 	case HID_GD_X:
 		if (touch_max == 1)
 			wacom_map_usage(input, usage, field, EV_ABS, ABS_X, 4);
@@ -1673,8 +1697,9 @@ static int wacom_wac_finger_event(struct hid_device *hdev,
 {
 	struct wacom *wacom = hid_get_drvdata(hdev);
 	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
+	unsigned equivalent_usage = wacom_equivalent_usage(usage->hid);
 
-	switch (usage->hid) {
+	switch (equivalent_usage) {
 	case HID_GD_X:
 		wacom_wac->hid_data.x = value;
 		break;
@@ -1697,7 +1722,7 @@ static int wacom_wac_finger_event(struct hid_device *hdev,
 
 
 	if (usage->usage_index + 1 == field->report_count) {
-		if (usage->hid == wacom_wac->hid_data.last_slot_field)
+		if (equivalent_usage == wacom_wac->hid_data.last_slot_field)
 			wacom_wac_finger_slot(wacom_wac, wacom_wac->touch_input);
 	}
 
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index d2629c8..ba914ba 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -85,7 +85,10 @@
 #define WACOM_DEVICETYPE_DIRECT         0x0010
 
 #define WACOM_HID_UP_WACOMDIGITIZER     0xff0d0000
+#define WACOM_HID_SP_DIGITIZER          0x000d0000
+#define WACOM_HID_SP_DIGITIZERINFO      0x00100000
 #define WACOM_HID_WD_DIGITIZER          (WACOM_HID_UP_WACOMDIGITIZER | 0x01)
+#define WACOM_HID_WD_DATAMODE           (WACOM_HID_UP_WACOMDIGITIZER | 0x1002)
 #define WACOM_HID_UP_G9                 0xff090000
 #define WACOM_HID_G9_PEN                (WACOM_HID_UP_G9 | 0x02)
 #define WACOM_HID_G9_TOUCHSCREEN        (WACOM_HID_UP_G9 | 0x11)
-- 
2.10.0

