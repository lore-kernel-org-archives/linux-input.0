From: Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH v3 3/5] Input: goodix - add power management support
Date: Mon, 29 Jun 2015 19:28:22 +0300
Message-ID: <1435595304-4840-4-git-send-email-irina.tirdea@intel.com>
References: <1435595304-4840-1-git-send-email-irina.tirdea@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1435595304-4840-1-git-send-email-irina.tirdea@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, Mark Rutland <mark.rutland@arm.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Irina Tirdea <irina.tirdea@intel.com>, Octavian Purdila <octavian.purdila@intel.com>
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
 drivers/input/touchscreen/goodix.c | 94 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 89 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index d2d72c1..a50a1fd 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -41,6 +41,7 @@ struct goodix_ts_data {
 	u16 id;
 	u16 version;
 	char *cfg_name;
+	unsigned long irq_flags;
 };
 
 struct goodix_gpio_data {
@@ -57,6 +58,9 @@ struct goodix_gpio_data {
 #define GOODIX_CONFIG_MAX_LENGTH	240
 
 /* Register defines */
+#define GOODIX_REG_COMMAND		0x8040
+#define GOODIX_CMD_SCREEN_OFF		0x05
+
 #define GOODIX_READ_COOR_ADDR		0x814E
 #define GOODIX_REG_CONFIG_DATA		0x8047
 #define GOODIX_REG_ID			0x8140
@@ -144,6 +148,11 @@ static int goodix_i2c_write(struct i2c_client *client, u16 reg, const u8 *buf,
 	return ret < 0 ? ret : (ret != 1 ? -EIO : 0);
 }
 
+static int goodix_i2c_write_u8(struct i2c_client *client, u16 reg, u8 value)
+{
+	return goodix_i2c_write(client, reg, &value, sizeof(value));
+}
+
 static int goodix_ts_read_input_report(struct goodix_ts_data *ts, u8 *data)
 {
 	int touch_num;
@@ -241,6 +250,18 @@ static irqreturn_t goodix_ts_irq_handler(int irq, void *dev_id)
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
@@ -553,7 +574,6 @@ static int goodix_request_input_dev(struct goodix_ts_data *ts)
 static int goodix_configure_dev(struct goodix_ts_data *ts)
 {
 	int error;
-	unsigned long irq_flags;
 
 	goodix_read_config(ts);
 
@@ -561,10 +581,8 @@ static int goodix_configure_dev(struct goodix_ts_data *ts)
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
@@ -666,6 +684,71 @@ static int goodix_ts_probe(struct i2c_client *client,
 	return goodix_configure_dev(ts);
 }
 
+static int __maybe_unused goodix_suspend(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct goodix_ts_data *ts = i2c_get_clientdata(client);
+	int ret;
+
+	/* We need gpio pins to suspend/resume */
+	if (!ts->gpiod_int || !ts->gpiod_rst)
+		return 0;
+
+	/* Free IRQ as IRQ pin is used as output in the suspend sequence */
+	goodix_free_irq(ts);
+	/* Output LOW on the INT pin for 5 ms */
+	ret = gpiod_direction_output(ts->gpiod_int, 0);
+	if (ret) {
+		goodix_request_irq(ts);
+		return ret;
+	}
+	usleep_range(5000, 6000);
+
+	ret = goodix_i2c_write_u8(ts->client, GOODIX_REG_COMMAND,
+				  GOODIX_CMD_SCREEN_OFF);
+	if (ret) {
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
+	int ret;
+
+	if (!ts->gpiod_int || !ts->gpiod_rst)
+		return 0;
+
+	/*
+	 * Exit sleep mode by outputting HIGH level to INT pin
+	 * for 2ms~5ms.
+	 */
+	ret = gpiod_direction_output(ts->gpiod_int, 1);
+	if (ret)
+		return ret;
+	usleep_range(2000, 5000);
+
+	ret = goodix_int_sync(ts);
+	if (ret)
+		return ret;
+
+	return goodix_request_irq(ts);
+}
+
+static SIMPLE_DEV_PM_OPS(goodix_pm_ops, goodix_suspend, goodix_resume);
+
 static const struct i2c_device_id goodix_ts_id[] = {
 	{ "GDIX1001:00", (kernel_ulong_t)&goodix_gpio_rst_irq },
 	{ }
@@ -701,6 +784,7 @@ static struct i2c_driver goodix_ts_driver = {
 		.owner = THIS_MODULE,
 		.acpi_match_table = ACPI_PTR(goodix_acpi_match),
 		.of_match_table = of_match_ptr(goodix_of_match),
+		.pm = &goodix_pm_ops,
 	},
 };
 module_i2c_driver(goodix_ts_driver);
-- 
1.9.1
