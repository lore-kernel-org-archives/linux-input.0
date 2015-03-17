From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH 1/2] Input: atmel_mxt_ts - Implement support for T100 touch object
Date: Tue, 17 Mar 2015 15:00:45 +0100
Message-ID: <1426600846-13346-2-git-send-email-javier.martinez@collabora.co.uk>
References: <1426600846-13346-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:53415 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752908AbbCQOBs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Mar 2015 10:01:48 -0400
In-Reply-To: <1426600846-13346-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Nick Dyer <nick.dyer@itdev.co.uk>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Doug Anderson <dianders@chromium.org>, Olof Johansson <olof@lixom.net>, Yufeng Shen <miletus@chromium.org>, Benson Leung <bleung@chromium.org>, Chung-yih Wang <cywang@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

From: Nick Dyer <nick.dyer@itdev.co.uk>

Add support for the new T100 object which replaces the previous
T9 multitouch touchscreen object in recent maXTouch devices.
T100 provides improved reporting with selectable auxiliary
information, and a type field for hover/stylus/glove reporting.

The hovering finger support was based on Chung-Yih's work in
the ChromiumOS downstream kernel:

https://chromium-review.googlesource.com/#/c/219280/

Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
Acked-by: Yufeng Shen <miletus@chromium.org>
[javier: Factor out T9 and T100 init functions and rework hover support]
Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 323 +++++++++++++++++++++++++++++--
 1 file changed, 302 insertions(+), 21 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 95ee92a91bd2..749371761669 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -79,6 +79,7 @@
 #define MXT_SPT_DIGITIZER_T43		43
 #define MXT_SPT_MESSAGECOUNT_T44	44
 #define MXT_SPT_CTECONFIG_T46		46
+#define MXT_TOUCH_MULTITOUCHSCREEN_T100 100
 
 /* MXT_GEN_MESSAGE_T5 object */
 #define MXT_RPTID_NOMSG		0xff
@@ -185,6 +186,36 @@ struct t9_range {
 #define MXT_RESET_VALUE		0x01
 #define MXT_BACKUP_VALUE	0x55
 
+/* T100 Multiple Touch Touchscreen */
+#define MXT_T100_CTRL		0
+#define MXT_T100_CFG1		1
+#define MXT_T100_TCHAUX		3
+#define MXT_T100_XRANGE		13
+#define MXT_T100_YRANGE		24
+
+#define MXT_T100_CFG_SWITCHXY	(1 << 5)
+
+#define MXT_T100_TCHAUX_VECT	(1 << 0)
+#define MXT_T100_TCHAUX_AMPL	(1 << 1)
+#define MXT_T100_TCHAUX_AREA	(1 << 2)
+
+#define MXT_T100_DETECT		(1 << 7)
+#define MXT_T100_TYPE_MASK	0x70
+
+enum t100_type {
+	MXT_T100_TYPE_FINGER		= 1,
+	MXT_T100_TYPE_PASSIVE_STYLUS	= 2,
+	MXT_T100_TYPE_HOVERING_FINGER	= 4,
+	MXT_T100_TYPE_GLOVE		= 5,
+	MXT_T100_TYPE_LARGE_TOUCH	= 6,
+};
+
+#define MXT_DISTANCE_ACTIVE_TOUCH	0
+#define MXT_DISTANCE_HOVERING		1
+
+#define MXT_TOUCH_MAJOR_DEFAULT	1
+#define MXT_PRESSURE_DEFAULT	1
+
 /* Delay times */
 #define MXT_BACKUP_TIME		50	/* msec */
 #define MXT_RESET_TIME		200	/* msec */
@@ -244,6 +275,9 @@ struct mxt_data {
 	unsigned int max_y;
 	bool in_bootloader;
 	u16 mem_size;
+	u8 t100_aux_ampl;
+	u8 t100_aux_area;
+	u8 t100_aux_vect;
 	u8 max_reportid;
 	u32 config_crc;
 	u32 info_crc;
@@ -253,6 +287,7 @@ struct mxt_data {
 	bool update_input;
 	u8 last_message_count;
 	u8 num_touchids;
+	u8 multitouch;
 
 	/* Cached parameters from object table */
 	u16 T5_address;
@@ -264,6 +299,8 @@ struct mxt_data {
 	u8 T9_reportid_max;
 	u8 T19_reportid;
 	u16 T44_address;
+	u8 T100_reportid_min;
+	u8 T100_reportid_max;
 
 	/* for fw update in bootloader */
 	struct completion bl_completion;
@@ -771,6 +808,108 @@ static void mxt_proc_t9_message(struct mxt_data *data, u8 *message)
 	data->update_input = true;
 }
 
+static void mxt_proc_t100_message(struct mxt_data *data, u8 *message)
+{
+	struct device *dev = &data->client->dev;
+	struct input_dev *input_dev = data->input_dev;
+	int id;
+	u8 status;
+	u8 type = 0;
+	int x;
+	int y;
+	int distance = 0;
+	int tool = 0;
+	u8 major = 0;
+	u8 pressure = 0;
+	u8 orientation = 0;
+
+	id = message[0] - data->T100_reportid_min - 2;
+
+	/* ignore SCRSTATUS events */
+	if (id < 0)
+		return;
+
+	status = message[1];
+	x = (message[3] << 8) | message[2];
+	y = (message[5] << 8) | message[4];
+
+	if (status & MXT_T100_DETECT) {
+		type = (status & MXT_T100_TYPE_MASK) >> 4;
+
+		switch (type) {
+		case MXT_T100_TYPE_HOVERING_FINGER:
+			tool = MT_TOOL_FINGER;
+			distance = MXT_DISTANCE_HOVERING;
+
+			if (data->t100_aux_vect)
+				orientation = message[data->t100_aux_vect];
+
+			break;
+		case MXT_T100_TYPE_FINGER:
+		case MXT_T100_TYPE_GLOVE:
+			tool = MT_TOOL_FINGER;
+			distance = MXT_DISTANCE_ACTIVE_TOUCH;
+
+			if (data->t100_aux_area)
+				major = message[data->t100_aux_area];
+
+			if (data->t100_aux_ampl)
+				pressure = message[data->t100_aux_ampl];
+
+			if (data->t100_aux_vect)
+				orientation = message[data->t100_aux_vect];
+
+			break;
+		case MXT_T100_TYPE_PASSIVE_STYLUS:
+			tool = MT_TOOL_PEN;
+
+			/* Passive stylus is reported with size zero so
+			 * hardcode */
+			major = MXT_TOUCH_MAJOR_DEFAULT;
+
+			if (data->t100_aux_ampl)
+				pressure = message[data->t100_aux_ampl];
+
+			break;
+		case MXT_T100_TYPE_LARGE_TOUCH:
+			/* Ignore suppressed touch */
+			break;
+		default:
+			dev_dbg(dev, "Unexpected T100 type\n");
+			return;
+		}
+	}
+
+	/*
+	 * Values reported should be non-zero if tool is touching the
+	 * device
+	 */
+	if (!pressure && type != MXT_T100_TYPE_HOVERING_FINGER)
+		pressure = MXT_PRESSURE_DEFAULT;
+
+	input_mt_slot(input_dev, id);
+
+	if (status & MXT_T100_DETECT) {
+		dev_dbg(dev, "[%u] type:%u x:%u y:%u a:%02X p:%02X v:%02X\n",
+			id, type, x, y, major, pressure, orientation);
+
+		input_mt_report_slot_state(input_dev, tool, 1);
+		input_report_abs(input_dev, ABS_MT_POSITION_X, x);
+		input_report_abs(input_dev, ABS_MT_POSITION_Y, y);
+		input_report_abs(input_dev, ABS_MT_TOUCH_MAJOR, major);
+		input_report_abs(input_dev, ABS_MT_PRESSURE, pressure);
+		input_report_abs(input_dev, ABS_MT_DISTANCE, distance);
+		input_report_abs(input_dev, ABS_MT_ORIENTATION, orientation);
+	} else {
+		dev_dbg(dev, "[%u] release\n", id);
+
+		/* close out slot */
+		input_mt_report_slot_state(input_dev, 0, 0);
+	}
+
+	data->update_input = true;
+}
+
 static int mxt_proc_message(struct mxt_data *data, u8 *message)
 {
 	u8 report_id = message[0];
@@ -789,6 +928,9 @@ static int mxt_proc_message(struct mxt_data *data, u8 *message)
 	} else if (report_id >= data->T9_reportid_min
 	    && report_id <= data->T9_reportid_max) {
 		mxt_proc_t9_message(data, message);
+	} else if (report_id >= data->T100_reportid_min
+	    && report_id <= data->T100_reportid_max) {
+		mxt_proc_t100_message(data, message);
 	} else if (report_id == data->T19_reportid) {
 		mxt_input_button(data, message);
 		data->update_input = true;
@@ -1411,6 +1553,8 @@ static void mxt_free_object_table(struct mxt_data *data)
 	data->T9_reportid_max = 0;
 	data->T19_reportid = 0;
 	data->T44_address = 0;
+	data->T100_reportid_min = 0;
+	data->T100_reportid_max = 0;
 	data->max_reportid = 0;
 }
 
@@ -1487,6 +1631,7 @@ static int mxt_get_object_table(struct mxt_data *data)
 			data->T7_address = object->start_address;
 			break;
 		case MXT_TOUCH_MULTI_T9:
+			data->multitouch = MXT_TOUCH_MULTI_T9;
 			data->T9_reportid_min = min_id;
 			data->T9_reportid_max = max_id;
 			data->num_touchids = object->num_report_ids
@@ -1498,6 +1643,13 @@ static int mxt_get_object_table(struct mxt_data *data)
 		case MXT_SPT_GPIOPWM_T19:
 			data->T19_reportid = min_id;
 			break;
+		case MXT_TOUCH_MULTITOUCHSCREEN_T100:
+			data->multitouch = MXT_TOUCH_MULTITOUCHSCREEN_T100;
+			data->T100_reportid_min = min_id;
+			data->T100_reportid_max = max_id;
+			/* first two report IDs reserved */
+			data->num_touchids = object->num_report_ids - 2;
+			break;
 		}
 
 		end_address = object->start_address
@@ -1582,10 +1734,88 @@ static int mxt_read_t9_resolution(struct mxt_data *data)
 	return 0;
 }
 
+static int mxt_read_t100_config(struct mxt_data *data)
+{
+	struct i2c_client *client = data->client;
+	int error;
+	struct mxt_object *object;
+	u16 range_x, range_y;
+	u8 cfg, tchaux;
+	u8 aux;
+
+	object = mxt_get_object(data, MXT_TOUCH_MULTITOUCHSCREEN_T100);
+	if (!object)
+		return -EINVAL;
+
+	error = __mxt_read_reg(client,
+			       object->start_address + MXT_T100_XRANGE,
+			       sizeof(range_x), &range_x);
+	if (error)
+		return error;
+
+	le16_to_cpus(range_x);
+
+	error = __mxt_read_reg(client,
+			       object->start_address + MXT_T100_YRANGE,
+			       sizeof(range_y), &range_y);
+	if (error)
+		return error;
+
+	le16_to_cpus(range_y);
+
+	error =  __mxt_read_reg(client,
+				object->start_address + MXT_T100_CFG1,
+				1, &cfg);
+	if (error)
+		return error;
+
+	error =  __mxt_read_reg(client,
+				object->start_address + MXT_T100_TCHAUX,
+				1, &tchaux);
+	if (error)
+		return error;
+
+	/* Handle default values */
+	if (range_x == 0)
+		range_x = 1023;
+
+	if (range_y == 0)
+		range_y = 1023;
+
+	if (cfg & MXT_T100_CFG_SWITCHXY) {
+		data->max_x = range_y;
+		data->max_y = range_x;
+	} else {
+		data->max_x = range_x;
+		data->max_y = range_y;
+	}
+
+	/* allocate aux bytes */
+	aux = 6;
+
+	if (tchaux & MXT_T100_TCHAUX_VECT)
+		data->t100_aux_vect = aux++;
+
+	if (tchaux & MXT_T100_TCHAUX_AMPL)
+		data->t100_aux_ampl = aux++;
+
+	if (tchaux & MXT_T100_TCHAUX_AREA)
+		data->t100_aux_area = aux++;
+
+	dev_dbg(&client->dev,
+		"T100 aux mappings vect:%u ampl:%u area:%u\n",
+		data->t100_aux_vect, data->t100_aux_ampl, data->t100_aux_area);
+
+	dev_info(&client->dev,
+		 "T100 Touchscreen size X%uY%u\n", data->max_x, data->max_y);
+
+	return 0;
+}
+
 static int mxt_input_open(struct input_dev *dev);
 static void mxt_input_close(struct input_dev *dev);
 
-static int mxt_initialize_t9_input_device(struct mxt_data *data)
+static int mxt_initialize_input_device(struct mxt_data *data)
 {
 	struct device *dev = &data->client->dev;
 	const struct mxt_platform_data *pdata = data->pdata;
@@ -1595,9 +1825,23 @@ static int mxt_initialize_t9_input_device(struct mxt_data *data)
 	unsigned int mt_flags = 0;
 	int i;
 
-	error = mxt_read_t9_resolution(data);
-	if (error)
-		dev_warn(dev, "Failed to initialize T9 resolution\n");
+	switch (data->multitouch) {
+	case MXT_TOUCH_MULTI_T9:
+		num_mt_slots = data->T9_reportid_max - data->T9_reportid_min + 1;
+		error = mxt_read_t9_resolution(data);
+		if (error)
+			dev_warn(dev, "Failed to initialize T9 resolution\n");
+		break;
+	case MXT_TOUCH_MULTITOUCHSCREEN_T100:
+		num_mt_slots = data->num_touchids;
+		error = mxt_read_t100_config(data);
+		if (error)
+			dev_warn(dev, "Failed to read T100 config\n");
+		break;
+	default:
+		dev_err(dev, "Invalid multitouch object\n");
+		return -EINVAL;
+	}
 
 	input_dev = input_allocate_device();
 	if (!input_dev) {
@@ -1612,9 +1856,8 @@ static int mxt_initialize_t9_input_device(struct mxt_data *data)
 	input_dev->open = mxt_input_open;
 	input_dev->close = mxt_input_close;
 
-	__set_bit(EV_ABS, input_dev->evbit);
-	__set_bit(EV_KEY, input_dev->evbit);
-	__set_bit(BTN_TOUCH, input_dev->keybit);
+	set_bit(EV_ABS, input_dev->evbit);
+	input_set_capability(input_dev, EV_KEY, BTN_TOUCH);
 
 	if (pdata->t19_num_keys) {
 		__set_bit(INPUT_PROP_BUTTONPAD, input_dev->propbit);
@@ -1641,25 +1884,61 @@ static int mxt_initialize_t9_input_device(struct mxt_data *data)
 			     0, data->max_x, 0, 0);
 	input_set_abs_params(input_dev, ABS_Y,
 			     0, data->max_y, 0, 0);
-	input_set_abs_params(input_dev, ABS_PRESSURE,
-			     0, 255, 0, 0);
+
+	if (data->multitouch == MXT_TOUCH_MULTI_T9 ||
+	    (data->multitouch == MXT_TOUCH_MULTITOUCHSCREEN_T100 &&
+	     data->t100_aux_ampl))
+		input_set_abs_params(input_dev, ABS_PRESSURE,
+				     0, 255, 0, 0);
 
 	/* For multi touch */
-	num_mt_slots = data->T9_reportid_max - data->T9_reportid_min + 1;
 	error = input_mt_init_slots(input_dev, num_mt_slots, mt_flags);
 	if (error) {
 		dev_err(dev, "Error %d initialising slots\n", error);
 		goto err_free_mem;
 	}
 
-	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR,
-			     0, MXT_MAX_AREA, 0, 0);
+	if (data->multitouch == MXT_TOUCH_MULTITOUCHSCREEN_T100) {
+		input_set_abs_params(input_dev, ABS_MT_TOOL_TYPE, 0,
+				     MT_TOOL_MAX, 0, 0);
+
+		input_set_abs_params(input_dev, ABS_MT_DISTANCE,
+				     MXT_DISTANCE_ACTIVE_TOUCH,
+				     MXT_DISTANCE_HOVERING,
+				     0, 0);
+	}
+
 	input_set_abs_params(input_dev, ABS_MT_POSITION_X,
 			     0, data->max_x, 0, 0);
 	input_set_abs_params(input_dev, ABS_MT_POSITION_Y,
 			     0, data->max_y, 0, 0);
-	input_set_abs_params(input_dev, ABS_MT_PRESSURE,
-			     0, 255, 0, 0);
+
+	if (data->multitouch == MXT_TOUCH_MULTI_T9 ||
+	    (data->multitouch == MXT_TOUCH_MULTITOUCHSCREEN_T100 &&
+	     data->t100_aux_area))
+		input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR,
+				     0, MXT_MAX_AREA, 0, 0);
+
+	if (data->multitouch == MXT_TOUCH_MULTI_T9 ||
+	    (data->multitouch == MXT_TOUCH_MULTITOUCHSCREEN_T100 &&
+	     data->t100_aux_ampl))
+		input_set_abs_params(input_dev, ABS_MT_PRESSURE,
+				     0, 255, 0, 0);
+
+	if (data->multitouch == MXT_TOUCH_MULTITOUCHSCREEN_T100 &&
+	    data->t100_aux_vect)
+		input_set_abs_params(input_dev, ABS_MT_ORIENTATION,
+				     0, 255, 0, 0);
+
+	if (data->multitouch == MXT_TOUCH_MULTITOUCHSCREEN_T100 &&
+	    data->t100_aux_ampl)
+		input_set_abs_params(input_dev, ABS_MT_PRESSURE,
+				     0, 255, 0, 0);
+
+	if (data->multitouch == MXT_TOUCH_MULTITOUCHSCREEN_T100 &&
+	    data->t100_aux_vect)
+		input_set_abs_params(input_dev, ABS_MT_ORIENTATION,
+				     0, 255, 0, 0);
 
 	input_set_drvdata(input_dev, data);
 
@@ -1765,9 +2044,13 @@ static int mxt_configure_objects(struct mxt_data *data,
 			dev_warn(dev, "Error %d updating config\n", error);
 	}
 
-	error = mxt_initialize_t9_input_device(data);
-	if (error)
-		return error;
+	if (data->multitouch) {
+		error = mxt_initialize_input_device(data);
+		if (error)
+			return error;
+	} else {
+		dev_warn(dev, "No touch object detected\n");
+	}
 
 	dev_info(dev,
 		 "Family: %u Variant: %u Firmware V%u.%u.%02X Objects: %u\n",
@@ -2044,15 +2327,13 @@ static const struct attribute_group mxt_attr_group = {
 static void mxt_start(struct mxt_data *data)
 {
 	/* Touch enable */
-	mxt_write_object(data,
-			MXT_TOUCH_MULTI_T9, MXT_TOUCH_CTRL, 0x83);
+	mxt_write_object(data, data->multitouch, MXT_TOUCH_CTRL, 0x83);
 }
 
 static void mxt_stop(struct mxt_data *data)
 {
 	/* Touch disable */
-	mxt_write_object(data,
-			MXT_TOUCH_MULTI_T9, MXT_TOUCH_CTRL, 0);
+	mxt_write_object(data, data->multitouch, MXT_TOUCH_CTRL, 0);
 }
 
 static int mxt_input_open(struct input_dev *dev)
-- 
2.1.4

