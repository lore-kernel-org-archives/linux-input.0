From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH v4 1/2] HID: wacom: Add WACOM_DEVICETYPE_DIRECT for Cintiqs and similar
Date: Mon,  8 Aug 2016 12:06:29 -0700
Message-ID: <20160808190630.7641-1-killertofu@gmail.com>
References: <20160711180711.17537-1-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35699 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752265AbcHHTGq (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Aug 2016 15:06:46 -0400
Received: by mail-pf0-f194.google.com with SMTP id h186so25420806pfg.2
        for <linux-input@vger.kernel.org>; Mon, 08 Aug 2016 12:06:46 -0700 (PDT)
In-Reply-To: <20160711180711.17537-1-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

"Direct" input devices like Cintiqs and Tablet PCs set the INPUT_PROP_DIRECT
property to notify userspace that the sensor and screen are overlaid. This
information can also be useful elsewhere within the kernel driver, however,
so we introduce a new WACOM_DEVICETYPE_DIRECT that signals this to other
kernel code.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
Changes from v3:
 * Changed 'WACOM24_HD' to 'WACOM_24HD' (/me places paper bag over head)

 drivers/hid/wacom_wac.c | 58 +++++++++++++++++++++++++++++++++----------------
 drivers/hid/wacom_wac.h |  1 +
 2 files changed, 40 insertions(+), 19 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 510a56b..cfefed0 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1740,10 +1740,10 @@ void wacom_wac_usage_mapping(struct hid_device *hdev,
 {
 	struct wacom *wacom = hid_get_drvdata(hdev);
 	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
+	struct wacom_features *features = &wacom_wac->features;
 
 	/* currently, only direct devices have proper hid report descriptors */
-	__set_bit(INPUT_PROP_DIRECT, wacom_wac->pen_input->propbit);
-	__set_bit(INPUT_PROP_DIRECT, wacom_wac->touch_input->propbit);
+	features->device_type |= WACOM_DEVICETYPE_DIRECT;
 
 	if (WACOM_PEN_FIELD(field))
 		return wacom_wac_pen_usage_mapping(hdev, field, usage);
@@ -2449,6 +2449,33 @@ void wacom_setup_device_quirks(struct wacom *wacom)
 	if (features->type == REMOTE)
 		features->device_type = WACOM_DEVICETYPE_PAD;
 
+	switch (features->type) {
+	case PL:
+	case DTU:
+	case DTUS:
+	case DTUSX:
+	case WACOM_21UX2:
+	case WACOM_22HD:
+	case DTK:
+	case WACOM_24HD:
+	case WACOM_27QHD:
+	case CINTIQ_HYBRID:
+	case CINTIQ_COMPANION_2:
+	case CINTIQ:
+	case WACOM_BEE:
+	case WACOM_13HD:
+	case WACOM_24HDT:
+	case WACOM_27QHDT:
+	case TABLETPC:
+	case TABLETPCE:
+	case TABLETPC2FG:
+	case MTSCREEN:
+	case MTTPC:
+	case MTTPC_B:
+		features->device_type |= WACOM_DEVICETYPE_DIRECT;
+		break;
+	}
+
 	if (wacom->hdev->bus == BUS_BLUETOOTH)
 		features->quirks |= WACOM_QUIRK_BATTERY;
 
@@ -2482,6 +2509,11 @@ int wacom_setup_pen_input_capabilities(struct input_dev *input_dev,
 	if (!(features->device_type & WACOM_DEVICETYPE_PEN))
 		return -ENODEV;
 
+	if (features->device_type & WACOM_DEVICETYPE_DIRECT)
+		__set_bit(INPUT_PROP_DIRECT, input_dev->propbit);
+	else
+		__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
+
 	if (features->type == HID_GENERIC)
 		/* setup has already been done */
 		return 0;
@@ -2500,7 +2532,6 @@ int wacom_setup_pen_input_capabilities(struct input_dev *input_dev,
 	input_abs_set_res(input_dev, ABS_X, features->x_resolution);
 	input_abs_set_res(input_dev, ABS_Y, features->y_resolution);
 
-
 	switch (features->type) {
 	case GRAPHIRE_BT:
 		__clear_bit(ABS_MISC, input_dev->absbit);
@@ -2524,8 +2555,6 @@ int wacom_setup_pen_input_capabilities(struct input_dev *input_dev,
 		__set_bit(BTN_TOOL_MOUSE, input_dev->keybit);
 		__set_bit(BTN_STYLUS, input_dev->keybit);
 		__set_bit(BTN_STYLUS2, input_dev->keybit);
-
-		__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
 		break;
 
 	case WACOM_27QHD:
@@ -2540,7 +2569,6 @@ int wacom_setup_pen_input_capabilities(struct input_dev *input_dev,
 	case CINTIQ_COMPANION_2:
 		input_set_abs_params(input_dev, ABS_Z, -900, 899, 0, 0);
 		input_abs_set_res(input_dev, ABS_Z, 287);
-		__set_bit(INPUT_PROP_DIRECT, input_dev->propbit);
 		wacom_setup_cintiq(wacom_wac);
 		break;
 
@@ -2556,8 +2584,6 @@ int wacom_setup_pen_input_capabilities(struct input_dev *input_dev,
 		/* fall through */
 
 	case INTUOS:
-		__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
-
 		wacom_setup_intuos(wacom_wac);
 		break;
 
@@ -2567,8 +2593,6 @@ int wacom_setup_pen_input_capabilities(struct input_dev *input_dev,
 	case INTUOSPL:
 	case INTUOS5S:
 	case INTUOSPS:
-		__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
-
 		input_set_abs_params(input_dev, ABS_DISTANCE, 0,
 				      features->distance_max,
 				      features->distance_fuzz, 0);
@@ -2598,8 +2622,6 @@ int wacom_setup_pen_input_capabilities(struct input_dev *input_dev,
 		__set_bit(BTN_TOOL_RUBBER, input_dev->keybit);
 		__set_bit(BTN_STYLUS, input_dev->keybit);
 		__set_bit(BTN_STYLUS2, input_dev->keybit);
-
-		__set_bit(INPUT_PROP_DIRECT, input_dev->propbit);
 		break;
 
 	case PTU:
@@ -2610,16 +2632,12 @@ int wacom_setup_pen_input_capabilities(struct input_dev *input_dev,
 		__set_bit(BTN_TOOL_PEN, input_dev->keybit);
 		__set_bit(BTN_TOOL_RUBBER, input_dev->keybit);
 		__set_bit(BTN_STYLUS, input_dev->keybit);
-
-		__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
 		break;
 
 	case INTUOSHT:
 	case BAMBOO_PT:
 	case BAMBOO_PEN:
 	case INTUOSHT2:
-		__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
-
 		if (features->type == INTUOSHT2) {
 			wacom_setup_basic_pro_pen(wacom_wac);
 		} else {
@@ -2650,6 +2668,11 @@ int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
 	if (!(features->device_type & WACOM_DEVICETYPE_TOUCH))
 		return -ENODEV;
 
+	if (features->device_type & WACOM_DEVICETYPE_DIRECT)
+		__set_bit(INPUT_PROP_DIRECT, input_dev->propbit);
+	else
+		__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
+
 	if (features->type == HID_GENERIC)
 		/* setup has already been done */
 		return 0;
@@ -2684,8 +2707,6 @@ int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
 	case INTUOSPL:
 	case INTUOS5S:
 	case INTUOSPS:
-		__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
-
 		input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0, features->x_max, 0, 0);
 		input_set_abs_params(input_dev, ABS_MT_TOUCH_MINOR, 0, features->y_max, 0, 0);
 		input_mt_init_slots(input_dev, features->touch_max, INPUT_MT_POINTER);
@@ -2708,7 +2729,6 @@ int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
 
 	case TABLETPC:
 	case TABLETPCE:
-		__set_bit(INPUT_PROP_DIRECT, input_dev->propbit);
 		break;
 
 	case INTUOSHT:
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index 9326b60..324c40b 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -82,6 +82,7 @@
 #define WACOM_DEVICETYPE_TOUCH          0x0002
 #define WACOM_DEVICETYPE_PAD            0x0004
 #define WACOM_DEVICETYPE_WL_MONITOR     0x0008
+#define WACOM_DEVICETYPE_DIRECT         0x0010
 
 #define WACOM_VENDORDEFINED_PEN		0xff0d0001
 #define WACOM_G9_PAGE			0xff090000
-- 
2.9.2

