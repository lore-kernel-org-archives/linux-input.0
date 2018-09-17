From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [RFC/PATCH 5/5] RFC: ARM: simone: Hacked in keys
Date: Mon, 17 Sep 2018 11:16:03 -0700
Message-ID: <20180917181603.125492-6-dmitry.torokhov@gmail.com>
References: <20180917181603.125492-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180917181603.125492-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-input@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-input@vger.kernel.org

From: Linus Walleij <linus.walleij@linaro.org>

This serves as an illustration of how to use the gpio-keys
in board files using static device properties and machine GPIO descriptor
tables.

It is a hack for the joystick connector on the entirely
boardfile-based SIM.ONE. It will probably not be applied.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/arm/mach-ep93xx/simone.c | 60 +++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm/mach-ep93xx/simone.c b/arch/arm/mach-ep93xx/simone.c
index 41aa57581356..b998d6772158 100644
--- a/arch/arm/mach-ep93xx/simone.c
+++ b/arch/arm/mach-ep93xx/simone.c
@@ -24,7 +24,11 @@
 #include <linux/spi/mmc_spi.h>
 #include <linux/platform_data/video-ep93xx.h>
 #include <linux/platform_data/spi-ep93xx.h>
+#include <linux/gpio/machine.h>
 #include <linux/gpio.h>
+#include <linux/input.h>
+#include <linux/gpio_keys.h>
+#include <linux/property.h>
 
 #include <mach/hardware.h>
 #include <mach/gpio-ep93xx.h>
@@ -34,6 +38,47 @@
 
 #include "soc.h"
 
+static const struct property_entry simone_key_enter_props[] __initconst = {
+	PROPERTY_ENTRY_U32("linux,code",	KEY_ENTER),
+	PROPERTY_ENTRY_STRING("label",		"enter"),
+	PROPERTY_ENTRY_STRING("gpios",		"enter-gpios"),
+	{ }
+};
+
+static const struct property_entry simone_key_up_props[] __initconst = {
+	PROPERTY_ENTRY_U32("linux,code",	KEY_UP),
+	PROPERTY_ENTRY_STRING("label",		"up"),
+	PROPERTY_ENTRY_STRING("gpios",		"up-gpios"),
+	{ }
+};
+
+static const struct property_entry simone_key_up_props[] __initconst = {
+	PROPERTY_ENTRY_U32("linux,code",	KEY_LEFT),
+	PROPERTY_ENTRY_STRING("label",		"left"),
+	PROPERTY_ENTRY_STRING("gpios",		"left-gpios"),
+	{ }
+};
+
+static const struct property_entry simone_key_props[] __initconst = {
+	/* There are no properties at device level on this device */
+	{ }
+};
+
+static struct gpiod_lookup_table simone_keys_gpiod_table = {
+	.dev_id = "gpio-keys",
+	.table = {
+		/* Use local offsets on gpiochip/port "B" */
+		GPIO_LOOKUP_IDX("B", 0, "enter-gpios", 0, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("B", 1, "up-gpios", 1, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("B", 2, "left-gpios", 2, GPIO_ACTIVE_LOW),
+	},
+};
+
+static struct platform_device simone_keys_device = {
+	.name = "gpio-keys",
+	.id = -1,
+};
+
 static struct ep93xx_eth_data __initdata simone_eth_data = {
 	.phy_id		= 1,
 };
@@ -107,6 +152,21 @@ static void __init simone_init_machine(void)
 			    ARRAY_SIZE(simone_i2c_board_info));
 	ep93xx_register_spi(&simone_spi_info, simone_spi_devices,
 			    ARRAY_SIZE(simone_spi_devices));
+
+	gpiod_add_lookup_table(&simone_keys_gpiod_table);
+	device_add_properties(&simone_keys_device.dev,
+			      simone_keys_device_props);
+	device_add_child_properties(&simone_keys_device.dev,
+				    dev_fwnode(&simone_keys_device.dev),
+				    simone_key_enter_props);
+	device_add_child_properties(&simone_keys_device.dev,
+				    dev_fwnode(&simone_keys_device.dev),
+				    simone_key_up_props);
+	device_add_child_properties(&simone_keys_device.dev,
+				    dev_fwnode(&simone_keys_device.dev),
+				    simone_key_left_props);
+	platform_device_register(&simone_keys_device);
+
 	simone_register_audio();
 }
 
-- 
2.19.0.397.gdd90340f6a-goog
