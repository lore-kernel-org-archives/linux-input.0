From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH 1/8] Input: tm2-touchkey: Add support for midas touchkey
Date: Fri,  7 Dec 2018 11:58:04 +0100
Message-ID: <20181207105811.1831-2-pawel.mikolaj.chmiel@gmail.com>
References: <20181207105811.1831-1-pawel.mikolaj.chmiel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181207105811.1831-1-pawel.mikolaj.chmiel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, pawel.mikolaj.chmiel@gmail.com, xc-racer2@live.ca, simon@lineageos.org
List-Id: linux-input@vger.kernel.org

From: Simon Shields <simon@lineageos.org>

The touchkey on midas boards is almost identical.
The only real difference is that it uses the same register for both
keycode and base.

Signed-off-by: Simon Shields <simon@lineageos.org>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 drivers/input/keyboard/tm2-touchkey.c | 48 ++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 9 deletions(-)

diff --git a/drivers/input/keyboard/tm2-touchkey.c b/drivers/input/keyboard/tm2-touchkey.c
index abc266e40e17..37a5ced24009 100644
--- a/drivers/input/keyboard/tm2-touchkey.c
+++ b/drivers/input/keyboard/tm2-touchkey.c
@@ -22,12 +22,13 @@
 #include <linux/leds.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/pm.h>
 #include <linux/regulator/consumer.h>
 
-#define TM2_TOUCHKEY_DEV_NAME		"tm2-touchkey"
-#define TM2_TOUCHKEY_KEYCODE_REG	0x03
-#define TM2_TOUCHKEY_BASE_REG		0x00
+#define TM2_TOUCHKEY_DEV_NAME "tm2-touchkey"
+#define MIDAS_TOUCHKEY_DEV_NAME "midas-touchkey"
+
 #define TM2_TOUCHKEY_CMD_LED_ON		0x10
 #define TM2_TOUCHKEY_CMD_LED_OFF	0x20
 #define TM2_TOUCHKEY_BIT_PRESS_EV	BIT(3)
@@ -40,12 +41,31 @@ enum {
 	TM2_TOUCHKEY_KEY_BACK,
 };
 
+struct touchkey_variant {
+	const char *name;
+	u8 keycode_reg;
+	u8 base_reg;
+};
+
 struct tm2_touchkey_data {
 	struct i2c_client *client;
 	struct input_dev *input_dev;
 	struct led_classdev led_dev;
 	struct regulator *vdd;
 	struct regulator_bulk_data regulators[2];
+	struct touchkey_variant *variant;
+};
+
+static struct touchkey_variant tm2_touchkey_variant = {
+	.name = "tm2-touchkey",
+	.keycode_reg = 0x03,
+	.base_reg = 0x00,
+};
+
+static struct touchkey_variant midas_touchkey_variant = {
+	.name = "midas-touchkey",
+	.keycode_reg = 0x00,
+	.base_reg = 0x00,
 };
 
 static void tm2_touchkey_led_brightness_set(struct led_classdev *led_dev,
@@ -66,7 +86,7 @@ static void tm2_touchkey_led_brightness_set(struct led_classdev *led_dev,
 
 	regulator_set_voltage(touchkey->vdd, volt, volt);
 	i2c_smbus_write_byte_data(touchkey->client,
-				  TM2_TOUCHKEY_BASE_REG, data);
+				  touchkey->variant->base_reg, data);
 }
 
 static int tm2_touchkey_power_enable(struct tm2_touchkey_data *touchkey)
@@ -99,7 +119,7 @@ static irqreturn_t tm2_touchkey_irq_handler(int irq, void *devid)
 	int key;
 
 	data = i2c_smbus_read_byte_data(touchkey->client,
-					TM2_TOUCHKEY_KEYCODE_REG);
+					touchkey->variant->keycode_reg);
 	if (data < 0) {
 		dev_err(&touchkey->client->dev,
 			"failed to read i2c data: %d\n", data);
@@ -153,6 +173,9 @@ static int tm2_touchkey_probe(struct i2c_client *client,
 	touchkey->client = client;
 	i2c_set_clientdata(client, touchkey);
 
+	touchkey->variant = (struct touchkey_variant *)
+		of_device_get_match_data(&client->dev);
+
 	touchkey->regulators[0].supply = "vcc";
 	touchkey->regulators[1].supply = "vdd";
 	error = devm_regulator_bulk_get(&client->dev,
@@ -187,7 +210,7 @@ static int tm2_touchkey_probe(struct i2c_client *client,
 		return -ENOMEM;
 	}
 
-	touchkey->input_dev->name = TM2_TOUCHKEY_DEV_NAME;
+	touchkey->input_dev->name = touchkey->variant->name;
 	touchkey->input_dev->id.bustype = BUS_I2C;
 
 	input_set_capability(touchkey->input_dev, EV_KEY, KEY_PHONE);
@@ -203,7 +226,7 @@ static int tm2_touchkey_probe(struct i2c_client *client,
 	error = devm_request_threaded_irq(&client->dev, client->irq,
 					  NULL, tm2_touchkey_irq_handler,
 					  IRQF_ONESHOT,
-					  TM2_TOUCHKEY_DEV_NAME, touchkey);
+					  touchkey->variant->name, touchkey);
 	if (error) {
 		dev_err(&client->dev,
 			"failed to request threaded irq: %d\n", error);
@@ -211,7 +234,7 @@ static int tm2_touchkey_probe(struct i2c_client *client,
 	}
 
 	/* led device */
-	touchkey->led_dev.name = TM2_TOUCHKEY_DEV_NAME;
+	touchkey->led_dev.name = touchkey->variant->name;
 	touchkey->led_dev.brightness = LED_FULL;
 	touchkey->led_dev.max_brightness = LED_ON;
 	touchkey->led_dev.brightness_set = tm2_touchkey_led_brightness_set;
@@ -257,12 +280,19 @@ static SIMPLE_DEV_PM_OPS(tm2_touchkey_pm_ops,
 
 static const struct i2c_device_id tm2_touchkey_id_table[] = {
 	{ TM2_TOUCHKEY_DEV_NAME, 0 },
+	{ MIDAS_TOUCHKEY_DEV_NAME, 0 },
 	{ },
 };
 MODULE_DEVICE_TABLE(i2c, tm2_touchkey_id_table);
 
 static const struct of_device_id tm2_touchkey_of_match[] = {
-	{ .compatible = "cypress,tm2-touchkey", },
+	{
+		.compatible = "cypress,tm2-touchkey",
+		.data = &tm2_touchkey_variant,
+	}, {
+		.compatible = "cypress,midas-touchkey",
+		.data = &midas_touchkey_variant,
+	},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, tm2_touchkey_of_match);
-- 
2.17.1
