From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH 7/8] Input: tm2-touchkey: Add support for aries touchkey variant
Date: Fri,  7 Dec 2018 11:58:10 +0100
Message-ID: <20181207105811.1831-8-pawel.mikolaj.chmiel@gmail.com>
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

From: Jonathan Bakker <xc-racer2@live.ca>

The touchkey variant found on aries board is slighty different,
it uses a fixed regulator and writes/read to the same place

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 drivers/input/keyboard/tm2-touchkey.c | 56 +++++++++++++++++++++++----
 1 file changed, 49 insertions(+), 7 deletions(-)

diff --git a/drivers/input/keyboard/tm2-touchkey.c b/drivers/input/keyboard/tm2-touchkey.c
index ebc275ab8ad1..6f1235183c21 100644
--- a/drivers/input/keyboard/tm2-touchkey.c
+++ b/drivers/input/keyboard/tm2-touchkey.c
@@ -28,7 +28,10 @@
 
 #define TM2_TOUCHKEY_DEV_NAME "tm2-touchkey"
 #define MIDAS_TOUCHKEY_DEV_NAME "midas-touchkey"
+#define ARIES_TOUCHKEY_DEV_NAME "aries-touchkey"
 
+#define ARIES_TOUCHKEY_CMD_LED_ON	0x1
+#define ARIES_TOUCHKEY_CMD_LED_OFF	0x2
 #define TM2_TOUCHKEY_CMD_LED_ON		0x10
 #define TM2_TOUCHKEY_CMD_LED_OFF	0x20
 #define TM2_TOUCHKEY_BIT_PRESS_EV	BIT(3)
@@ -40,6 +43,10 @@ struct touchkey_variant {
 	const char *name;
 	u8 keycode_reg;
 	u8 base_reg;
+	u8 cmd_led_on;
+	u8 cmd_led_off;
+	bool no_reg;
+	bool fixed_regulator;
 };
 
 struct tm2_touchkey_data {
@@ -57,12 +64,24 @@ static struct touchkey_variant tm2_touchkey_variant = {
 	.name = TM2_TOUCHKEY_DEV_NAME,
 	.keycode_reg = 0x03,
 	.base_reg = 0x00,
+	.cmd_led_on = TM2_TOUCHKEY_CMD_LED_ON,
+	.cmd_led_off = TM2_TOUCHKEY_CMD_LED_OFF,
 };
 
 static struct touchkey_variant midas_touchkey_variant = {
 	.name = MIDAS_TOUCHKEY_DEV_NAME,
 	.keycode_reg = 0x00,
 	.base_reg = 0x00,
+	.cmd_led_on = TM2_TOUCHKEY_CMD_LED_ON,
+	.cmd_led_off = TM2_TOUCHKEY_CMD_LED_OFF,
+};
+
+static struct touchkey_variant aries_touchkey_variant = {
+	.name = ARIES_TOUCHKEY_DEV_NAME,
+	.no_reg = true,
+	.fixed_regulator = true,
+	.cmd_led_on = ARIES_TOUCHKEY_CMD_LED_ON,
+	.cmd_led_off = ARIES_TOUCHKEY_CMD_LED_OFF,
 };
 
 static void tm2_touchkey_led_brightness_set(struct led_classdev *led_dev,
@@ -75,15 +94,20 @@ static void tm2_touchkey_led_brightness_set(struct led_classdev *led_dev,
 
 	if (brightness == LED_OFF) {
 		volt = TM2_TOUCHKEY_LED_VOLTAGE_MIN;
-		data = TM2_TOUCHKEY_CMD_LED_OFF;
+		data = touchkey->variant->cmd_led_off;
 	} else {
 		volt = TM2_TOUCHKEY_LED_VOLTAGE_MAX;
-		data = TM2_TOUCHKEY_CMD_LED_ON;
+		data = touchkey->variant->cmd_led_on;
 	}
 
-	regulator_set_voltage(touchkey->vdd, volt, volt);
-	i2c_smbus_write_byte_data(touchkey->client,
-				  touchkey->variant->base_reg, data);
+	if (!touchkey->variant->fixed_regulator)
+		regulator_set_voltage(touchkey->vdd, volt, volt);
+
+	if (touchkey->variant->no_reg)
+		i2c_smbus_write_byte(touchkey->client, data);
+	else
+		i2c_smbus_write_byte_data(touchkey->client,
+					  touchkey->variant->base_reg, data);
 }
 
 static int tm2_touchkey_power_enable(struct tm2_touchkey_data *touchkey)
@@ -116,8 +140,11 @@ static irqreturn_t tm2_touchkey_irq_handler(int irq, void *devid)
 	int index;
 	int i;
 
-	data = i2c_smbus_read_byte_data(touchkey->client,
-					touchkey->variant->keycode_reg);
+	if (touchkey->variant->no_reg)
+		data = i2c_smbus_read_byte(touchkey->client);
+	else
+		data = i2c_smbus_read_byte_data(touchkey->client,
+						touchkey->variant->keycode_reg);
 	if (data < 0) {
 		dev_err(&touchkey->client->dev,
 			"failed to read i2c data: %d\n", data);
@@ -143,6 +170,14 @@ static irqreturn_t tm2_touchkey_irq_handler(int irq, void *devid)
 	input_sync(touchkey->input_dev);
 
 out:
+	if (touchkey->variant->fixed_regulator &&
+				data & TM2_TOUCHKEY_BIT_PRESS_EV) {
+		/* touch turns backlight on, so make sure we're in sync */
+		if (touchkey->led_dev.brightness == LED_OFF)
+			tm2_touchkey_led_brightness_set(&touchkey->led_dev,
+							LED_OFF);
+	}
+
 	return IRQ_HANDLED;
 }
 
@@ -251,6 +286,9 @@ static int tm2_touchkey_probe(struct i2c_client *client,
 		return error;
 	}
 
+	if (touchkey->variant->fixed_regulator)
+		tm2_touchkey_led_brightness_set(&touchkey->led_dev, LED_ON);
+
 	return 0;
 }
 
@@ -286,6 +324,7 @@ static SIMPLE_DEV_PM_OPS(tm2_touchkey_pm_ops,
 static const struct i2c_device_id tm2_touchkey_id_table[] = {
 	{ TM2_TOUCHKEY_DEV_NAME, 0 },
 	{ MIDAS_TOUCHKEY_DEV_NAME, 0 },
+	{ ARIES_TOUCHKEY_DEV_NAME, 0 },
 	{ },
 };
 MODULE_DEVICE_TABLE(i2c, tm2_touchkey_id_table);
@@ -297,6 +336,9 @@ static const struct of_device_id tm2_touchkey_of_match[] = {
 	}, {
 		.compatible = "cypress,midas-touchkey",
 		.data = &midas_touchkey_variant,
+	}, {
+		.compatible = "cypress,aries-touchkey",
+		.data = &aries_touchkey_variant,
 	},
 	{ },
 };
-- 
2.17.1
