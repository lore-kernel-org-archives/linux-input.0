From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCHv4] input: ROHM BU21013 touch panel controller support
Date: Wed, 29 Sep 2010 11:32:53 +0200
Message-ID: <4CA307C5.3090807@euromail.se>
References: <1285737038-3536-1-git-send-email-naveen.gaddipati@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000008000009020404070507"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:39234 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751114Ab0I2Jej (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Sep 2010 05:34:39 -0400
In-Reply-To: <1285737038-3536-1-git-send-email-naveen.gaddipati@stericsson.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Naveen Kumar G <naveen.gaddipati@stericsson.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, STEricsson_nomadik_linux@list.st.com, linux-input@vger.kernel.org, tsoni@codeaurora.org

This is a multi-part message in MIME format.
--------------000008000009020404070507
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Naveen,

Many thanks for the efforts and changes. Some comments below, plus I have
attached an untested patch with the code I had in mind when writing my last
comments.

Cheers,
Henrik

> +

> +/**
> + * bu21013_do_touch_report(): Get the touch co-ordinates
> + * @data: bu21013_ts_data structure pointer
> + *
> + * Get the touch co-ordinates from touch sensor registers and writes
> + * into device structure and returns integer.
> + */
> +static int bu21013_do_touch_report(struct bu21013_ts_data *data)
> +{
> +	u8	buf[LENGTH_OF_BUFFER];
> +	bool	finger1_valid;
> +	bool	finger2_valid;
> +	unsigned int	finger1_pos[2];
> +	unsigned int	finger2_pos[2];
> +	int	number_of_active_x_sensors;
> +	int	number_of_active_y_sensors;
> +	int	total_number_of_active_sensors;
> +	int	finger_down_count = 0;
> +	int	retval = 0;
> +	int	i = 0;
> +	int	j = 0;
> +	int	retry_count = I2C_RETRY_COUNT;
> +	bool	rotate[MAX_FINGERS];
> +	static bool previous_press_reported;


The number of variables alone suggests something could be broken out of this
function.

> +
> +	if (data == NULL)
> +		return -EINVAL;
> +
> +	do {
> +		retval = i2c_smbus_read_i2c_block_data
> +			(data->client, BU21013_SENSORS_BTN_0_7_REG,
> +				LENGTH_OF_BUFFER, buf);
> +		retry_count--;
> +		if ((retval < LENGTH_OF_BUFFER) && (!retry_count))
> +			return -EINVAL;
> +	} while (retval < LENGTH_OF_BUFFER);


In the attached patch, the above code has been broken out.

> +
> +	number_of_active_x_sensors = hweight32(buf[0] &
> +					BU21013_SENSORS_EN_0_7);
> +	number_of_active_y_sensors = hweight32(
> +			((buf[1] & BU21013_SENSORS_EN_8_15) |
> +		((buf[2] & BU21013_SENSORS_EN_16_23) << SHIFT_8)) >> SHIFT_2);
> +	if (((number_of_active_x_sensors != 0) &&
> +		(number_of_active_y_sensors == 0)) ||
> +		((number_of_active_x_sensors == 0) &&
> +		(number_of_active_y_sensors != 0)))
> +		return 0;


Using boolean variables, the above can be written quite compactly, see attached
patch.

> +
> +	total_number_of_active_sensors =
> +		number_of_active_x_sensors + number_of_active_y_sensors;
> +
> +	if (total_number_of_active_sensors) {
> +		while (i < 2) {
> +			finger1_pos[i] = buf[j + 3] << SHIFT_2 |
> +						(buf[j + 4] & MASK_BITS);
> +			finger2_pos[i] = buf[j + 7] << SHIFT_2 |
> +						(buf[j + 8] & MASK_BITS);
> +
> +			finger1_valid = (finger1_pos[i] != 0) ? true : false;
> +			finger2_valid = (finger2_pos[i] != 0) ? true : false;


When talking about arrays, I really meant an array of fingers, rather than an
array of x and y.

> +
> +			if ((!finger1_valid) && (!finger2_valid)) {
> +				return 0;
> +			} else if ((!finger1_valid) && (finger2_valid)) {
> +				finger1_valid = finger2_valid;
> +				finger2_valid = false;
> +				finger1_pos[i] = finger2_pos[i];
> +				finger2_pos[i] = 0;
> +			}
> +			j += 2;
> +			i++;
> +		}
> +
> +		if (finger1_valid) {
> +			if (data->chip->x_flip)
> +				finger1_pos[0] = data->chip->touch_x_max -
> +							finger1_pos[0];
> +			if (data->chip->y_flip)
> +				finger1_pos[1] = data->chip->touch_y_max -
> +							finger1_pos[1];
> +			finger_down_count++;
> +		}
> +
> +		if (finger2_valid && finger1_valid) {
> +			if ((abs(finger2_pos[0] - finger1_pos[0]) < DELTA_MIN)
> +			|| (abs(finger2_pos[1] - finger1_pos[1]) < DELTA_MIN))
> +				goto report;


As far as I can see, the only thing that happens when two fingers are close to
each other is that the coordinate translation is not performed. Is that correct?

> +
> +			if (data->chip->x_flip)
> +				finger2_pos[0] = data->chip->touch_x_max -
> +								finger2_pos[0];
> +			if (data->chip->y_flip)
> +				finger2_pos[1] = data->chip->touch_y_max -
> +								finger2_pos[1];
> +			finger_down_count++;
> +		}
> +	}
> +
> +report:
> +	if ((finger_down_count <= 0) && (previous_press_reported)) {
> +		/* report pen up to input subsystem */
> +		input_report_key(data->in_dev, BTN_TOUCH, 0);
> +		input_report_abs(data->in_dev, ABS_MT_TOUCH_MAJOR, 0);
> +		input_report_abs(data->in_dev, ABS_MT_TOUCH_MINOR, 0);


The touch major/minor are for finger width, and should not be reported when not
available from the device.

> +		input_mt_sync(data->in_dev);
> +		input_sync(data->in_dev);
> +		previous_press_reported = false;
> +	} else if (finger_down_count > 0) {
> +		/* report pen down to input subsystem */
> +		input_report_abs(data->in_dev, ABS_X, finger1_pos[0]);
> +		input_report_abs(data->in_dev, ABS_Y, finger1_pos[1]);
> +		input_report_key(data->in_dev, BTN_TOUCH, 1);
> +
> +		rotate[0] = (finger1_pos[0] > finger1_pos[1]) ? 1 : 0;
> +		input_report_abs(data->in_dev, ABS_MT_TOUCH_MAJOR,
> +				max(finger1_pos[0], finger1_pos[1]));
> +		input_report_abs(data->in_dev, ABS_MT_TOUCH_MINOR,
> +				min(finger1_pos[0], finger1_pos[1]));
> +		input_report_abs(data->in_dev, ABS_MT_ORIENTATION,
> +						rotate[0]);


These lines report touch major/minor as a bounding box, which violates the
semantics of those fields.

> +		input_report_abs(data->in_dev, ABS_MT_POSITION_X,
> +						finger1_pos[0]);
> +		input_report_abs(data->in_dev, ABS_MT_POSITION_Y,
> +						finger1_pos[1]);
> +		input_mt_sync(data->in_dev);
> +		if (finger_down_count > 1) {
> +			rotate[1] = (finger2_pos[1] > finger2_pos[1]) ? 1 : 0;
> +			input_report_abs(data->in_dev, ABS_MT_TOUCH_MAJOR,
> +				max(finger2_pos[0], finger2_pos[1]));
> +			input_report_abs(data->in_dev, ABS_MT_TOUCH_MINOR,
> +				min(finger2_pos[0], finger2_pos[1]));
> +			input_report_abs(data->in_dev, ABS_MT_ORIENTATION,
> +						rotate[1]);
> +			input_report_abs(data->in_dev, ABS_MT_POSITION_X,
> +						finger2_pos[0]);
> +			input_report_abs(data->in_dev, ABS_MT_POSITION_Y,
> +						finger2_pos[1]);
> +			input_mt_sync(data->in_dev);
> +		}
> +		input_sync(data->in_dev);
> +		previous_press_reported = true;


In a previous comment about the previous_press_reported, what I really meant was
that it is not needed at all, since the state is already handled in the input
core. Please see the attached patch.

Thanks,
Henrik

--------------000008000009020404070507
Content-Type: text/x-diff;
 name="0001-input-ROHM-BU21013-touch-panel-controller-support.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-input-ROHM-BU21013-touch-panel-controller-support.patch"

>From 58e77f4c693b9593d6f1b81444dfd97396ddcab1 Mon Sep 17 00:00:00 2001
From: Henrik Rydberg <rydberg@euromail.se>
Date: Wed, 29 Sep 2010 11:30:50 +0200
Subject: [PATCH] input: ROHM BU21013 touch panel controller support

Simplifications for review.
---
 drivers/input/touchscreen/Kconfig      |   12 +
 drivers/input/touchscreen/Makefile     |    1 +
 drivers/input/touchscreen/bu21013_ts.c |  637 ++++++++++++++++++++++++++++++++
 include/linux/input/bu21013.h          |   44 +++
 4 files changed, 694 insertions(+), 0 deletions(-)
 create mode 100755 drivers/input/touchscreen/bu21013_ts.c
 create mode 100644 include/linux/input/bu21013.h

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 0069d97..2380533 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -98,6 +98,18 @@ config TOUCHSCREEN_BITSY
 	  To compile this driver as a module, choose M here: the
 	  module will be called h3600_ts_input.
 
+config TOUCHSCREEN_BU21013
+	tristate "BU21013 based touch panel controllers"
+	depends on I2C
+	help
+	  Say Y here if you have a bu21013 touchscreen connected to
+	  your system.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called bu21013_ts.
+
 config TOUCHSCREEN_CY8CTMG110
 	tristate "cy8ctmg110 touchscreen"
 	depends on I2C
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index 28217e1..a0a2021 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_TOUCHSCREEN_AD7879_SPI)	+= ad7879-spi.o
 obj-$(CONFIG_TOUCHSCREEN_ADS7846)	+= ads7846.o
 obj-$(CONFIG_TOUCHSCREEN_ATMEL_TSADCC)	+= atmel_tsadcc.o
 obj-$(CONFIG_TOUCHSCREEN_BITSY)		+= h3600_ts_input.o
+obj-$(CONFIG_TOUCHSCREEN_BU21013)       += bu21013_ts.o
 obj-$(CONFIG_TOUCHSCREEN_CY8CTMG110)	+= cy8ctmg110_ts.o
 obj-$(CONFIG_TOUCHSCREEN_DA9034)	+= da9034-ts.o
 obj-$(CONFIG_TOUCHSCREEN_DYNAPRO)	+= dynapro.o
diff --git a/drivers/input/touchscreen/bu21013_ts.c b/drivers/input/touchscreen/bu21013_ts.c
new file mode 100755
index 0000000..0e95543
--- /dev/null
+++ b/drivers/input/touchscreen/bu21013_ts.c
@@ -0,0 +1,637 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ * Author: Naveen Kumar G <naveen.gaddipati@stericsson.com> for ST-Ericsson
+ * License terms:GNU General Public License (GPL) version 2
+ */
+
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/i2c.h>
+#include <linux/workqueue.h>
+#include <linux/input.h>
+#include <linux/input/bu21013.h>
+#include <linux/slab.h>
+
+#define PEN_DOWN_INTR	0
+#define MAX_FINGERS	2
+#define RESET_DELAY	30
+#define PENUP_TIMEOUT	(10)
+#define DELTA_MIN	16
+#define MASK_BITS	0x03
+#define SHIFT_8		8
+#define SHIFT_2		2
+#define LENGTH_OF_BUFFER	11
+#define I2C_RETRY_COUNT	5
+
+#define BU21013_SENSORS_BTN_0_7_REG	0x70
+#define BU21013_SENSORS_BTN_8_15_REG	0x71
+#define BU21013_SENSORS_BTN_16_23_REG	0x72
+#define BU21013_X1_POS_MSB_REG		0x73
+#define BU21013_X1_POS_LSB_REG		0x74
+#define BU21013_Y1_POS_MSB_REG		0x75
+#define BU21013_Y1_POS_LSB_REG		0x76
+#define BU21013_X2_POS_MSB_REG		0x77
+#define BU21013_X2_POS_LSB_REG		0x78
+#define BU21013_Y2_POS_MSB_REG		0x79
+#define BU21013_Y2_POS_LSB_REG		0x7A
+#define BU21013_INT_CLR_REG		0xE8
+#define BU21013_INT_MODE_REG		0xE9
+#define BU21013_GAIN_REG		0xEA
+#define BU21013_OFFSET_MODE_REG		0xEB
+#define BU21013_XY_EDGE_REG		0xEC
+#define BU21013_RESET_REG		0xED
+#define BU21013_CALIB_REG		0xEE
+#define BU21013_DONE_REG		0xEF
+#define BU21013_SENSOR_0_7_REG		0xF0
+#define BU21013_SENSOR_8_15_REG		0xF1
+#define BU21013_SENSOR_16_23_REG	0xF2
+#define BU21013_POS_MODE1_REG		0xF3
+#define BU21013_POS_MODE2_REG		0xF4
+#define BU21013_CLK_MODE_REG		0xF5
+#define BU21013_IDLE_REG		0xFA
+#define BU21013_FILTER_REG		0xFB
+#define BU21013_TH_ON_REG		0xFC
+#define BU21013_TH_OFF_REG		0xFD
+
+
+#define BU21013_RESET_ENABLE		0x01
+
+#define BU21013_SENSORS_EN_0_7		0x3F
+#define BU21013_SENSORS_EN_8_15		0xFC
+#define BU21013_SENSORS_EN_16_23	0x1F
+
+#define BU21013_POS_MODE1_0		0x02
+#define BU21013_POS_MODE1_1		0x04
+#define BU21013_POS_MODE1_2		0x08
+
+#define BU21013_POS_MODE2_ZERO		0x01
+#define BU21013_POS_MODE2_AVG1		0x02
+#define BU21013_POS_MODE2_AVG2		0x04
+#define BU21013_POS_MODE2_EN_XY		0x08
+#define BU21013_POS_MODE2_EN_RAW	0x10
+#define BU21013_POS_MODE2_MULTI		0x80
+
+#define BU21013_CLK_MODE_DIV		0x01
+#define BU21013_CLK_MODE_EXT		0x02
+#define BU21013_CLK_MODE_CALIB		0x80
+
+#define BU21013_IDLET_0			0x01
+#define BU21013_IDLET_1			0x02
+#define BU21013_IDLET_2			0x04
+#define BU21013_IDLET_3			0x08
+#define BU21013_IDLE_INTERMIT_EN	0x10
+
+#define BU21013_DELTA_0_6	0x7F
+#define BU21013_FILTER_EN	0x80
+
+#define BU21013_INT_MODE_LEVEL	0x00
+#define BU21013_INT_MODE_EDGE	0x01
+
+#define BU21013_GAIN_0		0x01
+#define BU21013_GAIN_1		0x02
+#define BU21013_GAIN_2		0x04
+
+#define BU21013_OFFSET_MODE_DEFAULT	0x00
+#define BU21013_OFFSET_MODE_MOVE	0x01
+#define BU21013_OFFSET_MODE_DISABLE	0x02
+
+#define BU21013_TH_ON_0		0x01
+#define BU21013_TH_ON_1		0x02
+#define BU21013_TH_ON_2		0x04
+#define BU21013_TH_ON_3		0x08
+#define BU21013_TH_ON_4		0x10
+#define BU21013_TH_ON_5		0x20
+#define BU21013_TH_ON_6		0x40
+#define BU21013_TH_ON_7		0x80
+#define BU21013_TH_ON_MAX	0xFF
+
+#define BU21013_TH_OFF_0	0x01
+#define BU21013_TH_OFF_1	0x02
+#define BU21013_TH_OFF_2	0x04
+#define BU21013_TH_OFF_3	0x08
+#define BU21013_TH_OFF_4	0x10
+#define BU21013_TH_OFF_5	0x20
+#define BU21013_TH_OFF_6	0x40
+#define BU21013_TH_OFF_7	0x80
+#define BU21013_TH_OFF_MAX	0xFF
+
+#define BU21013_X_EDGE_0	0x01
+#define BU21013_X_EDGE_1	0x02
+#define BU21013_X_EDGE_2	0x04
+#define BU21013_X_EDGE_3	0x08
+#define BU21013_Y_EDGE_0	0x10
+#define BU21013_Y_EDGE_1	0x20
+#define BU21013_Y_EDGE_2	0x40
+#define BU21013_Y_EDGE_3	0x80
+
+#define BU21013_DONE	0x01
+#define BU21013_NUMBER_OF_X_SENSORS	(6)
+#define BU21013_NUMBER_OF_Y_SENSORS	(11)
+
+#define DRIVER_TP	"bu21013_ts"
+
+/**
+ * struct bu21013_ts_data - touch panel data structure
+ * @client: pointer to the i2c client
+ * @wait: variable to wait_queue_head_t structure
+ * @touch_stopped: touch stop flag
+ * @chip: pointer to the touch panel controller
+ * @in_dev: pointer to the input device structure
+ * @intr_pin: interrupt pin value
+ *
+ * Touch panel device data structure
+ */
+struct bu21013_ts_data {
+	struct i2c_client *client;
+	wait_queue_head_t wait;
+	bool touch_stopped;
+	const struct bu21013_platform_device *chip;
+	struct input_dev *in_dev;
+	unsigned int intr_pin;
+};
+
+static int bu21013_read_block_data(struct bu21013_ts_data *data, u8 *buf)
+{
+	int ret, i;
+
+	for (i = 0; i < I2C_RETRY_COUNT; i++) {
+		ret = i2c_smbus_read_i2c_block_data
+			(data->client, BU21013_SENSORS_BTN_0_7_REG,
+				LENGTH_OF_BUFFER, buf);
+		if (ret == LENGTH_OF_BUFFER)
+			return 0;
+	}
+
+	return -EINVAL;
+}
+
+/**
+ * bu21013_do_touch_report(): Get the touch co-ordinates
+ * @data: bu21013_ts_data structure pointer
+ *
+ * Get the touch co-ordinates from touch sensor registers and writes
+ * into device structure and returns integer.
+ */
+static int bu21013_do_touch_report(struct bu21013_ts_data *data)
+{
+	u8	buf[LENGTH_OF_BUFFER];
+	unsigned int pos_x[2], pos_y[2];
+	bool	has_x_sensors, has_y_sensors;
+	int	finger_down_count = 0;
+	int	i;
+
+	if (data == NULL)
+		return -EINVAL;
+
+	if (bu21013_read_block_data(data, buf))
+		return -EINVAL;
+
+	has_x_sensors = hweight32(buf[0] & BU21013_SENSORS_EN_0_7);
+	has_y_sensors = hweight32(
+			((buf[1] & BU21013_SENSORS_EN_8_15) |
+		((buf[2] & BU21013_SENSORS_EN_16_23) << SHIFT_8)) >> SHIFT_2);
+	if (has_x_sensors ^ has_y_sensors)
+		return 0;
+	if (!has_x_sensors && !has_y_sensors)
+		goto report;
+
+	for (i = 0; i < 2; i++) {
+		const u8 *p = &buf[4 * i + 3];
+		unsigned int x = p[0] << SHIFT_2 | (p[1] & MASK_BITS);
+		unsigned int y = p[2] << SHIFT_2 | (p[3] & MASK_BITS);
+		if (x == 0 || y == 0)
+			continue;
+		pos_x[finger_down_count] = x;
+		pos_y[finger_down_count] = y;
+		finger_down_count++;
+	}
+
+	/* should this really be ignored? */
+	if (finger_down_count == 0)
+		return 0;
+
+	/* should this really be ignored? */
+	if (finger_down_count == 2 &&
+	    (abs(pos_x[0] - pos_x[1]) < DELTA_MIN ||
+	     abs(pos_y[0] - pos_y[1]) < DELTA_MIN))
+		return 0;
+
+	for (i = 0; i < finger_down_count; i++) {
+		if (data->chip->x_flip)
+			pos_x[i] = data->chip->touch_x_max - pos_x[i];
+		if (data->chip->y_flip)
+			pos_y[i] = data->chip->touch_y_max - pos_y[i];
+	}
+
+report:
+
+	for (i = 0; i < finger_down_count; i++) {
+		input_report_abs(data->in_dev, ABS_MT_POSITION_X, pos_x[i]);
+		input_report_abs(data->in_dev, ABS_MT_POSITION_Y, pos_y[i]);
+		input_mt_sync(data->in_dev);
+	}
+
+	if (finger_down_count > 0) {
+		input_report_key(data->in_dev, BTN_TOUCH, 1);
+		input_report_abs(data->in_dev, ABS_X, pos_x[0]);
+		input_report_abs(data->in_dev, ABS_Y, pos_y[0]);
+	} else {
+		input_report_key(data->in_dev, BTN_TOUCH, 0);
+	}
+
+	input_sync(data->in_dev);
+
+	return 0;
+}
+
+/**
+ * bu21013_gpio_irq() - gpio thread function for touch interrupt
+ * @irq: irq value
+ * @device_data: void pointer
+ *
+ * This gpio thread function for touch interrupt
+ * and returns irqreturn_t.
+ */
+static irqreturn_t bu21013_gpio_irq(int irq, void *device_data)
+{
+	struct bu21013_ts_data *data = device_data;
+	struct i2c_client *i2c = data->client;
+	int retval;
+
+	do {
+		retval = bu21013_do_touch_report(data);
+		if (retval < 0) {
+			dev_err(&i2c->dev, "bu21013_do_touch_report failed\n");
+			return IRQ_NONE;
+		}
+
+		data->intr_pin = data->chip->irq_read_val();
+		if (data->intr_pin == PEN_DOWN_INTR)
+			wait_event_timeout(data->wait, data->touch_stopped,
+							msecs_to_jiffies(10));
+	} while (!data->intr_pin && !data->touch_stopped);
+	return IRQ_HANDLED;
+}
+
+/**
+ * bu21013_init_chip() - power on sequence for the bu21013 controller
+ * @data: device structure pointer
+ *
+ * This function is used to power on
+ * the bu21013 controller and returns integer.
+ */
+static int bu21013_init_chip(struct bu21013_ts_data *data)
+{
+	int retval;
+	struct i2c_client *i2c = data->client;
+
+	retval = i2c_smbus_write_byte_data(i2c, BU21013_RESET_REG,
+					BU21013_RESET_ENABLE);
+	if (retval < 0) {
+		dev_err(&i2c->dev, "BU21013_RESET reg write failed\n");
+		return retval;
+	}
+	msleep(RESET_DELAY);
+
+	retval = i2c_smbus_write_byte_data(i2c, BU21013_SENSOR_0_7_REG,
+					BU21013_SENSORS_EN_0_7);
+	if (retval < 0) {
+		dev_err(&i2c->dev, "BU21013_SENSOR_0_7 reg write failed\n");
+		return retval;
+	}
+	retval = i2c_smbus_write_byte_data(i2c, BU21013_SENSOR_8_15_REG,
+						BU21013_SENSORS_EN_8_15);
+	if (retval < 0) {
+		dev_err(&i2c->dev, "BU21013_SENSOR_8_15 reg write failed\n");
+		return retval;
+	}
+	retval = i2c_smbus_write_byte_data(i2c, BU21013_SENSOR_16_23_REG,
+						BU21013_SENSORS_EN_16_23);
+	if (retval < 0) {
+		dev_err(&i2c->dev, "BU21013_SENSOR_16_23 reg write failed\n");
+		return retval;
+	}
+	retval = i2c_smbus_write_byte_data(i2c, BU21013_POS_MODE1_REG,
+				(BU21013_POS_MODE1_0 | BU21013_POS_MODE1_1));
+	if (retval < 0) {
+		dev_err(&i2c->dev, "BU21013_POS_MODE1 reg write failed\n");
+		return retval;
+	}
+	retval = i2c_smbus_write_byte_data(i2c, BU21013_POS_MODE2_REG,
+			(BU21013_POS_MODE2_ZERO | BU21013_POS_MODE2_AVG1 |
+			BU21013_POS_MODE2_AVG2 | BU21013_POS_MODE2_EN_RAW |
+			BU21013_POS_MODE2_MULTI));
+	if (retval < 0) {
+		dev_err(&i2c->dev, "BU21013_POS_MODE2 reg write failed\n");
+		return retval;
+	}
+	if (data->chip->ext_clk)
+		retval = i2c_smbus_write_byte_data(i2c, BU21013_CLK_MODE_REG,
+			(BU21013_CLK_MODE_EXT | BU21013_CLK_MODE_CALIB));
+	else
+		retval = i2c_smbus_write_byte_data(i2c, BU21013_CLK_MODE_REG,
+			(BU21013_CLK_MODE_DIV | BU21013_CLK_MODE_CALIB));
+	if (retval < 0) {
+		dev_err(&i2c->dev, "BU21013_CLK_MODE reg write failed\n");
+		return retval;
+	}
+	retval = i2c_smbus_write_byte_data(i2c, BU21013_IDLE_REG,
+				(BU21013_IDLET_0 | BU21013_IDLE_INTERMIT_EN));
+	if (retval < 0) {
+		dev_err(&i2c->dev, "BU21013_IDLE reg write failed\n");
+		return retval;
+	}
+	retval = i2c_smbus_write_byte_data(i2c, BU21013_INT_MODE_REG,
+						BU21013_INT_MODE_LEVEL);
+	if (retval < 0) {
+		dev_err(&i2c->dev, "BU21013_INT_MODE reg write failed\n");
+		return retval;
+	}
+	retval = i2c_smbus_write_byte_data(i2c, BU21013_FILTER_REG,
+						(BU21013_DELTA_0_6 |
+							BU21013_FILTER_EN));
+	if (retval < 0) {
+		dev_err(&i2c->dev, "BU21013_FILTER reg write failed\n");
+		return retval;
+	}
+
+	retval = i2c_smbus_write_byte_data(i2c, BU21013_TH_ON_REG,
+					BU21013_TH_ON_5);
+	if (retval < 0) {
+		dev_err(&i2c->dev, "BU21013_TH_ON reg write failed\n");
+		return retval;
+	}
+	retval = i2c_smbus_write_byte_data(i2c, BU21013_TH_OFF_REG,
+					BU21013_TH_OFF_4 || BU21013_TH_OFF_3);
+	if (retval < 0) {
+		dev_err(&i2c->dev, "BU21013_TH_OFF reg write failed\n");
+		return retval;
+	}
+	retval = i2c_smbus_write_byte_data(i2c, BU21013_GAIN_REG,
+					(BU21013_GAIN_0 | BU21013_GAIN_1));
+	if (retval < 0) {
+		dev_err(&i2c->dev, "BU21013_GAIN reg write failed\n");
+		return retval;
+	}
+
+	retval = i2c_smbus_write_byte_data(i2c, BU21013_OFFSET_MODE_REG,
+					BU21013_OFFSET_MODE_DEFAULT);
+	if (retval < 0) {
+		dev_err(&i2c->dev, "BU21013_OFFSET_MODE reg write failed\n");
+		return retval;
+	}
+	retval = i2c_smbus_write_byte_data(i2c, BU21013_XY_EDGE_REG,
+				(BU21013_X_EDGE_0 | BU21013_X_EDGE_2 |
+				BU21013_Y_EDGE_1 | BU21013_Y_EDGE_3));
+	if (retval < 0) {
+		dev_err(&i2c->dev, "BU21013_XY_EDGE reg write failed\n");
+		return retval;
+	}
+	retval = i2c_smbus_write_byte_data(i2c, BU21013_DONE_REG,
+							BU21013_DONE);
+	if (retval < 0) {
+		dev_err(&i2c->dev, "BU21013_REG_DONE reg write failed\n");
+		return retval;
+	}
+
+	return retval;
+}
+
+/**
+ * bu21013_probe() - initialzes the i2c-client touchscreen driver
+ * @client: i2c client structure pointer
+ * @id: i2c device id pointer
+ *
+ * This function used to initializes the i2c-client touchscreen
+ * driver and returns integer.
+ */
+static int __devinit bu21013_probe(struct i2c_client *client,
+					const struct i2c_device_id *id)
+{
+	int retval;
+	struct bu21013_ts_data *bu21013_data;
+	struct input_dev *in_dev;
+	const struct bu21013_platform_device *pdata =
+					client->dev.platform_data;
+
+	if (!i2c_check_functionality(client->adapter,
+					I2C_FUNC_SMBUS_BYTE_DATA)) {
+		dev_err(&client->dev, "i2c smbus byte data not supported\n");
+		return -EIO;
+	}
+
+	if (!pdata) {
+		dev_err(&client->dev, "platform data not defined\n");
+		retval = -EINVAL;
+		return retval;
+	}
+
+	bu21013_data = kzalloc(sizeof(struct bu21013_ts_data), GFP_KERNEL);
+	if (!bu21013_data) {
+		dev_err(&client->dev, "device memory alloc failed\n");
+		retval = -ENOMEM;
+		return retval;
+	}
+	/* allocate input device */
+	in_dev = input_allocate_device();
+	if (!in_dev) {
+		dev_err(&client->dev, "input device memory alloc failed\n");
+		retval = -ENOMEM;
+		goto err_alloc;
+	}
+	bu21013_data->in_dev = in_dev;
+	bu21013_data->chip = pdata;
+	bu21013_data->client = client;
+
+	/* configure the gpio pins */
+	if (pdata->cs_en) {
+		retval = pdata->cs_en(pdata->cs_pin);
+		if (retval < 0) {
+			dev_err(&client->dev, "chip init failed\n");
+			goto err_init_cs;
+		}
+	}
+
+	/* configure the touch panel controller */
+	retval = bu21013_init_chip(bu21013_data);
+	if (retval < 0) {
+		dev_err(&client->dev, "error in bu21013 config\n");
+		goto err_init_config;
+	}
+
+	init_waitqueue_head(&bu21013_data->wait);
+	bu21013_data->touch_stopped = false;
+	i2c_set_clientdata(client, bu21013_data);
+
+	/* register the device to input subsystem */
+	in_dev->name = DRIVER_TP;
+	in_dev->id.bustype = BUS_I2C;
+	in_dev->dev.parent = &client->dev;
+	input_set_drvdata(in_dev, bu21013_data);
+
+	__set_bit(EV_SYN, in_dev->evbit);
+	__set_bit(EV_KEY, in_dev->evbit);
+	__set_bit(EV_ABS, in_dev->evbit);
+	__set_bit(BTN_TOUCH, in_dev->keybit);
+
+	input_set_abs_params(in_dev, ABS_X, 0, pdata->x_max_res, 0, 0);
+	input_set_abs_params(in_dev, ABS_Y, 0, pdata->y_max_res, 0, 0);
+	input_set_abs_params(in_dev, ABS_MT_POSITION_X, 0,
+						pdata->x_max_res, 0, 0);
+	input_set_abs_params(in_dev, ABS_MT_POSITION_Y, 0,
+						pdata->y_max_res, 0, 0);
+
+	retval = input_register_device(in_dev);
+	if (retval)
+		goto err_input_register;
+
+	retval = request_threaded_irq(pdata->irq, NULL, bu21013_gpio_irq,
+					(IRQF_TRIGGER_FALLING | IRQF_SHARED),
+					DRIVER_TP, bu21013_data);
+	if (retval) {
+		dev_err(&client->dev, "request irq %d failed\n", pdata->irq);
+		goto err_init_irq;
+	}
+
+	device_init_wakeup(&client->dev, pdata->wakeup);
+
+	return retval;
+
+err_init_irq:
+	input_unregister_device(bu21013_data->in_dev);
+	bu21013_data->in_dev = NULL;
+err_input_register:
+err_init_config:
+	pdata->cs_dis(pdata->cs_pin);
+err_init_cs:
+	input_free_device(bu21013_data->in_dev);
+err_alloc:
+	kfree(bu21013_data);
+
+	return retval;
+}
+/**
+ * bu21013_remove() - removes the i2c-client touchscreen driver
+ * @client: i2c client structure pointer
+ *
+ * This function uses to remove the i2c-client
+ * touchscreen driver and returns integer.
+ */
+static int __devexit bu21013_remove(struct i2c_client *client)
+{
+	struct bu21013_ts_data *bu21013_data = i2c_get_clientdata(client);
+
+	bu21013_data->touch_stopped = true;
+	wake_up(&bu21013_data->wait);
+	device_init_wakeup(&client->dev, false);
+	free_irq(bu21013_data->chip->irq, bu21013_data);
+	bu21013_data->chip->cs_dis(bu21013_data->chip->cs_pin);
+	input_unregister_device(bu21013_data->in_dev);
+	kfree(bu21013_data);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+/**
+ * bu21013_suspend() - suspend the touch screen controller
+ * @dev: pointer to device structure
+ *
+ * This function is used to suspend the
+ * touch panel controller and returns integer
+ */
+static int bu21013_suspend(struct device *dev)
+{
+	struct bu21013_ts_data *bu21013_data = dev_get_drvdata(dev);
+	struct i2c_client *client = bu21013_data->client;
+
+	bu21013_data->touch_stopped = true;
+	if (device_may_wakeup(&client->dev))
+		enable_irq_wake(bu21013_data->chip->irq);
+	else
+		disable_irq(bu21013_data->chip->irq);
+
+	return 0;
+}
+
+/**
+ * bu21013_resume() - resume the touch screen controller
+ * @dev: pointer to device structure
+ *
+ * This function is used to resume the touch panel
+ * controller and returns integer.
+ */
+static int bu21013_resume(struct device *dev)
+{
+	struct bu21013_ts_data *bu21013_data = dev_get_drvdata(dev);
+	struct i2c_client *client = bu21013_data->client;
+	int retval;
+
+	retval = bu21013_init_chip(bu21013_data);
+	if (retval < 0) {
+		dev_err(&client->dev, "bu21013 controller config failed\n");
+		return retval;
+	}
+	bu21013_data->touch_stopped = false;
+	if (device_may_wakeup(&client->dev))
+		disable_irq_wake(bu21013_data->chip->irq);
+	else
+		enable_irq(bu21013_data->chip->irq);
+
+	return 0;
+}
+
+static const struct dev_pm_ops bu21013_dev_pm_ops = {
+	.suspend = bu21013_suspend,
+	.resume  = bu21013_resume,
+};
+#endif
+
+static const struct i2c_device_id bu21013_id[] = {
+	{ DRIVER_TP, 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, bu21013_id);
+
+static struct i2c_driver bu21013_driver = {
+	.driver	= {
+		.name	=	DRIVER_TP,
+		.owner	=	THIS_MODULE,
+#ifdef CONFIG_PM
+		.pm	=	&bu21013_dev_pm_ops,
+#endif
+	},
+	.probe		=	bu21013_probe,
+	.remove		=	__devexit_p(bu21013_remove),
+	.id_table	=	bu21013_id,
+};
+
+/**
+ * bu21013_init() - initializes the bu21013 touchscreen driver
+ *
+ * This function used to initializes the bu21013
+ * touchscreen driver and returns integer.
+ */
+static int __init bu21013_init(void)
+{
+	return i2c_add_driver(&bu21013_driver);
+}
+
+/**
+ * bu21013_exit() - de-initializes the bu21013 touchscreen driver
+ *
+ * This function uses to de-initializes the bu21013
+ * touchscreen driver and returns none.
+ */
+static void __exit bu21013_exit(void)
+{
+	i2c_del_driver(&bu21013_driver);
+}
+
+module_init(bu21013_init);
+module_exit(bu21013_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Naveen Kumar G <naveen.gaddipati@stericsson.com>");
+MODULE_DESCRIPTION("bu21013 touch screen controller driver");
diff --git a/include/linux/input/bu21013.h b/include/linux/input/bu21013.h
new file mode 100644
index 0000000..e470d38
--- /dev/null
+++ b/include/linux/input/bu21013.h
@@ -0,0 +1,44 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ * Author: Naveen Kumar G <naveen.gaddipati@stericsson.com> for ST-Ericsson
+ * License terms:GNU General Public License (GPL) version 2
+ */
+
+#ifndef _BU21013_H
+#define _BU21013_H
+
+/**
+ * struct bu21013_platform_device - Handle the platform data
+ * @cs_en:	pointer to the cs enable function
+ * @cs_dis:	pointer to the cs disable function
+ * @irq_read_val:    pointer to read the pen irq value function
+ * @x_max_res: xmax resolution
+ * @y_max_res: ymax resolution
+ * @touch_x_max: touch x max
+ * @touch_y_max: touch y max
+ * @cs_pin: chip select pin
+ * @irq: irq pin
+ * @ext_clk: external clock flag
+ * @x_flip: x flip flag
+ * @y_flip: y flip flag
+ * @wakeup: wakeup flag
+ *
+ * This is used to handle the platform data
+ */
+struct bu21013_platform_device {
+	int (*cs_en)(int reset_pin);
+	int (*cs_dis)(int reset_pin);
+	int (*irq_read_val)(void);
+	int x_max_res;
+	int y_max_res;
+	int touch_x_max;
+	int touch_y_max;
+	unsigned int cs_pin;
+	unsigned int irq;
+	bool ext_clk;
+	bool x_flip;
+	bool y_flip;
+	bool wakeup;
+};
+
+#endif
-- 
1.7.1


--------------000008000009020404070507--
