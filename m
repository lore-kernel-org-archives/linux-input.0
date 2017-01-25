From: Aaron Armstrong Skomra <skomra@gmail.com>
Subject: [PATCH 8/8] HID: wacom: generic: support LEDs
Date: Wed, 25 Jan 2017 12:08:42 -0800
Message-ID: <1485374922-3417-9-git-send-email-skomra@gmail.com>
References: <1485374922-3417-1-git-send-email-skomra@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35720 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751718AbdAYUJo (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 25 Jan 2017 15:09:44 -0500
Received: by mail-pg0-f68.google.com with SMTP id 204so20532763pge.2
        for <linux-input@vger.kernel.org>; Wed, 25 Jan 2017 12:09:43 -0800 (PST)
In-Reply-To: <1485374922-3417-1-git-send-email-skomra@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, jkosina@suse.cz, benjamin.tissoires@redhat.com, pinglinux@gmail.com, killertofu@gmail.com
Cc: Aaron Armstrong Skomra <skomra@gmail.com>, Aaron Skomra <aaron.skomra@wacom.com>

Add support for the LEDs around the mode switch to the
generic code path in support of the second generation
Intuos Pro.

Signed-off-by: Aaron Skomra <aaron.skomra@wacom.com>
---
 drivers/hid/wacom.h     |  2 ++
 drivers/hid/wacom_sys.c | 39 ++++++++++++++++++++++++++++++++++++---
 drivers/hid/wacom_wac.c | 14 +++++++++++++-
 drivers/hid/wacom_wac.h |  1 +
 4 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/wacom.h b/drivers/hid/wacom.h
index 0e7b840..d0d7dc1 100644
--- a/drivers/hid/wacom.h
+++ b/drivers/hid/wacom.h
@@ -168,6 +168,7 @@ struct wacom {
 	struct work_struct remote_work;
 	struct delayed_work init_work;
 	struct wacom_remote *remote;
+	bool generic_has_leds;
 	struct wacom_leds {
 		struct wacom_group_leds *groups;
 		unsigned int count;
@@ -220,4 +221,5 @@ struct wacom_led *wacom_led_find(struct wacom *wacom, unsigned int group,
 				 unsigned int id);
 struct wacom_led *wacom_led_next(struct wacom *wacom, struct wacom_led *cur);
 int wacom_equivalent_usage(int usage);
+int wacom_initialize_leds(struct wacom *wacom);
 #endif
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index a8e68dc..3586acb 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -771,8 +771,13 @@ static int wacom_led_control(struct wacom *wacom)
 	if (!buf)
 		return -ENOMEM;
 
-	if (wacom->wacom_wac.features.type >= INTUOS5S &&
-	    wacom->wacom_wac.features.type <= INTUOSPL) {
+	if (wacom->wacom_wac.features.type == HID_GENERIC) {
+		buf[0] = WAC_CMD_LED_CONTROL_GENERIC;
+		buf[1] = wacom->led.llv;
+		buf[2] = wacom->led.groups[0].select & 0x03;
+
+	} else if ((wacom->wacom_wac.features.type >= INTUOS5S &&
+	    wacom->wacom_wac.features.type <= INTUOSPL)) {
 		/*
 		 * Touch Ring and crop mark LED luminance may take on
 		 * one of four values:
@@ -1042,6 +1047,17 @@ static struct attribute_group intuos5_led_attr_group = {
 	.attrs = intuos5_led_attrs,
 };
 
+static struct attribute *generic_led_attrs[] = {
+	&dev_attr_status0_luminance.attr,
+	&dev_attr_status_led0_select.attr,
+	NULL
+};
+
+static struct attribute_group generic_led_attr_group = {
+	.name = "wacom_led",
+	.attrs = generic_led_attrs,
+};
+
 struct wacom_sysfs_group_devres {
 	struct attribute_group *group;
 	struct kobject *root;
@@ -1363,7 +1379,7 @@ static int wacom_leds_alloc_and_register(struct wacom *wacom, int group_count,
 	return 0;
 }
 
-static int wacom_initialize_leds(struct wacom *wacom)
+int wacom_initialize_leds(struct wacom *wacom)
 {
 	int error;
 
@@ -1372,6 +1388,23 @@ static int wacom_initialize_leds(struct wacom *wacom)
 
 	/* Initialize default values */
 	switch (wacom->wacom_wac.features.type) {
+	case HID_GENERIC:
+		if (!wacom->generic_has_leds)
+			return 0;
+		wacom->led.llv = 100;
+		wacom->led.max_llv = 100;
+
+		error = wacom_leds_alloc_and_register(wacom, 1, 4, false);
+		if (error) {
+			hid_err(wacom->hdev,
+				"cannot create leds err: %d\n", error);
+			return error;
+		}
+
+		error = wacom_devm_sysfs_create_group(wacom,
+						      &generic_led_attr_group);
+		break;
+
 	case INTUOS4S:
 	case INTUOS4:
 	case INTUOS4WL:
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 06d152a..0dad786 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -43,6 +43,8 @@ static void wacom_report_numbered_buttons(struct input_dev *input_dev,
 
 static int wacom_numbered_button_to_key(int n);
 
+static void wacom_update_led(struct wacom *wacom, int button_count, int mask,
+			     int group);
 /*
  * Percent of battery capacity for Graphire.
  * 8th value means AC online and show 100% capacity.
@@ -1715,12 +1717,14 @@ static void wacom_wac_pad_usage_mapping(struct hid_device *hdev,
 		wacom_map_usage(input, usage, field, EV_ABS, ABS_Z, 0);
 		features->device_type |= WACOM_DEVICETYPE_PAD;
 		break;
+	case WACOM_HID_WD_BUTTONCENTER:
+		wacom->generic_has_leds = true;
+		/* fall through */
 	case WACOM_HID_WD_BUTTONHOME:
 	case WACOM_HID_WD_BUTTONUP:
 	case WACOM_HID_WD_BUTTONDOWN:
 	case WACOM_HID_WD_BUTTONLEFT:
 	case WACOM_HID_WD_BUTTONRIGHT:
-	case WACOM_HID_WD_BUTTONCENTER:
 		wacom_map_usage(input, usage, field, EV_KEY,
 				wacom_numbered_button_to_key(features->numbered_buttons),
 				0);
@@ -1797,7 +1801,9 @@ static void wacom_wac_pad_event(struct hid_device *hdev, struct hid_field *field
 	struct wacom *wacom = hid_get_drvdata(hdev);
 	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
 	struct input_dev *input = wacom_wac->pad_input;
+	struct wacom_features *features = &wacom_wac->features;
 	unsigned equivalent_usage = wacom_equivalent_usage(usage->hid);
+	int i;
 
 	/*
 	 * Avoid reporting this event and setting inrange_state if this usage
@@ -1824,6 +1830,12 @@ static void wacom_wac_pad_event(struct hid_device *hdev, struct hid_field *field
 			input_sync(wacom_wac->shared->touch_input);
 		}
 		break;
+
+	case WACOM_HID_WD_BUTTONCENTER:
+		for (i = 0; i < wacom->led.count; i++)
+			wacom_update_led(wacom, features->numbered_buttons,
+					 value, i);
+		 /* fall through*/
 	default:
 		input_event(input, usage->type, usage->code, value);
 		break;
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index 4feaf94..857ccee 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -79,6 +79,7 @@
 #define WAC_CMD_ICON_XFER               0x23
 #define WAC_CMD_ICON_BT_XFER            0x26
 #define WAC_CMD_DELETE_PAIRING          0x20
+#define WAC_CMD_LED_CONTROL_GENERIC     0x32
 #define WAC_CMD_UNPAIR_ALL              0xFF
 #define WAC_CMD_WL_INTUOSP2             0x82
 
-- 
2.7.4

