From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: tm2-touchkey - acknowledge that setting brightness is
 a blocking call
Date: Wed, 6 Feb 2019 10:16:16 -0800
Message-ID: <20190206181616.GA204279@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>, Jonathan Bakker <xc-racer2@live.ca>, Andi Shyti <andi@etezian.org>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

We need to access I2C bus when switching brightness, and that may block,
therefore we have to set stmfts_brightness_set() as LED's
brightness_set_blocking() method.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/tm2-touchkey.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/input/keyboard/tm2-touchkey.c b/drivers/input/keyboard/tm2-touchkey.c
index 7dbef96559d2..d4455f3a5cf1 100644
--- a/drivers/input/keyboard/tm2-touchkey.c
+++ b/drivers/input/keyboard/tm2-touchkey.c
@@ -78,7 +78,7 @@ static struct touchkey_variant aries_touchkey_variant = {
 	.cmd_led_off = ARIES_TOUCHKEY_CMD_LED_OFF,
 };
 
-static void tm2_touchkey_led_brightness_set(struct led_classdev *led_dev,
+static int tm2_touchkey_led_brightness_set(struct led_classdev *led_dev,
 					    enum led_brightness brightness)
 {
 	struct tm2_touchkey_data *touchkey =
@@ -97,9 +97,8 @@ static void tm2_touchkey_led_brightness_set(struct led_classdev *led_dev,
 	if (!touchkey->variant->fixed_regulator)
 		regulator_set_voltage(touchkey->vdd, volt, volt);
 
-	if (touchkey->variant->no_reg)
-		i2c_smbus_write_byte(touchkey->client, data);
-	else
+	return touchkey->variant->no_reg ?
+		i2c_smbus_write_byte(touchkey->client, data) :
 		i2c_smbus_write_byte_data(touchkey->client,
 					  touchkey->variant->base_reg, data);
 }
@@ -270,7 +269,8 @@ static int tm2_touchkey_probe(struct i2c_client *client,
 	touchkey->led_dev.name = TM2_TOUCHKEY_DEV_NAME;
 	touchkey->led_dev.brightness = LED_ON;
 	touchkey->led_dev.max_brightness = LED_ON;
-	touchkey->led_dev.brightness_set = tm2_touchkey_led_brightness_set;
+	touchkey->led_dev.brightness_set_blocking =
+					tm2_touchkey_led_brightness_set;
 
 	error = devm_led_classdev_register(&client->dev, &touchkey->led_dev);
 	if (error) {
-- 
2.20.1.611.gfbb209baf1-goog


-- 
Dmitry
