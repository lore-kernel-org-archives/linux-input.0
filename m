From: Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH v11 4/8] Input: goodix - add power management support
Date: Thu, 19 Nov 2015 14:26:37 +0200
Message-ID: <1447936001-21420-5-git-send-email-irina.tirdea@intel.com>
References: <1447936001-21420-1-git-send-email-irina.tirdea@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447936001-21420-1-git-send-email-irina.tirdea@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, Aleksei Mamlin <mamlinav@gmail.com>, Karsten Merker <merker@debian.org>, linux-input@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Octavian Purdila <octavian.purdila@intel.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Irina Tirdea <irina.tirdea@intel.com>
List-Id: linux-input@vger.kernel.org

Implement suspend/resume for goodix driver.

The suspend and resume process uses the gpio pins.
If the device ACPI/DT information does not declare gpio pins,
suspend/resume will not be available for these devices.

This is based on Goodix datasheets for GT911 and GT9271
and on Goodix driver gt9xx.c for Android (publicly available
in Android kernel trees for various devices).

Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
---
 drivers/input/touchscreen/goodix.c | 96 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 91 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index 0911b0c9..0fd472d 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -45,6 +45,7 @@ struct goodix_ts_data {
 	u16 version;
 	char *cfg_name;
 	struct completion firmware_loading_complete;
+	unsigned long irq_flags;
 };
 
 #define GOODIX_GPIO_INT_NAME		"irq"
@@ -61,6 +62,9 @@ struct goodix_ts_data {
 #define GOODIX_CONFIG_967_LENGTH	228
 
 /* Register defines */
+#define GOODIX_REG_COMMAND		0x8040
+#define GOODIX_CMD_SCREEN_OFF		0x05
+
 #define GOODIX_READ_COOR_ADDR		0x814E
 #define GOODIX_REG_CONFIG_DATA		0x8047
 #define GOODIX_REG_ID			0x8140
@@ -162,6 +166,11 @@ static int goodix_i2c_write(struct i2c_client *client, u16 reg, const u8 *buf,
 	return ret < 0 ? ret : (ret != 1 ? -EIO : 0);
 }
 
+static int goodix_i2c_write_u8(struct i2c_client *client, u16 reg, u8 value)
+{
+	return goodix_i2c_write(client, reg, &value, sizeof(value));
+}
+
 static int goodix_get_cfg_len(u16 id)
 {
 	switch (id) {
@@ -281,6 +290,18 @@ static irqreturn_t goodix_ts_irq_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static void goodix_free_irq(struct goodix_ts_data *ts)
+{
+	devm_free_irq(&ts->client->dev, ts->client->irq, ts);
+}
+
+static int goodix_request_irq(struct goodix_ts_data *ts)
+{
+	return devm_request_threaded_irq(&ts->client->dev, ts->client->irq,
+					 NULL, goodix_ts_irq_handler,
+					 ts->irq_flags, ts->client->name, ts);
+}
+
 /**
  * goodix_check_cfg - Checks if config fw is valid
  *
@@ -585,7 +606,6 @@ static int goodix_request_input_dev(struct goodix_ts_data *ts)
 static int goodix_configure_dev(struct goodix_ts_data *ts)
 {
 	int error;
-	unsigned long irq_flags;
 
 	goodix_read_config(ts);
 
@@ -593,10 +613,8 @@ static int goodix_configure_dev(struct goodix_ts_data *ts)
 	if (error)
 		return error;
 
-	irq_flags = goodix_irq_flags[ts->int_trigger_type] | IRQF_ONESHOT;
-	error = devm_request_threaded_irq(&ts->client->dev, ts->client->irq,
-					  NULL, goodix_ts_irq_handler,
-					  irq_flags, ts->client->name, ts);
+	ts->irq_flags = goodix_irq_flags[ts->int_trigger_type] | IRQF_ONESHOT;
+	error = goodix_request_irq(ts);
 	if (error) {
 		dev_err(&ts->client->dev, "request IRQ failed: %d\n", error);
 		return error;
@@ -720,6 +738,73 @@ static int goodix_ts_remove(struct i2c_client *client)
 	return 0;
 }
 
+static int __maybe_unused goodix_suspend(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct goodix_ts_data *ts = i2c_get_clientdata(client);
+	int error;
+
+	/* We need gpio pins to suspend/resume */
+	if (!ts->gpiod_int || !ts->gpiod_rst)
+		return 0;
+
+	wait_for_completion(&ts->firmware_loading_complete);
+
+	/* Free IRQ as IRQ pin is used as output in the suspend sequence */
+	goodix_free_irq(ts);
+	/* Output LOW on the INT pin for 5 ms */
+	error = gpiod_direction_output(ts->gpiod_int, 0);
+	if (error) {
+		goodix_request_irq(ts);
+		return error;
+	}
+	usleep_range(5000, 6000);
+
+	error = goodix_i2c_write_u8(ts->client, GOODIX_REG_COMMAND,
+				    GOODIX_CMD_SCREEN_OFF);
+	if (error) {
+		dev_err(&ts->client->dev, "Screen off command failed\n");
+		gpiod_direction_input(ts->gpiod_int);
+		goodix_request_irq(ts);
+		return -EAGAIN;
+	}
+
+	/*
+	 * The datasheet specifies that the interval between sending screen-off
+	 * command and wake-up should be longer than 58 ms. To avoid waking up
+	 * sooner, delay 58ms here.
+	 */
+	msleep(58);
+	return 0;
+}
+
+static int __maybe_unused goodix_resume(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct goodix_ts_data *ts = i2c_get_clientdata(client);
+	int error;
+
+	if (!ts->gpiod_int || !ts->gpiod_rst)
+		return 0;
+
+	/*
+	 * Exit sleep mode by outputting HIGH level to INT pin
+	 * for 2ms~5ms.
+	 */
+	error = gpiod_direction_output(ts->gpiod_int, 1);
+	if (error)
+		return error;
+	usleep_range(2000, 5000);
+
+	error = goodix_int_sync(ts);
+	if (error)
+		return error;
+
+	return goodix_request_irq(ts);
+}
+
+static SIMPLE_DEV_PM_OPS(goodix_pm_ops, goodix_suspend, goodix_resume);
+
 static const struct i2c_device_id goodix_ts_id[] = {
 	{ "GDIX1001:00", 0 },
 	{ }
@@ -756,6 +841,7 @@ static struct i2c_driver goodix_ts_driver = {
 		.name = "Goodix-TS",
 		.acpi_match_table = ACPI_PTR(goodix_acpi_match),
 		.of_match_table = of_match_ptr(goodix_of_match),
+		.pm = &goodix_pm_ops,
 	},
 };
 module_i2c_driver(goodix_ts_driver);
-- 
1.9.1
