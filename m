From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v3 6/7] Input: tm2-touchkey: Add support for aries touchkey variant
Date: Mon,  7 Jan 2019 19:53:45 +0100
Message-ID: <20190107185346.30184-7-pawel.mikolaj.chmiel@gmail.com>
References: <20190107185346.30184-1-pawel.mikolaj.chmiel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190107185346.30184-1-pawel.mikolaj.chmiel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, pawel.mikolaj.chmiel@gmail.com, xc-racer2@live.ca, simon@lineageos.org
List-Id: linux-input@vger.kernel.org

From: Jonathan Bakker <xc-racer2@live.ca>

The touchkey variant found on aries board is slighty different,
it uses a fixed regulator and writes/read to the same place

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 drivers/input/keyboard/tm2-touchkey.c | 53 +++++++++++++++++++++++----
 1 file changed, 46 insertions(+), 7 deletions(-)

diff --git a/drivers/input/keyboard/tm2-touchkey.c b/drivers/input/keyboard/tm2-touchkey.c
index b55faf597d8a..7dbef96559d2 100644
--- a/drivers/input/keyboard/tm2-touchkey.c
+++ b/drivers/input/keyboard/tm2-touchkey.c
@@ -28,6 +28,8 @@
 
 #define TM2_TOUCHKEY_DEV_NAME		"tm2-touchkey"
 
+#define ARIES_TOUCHKEY_CMD_LED_ON	0x1
+#define ARIES_TOUCHKEY_CMD_LED_OFF	0x2
 #define TM2_TOUCHKEY_CMD_LED_ON		0x10
 #define TM2_TOUCHKEY_CMD_LED_OFF	0x20
 #define TM2_TOUCHKEY_BIT_PRESS_EV	BIT(3)
@@ -38,6 +40,10 @@
 struct touchkey_variant {
 	u8 keycode_reg;
 	u8 base_reg;
+	u8 cmd_led_on;
+	u8 cmd_led_off;
+	bool no_reg;
+	bool fixed_regulator;
 };
 
 struct tm2_touchkey_data {
@@ -54,11 +60,22 @@ struct tm2_touchkey_data {
 static const struct touchkey_variant tm2_touchkey_variant = {
 	.keycode_reg = 0x03,
 	.base_reg = 0x00,
+	.cmd_led_on = TM2_TOUCHKEY_CMD_LED_ON,
+	.cmd_led_off = TM2_TOUCHKEY_CMD_LED_OFF,
 };
 
 static const struct touchkey_variant midas_touchkey_variant = {
 	.keycode_reg = 0x00,
 	.base_reg = 0x00,
+	.cmd_led_on = TM2_TOUCHKEY_CMD_LED_ON,
+	.cmd_led_off = TM2_TOUCHKEY_CMD_LED_OFF,
+};
+
+static struct touchkey_variant aries_touchkey_variant = {
+	.no_reg = true,
+	.fixed_regulator = true,
+	.cmd_led_on = ARIES_TOUCHKEY_CMD_LED_ON,
+	.cmd_led_off = ARIES_TOUCHKEY_CMD_LED_OFF,
 };
 
 static void tm2_touchkey_led_brightness_set(struct led_classdev *led_dev,
@@ -71,15 +88,20 @@ static void tm2_touchkey_led_brightness_set(struct led_classdev *led_dev,
 
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
@@ -112,8 +134,11 @@ static irqreturn_t tm2_touchkey_irq_handler(int irq, void *devid)
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
@@ -139,6 +164,14 @@ static irqreturn_t tm2_touchkey_irq_handler(int irq, void *devid)
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
 
@@ -246,6 +279,9 @@ static int tm2_touchkey_probe(struct i2c_client *client,
 		return error;
 	}
 
+	if (touchkey->variant->fixed_regulator)
+		tm2_touchkey_led_brightness_set(&touchkey->led_dev, LED_ON);
+
 	return 0;
 }
 
@@ -291,6 +327,9 @@ static const struct of_device_id tm2_touchkey_of_match[] = {
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
