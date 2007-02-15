From: Philipp Zabel <philipp.zabel@gmail.com>
Subject: [PATCH] gpio-keys
Date: Thu, 15 Feb 2007 12:06:59 +0100
Message-ID: <1171537620.27151.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: linux-input@atrey.karlin.mff.cuni.cz
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Paul Sokolovsky <pmiscml@gmail.com>
List-Id: linux-input@vger.kernel.org

Now that the common GPIO API is in mainline, gpio-keys should use it.
This adds support for at least SA1100 and S3C24xx CPUs.

Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>

Index: linux-2.6/drivers/input/keyboard/Kconfig
===================================================================
--- linux-2.6.orig/drivers/input/keyboard/Kconfig	2007-02-15 10:18:58.000000000 +0100
+++ linux-2.6/drivers/input/keyboard/Kconfig	2007-02-15 10:20:03.000000000 +0100
@@ -216,10 +216,10 @@
 
 config KEYBOARD_GPIO
         tristate "Buttons on CPU GPIOs (PXA)"
-        depends on ARCH_PXA
+	depends on (ARCH_SA1100 || ARCH_PXA || ARCH_S3C2410)
 	help
 	  This driver implements support for buttons connected
-	  directly to GPIO pins of PXA CPUs.
+	  directly to GPIO pins of SA1100, PXA or S3C24xx CPUs.
 
 	  Say Y here if your device has buttons connected
 	  directly to GPIO pins of the CPU.
Index: linux-2.6/drivers/input/keyboard/gpio_keys.c
===================================================================
--- linux-2.6.orig/drivers/input/keyboard/gpio_keys.c	2007-02-15 10:17:05.000000000 +0100
+++ linux-2.6/drivers/input/keyboard/gpio_keys.c	2007-02-15 10:18:18.000000000 +0100
@@ -24,7 +24,7 @@
 #include <linux/input.h>
 #include <linux/irq.h>
 
-#include <asm/arch/pxa-regs.h>
+#include <asm/gpio.h>
 #include <asm/arch/hardware.h>
 
 #include <asm/hardware/gpio_keys.h>
@@ -38,8 +38,8 @@
 
 	for (i = 0; i < pdata->nbuttons; i++) {
 		int gpio = pdata->buttons[i].gpio;
-		if (irq == IRQ_GPIO(gpio)) {
-			int state = ((GPLR(gpio) & GPIO_bit(gpio)) ? 1 : 0) ^ (pdata->buttons[i].active_low);
+		if (irq == gpio_to_irq(gpio)) {
+			int state = (gpio_get_value(gpio) ? 1 : 0) ^ (pdata->buttons[i].active_low);
 
 			input_report_key(input, pdata->buttons[i].keycode, state);
 			input_sync(input);
@@ -75,7 +75,7 @@
 
 	for (i = 0; i < pdata->nbuttons; i++) {
 		int code = pdata->buttons[i].keycode;
-		int irq = IRQ_GPIO(pdata->buttons[i].gpio);
+		int irq = gpio_to_irq(pdata->buttons[i].gpio);
 
 		set_irq_type(irq, IRQ_TYPE_EDGE_BOTH);
 		error = request_irq(irq, gpio_keys_isr, IRQF_SAMPLE_RANDOM,
@@ -98,7 +98,7 @@
 
  fail:
 	for (i = i - 1; i >= 0; i--)
-		free_irq(IRQ_GPIO(pdata->buttons[i].gpio), pdev);
+		free_irq(gpio_to_irq(pdata->buttons[i].gpio), pdev);
 
 	input_free_device(input);
 
@@ -112,7 +112,7 @@
 	int i;
 
 	for (i = 0; i < pdata->nbuttons; i++) {
-		int irq = IRQ_GPIO(pdata->buttons[i].gpio);
+		int irq = gpio_to_irq(pdata->buttons[i].gpio);
 		free_irq(irq, pdev);
 	}
 
