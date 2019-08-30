From: Peter Cai <peter@typeblog.net>
Subject: [PATCH 1/2] gpio: acpi: add quirk to override GpioInt polarity
Date: Fri, 30 Aug 2019 08:00:23 +0800
Message-ID: <20190830000024.20384-1-peter@typeblog.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Peter Cai <peter@typeblog.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Bastien Nocera <hadess@hadess.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On GPD P2 Max, the firmware could not reset the touch panel correctly.
The kernel needs to take on the job instead, but the GpioInt definition
in DSDT specifies ActiveHigh while the GPIO pin should actually be
ActiveLow.

We need to override the polarity defined by DSDT. The GPIO driver
already allows defining polarity in acpi_gpio_params, but the option is
not applied to GpioInt.

This patch adds a new quirk that enables the polarity specified in
acpi_gpio_params to also be applied to GpioInt.

Signed-off-by: Peter Cai <peter@typeblog.net>
---
 drivers/gpio/gpiolib-acpi.c | 10 +++++++++-
 include/linux/acpi.h        |  6 ++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 39f2f9035c11..1a07c79ca2de 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -583,13 +583,21 @@ static int acpi_populate_gpio_lookup(struct acpi_resource *ares, void *data)
 		/*
 		 * Polarity and triggering are only specified for GpioInt
 		 * resource.
+		 * Polarity specified by GpioInt may be ignored if
+		 * ACPI_GPIO_QUIRK_OVERRIDE_POLARITY is set.
 		 * Note: we expect here:
 		 * - ACPI_ACTIVE_LOW == GPIO_ACTIVE_LOW
 		 * - ACPI_ACTIVE_HIGH == GPIO_ACTIVE_HIGH
 		 */
 		if (lookup->info.gpioint) {
 			lookup->info.flags = GPIOD_IN;
-			lookup->info.polarity = agpio->polarity;
+			if (lookup->info.quirks &
+					ACPI_GPIO_QUIRK_OVERRIDE_POLARITY) {
+				dev_warn(&lookup->info.adev->dev, FW_BUG "Incorrect polarity specified by GpioInt, overriding.\n");
+				lookup->info.polarity = lookup->active_low;
+			} else {
+				lookup->info.polarity = agpio->polarity;
+			}
 			lookup->info.triggering = agpio->triggering;
 		} else {
 			lookup->info.flags = acpi_gpio_to_gpiod_flags(agpio);
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 9426b9aaed86..6569773ceffd 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1014,6 +1014,12 @@ struct acpi_gpio_mapping {
  * get GpioIo type explicitly, this quirk may be used.
  */
 #define ACPI_GPIO_QUIRK_ONLY_GPIOIO		BIT(1)
+/*
+ * Use the GPIO polarity (ActiveHigh / ActiveLow) from acpi_gpio_params
+ * for GpioInt as well. The default behavior is to use the one specified
+ * by GpioInt, which can be incorrect on some devices.
+ */
+#define ACPI_GPIO_QUIRK_OVERRIDE_POLARITY	BIT(2)
 
 	unsigned int quirks;
 };
-- 
2.23.0
