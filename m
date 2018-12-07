From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH 5/8] Input: tm2-touchkey: Allow specifying custom keycodes
Date: Fri,  7 Dec 2018 11:58:08 +0100
Message-ID: <20181207105811.1831-6-pawel.mikolaj.chmiel@gmail.com>
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

Not all devices use the same keycodes in the same order

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 drivers/input/keyboard/tm2-touchkey.c | 49 +++++++++++++++------------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/drivers/input/keyboard/tm2-touchkey.c b/drivers/input/keyboard/tm2-touchkey.c
index a73894b8dede..ebc275ab8ad1 100644
--- a/drivers/input/keyboard/tm2-touchkey.c
+++ b/drivers/input/keyboard/tm2-touchkey.c
@@ -36,11 +36,6 @@
 #define TM2_TOUCHKEY_LED_VOLTAGE_MIN	2500000
 #define TM2_TOUCHKEY_LED_VOLTAGE_MAX	3300000
 
-enum {
-	TM2_TOUCHKEY_KEY_MENU = 0x1,
-	TM2_TOUCHKEY_KEY_BACK,
-};
-
 struct touchkey_variant {
 	const char *name;
 	u8 keycode_reg;
@@ -54,6 +49,8 @@ struct tm2_touchkey_data {
 	struct regulator *vdd;
 	struct regulator_bulk_data regulators[2];
 	struct touchkey_variant *variant;
+	u8 keycodes[4];
+	int num_keycodes;
 };
 
 static struct touchkey_variant tm2_touchkey_variant = {
@@ -116,7 +113,8 @@ static irqreturn_t tm2_touchkey_irq_handler(int irq, void *devid)
 {
 	struct tm2_touchkey_data *touchkey = devid;
 	int data;
-	int key;
+	int index;
+	int i;
 
 	data = i2c_smbus_read_byte_data(touchkey->client,
 					touchkey->variant->keycode_reg);
@@ -126,26 +124,20 @@ static irqreturn_t tm2_touchkey_irq_handler(int irq, void *devid)
 		goto out;
 	}
 
-	switch (data & TM2_TOUCHKEY_BIT_KEYCODE) {
-	case TM2_TOUCHKEY_KEY_MENU:
-		key = KEY_PHONE;
-		break;
-
-	case TM2_TOUCHKEY_KEY_BACK:
-		key = KEY_BACK;
-		break;
-
-	default:
+	index = (data & TM2_TOUCHKEY_BIT_KEYCODE) - 1;
+	if (index < 0 || index >= touchkey->num_keycodes) {
 		dev_warn(&touchkey->client->dev,
-			 "unhandled keycode, data %#02x\n", data);
+			 "invalid keycode index %d\n", index);
 		goto out;
 	}
 
 	if (data & TM2_TOUCHKEY_BIT_PRESS_EV) {
-		input_report_key(touchkey->input_dev, KEY_PHONE, 0);
-		input_report_key(touchkey->input_dev, KEY_BACK, 0);
+		for (i = 0; i < touchkey->num_keycodes; i++)
+			input_report_key(touchkey->input_dev,
+					 touchkey->keycodes[i], 0);
 	} else {
-		input_report_key(touchkey->input_dev, key, 1);
+		input_report_key(touchkey->input_dev,
+				 touchkey->keycodes[index], 1);
 	}
 
 	input_sync(touchkey->input_dev);
@@ -157,8 +149,10 @@ static irqreturn_t tm2_touchkey_irq_handler(int irq, void *devid)
 static int tm2_touchkey_probe(struct i2c_client *client,
 			      const struct i2c_device_id *id)
 {
+	struct device_node *np = client->dev.of_node;
 	struct tm2_touchkey_data *touchkey;
 	int error;
+	int i;
 
 	if (!i2c_check_functionality(client->adapter,
 			I2C_FUNC_SMBUS_BYTE | I2C_FUNC_SMBUS_BYTE_DATA)) {
@@ -189,6 +183,16 @@ static int tm2_touchkey_probe(struct i2c_client *client,
 	/* Save VDD for easy access */
 	touchkey->vdd = touchkey->regulators[1].consumer;
 
+	touchkey->num_keycodes = of_property_read_variable_u8_array(np,
+					"keycodes", touchkey->keycodes, 0,
+					ARRAY_SIZE(touchkey->keycodes));
+	if (touchkey->num_keycodes <= 0) {
+		/* default keycodes */
+		touchkey->keycodes[0] = KEY_PHONE;
+		touchkey->keycodes[1] = KEY_BACK;
+		touchkey->num_keycodes = 2;
+	}
+
 	error = tm2_touchkey_power_enable(touchkey);
 	if (error) {
 		dev_err(&client->dev, "failed to power up device: %d\n", error);
@@ -213,8 +217,9 @@ static int tm2_touchkey_probe(struct i2c_client *client,
 	touchkey->input_dev->name = touchkey->variant->name;
 	touchkey->input_dev->id.bustype = BUS_I2C;
 
-	input_set_capability(touchkey->input_dev, EV_KEY, KEY_PHONE);
-	input_set_capability(touchkey->input_dev, EV_KEY, KEY_BACK);
+	for (i = 0; i < touchkey->num_keycodes; i++)
+		input_set_capability(touchkey->input_dev, EV_KEY,
+				     touchkey->keycodes[i]);
 
 	error = input_register_device(touchkey->input_dev);
 	if (error) {
-- 
2.17.1
