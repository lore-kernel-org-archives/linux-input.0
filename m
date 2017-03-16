From: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Subject: [PATCH v15 1/5] mfd: mxs-lradc: Add support for mxs-lradc MFD
Date: Thu, 16 Mar 2017 13:27:09 +0100
Message-ID: <a087d44c8b61d87a7eaf987c0ec0266d398ea987.1489666428.git.ksenija.stanojevic@gmail.com>
References: <cover.1489666428.git.ksenija.stanojevic@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1489666428.git.ksenija.stanojevic@gmail.com>
In-Reply-To: <cover.1489666428.git.ksenija.stanojevic@gmail.com>
References: <cover.1489666428.git.ksenija.stanojevic@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: lee.jones@linaro.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, marex@denx.de, linux-iio@vger.kernel.org, harald@ccbib.org, stefan.wahren@i2se.com, fabio.estevam@freescale.com, Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
List-Id: linux-input@vger.kernel.org

Add core files for low resolution analog-to-digital converter (mxs-lradc)
MFD driver.

Signed-off-by: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Reviewed-by: Marek Vasut <marex@denx.de>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
Changes in v15:
 - if hardware doesn't contain touchscreen don't load touchscreen driver.

Changes in v14:
 - none

Changes in v13:
 - none

Changes in v12:
 - use BIT macro

Changes in v11:
 - create static struct mfd_cells
 - don't set platform data in mfd cells, set driver data instead
 - remove mxs_lradc_reg_* functions, use writel function instead

Changes in v10:
 - fetch base address from DT
 - add a NULL check for of_match_device

Changes in v9:
 - improve commit message.

Changes in v8:
 - rebase onto 4.9-rc1

Changes in v7:
 - define macros ADC_CELL and TSC_CELL
 - remove one cell and dynamically set them in the switch()
 - fail in the touchscreen driver instead of mfd driver if
   hardware doesn't contain a touchscreen

Changes in v6:
 - update copyright
 - add kernel-doc header for struct mxs-lradc
 - add error message
 - change EINVAL to ENODEV
 - use PLATFORM_DEVID_NONE instead -1
 - cosmetic fixes

Changes in v5:
 - use DEFINE_RES_MEM
 - don't pass ioreammaped adress to platform cells
 - move comment outside of struct mxs_lradc
 - change type of argument in mxs_lradc_reg_set, mxs_lradc_reg_clear,
   mxs_lradc_reg_wrt (struct mxs_lradc * -> void __iomem *)

Changes in v4:
 - update copyright
 - use DEFINE_RES_IRQ_NAMED
 - remove mxs_lradc_add_device function
 - use struct mfd_cell in static form
 - improve spacing
 - remove unnecessary comment
 - remove platform_get_irq
 - remove touch_ret and use ret instead
 - rename use_touchscreen to touchscreen_wire
 - use goto statements
 - remove irq[13], irq_count and irq_name from struct mxs_lradc
 - remove all defines from inside the struct definition

Changes in v3:
 - add note to commit message
 - move switch statement into if(touch_ret == 0) branch
 - add MODULE_AUTHOR

Changes in v2:
 - do not change spacing in Kconfig
 - make struct mfd_cell part of struct mxs_lradc
 - use switch instead of if in mxs_lradc_irq_mask
 - use only necessary header files in mxs_lradc.h
 - use devm_mfd_add_device
 - use separate function to register mfd device
 - change licence to GPL
 - add copyright

 drivers/mfd/Kconfig           |  17 +++
 drivers/mfd/Makefile          |   1 +
 drivers/mfd/mxs-lradc.c       | 267 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/mxs-lradc.h | 187 +++++++++++++++++++++++++++++
 4 files changed, 472 insertions(+)
 create mode 100644 drivers/mfd/mxs-lradc.c
 create mode 100644 include/linux/mfd/mxs-lradc.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 55ecdfb..8bbc91b 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -344,6 +344,23 @@ config MFD_MC13XXX_I2C
 	help
 	  Select this if your MC13xxx is connected via an I2C bus.
 
+config MFD_MXS_LRADC
+	tristate "Freescale i.MX23/i.MX28 LRADC"
+	depends on ARCH_MXS || COMPILE_TEST
+	select MFD_CORE
+	select STMP_DEVICE
+	help
+	  Say yes here to build support for the Low Resolution
+	  Analog-to-Digital Converter (LRADC) found on the i.MX23 and i.MX28
+	  processors. This driver provides common support for accessing the
+	  device, additional drivers must be enabled in order to use the
+	  functionality of the device:
+		mxs-lradc-adc for ADC readings
+		mxs-lradc-ts  for touchscreen support
+
+	  This driver can also be built as a module. If so, the module will be
+	  called mxs-lradc.
+
 config MFD_MX25_TSADC
 	tristate "Freescale i.MX25 integrated Touchscreen and ADC unit"
 	select REGMAP_MMIO
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 31ce076..790698a 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -215,3 +215,4 @@ obj-$(CONFIG_MFD_ALTERA_A10SR)	+= altera-a10sr.o
 obj-$(CONFIG_MFD_SUN4I_GPADC)	+= sun4i-gpadc.o
 
 obj-$(CONFIG_MFD_STM32_TIMERS) 	+= stm32-timers.o
+obj-$(CONFIG_MFD_MXS_LRADC)     += mxs-lradc.o
diff --git a/drivers/mfd/mxs-lradc.c b/drivers/mfd/mxs-lradc.c
new file mode 100644
index 0000000..630bd19
--- /dev/null
+++ b/drivers/mfd/mxs-lradc.c
@@ -0,0 +1,267 @@
+/*
+ * Freescale MXS Low Resolution Analog-to-Digital Converter driver
+ *
+ * Copyright (c) 2012 DENX Software Engineering, GmbH.
+ * Copyright (c) 2017 Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
+ *
+ * Authors:
+ *  Marek Vasut <marex@denx.de>
+ *  Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
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
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#define ADC_CELL		0
+#define TSC_CELL		1
+#define RES_MEM			0
+
+enum mx23_lradc_irqs {
+	MX23_LRADC_TS_IRQ = 0,
+	MX23_LRADC_CH0_IRQ,
+	MX23_LRADC_CH1_IRQ,
+	MX23_LRADC_CH2_IRQ,
+	MX23_LRADC_CH3_IRQ,
+	MX23_LRADC_CH4_IRQ,
+	MX23_LRADC_CH5_IRQ,
+	MX23_LRADC_CH6_IRQ,
+	MX23_LRADC_CH7_IRQ,
+};
+
+enum mx28_lradc_irqs {
+	MX28_LRADC_TS_IRQ = 0,
+	MX28_LRADC_TRESH0_IRQ,
+	MX28_LRADC_TRESH1_IRQ,
+	MX28_LRADC_CH0_IRQ,
+	MX28_LRADC_CH1_IRQ,
+	MX28_LRADC_CH2_IRQ,
+	MX28_LRADC_CH3_IRQ,
+	MX28_LRADC_CH4_IRQ,
+	MX28_LRADC_CH5_IRQ,
+	MX28_LRADC_CH6_IRQ,
+	MX28_LRADC_CH7_IRQ,
+	MX28_LRADC_BUTTON0_IRQ,
+	MX28_LRADC_BUTTON1_IRQ,
+};
+
+static struct resource mx23_adc_resources[] = {
+	DEFINE_RES_MEM(0x0, 0x0),
+	DEFINE_RES_IRQ_NAMED(MX23_LRADC_CH0_IRQ, "mxs-lradc-channel0"),
+	DEFINE_RES_IRQ_NAMED(MX23_LRADC_CH1_IRQ, "mxs-lradc-channel1"),
+	DEFINE_RES_IRQ_NAMED(MX23_LRADC_CH2_IRQ, "mxs-lradc-channel2"),
+	DEFINE_RES_IRQ_NAMED(MX23_LRADC_CH3_IRQ, "mxs-lradc-channel3"),
+	DEFINE_RES_IRQ_NAMED(MX23_LRADC_CH4_IRQ, "mxs-lradc-channel4"),
+	DEFINE_RES_IRQ_NAMED(MX23_LRADC_CH5_IRQ, "mxs-lradc-channel5"),
+};
+
+static struct resource mx23_touchscreen_resources[] = {
+	DEFINE_RES_MEM(0x0, 0x0),
+	DEFINE_RES_IRQ_NAMED(MX23_LRADC_TS_IRQ, "mxs-lradc-touchscreen"),
+	DEFINE_RES_IRQ_NAMED(MX23_LRADC_CH6_IRQ, "mxs-lradc-channel6"),
+	DEFINE_RES_IRQ_NAMED(MX23_LRADC_CH7_IRQ, "mxs-lradc-channel7"),
+};
+
+static struct resource mx28_adc_resources[] = {
+	DEFINE_RES_MEM(0x0, 0x0),
+	DEFINE_RES_IRQ_NAMED(MX28_LRADC_TRESH0_IRQ, "mxs-lradc-thresh0"),
+	DEFINE_RES_IRQ_NAMED(MX28_LRADC_TRESH1_IRQ, "mxs-lradc-thresh1"),
+	DEFINE_RES_IRQ_NAMED(MX28_LRADC_CH0_IRQ, "mxs-lradc-channel0"),
+	DEFINE_RES_IRQ_NAMED(MX28_LRADC_CH1_IRQ, "mxs-lradc-channel1"),
+	DEFINE_RES_IRQ_NAMED(MX28_LRADC_CH2_IRQ, "mxs-lradc-channel2"),
+	DEFINE_RES_IRQ_NAMED(MX28_LRADC_CH3_IRQ, "mxs-lradc-channel3"),
+	DEFINE_RES_IRQ_NAMED(MX28_LRADC_CH4_IRQ, "mxs-lradc-channel4"),
+	DEFINE_RES_IRQ_NAMED(MX28_LRADC_CH5_IRQ, "mxs-lradc-channel5"),
+	DEFINE_RES_IRQ_NAMED(MX28_LRADC_BUTTON0_IRQ, "mxs-lradc-button0"),
+	DEFINE_RES_IRQ_NAMED(MX28_LRADC_BUTTON1_IRQ, "mxs-lradc-button1"),
+};
+
+static struct resource mx28_touchscreen_resources[] = {
+	DEFINE_RES_MEM(0x0, 0x0),
+	DEFINE_RES_IRQ_NAMED(MX28_LRADC_TS_IRQ, "mxs-lradc-touchscreen"),
+	DEFINE_RES_IRQ_NAMED(MX28_LRADC_CH6_IRQ, "mxs-lradc-channel6"),
+	DEFINE_RES_IRQ_NAMED(MX28_LRADC_CH7_IRQ, "mxs-lradc-channel7"),
+};
+
+static struct mfd_cell mx23_cells[] = {
+	{
+		.name = "mxs-lradc-adc",
+		.resources = mx23_adc_resources,
+		.num_resources = ARRAY_SIZE(mx23_adc_resources),
+	},
+	{
+		.name = "mxs-lradc-ts",
+		.resources = mx23_touchscreen_resources,
+		.num_resources = ARRAY_SIZE(mx23_touchscreen_resources),
+	},
+};
+
+static struct mfd_cell mx28_cells[] = {
+	{
+		.name = "mxs-lradc-adc",
+		.resources = mx28_adc_resources,
+		.num_resources = ARRAY_SIZE(mx28_adc_resources),
+	},
+	{
+		.name = "mxs-lradc-ts",
+		.resources = mx28_touchscreen_resources,
+		.num_resources = ARRAY_SIZE(mx28_touchscreen_resources),
+	}
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
+	const struct of_device_id *of_id;
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->of_node;
+	struct mxs_lradc *lradc;
+	struct mfd_cell *cells = NULL;
+	struct resource *res;
+	int ret = 0;
+	u32 ts_wires = 0;
+
+	lradc = devm_kzalloc(&pdev->dev, sizeof(*lradc), GFP_KERNEL);
+	if (!lradc)
+		return -ENOMEM;
+
+	of_id = of_match_device(mxs_lradc_dt_ids, &pdev->dev);
+	if (!of_id)
+		return -EINVAL;
+
+	lradc->soc = (enum mxs_lradc_id)of_id->data;
+
+	lradc->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(lradc->clk)) {
+		dev_err(dev, "Failed to get the delay unit clock\n");
+		return PTR_ERR(lradc->clk);
+	}
+
+	ret = clk_prepare_enable(lradc->clk);
+	if (ret) {
+		dev_err(dev, "Failed to enable the delay unit clock\n");
+		return ret;
+	}
+
+	ret = of_property_read_u32(node, "fsl,lradc-touchscreen-wires",
+					 &ts_wires);
+
+	if (!ret) {
+		lradc->buffer_vchans = BUFFER_VCHANS_LIMITED;
+
+		switch (ts_wires) {
+		case 4:
+			lradc->touchscreen_wire = MXS_LRADC_TOUCHSCREEN_4WIRE;
+			break;
+		case 5:
+			if (lradc->soc == IMX28_LRADC) {
+				lradc->touchscreen_wire =
+					MXS_LRADC_TOUCHSCREEN_5WIRE;
+				break;
+			}
+			/* fall through to an error message for i.MX23 */
+		default:
+			dev_err(&pdev->dev,
+				"Unsupported number of touchscreen wires (%d)\n"
+				, ts_wires);
+			ret = -EINVAL;
+			goto err_clk;
+		}
+	} else {
+		lradc->buffer_vchans = BUFFER_VCHANS_ALL;
+	}
+
+	platform_set_drvdata(pdev, lradc);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENOMEM;
+
+	switch (lradc->soc) {
+	case IMX23_LRADC:
+		mx23_adc_resources[RES_MEM] = *res;
+		mx23_touchscreen_resources[RES_MEM] = *res;
+		cells = mx23_cells;
+		break;
+	case IMX28_LRADC:
+		mx28_adc_resources[RES_MEM] = *res;
+		mx28_touchscreen_resources[RES_MEM] = *res;
+		cells = mx28_cells;
+		break;
+	default:
+		dev_err(dev, "Unsupported SoC\n");
+		ret = -ENODEV;
+		goto err_clk;
+	}
+
+	ret = devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE,
+				   &cells[ADC_CELL], 1, NULL, 0, NULL);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to add the ADC subdevice\n");
+		goto err_clk;
+	}
+
+	if (!lradc->touchscreen_wire)
+		return 0;
+
+	ret = devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE,
+				   &cells[TSC_CELL], 1, NULL, 0, NULL);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"Failed to add the touchscreen subdevice\n");
+		goto err_clk;
+	}
+
+	return 0;
+
+err_clk:
+	clk_disable_unprepare(lradc->clk);
+
+	return ret;
+}
+
+static int mxs_lradc_remove(struct platform_device *pdev)
+{
+	struct mxs_lradc *lradc = platform_get_drvdata(pdev);
+
+	clk_disable_unprepare(lradc->clk);
+
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
+module_platform_driver(mxs_lradc_driver);
+
+MODULE_AUTHOR("Ksenija Stanojevic <ksenija.stanojevic@gmail.com>");
+MODULE_DESCRIPTION("Freescale i.MX23/i.MX28 LRADC driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:mxs-lradc");
diff --git a/include/linux/mfd/mxs-lradc.h b/include/linux/mfd/mxs-lradc.h
new file mode 100644
index 0000000..661a452
--- /dev/null
+++ b/include/linux/mfd/mxs-lradc.h
@@ -0,0 +1,187 @@
+/*
+ * Freescale MXS Low Resolution Analog-to-Digital Converter driver
+ *
+ * Copyright (c) 2012 DENX Software Engineering, GmbH.
+ * Copyright (c) 2016 Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
+ *
+ * Author: Marek Vasut <marex@denx.de>
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
+#ifndef __MFD_MXS_LRADC_H
+#define __MFD_MXS_LRADC_H
+
+#include <linux/bitops.h>
+#include <linux/io.h>
+#include <linux/stmp_device.h>
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
+#define LRADC_CTRL1_LRADC_IRQ(n)		BIT(n)
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
+#define BUFFER_VCHANS_LIMITED		0x3f
+#define BUFFER_VCHANS_ALL		0xff
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
+/**
+ * struct mxs_lradc
+ * @soc: soc type (IMX23 or IMX28)
+ * @clk: 2 kHz clock for delay units
+ * @buffer_vchans: channels that can be used during buffered capture
+ * @touchscreen_wire: touchscreen type (4-wire or 5-wire)
+ * @use_touchbutton: button state (on or off)
+ */
+struct mxs_lradc {
+	enum mxs_lradc_id	soc;
+	struct clk		*clk;
+	u8			buffer_vchans;
+
+	enum mxs_lradc_ts_wires	touchscreen_wire;
+	bool			use_touchbutton;
+};
+
+static inline u32 mxs_lradc_irq_mask(struct mxs_lradc *lradc)
+{
+	switch (lradc->soc) {
+	case IMX23_LRADC:
+		return LRADC_CTRL1_MX23_LRADC_IRQ_MASK;
+	case IMX28_LRADC:
+		return LRADC_CTRL1_MX28_LRADC_IRQ_MASK;
+	default:
+		return 0;
+	}
+}
+
+#endif /* __MXS_LRADC_H */
-- 
1.9.1
