From: Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 4/4] Input: jornada720_ts - get rid of mach/irqs.h and
 mach/hardware.h includes
Date: Wed, 07 Sep 2016 10:51:19 +0100
Message-ID: <E1bhZVn-0005cl-E4@rmk-PC.armlinux.org.uk>
References: <20160907095029.GL1041@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:52471 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751606AbcIGJvX (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 7 Sep 2016 05:51:23 -0400
In-Reply-To: <20160907095029.GL1041@n2100.armlinux.org.uk>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Kristoffer Ericson <kristoffer.ericson@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org

Switch the jornada720 touchscreen driver to obtain its gpio from
the platform device via gpiolib and derive the interrupt from the
GPIO, rather than via a hard-coded interrupt number obtained from
the mach/irqs.h and mach/hardware.h headers.

Tested-by: Adam Wysocki <armlinux@chmurka.net>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-sa1100/jornada720.c         | 10 ++++++++++
 drivers/input/touchscreen/jornada720_ts.c | 21 ++++++++++++++-------
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-sa1100/jornada720.c b/arch/arm/mach-sa1100/jornada720.c
index 2b96f7bc16bd..0a2ca9be00e6 100644
--- a/arch/arm/mach-sa1100/jornada720.c
+++ b/arch/arm/mach-sa1100/jornada720.c
@@ -17,6 +17,7 @@
 #include <linux/kernel.h>
 #include <linux/tty.h>
 #include <linux/delay.h>
+#include <linux/gpio/machine.h>
 #include <linux/platform_data/sa11x0-serial.h>
 #include <linux/platform_device.h>
 #include <linux/ioport.h>
@@ -228,6 +229,13 @@ static struct platform_device jornada_kbd_device = {
 	.resource	= jornada_kbd_resources,
 };
 
+static struct gpiod_lookup_table jornada_ts_gpiod_table = {
+	.dev_id		= "jornada_ts",
+	.table		= {
+		GPIO_LOOKUP("gpio", 9, "penup", GPIO_ACTIVE_HIGH),
+	},
+};
+
 static struct platform_device jornada_ts_device = {
 	.name		= "jornada_ts",
 	.id		= -1,
@@ -256,6 +264,8 @@ static int __init jornada720_init(void)
 		GPSR = GPIO_GPIO20;	/* restart gpio20 */
 		udelay(20);		/* give it some time to restart */
 
+		gpiod_add_lookup_table(&jornada_ts_gpiod_table);
+
 		ret = platform_add_devices(devices, ARRAY_SIZE(devices));
 	}
 
diff --git a/drivers/input/touchscreen/jornada720_ts.c b/drivers/input/touchscreen/jornada720_ts.c
index ea3b6a5b83e6..729b3c89324c 100644
--- a/drivers/input/touchscreen/jornada720_ts.c
+++ b/drivers/input/touchscreen/jornada720_ts.c
@@ -13,6 +13,7 @@
  * HP Jornada 710/720/729 Touchscreen Driver
  */
 
+#include <linux/gpio/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/input.h>
 #include <linux/interrupt.h>
@@ -20,9 +21,7 @@
 #include <linux/slab.h>
 #include <linux/io.h>
 
-#include <mach/hardware.h>
 #include <mach/jornada720.h>
-#include <mach/irqs.h>
 
 MODULE_AUTHOR("Kristoffer Ericson <kristoffer.ericson@gmail.com>");
 MODULE_DESCRIPTION("HP Jornada 710/720/728 touchscreen driver");
@@ -30,6 +29,7 @@ MODULE_LICENSE("GPL v2");
 
 struct jornada_ts {
 	struct input_dev *dev;
+	struct gpio_desc *gpio;
 	int x_data[4];		/* X sample values */
 	int y_data[4];		/* Y sample values */
 };
@@ -71,8 +71,8 @@ static irqreturn_t jornada720_ts_interrupt(int irq, void *dev_id)
 	struct input_dev *input = jornada_ts->dev;
 	int x, y;
 
-	/* If GPIO_GPIO9 is set to high then report pen up */
-	if (GPLR & GPIO_GPIO(9)) {
+	/* If gpio is high then report pen up */
+	if (gpiod_get_value(jornada_ts->gpio)) {
 		input_report_key(input, BTN_TOUCH, 0);
 		input_sync(input);
 	} else {
@@ -101,7 +101,7 @@ static int jornada720_ts_probe(struct platform_device *pdev)
 {
 	struct jornada_ts *jornada_ts;
 	struct input_dev *input_dev;
-	int error;
+	int error, irq;
 
 	jornada_ts = devm_kzalloc(&pdev->dev, sizeof(*jornada_ts), GFP_KERNEL);
 	if (!jornada_ts)
@@ -113,6 +113,14 @@ static int jornada720_ts_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, jornada_ts);
 
+	jornada_ts->gpio = devm_gpiod_get(&pdev->dev, "penup", GPIOD_IN);
+	if (IS_ERR(jornada_ts->gpio))
+		return PTR_ERR(jornada_ts->gpio);
+
+	irq = gpiod_to_irq(jornada_ts->gpio);
+	if (irq <= 0)
+		return irq < 0 ? irq : -EINVAL;
+
 	jornada_ts->dev = input_dev;
 
 	input_dev->name = "HP Jornada 7xx Touchscreen";
@@ -125,8 +133,7 @@ static int jornada720_ts_probe(struct platform_device *pdev)
 	input_set_abs_params(input_dev, ABS_X, 270, 3900, 0, 0);
 	input_set_abs_params(input_dev, ABS_Y, 180, 3700, 0, 0);
 
-	error = devm_request_irq(&pdev->dev, IRQ_GPIO9,
-				 jornada720_ts_interrupt,
+	error = devm_request_irq(&pdev->dev, irq, jornada720_ts_interrupt,
 				 IRQF_TRIGGER_RISING,
 				 "HP7XX Touchscreen driver", pdev);
 	if (error) {
-- 
2.1.0

