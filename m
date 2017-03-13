From: Petr Cvek <petr.cvek@tul.cz>
Subject: [PATCH v2] ARM: pxa: magician: Add support for ADS7846 touchscreen
Date: Mon, 13 Mar 2017 01:25:00 +0100
Message-ID: <65621425-91ac-1726-88ba-4626c85e7981@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bubo.tul.cz ([147.230.16.1]:54910 "EHLO bubo.tul.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755828AbdCMAXQ (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sun, 12 Mar 2017 20:23:16 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: philipp.zabel@gmail.com, daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr
Cc: linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org

This patch adds a support for ADS7846 touchscreen driver.

The basic functionality was tested, x_plate_ohms and y_plate_ohms were
physically measured. The value pressure_max was empirically set to match
the measured range, which is affected by x_plate_ohms and ADS samples.

The value of keep_vref_on doesn't seem to have any effect on measurements
(at least on T-Mobile MDA Compact PM10A device). Leave it to zero so
the internal and external Vref sources will not collide.

SPI framing pin (gpio_cs) must be used in GPIO mode due to an incompatible
autoframing of PXA27x controller and ADS7846 device.

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 arch/arm/mach-pxa/include/mach/magician.h |  1 +
 arch/arm/mach-pxa/magician.c              | 84 ++++++++++++++++++++++++++++++-
 2 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/include/mach/magician.h b/arch/arm/mach-pxa/include/mach/magician.h
index 5f6b850ebe33..c48b54d0f331 100644
--- a/arch/arm/mach-pxa/include/mach/magician.h
+++ b/arch/arm/mach-pxa/include/mach/magician.h
@@ -24,6 +24,7 @@
 #define GPIO10_MAGICIAN_GSM_IRQ			10
 #define GPIO11_MAGICIAN_GSM_OUT1		11
 #define GPIO13_MAGICIAN_CPLD_IRQ		13
+#define GPIO14_MAGICIAN_TSC2046_CS		14
 #define GPIO18_MAGICIAN_UNKNOWN			18
 #define GPIO22_MAGICIAN_VIBRA_EN		22
 #define GPIO26_MAGICIAN_GSM_POWER		26
diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index b413e36506af..1d1c01b56a8d 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -54,6 +54,10 @@
 #include "devices.h"
 #include "generic.h"
 
+#include <linux/spi/spi.h>
+#include <linux/spi/pxa2xx_spi.h>
+#include <linux/spi/ads7846.h>
+
 static unsigned long magician_pin_config[] __initdata = {
 
 	/* SDRAM and Static Memory I/O Signals */
@@ -85,7 +89,7 @@ static unsigned long magician_pin_config[] __initdata = {
 
 	/* SSP 2 TSC2046 touchscreen */
 	GPIO19_SSP2_SCLK,
-	GPIO14_SSP2_SFRM,
+	MFP_CFG_OUT(GPIO14, AF0, DRIVE_HIGH),	/* frame as GPIO */
 	GPIO89_SSP2_TXD,
 	GPIO88_SSP2_RXD,
 
@@ -675,6 +679,37 @@ static struct platform_device bq24022 = {
 };
 
 /*
+ * fixed regulator for ads7846
+ */
+
+static struct regulator_consumer_supply ads7846_supply =
+	REGULATOR_SUPPLY("vcc", "spi2.0");
+
+static struct regulator_init_data vads7846_regulator = {
+	.constraints	= {
+		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &ads7846_supply,
+};
+
+static struct fixed_voltage_config vads7846 = {
+	.supply_name	= "vads7846",
+	.microvolts	= 3300000, /* probably */
+	.gpio		= -EINVAL,
+	.startup_delay	= 0,
+	.init_data	= &vads7846_regulator,
+};
+
+static struct platform_device vads7846_device = {
+	.name	= "reg-fixed-voltage",
+	.id	= -1,
+	.dev	= {
+		.platform_data	= &vads7846,
+	},
+};
+
+/*
  * Vcore regulator MAX1587A
  */
 
@@ -852,6 +887,49 @@ static struct i2c_pxa_platform_data magician_i2c_power_info = {
 };
 
 /*
+ * Touchscreen
+ */
+
+static struct ads7846_platform_data ads7846_pdata = {
+	.model		= 7846,
+	.x_plate_ohms	= 317,
+	.y_plate_ohms	= 500,
+	.pressure_max	= 1023,	/* with x plate ohms it will overflow 255 */
+	.debounce_max	= 3,	/* first readout is always bad */
+	.debounce_tol	= 30,
+	.debounce_rep	= 0,
+	.gpio_pendown	= GPIO115_MAGICIAN_nPEN_IRQ,
+	.keep_vref_on	= 0,
+	.wakeup		= true,
+	.vref_delay_usecs		= 100,
+	.penirq_recheck_delay_usecs	= 100,
+};
+
+struct pxa2xx_spi_chip tsc2046_chip_info = {
+	.tx_threshold	= 1,
+	.rx_threshold	= 2,
+	.timeout	= 64,
+	/* NOTICE must be GPIO, incompatibility with hw PXA SPI framing */
+	.gpio_cs	= GPIO14_MAGICIAN_TSC2046_CS,
+};
+
+static struct pxa2xx_spi_master magician_spi_info = {
+	.num_chipselect	= 1,
+	.enable_dma	= 1,
+};
+
+static struct spi_board_info ads7846_spi_board_info[] __initdata = {
+	{
+		.modalias		= "ads7846",
+		.bus_num		= 2,
+		.max_speed_hz		= 2500000,
+		.platform_data		= &ads7846_pdata,
+		.controller_data	= &tsc2046_chip_info,
+		.irq = PXA_GPIO_TO_IRQ(GPIO115_MAGICIAN_nPEN_IRQ),
+	},
+};
+
+/*
  * Platform devices
  */
 
@@ -865,6 +943,7 @@ static struct platform_device *devices[] __initdata = {
 	&power_supply,
 	&strataflash,
 	&leds_gpio,
+	&vads7846_device,
 };
 
 static struct gpio magician_global_gpios[] = {
@@ -922,6 +1001,9 @@ static void __init magician_init(void)
 	} else
 		pr_err("LCD detection: CPLD mapping failed\n");
 
+	pxa2xx_set_spi_info(2, &magician_spi_info);
+	spi_register_board_info(ARRAY_AND_SIZE(ads7846_spi_board_info));
+
 	regulator_register_always_on(0, "power", pwm_backlight_supply,
 		ARRAY_SIZE(pwm_backlight_supply), 5000000);
 
-- 
2.11.0

