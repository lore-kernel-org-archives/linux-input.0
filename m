From: Richard Leitner <richard.leitner@skidata.com>
Subject: [PATCH 2/7] Input: sx8654 - add reset-gpio support
Date: Tue, 16 Oct 2018 11:16:48 +0200
Message-ID: <20181016091653.26896-3-richard.leitner@skidata.com>
References: <20181016091653.26896-1-richard.leitner@skidata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181016091653.26896-1-richard.leitner@skidata.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Richard Leitner <richard.leitner@skidata.com>
List-Id: linux-input@vger.kernel.org

The sx8654 features a NRST input which may be connected to a GPIO.
Therefore add support for hard-resetting the sx8654 via this NRST.

If the reset-gpio property is provided the sx8654 is resetted via NRST
instead of the soft-reset via I2C.

Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
---
 drivers/input/touchscreen/sx8654.c | 88 ++++++++++++++++++++++++++++++++------
 1 file changed, 74 insertions(+), 14 deletions(-)

diff --git a/drivers/input/touchscreen/sx8654.c b/drivers/input/touchscreen/sx8654.c
index ed29db3ec731..059127490c8d 100644
--- a/drivers/input/touchscreen/sx8654.c
+++ b/drivers/input/touchscreen/sx8654.c
@@ -33,6 +33,8 @@
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/gpio/consumer.h>
+#include <linux/delay.h>
 
 /* register addresses */
 #define I2C_REG_TOUCH0			0x00
@@ -74,6 +76,7 @@
 struct sx8654 {
 	struct input_dev *input;
 	struct i2c_client *client;
+	struct gpio_desc *gpio_reset;
 };
 
 static irqreturn_t sx8654_irq(int irq, void *handle)
@@ -124,6 +127,27 @@ static irqreturn_t sx8654_irq(int irq, void *handle)
 	return IRQ_HANDLED;
 }
 
+static int sx8654_reset(struct sx8654 *ts)
+{
+	int err;
+
+	if (ts->gpio_reset) {
+		gpiod_set_value_cansleep(ts->gpio_reset, 1);
+		udelay(2); /* Tpulse > 1µs */
+		gpiod_set_value_cansleep(ts->gpio_reset, 0);
+
+		return 0;
+	}
+
+	dev_dbg(&ts->client->dev, "NRST unavailable, try softreset\n");
+	err = i2c_smbus_write_byte_data(ts->client, I2C_REG_SOFTRESET,
+					SOFTRESET_VALUE);
+	if (err)
+		return err;
+
+	return 0;
+}
+
 static int sx8654_open(struct input_dev *dev)
 {
 	struct sx8654 *sx8654 = input_get_drvdata(dev);
@@ -171,6 +195,44 @@ static void sx8654_close(struct input_dev *dev)
 	}
 }
 
+#ifdef CONFIG_OF
+static int sx8654_get_ofdata(struct sx8654 *ts)
+{
+	struct device *dev = &ts->client->dev;
+	struct device_node *node = dev->of_node;
+	int err;
+
+	if (!node) {
+		ts->gpio_reset = NULL;
+		return 0;
+	}
+
+	ts->gpio_reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (PTR_ERR(ts->gpio_reset) == -EPROBE_DEFER) {
+		return -EPROBE_DEFER;
+	} else if (IS_ERR(ts->gpio_reset)) {
+		err = PTR_ERR(ts->gpio_reset);
+		dev_err(dev, "unable to request GPIO reset pin (%d)\n", err);
+		return err;
+	}
+	dev_dbg(dev, "got GPIO reset pin\n");
+
+	return 0;
+}
+
+static const struct of_device_id sx8654_of_match[] = {
+	{ .compatible = "semtech,sx8654", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, sx8654_of_match);
+#else /* CONFIG_OF */
+static int sx8654_get_ofdata(struct sx8654 *ts)
+{
+	ts->gpio_reset = NULL;
+	return 0;
+}
+#endif /* CONFIG_OF */
+
 static int sx8654_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
@@ -186,10 +248,20 @@ static int sx8654_probe(struct i2c_client *client,
 	if (!sx8654)
 		return -ENOMEM;
 
+	sx8654->client = client;
+
+	error = sx8654_get_ofdata(sx8654);
+	if (error) {
+		dev_err(&client->dev, "get_ofdata failed: %d\n", error);
+		return error;
+	}
+
 	input = devm_input_allocate_device(&client->dev);
 	if (!input)
 		return -ENOMEM;
 
+	sx8654->input = input;
+
 	input->name = "SX8654 I2C Touchscreen";
 	input->id.bustype = BUS_I2C;
 	input->dev.parent = &client->dev;
@@ -201,15 +273,11 @@ static int sx8654_probe(struct i2c_client *client,
 	input_set_abs_params(input, ABS_X, 0, MAX_12BIT, 0, 0);
 	input_set_abs_params(input, ABS_Y, 0, MAX_12BIT, 0, 0);
 
-	sx8654->client = client;
-	sx8654->input = input;
-
 	input_set_drvdata(sx8654->input, sx8654);
 
-	error = i2c_smbus_write_byte_data(client, I2C_REG_SOFTRESET,
-					  SOFTRESET_VALUE);
+	error = sx8654_reset(sx8654);
 	if (error) {
-		dev_err(&client->dev, "writing softreset value failed");
+		dev_err(&client->dev, "reset failed");
 		return error;
 	}
 
@@ -256,14 +324,6 @@ static int sx8654_probe(struct i2c_client *client,
 	return 0;
 }
 
-#ifdef CONFIG_OF
-static const struct of_device_id sx8654_of_match[] = {
-	{ .compatible = "semtech,sx8654", },
-	{ },
-};
-MODULE_DEVICE_TABLE(of, sx8654_of_match);
-#endif
-
 static const struct i2c_device_id sx8654_id_table[] = {
 	{ "semtech_sx8654", 0 },
 	{ },
-- 
2.11.0
