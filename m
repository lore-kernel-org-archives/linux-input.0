From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH v3 1/2] HID: wacom: Add WACOM_DEVICETYPE_DIRECT for Cintiqs and similar
Date: Fri, 22 Jul 2016 16:15:02 -0700
Message-ID: <20160722231503.1984-1-killertofu@gmail.com>
References: <20160721161200.25830-1-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:32810 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190AbcGVXPI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Jul 2016 19:15:08 -0400
Received: by mail-pf0-f195.google.com with SMTP id i6so7943186pfe.0
        for <linux-input@vger.kernel.org>; Fri, 22 Jul 2016 16:15:08 -0700 (PDT)
In-Reply-To: <20160721161200.25830-1-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

"Direct" input devices like Cintiqs and Tablet PCs set the INPUT_PROP_DIRECT
property to notify userspace that the sensor and screen are overlaid. This
information can also be useful elsewhere within the kernel driver, however,
so we introduce a new WACOM_DEVICETYPE_DIRECT that signals this to other
kernel code.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
Changes from v2:
 * Moved setting of INPUT_PROP_DIRECT in wacom_setup_pen_input_capabilities
   and wacom_setup_touch_input_capabilities to occur before the functions
   exit if a HID_GENERIC device is being probed.

 * Changed large 'if' to 'switch' statement

 drivers/hid/wacom_wac.c | 58 +++++++++++++++++++++++++++++++++----------------
 drivers/hid/wacom_wac.h |  1 +
 2 files changed, 40 insertions(+), 19 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index d2611f3..8621d49 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1742,10 +1742,10 @@ void wacom_wac_usage_mapping(struct hid_device *hdev,
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
@@ -2450,6 +2450,33 @@ void wacom_setup_device_quirks(struct wacom *wacom)
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
+	case WACOM24_HD:
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
 
@@ -2483,6 +2510,11 @@ int wacom_setup_pen_input_capabilities(struct input_dev *input_dev,
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
@@ -2501,7 +2533,6 @@ int wacom_setup_pen_input_capabilities(struct input_dev *input_dev,
 	input_abs_set_res(input_dev, ABS_X, features->x_resolution);
 	input_abs_set_res(input_dev, ABS_Y, features->y_resolution);
 
-
 	switch (features->type) {
 	case GRAPHIRE_BT:
 		__clear_bit(ABS_MISC, input_dev->absbit);
@@ -2525,8 +2556,6 @@ int wacom_setup_pen_input_capabilities(struct input_dev *input_dev,
 		__set_bit(BTN_TOOL_MOUSE, input_dev->keybit);
 		__set_bit(BTN_STYLUS, input_dev->keybit);
 		__set_bit(BTN_STYLUS2, input_dev->keybit);
-
-		__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
 		break;
 
 	case WACOM_27QHD:
@@ -2541,7 +2570,6 @@ int wacom_setup_pen_input_capabilities(struct input_dev *input_dev,
 	case CINTIQ_COMPANION_2:
 		input_set_abs_params(input_dev, ABS_Z, -900, 899, 0, 0);
 		input_abs_set_res(input_dev, ABS_Z, 287);
-		__set_bit(INPUT_PROP_DIRECT, input_dev->propbit);
 		wacom_setup_cintiq(wacom_wac);
 		break;
 
@@ -2557,8 +2585,6 @@ int wacom_setup_pen_input_capabilities(struct input_dev *input_dev,
 		/* fall through */
 
 	case INTUOS:
-		__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
-
 		wacom_setup_intuos(wacom_wac);
 		break;
 
@@ -2568,8 +2594,6 @@ int wacom_setup_pen_input_capabilities(struct input_dev *input_dev,
 	case INTUOSPL:
 	case INTUOS5S:
 	case INTUOSPS:
-		__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
-
 		input_set_abs_params(input_dev, ABS_DISTANCE, 0,
 				      features->distance_max,
 				      features->distance_fuzz, 0);
@@ -2599,8 +2623,6 @@ int wacom_setup_pen_input_capabilities(struct input_dev *input_dev,
 		__set_bit(BTN_TOOL_RUBBER, input_dev->keybit);
 		__set_bit(BTN_STYLUS, input_dev->keybit);
 		__set_bit(BTN_STYLUS2, input_dev->keybit);
-
-		__set_bit(INPUT_PROP_DIRECT, input_dev->propbit);
 		break;
 
 	case PTU:
@@ -2611,16 +2633,12 @@ int wacom_setup_pen_input_capabilities(struct input_dev *input_dev,
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
@@ -2651,6 +2669,11 @@ int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
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
@@ -2685,8 +2708,6 @@ int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
 	case INTUOSPL:
 	case INTUOS5S:
 	case INTUOSPS:
-		__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
-
 		input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0, features->x_max, 0, 0);
 		input_set_abs_params(input_dev, ABS_MT_TOUCH_MINOR, 0, features->y_max, 0, 0);
 		input_mt_init_slots(input_dev, features->touch_max, INPUT_MT_POINTER);
@@ -2709,7 +2730,6 @@ int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
 
 	case TABLETPC:
 	case TABLETPCE:
-		__set_bit(INPUT_PROP_DIRECT, input_dev->propbit);
 		break;
 
 	case INTUOSHT:
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index 267025c..5624268 100644
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
2.9.0

