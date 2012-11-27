From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 3/3] Input: bu21013_ts - Add support for Device Tree booting
Date: Tue, 27 Nov 2012 13:13:10 +0000
Message-ID: <1354021990-16978-4-git-send-email-lee.jones@linaro.org>
References: <1354021990-16978-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1354021990-16978-1-git-send-email-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, linus.walleij@stericsson.com, Lee Jones <lee.jones@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Now we can register the BU21013_ts touch screen when booting with
Device Tree enabled. Here we parse all the necessary components
previously expected to be passed from platform data.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/input/touchscreen/bu21013_ts.c |   36 ++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/bu21013_ts.c b/drivers/input/touchscreen/bu21013_ts.c
index 8982bea..dbbd1f8 100644
--- a/drivers/input/touchscreen/bu21013_ts.c
+++ b/drivers/input/touchscreen/bu21013_ts.c
@@ -15,6 +15,8 @@
 #include <linux/regulator/consumer.h>
 #include <linux/module.h>
 #include <linux/gpio.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
 
 #define PEN_DOWN_INTR	0
 #define MAX_FINGERS	2
@@ -454,13 +456,30 @@ static void bu21013_cs_disable(struct bu21013_ts_data *bu21013_data)
  * This function used to initializes the i2c-client touchscreen
  * driver and returns integer.
  */
+static void __devinit bu21013_of_probe(struct device_node *np,
+				       struct bu21013_platform_device *pdata)
+{
+	pdata->y_flip = pdata->x_flip = false;
+
+	pdata->x_flip = of_property_read_bool(np, "rohm,flip-x");
+	pdata->y_flip = of_property_read_bool(np, "rohm,flip-y");
+
+	of_property_read_u32(np, "rohm,touch-max-x", &pdata->touch_x_max);
+	of_property_read_u32(np, "rohm,touch-max-y", &pdata->touch_y_max);
+
+	pdata->touch_pin = of_get_named_gpio(np, "touch-gpio", 0);
+	pdata->cs_pin = of_get_named_gpio(np, "reset-gpio", 0);
+
+	pdata->ext_clk = false;
+}
+
 static int __devinit bu21013_probe(struct i2c_client *client,
 				   const struct i2c_device_id *id)
 {
 	struct bu21013_ts_data *bu21013_data;
 	struct input_dev *in_dev;
-	const struct bu21013_platform_device *pdata =
-					client->dev.platform_data;
+	struct device_node *np = client->dev.of_node;
+	struct bu21013_platform_device *pdata = client->dev.platform_data;
 	int error;
 
 	if (!i2c_check_functionality(client->adapter,
@@ -470,8 +489,17 @@ static int __devinit bu21013_probe(struct i2c_client *client,
 	}
 
 	if (!pdata) {
-		dev_err(&client->dev, "platform data not defined\n");
-		return -EINVAL;
+		if (np) {
+			pdata = devm_kzalloc(&client->dev, sizeof(*pdata),
+					GFP_KERNEL);
+			if (!pdata)
+				return -ENOMEM;
+
+			bu21013_of_probe(np, pdata);
+		} else {
+			dev_err(&client->dev, "no device tree or platform data\n");
+			return -EINVAL;
+		}
 	}
 
 	if (!gpio_is_valid(pdata->touch_pin)) {
-- 
1.7.9.5
