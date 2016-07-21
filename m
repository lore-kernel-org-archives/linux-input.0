From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH v2 1/2] HID: wacom: Add WACOM_DEVICETYPE_DIRECT for Cintiqs and similar
Date: Thu, 21 Jul 2016 09:11:59 -0700
Message-ID: <20160721161200.25830-1-killertofu@gmail.com>
References: <20160711180711.17537-1-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36570 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753100AbcGUQMJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Jul 2016 12:12:09 -0400
Received: by mail-pf0-f193.google.com with SMTP id y134so5693103pfg.3
        for <linux-input@vger.kernel.org>; Thu, 21 Jul 2016 09:12:08 -0700 (PDT)
In-Reply-To: <20160711180711.17537-1-killertofu@gmail.com>
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
 drivers/hid/wacom_wac.c | 40 ++++++++++++++++++++++++----------------
 drivers/hid/wacom_wac.h |  1 +
 2 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index d2611f3..9a13d09 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1742,8 +1742,10 @@ void wacom_wac_usage_mapping(struct hid_device *hdev,
 {
 	struct wacom *wacom = hid_get_drvdata(hdev);
 	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
+	struct wacom_features *features = &wacom_wac->features;
 
 	/* currently, only direct devices have proper hid report descriptors */
+	features->device_type |= WACOM_DEVICETYPE_DIRECT;
 	__set_bit(INPUT_PROP_DIRECT, wacom_wac->pen_input->propbit);
 	__set_bit(INPUT_PROP_DIRECT, wacom_wac->touch_input->propbit);
 
@@ -2450,6 +2452,19 @@ void wacom_setup_device_quirks(struct wacom *wacom)
 	if (features->type == REMOTE)
 		features->device_type = WACOM_DEVICETYPE_PAD;
 
+	if (features->type == PL          || features->type == DTU           ||
+	    features->type == DTUS        || features->type == DTUSX         ||
+	    features->type == WACOM_21UX2 || features->type == WACOM_22HD    ||
+	    features->type == DTK         || features->type == WACOM_24HD    ||
+	    features->type == WACOM_27QHD || features->type == CINTIQ_HYBRID ||
+	    features->type == CINTIQ_COMPANION_2 || features->type == CINTIQ ||
+	    features->type == WACOM_BEE   || features->type == WACOM_13HD    ||
+	    features->type == WACOM_24HDT || features->type == WACOM_27QHDT  ||
+	    features->type == TABLETPC    || features->type == TABLETPCE     ||
+	    features->type == TABLETPC2FG || features->type == MTSCREEN      ||
+	    features->type == MTTPC       || features->type == MTTPC_B)
+	    features->device_type |= WACOM_DEVICETYPE_DIRECT;
+
 	if (wacom->hdev->bus == BUS_BLUETOOTH)
 		features->quirks |= WACOM_QUIRK_BATTERY;
 
@@ -2501,6 +2516,10 @@ int wacom_setup_pen_input_capabilities(struct input_dev *input_dev,
 	input_abs_set_res(input_dev, ABS_X, features->x_resolution);
 	input_abs_set_res(input_dev, ABS_Y, features->y_resolution);
 
+	if (features->device_type & WACOM_DEVICETYPE_DIRECT)
+		__set_bit(INPUT_PROP_DIRECT, input_dev->propbit);
+	else
+		__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
 
 	switch (features->type) {
 	case GRAPHIRE_BT:
@@ -2525,8 +2544,6 @@ int wacom_setup_pen_input_capabilities(struct input_dev *input_dev,
 		__set_bit(BTN_TOOL_MOUSE, input_dev->keybit);
 		__set_bit(BTN_STYLUS, input_dev->keybit);
 		__set_bit(BTN_STYLUS2, input_dev->keybit);
-
-		__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
 		break;
 
 	case WACOM_27QHD:
@@ -2541,7 +2558,6 @@ int wacom_setup_pen_input_capabilities(struct input_dev *input_dev,
 	case CINTIQ_COMPANION_2:
 		input_set_abs_params(input_dev, ABS_Z, -900, 899, 0, 0);
 		input_abs_set_res(input_dev, ABS_Z, 287);
-		__set_bit(INPUT_PROP_DIRECT, input_dev->propbit);
 		wacom_setup_cintiq(wacom_wac);
 		break;
 
@@ -2557,8 +2573,6 @@ int wacom_setup_pen_input_capabilities(struct input_dev *input_dev,
 		/* fall through */
 
 	case INTUOS:
-		__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
-
 		wacom_setup_intuos(wacom_wac);
 		break;
 
@@ -2568,8 +2582,6 @@ int wacom_setup_pen_input_capabilities(struct input_dev *input_dev,
 	case INTUOSPL:
 	case INTUOS5S:
 	case INTUOSPS:
-		__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
-
 		input_set_abs_params(input_dev, ABS_DISTANCE, 0,
 				      features->distance_max,
 				      features->distance_fuzz, 0);
@@ -2599,8 +2611,6 @@ int wacom_setup_pen_input_capabilities(struct input_dev *input_dev,
 		__set_bit(BTN_TOOL_RUBBER, input_dev->keybit);
 		__set_bit(BTN_STYLUS, input_dev->keybit);
 		__set_bit(BTN_STYLUS2, input_dev->keybit);
-
-		__set_bit(INPUT_PROP_DIRECT, input_dev->propbit);
 		break;
 
 	case PTU:
@@ -2611,16 +2621,12 @@ int wacom_setup_pen_input_capabilities(struct input_dev *input_dev,
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
@@ -2678,6 +2684,11 @@ int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
 				  features->y_resolution);
 	}
 
+	if (features->device_type & WACOM_DEVICETYPE_DIRECT)
+		__set_bit(INPUT_PROP_DIRECT, input_dev->propbit);
+	else
+		__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
+
 	switch (features->type) {
 	case INTUOS5:
 	case INTUOS5L:
@@ -2685,8 +2696,6 @@ int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
 	case INTUOSPL:
 	case INTUOS5S:
 	case INTUOSPS:
-		__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
-
 		input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0, features->x_max, 0, 0);
 		input_set_abs_params(input_dev, ABS_MT_TOUCH_MINOR, 0, features->y_max, 0, 0);
 		input_mt_init_slots(input_dev, features->touch_max, INPUT_MT_POINTER);
@@ -2709,7 +2718,6 @@ int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
 
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

