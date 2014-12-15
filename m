From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH 1/2] Input: atmel_mxt_ts - Implement support for T100 touch object
Date: Mon, 15 Dec 2014 11:39:06 +0100
Message-ID: <1418639947-28765-2-git-send-email-javier.martinez@collabora.co.uk>
References: <1418639947-28765-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1418639947-28765-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Nick Dyer <nick.dyer@itdev.co.uk>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Doug Anderson <dianders@chromium.org>, Olof Johansson <olof@lixom.net>, Yufeng Shen <miletus@chromium.org>, Benson Leung <bleung@chromium.org>, linux-input@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>
List-Id: linux-input@vger.kernel.org

From: Nick Dyer <nick.dyer@itdev.co.uk>

The T100 object replaces the old T9 multitouch touchscreen object in new
chips. This patch was cherry-picked from the Atmel touch downstream tree

The original patch had different initialization functions for the T9 and
T100 multi-touch input devices but there was a lot of code duplicated so
the code was refactored to make the T9 dev init function more generic to
support different multi-touch object types.

T9 and T100 initialization logic is kept as it was in the original patch
since there is no public documentation about the different object types.

Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
Acked-by: Yufeng Shen <miletus@chromium.org>
[javier: Factor out T9 and T100 routines to have a common init function]
Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 258 +++++++++++++++++++++++++++++--
 1 file changed, 241 insertions(+), 17 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index bb07020..aaa9e07 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -79,6 +79,7 @@
 #define MXT_SPT_DIGITIZER_T43		43
 #define MXT_SPT_MESSAGECOUNT_T44	44
 #define MXT_SPT_CTECONFIG_T46		46
+#define MXT_TOUCH_MULTITOUCHSCREEN_T100 100
 
 /* MXT_GEN_MESSAGE_T5 object */
 #define MXT_RPTID_NOMSG		0xff
@@ -138,6 +139,9 @@ struct t9_range {
 /* MXT_TOUCH_MULTI_T9 orient */
 #define MXT_T9_ORIENT_SWITCH	(1 << 0)
 
+/* T47 Stylus */
+#define MXT_TOUCH_MAJOR_T47_STYLUS	1
+
 /* MXT_PROCI_GRIPFACE_T20 field */
 #define MXT_GRIPFACE_CTRL	0
 #define MXT_GRIPFACE_XLOGRIP	1
@@ -188,6 +192,23 @@ struct t9_range {
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
+#define MXT_T100_TYPE_STYLUS	0x20
+
 /* Delay times */
 #define MXT_BACKUP_TIME		50	/* msec */
 #define MXT_RESET_TIME		200	/* msec */
@@ -247,6 +268,9 @@ struct mxt_data {
 	unsigned int max_y;
 	bool in_bootloader;
 	u16 mem_size;
+	u8 t100_aux_ampl;
+	u8 t100_aux_area;
+	u8 t100_aux_vect;
 	u8 max_reportid;
 	u32 config_crc;
 	u32 info_crc;
@@ -268,6 +292,8 @@ struct mxt_data {
 	u8 T9_reportid_max;
 	u8 T19_reportid;
 	u16 T44_address;
+	u8 T100_reportid_min;
+	u8 T100_reportid_max;
 
 	/* for fw update in bootloader */
 	struct completion bl_completion;
@@ -761,6 +787,72 @@ static void mxt_proc_t9_message(struct mxt_data *data, u8 *message)
 	data->update_input = true;
 }
 
+static void mxt_proc_t100_message(struct mxt_data *data, u8 *message)
+{
+	struct device *dev = &data->client->dev;
+	struct input_dev *input_dev = data->input_dev;
+	int id;
+	u8 status;
+	int x;
+	int y;
+	int tool;
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
+	dev_dbg(dev,
+		"[%u] status:%02X x:%u y:%u area:%02X amp:%02X vec:%02X\n",
+		id,
+		status,
+		x, y,
+		data->t100_aux_area ? message[data->t100_aux_area] : 0,
+		data->t100_aux_ampl ? message[data->t100_aux_ampl] : 0,
+		data->t100_aux_vect ? message[data->t100_aux_vect] : 0);
+
+	input_mt_slot(input_dev, id);
+
+	if (status & MXT_T100_DETECT) {
+		if ((status & MXT_T100_TYPE_MASK) == MXT_T100_TYPE_STYLUS)
+			tool = MT_TOOL_PEN;
+		else
+			tool = MT_TOOL_FINGER;
+
+		/* Touch active */
+		input_mt_report_slot_state(input_dev, tool, 1);
+		input_report_abs(input_dev, ABS_MT_POSITION_X, x);
+		input_report_abs(input_dev, ABS_MT_POSITION_Y, y);
+
+		if (data->t100_aux_ampl)
+			input_report_abs(input_dev, ABS_MT_PRESSURE,
+					 message[data->t100_aux_ampl]);
+
+		if (data->t100_aux_area) {
+			if (tool == MT_TOOL_PEN)
+				input_report_abs(input_dev, ABS_MT_TOUCH_MAJOR,
+						 MXT_TOUCH_MAJOR_T47_STYLUS);
+			else
+				input_report_abs(input_dev, ABS_MT_TOUCH_MAJOR,
+						 message[data->t100_aux_area]);
+		}
+
+		if (data->t100_aux_vect)
+			input_report_abs(input_dev, ABS_MT_ORIENTATION,
+					 message[data->t100_aux_vect]);
+	} else {
+		/* Touch no longer active, close out slot */
+		input_mt_report_slot_state(input_dev, MT_TOOL_FINGER, 0);
+	}
+
+	data->update_input = true;
+}
+
 static int mxt_proc_message(struct mxt_data *data, u8 *message)
 {
 	u8 report_id = message[0];
@@ -779,6 +871,9 @@ static int mxt_proc_message(struct mxt_data *data, u8 *message)
 	} else if (report_id >= data->T9_reportid_min
 	    && report_id <= data->T9_reportid_max) {
 		mxt_proc_t9_message(data, message);
+	} else if (report_id >= data->T100_reportid_min
+	    && report_id <= data->T100_reportid_max) {
+		mxt_proc_t100_message(data, message);
 	} else if (report_id == data->T19_reportid) {
 		mxt_input_button(data, message);
 		data->update_input = true;
@@ -1401,6 +1496,8 @@ static void mxt_free_object_table(struct mxt_data *data)
 	data->T9_reportid_max = 0;
 	data->T19_reportid = 0;
 	data->T44_address = 0;
+	data->T100_reportid_min = 0;
+	data->T100_reportid_max = 0;
 	data->max_reportid = 0;
 }
 
@@ -1488,6 +1585,12 @@ static int mxt_get_object_table(struct mxt_data *data)
 		case MXT_SPT_GPIOPWM_T19:
 			data->T19_reportid = min_id;
 			break;
+		case MXT_TOUCH_MULTITOUCHSCREEN_T100:
+			data->T100_reportid_min = min_id;
+			data->T100_reportid_max = max_id;
+			/* first two report IDs reserved */
+			data->num_touchids = object->num_report_ids - 2;
+			break;
 		}
 
 		end_address = object->start_address
@@ -1572,10 +1675,88 @@ static int mxt_read_t9_resolution(struct mxt_data *data)
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
+	dev_info(&client->dev,
+		 "T100 Touchscreen size X%uY%u\n", data->max_x, data->max_y);
+
+	return 0;
+}
+
 static int mxt_input_open(struct input_dev *dev);
 static void mxt_input_close(struct input_dev *dev);
 
-static int mxt_initialize_t9_input_device(struct mxt_data *data)
+static int mxt_initialize_input_device(struct mxt_data *data, int multitouch)
 {
 	struct device *dev = &data->client->dev;
 	const struct mxt_platform_data *pdata = data->pdata;
@@ -1585,9 +1766,23 @@ static int mxt_initialize_t9_input_device(struct mxt_data *data)
 	unsigned int mt_flags = 0;
 	int i;
 
-	error = mxt_read_t9_resolution(data);
-	if (error)
-		dev_warn(dev, "Failed to initialize T9 resolution\n");
+	switch (multitouch) {
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
@@ -1602,9 +1797,8 @@ static int mxt_initialize_t9_input_device(struct mxt_data *data)
 	input_dev->open = mxt_input_open;
 	input_dev->close = mxt_input_close;
 
-	__set_bit(EV_ABS, input_dev->evbit);
-	__set_bit(EV_KEY, input_dev->evbit);
-	__set_bit(BTN_TOUCH, input_dev->keybit);
+	set_bit(EV_ABS, input_dev->evbit);
+	input_set_capability(input_dev, EV_KEY, BTN_TOUCH);
 
 	if (pdata->t19_num_keys) {
 		__set_bit(INPUT_PROP_BUTTONPAD, input_dev->propbit);
@@ -1631,25 +1825,45 @@ static int mxt_initialize_t9_input_device(struct mxt_data *data)
 			     0, data->max_x, 0, 0);
 	input_set_abs_params(input_dev, ABS_Y,
 			     0, data->max_y, 0, 0);
-	input_set_abs_params(input_dev, ABS_PRESSURE,
-			     0, 255, 0, 0);
+
+	if (multitouch == MXT_TOUCH_MULTI_T9 ||
+	    (multitouch == MXT_TOUCH_MULTITOUCHSCREEN_T100 &&
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
+	if (multitouch == MXT_TOUCH_MULTI_T9 ||
+	    (multitouch == MXT_TOUCH_MULTITOUCHSCREEN_T100 &&
+	     data->t100_aux_area))
+		input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR,
+				     0, MXT_MAX_AREA, 0, 0);
+
+	if (multitouch == MXT_TOUCH_MULTITOUCHSCREEN_T100)
+		input_set_abs_params(input_dev, ABS_MT_TOOL_TYPE, 0,
+				     MT_TOOL_MAX, 0, 0);
+
 	input_set_abs_params(input_dev, ABS_MT_POSITION_X,
 			     0, data->max_x, 0, 0);
 	input_set_abs_params(input_dev, ABS_MT_POSITION_Y,
 			     0, data->max_y, 0, 0);
-	input_set_abs_params(input_dev, ABS_MT_PRESSURE,
-			     0, 255, 0, 0);
+
+	if (multitouch == MXT_TOUCH_MULTI_T9 ||
+	    (multitouch == MXT_TOUCH_MULTITOUCHSCREEN_T100 &&
+	     data->t100_aux_ampl))
+		input_set_abs_params(input_dev, ABS_MT_PRESSURE,
+				     0, 255, 0, 0);
+
+	if (multitouch == MXT_TOUCH_MULTITOUCHSCREEN_T100 &&
+	    data->t100_aux_vect)
+		input_set_abs_params(input_dev, ABS_MT_ORIENTATION,
+				     0, 255, 0, 0);
 
 	input_set_drvdata(input_dev, data);
 
@@ -1801,6 +2015,7 @@ static int mxt_configure_objects(struct mxt_data *data,
 {
 	struct device *dev = &data->client->dev;
 	struct mxt_info *info = &data->info;
+	int multitouch = 0;
 	int error;
 
 	if (cfg) {
@@ -1815,9 +2030,18 @@ static int mxt_configure_objects(struct mxt_data *data,
 		return error;
 	}
 
-	error = mxt_initialize_t9_input_device(data);
-	if (error)
-		return error;
+	if (data->T9_reportid_min)
+		multitouch = MXT_TOUCH_MULTI_T9;
+	else if (data->T100_reportid_min)
+		multitouch = MXT_TOUCH_MULTITOUCHSCREEN_T100;
+
+	if (multitouch) {
+		error = mxt_initialize_input_device(data, multitouch);
+		if (error)
+			return error;
+	} else {
+		dev_warn(dev, "No touch object detected\n");
+	}
 
 	dev_info(dev,
 		 "Family: %u Variant: %u Firmware V%u.%u.%02X Objects: %u\n",
-- 
2.1.3
