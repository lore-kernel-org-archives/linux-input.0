From: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 6/8] input: goodix: add power management support
Date: Mon,  8 Jun 2015 17:37:51 +0300
Message-ID: <1433774273-23103-7-git-send-email-irina.tirdea@intel.com>
References: <1433774273-23103-1-git-send-email-irina.tirdea@intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1433774273-23103-1-git-send-email-irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Implement suspend/resume for goodix driver.

This is based on Goodix datasheets for GT911 and GT9271
and on Goodix driver gt9xx.c for Android (publicly available
in Android kernel trees for various devices).

Signed-off-by: Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/input/touchscreen/goodix.c | 88 +++++++++++++++++++++++++++++++++++---
 1 file changed, 83 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index 1ce9278..903c83d 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -38,6 +38,7 @@ struct goodix_ts_data {
 	unsigned int int_trigger_type;
 	struct gpio_desc *gpiod_int;
 	struct gpio_desc *gpiod_rst;
+	unsigned long irq_flags;
 };
 
 #define GOODIX_GPIO_INT_NAME		"irq"
@@ -52,6 +53,9 @@ struct goodix_ts_data {
 #define GOODIX_CONFIG_MAX_LENGTH	240
 
 /* Register defines */
+#define GOODIX_REG_COMMAND		0x8040
+#define GOODIX_CMD_SCREEN_OFF		0x05
+
 #define GOODIX_READ_COOR_ADDR		0x814E
 #define GOODIX_REG_CONFIG_DATA		0x8047
 #define GOODIX_REG_ID			0x8140
@@ -129,6 +133,11 @@ static int goodix_i2c_write(struct i2c_client *client, u16 reg, const u8 *buf,
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
@@ -226,6 +235,18 @@ static irqreturn_t goodix_ts_irq_handler(int irq, void *dev_id)
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
  * goodix_check_cfg - Checks if config buffer is valid
  *
@@ -547,7 +568,6 @@ static int goodix_ts_probe(struct i2c_client *client,
 			   const struct i2c_device_id *id)
 {
 	struct goodix_ts_data *ts;
-	unsigned long irq_flags;
 	int error;
 	u16 version_info, id_info;
 
@@ -599,10 +619,8 @@ static int goodix_ts_probe(struct i2c_client *client,
 	if (error)
 		return error;
 
-	irq_flags = goodix_irq_flags[ts->int_trigger_type] | IRQF_ONESHOT;
-	error = devm_request_threaded_irq(&ts->client->dev, client->irq,
-					  NULL, goodix_ts_irq_handler,
-					  irq_flags, client->name, ts);
+	ts->irq_flags = goodix_irq_flags[ts->int_trigger_type] | IRQF_ONESHOT;
+	error = goodix_request_irq(ts);
 	if (error) {
 		dev_err(&client->dev, "request IRQ failed: %d\n", error);
 		return error;
@@ -611,6 +629,65 @@ static int goodix_ts_probe(struct i2c_client *client,
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int goodix_suspend(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct goodix_ts_data *ts = i2c_get_clientdata(client);
+	int ret;
+
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
+static int goodix_resume(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct goodix_ts_data *ts = i2c_get_clientdata(client);
+	int ret;
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
+#endif
+
+static SIMPLE_DEV_PM_OPS(goodix_pm_ops, goodix_suspend, goodix_resume);
+
 static const struct i2c_device_id goodix_ts_id[] = {
 	{ "GDIX1001:00", 0 },
 	{ }
@@ -646,6 +723,7 @@ static struct i2c_driver goodix_ts_driver = {
 		.owner = THIS_MODULE,
 		.acpi_match_table = ACPI_PTR(goodix_acpi_match),
 		.of_match_table = of_match_ptr(goodix_of_match),
+		.pm = &goodix_pm_ops,
 	},
 };
 module_i2c_driver(goodix_ts_driver);
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
