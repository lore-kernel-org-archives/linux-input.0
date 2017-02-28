From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 06/10] Input: eeti_ts - respect interrupt set in client structure
Date: Tue, 28 Feb 2017 14:46:28 -0800
Message-ID: <20170228224632.3401-6-dmitry.torokhov@gmail.com>
References: <20170228224632.3401-1-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170228224632.3401-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Instead of expecting that GPIO is always interrupt source, let's use
interrupt specified in I2C client.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/arm/mach-pxa/raumfeld.c        |  1 +
 drivers/input/touchscreen/eeti_ts.c | 13 ++++++-------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
index c27ce1f070d2..94df8e23fdb5 100644
--- a/arch/arm/mach-pxa/raumfeld.c
+++ b/arch/arm/mach-pxa/raumfeld.c
@@ -973,6 +973,7 @@ static struct eeti_ts_platform_data eeti_ts_pdata = {
 static struct i2c_board_info raumfeld_controller_i2c_board_info __initdata = {
 	.type	= "eeti_ts",
 	.addr	= 0x0a,
+	.irq	= PXA_GPIO_TO_IRQ(GPIO_TOUCH_IRQ),
 	.platform_data = &eeti_ts_pdata,
 };
 
diff --git a/drivers/input/touchscreen/eeti_ts.c b/drivers/input/touchscreen/eeti_ts.c
index e99e4fec93f5..ac78ac6d4936 100644
--- a/drivers/input/touchscreen/eeti_ts.c
+++ b/drivers/input/touchscreen/eeti_ts.c
@@ -49,7 +49,7 @@ struct eeti_ts {
 	struct input_dev *input;
 	struct work_struct work;
 	struct mutex mutex;
-	int irq_gpio, irq, irq_active_high;
+	int irq_gpio, irq_active_high;
 };
 
 #define EETI_TS_BITDEPTH	(11)
@@ -128,7 +128,7 @@ static irqreturn_t eeti_ts_isr(int irq, void *dev_id)
 
 static void eeti_ts_start(struct eeti_ts *eeti)
 {
-	enable_irq(eeti->irq);
+	enable_irq(eeti->client->irq);
 
 	/* Read the events once to arm the IRQ */
 	eeti_ts_read(&eeti->work);
@@ -136,7 +136,7 @@ static void eeti_ts_start(struct eeti_ts *eeti)
 
 static void eeti_ts_stop(struct eeti_ts *eeti)
 {
-	disable_irq(eeti->irq);
+	disable_irq(eeti->client->irq);
 	cancel_work_sync(&eeti->work);
 }
 
@@ -201,7 +201,6 @@ static int eeti_ts_probe(struct i2c_client *client,
 	eeti->client = client;
 	eeti->input = input;
 	eeti->irq_gpio = pdata->irq_gpio;
-	eeti->irq = gpio_to_irq(pdata->irq_gpio);
 
 	error = devm_gpio_request_one(dev, pdata->irq_gpio, GPIOF_IN,
 				      client->name);
@@ -221,7 +220,7 @@ static int eeti_ts_probe(struct i2c_client *client,
 	if (error)
 		return error;
 
-	error = devm_request_irq(dev, eeti->irq, eeti_ts_isr, irq_flags,
+	error = devm_request_irq(dev, client->irq, eeti_ts_isr, irq_flags,
 				 client->name, eeti);
 	if (error) {
 		dev_err(dev, "Unable to request touchscreen IRQ: %d\n",
@@ -252,7 +251,7 @@ static int __maybe_unused eeti_ts_suspend(struct device *dev)
 	mutex_unlock(&input_dev->mutex);
 
 	if (device_may_wakeup(&client->dev))
-		enable_irq_wake(eeti->irq);
+		enable_irq_wake(client->irq);
 
 	return 0;
 }
@@ -264,7 +263,7 @@ static int __maybe_unused eeti_ts_resume(struct device *dev)
 	struct input_dev *input_dev = eeti->input;
 
 	if (device_may_wakeup(&client->dev))
-		disable_irq_wake(eeti->irq);
+		disable_irq_wake(client->irq);
 
 	mutex_lock(&input_dev->mutex);
 
-- 
2.11.0.483.g087da7b7c-goog
