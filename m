From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] input: add synaptics_i2c driver
Date: Thu, 11 Jun 2009 00:14:29 -0700
Message-ID: <20090611071428.GC8035@dtor-d630.eng.vmware.com>
References: <4A13F941.7040301@compulab.co.il> <200906020458.56763.dmitry.torokhov@gmail.com> <4A262D5F.1070803@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.230]:10439 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756379AbZFKHUY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Jun 2009 03:20:24 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1849184rvb.5
        for <linux-input@vger.kernel.org>; Thu, 11 Jun 2009 00:20:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4A262D5F.1070803@compulab.co.il>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: Jean Delvare <khali@linux-fr.org>, grinberg <grinberg@compulab.co.il>, linux-input <linux-input@vger.kernel.org>

Hi Mike,

On Wed, Jun 03, 2009 at 10:59:27AM +0300, Mike Rapoport wrote:
> 
> This driver supports Synaptics I2C touchpad controller on eXeda
> mobile device.
> 
>

Looks much better, one concern still though:
 
> +
> +/* Work Handler */
> +static void synaptics_i2c_work_handler(struct work_struct *work)
> +{
> +	int data = 1;
> +	struct synaptics_i2c *touch =
> +			container_of(work, struct synaptics_i2c, dwork.work);
> +	unsigned long delay;
> +
> +	synaptics_i2c_check_params(touch);
> +
> +	do {
> +		data = synaptics_i2c_get_input(touch);
> +		delay = synaptics_i2c_fix_delay(touch, data);
> +	} while (data);
> +

This will spin in the work handler for the duration of the touch
hogging keventd on this CPU and delaying all other scheduled works. I
don't think we can do that.

Please try the patchg below and if it still works I will fold it all
together and queue for upstream. Thanks!

-- 
Dmitry

Input: synaptics_i2c fixups

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/mouse/synaptics_i2c.c |   94 ++++++++++++++++++++---------------
 1 files changed, 53 insertions(+), 41 deletions(-)


diff --git a/drivers/input/mouse/synaptics_i2c.c b/drivers/input/mouse/synaptics_i2c.c
index 32a5d87..eac9fdd 100644
--- a/drivers/input/mouse/synaptics_i2c.c
+++ b/drivers/input/mouse/synaptics_i2c.c
@@ -241,10 +241,10 @@ static s32 synaptics_i2c_reg_get(struct i2c_client *client, u16 reg)
 	int ret;
 
 	ret = i2c_smbus_write_byte_data(client, PAGE_SEL_REG, reg >> 8);
-	if (ret)
-		return ret;
+	if (ret == 0)
+		ret = i2c_smbus_read_byte_data(client, reg & 0xff);
 
-	return i2c_smbus_read_byte_data(client, reg & 0xff);
+	return ret;
 }
 
 static s32 synaptics_i2c_reg_set(struct i2c_client *client, u16 reg, u8 val)
@@ -252,10 +252,10 @@ static s32 synaptics_i2c_reg_set(struct i2c_client *client, u16 reg, u8 val)
 	int ret;
 
 	ret = i2c_smbus_write_byte_data(client, PAGE_SEL_REG, reg >> 8);
-	if (ret)
-		return ret;
+	if (ret == 0)
+		ret = i2c_smbus_write_byte_data(client, reg & 0xff, val);
 
-	return i2c_smbus_write_byte_data(client, reg & 0xff, val);
+	return ret;
 }
 
 static s32 synaptics_i2c_word_get(struct i2c_client *client, u16 reg)
@@ -263,10 +263,10 @@ static s32 synaptics_i2c_word_get(struct i2c_client *client, u16 reg)
 	int ret;
 
 	ret = i2c_smbus_write_byte_data(client, PAGE_SEL_REG, reg >> 8);
-	if (ret)
-		return ret;
+	if (ret == 0)
+		ret = i2c_smbus_read_word_data(client, reg & 0xff);
 
-	return i2c_smbus_read_word_data(client, reg & 0xff);
+	return ret;
 }
 
 static int synaptics_i2c_config(struct i2c_client *client)
@@ -287,11 +287,11 @@ static int synaptics_i2c_config(struct i2c_client *client)
 
 	control = synaptics_i2c_reg_get(client, GENERAL_2D_CONTROL_REG);
 	/* No Deceleration */
-	control |= (no_decel) ? 1 << NO_DECELERATION : 0;
+	control |= no_decel ? 1 << NO_DECELERATION : 0;
 	/* Reduced Reporting */
-	control |= (reduce_report) ? 1 << REDUCE_REPORTING : 0;
+	control |= reduce_report ? 1 << REDUCE_REPORTING : 0;
 	/* No Filter */
-	control |= (no_filter) ? 1 << NO_FILTER : 0;
+	control |= no_filter ? 1 << NO_FILTER : 0;
 	ret = synaptics_i2c_reg_set(client, GENERAL_2D_CONTROL_REG, control);
 	if (ret)
 		return ret;
@@ -302,6 +302,7 @@ static int synaptics_i2c_config(struct i2c_client *client)
 static int synaptics_i2c_reset_config(struct i2c_client *client)
 {
 	int ret;
+
 	/* Reset the Touchpad */
 	ret = synaptics_i2c_reg_set(client, DEV_COMMAND_REG, RESET_COMMAND);
 	if (ret) {
@@ -329,10 +330,11 @@ static int synaptics_i2c_check_error(struct i2c_client *client)
 	return ret;
 }
 
-static int synaptics_i2c_get_input(struct synaptics_i2c *touch)
+static bool synaptics_i2c_get_input(struct synaptics_i2c *touch)
 {
 	struct input_dev *input = touch->input;
 	int xy_delta, gesture;
+	s32 data;
 	s8 x_delta, y_delta;
 
 	/* Deal with spontanious resets and errors */
@@ -340,8 +342,8 @@ static int synaptics_i2c_get_input(struct synaptics_i2c *touch)
 		return 0;
 
 	/* Get Gesture Bit */
-	gesture = (synaptics_i2c_reg_get(touch->client, DATA_REG0)
-							>> GESTURE) & 0x1;
+	data = synaptics_i2c_reg_get(touch->client, DATA_REG0);
+	gesture = (data >> GESTURE) & 0x1;
 
 	/*
 	 * Get Relative axes. we have to get them in one shot,
@@ -361,7 +363,7 @@ static int synaptics_i2c_get_input(struct synaptics_i2c *touch)
 	input_report_rel(input, REL_Y, -y_delta);
 	input_sync(input);
 
-	return (xy_delta || gesture) ? 1 : 0;
+	return xy_delta || gesture;
 }
 
 static irqreturn_t synaptics_i2c_irq(int irq, void *dev_id)
@@ -369,8 +371,9 @@ static irqreturn_t synaptics_i2c_irq(int irq, void *dev_id)
 	struct synaptics_i2c *touch = dev_id;
 
 	/*
-	 * This cancels the work scheduled in work handler.
-	 * See explanation on this in work handler func.
+	 * We want to have the work run immediately but it might have
+	 * already been scheduled with a delay, that's why we have to
+	 * cancel it first.
 	 */
 	cancel_delayed_work(&touch->dwork);
 	schedule_delayed_work(&touch->dwork, 0);
@@ -380,34 +383,39 @@ static irqreturn_t synaptics_i2c_irq(int irq, void *dev_id)
 
 static void synaptics_i2c_check_params(struct synaptics_i2c *touch)
 {
-	int reset = 0;
+	bool reset = false;
+
 	if (scan_rate != touch->scan_rate_param)
 		set_scan_rate(touch, scan_rate);
 
 	if (no_decel != touch->no_decel_param) {
 		touch->no_decel_param = no_decel;
-		reset = 1;
+		reset = true;
 	}
+
 	if (no_filter != touch->no_filter_param) {
 		touch->no_filter_param = no_filter;
-		reset = 1;
+		reset = true;
 	}
+
 	if (reduce_report != touch->reduce_report_param) {
 		touch->reduce_report_param = reduce_report;
-		reset = 1;
+		reset = true;
 	}
+
 	if (reset)
 		synaptics_i2c_reset_config(touch->client);
 }
 
 /* Control the Device polling rate / Work Handler sleep time */
-unsigned long synaptics_i2c_fix_delay(struct synaptics_i2c *touch, int data)
+unsigned long synaptics_i2c_adjust_delay(struct synaptics_i2c *touch,
+					 bool have_data)
 {
-	int delay, nodata_count_thres;
+	unsigned long delay, nodata_count_thres;
 
 	if (polling_req) {
 		delay = touch->scan_ms;
-		if (data) {
+		if (have_data) {
 			touch->no_data_count = 0;
 		} else {
 			nodata_count_thres = NO_DATA_THRES / touch->scan_ms;
@@ -416,26 +424,25 @@ unsigned long synaptics_i2c_fix_delay(struct synaptics_i2c *touch, int data)
 			else
 				delay = NO_DATA_SLEEP_MSECS;
 		}
-	} else
-		delay = THREAD_IRQ_SLEEP_MSECS;
-
-	return msecs_to_jiffies(delay);
+		return msecs_to_jiffies(delay);
+	} else {
+		delay = msecs_to_jiffies(THREAD_IRQ_SLEEP_MSECS);
+		return round_jiffies_relative(delay);
+	}
 }
 
 /* Work Handler */
 static void synaptics_i2c_work_handler(struct work_struct *work)
 {
-	int data = 1;
+	bool have_data;
 	struct synaptics_i2c *touch =
 			container_of(work, struct synaptics_i2c, dwork.work);
 	unsigned long delay;
 
 	synaptics_i2c_check_params(touch);
 
-	do {
-		data = synaptics_i2c_get_input(touch);
-		delay = synaptics_i2c_fix_delay(touch, data);
-	} while (data);
+	have_data = synaptics_i2c_get_input(touch);
+	delay = synaptics_i2c_adjust_delay(touch, have_data);
 
 	/*
 	 * While interrupt driven, there is no real need to poll the device.
@@ -450,8 +457,8 @@ static void synaptics_i2c_work_handler(struct work_struct *work)
 
 static int synaptics_i2c_open(struct input_dev *input)
 {
-	int ret = 0;
 	struct synaptics_i2c *touch = input_get_drvdata(input);
+	int ret;
 
 	ret = synaptics_i2c_reset_config(touch->client);
 	if (ret)
@@ -461,7 +468,7 @@ static int synaptics_i2c_open(struct input_dev *input)
 		schedule_delayed_work(&touch->dwork,
 				       msecs_to_jiffies(NO_DATA_SLEEP_MSECS));
 
-	return ret;
+	return 0;
 }
 
 static void synaptics_i2c_close(struct input_dev *input)
@@ -492,13 +499,13 @@ static void synaptics_i2c_set_input_params(struct synaptics_i2c *touch)
 	input_set_drvdata(input, touch);
 
 	/* Register the device as mouse */
-	set_bit(EV_REL, input->evbit);
-	set_bit(REL_X, input->relbit);
-	set_bit(REL_Y, input->relbit);
+	__set_bit(EV_REL, input->evbit);
+	__set_bit(REL_X, input->relbit);
+	__set_bit(REL_Y, input->relbit);
 
 	/* Register device's buttons and keys */
-	set_bit(EV_KEY, input->evbit);
-	set_bit(BTN_LEFT, input->keybit);
+	__set_bit(EV_KEY, input->evbit);
+	__set_bit(BTN_LEFT, input->keybit);
 }
 
 struct synaptics_i2c *synaptics_i2c_touch_create(struct i2c_client *client)
@@ -598,6 +605,7 @@ static int __devexit synaptics_i2c_remove(struct i2c_client *client)
 	return 0;
 }
 
+#ifdef CONFIG_PM
 static int synaptics_i2c_suspend(struct i2c_client *client, pm_message_t mesg)
 {
 	struct synaptics_i2c *touch = i2c_get_clientdata(client);
@@ -624,6 +632,10 @@ static int synaptics_i2c_resume(struct i2c_client *client)
 
 	return 0;
 }
+#else
+#define synaptics_i2c_suspend	NULL
+#define synaptics_i2c_resume	NULL
+#endif
 
 static const struct i2c_device_id synaptics_i2c_id_table[] = {
 	{ "synaptics_i2c", 0 },
