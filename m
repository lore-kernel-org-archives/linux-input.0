From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] gpiolib: handle probe deferrals better
Date: Fri,  1 Apr 2016 13:44:08 +0200
Message-ID: <1459511048-24084-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: linux-gpio@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>, Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-input@vger.kernel.org, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-input@vger.kernel.org

The gpiolib does not currently return probe deferrals from the
.to_irq() hook while the GPIO drivers are being initialized.
Further: it keeps returning -EPROBE_DEFER for gpio[d]_get()
even after all builtin drivers have initialized.

Fix this thusly:

- Move the assignment of .to_irq() to the last step when
  using gpiolib_irqchip_add() so we can't get spurious calls
  into the .to_irq() function until all set-up is finished.

- Put in a late_initcall_sync() to set a boolean state variable to
  indicate that we're not gonna defer any longer. Since deferred
  probe happens at late_initcall() time, using late_initcall_sync()
  should be fine.

- After this point, return hard errors (-ENXIO) from both
  gpio[d]_get() and .to_irq().

This way we should (at least for all drivers using GPIOLIB_IRQCHIP)
be getting proper deferrals from both gpio[d]_get() and .to_irq()
until the irqchip side is properly set up, and then proper
errors after all drivers should have been probed.

This problem was first seen with gpio-keys.

Cc: linux-input@vger.kernel.org
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Reported-by: Alexander Stein <alexander.stein@systec-electronic.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Alexander: please test this, you need Guether's patches too,
I have it all on my "fixes" branch in the GPIO git:
https://git.kernel.org/cgit/linux/kernel/git/linusw/linux-gpio.git/log/?h=fixes

Tomeu: I think you're the authority on deferred probe these days.
Is this the right way for a subsystem to switch from returning
-EPROBE_DEFER to instead returning an unrecoverable error?

Guenther: I applied this on top of your patches, please check it
if you can, you're smarter than me with this stuff.
---
 drivers/gpio/gpiolib.c | 47 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 40 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index b747c76fd2b1..426a93f9d79e 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -68,7 +68,9 @@ LIST_HEAD(gpio_devices);
 static void gpiochip_free_hogs(struct gpio_chip *chip);
 static void gpiochip_irqchip_remove(struct gpio_chip *gpiochip);
 
+/* These keep the state of the library */
 static bool gpiolib_initialized;
+static bool gpiolib_builtin_ready;
 
 static inline void desc_set_label(struct gpio_desc *d, const char *label)
 {
@@ -1093,7 +1095,6 @@ int _gpiochip_irqchip_add(struct gpio_chip *gpiochip,
 	gpiochip->irqchip = irqchip;
 	gpiochip->irq_handler = handler;
 	gpiochip->irq_default_type = type;
-	gpiochip->to_irq = gpiochip_to_irq;
 	gpiochip->lock_key = lock_key;
 	gpiochip->irqdomain = irq_domain_add_simple(of_node,
 					gpiochip->ngpio, first_irq,
@@ -1129,6 +1130,12 @@ int _gpiochip_irqchip_add(struct gpio_chip *gpiochip,
 	}
 
 	acpi_gpiochip_request_interrupts(gpiochip);
+	/*
+	 * Wait with this until last, as someone may be asynchronously
+	 * calling .to_irq() and needs to be getting probe deferrals until
+	 * this point.
+	 */
+	gpiochip->to_irq = gpiochip_to_irq;
 
 	return 0;
 }
@@ -1366,12 +1373,21 @@ done:
 
 int gpiod_request(struct gpio_desc *desc, const char *label)
 {
-	int status = -EPROBE_DEFER;
+	int status;
 	struct gpio_device *gdev;
 
 	VALIDATE_DESC(desc);
 	gdev = desc->gdev;
 
+	/*
+	 * Defer requests until all built-in drivers have had a chance
+	 * to probe, then give up and return a hard error.
+	 */
+	if (!gpiolib_builtin_ready)
+		status = -EPROBE_DEFER;
+	else
+		status = -ENXIO;
+
 	if (try_module_get(gdev->owner)) {
 		status = __gpiod_request(desc, label);
 		if (status < 0)
@@ -1993,18 +2009,27 @@ EXPORT_SYMBOL_GPL(gpiod_cansleep);
  * gpiod_to_irq() - return the IRQ corresponding to a GPIO
  * @desc: gpio whose IRQ will be returned (already requested)
  *
- * Return the IRQ corresponding to the passed GPIO, or an error code in case of
- * error.
+ * Return the IRQ corresponding to the passed GPIO, or an error code.
  */
 int gpiod_to_irq(const struct gpio_desc *desc)
 {
-	struct gpio_chip	*chip;
-	int			offset;
+	struct gpio_chip *chip;
+	int offset;
 
 	VALIDATE_DESC(desc);
 	chip = desc->gdev->chip;
 	offset = gpio_chip_hwgpio(desc);
-	return chip->to_irq ? chip->to_irq(chip, offset) : -ENXIO;
+
+	if (chip->to_irq)
+		return chip->to_irq(chip, offset);
+	/*
+	 * We will wait for new GPIO drivers to arrive until the
+	 * late initcalls. After that we stop deferring and return
+	 * a hard error.
+	 */
+	if (!gpiolib_builtin_ready)
+		return -EPROBE_DEFER;
+	return -ENXIO;
 }
 EXPORT_SYMBOL_GPL(gpiod_to_irq);
 
@@ -2883,6 +2908,14 @@ static int __init gpiolib_dev_init(void)
 }
 core_initcall(gpiolib_dev_init);
 
+static int __init gpiolib_late_done(void)
+{
+	/* Flag that we're not deferring probes anymore */
+	gpiolib_builtin_ready = true;
+	return 0;
+}
+late_initcall_sync(gpiolib_late_done);
+
 #ifdef CONFIG_DEBUG_FS
 
 static void gpiolib_dbg_show(struct seq_file *s, struct gpio_device *gdev)
-- 
2.4.3

