From: Chris Leech <christopher.leech@linux.intel.com>
Subject: [PATCH 3/5] qt602240_ts: Trust factory configuration of touchscreen.
Date: Tue, 16 Nov 2010 12:42:00 -0800
Message-ID: <20101116204200.28796.23013.stgit@localhost6.localdomain6>
References: <20101116203914.28796.23141.stgit@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:42155 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756675Ab0KPUmB (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Nov 2010 15:42:01 -0500
In-Reply-To: <20101116203914.28796.23141.stgit@localhost6.localdomain6>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Joonyoung Shim <jy0922.shim@samsung.com>

The maXTouch 224 touchscreen controller has non-volatile storage for system
configuration and calibration settings.  Make it a platform option to trust
those values, instead of reconfiguring everything.  The configuration settings
currently being applied are determined from the firmware version, but are not
appropriate for all systems.  This should be a compatible change with existing
users of this driver.

Signed-off-by: Chris Leech <christopher.leech@linux.intel.com>
---
 drivers/input/touchscreen/qt602240_ts.c |  121 +++++++++++++++++++++++--------
 include/linux/i2c/qt602240_ts.h         |    8 ++
 2 files changed, 98 insertions(+), 31 deletions(-)

diff --git a/drivers/input/touchscreen/qt602240_ts.c b/drivers/input/touchscreen/qt602240_ts.c
index 95496ec..11055ec 100644
--- a/drivers/input/touchscreen/qt602240_ts.c
+++ b/drivers/input/touchscreen/qt602240_ts.c
@@ -353,7 +353,7 @@ struct qt602240_finger {
 struct qt602240_data {
 	struct i2c_client *client;
 	struct input_dev *input_dev;
-	const struct qt602240_platform_data *pdata;
+	struct qt602240_platform_data *pdata;
 	struct qt602240_object *object_table;
 	struct qt602240_info info;
 	struct qt602240_finger finger[QT602240_MAX_FINGER];
@@ -754,7 +754,7 @@ static int qt602240_check_reg_init(struct qt602240_data *data)
 
 static int qt602240_check_matrix_size(struct qt602240_data *data)
 {
-	const struct qt602240_platform_data *pdata = data->pdata;
+	struct qt602240_platform_data *pdata = data->pdata;
 	struct device *dev = &data->client->dev;
 	int mode = -1;
 	int error;
@@ -844,7 +844,7 @@ static int qt602240_make_highchg(struct qt602240_data *data)
 
 static void qt602240_handle_pdata(struct qt602240_data *data)
 {
-	const struct qt602240_platform_data *pdata = data->pdata;
+	struct qt602240_platform_data *pdata = data->pdata;
 	u8 voltage;
 
 	/* Set touchscreen lines */
@@ -890,6 +890,48 @@ static void qt602240_handle_pdata(struct qt602240_data *data)
 	}
 }
 
+static void qt602240_read_config(struct qt602240_data *data)
+{
+	struct qt602240_platform_data *pdata = data->pdata;
+	u8 val;
+	u8 high, low;
+
+	/* touchscreen lines */
+	qt602240_read_object(data, QT602240_TOUCH_MULTI, QT602240_TOUCH_XSIZE,
+			&val);
+		pdata->x_line = val;
+	qt602240_read_object(data, QT602240_TOUCH_MULTI, QT602240_TOUCH_YSIZE,
+			&val);
+		pdata->x_line = val;
+
+	/* touchscreen orient */
+	qt602240_read_object(data, QT602240_TOUCH_MULTI, QT602240_TOUCH_ORIENT,
+			&val);
+		pdata->orient = val;
+
+	/* touchscreen burst length */
+	qt602240_read_object(data, QT602240_TOUCH_MULTI, QT602240_TOUCH_BLEN,
+			&val);
+		pdata->blen = val;
+
+	/* touchscreen threshold */
+	qt602240_read_object(data, QT602240_TOUCH_MULTI, QT602240_TOUCH_TCHTHR,
+			&val);
+		pdata->threshold = val;
+
+	/* touchscreen resolution */
+	qt602240_read_object(data, QT602240_TOUCH_MULTI,
+			QT602240_TOUCH_XRANGE_LSB, &low);
+	qt602240_read_object(data, QT602240_TOUCH_MULTI,
+			QT602240_TOUCH_XRANGE_MSB, &high);
+	pdata->x_size = (high << 8) | (low + 1);
+	qt602240_read_object(data, QT602240_TOUCH_MULTI,
+			QT602240_TOUCH_YRANGE_LSB, &low);
+	qt602240_read_object(data, QT602240_TOUCH_MULTI,
+			QT602240_TOUCH_YRANGE_MSB, &high);
+	pdata->y_size = (high << 8) | (low + 1);
+}
+
 static int qt602240_get_info(struct qt602240_data *data)
 {
 	struct i2c_client *client = data->client;
@@ -981,23 +1023,28 @@ static int qt602240_initialize(struct qt602240_data *data)
 	if (error)
 		return error;
 
-	/* Check register init values */
-	error = qt602240_check_reg_init(data);
-	if (error)
-		return error;
+	if (data->pdata->trust_nvm) {
+		/* read configuration from device */
+		qt602240_read_config(data);
+	} else {
+		/* Check register init values */
+		error = qt602240_check_reg_init(data);
+		if (error)
+			return error;
 
-	/* Check X/Y matrix size */
-	error = qt602240_check_matrix_size(data);
-	if (error)
-		return error;
+		/* Check X/Y matrix size */
+		error = qt602240_check_matrix_size(data);
+		if (error)
+			return error;
 
-	qt602240_handle_pdata(data);
+		qt602240_handle_pdata(data);
 
-	/* Backup to memory */
-	qt602240_write_object(data, QT602240_GEN_COMMAND,
-			QT602240_COMMAND_BACKUPNV,
-			QT602240_BACKUP_VALUE);
-	msleep(QT602240_BACKUP_TIME);
+		/* Backup to memory */
+		qt602240_write_object(data, QT602240_GEN_COMMAND,
+				QT602240_COMMAND_BACKUPNV,
+				QT602240_BACKUP_VALUE);
+		msleep(QT602240_BACKUP_TIME);
+	}
 
 	/* Soft reset */
 	qt602240_write_object(data, QT602240_GEN_COMMAND,
@@ -1227,6 +1274,8 @@ static int __devinit qt602240_probe(struct i2c_client *client,
 	struct qt602240_data *data;
 	struct input_dev *input_dev;
 	int error;
+	u16 x_size;
+	u16 y_size;
 
 	if (!client->dev.platform_data)
 		return -EINVAL;
@@ -1249,20 +1298,6 @@ static int __devinit qt602240_probe(struct i2c_client *client,
 	__set_bit(EV_KEY, input_dev->evbit);
 	__set_bit(BTN_TOUCH, input_dev->keybit);
 
-	/* For single touch */
-	input_set_abs_params(input_dev, ABS_X,
-			     0, QT602240_MAX_XC, 0, 0);
-	input_set_abs_params(input_dev, ABS_Y,
-			     0, QT602240_MAX_YC, 0, 0);
-
-	/* For multi touch */
-	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR,
-			     0, QT602240_MAX_AREA, 0, 0);
-	input_set_abs_params(input_dev, ABS_MT_POSITION_X,
-			     0, QT602240_MAX_XC, 0, 0);
-	input_set_abs_params(input_dev, ABS_MT_POSITION_Y,
-			     0, QT602240_MAX_YC, 0, 0);
-
 	input_set_drvdata(input_dev, data);
 
 	data->client = client;
@@ -1276,6 +1311,30 @@ static int __devinit qt602240_probe(struct i2c_client *client,
 	if (error)
 		goto err_free_object;
 
+	/*
+	 * Bit 0 of TOUCH_ORIENT is the X/Y swap configuration.
+	 * If the axises are swapped the reporting will change, and in order to
+	 * get the scaling correct we need to swap the maximum range values
+	 * reported to the input layer.
+	 */
+	if (data->pdata->orient & 1) {
+		x_size = data->pdata->y_size;
+		y_size = data->pdata->x_size;
+	} else {
+		x_size = data->pdata->x_size;
+		y_size = data->pdata->y_size;
+	}
+
+	/* For single touch */
+	input_set_abs_params(input_dev, ABS_X, 0, x_size, 0, 0);
+	input_set_abs_params(input_dev, ABS_Y, 0, y_size, 0, 0);
+
+	/* For multi touch */
+	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0,
+			QT602240_MAX_AREA, 0, 0);
+	input_set_abs_params(input_dev, ABS_MT_POSITION_X, 0, x_size, 0, 0);
+	input_set_abs_params(input_dev, ABS_MT_POSITION_Y, 0, y_size, 0, 0);
+
 	error = qt602240_make_highchg(data);
 	if (error)
 		goto err_free_object;
diff --git a/include/linux/i2c/qt602240_ts.h b/include/linux/i2c/qt602240_ts.h
index c5033e1..d2aa1b6 100644
--- a/include/linux/i2c/qt602240_ts.h
+++ b/include/linux/i2c/qt602240_ts.h
@@ -33,6 +33,14 @@ struct qt602240_platform_data {
 	unsigned int threshold;
 	unsigned int voltage;
 	unsigned char orient;
+	/*
+	 * trust_nvm: 1 to trust HW config, 0 for software reconfiguration
+	 * If trust_nvm is set, all of the above values will be read from the
+	 * device (presumably loaded from non-volatile memory at reset),
+	 * instead of the other way around (configuring the device based on
+	 * platform_data).
+	 */
+	unsigned char trust_nvm;
 };
 
 #endif /* __LINUX_QT602240_TS_H */

