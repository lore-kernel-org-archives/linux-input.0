From: <Frank.Li@freescale.com>
Subject: [PATCH v3 4/6] input: keyboard: imx: add snvs power key driver
Date: Fri, 22 May 2015 00:16:50 +0800
Message-ID: <1432225012-20598-5-git-send-email-Frank.Li@freescale.com>
References: <1432225012-20598-1-git-send-email-Frank.Li@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bl2on0108.outbound.protection.outlook.com ([65.55.169.108]:33955
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932167AbbEUQR6 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 21 May 2015 12:17:58 -0400
In-Reply-To: <1432225012-20598-1-git-send-email-Frank.Li@freescale.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: lznuaa@gmail.com, shawn.guo@linaro.org, dmitry.torokhov@gmail.com, robh+dt@kernel.org, alexandre.belloni@free-electrons.com, linux@arm.linux.org.uk
Cc: linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, rtc-linux@googlegroups.com, devicetree@vger.kernel.org, Robin Gong <b38343@freescale.com>, Frank Li <Frank.Li@freescale.com>

From: Robin Gong <b38343@freescale.com>

add snvs power key driver.
It work in imx chips after i.mx6sx

ON/OFF key used power on/off whole system.
This driver make it wakeup from suspend state when short press
ON/OFF key.

Long time press will trig SNVS power off chip without software
intervention.

Signed-off-by: Robin Gong <b38343@freescale.com>
Signed-off-by: Frank Li <Frank.Li@freescale.com>
---
 drivers/input/keyboard/Kconfig       |  11 ++
 drivers/input/keyboard/Makefile      |   1 +
 drivers/input/keyboard/snvs_pwrkey.c | 232 +++++++++++++++++++++++++++++++++++
 3 files changed, 244 insertions(+)
 create mode 100644 drivers/input/keyboard/snvs_pwrkey.c

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 106fbac..61b3fab 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -400,6 +400,17 @@ config KEYBOARD_MPR121
 	  To compile this driver as a module, choose M here: the
 	  module will be called mpr121_touchkey.
 
+config KEYBOARD_SNVS_PWRKEY
+	tristate "IMX SNVS Power Key Driver"
+	depends on SOC_IMX6SX
+	depends on OF
+	help
+	  This is the snvs powerkey driver for the Freescale i.MX application
+	  processors that are newer than i.MX6 SX.
+
+	  To compile this driver as a module, choose M here; the
+	  module will be called snvs_pwrkey.
+
 config KEYBOARD_IMX
 	tristate "IMX keypad support"
 	depends on ARCH_MXC
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index df28d55..1d416dd 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -51,6 +51,7 @@ obj-$(CONFIG_KEYBOARD_QT1070)           += qt1070.o
 obj-$(CONFIG_KEYBOARD_QT2160)		+= qt2160.o
 obj-$(CONFIG_KEYBOARD_SAMSUNG)		+= samsung-keypad.o
 obj-$(CONFIG_KEYBOARD_SH_KEYSC)		+= sh_keysc.o
+obj-$(CONFIG_KEYBOARD_SNVS_PWRKEY)	+= snvs_pwrkey.o
 obj-$(CONFIG_KEYBOARD_SPEAR)		+= spear-keyboard.o
 obj-$(CONFIG_KEYBOARD_STMPE)		+= stmpe-keypad.o
 obj-$(CONFIG_KEYBOARD_STOWAWAY)		+= stowaway.o
diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/snvs_pwrkey.c
new file mode 100644
index 0000000..98c340e
--- /dev/null
+++ b/drivers/input/keyboard/snvs_pwrkey.c
@@ -0,0 +1,232 @@
+/*
+ * Driver for the IMX SNVS ON/OFF Power Key
+ * Copyright (C) 2015 Freescale Semiconductor, Inc. All Rights Reserved.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+
+#define SNVS_LPSR_REG	0x4C	/* LP Status Register */
+#define SNVS_LPCR_REG	0x38	/* LP Control Register */
+#define SNVS_HPSR_REG	0x14
+#define SNVS_HPSR_BTN	BIT(6)
+#define SNVS_LPSR_SPO	BIT(18)
+#define SNVS_LPCR_DEP_EN BIT(5)
+
+#define DEBOUNCE_TIME 30
+#define REPEAT_INTERVAL 60
+
+struct pwrkey_drv_data {
+	struct regmap *snvs;
+	int irq;
+	int keycode;
+	int keystate;  /* 1:pressed */
+	int wakeup;
+	struct timer_list check_timer;
+	struct input_dev *input;
+};
+
+static void imx_imx_snvs_check_for_events(unsigned long data)
+{
+	struct pwrkey_drv_data *pdata = (struct pwrkey_drv_data *) data;
+	struct input_dev *input = pdata->input;
+	u32 state;
+
+	regmap_read(pdata->snvs, SNVS_HPSR_REG, &state);
+	state = state & SNVS_HPSR_BTN ? 1 : 0;
+
+	/* only report new event if status changed */
+	if (state ^ pdata->keystate) {
+		pdata->keystate = state;
+		input_event(input, EV_KEY, pdata->keycode, state);
+		input_sync(input);
+		pm_relax(pdata->input->dev.parent);
+	}
+
+	/* repeat check if pressed long */
+	if (state) {
+		mod_timer(&pdata->check_timer,
+			  jiffies + msecs_to_jiffies(REPEAT_INTERVAL));
+	}
+}
+
+static irqreturn_t imx_snvs_pwrkey_interrupt(int irq, void *dev_id)
+{
+	struct platform_device *pdev = dev_id;
+	struct pwrkey_drv_data *pdata = platform_get_drvdata(pdev);
+	u32 lp_status;
+
+	pm_wakeup_event(pdata->input->dev.parent, 0);
+
+	regmap_read(pdata->snvs, SNVS_LPSR_REG, &lp_status);
+	if (lp_status & SNVS_LPSR_SPO)
+		mod_timer(&pdata->check_timer, jiffies + msecs_to_jiffies(DEBOUNCE_TIME));
+
+	/* clear SPO status */
+	regmap_write(pdata->snvs, SNVS_LPSR_REG, SNVS_LPSR_SPO);
+
+	return IRQ_HANDLED;
+}
+
+static void imx_snvs_pwrkey_act(void *pdata)
+{
+	struct pwrkey_drv_data *pd = pdata;
+
+	del_timer_sync(&pd->check_timer);
+}
+
+static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
+{
+	struct pwrkey_drv_data *pdata = NULL;
+	struct input_dev *input = NULL;
+	struct device_node *np, *snvs_np;
+	int error;
+
+	/* Get SNVS register Page */
+	np = pdev->dev.of_node;
+	if (!np)
+		return -ENODEV;
+
+	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
+
+	snvs_np = of_get_parent(pdev->dev.of_node);
+	if (!snvs_np)
+		return -ENODEV;
+
+	pdata->snvs = syscon_node_to_regmap(snvs_np);
+	of_node_put(snvs_np);
+
+	if (!pdata->snvs) {
+		pr_err("Can't get snvs syscon\n");
+		return -ENODEV;
+	}
+
+	if (of_property_read_u32(np, "linux,keycode", &pdata->keycode)) {
+		pdata->keycode = KEY_POWER;
+		dev_warn(&pdev->dev, "KEY_POWER without setting in dts\n");
+	}
+
+	pdata->wakeup = of_property_read_bool(np, "wakeup");
+
+	pdata->irq = platform_get_irq(pdev, 0);
+	if (pdata->irq < 0) {
+		dev_err(&pdev->dev, "no irq defined in platform data\n");
+		return -EINVAL;
+	}
+
+	regmap_update_bits(pdata->snvs, SNVS_LPCR_REG, SNVS_LPCR_DEP_EN, SNVS_LPCR_DEP_EN);
+
+	/* clear the unexpected interrupt before driver ready */
+	regmap_write(pdata->snvs, SNVS_LPSR_REG, SNVS_LPSR_SPO);
+
+	setup_timer(&pdata->check_timer,
+		    imx_imx_snvs_check_for_events, (unsigned long) pdata);
+
+	input = devm_input_allocate_device(&pdev->dev);
+	if (!input) {
+		dev_err(&pdev->dev, "failed to allocate the input device\n");
+		return -ENOMEM;
+	}
+
+	input->name = pdev->name;
+	input->phys = "snvs-pwrkey/input0";
+	input->id.bustype = BUS_HOST;
+
+	input_set_capability(input, EV_KEY, pdata->keycode);
+
+	/* input customer action to cancel release timer */
+	error = devm_add_action(&pdev->dev, imx_snvs_pwrkey_act, pdata);
+	if (error) {
+		dev_err(&pdev->dev, "failed to register remove action\n");
+		return error;
+	}
+
+	error = devm_request_irq(&pdev->dev, pdata->irq,
+			       imx_snvs_pwrkey_interrupt,
+			       0, pdev->name, pdev);
+
+	if (error) {
+		dev_err(&pdev->dev, "interrupt not available.\n");
+		return error;
+	}
+
+	error = input_register_device(input);
+	if (error < 0) {
+		dev_err(&pdev->dev, "failed to register input device\n");
+		input_free_device(input);
+		return error;
+	}
+
+	pdata->input = input;
+	platform_set_drvdata(pdev, pdata);
+
+	device_init_wakeup(&pdev->dev, pdata->wakeup);
+
+	return 0;
+}
+
+static int imx_snvs_pwrkey_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct pwrkey_drv_data *pdata = platform_get_drvdata(pdev);
+
+	if (device_may_wakeup(&pdev->dev))
+		enable_irq_wake(pdata->irq);
+
+	return 0;
+}
+
+static int imx_snvs_pwrkey_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct pwrkey_drv_data *pdata = platform_get_drvdata(pdev);
+
+	if (device_may_wakeup(&pdev->dev))
+		disable_irq_wake(pdata->irq);
+
+	return 0;
+}
+
+static const struct of_device_id imx_snvs_pwrkey_ids[] = {
+	{ .compatible = "fsl,sec-v4.0-pwrkey" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, imx_snvs_pwrkey_ids);
+
+static SIMPLE_DEV_PM_OPS(imx_snvs_pwrkey_pm_ops, imx_snvs_pwrkey_suspend,
+				imx_snvs_pwrkey_resume);
+
+static struct platform_driver imx_snvs_pwrkey_driver = {
+	.driver = {
+		.name = "snvs_pwrkey",
+		.pm     = &imx_snvs_pwrkey_pm_ops,
+		.of_match_table = imx_snvs_pwrkey_ids,
+	},
+	.probe = imx_snvs_pwrkey_probe,
+};
+module_platform_driver(imx_snvs_pwrkey_driver);
+
+MODULE_AUTHOR("Freescale Semiconductor");
+MODULE_DESCRIPTION("i.MX snvs power key Driver");
+MODULE_LICENSE("GPL");
-- 
1.9.1

