From: <Frank.Li@freescale.com>
Subject: [PATCH v2 1/3] input: keyboad: imx: add snvs power key driver
Date: Wed, 13 May 2015 22:47:40 +0800
Message-ID: <1431528462-21591-1-git-send-email-Frank.Li@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bl2on0129.outbound.protection.outlook.com ([65.55.169.129]:25456
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965055AbbEMP4X (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 13 May 2015 11:56:23 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: lznuaa@gmail.com, shawn.guo@linaro.org, dmitry.torokhov@gmail.com
Cc: linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, Robin Gong <b38343@freescale.com>, Frank Li <Frank.Li@freescale.com>

From: Robin Gong <b38343@freescale.com>

add snvs power key driver.
It work in imx chips after i.mx6sx

Signed-off-by: Robin Gong <b38343@freescale.com>
Signed-off-by: Frank Li <Frank.Li@freescale.com>
---
Change from V1 to V2
 - Remove SOC_IMX6SX depend
 - Add "TO compile the deiver as module.. "
 - Change license  2015
 - BIT(x)
 - use pdev->dev.of_node
 - iounmap at remove
 - use linux,keycode
 - use linux,wakeup
 - Remove irq >=0 check at devm_regust_irq
 - Remove IRQF_NO_SUSPEND
 - Register irq after allocate device to avoid race condition
 - add devm_add_action to remove del_timer_sync

 drivers/input/keyboard/Kconfig       |   9 ++
 drivers/input/keyboard/Makefile      |   1 +
 drivers/input/keyboard/snvs_pwrkey.c | 239 +++++++++++++++++++++++++++++++++++
 3 files changed, 249 insertions(+)
 create mode 100644 drivers/input/keyboard/snvs_pwrkey.c

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 106fbac..6c1c7de 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -400,6 +400,15 @@ config KEYBOARD_MPR121
 	  To compile this driver as a module, choose M here: the
 	  module will be called mpr121_touchkey.
 
+config KEYBOARD_SNVS_PWRKEY
+	tristate "IMX SNVS Power Key Driver"
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
index 0000000..e4c2de3
--- /dev/null
+++ b/drivers/input/keyboard/snvs_pwrkey.c
@@ -0,0 +1,239 @@
+/*
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
+
+#define SNVS_LPSR_REG	0x4C	/* LP Status Register */
+#define SNVS_LPCR_REG	0x38	/* LP Control Register */
+#define SNVS_HPSR_REG	0x14
+#define SNVS_HPSR_BTN	BIT(6)
+#define SNVS_LPSR_SPO	BIT(18)
+#define SNVS_LPCR_DEP_EN BIT(5)
+
+struct pwrkey_drv_data {
+	void __iomem *ioaddr;
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
+	void __iomem *ioaddr = pdata->ioaddr;
+	u32 state;
+
+	state = ((readl_relaxed(ioaddr + SNVS_HPSR_REG) & SNVS_HPSR_BTN) ?
+		1 : 0);
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
+			  jiffies + msecs_to_jiffies(60));
+	}
+}
+
+static irqreturn_t imx_snvs_pwrkey_interrupt(int irq, void *dev_id)
+{
+	struct platform_device *pdev = dev_id;
+	struct pwrkey_drv_data *pdata = platform_get_drvdata(pdev);
+	void __iomem *ioaddr = pdata->ioaddr;
+	u32 lp_status;
+
+	pm_wakeup_event(pdata->input->dev.parent, 0);
+	lp_status = readl_relaxed(ioaddr + SNVS_LPSR_REG);
+	if (lp_status & SNVS_LPSR_SPO)
+		mod_timer(&pdata->check_timer, jiffies + msecs_to_jiffies(2));
+
+	/* clear SPO status */
+	writel_relaxed(lp_status, ioaddr + SNVS_LPSR_REG);
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
+	struct device_node *np;
+	void __iomem *ioaddr;
+	u32 val;
+	int ret = 0;
+
+	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
+
+	/* Get SNVS register Page */
+	np = pdev->dev.of_node;
+	if (!np)
+		return -ENODEV;
+	pdata->ioaddr = of_iomap(np, 0);
+	if (IS_ERR(pdata->ioaddr))
+		return PTR_ERR(pdata->ioaddr);
+
+	if (of_property_read_u32(np, "linux,keycode", &pdata->keycode)) {
+		pdata->keycode = KEY_POWER;
+		dev_warn(&pdev->dev, "KEY_POWER without setting in dts\n");
+	}
+
+	pdata->wakeup = !!of_get_property(np, "linux,wakeup", NULL);
+
+	pdata->irq = platform_get_irq(pdev, 0);
+	if (pdata->irq < 0) {
+		dev_err(&pdev->dev, "no irq defined in platform data\n");
+		return -EINVAL;
+	}
+
+	ioaddr = pdata->ioaddr;
+	val = readl_relaxed(ioaddr + SNVS_LPCR_REG);
+	val |= SNVS_LPCR_DEP_EN,
+	writel_relaxed(val, ioaddr + SNVS_LPCR_REG);
+	/* clear the unexpected interrupt before driver ready */
+	val = readl_relaxed(ioaddr + SNVS_LPSR_REG);
+	if (val & SNVS_LPSR_SPO)
+		writel_relaxed(val | SNVS_LPSR_SPO, ioaddr + SNVS_LPSR_REG);
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
+	input->evbit[0] = BIT_MASK(EV_KEY);
+
+	input_set_capability(input, EV_KEY, pdata->keycode);
+
+	/* input customer action to cancel release timer */
+	ret = devm_add_action(&pdev->dev, imx_snvs_pwrkey_act, pdata);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register remove action\n");
+		return ret;
+	}
+
+	ret = devm_request_irq(&pdev->dev, pdata->irq,
+			       imx_snvs_pwrkey_interrupt,
+			       0, pdev->name, pdev);
+
+	if (ret) {
+		dev_err(&pdev->dev, "interrupt not available.\n");
+		return ret;
+	}
+
+	ret = input_register_device(input);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to register input device\n");
+		input_free_device(input);
+		return ret;
+	}
+
+	pdata->input = input;
+	platform_set_drvdata(pdev, pdata);
+
+	device_init_wakeup(&pdev->dev, pdata->wakeup);
+
+	dev_info(&pdev->dev, "i.MX snvs powerkey probed\n");
+
+	return 0;
+}
+
+static int imx_snvs_pwrkey_remove(struct platform_device *pdev)
+{
+	struct pwrkey_drv_data *pdata = platform_get_drvdata(pdev);
+
+	input_unregister_device(pdata->input);
+	iounmap(pdata->ioaddr);
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
+	{ .compatible = "fsl,imx6sx-snvs-pwrkey" },
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
+		.owner	= THIS_MODULE,
+		.pm     = &imx_snvs_pwrkey_pm_ops,
+		.of_match_table = imx_snvs_pwrkey_ids,
+	},
+	.probe = imx_snvs_pwrkey_probe,
+	.remove = imx_snvs_pwrkey_remove,
+};
+module_platform_driver(imx_snvs_pwrkey_driver);
+
+MODULE_AUTHOR("Freescale Semiconductor");
+MODULE_DESCRIPTION("i.MX snvs power key Driver");
+MODULE_LICENSE("GPL");
-- 
1.9.1

