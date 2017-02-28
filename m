From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 10/10] Input: eeti_ts - switch to gpiod API
Date: Tue, 28 Feb 2017 14:46:32 -0800
Message-ID: <20170228224632.3401-10-dmitry.torokhov@gmail.com>
References: <20170228224632.3401-1-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170228224632.3401-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

gpiod API allows standard way of specifying GPIO polarity and takes it into
account when reading or setting GPIO state. It also allows us to switch to
common way of obtaining GPIO descriptor and away form legacy platform data.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/arm/mach-pxa/raumfeld.c        | 14 +++++++++-----
 drivers/input/touchscreen/eeti_ts.c | 24 +++++++-----------------
 include/linux/input/eeti_ts.h       | 10 ----------
 3 files changed, 16 insertions(+), 32 deletions(-)
 delete mode 100644 include/linux/input/eeti_ts.h

diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
index 80b03193799d..b0886ef92d8c 100644
--- a/arch/arm/mach-pxa/raumfeld.c
+++ b/arch/arm/mach-pxa/raumfeld.c
@@ -27,7 +27,6 @@
 #include <linux/smsc911x.h>
 #include <linux/input.h>
 #include <linux/gpio_keys.h>
-#include <linux/input/eeti_ts.h>
 #include <linux/leds.h>
 #include <linux/w1-gpio.h>
 #include <linux/sched.h>
@@ -966,16 +965,19 @@ static struct i2c_board_info raumfeld_connector_i2c_board_info __initdata = {
 	.addr	= 0x48,
 };
 
-static struct eeti_ts_platform_data eeti_ts_pdata = {
-	.irq_active_high = 1,
-	.irq_gpio = GPIO_TOUCH_IRQ,
+static struct gpiod_lookup_table raumfeld_controller_gpios_table = {
+	.dev_id = "0-000a",
+	.table = {
+		GPIO_LOOKUP("gpio-pxa",
+			    GPIO_TOUCH_IRQ, "attn", GPIO_ACTIVE_HIGH),
+		{ },
+	},
 };
 
 static struct i2c_board_info raumfeld_controller_i2c_board_info __initdata = {
 	.type	= "eeti_ts",
 	.addr	= 0x0a,
 	.irq	= PXA_GPIO_TO_IRQ(GPIO_TOUCH_IRQ),
-	.platform_data = &eeti_ts_pdata,
 };
 
 static struct platform_device *raumfeld_common_devices[] = {
@@ -1073,6 +1075,8 @@ static void __init __maybe_unused raumfeld_controller_init(void)
 	if (irqd)
 		irqd_set_trigger_type(irqd, IRQ_TYPE_LEVEL_HIGH);
 
+	gpiod_add_lookup_table(&raumfeld_controller_gpios_table);
+
 	i2c_register_board_info(0, &raumfeld_controller_i2c_board_info, 1);
 
 	ret = gpio_request(GPIO_SHUTDOWN_BATT, "battery shutdown");
diff --git a/drivers/input/touchscreen/eeti_ts.c b/drivers/input/touchscreen/eeti_ts.c
index 3627c7b5f5ec..2facad75eb6d 100644
--- a/drivers/input/touchscreen/eeti_ts.c
+++ b/drivers/input/touchscreen/eeti_ts.c
@@ -31,8 +31,7 @@
 #include <linux/interrupt.h>
 #include <linux/i2c.h>
 #include <linux/timer.h>
-#include <linux/gpio.h>
-#include <linux/input/eeti_ts.h>
+#include <linux/gpio/consumer.h>
 #include <linux/slab.h>
 #include <asm/unaligned.h>
 
@@ -47,7 +46,7 @@ MODULE_PARM_DESC(flip_y, "flip y coordinate");
 struct eeti_ts {
 	struct i2c_client *client;
 	struct input_dev *input;
-	int irq_gpio, irq_active_high;
+	struct gpio_desc *attn_gpio;
 	bool running;
 };
 
@@ -60,11 +59,6 @@ struct eeti_ts {
 #define REPORT_BIT_HAS_PRESSURE	BIT(6)
 #define REPORT_RES_BITS(v)	(((v) >> 1) + EETI_TS_BITDEPTH)
 
-static inline int eeti_ts_irq_active(struct eeti_ts *eeti)
-{
-	return gpio_get_value_cansleep(eeti->irq_gpio) == eeti->irq_active_high;
-}
-
 static void eeti_ts_report_event(struct eeti_ts *eeti, u8 *buf)
 {
 	unsigned int res;
@@ -115,7 +109,8 @@ static irqreturn_t eeti_ts_isr(int irq, void *dev_id)
 			/* Motion packet */
 			eeti_ts_report_event(eeti, buf);
 		}
-	} while (eeti->running && eeti_ts_irq_active(eeti));
+	} while (eeti->running &&
+		 eeti->attn_gpio && gpiod_get_value_cansleep(eeti->attn_gpio));
 
 	return IRQ_HANDLED;
 }
@@ -154,7 +149,6 @@ static int eeti_ts_probe(struct i2c_client *client,
 			 const struct i2c_device_id *idp)
 {
 	struct device *dev = &client->dev;
-	struct eeti_ts_platform_data *pdata = dev_get_platdata(dev);
 	struct eeti_ts *eeti;
 	struct input_dev *input;
 	int error;
@@ -191,14 +185,10 @@ static int eeti_ts_probe(struct i2c_client *client,
 
 	eeti->client = client;
 	eeti->input = input;
-	eeti->irq_gpio = pdata->irq_gpio;
-
-	error = devm_gpio_request_one(dev, pdata->irq_gpio, GPIOF_IN,
-				      client->name);
-	if (error)
-		return error;
 
-	eeti->irq_active_high = pdata->irq_active_high;
+	eeti->attn_gpio = devm_gpiod_get_optional(dev, "attn", GPIOD_IN);
+	if (IS_ERR(eeti->attn_gpio))
+		return PTR_ERR(eeti->attn_gpio);
 
 	i2c_set_clientdata(client, eeti);
 	input_set_drvdata(input, eeti);
diff --git a/include/linux/input/eeti_ts.h b/include/linux/input/eeti_ts.h
deleted file mode 100644
index 16625d799b6f..000000000000
--- a/include/linux/input/eeti_ts.h
+++ /dev/null
@@ -1,10 +0,0 @@
-#ifndef LINUX_INPUT_EETI_TS_H
-#define LINUX_INPUT_EETI_TS_H
-
-struct eeti_ts_platform_data {
-	int irq_gpio;
-	unsigned int irq_active_high;
-};
-
-#endif /* LINUX_INPUT_EETI_TS_H */
-
-- 
2.11.0.483.g087da7b7c-goog
