From: Peter Cai <peter@typeblog.net>
Subject: [PATCH 2/2] touchscreen: goodix: define GPIO mapping for GPD P2 Max
Date: Fri, 30 Aug 2019 08:00:24 +0800
Message-ID: <20190830000024.20384-2-peter@typeblog.net>
References: <20190830000024.20384-1-peter@typeblog.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190830000024.20384-1-peter@typeblog.net>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Peter Cai <peter@typeblog.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Bastien Nocera <hadess@hadess.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The firmware of GPD P2 Max could not handle panel resets although code
is present in DSDT. The kernel needs to take on this job instead, but
the DSDT does not provide _DSD, rendering kernel helpless when trying to
find the respective GPIO pins.

Fortunately, this time GPD has proper DMI vendor / product strings that
we could match against. We simply apply an acpi_gpio_mapping table when
GPD P2 Max is matched.

Additionally, the DSDT definition of the irq pin specifies a wrong
polarity. The new quirk introduced in the previous patch
(ACPI_GPIO_QUIRK_OVERRIDE_POLARITY) is applied to correct this.

Signed-off-by: Peter Cai <peter@typeblog.net>
---
 drivers/input/touchscreen/goodix.c | 37 ++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index 5178ea8b5f30..65b8d04b6dcf 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -144,6 +144,34 @@ static const struct dmi_system_id rotated_screen[] = {
 	{}
 };
 
+#ifdef CONFIG_ACPI
+static const struct acpi_gpio_params irq_gpios_default = { 0, 0, false };
+static const struct acpi_gpio_params reset_gpios_default = { 1, 0, false };
+static const struct acpi_gpio_mapping gpio_mapping_force_irq_active_high[] = {
+	{ "irq-gpios", &irq_gpios_default, 1,
+		ACPI_GPIO_QUIRK_OVERRIDE_POLARITY },
+	{ "reset-gpios", &reset_gpios_default, 1 },
+	{}
+};
+
+/*
+ * Devices that need acpi_gpio_mapping to function correctly
+ */
+static const struct dmi_system_id need_gpio_mapping[] = {
+#if defined(CONFIG_DMI) && defined(CONFIG_X86)
+	{
+		.ident = "GPD P2 Max",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "GPD"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "P2 MAX")
+		},
+		.driver_data = &gpio_mapping_force_irq_active_high
+	},
+#endif
+	{}
+};
+#endif
+
 /**
  * goodix_i2c_read - read data from a register of the i2c slave device.
  *
@@ -796,6 +824,15 @@ static int goodix_ts_probe(struct i2c_client *client,
 	struct goodix_ts_data *ts;
 	int error;
 
+#ifdef CONFIG_ACPI
+	struct dmi_system_id *dmi_match;
+
+	dmi_match = dmi_first_match(need_gpio_mapping);
+	if (dmi_match)
+		devm_acpi_dev_add_driver_gpios(&client->dev,
+					       dmi_match->driver_data);
+#endif
+
 	dev_dbg(&client->dev, "I2C Address: 0x%02x\n", client->addr);
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
-- 
2.23.0
