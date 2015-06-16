From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH v2 5/5] HID: wacom: Introduce new 'touch_input' device
Date: Mon, 15 Jun 2015 18:01:45 -0700
Message-ID: <1434416505-12685-5-git-send-email-killertofu@gmail.com>
References: <1434416505-12685-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:35070 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730AbbFPBCL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Jun 2015 21:02:11 -0400
Received: by pdbnf5 with SMTP id nf5so1882117pdb.2
        for <linux-input@vger.kernel.org>; Mon, 15 Jun 2015 18:02:11 -0700 (PDT)
In-Reply-To: <1434416505-12685-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

Instead of having a single 'input_dev' device that will take either pen
or touch data depending on the type of the device, create seperate devices
devices for each. By splitting things like this, we can support devices
(e.g. the I2C "AES" sensors in some newer tablet PCs) that send both pen
and touch reports from a single endpoint.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
Changes from v1:
 * Fixed mis-named devices ("Pad" -> "Pen"; "Touch" -> "Finger")

 * Do not update touch state in 'wacom_bpt3_touch' unless a touchpad
   is actually present.

 * In 'wacom_wireless_work' and 'wacom_probe', have 'wacom_wac->shared->touch_input'
   point to the touch input instead of the pen input.

 drivers/hid/wacom_sys.c | 116 +++++++++++++++++++++++++++++-------------------
 drivers/hid/wacom_wac.c | 115 +++++++++++++++++++++++++----------------------
 drivers/hid/wacom_wac.h |   9 ++--
 3 files changed, 139 insertions(+), 101 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index ca15c7f..4c0ffca 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -253,7 +253,7 @@ static void wacom_post_parse_hid(struct hid_device *hdev,
 	if (features->type == HID_GENERIC) {
 		/* Any last-minute generic device setup */
 		if (features->touch_max > 1) {
-			input_mt_init_slots(wacom_wac->input, wacom_wac->features.touch_max,
+			input_mt_init_slots(wacom_wac->touch_input, wacom_wac->features.touch_max,
 				    INPUT_MT_DIRECT);
 		}
 	}
@@ -1130,7 +1130,7 @@ static struct input_dev *wacom_allocate_input(struct wacom *wacom)
 	if (!input_dev)
 		return NULL;
 
-	input_dev->name = wacom_wac->name;
+	input_dev->name = wacom_wac->pen_name;
 	input_dev->phys = hdev->phys;
 	input_dev->dev.parent = &hdev->dev;
 	input_dev->open = wacom_open;
@@ -1149,27 +1149,33 @@ static void wacom_free_inputs(struct wacom *wacom)
 {
 	struct wacom_wac *wacom_wac = &(wacom->wacom_wac);
 
-	if (wacom_wac->input)
-		input_free_device(wacom_wac->input);
+	if (wacom_wac->pen_input)
+		input_free_device(wacom_wac->pen_input);
+	if (wacom_wac->touch_input)
+		input_free_device(wacom_wac->touch_input);
 	if (wacom_wac->pad_input)
 		input_free_device(wacom_wac->pad_input);
-	wacom_wac->input = NULL;
+	wacom_wac->pen_input = NULL;
+	wacom_wac->touch_input = NULL;
 	wacom_wac->pad_input = NULL;
 }
 
 static int wacom_allocate_inputs(struct wacom *wacom)
 {
-	struct input_dev *input_dev, *pad_input_dev;
+	struct input_dev *pen_input_dev, *touch_input_dev, *pad_input_dev;
 	struct wacom_wac *wacom_wac = &(wacom->wacom_wac);
 
-	input_dev = wacom_allocate_input(wacom);
+	pen_input_dev = wacom_allocate_input(wacom);
+	touch_input_dev = wacom_allocate_input(wacom);
 	pad_input_dev = wacom_allocate_input(wacom);
-	if (!input_dev || !pad_input_dev) {
+	if (!pen_input_dev || !touch_input_dev || !pad_input_dev) {
 		wacom_free_inputs(wacom);
 		return -ENOMEM;
 	}
 
-	wacom_wac->input = input_dev;
+	wacom_wac->pen_input = pen_input_dev;
+	wacom_wac->touch_input = touch_input_dev;
+	wacom_wac->touch_input->name = wacom_wac->touch_name;
 	wacom_wac->pad_input = pad_input_dev;
 	wacom_wac->pad_input->name = wacom_wac->pad_name;
 
@@ -1178,11 +1184,17 @@ static int wacom_allocate_inputs(struct wacom *wacom)
 
 static void wacom_clean_inputs(struct wacom *wacom)
 {
-	if (wacom->wacom_wac.input) {
-		if (wacom->wacom_wac.input_registered)
-			input_unregister_device(wacom->wacom_wac.input);
+	if (wacom->wacom_wac.pen_input) {
+		if (wacom->wacom_wac.pen_registered)
+			input_unregister_device(wacom->wacom_wac.pen_input);
 		else
-			input_free_device(wacom->wacom_wac.input);
+			input_free_device(wacom->wacom_wac.pen_input);
+	}
+	if (wacom->wacom_wac.touch_input) {
+		if (wacom->wacom_wac.touch_registered)
+			input_unregister_device(wacom->wacom_wac.touch_input);
+		else
+			input_free_device(wacom->wacom_wac.touch_input);
 	}
 	if (wacom->wacom_wac.pad_input) {
 		if (wacom->wacom_wac.pad_registered)
@@ -1190,33 +1202,49 @@ static void wacom_clean_inputs(struct wacom *wacom)
 		else
 			input_free_device(wacom->wacom_wac.pad_input);
 	}
-	wacom->wacom_wac.input = NULL;
+	wacom->wacom_wac.pen_input = NULL;
+	wacom->wacom_wac.touch_input = NULL;
 	wacom->wacom_wac.pad_input = NULL;
 	wacom_destroy_leds(wacom);
 }
 
 static int wacom_register_inputs(struct wacom *wacom)
 {
-	struct input_dev *input_dev, *pad_input_dev;
+	struct input_dev *pen_input_dev, *touch_input_dev, *pad_input_dev;
 	struct wacom_wac *wacom_wac = &(wacom->wacom_wac);
-	struct wacom_features *features = &wacom_wac->features;
 	int error = 0;
 
-	input_dev = wacom_wac->input;
+	pen_input_dev = wacom_wac->pen_input;
+	touch_input_dev = wacom_wac->touch_input;
 	pad_input_dev = wacom_wac->pad_input;
 
-	if (!input_dev || !pad_input_dev)
+	if (!pen_input_dev || !touch_input_dev || !pad_input_dev)
 		return -EINVAL;
 
-	if (features->device_type & WACOM_DEVICETYPE_PEN)
-		error = wacom_setup_pen_input_capabilities(input_dev, wacom_wac);
-	if (!error && features->device_type & WACOM_DEVICETYPE_TOUCH)
-		error = wacom_setup_touch_input_capabilities(input_dev, wacom_wac);
-	if (!error) {
-		error = input_register_device(input_dev);
+	error = wacom_setup_pen_input_capabilities(pen_input_dev, wacom_wac);
+	if (error) {
+		/* no pen in use on this interface */
+		input_free_device(pen_input_dev);
+		wacom_wac->pen_input = NULL;
+		pen_input_dev = NULL;
+	} else {
+		error = input_register_device(pen_input_dev);
+		if (error)
+			goto fail_register_pen_input;
+		wacom_wac->pen_registered = true;
+	}
+
+	error = wacom_setup_touch_input_capabilities(touch_input_dev, wacom_wac);
+	if (error) {
+		/* no touch in use on this interface */
+		input_free_device(touch_input_dev);
+		wacom_wac->touch_input = NULL;
+		touch_input_dev = NULL;
+	} else {
+		error = input_register_device(touch_input_dev);
 		if (error)
-			return error;
-		wacom_wac->input_registered = true;
+			goto fail_register_touch_input;
+		wacom_wac->touch_registered = true;
 	}
 
 	error = wacom_setup_pad_input_capabilities(pad_input_dev, wacom_wac);
@@ -1243,9 +1271,14 @@ fail_leds:
 	pad_input_dev = NULL;
 	wacom_wac->pad_registered = false;
 fail_register_pad_input:
-	input_unregister_device(input_dev);
-	wacom_wac->input = NULL;
-	wacom_wac->input_registered = false;
+	input_unregister_device(touch_input_dev);
+	wacom_wac->touch_input = NULL;
+	wacom_wac->touch_registered = false;
+fail_register_touch_input:
+	input_unregister_device(pen_input_dev);
+	wacom_wac->pen_input = NULL;
+	wacom_wac->pen_registered = false;
+fail_register_pen_input:
 	return error;
 }
 
@@ -1306,7 +1339,7 @@ static void wacom_wireless_work(struct work_struct *work)
 		if (wacom_wac1->features.type != INTUOSHT &&
 		    wacom_wac1->features.type != BAMBOO_PT)
 			wacom_wac1->features.device_type |= WACOM_DEVICETYPE_PAD;
-		snprintf(wacom_wac1->name, WACOM_NAME_MAX, "%s (WL) Pen",
+		snprintf(wacom_wac1->pen_name, WACOM_NAME_MAX, "%s (WL) Pen",
 			 wacom_wac1->features.name);
 		snprintf(wacom_wac1->pad_name, WACOM_NAME_MAX, "%s (WL) Pad",
 			 wacom_wac1->features.name);
@@ -1325,7 +1358,7 @@ static void wacom_wireless_work(struct work_struct *work)
 				*((struct wacom_features *)id->driver_data);
 			wacom_wac2->features.pktlen = WACOM_PKGLEN_BBTOUCH3;
 			wacom_wac2->features.x_max = wacom_wac2->features.y_max = 4096;
-			snprintf(wacom_wac2->name, WACOM_NAME_MAX,
+			snprintf(wacom_wac2->touch_name, WACOM_NAME_MAX,
 				 "%s (WL) Finger",wacom_wac2->features.name);
 			snprintf(wacom_wac2->pad_name, WACOM_NAME_MAX,
 				 "%s (WL) Pad",wacom_wac2->features.name);
@@ -1342,7 +1375,7 @@ static void wacom_wireless_work(struct work_struct *work)
 
 			if (wacom_wac1->features.type == INTUOSHT &&
 			    wacom_wac1->features.touch_max)
-				wacom_wac->shared->touch_input = wacom_wac2->input;
+				wacom_wac->shared->touch_input = wacom_wac2->touch_input;
 		}
 
 		error = wacom_initialize_battery(wacom);
@@ -1457,21 +1490,12 @@ static void wacom_update_name(struct wacom *wacom)
 	}
 
 	/* Append the device type to the name */
+	snprintf(wacom_wac->pen_name, sizeof(wacom_wac->pen_name),
+		"%s Pen", name);
+	snprintf(wacom_wac->touch_name, sizeof(wacom_wac->touch_name),
+		"%s Finger", name);
 	snprintf(wacom_wac->pad_name, sizeof(wacom_wac->pad_name),
 		"%s Pad", name);
-
-	if (features->device_type & WACOM_DEVICETYPE_PEN) {
-		snprintf(wacom_wac->name, sizeof(wacom_wac->name),
-			"%s Pen", name);
-	}
-	else if (features->device_type & WACOM_DEVICETYPE_TOUCH) {
-		snprintf(wacom_wac->name, sizeof(wacom_wac->name),
-			"%s Finger", name);
-	}
-	else if (features->device_type & WACOM_DEVICETYPE_PAD) {
-		snprintf(wacom_wac->name, sizeof(wacom_wac->name),
-			"%s Pad", name);
-	}
 }
 
 static int wacom_probe(struct hid_device *hdev,
@@ -1615,7 +1639,7 @@ static int wacom_probe(struct hid_device *hdev,
 
 	if (wacom_wac->features.type == INTUOSHT && 
 	    wacom_wac->features.device_type & WACOM_DEVICETYPE_TOUCH) {
-			wacom_wac->shared->touch_input = wacom_wac->input;
+			wacom_wac->shared->touch_input = wacom_wac->touch_input;
 	}
 
 	return 0;
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index b80a67a..d811e87 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -69,7 +69,7 @@ static void wacom_notify_battery(struct wacom_wac *wacom_wac,
 static int wacom_penpartner_irq(struct wacom_wac *wacom)
 {
 	unsigned char *data = wacom->data;
-	struct input_dev *input = wacom->input;
+	struct input_dev *input = wacom->pen_input;
 
 	switch (data[0]) {
 	case 1:
@@ -114,7 +114,7 @@ static int wacom_pl_irq(struct wacom_wac *wacom)
 {
 	struct wacom_features *features = &wacom->features;
 	unsigned char *data = wacom->data;
-	struct input_dev *input = wacom->input;
+	struct input_dev *input = wacom->pen_input;
 	int prox, pressure;
 
 	if (data[0] != WACOM_REPORT_PENABLED) {
@@ -186,7 +186,7 @@ static int wacom_pl_irq(struct wacom_wac *wacom)
 static int wacom_ptu_irq(struct wacom_wac *wacom)
 {
 	unsigned char *data = wacom->data;
-	struct input_dev *input = wacom->input;
+	struct input_dev *input = wacom->pen_input;
 
 	if (data[0] != WACOM_REPORT_PENABLED) {
 		dev_dbg(input->dev.parent,
@@ -215,7 +215,7 @@ static int wacom_ptu_irq(struct wacom_wac *wacom)
 static int wacom_dtu_irq(struct wacom_wac *wacom)
 {
 	unsigned char *data = wacom->data;
-	struct input_dev *input = wacom->input;
+	struct input_dev *input = wacom->pen_input;
 	int prox = data[1] & 0x20;
 
 	dev_dbg(input->dev.parent,
@@ -245,7 +245,7 @@ static int wacom_dtu_irq(struct wacom_wac *wacom)
 static int wacom_dtus_irq(struct wacom_wac *wacom)
 {
 	char *data = wacom->data;
-	struct input_dev *input = wacom->input;
+	struct input_dev *input = wacom->pen_input;
 	unsigned short prox, pressure = 0;
 
 	if (data[0] != WACOM_REPORT_DTUS && data[0] != WACOM_REPORT_DTUSPAD) {
@@ -297,7 +297,7 @@ static int wacom_graphire_irq(struct wacom_wac *wacom)
 {
 	struct wacom_features *features = &wacom->features;
 	unsigned char *data = wacom->data;
-	struct input_dev *input = wacom->input;
+	struct input_dev *input = wacom->pen_input;
 	struct input_dev *pad_input = wacom->pad_input;
 	int battery_capacity, ps_connected;
 	int prox;
@@ -464,7 +464,7 @@ static int wacom_intuos_inout(struct wacom_wac *wacom)
 {
 	struct wacom_features *features = &wacom->features;
 	unsigned char *data = wacom->data;
-	struct input_dev *input = wacom->input;
+	struct input_dev *input = wacom->pen_input;
 	int idx = 0;
 
 	/* tool number */
@@ -649,7 +649,7 @@ static void wacom_intuos_general(struct wacom_wac *wacom)
 {
 	struct wacom_features *features = &wacom->features;
 	unsigned char *data = wacom->data;
-	struct input_dev *input = wacom->input;
+	struct input_dev *input = wacom->pen_input;
 	unsigned int t;
 
 	/* general pen packet */
@@ -681,7 +681,7 @@ static int wacom_intuos_irq(struct wacom_wac *wacom)
 {
 	struct wacom_features *features = &wacom->features;
 	unsigned char *data = wacom->data;
-	struct input_dev *input = wacom->input;
+	struct input_dev *input = wacom->pen_input;
 	unsigned int t;
 	int idx = 0, result;
 
@@ -1025,7 +1025,7 @@ static void wacom_intuos_bt_process_data(struct wacom_wac *wacom,
 	memcpy(wacom->data, data, 10);
 	wacom_intuos_irq(wacom);
 
-	input_sync(wacom->input);
+	input_sync(wacom->pen_input);
 	if (wacom->pad_input)
 		input_sync(wacom->pad_input);
 }
@@ -1057,7 +1057,7 @@ static int wacom_intuos_bt_irq(struct wacom_wac *wacom, size_t len)
 				     ps_connected);
 		break;
 	default:
-		dev_dbg(wacom->input->dev.parent,
+		dev_dbg(wacom->pen_input->dev.parent,
 				"Unknown report: %d,%d size:%zu\n",
 				data[0], data[1], len);
 		return 0;
@@ -1067,7 +1067,7 @@ static int wacom_intuos_bt_irq(struct wacom_wac *wacom, size_t len)
 
 static int wacom_wac_finger_count_touches(struct wacom_wac *wacom)
 {
-	struct input_dev *input = wacom->input;
+	struct input_dev *input = wacom->touch_input;
 	unsigned touch_max = wacom->features.touch_max;
 	int count = 0;
 	int i;
@@ -1088,7 +1088,7 @@ static int wacom_wac_finger_count_touches(struct wacom_wac *wacom)
 
 static int wacom_24hdt_irq(struct wacom_wac *wacom)
 {
-	struct input_dev *input = wacom->input;
+	struct input_dev *input = wacom->touch_input;
 	unsigned char *data = wacom->data;
 	int i;
 	int current_num_contacts = data[61];
@@ -1156,7 +1156,7 @@ static int wacom_24hdt_irq(struct wacom_wac *wacom)
 
 static int wacom_mt_touch(struct wacom_wac *wacom)
 {
-	struct input_dev *input = wacom->input;
+	struct input_dev *input = wacom->touch_input;
 	unsigned char *data = wacom->data;
 	int i;
 	int current_num_contacts = data[2];
@@ -1207,7 +1207,7 @@ static int wacom_mt_touch(struct wacom_wac *wacom)
 
 static int wacom_tpc_mt_touch(struct wacom_wac *wacom)
 {
-	struct input_dev *input = wacom->input;
+	struct input_dev *input = wacom->touch_input;
 	unsigned char *data = wacom->data;
 	int i;
 
@@ -1236,7 +1236,7 @@ static int wacom_tpc_mt_touch(struct wacom_wac *wacom)
 static int wacom_tpc_single_touch(struct wacom_wac *wacom, size_t len)
 {
 	unsigned char *data = wacom->data;
-	struct input_dev *input = wacom->input;
+	struct input_dev *input = wacom->touch_input;
 	bool prox = !wacom->shared->stylus_in_proximity;
 	int x = 0, y = 0;
 
@@ -1272,7 +1272,7 @@ static int wacom_tpc_single_touch(struct wacom_wac *wacom, size_t len)
 static int wacom_tpc_pen(struct wacom_wac *wacom)
 {
 	unsigned char *data = wacom->data;
-	struct input_dev *input = wacom->input;
+	struct input_dev *input = wacom->pen_input;
 	bool prox = data[1] & 0x20;
 
 	if (!wacom->shared->stylus_in_proximity) /* first in prox */
@@ -1301,8 +1301,12 @@ static int wacom_tpc_irq(struct wacom_wac *wacom, size_t len)
 {
 	unsigned char *data = wacom->data;
 
-	dev_dbg(wacom->input->dev.parent,
-		"%s: received report #%d\n", __func__, data[0]);
+	if (wacom->pen_input)
+		dev_dbg(wacom->pen_input->dev.parent,
+			"%s: received report #%d\n", __func__, data[0]);
+	else if (wacom->touch_input)
+		dev_dbg(wacom->touch_input->dev.parent,
+			"%s: received report #%d\n", __func__, data[0]);
 
 	switch (len) {
 	case WACOM_PKGLEN_TPC1FG:
@@ -1334,11 +1338,9 @@ static int wacom_tpc_irq(struct wacom_wac *wacom, size_t len)
 	return 0;
 }
 
-static void wacom_map_usage(struct wacom *wacom, struct hid_usage *usage,
+static void wacom_map_usage(struct input_dev *input, struct hid_usage *usage,
 		struct hid_field *field, __u8 type, __u16 code, int fuzz)
 {
-	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
-	struct input_dev *input = wacom_wac->input;
 	int fmin = field->logical_minimum;
 	int fmax = field->logical_maximum;
 
@@ -1366,36 +1368,38 @@ static void wacom_wac_pen_usage_mapping(struct hid_device *hdev,
 		struct hid_field *field, struct hid_usage *usage)
 {
 	struct wacom *wacom = hid_get_drvdata(hdev);
+	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
+	struct input_dev *input = wacom_wac->pen_input;
 
 	switch (usage->hid) {
 	case HID_GD_X:
-		wacom_map_usage(wacom, usage, field, EV_ABS, ABS_X, 4);
+		wacom_map_usage(input, usage, field, EV_ABS, ABS_X, 4);
 		break;
 	case HID_GD_Y:
-		wacom_map_usage(wacom, usage, field, EV_ABS, ABS_Y, 4);
+		wacom_map_usage(input, usage, field, EV_ABS, ABS_Y, 4);
 		break;
 	case HID_DG_TIPPRESSURE:
-		wacom_map_usage(wacom, usage, field, EV_ABS, ABS_PRESSURE, 0);
+		wacom_map_usage(input, usage, field, EV_ABS, ABS_PRESSURE, 0);
 		break;
 	case HID_DG_INRANGE:
-		wacom_map_usage(wacom, usage, field, EV_KEY, BTN_TOOL_PEN, 0);
+		wacom_map_usage(input, usage, field, EV_KEY, BTN_TOOL_PEN, 0);
 		break;
 	case HID_DG_INVERT:
-		wacom_map_usage(wacom, usage, field, EV_KEY,
+		wacom_map_usage(input, usage, field, EV_KEY,
 				BTN_TOOL_RUBBER, 0);
 		break;
 	case HID_DG_ERASER:
 	case HID_DG_TIPSWITCH:
-		wacom_map_usage(wacom, usage, field, EV_KEY, BTN_TOUCH, 0);
+		wacom_map_usage(input, usage, field, EV_KEY, BTN_TOUCH, 0);
 		break;
 	case HID_DG_BARRELSWITCH:
-		wacom_map_usage(wacom, usage, field, EV_KEY, BTN_STYLUS, 0);
+		wacom_map_usage(input, usage, field, EV_KEY, BTN_STYLUS, 0);
 		break;
 	case HID_DG_BARRELSWITCH2:
-		wacom_map_usage(wacom, usage, field, EV_KEY, BTN_STYLUS2, 0);
+		wacom_map_usage(input, usage, field, EV_KEY, BTN_STYLUS2, 0);
 		break;
 	case HID_DG_TOOLSERIALNUMBER:
-		wacom_map_usage(wacom, usage, field, EV_MSC, MSC_SERIAL, 0);
+		wacom_map_usage(input, usage, field, EV_MSC, MSC_SERIAL, 0);
 		break;
 	}
 }
@@ -1405,7 +1409,7 @@ static int wacom_wac_pen_event(struct hid_device *hdev, struct hid_field *field,
 {
 	struct wacom *wacom = hid_get_drvdata(hdev);
 	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
-	struct input_dev *input = wacom_wac->input;
+	struct input_dev *input = wacom_wac->pen_input;
 
 	/* checking which Tool / tip switch to send */
 	switch (usage->hid) {
@@ -1435,7 +1439,7 @@ static void wacom_wac_pen_report(struct hid_device *hdev,
 {
 	struct wacom *wacom = hid_get_drvdata(hdev);
 	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
-	struct input_dev *input = wacom_wac->input;
+	struct input_dev *input = wacom_wac->pen_input;
 	bool prox = wacom_wac->hid_data.inrange_state;
 
 	if (!wacom_wac->shared->stylus_in_proximity) /* first in prox */
@@ -1464,23 +1468,24 @@ static void wacom_wac_finger_usage_mapping(struct hid_device *hdev,
 	struct wacom *wacom = hid_get_drvdata(hdev);
 	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
 	struct wacom_features *features = &wacom_wac->features;
+	struct input_dev *input = wacom_wac->touch_input;
 	unsigned touch_max = wacom_wac->features.touch_max;
 
 	switch (usage->hid) {
 	case HID_GD_X:
 		features->last_slot_field = usage->hid;
 		if (touch_max == 1)
-			wacom_map_usage(wacom, usage, field, EV_ABS, ABS_X, 4);
+			wacom_map_usage(input, usage, field, EV_ABS, ABS_X, 4);
 		else
-			wacom_map_usage(wacom, usage, field, EV_ABS,
+			wacom_map_usage(input, usage, field, EV_ABS,
 					ABS_MT_POSITION_X, 4);
 		break;
 	case HID_GD_Y:
 		features->last_slot_field = usage->hid;
 		if (touch_max == 1)
-			wacom_map_usage(wacom, usage, field, EV_ABS, ABS_Y, 4);
+			wacom_map_usage(input, usage, field, EV_ABS, ABS_Y, 4);
 		else
-			wacom_map_usage(wacom, usage, field, EV_ABS,
+			wacom_map_usage(input, usage, field, EV_ABS,
 					ABS_MT_POSITION_Y, 4);
 		break;
 	case HID_DG_CONTACTID:
@@ -1494,7 +1499,7 @@ static void wacom_wac_finger_usage_mapping(struct hid_device *hdev,
 		break;
 	case HID_DG_TIPSWITCH:
 		features->last_slot_field = usage->hid;
-		wacom_map_usage(wacom, usage, field, EV_KEY, BTN_TOUCH, 0);
+		wacom_map_usage(input, usage, field, EV_KEY, BTN_TOUCH, 0);
 		break;
 	}
 }
@@ -1550,7 +1555,7 @@ static int wacom_wac_finger_event(struct hid_device *hdev,
 
 	if (usage->usage_index + 1 == field->report_count) {
 		if (usage->hid == wacom_wac->features.last_slot_field)
-			wacom_wac_finger_slot(wacom_wac, wacom_wac->input);
+			wacom_wac_finger_slot(wacom_wac, wacom_wac->touch_input);
 	}
 
 	return 0;
@@ -1561,7 +1566,7 @@ static void wacom_wac_finger_report(struct hid_device *hdev,
 {
 	struct wacom *wacom = hid_get_drvdata(hdev);
 	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
-	struct input_dev *input = wacom_wac->input;
+	struct input_dev *input = wacom_wac->touch_input;
 	unsigned touch_max = wacom_wac->features.touch_max;
 
 	if (touch_max > 1)
@@ -1578,10 +1583,10 @@ void wacom_wac_usage_mapping(struct hid_device *hdev,
 {
 	struct wacom *wacom = hid_get_drvdata(hdev);
 	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
-	struct input_dev *input = wacom_wac->input;
 
 	/* currently, only direct devices have proper hid report descriptors */
-	__set_bit(INPUT_PROP_DIRECT, input->propbit);
+	__set_bit(INPUT_PROP_DIRECT, wacom_wac->pen_input->propbit);
+	__set_bit(INPUT_PROP_DIRECT, wacom_wac->touch_input->propbit);
 
 	if (WACOM_PEN_FIELD(field))
 		return wacom_wac_pen_usage_mapping(hdev, field, usage);
@@ -1626,7 +1631,7 @@ void wacom_wac_report(struct hid_device *hdev, struct hid_report *report)
 static int wacom_bpt_touch(struct wacom_wac *wacom)
 {
 	struct wacom_features *features = &wacom->features;
-	struct input_dev *input = wacom->input;
+	struct input_dev *input = wacom->touch_input;
 	struct input_dev *pad_input = wacom->pad_input;
 	unsigned char *data = wacom->data;
 	int i;
@@ -1674,7 +1679,7 @@ static int wacom_bpt_touch(struct wacom_wac *wacom)
 static void wacom_bpt3_touch_msg(struct wacom_wac *wacom, unsigned char *data)
 {
 	struct wacom_features *features = &wacom->features;
-	struct input_dev *input = wacom->input;
+	struct input_dev *input = wacom->touch_input;
 	bool touch = data[1] & 0x80;
 	int slot = input_mt_get_slot_by_key(input, data[0]);
 
@@ -1732,7 +1737,6 @@ static void wacom_bpt3_button_msg(struct wacom_wac *wacom, unsigned char *data)
 
 static int wacom_bpt3_touch(struct wacom_wac *wacom)
 {
-	struct input_dev *input = wacom->input;
 	unsigned char *data = wacom->data;
 	int count = data[1] & 0x07;
 	int i;
@@ -1751,8 +1755,12 @@ static int wacom_bpt3_touch(struct wacom_wac *wacom)
 			wacom_bpt3_button_msg(wacom, data + offset);
 
 	}
-	input_mt_sync_frame(input);
-	wacom->shared->touch_down = wacom_wac_finger_count_touches(wacom);
+
+	/* only update the touch if we actually have a touchpad */
+	if (wacom->touch_registered) {
+		input_mt_sync_frame(wacom->touch_input);
+		wacom->shared->touch_down = wacom_wac_finger_count_touches(wacom);
+	}
 
 	return 1;
 }
@@ -1760,7 +1768,7 @@ static int wacom_bpt3_touch(struct wacom_wac *wacom)
 static int wacom_bpt_pen(struct wacom_wac *wacom)
 {
 	struct wacom_features *features = &wacom->features;
-	struct input_dev *input = wacom->input;
+	struct input_dev *input = wacom->pen_input;
 	unsigned char *data = wacom->data;
 	int prox = 0, x = 0, y = 0, p = 0, d = 0, pen = 0, btn1 = 0, btn2 = 0;
 
@@ -1869,7 +1877,7 @@ static void wacom_bamboo_pad_pen_event(struct wacom_wac *wacom,
 static int wacom_bamboo_pad_touch_event(struct wacom_wac *wacom,
 		unsigned char *data)
 {
-	struct input_dev *input = wacom->input;
+	struct input_dev *input = wacom->touch_input;
 	unsigned char *finger_data, prefix;
 	unsigned id;
 	int x, y;
@@ -2113,7 +2121,10 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len)
 	}
 
 	if (sync) {
-		input_sync(wacom_wac->input);
+		if (wacom_wac->pen_input)
+			input_sync(wacom_wac->pen_input);
+		if (wacom_wac->touch_input)
+			input_sync(wacom_wac->touch_input);
 		if (wacom_wac->pad_input)
 			input_sync(wacom_wac->pad_input);
 	}
@@ -2121,7 +2132,7 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len)
 
 static void wacom_setup_cintiq(struct wacom_wac *wacom_wac)
 {
-	struct input_dev *input_dev = wacom_wac->input;
+	struct input_dev *input_dev = wacom_wac->pen_input;
 
 	input_set_capability(input_dev, EV_MSC, MSC_SERIAL);
 
@@ -2144,7 +2155,7 @@ static void wacom_setup_cintiq(struct wacom_wac *wacom_wac)
 
 static void wacom_setup_intuos(struct wacom_wac *wacom_wac)
 {
-	struct input_dev *input_dev = wacom_wac->input;
+	struct input_dev *input_dev = wacom_wac->pen_input;
 
 	input_set_capability(input_dev, EV_REL, REL_WHEEL);
 
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index c873c9f..2978c30 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -196,7 +196,8 @@ struct hid_data {
 };
 
 struct wacom_wac {
-	char name[WACOM_NAME_MAX];
+	char pen_name[WACOM_NAME_MAX];
+	char touch_name[WACOM_NAME_MAX];
 	char pad_name[WACOM_NAME_MAX];
 	char bat_name[WACOM_NAME_MAX];
 	char ac_name[WACOM_NAME_MAX];
@@ -207,9 +208,11 @@ struct wacom_wac {
 	bool reporting_data;
 	struct wacom_features features;
 	struct wacom_shared *shared;
-	struct input_dev *input;
+	struct input_dev *pen_input;
+	struct input_dev *touch_input;
 	struct input_dev *pad_input;
-	bool input_registered;
+	bool pen_registered;
+	bool touch_registered;
 	bool pad_registered;
 	int pid;
 	int battery_capacity;
-- 
2.4.2

