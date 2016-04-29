From: Ksenija Stanojevic <ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/3] mfd: mxs-lradc: Add support for mxs-lradc MFD
Date: Fri, 29 Apr 2016 13:47:15 +0200
Message-ID: <a93050366ed452b147652abfad21a87f4af87bfb.1461930102.git.ksenija.stanojevic@gmail.com>
References: <cover.1461930102.git.ksenija.stanojevic@gmail.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1461930102.git.ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-95f8Dae0BrPYtjvyW6yDsg@public.gmane.org, Ksenija Stanojevic <ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Add core files for mxs-lradc MFD driver.

Signed-off-by: Ksenija Stanojevic <ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/mfd/Kconfig           |  33 +++++--
 drivers/mfd/Makefile          |   1 +
 drivers/mfd/mxs-lradc.c       | 213 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/mxs-lradc.h | 210 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 449 insertions(+), 8 deletions(-)
 create mode 100644 drivers/mfd/mxs-lradc.c
 create mode 100644 include/linux/mfd/mxs-lradc.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index eea61e3..fff44d6 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -16,7 +16,7 @@ config MFD_CS5535
 	depends on PCI && (X86_32 || (X86 && COMPILE_TEST))
 	---help---
 	  This is the core driver for CS5535/CS5536 MFD functions.  This is
-          necessary for using the board's GPIO and MFGPT functionality.
+	  necessary for using the board's GPIO and MFGPT functionality.
 
 config MFD_ACT8945A
 	tristate "Active-semi ACT8945A"
@@ -319,6 +319,23 @@ config MFD_HI6421_PMIC
 	  menus in order to enable them.
 	  We communicate with the Hi6421 via memory-mapped I/O.
 
+config MFD_MXS_LRADC
+	tristate "Freescale i.MX23/i.MX28 LRADC"
+	depends on ARCH_MXS || COMPILE_TEST
+	select MFD_CORE
+	select STMP_DEVICE
+	help
+	  Say yes here to build support for the low-resolution
+	  analog-to-digital converter (LRADC) found on the i.MX23 and i.MX28
+	  processors. This driver provides common support for accessing the
+	  device, additional drivers must be enabled in order to use the
+	  functionality of the device:
+		mxs-lradc-adc for ADC readings
+		mxs-lradc-ts  for touchscreen support
+
+	  This driver can also be built as a module. If so, the module will be
+	  called mxs-lradc.
+
 config HTC_EGPIO
 	bool "HTC EGPIO support"
 	depends on GPIOLIB && ARM
@@ -650,7 +667,7 @@ config EZX_PCAP
 	  needed for MMC, TouchScreen, Sound, USB, etc..
 
 config MFD_VIPERBOARD
-        tristate "Nano River Technologies Viperboard"
+	tristate "Nano River Technologies Viperboard"
 	select MFD_CORE
 	depends on USB
 	default n
@@ -898,11 +915,11 @@ config MFD_SMSC
        select MFD_CORE
        select REGMAP_I2C
        help
-        If you say yes here you get support for the
-        ece1099 chips from SMSC.
+	If you say yes here you get support for the
+	ece1099 chips from SMSC.
 
-        To compile this driver as a module, choose M here: the
-        module will be called smsc.
+	To compile this driver as a module, choose M here: the
+	module will be called smsc.
 
 config ABX500_CORE
 	bool "ST-Ericsson ABX500 Mixed Signal Circuit register functions"
@@ -956,8 +973,8 @@ config AB8500_DEBUG
        depends on AB8500_GPADC && DEBUG_FS
        default y if DEBUG_FS
        help
-         Select this option if you want debug information using the debug
-         filesystem, debugfs.
+	 Select this option if you want debug information using the debug
+	 filesystem, debugfs.
 
 config AB8500_GPADC
 	bool "ST-Ericsson AB8500 GPADC driver"
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 5eaa6465d..236b831 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -203,3 +203,4 @@ intel-soc-pmic-objs		:= intel_soc_pmic_core.o intel_soc_pmic_crc.o
 intel-soc-pmic-$(CONFIG_INTEL_PMC_IPC)	+= intel_soc_pmic_bxtwc.o
 obj-$(CONFIG_INTEL_SOC_PMIC)	+= intel-soc-pmic.o
 obj-$(CONFIG_MFD_MT6397)	+= mt6397-core.o
+obj-$(CONFIG_MFD_MXS_LRADC)	+= mxs-lradc.o
diff --git a/drivers/mfd/mxs-lradc.c b/drivers/mfd/mxs-lradc.c
new file mode 100644
index 0000000..e1c8f9e
--- /dev/null
+++ b/drivers/mfd/mxs-lradc.c
@@ -0,0 +1,213 @@
+/*
+ * Freescale MXS LRADC driver
+ *
+ * Copyright (c) 2012 DENX Software Engineering, GmbH.
+ * Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/mxs-lradc.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+static struct mfd_cell lradc_adc_dev = {
+	.name = DRIVER_NAME_ADC,
+};
+
+static struct mfd_cell lradc_ts_dev = {
+	.name = DRIVER_NAME_TS,
+};
+
+static const char * const mx23_lradc_irq_names[] = {
+	"mxs-lradc-touchscreen",
+	"mxs-lradc-channel0",
+	"mxs-lradc-channel1",
+	"mxs-lradc-channel2",
+	"mxs-lradc-channel3",
+	"mxs-lradc-channel4",
+	"mxs-lradc-channel5",
+	"mxs-lradc-channel6",
+	"mxs-lradc-channel7",
+};
+
+static const char * const mx28_lradc_irq_names[] = {
+	"mxs-lradc-touchscreen",
+	"mxs-lradc-thresh0",
+	"mxs-lradc-thresh1",
+	"mxs-lradc-channel0",
+	"mxs-lradc-channel1",
+	"mxs-lradc-channel2",
+	"mxs-lradc-channel3",
+	"mxs-lradc-channel4",
+	"mxs-lradc-channel5",
+	"mxs-lradc-channel6",
+	"mxs-lradc-channel7",
+	"mxs-lradc-button0",
+	"mxs-lradc-button1",
+};
+
+struct mxs_lradc_of_config {
+	const int		irq_count;
+	const char * const	*irq_name;
+};
+
+static const struct mxs_lradc_of_config mxs_lradc_of_config[] = {
+	[IMX23_LRADC] = {
+		.irq_count	= ARRAY_SIZE(mx23_lradc_irq_names),
+		.irq_name	= mx23_lradc_irq_names,
+	},
+	[IMX28_LRADC] = {
+		.irq_count	= ARRAY_SIZE(mx28_lradc_irq_names),
+		.irq_name	= mx28_lradc_irq_names,
+	},
+};
+
+static const struct of_device_id mxs_lradc_dt_ids[] = {
+	{ .compatible = "fsl,imx23-lradc", .data = (void *)IMX23_LRADC, },
+	{ .compatible = "fsl,imx28-lradc", .data = (void *)IMX28_LRADC, },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, mxs_lradc_dt_ids);
+
+static int mxs_lradc_probe(struct platform_device *pdev)
+{
+	const struct of_device_id *of_id =
+		of_match_device(mxs_lradc_dt_ids, &pdev->dev);
+	const struct mxs_lradc_of_config *of_cfg =
+		&mxs_lradc_of_config[(enum mxs_lradc_id)of_id->data];
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->of_node;
+	struct mxs_lradc *lradc;
+	struct resource *iores;
+	int ret = 0, touch_ret, i;
+	u32 ts_wires = 0;
+
+	lradc = devm_kzalloc(&pdev->dev, sizeof(*lradc), GFP_KERNEL);
+	if (!lradc)
+		return -ENOMEM;
+	lradc->soc = (enum mxs_lradc_id)of_id->data;
+
+	/* Grab the memory area */
+	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	lradc->base = devm_ioremap_resource(dev, iores);
+	if (IS_ERR(lradc->base))
+		return PTR_ERR(lradc->base);
+
+	lradc->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(lradc->clk)) {
+		dev_err(dev, "Failed to get the delay unit clock\n");
+		return PTR_ERR(lradc->clk);
+	}
+	ret = clk_prepare_enable(lradc->clk);
+	if (ret != 0) {
+		dev_err(dev, "Failed to enable the delay unit clock\n");
+		return ret;
+	}
+
+	touch_ret = of_property_read_u32(node, "fsl,lradc-touchscreen-wires",
+					 &ts_wires);
+
+	if (touch_ret == 0)
+		lradc->buffer_vchans = BUFFER_VCHANS_LIMITED;
+	else
+		lradc->buffer_vchans = BUFFER_VCHANS_ALL;
+
+	lradc->irq_count = of_cfg->irq_count;
+	lradc->irq_name = of_cfg->irq_name;
+	for (i = 0; i < lradc->irq_count; i++) {
+		lradc->irq[i] = platform_get_irq(pdev, i);
+		if (lradc->irq[i] < 0) {
+			ret = lradc->irq[i];
+			goto err_clk;
+		}
+	}
+
+	platform_set_drvdata(pdev, lradc);
+
+	ret = stmp_reset_block(lradc->base);
+
+	if (ret)
+		return ret;
+
+	lradc_adc_dev.platform_data = lradc;
+	lradc_adc_dev.pdata_size = sizeof(*lradc);
+
+	ret = mfd_add_devices(&pdev->dev, -1, &lradc_adc_dev, 1, NULL, 0, NULL);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to add the ADC subdevice\n");
+		return ret;
+	}
+
+	lradc_ts_dev.platform_data = lradc;
+	lradc_ts_dev.pdata_size = sizeof(*lradc);
+
+	switch (ts_wires) {
+	case 4:
+		lradc->use_touchscreen = MXS_LRADC_TOUCHSCREEN_4WIRE;
+		break;
+	case 5:
+		if (lradc->soc == IMX28_LRADC) {
+			lradc->use_touchscreen = MXS_LRADC_TOUCHSCREEN_5WIRE;
+			break;
+		}
+		/* fall through an error message for i.MX23 */
+	default:
+		dev_err(&pdev->dev,
+			"Unsupported number of touchscreen wires (%d)\n",
+			ts_wires);
+		return -EINVAL;
+	}
+
+	ret = mfd_add_devices(&pdev->dev, -1, &lradc_ts_dev, 1, NULL, 0, NULL);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"Failed to add the touchscreen subdevice\n");
+		goto err_remove_adc;
+	}
+
+	return 0;
+
+err_remove_adc:
+	mfd_remove_devices(&pdev->dev);
+err_clk:
+	clk_disable_unprepare(lradc->clk);
+	return ret;
+}
+
+static int mxs_lradc_remove(struct platform_device *pdev)
+{
+	struct mxs_lradc *lradc = platform_get_drvdata(pdev);
+
+	mfd_remove_devices(&pdev->dev);
+	clk_disable_unprepare(lradc->clk);
+	return 0;
+}
+
+static struct platform_driver mxs_lradc_driver = {
+	.driver = {
+		.name = "mxs-lradc",
+		.of_match_table = mxs_lradc_dt_ids,
+	},
+	.probe = mxs_lradc_probe,
+	.remove = mxs_lradc_remove,
+};
+
+module_platform_driver(mxs_lradc_driver);
+
+MODULE_DESCRIPTION("Freescale i.MX23/i.MX28 LRADC driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:mxs-lradc");
diff --git a/include/linux/mfd/mxs-lradc.h b/include/linux/mfd/mxs-lradc.h
new file mode 100644
index 0000000..c062969
--- /dev/null
+++ b/include/linux/mfd/mxs-lradc.h
@@ -0,0 +1,210 @@
+/*
+ * Freescale MXS LRADC driver
+ *
+ * Copyright (c) 2012 DENX Software Engineering, GmbH.
+ * Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __MXS_LRADC_H
+#define __MXS_LRADC_H
+
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/completion.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/stmp_device.h>
+#include <linux/sysfs.h>
+
+#define DRIVER_NAME_ADC "mxs-lradc-adc"
+#define DRIVER_NAME_TS "mxs-lradc-ts"
+
+#define LRADC_MAX_DELAY_CHANS	4
+#define LRADC_MAX_MAPPED_CHANS	8
+#define LRADC_MAX_TOTAL_CHANS	16
+
+#define LRADC_DELAY_TIMER_HZ	2000
+
+#define LRADC_CTRL0				0x00
+# define LRADC_CTRL0_MX28_TOUCH_DETECT_ENABLE	BIT(23)
+# define LRADC_CTRL0_MX28_TOUCH_SCREEN_TYPE	BIT(22)
+# define LRADC_CTRL0_MX28_YNNSW /* YM */	BIT(21)
+# define LRADC_CTRL0_MX28_YPNSW /* YP */	BIT(20)
+# define LRADC_CTRL0_MX28_YPPSW /* YP */	BIT(19)
+# define LRADC_CTRL0_MX28_XNNSW /* XM */	BIT(18)
+# define LRADC_CTRL0_MX28_XNPSW /* XM */	BIT(17)
+# define LRADC_CTRL0_MX28_XPPSW /* XP */	BIT(16)
+
+# define LRADC_CTRL0_MX23_TOUCH_DETECT_ENABLE	BIT(20)
+# define LRADC_CTRL0_MX23_YM			BIT(19)
+# define LRADC_CTRL0_MX23_XM			BIT(18)
+# define LRADC_CTRL0_MX23_YP			BIT(17)
+# define LRADC_CTRL0_MX23_XP			BIT(16)
+
+# define LRADC_CTRL0_MX28_PLATE_MASK \
+		(LRADC_CTRL0_MX28_TOUCH_DETECT_ENABLE | \
+		LRADC_CTRL0_MX28_YNNSW | LRADC_CTRL0_MX28_YPNSW | \
+		LRADC_CTRL0_MX28_YPPSW | LRADC_CTRL0_MX28_XNNSW | \
+		LRADC_CTRL0_MX28_XNPSW | LRADC_CTRL0_MX28_XPPSW)
+
+# define LRADC_CTRL0_MX23_PLATE_MASK \
+		(LRADC_CTRL0_MX23_TOUCH_DETECT_ENABLE | \
+		LRADC_CTRL0_MX23_YM | LRADC_CTRL0_MX23_XM | \
+		LRADC_CTRL0_MX23_YP | LRADC_CTRL0_MX23_XP)
+
+#define LRADC_CTRL1				0x10
+#define LRADC_CTRL1_TOUCH_DETECT_IRQ_EN		BIT(24)
+#define LRADC_CTRL1_LRADC_IRQ_EN(n)		(1 << ((n) + 16))
+#define LRADC_CTRL1_MX28_LRADC_IRQ_EN_MASK	(0x1fff << 16)
+#define LRADC_CTRL1_MX23_LRADC_IRQ_EN_MASK	(0x01ff << 16)
+#define LRADC_CTRL1_LRADC_IRQ_EN_OFFSET		16
+#define LRADC_CTRL1_TOUCH_DETECT_IRQ		BIT(8)
+#define LRADC_CTRL1_LRADC_IRQ(n)		(1 << (n))
+#define LRADC_CTRL1_MX28_LRADC_IRQ_MASK		0x1fff
+#define LRADC_CTRL1_MX23_LRADC_IRQ_MASK		0x01ff
+#define LRADC_CTRL1_LRADC_IRQ_OFFSET		0
+
+#define LRADC_CTRL2				0x20
+#define LRADC_CTRL2_DIVIDE_BY_TWO_OFFSET	24
+#define LRADC_CTRL2_TEMPSENSE_PWD		BIT(15)
+
+#define LRADC_STATUS				0x40
+#define LRADC_STATUS_TOUCH_DETECT_RAW		BIT(0)
+
+#define LRADC_CH(n)				(0x50 + (0x10 * (n)))
+#define LRADC_CH_ACCUMULATE			BIT(29)
+#define LRADC_CH_NUM_SAMPLES_MASK		(0x1f << 24)
+#define LRADC_CH_NUM_SAMPLES_OFFSET		24
+#define LRADC_CH_NUM_SAMPLES(x) \
+				((x) << LRADC_CH_NUM_SAMPLES_OFFSET)
+#define LRADC_CH_VALUE_MASK			0x3ffff
+#define LRADC_CH_VALUE_OFFSET			0
+
+#define LRADC_DELAY(n)				(0xd0 + (0x10 * (n)))
+#define LRADC_DELAY_TRIGGER_LRADCS_MASK		(0xffUL << 24)
+#define LRADC_DELAY_TRIGGER_LRADCS_OFFSET	24
+#define LRADC_DELAY_TRIGGER(x) \
+				(((x) << LRADC_DELAY_TRIGGER_LRADCS_OFFSET) & \
+				LRADC_DELAY_TRIGGER_LRADCS_MASK)
+#define LRADC_DELAY_KICK			BIT(20)
+#define LRADC_DELAY_TRIGGER_DELAYS_MASK		(0xf << 16)
+#define LRADC_DELAY_TRIGGER_DELAYS_OFFSET	16
+#define LRADC_DELAY_TRIGGER_DELAYS(x) \
+				(((x) << LRADC_DELAY_TRIGGER_DELAYS_OFFSET) & \
+				LRADC_DELAY_TRIGGER_DELAYS_MASK)
+#define LRADC_DELAY_LOOP_COUNT_MASK		(0x1f << 11)
+#define LRADC_DELAY_LOOP_COUNT_OFFSET		11
+#define LRADC_DELAY_LOOP(x) \
+				(((x) << LRADC_DELAY_LOOP_COUNT_OFFSET) & \
+				LRADC_DELAY_LOOP_COUNT_MASK)
+#define LRADC_DELAY_DELAY_MASK			0x7ff
+#define LRADC_DELAY_DELAY_OFFSET		0
+#define LRADC_DELAY_DELAY(x) \
+				(((x) << LRADC_DELAY_DELAY_OFFSET) & \
+				LRADC_DELAY_DELAY_MASK)
+
+#define LRADC_CTRL4				0x140
+#define LRADC_CTRL4_LRADCSELECT_MASK(n)		(0xf << ((n) * 4))
+#define LRADC_CTRL4_LRADCSELECT_OFFSET(n)	((n) * 4)
+#define LRADC_CTRL4_LRADCSELECT(n, x) \
+				(((x) << LRADC_CTRL4_LRADCSELECT_OFFSET(n)) & \
+				LRADC_CTRL4_LRADCSELECT_MASK(n))
+
+#define LRADC_RESOLUTION			12
+#define LRADC_SINGLE_SAMPLE_MASK		((1 << LRADC_RESOLUTION) - 1)
+
+enum mxs_lradc_id {
+	IMX23_LRADC,
+	IMX28_LRADC,
+};
+
+enum mxs_lradc_ts_wires {
+	MXS_LRADC_TOUCHSCREEN_NONE = 0,
+	MXS_LRADC_TOUCHSCREEN_4WIRE,
+	MXS_LRADC_TOUCHSCREEN_5WIRE,
+};
+
+struct mxs_lradc {
+	enum mxs_lradc_id	soc;
+
+	void __iomem		*base;
+	struct clk		*clk;
+
+	int			irq[13];
+	const char * const	*irq_name;
+	int			irq_count;
+
+#define BUFFER_VCHANS_LIMITED		0x3f
+#define BUFFER_VCHANS_ALL		0xff
+	u8			buffer_vchans;
+
+	/*
+	 * Certain LRADC channels are shared between touchscreen
+	 * and/or touch-buttons and generic LRADC block. Therefore when using
+	 * either of these, these channels are not available for the regular
+	 * sampling. The shared channels are as follows:
+	 *
+	 * CH0 -- Touch button #0
+	 * CH1 -- Touch button #1
+	 * CH2 -- Touch screen XPUL
+	 * CH3 -- Touch screen YPLL
+	 * CH4 -- Touch screen XNUL
+	 * CH5 -- Touch screen YNLR
+	 * CH6 -- Touch screen WIPER (5-wire only)
+	 *
+	 * The bit fields below represents which parts of the LRADC block are
+	 * switched into special mode of operation. These channels can not
+	 * be sampled as regular LRADC channels. The driver will refuse any
+	 * attempt to sample these channels.
+	 */
+#define CHAN_MASK_TOUCHBUTTON		(BIT(1) | BIT(0))
+#define CHAN_MASK_TOUCHSCREEN_4WIRE	(0xf << 2)
+#define CHAN_MASK_TOUCHSCREEN_5WIRE	(0x1f << 2)
+	enum mxs_lradc_ts_wires	use_touchscreen;
+	bool			use_touchbutton;
+};
+
+static inline void mxs_lradc_reg_set(struct mxs_lradc *lradc, u32 val, u32 reg)
+{
+	writel(val, lradc->base + reg + STMP_OFFSET_REG_SET);
+}
+
+static inline void mxs_lradc_reg_clear(struct mxs_lradc *lradc, u32 val,
+				       u32 reg)
+{
+	writel(val, lradc->base + reg + STMP_OFFSET_REG_CLR);
+}
+
+static inline void mxs_lradc_reg_wrt(struct mxs_lradc *lradc, u32 val, u32 reg)
+{
+	writel(val, lradc->base + reg);
+}
+
+static inline u32 mxs_lradc_irq_mask(struct mxs_lradc *lradc)
+{
+	if (lradc->soc == IMX23_LRADC)
+		return LRADC_CTRL1_MX23_LRADC_IRQ_MASK;
+	return LRADC_CTRL1_MX28_LRADC_IRQ_MASK;
+}
+
+#endif /* __MXS_LRADC_H */
-- 
1.9.1
