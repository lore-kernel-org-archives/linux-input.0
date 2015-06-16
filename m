From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH v2 3/5] HID: wacom: Introduce a new WACOM_DEVICETYPE_PAD device_type
Date: Mon, 15 Jun 2015 18:01:43 -0700
Message-ID: <1434416505-12685-3-git-send-email-killertofu@gmail.com>
References: <1434416505-12685-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:36422 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750989AbbFPBCH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Jun 2015 21:02:07 -0400
Received: by pdjm12 with SMTP id m12so1845394pdj.3
        for <linux-input@vger.kernel.org>; Mon, 15 Jun 2015 18:02:06 -0700 (PDT)
In-Reply-To: <1434416505-12685-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

Historically, both the touch and pad tools would have shared the
'BTN_TOOL_FINGER' type. Any time you needed to distinguish the two, you
had to use some other bit of knowledge (e.g. that the pad was on the same
interface as the pen, and thus 'touch_max' would be zero).

To make these checks more readable, we introduce WACOM_DEVICETYPE_PAD.
Although we still have to rely on other bits of knowledge to set this
bit on the right interface (since it cannot be detected from the HID
descriptor), it can be done just once inside 'wacom_setup_device_quirks'.

This patch introduces no functional changes.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
Changes from v1:
 * Correct conditions under which 'wacom_wireless_work' sets the
   pad device type flag. Fixes issue with some pad devices not
   showing up and others crashing.

 * Set pad/touch flags for INTUOSHT and BAMBOO_PT inside the block
   of 'wacom_setup_device_quirks' which handles them. Ensures types
   are properly set on the devices before we get too far.

 drivers/hid/wacom_sys.c | 65 +++++++++++++++++++++++---------------------
 drivers/hid/wacom_wac.c | 71 ++++++++++++++++++++++++++-----------------------
 drivers/hid/wacom_wac.h |  1 +
 3 files changed, 73 insertions(+), 64 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 2b4cbd8..aaa9c84 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -859,6 +859,9 @@ static int wacom_initialize_leds(struct wacom *wacom)
 {
 	int error;
 
+	if (!(wacom->wacom_wac.features.device_type & WACOM_DEVICETYPE_PAD))
+		return 0;
+
 	/* Initialize default values */
 	switch (wacom->wacom_wac.features.type) {
 	case INTUOS4S:
@@ -892,17 +895,14 @@ static int wacom_initialize_leds(struct wacom *wacom)
 	case INTUOSPS:
 	case INTUOSPM:
 	case INTUOSPL:
-		if (wacom->wacom_wac.features.device_type & WACOM_DEVICETYPE_PEN) {
-			wacom->led.select[0] = 0;
-			wacom->led.select[1] = 0;
-			wacom->led.llv = 32;
-			wacom->led.hlv = 0;
-			wacom->led.img_lum = 0;
-
-			error = sysfs_create_group(&wacom->hdev->dev.kobj,
-						  &intuos5_led_attr_group);
-		} else
-			return 0;
+		wacom->led.select[0] = 0;
+		wacom->led.select[1] = 0;
+		wacom->led.llv = 32;
+		wacom->led.hlv = 0;
+		wacom->led.img_lum = 0;
+
+		error = sysfs_create_group(&wacom->hdev->dev.kobj,
+					  &intuos5_led_attr_group);
 		break;
 
 	default:
@@ -925,6 +925,9 @@ static void wacom_destroy_leds(struct wacom *wacom)
 	if (!wacom->led_initialized)
 		return;
 
+	if (!(wacom->wacom_wac.features.device_type & WACOM_DEVICETYPE_PAD))
+		return;
+
 	wacom->led_initialized = false;
 
 	switch (wacom->wacom_wac.features.type) {
@@ -948,9 +951,8 @@ static void wacom_destroy_leds(struct wacom *wacom)
 	case INTUOSPS:
 	case INTUOSPM:
 	case INTUOSPL:
-		if (wacom->wacom_wac.features.device_type & WACOM_DEVICETYPE_PEN)
-			sysfs_remove_group(&wacom->hdev->dev.kobj,
-					   &intuos5_led_attr_group);
+		sysfs_remove_group(&wacom->hdev->dev.kobj,
+				   &intuos5_led_attr_group);
 		break;
 	}
 }
@@ -1297,6 +1299,9 @@ static void wacom_wireless_work(struct work_struct *work)
 		wacom_wac1->features =
 			*((struct wacom_features *)id->driver_data);
 		wacom_wac1->features.device_type |= WACOM_DEVICETYPE_PEN;
+		if (wacom_wac1->features.type != INTUOSHT &&
+		    wacom_wac1->features.type != BAMBOO_PT)
+			wacom_wac1->features.device_type |= WACOM_DEVICETYPE_PAD;
 		snprintf(wacom_wac1->name, WACOM_NAME_MAX, "%s (WL) Pen",
 			 wacom_wac1->features.name);
 		snprintf(wacom_wac1->pad_name, WACOM_NAME_MAX, "%s (WL) Pad",
@@ -1315,16 +1320,16 @@ static void wacom_wireless_work(struct work_struct *work)
 			wacom_wac2->features =
 				*((struct wacom_features *)id->driver_data);
 			wacom_wac2->features.pktlen = WACOM_PKGLEN_BBTOUCH3;
-			wacom_wac2->features.device_type |= WACOM_DEVICETYPE_TOUCH;
 			wacom_wac2->features.x_max = wacom_wac2->features.y_max = 4096;
-			if (wacom_wac2->features.touch_max)
-				snprintf(wacom_wac2->name, WACOM_NAME_MAX,
-					 "%s (WL) Finger",wacom_wac2->features.name);
-			else
-				snprintf(wacom_wac2->name, WACOM_NAME_MAX,
-					 "%s (WL) Pad",wacom_wac2->features.name);
+			snprintf(wacom_wac2->name, WACOM_NAME_MAX,
+				 "%s (WL) Finger",wacom_wac2->features.name);
 			snprintf(wacom_wac2->pad_name, WACOM_NAME_MAX,
-				 "%s (WL) Pad", wacom_wac2->features.name);
+				 "%s (WL) Pad",wacom_wac2->features.name);
+			if (wacom_wac1->features.touch_max)
+				wacom_wac2->features.device_type |= WACOM_DEVICETYPE_TOUCH;
+			if (wacom_wac1->features.type == INTUOSHT ||
+			    wacom_wac1->features.type == BAMBOO_PT)
+				wacom_wac2->features.device_type |= WACOM_DEVICETYPE_PAD;
 			wacom_wac2->pid = wacom_wac->pid;
 			error = wacom_allocate_inputs(wacom2) ||
 				wacom_register_inputs(wacom2);
@@ -1456,12 +1461,12 @@ static void wacom_update_name(struct wacom *wacom)
 			"%s Pen", name);
 	}
 	else if (features->device_type & WACOM_DEVICETYPE_TOUCH) {
-		if (features->touch_max)
-			snprintf(wacom_wac->name, sizeof(wacom_wac->name),
-				"%s Finger", name);
-		else
-			snprintf(wacom_wac->name, sizeof(wacom_wac->name),
-				"%s Pad", name);
+		snprintf(wacom_wac->name, sizeof(wacom_wac->name),
+			"%s Finger", name);
+	}
+	else if (features->device_type & WACOM_DEVICETYPE_PAD) {
+		snprintf(wacom_wac->name, sizeof(wacom_wac->name),
+			"%s Pad", name);
 	}
 }
 
@@ -1604,8 +1609,8 @@ static int wacom_probe(struct hid_device *hdev,
 	if (features->quirks & WACOM_QUIRK_MONITOR)
 		error = hid_hw_open(hdev);
 
-	if (wacom_wac->features.type == INTUOSHT && wacom_wac->features.touch_max) {
-		if (wacom_wac->features.device_type & WACOM_DEVICETYPE_TOUCH)
+	if (wacom_wac->features.type == INTUOSHT && 
+	    wacom_wac->features.device_type & WACOM_DEVICETYPE_TOUCH) {
 			wacom_wac->shared->touch_input = wacom_wac->input;
 	}
 
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 5e7710d..564a06d 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -2167,6 +2167,15 @@ void wacom_setup_device_quirks(struct wacom *wacom)
 {
 	struct wacom_features *features = &wacom->wacom_wac.features;
 
+	/* The pen and pad share the same interface on most devices */
+	if (features->type == GRAPHIRE_BT || features->type == WACOM_G4 ||
+	    features->type == DTUS || features->type == WACOM_MO ||
+	    (features->type >= INTUOS3S && features->type <= WACOM_13HD && 
+	     features->type != INTUOSHT)) {
+		if (features->device_type & WACOM_DEVICETYPE_PEN)
+			features->device_type |= WACOM_DEVICETYPE_PAD;
+	}
+
 	/* touch device found but size is not defined. use default */
 	if (features->device_type & WACOM_DEVICETYPE_TOUCH && !features->x_max) {
 		features->x_max = 1023;
@@ -2182,7 +2191,10 @@ void wacom_setup_device_quirks(struct wacom *wacom)
 	if ((features->type >= INTUOS5S && features->type <= INTUOSHT) ||
 		(features->type == BAMBOO_PT)) {
 		if (features->pktlen == WACOM_PKGLEN_BBTOUCH3) {
-			features->device_type |= WACOM_DEVICETYPE_TOUCH;
+			if (features->touch_max)
+				features->device_type |= WACOM_DEVICETYPE_TOUCH;
+			if (features->type == BAMBOO_PT || features->type == INTUOSHT)
+				features->device_type |= WACOM_DEVICETYPE_PAD;
 
 			features->x_max = 4096;
 			features->y_max = 4096;
@@ -2241,7 +2253,7 @@ static void wacom_abs_set_axis(struct input_dev *input_dev,
 		/* penabled devices have fixed resolution for each model */
 		input_abs_set_res(input_dev, ABS_X, features->x_resolution);
 		input_abs_set_res(input_dev, ABS_Y, features->y_resolution);
-	} else {
+	} else if (features->device_type & WACOM_DEVICETYPE_TOUCH) {
 		if (features->touch_max == 1) {
 			input_set_abs_params(input_dev, ABS_X, 0,
 				features->x_max, features->x_fuzz, 0);
@@ -2423,8 +2435,7 @@ int wacom_setup_pentouch_input_capabilities(struct input_dev *input_dev,
 		break;
 
 	case INTUOSHT:
-		if (features->touch_max &&
-		    features->device_type & WACOM_DEVICETYPE_TOUCH) {
+		if (features->device_type & WACOM_DEVICETYPE_TOUCH) {
 			input_dev->evbit[0] |= BIT_MASK(EV_SW);
 			__set_bit(SW_MUTE_DEVICE, input_dev->swbit);
 		}
@@ -2434,27 +2445,26 @@ int wacom_setup_pentouch_input_capabilities(struct input_dev *input_dev,
 		__clear_bit(ABS_MISC, input_dev->absbit);
 
 		if (features->device_type & WACOM_DEVICETYPE_TOUCH) {
-
-			if (features->touch_max) {
-				if (features->pktlen == WACOM_PKGLEN_BBTOUCH3) {
-					input_set_abs_params(input_dev,
-						     ABS_MT_TOUCH_MAJOR,
-						     0, features->x_max, 0, 0);
-					input_set_abs_params(input_dev,
-						     ABS_MT_TOUCH_MINOR,
-						     0, features->y_max, 0, 0);
-				}
-				input_mt_init_slots(input_dev, features->touch_max, INPUT_MT_POINTER);
-			} else {
-				/* buttons/keys only interface */
-				__clear_bit(ABS_X, input_dev->absbit);
-				__clear_bit(ABS_Y, input_dev->absbit);
-				__clear_bit(BTN_TOUCH, input_dev->keybit);
-
-				/* PAD is setup by wacom_setup_pad_input_capabilities later */
-				return 1;
+			if (features->pktlen == WACOM_PKGLEN_BBTOUCH3) {
+				input_set_abs_params(input_dev,
+					     ABS_MT_TOUCH_MAJOR,
+					     0, features->x_max, 0, 0);
+				input_set_abs_params(input_dev,
+					     ABS_MT_TOUCH_MINOR,
+					     0, features->y_max, 0, 0);
 			}
-		} else if (features->device_type & WACOM_DEVICETYPE_PEN) {
+			input_mt_init_slots(input_dev, features->touch_max, INPUT_MT_POINTER);
+		}
+		if (features->device_type & WACOM_DEVICETYPE_PAD) {
+			/* buttons/keys only interface */
+			__clear_bit(ABS_X, input_dev->absbit);
+			__clear_bit(ABS_Y, input_dev->absbit);
+			__clear_bit(BTN_TOUCH, input_dev->keybit);
+
+			/* PAD is setup by wacom_setup_pad_input_capabilities later */
+			return 1;
+		}
+		if (features->device_type & WACOM_DEVICETYPE_PEN) {
 			__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
 			__set_bit(BTN_TOOL_RUBBER, input_dev->keybit);
 			__set_bit(BTN_TOOL_PEN, input_dev->keybit);
@@ -2482,6 +2492,9 @@ int wacom_setup_pad_input_capabilities(struct input_dev *input_dev,
 	struct wacom_features *features = &wacom_wac->features;
 	int i;
 
+	if (!(features->device_type & WACOM_DEVICETYPE_PAD))
+		return -ENODEV;
+
 	input_dev->evbit[0] |= BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
 
 	/* kept for making legacy xf86-input-wacom working with the wheels */
@@ -2618,10 +2631,6 @@ int wacom_setup_pad_input_capabilities(struct input_dev *input_dev,
 
 	case INTUOS5S:
 	case INTUOSPS:
-		/* touch interface does not have the pad device */
-		if (!(features->device_type & WACOM_DEVICETYPE_PEN))
-			return -ENODEV;
-
 		for (i = 0; i < 7; i++)
 			__set_bit(BTN_0 + i, input_dev->keybit);
 
@@ -2663,12 +2672,6 @@ int wacom_setup_pad_input_capabilities(struct input_dev *input_dev,
 
 	case INTUOSHT:
 	case BAMBOO_PT:
-		/* pad device is on the touch interface */
-		if (!(features->device_type & WACOM_DEVICETYPE_TOUCH) ||
-		    /* Bamboo Pen only tablet does not have pad */
-		    ((features->type == BAMBOO_PT) && !features->touch_max))
-			return -ENODEV;
-
 		__clear_bit(ABS_MISC, input_dev->absbit);
 
 		__set_bit(BTN_LEFT, input_dev->keybit);
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index da2b309..c873c9f 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -76,6 +76,7 @@
 #define WACOM_DEVICETYPE_NONE           0x0000
 #define WACOM_DEVICETYPE_PEN            0x0001
 #define WACOM_DEVICETYPE_TOUCH          0x0002
+#define WACOM_DEVICETYPE_PAD            0x0004
 
 #define WACOM_VENDORDEFINED_PEN		0xff0d0001
 
-- 
2.4.2

