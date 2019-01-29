From: Martin Kepplinger <martink@posteo.de>
Subject: [PATCH 2/2] Input: st1232 - switch to gpiod API
Date: Tue, 29 Jan 2019 11:23:47 +0100
Message-ID: <20190129102347.27754-2-martink@posteo.de>
References: <20190129102347.27754-1-martink@posteo.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190129102347.27754-1-martink@posteo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, Martin Kepplinger <martin.kepplinger@ginzinger.com>
List-Id: linux-input@vger.kernel.org

From: Martin Kepplinger <martin.kepplinger@ginzinger.com>

Use devm_gpiod_get_optional() and gpiod_set_value_cansleep() instead
of the old API. The st1232_ts_power() now passes on the inverted "poweron"
value to reflect the correct logical value.

Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
---

Tested and works. thanks for your help Dmitry,

                          martin



 drivers/input/touchscreen/st1232.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touchscreen/st1232.c
index 777df903605d..04d75b08be44 100644
--- a/drivers/input/touchscreen/st1232.c
+++ b/drivers/input/touchscreen/st1232.c
@@ -45,7 +45,7 @@ struct st1232_ts_data {
 	struct i2c_client *client;
 	struct input_dev *input_dev;
 	struct dev_pm_qos_request low_latency_req;
-	int reset_gpio;
+	struct gpio_desc *reset_gpio;
 	const struct st_chip_info *chip_info;
 	int read_buf_len;
 	u8 *read_buf;
@@ -142,8 +142,8 @@ static irqreturn_t st1232_ts_irq_handler(int irq, void *dev_id)
 
 static void st1232_ts_power(struct st1232_ts_data *ts, bool poweron)
 {
-	if (gpio_is_valid(ts->reset_gpio))
-		gpio_direction_output(ts->reset_gpio, poweron);
+	if (ts->reset_gpio)
+		gpiod_set_value_cansleep(ts->reset_gpio, !poweron);
 }
 
 static const struct st_chip_info st1232_chip_info = {
@@ -215,15 +215,13 @@ static int st1232_ts_probe(struct i2c_client *client,
 	ts->client = client;
 	ts->input_dev = input_dev;
 
-	ts->reset_gpio = of_get_gpio(client->dev.of_node, 0);
-	if (gpio_is_valid(ts->reset_gpio)) {
-		error = devm_gpio_request(&client->dev, ts->reset_gpio, NULL);
-		if (error) {
-			dev_err(&client->dev,
-				"Unable to request GPIO pin %d.\n",
-				ts->reset_gpio);
-				return error;
-		}
+	ts->reset_gpio = devm_gpiod_get_optional(&client->dev, "reset",
+						 GPIOD_OUT_HIGH);
+	if (IS_ERR(ts->reset_gpio)) {
+		error = PTR_ERR(ts->reset_gpio);
+		dev_err(&client->dev, "Unable to request GPIO pin: %d.\n",
+			error);
+		return error;
 	}
 
 	st1232_ts_power(ts, true);
-- 
2.20.1
