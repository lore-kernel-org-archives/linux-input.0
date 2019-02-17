From: Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v5 2/4] Input: goodix - Add regulators support
Date: Sun, 17 Feb 2019 14:44:34 +0530
Message-ID: <20190217091436.3702-3-jagan@amarulasolutions.com>
References: <20190217091436.3702-1-jagan@amarulasolutions.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190217091436.3702-1-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, Rob Herring <robh+dt@kernel.org>
Cc: Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, linux-amarula@amarulasolutions.com, Michael Trimarchi <michael@amarulasolutions.com>, Jagan Teki <jagan@amarulasolutions.com>
List-Id: linux-input@vger.kernel.org

Goodix CTP controllers support analog, digital and gpio regulator
supplies on relevant controller pin configurations.

Support them via regulator bulk calls.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/input/touchscreen/goodix.c | 58 ++++++++++++++++++++++++++----
 1 file changed, 52 insertions(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index f2d9c2c41885..294456a53fe0 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -27,6 +27,7 @@
 #include <linux/delay.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
 #include <linux/of.h>
@@ -40,6 +41,15 @@ struct goodix_chip_data {
 	int (*check_config)(struct goodix_ts_data *, const struct firmware *);
 };
 
+static const char * const goodix_supply_names[] = {
+	"AVDD28",
+	"AVDD22",
+	"DVDD12",
+	"VDDIO",
+};
+
+#define GOODIX_NUM_SUPPLIES	ARRAY_SIZE(goodix_supply_names)
+
 struct goodix_ts_data {
 	struct i2c_client *client;
 	struct input_dev *input_dev;
@@ -47,6 +57,7 @@ struct goodix_ts_data {
 	struct touchscreen_properties prop;
 	unsigned int max_touch_num;
 	unsigned int int_trigger_type;
+	struct regulator_bulk_data supplies[GOODIX_NUM_SUPPLIES];
 	struct gpio_desc *gpiod_int;
 	struct gpio_desc *gpiod_rst;
 	u16 id;
@@ -761,11 +772,18 @@ static void goodix_config_cb(const struct firmware *cfg, void *ctx)
 	complete_all(&ts->firmware_loading_complete);
 }
 
+static void goodix_disable_regulator(void *arg)
+{
+	struct goodix_ts_data *ts = arg;
+
+	regulator_bulk_disable(GOODIX_NUM_SUPPLIES, ts->supplies);
+}
+
 static int goodix_ts_probe(struct i2c_client *client,
 			   const struct i2c_device_id *id)
 {
 	struct goodix_ts_data *ts;
-	int error;
+	int error, i;
 
 	dev_dbg(&client->dev, "I2C Address: 0x%02x\n", client->addr);
 
@@ -786,25 +804,49 @@ static int goodix_ts_probe(struct i2c_client *client,
 	if (error)
 		return error;
 
+	for (i = 0; i < GOODIX_NUM_SUPPLIES; i++)
+		ts->supplies[i].supply = goodix_supply_names[i];
+
+	error = devm_regulator_bulk_get(&client->dev, GOODIX_NUM_SUPPLIES,
+					ts->supplies);
+	if (error) {
+		dev_err(&client->dev, "Failed to get regulators (ret=%d)\n",
+			error);
+		return error;
+	}
+
+	error = devm_add_action_or_reset(&client->dev,
+					 goodix_disable_regulator, ts);
+	if (error)
+		return error;
+
+	/* power the controller */
+	error = regulator_bulk_enable(GOODIX_NUM_SUPPLIES, ts->supplies);
+	if (error) {
+		dev_err(&client->dev, "Failed to enable regulators (ret=%d)\n",
+			error);
+		return error;
+	}
+
 	if (ts->gpiod_int && ts->gpiod_rst) {
 		/* reset the controller */
 		error = goodix_reset(ts);
 		if (error) {
 			dev_err(&client->dev, "Controller reset failed.\n");
-			return error;
+			goto error;
 		}
 	}
 
 	error = goodix_i2c_test(client);
 	if (error) {
 		dev_err(&client->dev, "I2C communication failure: %d\n", error);
-		return error;
+		goto error;
 	}
 
 	error = goodix_read_version(ts);
 	if (error) {
 		dev_err(&client->dev, "Read version failed.\n");
-		return error;
+		goto error;
 	}
 
 	ts->chip = goodix_get_chip_data(ts->id);
@@ -823,17 +865,21 @@ static int goodix_ts_probe(struct i2c_client *client,
 			dev_err(&client->dev,
 				"Failed to invoke firmware loader: %d\n",
 				error);
-			return error;
+			goto error;
 		}
 
 		return 0;
 	} else {
 		error = goodix_configure_dev(ts);
 		if (error)
-			return error;
+			goto error;
 	}
 
 	return 0;
+
+error:
+	regulator_bulk_disable(GOODIX_NUM_SUPPLIES, ts->supplies);
+	return error;
 }
 
 static int goodix_ts_remove(struct i2c_client *client)
-- 
2.18.0.321.gffc6fa0e3
