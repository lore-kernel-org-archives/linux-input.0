From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 09/10] Input: eeti_ts - expect platform code to set interrupt trigger
Date: Tue, 28 Feb 2017 14:46:31 -0800
Message-ID: <20170228224632.3401-9-dmitry.torokhov@gmail.com>
References: <20170228224632.3401-1-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170228224632.3401-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Instead of keying interrupt trigger off GPIO polarity, let's reply on
platform code to set it up properly for us.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/arm/mach-pxa/raumfeld.c        | 8 ++++++++
 drivers/input/touchscreen/eeti_ts.c | 6 +-----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
index 94df8e23fdb5..80b03193799d 100644
--- a/arch/arm/mach-pxa/raumfeld.c
+++ b/arch/arm/mach-pxa/raumfeld.c
@@ -21,6 +21,7 @@
 #include <linux/property.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/gpio.h>
 #include <linux/gpio/machine.h>
 #include <linux/smsc911x.h>
@@ -1055,6 +1056,7 @@ static void __init raumfeld_common_init(void)
 
 static void __init __maybe_unused raumfeld_controller_init(void)
 {
+	struct irq_data *irqd;
 	int ret;
 
 	pxa3xx_mfp_config(ARRAY_AND_SIZE(raumfeld_controller_pin_config));
@@ -1065,6 +1067,12 @@ static void __init __maybe_unused raumfeld_controller_init(void)
 	platform_device_register(&rotary_encoder_device);
 
 	spi_register_board_info(ARRAY_AND_SIZE(controller_spi_devices));
+
+	/* Set up touchscreen interrupt */
+	irqd = irq_get_irq_data(PXA_GPIO_TO_IRQ(GPIO_TOUCH_IRQ));
+	if (irqd)
+		irqd_set_trigger_type(irqd, IRQ_TYPE_LEVEL_HIGH);
+
 	i2c_register_board_info(0, &raumfeld_controller_i2c_board_info, 1);
 
 	ret = gpio_request(GPIO_SHUTDOWN_BATT, "battery shutdown");
diff --git a/drivers/input/touchscreen/eeti_ts.c b/drivers/input/touchscreen/eeti_ts.c
index ee6b87c606ef..3627c7b5f5ec 100644
--- a/drivers/input/touchscreen/eeti_ts.c
+++ b/drivers/input/touchscreen/eeti_ts.c
@@ -157,7 +157,6 @@ static int eeti_ts_probe(struct i2c_client *client,
 	struct eeti_ts_platform_data *pdata = dev_get_platdata(dev);
 	struct eeti_ts *eeti;
 	struct input_dev *input;
-	unsigned int irq_flags;
 	int error;
 
 	/*
@@ -201,15 +200,12 @@ static int eeti_ts_probe(struct i2c_client *client,
 
 	eeti->irq_active_high = pdata->irq_active_high;
 
-	irq_flags = eeti->irq_active_high ?
-		IRQF_TRIGGER_HIGH : IRQF_TRIGGER_LOW;
-
 	i2c_set_clientdata(client, eeti);
 	input_set_drvdata(input, eeti);
 
 	error = devm_request_threaded_irq(dev, client->irq,
 					  NULL, eeti_ts_isr,
-					  irq_flags | IRQF_ONESHOT,
+					  IRQF_ONESHOT,
 					  client->name, eeti);
 	if (error) {
 		dev_err(dev, "Unable to request touchscreen IRQ: %d\n",
-- 
2.11.0.483.g087da7b7c-goog
