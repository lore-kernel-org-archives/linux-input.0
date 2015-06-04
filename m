From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 2/5] HID: wacom: Treat features->device_type values as flags
Date: Wed,  3 Jun 2015 18:18:14 -0700
Message-ID: <1433380697-28612-3-git-send-email-killertofu@gmail.com>
References: <1433380697-28612-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36771 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753233AbbFDBUd (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Jun 2015 21:20:33 -0400
Received: by pabqy3 with SMTP id qy3so18140253pab.3
        for <linux-input@vger.kernel.org>; Wed, 03 Jun 2015 18:20:33 -0700 (PDT)
In-Reply-To: <1433380697-28612-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

The USB devices that this driver has historically supported segregate the
pen and touch portions of the tablet. Oftentimes the segregation would be
done at the interface level, though on occasion (e.g. Cintiq 24HDT) the
tablet would combine two totally independent USB devices behind an internal
USB hub. Because pen and touch never shared the same interface, it made
sense for the 'device_type' to store a single value: "pen" or "touch".

Recently, however, some I2C devices have been created which combine the
two. A first step to accomodating this is to expand 'device_type' so that
it can represent two (or potentially more) types simultaneously. To do
this, we treat it as a bitfield and set/check individual bits rather
than using the '=' and '==' operators.

This should not result in any functional change since no supported devices
(that I'm aware of, at least) have HID descriptors that indicate both
pen and touch reports on a single interface.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_sys.c | 35 ++++++++++++++++++-----------------
 drivers/hid/wacom_wac.c | 30 +++++++++++++++---------------
 drivers/hid/wacom_wac.h |  5 +++++
 3 files changed, 38 insertions(+), 32 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index bdf31c9..2b4cbd8 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -197,9 +197,9 @@ static void wacom_usage_mapping(struct hid_device *hdev,
 	* values commonly reported.
 	*/
 	if (pen)
-		features->device_type = BTN_TOOL_PEN;
+		features->device_type |= WACOM_DEVICETYPE_PEN;
 	else if (finger)
-		features->device_type = BTN_TOOL_FINGER;
+		features->device_type |= WACOM_DEVICETYPE_TOUCH;
 	else
 		return;
 
@@ -411,7 +411,7 @@ static int wacom_query_tablet_data(struct hid_device *hdev,
 	if (features->type == HID_GENERIC)
 		return wacom_hid_set_device_mode(hdev);
 
-	if (features->device_type == BTN_TOOL_FINGER) {
+	if (features->device_type & WACOM_DEVICETYPE_TOUCH) {
 		if (features->type > TABLETPC) {
 			/* MT Tablet PC touch */
 			return wacom_set_device_mode(hdev, 3, 4, 4);
@@ -425,7 +425,7 @@ static int wacom_query_tablet_data(struct hid_device *hdev,
 		else if (features->type == BAMBOO_PAD) {
 			return wacom_set_device_mode(hdev, 2, 2, 2);
 		}
-	} else if (features->device_type == BTN_TOOL_PEN) {
+	} else if (features->device_type & WACOM_DEVICETYPE_PEN) {
 		if (features->type <= BAMBOO_PT && features->type != WIRELESS) {
 			return wacom_set_device_mode(hdev, 2, 2, 2);
 		}
@@ -454,9 +454,9 @@ static void wacom_retrieve_hid_descriptor(struct hid_device *hdev,
 	 */
 	if (features->type == WIRELESS) {
 		if (intf->cur_altsetting->desc.bInterfaceNumber == 0) {
-			features->device_type = 0;
+			features->device_type = WACOM_DEVICETYPE_NONE;
 		} else if (intf->cur_altsetting->desc.bInterfaceNumber == 2) {
-			features->device_type = BTN_TOOL_FINGER;
+			features->device_type |= WACOM_DEVICETYPE_TOUCH;
 			features->pktlen = WACOM_PKGLEN_BBTOUCH3;
 		}
 	}
@@ -538,9 +538,9 @@ static int wacom_add_shared_data(struct hid_device *hdev)
 
 	wacom_wac->shared = &data->shared;
 
-	if (wacom_wac->features.device_type == BTN_TOOL_FINGER)
+	if (wacom_wac->features.device_type & WACOM_DEVICETYPE_TOUCH)
 		wacom_wac->shared->touch = hdev;
-	else if (wacom_wac->features.device_type == BTN_TOOL_PEN)
+	else if (wacom_wac->features.device_type & WACOM_DEVICETYPE_PEN)
 		wacom_wac->shared->pen = hdev;
 
 out:
@@ -892,7 +892,7 @@ static int wacom_initialize_leds(struct wacom *wacom)
 	case INTUOSPS:
 	case INTUOSPM:
 	case INTUOSPL:
-		if (wacom->wacom_wac.features.device_type == BTN_TOOL_PEN) {
+		if (wacom->wacom_wac.features.device_type & WACOM_DEVICETYPE_PEN) {
 			wacom->led.select[0] = 0;
 			wacom->led.select[1] = 0;
 			wacom->led.llv = 32;
@@ -948,7 +948,7 @@ static void wacom_destroy_leds(struct wacom *wacom)
 	case INTUOSPS:
 	case INTUOSPM:
 	case INTUOSPL:
-		if (wacom->wacom_wac.features.device_type == BTN_TOOL_PEN)
+		if (wacom->wacom_wac.features.device_type & WACOM_DEVICETYPE_PEN)
 			sysfs_remove_group(&wacom->hdev->dev.kobj,
 					   &intuos5_led_attr_group);
 		break;
@@ -1296,7 +1296,7 @@ static void wacom_wireless_work(struct work_struct *work)
 		/* Stylus interface */
 		wacom_wac1->features =
 			*((struct wacom_features *)id->driver_data);
-		wacom_wac1->features.device_type = BTN_TOOL_PEN;
+		wacom_wac1->features.device_type |= WACOM_DEVICETYPE_PEN;
 		snprintf(wacom_wac1->name, WACOM_NAME_MAX, "%s (WL) Pen",
 			 wacom_wac1->features.name);
 		snprintf(wacom_wac1->pad_name, WACOM_NAME_MAX, "%s (WL) Pad",
@@ -1315,7 +1315,7 @@ static void wacom_wireless_work(struct work_struct *work)
 			wacom_wac2->features =
 				*((struct wacom_features *)id->driver_data);
 			wacom_wac2->features.pktlen = WACOM_PKGLEN_BBTOUCH3;
-			wacom_wac2->features.device_type = BTN_TOOL_FINGER;
+			wacom_wac2->features.device_type |= WACOM_DEVICETYPE_TOUCH;
 			wacom_wac2->features.x_max = wacom_wac2->features.y_max = 4096;
 			if (wacom_wac2->features.touch_max)
 				snprintf(wacom_wac2->name, WACOM_NAME_MAX,
@@ -1451,11 +1451,11 @@ static void wacom_update_name(struct wacom *wacom)
 	snprintf(wacom_wac->pad_name, sizeof(wacom_wac->pad_name),
 		"%s Pad", name);
 
-	if (features->device_type == BTN_TOOL_PEN) {
+	if (features->device_type & WACOM_DEVICETYPE_PEN) {
 		snprintf(wacom_wac->name, sizeof(wacom_wac->name),
 			"%s Pen", name);
 	}
-	else if (features->device_type == BTN_TOOL_FINGER) {
+	else if (features->device_type & WACOM_DEVICETYPE_TOUCH) {
 		if (features->touch_max)
 			snprintf(wacom_wac->name, sizeof(wacom_wac->name),
 				"%s Finger", name);
@@ -1545,7 +1545,8 @@ static int wacom_probe(struct hid_device *hdev,
 	wacom_retrieve_hid_descriptor(hdev, features);
 	wacom_setup_device_quirks(wacom);
 
-	if (!features->device_type && features->type != WIRELESS) {
+	if (features->device_type == WACOM_DEVICETYPE_NONE &&
+	    features->type != WIRELESS) {
 		error = features->type == HID_GENERIC ? -ENODEV : 0;
 
 		dev_warn(&hdev->dev, "Unknown device_type for '%s'. %s.",
@@ -1555,7 +1556,7 @@ static int wacom_probe(struct hid_device *hdev,
 		if (error)
 			goto fail_shared_data;
 
-		features->device_type = BTN_TOOL_PEN;
+		features->device_type |= WACOM_DEVICETYPE_PEN;
 	}
 
 	wacom_calculate_res(features);
@@ -1604,7 +1605,7 @@ static int wacom_probe(struct hid_device *hdev,
 		error = hid_hw_open(hdev);
 
 	if (wacom_wac->features.type == INTUOSHT && wacom_wac->features.touch_max) {
-		if (wacom_wac->features.device_type == BTN_TOOL_FINGER)
+		if (wacom_wac->features.device_type & WACOM_DEVICETYPE_TOUCH)
 			wacom_wac->shared->touch_input = wacom_wac->input;
 	}
 
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index a52fc25..5e7710d 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -2168,7 +2168,7 @@ void wacom_setup_device_quirks(struct wacom *wacom)
 	struct wacom_features *features = &wacom->wacom_wac.features;
 
 	/* touch device found but size is not defined. use default */
-	if (features->device_type == BTN_TOOL_FINGER && !features->x_max) {
+	if (features->device_type & WACOM_DEVICETYPE_TOUCH && !features->x_max) {
 		features->x_max = 1023;
 		features->y_max = 1023;
 	}
@@ -2182,7 +2182,7 @@ void wacom_setup_device_quirks(struct wacom *wacom)
 	if ((features->type >= INTUOS5S && features->type <= INTUOSHT) ||
 		(features->type == BAMBOO_PT)) {
 		if (features->pktlen == WACOM_PKGLEN_BBTOUCH3) {
-			features->device_type = BTN_TOOL_FINGER;
+			features->device_type |= WACOM_DEVICETYPE_TOUCH;
 
 			features->x_max = 4096;
 			features->y_max = 4096;
@@ -2197,7 +2197,7 @@ void wacom_setup_device_quirks(struct wacom *wacom)
 	 * so rewrite this one to be of type BTN_TOOL_FINGER.
 	 */
 	if (features->type == BAMBOO_PAD)
-		features->device_type = BTN_TOOL_FINGER;
+		features->device_type |= WACOM_DEVICETYPE_TOUCH;
 
 	if (wacom->hdev->bus == BUS_BLUETOOTH)
 		features->quirks |= WACOM_QUIRK_BATTERY;
@@ -2218,7 +2218,7 @@ void wacom_setup_device_quirks(struct wacom *wacom)
 		features->quirks |= WACOM_QUIRK_NO_INPUT;
 
 		/* must be monitor interface if no device_type set */
-		if (!features->device_type) {
+		if (features->device_type == WACOM_DEVICETYPE_NONE) {
 			features->quirks |= WACOM_QUIRK_MONITOR;
 			features->quirks |= WACOM_QUIRK_BATTERY;
 		}
@@ -2230,7 +2230,7 @@ static void wacom_abs_set_axis(struct input_dev *input_dev,
 {
 	struct wacom_features *features = &wacom_wac->features;
 
-	if (features->device_type == BTN_TOOL_PEN) {
+	if (features->device_type & WACOM_DEVICETYPE_PEN) {
 		input_set_abs_params(input_dev, ABS_X, features->x_min,
 				     features->x_max, features->x_fuzz, 0);
 		input_set_abs_params(input_dev, ABS_Y, features->y_min,
@@ -2349,7 +2349,7 @@ int wacom_setup_pentouch_input_capabilities(struct input_dev *input_dev,
 	case INTUOSPS:
 		__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
 
-		if (features->device_type == BTN_TOOL_PEN) {
+		if (features->device_type & WACOM_DEVICETYPE_PEN) {
 			input_set_abs_params(input_dev, ABS_DISTANCE, 0,
 					      features->distance_max,
 					      0, 0);
@@ -2358,7 +2358,7 @@ int wacom_setup_pentouch_input_capabilities(struct input_dev *input_dev,
 			input_abs_set_res(input_dev, ABS_Z, 287);
 
 			wacom_setup_intuos(wacom_wac);
-		} else if (features->device_type == BTN_TOOL_FINGER) {
+		} else if (features->device_type & WACOM_DEVICETYPE_TOUCH) {
 			__clear_bit(ABS_MISC, input_dev->absbit);
 
 			input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR,
@@ -2370,7 +2370,7 @@ int wacom_setup_pentouch_input_capabilities(struct input_dev *input_dev,
 		break;
 
 	case WACOM_24HDT:
-		if (features->device_type == BTN_TOOL_FINGER) {
+		if (features->device_type & WACOM_DEVICETYPE_TOUCH) {
 			input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0, features->x_max, 0, 0);
 			input_set_abs_params(input_dev, ABS_MT_WIDTH_MAJOR, 0, features->x_max, 0, 0);
 			input_set_abs_params(input_dev, ABS_MT_WIDTH_MINOR, 0, features->y_max, 0, 0);
@@ -2383,7 +2383,7 @@ int wacom_setup_pentouch_input_capabilities(struct input_dev *input_dev,
 	case MTTPC:
 	case MTTPC_B:
 	case TABLETPC2FG:
-		if (features->device_type == BTN_TOOL_FINGER && features->touch_max > 1)
+		if (features->device_type & WACOM_DEVICETYPE_TOUCH && features->touch_max > 1)
 			input_mt_init_slots(input_dev, features->touch_max, INPUT_MT_DIRECT);
 		/* fall through */
 
@@ -2393,7 +2393,7 @@ int wacom_setup_pentouch_input_capabilities(struct input_dev *input_dev,
 
 		__set_bit(INPUT_PROP_DIRECT, input_dev->propbit);
 
-		if (features->device_type != BTN_TOOL_PEN)
+		if (!(features->device_type & WACOM_DEVICETYPE_PEN))
 			break;  /* no need to process stylus stuff */
 
 		/* fall through */
@@ -2424,7 +2424,7 @@ int wacom_setup_pentouch_input_capabilities(struct input_dev *input_dev,
 
 	case INTUOSHT:
 		if (features->touch_max &&
-		    features->device_type == BTN_TOOL_FINGER) {
+		    features->device_type & WACOM_DEVICETYPE_TOUCH) {
 			input_dev->evbit[0] |= BIT_MASK(EV_SW);
 			__set_bit(SW_MUTE_DEVICE, input_dev->swbit);
 		}
@@ -2433,7 +2433,7 @@ int wacom_setup_pentouch_input_capabilities(struct input_dev *input_dev,
 	case BAMBOO_PT:
 		__clear_bit(ABS_MISC, input_dev->absbit);
 
-		if (features->device_type == BTN_TOOL_FINGER) {
+		if (features->device_type & WACOM_DEVICETYPE_TOUCH) {
 
 			if (features->touch_max) {
 				if (features->pktlen == WACOM_PKGLEN_BBTOUCH3) {
@@ -2454,7 +2454,7 @@ int wacom_setup_pentouch_input_capabilities(struct input_dev *input_dev,
 				/* PAD is setup by wacom_setup_pad_input_capabilities later */
 				return 1;
 			}
-		} else if (features->device_type == BTN_TOOL_PEN) {
+		} else if (features->device_type & WACOM_DEVICETYPE_PEN) {
 			__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
 			__set_bit(BTN_TOOL_RUBBER, input_dev->keybit);
 			__set_bit(BTN_TOOL_PEN, input_dev->keybit);
@@ -2619,7 +2619,7 @@ int wacom_setup_pad_input_capabilities(struct input_dev *input_dev,
 	case INTUOS5S:
 	case INTUOSPS:
 		/* touch interface does not have the pad device */
-		if (features->device_type != BTN_TOOL_PEN)
+		if (!(features->device_type & WACOM_DEVICETYPE_PEN))
 			return -ENODEV;
 
 		for (i = 0; i < 7; i++)
@@ -2664,7 +2664,7 @@ int wacom_setup_pad_input_capabilities(struct input_dev *input_dev,
 	case INTUOSHT:
 	case BAMBOO_PT:
 		/* pad device is on the touch interface */
-		if ((features->device_type != BTN_TOOL_FINGER) ||
+		if (!(features->device_type & WACOM_DEVICETYPE_TOUCH) ||
 		    /* Bamboo Pen only tablet does not have pad */
 		    ((features->type == BAMBOO_PT) && !features->touch_max))
 			return -ENODEV;
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index 9a5ee62..da2b309 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -72,6 +72,11 @@
 #define WACOM_QUIRK_MONITOR		0x0004
 #define WACOM_QUIRK_BATTERY		0x0008
 
+/* device types */
+#define WACOM_DEVICETYPE_NONE           0x0000
+#define WACOM_DEVICETYPE_PEN            0x0001
+#define WACOM_DEVICETYPE_TOUCH          0x0002
+
 #define WACOM_VENDORDEFINED_PEN		0xff0d0001
 
 #define WACOM_PEN_FIELD(f)	(((f)->logical == HID_DG_STYLUS) || \
-- 
2.4.1

