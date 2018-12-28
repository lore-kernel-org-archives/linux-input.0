From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v2 1/7] Input: tm2-touchkey: Add support for midas touchkey
Date: Fri, 28 Dec 2018 16:46:03 +0100
Message-ID: <20181228154609.14846-2-pawel.mikolaj.chmiel@gmail.com>
References: <20181228154609.14846-1-pawel.mikolaj.chmiel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181228154609.14846-1-pawel.mikolaj.chmiel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, pawel.mikolaj.chmiel@gmail.com, xc-racer2@live.ca, simon@lineageos.org
List-Id: linux-input@vger.kernel.org

From: Simon Shields <simon@lineageos.org>

The touchkey on midas boards is almost identical.
The only real difference is that it uses the same register for both
keycode and base.

Signed-off-by: Simon Shields <simon@lineageos.org>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
Changes from v1:
  - Droped separate name changes
  - Added missing const in few places
  - Removed redundant cast
---
 drivers/input/keyboard/tm2-touchkey.c | 34 +++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/input/keyboard/tm2-touchkey.c b/drivers/input/keyboard/tm2-touchkey.c
index abc266e40e17..5a1fe08bdd76 100644
--- a/drivers/input/keyboard/tm2-touchkey.c
+++ b/drivers/input/keyboard/tm2-touchkey.c
@@ -22,12 +22,12 @@
 #include <linux/leds.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/pm.h>
 #include <linux/regulator/consumer.h>
 
 #define TM2_TOUCHKEY_DEV_NAME		"tm2-touchkey"
-#define TM2_TOUCHKEY_KEYCODE_REG	0x03
-#define TM2_TOUCHKEY_BASE_REG		0x00
+
 #define TM2_TOUCHKEY_CMD_LED_ON		0x10
 #define TM2_TOUCHKEY_CMD_LED_OFF	0x20
 #define TM2_TOUCHKEY_BIT_PRESS_EV	BIT(3)
@@ -40,12 +40,28 @@ enum {
 	TM2_TOUCHKEY_KEY_BACK,
 };
 
+struct touchkey_variant {
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
+	const struct touchkey_variant *variant;
+};
+
+static const struct touchkey_variant tm2_touchkey_variant = {
+	.keycode_reg = 0x03,
+	.base_reg = 0x00,
+};
+
+static const struct touchkey_variant midas_touchkey_variant = {
+	.keycode_reg = 0x00,
+	.base_reg = 0x00,
 };
 
 static void tm2_touchkey_led_brightness_set(struct led_classdev *led_dev,
@@ -66,7 +82,7 @@ static void tm2_touchkey_led_brightness_set(struct led_classdev *led_dev,
 
 	regulator_set_voltage(touchkey->vdd, volt, volt);
 	i2c_smbus_write_byte_data(touchkey->client,
-				  TM2_TOUCHKEY_BASE_REG, data);
+				  touchkey->variant->base_reg, data);
 }
 
 static int tm2_touchkey_power_enable(struct tm2_touchkey_data *touchkey)
@@ -99,7 +115,7 @@ static irqreturn_t tm2_touchkey_irq_handler(int irq, void *devid)
 	int key;
 
 	data = i2c_smbus_read_byte_data(touchkey->client,
-					TM2_TOUCHKEY_KEYCODE_REG);
+					touchkey->variant->keycode_reg);
 	if (data < 0) {
 		dev_err(&touchkey->client->dev,
 			"failed to read i2c data: %d\n", data);
@@ -153,6 +169,8 @@ static int tm2_touchkey_probe(struct i2c_client *client,
 	touchkey->client = client;
 	i2c_set_clientdata(client, touchkey);
 
+	touchkey->variant = of_device_get_match_data(&client->dev);
+
 	touchkey->regulators[0].supply = "vcc";
 	touchkey->regulators[1].supply = "vdd";
 	error = devm_regulator_bulk_get(&client->dev,
@@ -262,7 +280,13 @@ static const struct i2c_device_id tm2_touchkey_id_table[] = {
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
