From: Peter Cai <peter@typeblog.net>
Subject: [PATCH v3 1/2] gpio: acpi: add quirk to override GpioInt polarity
Date: Mon,  2 Sep 2019 20:43:51 +0800
Message-ID: <20190902124352.12291-1-peter@typeblog.net>
References: <20190831030916.13172-1-peter@typeblog.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190831030916.13172-1-peter@typeblog.net>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Peter Cai <peter@typeblog.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Bastien Nocera <hadess@hadess.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
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
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v2: rebased to gpio/for-next, moved quirk out of the gpioint
conditional.

v3: no change, series update.
---
 drivers/gpio/gpiolib-acpi.c   | 9 +++++++++
 include/linux/gpio/consumer.h | 6 ++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index fdee8afa5339..ab16ea61a8fa 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -603,6 +603,15 @@ static int acpi_populate_gpio_lookup(struct acpi_resource *ares, void *data)
 			lookup->info.flags = acpi_gpio_to_gpiod_flags(agpio);
 			lookup->info.polarity = lookup->active_low;
 		}
+
+		/*
+		 * Override the polarity specified by GpioInt if
+		 * ACPI_GPIO_QUIRK_OVERRIDE_POLARITY is set.
+		 */
+		if (lookup->info.quirks & ACPI_GPIO_QUIRK_OVERRIDE_POLARITY) {
+			dev_warn(&lookup->info.adev->dev, FW_BUG "Incorrect polarity specified by GpioInt, overriding.\n");
+			lookup->info.polarity = lookup->active_low;
+		}
 	}
 
 	return 1;
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index b70af921c614..7e9f24ebb085 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -622,6 +622,12 @@ struct acpi_gpio_mapping {
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
