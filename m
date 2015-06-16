From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH v2 4/5] HID: wacom: Split apart 'wacom_setup_pentouch_input_capabilites'
Date: Mon, 15 Jun 2015 18:01:44 -0700
Message-ID: <1434416505-12685-4-git-send-email-killertofu@gmail.com>
References: <1434416505-12685-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36427 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991AbbFPBCJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Jun 2015 21:02:09 -0400
Received: by pabqy3 with SMTP id qy3so1636490pab.3
        for <linux-input@vger.kernel.org>; Mon, 15 Jun 2015 18:02:08 -0700 (PDT)
In-Reply-To: <1434416505-12685-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

This splits the 'wacom_setup_pentouch_input_capabilites' function into
pieces dedicated to doing setup for just the pen interface and just
the touch interface. This makes it easier to focus on the relevant
piece when making changes.

This patch introduces no functional changes.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
No changes from v1.

 drivers/hid/wacom.h     |   4 +-
 drivers/hid/wacom_sys.c |   8 +-
 drivers/hid/wacom_wac.c | 234 +++++++++++++++++++++++++-----------------------
 3 files changed, 131 insertions(+), 115 deletions(-)

diff --git a/drivers/hid/wacom.h b/drivers/hid/wacom.h
index c76e21f..a533787 100644
--- a/drivers/hid/wacom.h
+++ b/drivers/hid/wacom.h
@@ -135,7 +135,9 @@ extern const struct hid_device_id wacom_ids[];
 
 void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len);
 void wacom_setup_device_quirks(struct wacom *wacom);
-int wacom_setup_pentouch_input_capabilities(struct input_dev *input_dev,
+int wacom_setup_pen_input_capabilities(struct input_dev *input_dev,
+				   struct wacom_wac *wacom_wac);
+int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
 				   struct wacom_wac *wacom_wac);
 int wacom_setup_pad_input_capabilities(struct input_dev *input_dev,
 				       struct wacom_wac *wacom_wac);
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index aaa9c84..ca15c7f 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1199,7 +1199,8 @@ static int wacom_register_inputs(struct wacom *wacom)
 {
 	struct input_dev *input_dev, *pad_input_dev;
 	struct wacom_wac *wacom_wac = &(wacom->wacom_wac);
-	int error;
+	struct wacom_features *features = &wacom_wac->features;
+	int error = 0;
 
 	input_dev = wacom_wac->input;
 	pad_input_dev = wacom_wac->pad_input;
@@ -1207,7 +1208,10 @@ static int wacom_register_inputs(struct wacom *wacom)
 	if (!input_dev || !pad_input_dev)
 		return -EINVAL;
 
-	error = wacom_setup_pentouch_input_capabilities(input_dev, wacom_wac);
+	if (features->device_type & WACOM_DEVICETYPE_PEN)
+		error = wacom_setup_pen_input_capabilities(input_dev, wacom_wac);
+	if (!error && features->device_type & WACOM_DEVICETYPE_TOUCH)
+		error = wacom_setup_touch_input_capabilities(input_dev, wacom_wac);
 	if (!error) {
 		error = input_register_device(input_dev);
 		if (error)
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 564a06d..b80a67a 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -2237,54 +2237,16 @@ void wacom_setup_device_quirks(struct wacom *wacom)
 	}
 }
 
-static void wacom_abs_set_axis(struct input_dev *input_dev,
-			       struct wacom_wac *wacom_wac)
-{
-	struct wacom_features *features = &wacom_wac->features;
-
-	if (features->device_type & WACOM_DEVICETYPE_PEN) {
-		input_set_abs_params(input_dev, ABS_X, features->x_min,
-				     features->x_max, features->x_fuzz, 0);
-		input_set_abs_params(input_dev, ABS_Y, features->y_min,
-				     features->y_max, features->y_fuzz, 0);
-		input_set_abs_params(input_dev, ABS_PRESSURE, 0,
-			features->pressure_max, features->pressure_fuzz, 0);
-
-		/* penabled devices have fixed resolution for each model */
-		input_abs_set_res(input_dev, ABS_X, features->x_resolution);
-		input_abs_set_res(input_dev, ABS_Y, features->y_resolution);
-	} else if (features->device_type & WACOM_DEVICETYPE_TOUCH) {
-		if (features->touch_max == 1) {
-			input_set_abs_params(input_dev, ABS_X, 0,
-				features->x_max, features->x_fuzz, 0);
-			input_set_abs_params(input_dev, ABS_Y, 0,
-				features->y_max, features->y_fuzz, 0);
-			input_abs_set_res(input_dev, ABS_X,
-					  features->x_resolution);
-			input_abs_set_res(input_dev, ABS_Y,
-					  features->y_resolution);
-		}
-
-		if (features->touch_max > 1) {
-			input_set_abs_params(input_dev, ABS_MT_POSITION_X, 0,
-				features->x_max, features->x_fuzz, 0);
-			input_set_abs_params(input_dev, ABS_MT_POSITION_Y, 0,
-				features->y_max, features->y_fuzz, 0);
-			input_abs_set_res(input_dev, ABS_MT_POSITION_X,
-					  features->x_resolution);
-			input_abs_set_res(input_dev, ABS_MT_POSITION_Y,
-					  features->y_resolution);
-		}
-	}
-}
-
-int wacom_setup_pentouch_input_capabilities(struct input_dev *input_dev,
+int wacom_setup_pen_input_capabilities(struct input_dev *input_dev,
 				   struct wacom_wac *wacom_wac)
 {
 	struct wacom_features *features = &wacom_wac->features;
 
 	input_dev->evbit[0] |= BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
 
+	if (!(features->device_type & WACOM_DEVICETYPE_PEN))
+		return -ENODEV;
+
 	if (features->type == HID_GENERIC)
 		/* setup has already been done */
 		return 0;
@@ -2292,7 +2254,17 @@ int wacom_setup_pentouch_input_capabilities(struct input_dev *input_dev,
 	__set_bit(BTN_TOUCH, input_dev->keybit);
 	__set_bit(ABS_MISC, input_dev->absbit);
 
-	wacom_abs_set_axis(input_dev, wacom_wac);
+	input_set_abs_params(input_dev, ABS_X, features->x_min,
+			     features->x_max, features->x_fuzz, 0);
+	input_set_abs_params(input_dev, ABS_Y, features->y_min,
+			     features->y_max, features->y_fuzz, 0);
+	input_set_abs_params(input_dev, ABS_PRESSURE, 0,
+		features->pressure_max, features->pressure_fuzz, 0);
+
+	/* penabled devices have fixed resolution for each model */
+	input_abs_set_res(input_dev, ABS_X, features->x_resolution);
+	input_abs_set_res(input_dev, ABS_Y, features->y_resolution);
+
 
 	switch (features->type) {
 	case GRAPHIRE_BT:
@@ -2361,53 +2333,25 @@ int wacom_setup_pentouch_input_capabilities(struct input_dev *input_dev,
 	case INTUOSPS:
 		__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
 
-		if (features->device_type & WACOM_DEVICETYPE_PEN) {
-			input_set_abs_params(input_dev, ABS_DISTANCE, 0,
-					      features->distance_max,
-					      0, 0);
-
-			input_set_abs_params(input_dev, ABS_Z, -900, 899, 0, 0);
-			input_abs_set_res(input_dev, ABS_Z, 287);
+		input_set_abs_params(input_dev, ABS_DISTANCE, 0,
+				      features->distance_max,
+				      0, 0);
 
-			wacom_setup_intuos(wacom_wac);
-		} else if (features->device_type & WACOM_DEVICETYPE_TOUCH) {
-			__clear_bit(ABS_MISC, input_dev->absbit);
+		input_set_abs_params(input_dev, ABS_Z, -900, 899, 0, 0);
+		input_abs_set_res(input_dev, ABS_Z, 287);
 
-			input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR,
-			                     0, features->x_max, 0, 0);
-			input_set_abs_params(input_dev, ABS_MT_TOUCH_MINOR,
-			                     0, features->y_max, 0, 0);
-			input_mt_init_slots(input_dev, features->touch_max, INPUT_MT_POINTER);
-		}
+		wacom_setup_intuos(wacom_wac);
 		break;
 
 	case WACOM_24HDT:
-		if (features->device_type & WACOM_DEVICETYPE_TOUCH) {
-			input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0, features->x_max, 0, 0);
-			input_set_abs_params(input_dev, ABS_MT_WIDTH_MAJOR, 0, features->x_max, 0, 0);
-			input_set_abs_params(input_dev, ABS_MT_WIDTH_MINOR, 0, features->y_max, 0, 0);
-			input_set_abs_params(input_dev, ABS_MT_ORIENTATION, 0, 1, 0, 0);
-		}
-		/* fall through */
-
 	case WACOM_27QHDT:
 	case MTSCREEN:
 	case MTTPC:
 	case MTTPC_B:
 	case TABLETPC2FG:
-		if (features->device_type & WACOM_DEVICETYPE_TOUCH && features->touch_max > 1)
-			input_mt_init_slots(input_dev, features->touch_max, INPUT_MT_DIRECT);
-		/* fall through */
-
 	case TABLETPC:
 	case TABLETPCE:
 		__clear_bit(ABS_MISC, input_dev->absbit);
-
-		__set_bit(INPUT_PROP_DIRECT, input_dev->propbit);
-
-		if (!(features->device_type & WACOM_DEVICETYPE_PEN))
-			break;  /* no need to process stylus stuff */
-
 		/* fall through */
 
 	case DTUS:
@@ -2435,48 +2379,114 @@ int wacom_setup_pentouch_input_capabilities(struct input_dev *input_dev,
 		break;
 
 	case INTUOSHT:
-		if (features->device_type & WACOM_DEVICETYPE_TOUCH) {
-			input_dev->evbit[0] |= BIT_MASK(EV_SW);
-			__set_bit(SW_MUTE_DEVICE, input_dev->swbit);
-		}
-		/* fall through */
-
 	case BAMBOO_PT:
 		__clear_bit(ABS_MISC, input_dev->absbit);
 
-		if (features->device_type & WACOM_DEVICETYPE_TOUCH) {
-			if (features->pktlen == WACOM_PKGLEN_BBTOUCH3) {
-				input_set_abs_params(input_dev,
-					     ABS_MT_TOUCH_MAJOR,
-					     0, features->x_max, 0, 0);
-				input_set_abs_params(input_dev,
-					     ABS_MT_TOUCH_MINOR,
-					     0, features->y_max, 0, 0);
-			}
-			input_mt_init_slots(input_dev, features->touch_max, INPUT_MT_POINTER);
-		}
-		if (features->device_type & WACOM_DEVICETYPE_PAD) {
-			/* buttons/keys only interface */
-			__clear_bit(ABS_X, input_dev->absbit);
-			__clear_bit(ABS_Y, input_dev->absbit);
-			__clear_bit(BTN_TOUCH, input_dev->keybit);
+		__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
+		__set_bit(BTN_TOOL_RUBBER, input_dev->keybit);
+		__set_bit(BTN_TOOL_PEN, input_dev->keybit);
+		__set_bit(BTN_STYLUS, input_dev->keybit);
+		__set_bit(BTN_STYLUS2, input_dev->keybit);
+		input_set_abs_params(input_dev, ABS_DISTANCE, 0,
+				      features->distance_max,
+				      0, 0);
+		break;
+	case BAMBOO_PAD:
+		__clear_bit(ABS_MISC, input_dev->absbit);
+		break;
+	}
+	return 0;
+}
 
-			/* PAD is setup by wacom_setup_pad_input_capabilities later */
-			return 1;
-		}
-		if (features->device_type & WACOM_DEVICETYPE_PEN) {
-			__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
-			__set_bit(BTN_TOOL_RUBBER, input_dev->keybit);
-			__set_bit(BTN_TOOL_PEN, input_dev->keybit);
-			__set_bit(BTN_STYLUS, input_dev->keybit);
-			__set_bit(BTN_STYLUS2, input_dev->keybit);
-			input_set_abs_params(input_dev, ABS_DISTANCE, 0,
-					      features->distance_max,
-					      0, 0);
+int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
+					 struct wacom_wac *wacom_wac)
+{
+	struct wacom_features *features = &wacom_wac->features;
+
+	input_dev->evbit[0] |= BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
+
+	if (!(features->device_type & WACOM_DEVICETYPE_TOUCH))
+		return -ENODEV;
+
+	if (features->type == HID_GENERIC)
+		/* setup has already been done */
+		return 0;
+
+	__set_bit(BTN_TOUCH, input_dev->keybit);
+
+	if (features->touch_max == 1) {
+		input_set_abs_params(input_dev, ABS_X, 0,
+			features->x_max, features->x_fuzz, 0);
+		input_set_abs_params(input_dev, ABS_Y, 0,
+			features->y_max, features->y_fuzz, 0);
+		input_abs_set_res(input_dev, ABS_X,
+				  features->x_resolution);
+		input_abs_set_res(input_dev, ABS_Y,
+				  features->y_resolution);
+	}
+	else if (features->touch_max > 1) {
+		input_set_abs_params(input_dev, ABS_MT_POSITION_X, 0,
+			features->x_max, features->x_fuzz, 0);
+		input_set_abs_params(input_dev, ABS_MT_POSITION_Y, 0,
+			features->y_max, features->y_fuzz, 0);
+		input_abs_set_res(input_dev, ABS_MT_POSITION_X,
+				  features->x_resolution);
+		input_abs_set_res(input_dev, ABS_MT_POSITION_Y,
+				  features->y_resolution);
+	}
+
+	switch (features->type) {
+	case INTUOS5:
+	case INTUOS5L:
+	case INTUOSPM:
+	case INTUOSPL:
+	case INTUOS5S:
+	case INTUOSPS:
+		__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
+
+		input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0, features->x_max, 0, 0);
+		input_set_abs_params(input_dev, ABS_MT_TOUCH_MINOR, 0, features->y_max, 0, 0);
+		input_mt_init_slots(input_dev, features->touch_max, INPUT_MT_POINTER);
+		break;
+
+	case WACOM_24HDT:
+		input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0, features->x_max, 0, 0);
+		input_set_abs_params(input_dev, ABS_MT_WIDTH_MAJOR, 0, features->x_max, 0, 0);
+		input_set_abs_params(input_dev, ABS_MT_WIDTH_MINOR, 0, features->y_max, 0, 0);
+		input_set_abs_params(input_dev, ABS_MT_ORIENTATION, 0, 1, 0, 0);
+		/* fall through */
+
+	case WACOM_27QHDT:
+	case MTSCREEN:
+	case MTTPC:
+	case MTTPC_B:
+	case TABLETPC2FG:
+		input_mt_init_slots(input_dev, features->touch_max, INPUT_MT_DIRECT);
+		/*fall through */
+
+	case TABLETPC:
+	case TABLETPCE:
+		__set_bit(INPUT_PROP_DIRECT, input_dev->propbit);
+		break;
+
+	case INTUOSHT:
+		input_dev->evbit[0] |= BIT_MASK(EV_SW);
+		__set_bit(SW_MUTE_DEVICE, input_dev->swbit);
+		/* fall through */
+
+	case BAMBOO_PT:
+		if (features->pktlen == WACOM_PKGLEN_BBTOUCH3) {
+			input_set_abs_params(input_dev,
+				     ABS_MT_TOUCH_MAJOR,
+				     0, features->x_max, 0, 0);
+			input_set_abs_params(input_dev,
+				     ABS_MT_TOUCH_MINOR,
+				     0, features->y_max, 0, 0);
 		}
+		input_mt_init_slots(input_dev, features->touch_max, INPUT_MT_POINTER);
 		break;
+
 	case BAMBOO_PAD:
-		__clear_bit(ABS_MISC, input_dev->absbit);
 		input_mt_init_slots(input_dev, features->touch_max,
 				    INPUT_MT_POINTER);
 		__set_bit(BTN_LEFT, input_dev->keybit);
-- 
2.4.2

