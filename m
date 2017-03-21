From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCHv3 2/2] input: cpcap-pwrbutton: new driver
Date: Tue, 21 Mar 2017 23:50:42 +0100
Message-ID: <20170321225042.28057-2-sre@kernel.org>
References: <20170321225042.28057-1-sre@kernel.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933153AbdCUWvW (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 21 Mar 2017 18:51:22 -0400
In-Reply-To: <20170321225042.28057-1-sre@kernel.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Motorola CPCAP is a PMIC found in multiple smartphones.
This driver adds support for the power/on button and has
been tested in Droid 4.

Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Tested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
Changes since PATCHv2:
 - Collect Acked-by/Tested-by

As merge strategy I suggest, that Lee takes the first patch
and provides a immutable branch with for the input subsystem,
which can pull in the immutable branch + the second patch.
Alternatively both can go through mfd of course and Dmitry
gave his Ack for that strategy in PATCHv2.
---
 .../devicetree/bindings/input/cpcap-pwrbutton.txt  |  20 ++++
 drivers/input/misc/Kconfig                         |  10 ++
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/cpcap-pwrbutton.c               | 117 +++++++++++++++++++++
 4 files changed, 148 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt
 create mode 100644 drivers/input/misc/cpcap-pwrbutton.c

diff --git a/Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt b/Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt
new file mode 100644
index 000000000000..0dd0076daf71
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt
@@ -0,0 +1,20 @@
+Motorola CPCAP on key
+
+This module is part of the CPCAP. For more details about the whole
+chip see Documentation/devicetree/bindings/mfd/motorola-cpcap.txt.
+
+This module provides a simple power button event via an Interrupt.
+
+Required properties:
+- compatible: should be one of the following
+   - "motorola,cpcap-pwrbutton"
+- interrupts: irq specifier for CPCAP's ON IRQ
+
+Example:
+
+&cpcap {
+	cpcap_pwrbutton: pwrbutton {
+		compatible = "motorola,cpcap-pwrbutton";
+		interrupts = <23 IRQ_TYPE_NONE>;
+	};
+};
diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 5b6c52210d20..9f7b72249eac 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -316,6 +316,16 @@ config INPUT_COBALT_BTNS
 	  To compile this driver as a module, choose M here: the
 	  module will be called cobalt_btns.
 
+config INPUT_CPCAP_PWRBUTTON
+	tristate "CPCAP OnKey"
+	depends on MFD_CPCAP
+	help
+	  Say Y here if you want to enable power key reporting via the
+	  Motorola CPCAP chip.
+
+	  To compile this driver as a module, choose M here. The module will
+	  be called cpcap-pwrbutton.
+
 config INPUT_WISTRON_BTNS
 	tristate "x86 Wistron laptop button interface"
 	depends on X86_32
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index b10523f2878e..b923a9828c88 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_INPUT_CM109)		+= cm109.o
 obj-$(CONFIG_INPUT_CMA3000)		+= cma3000_d0x.o
 obj-$(CONFIG_INPUT_CMA3000_I2C)		+= cma3000_d0x_i2c.o
 obj-$(CONFIG_INPUT_COBALT_BTNS)		+= cobalt_btns.o
+obj-$(CONFIG_INPUT_CPCAP_PWRBUTTON)	+= cpcap-pwrbutton.o
 obj-$(CONFIG_INPUT_DA9052_ONKEY)	+= da9052_onkey.o
 obj-$(CONFIG_INPUT_DA9055_ONKEY)	+= da9055_onkey.o
 obj-$(CONFIG_INPUT_DA9063_ONKEY)	+= da9063_onkey.o
diff --git a/drivers/input/misc/cpcap-pwrbutton.c b/drivers/input/misc/cpcap-pwrbutton.c
new file mode 100644
index 000000000000..0abef63217e2
--- /dev/null
+++ b/drivers/input/misc/cpcap-pwrbutton.c
@@ -0,0 +1,117 @@
+/**
+ * CPCAP Power Button Input Driver
+ *
+ * Copyright (C) 2017 Sebastian Reichel <sre@kernel.org>
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License. See the file "COPYING" in the main directory of this
+ * archive for more details.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/regmap.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/mfd/motorola-cpcap.h>
+
+#define CPCAP_IRQ_ON 23
+#define CPCAP_IRQ_ON_BITMASK (1 << (CPCAP_IRQ_ON % 16))
+
+struct cpcap_power_button {
+	struct regmap *regmap;
+	struct input_dev *idev;
+	struct device *dev;
+};
+
+static irqreturn_t powerbutton_irq(int irq, void *_button)
+{
+	struct cpcap_power_button *button = _button;
+	int val;
+
+	val = cpcap_sense_virq(button->regmap, irq);
+	if (val < 0) {
+		dev_err(button->dev, "irq read failed: %d", val);
+		return IRQ_HANDLED;
+	}
+
+	pm_wakeup_event(button->dev, 0);
+	input_report_key(button->idev, KEY_POWER, val);
+	input_sync(button->idev);
+
+	return IRQ_HANDLED;
+}
+
+static int cpcap_power_button_probe(struct platform_device *pdev)
+{
+	struct cpcap_power_button *button;
+	int irq = platform_get_irq(pdev, 0);
+	int err;
+
+	button = devm_kmalloc(&pdev->dev, sizeof(*button), GFP_KERNEL);
+	if (!button)
+		return -ENOMEM;
+
+	button->idev = devm_input_allocate_device(&pdev->dev);
+	if (!button->idev)
+		return -ENOMEM;
+
+	button->regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!button->regmap)
+		return -ENODEV;
+
+	button->dev = &pdev->dev;
+
+	button->idev->name = "cpcap-pwrbutton";
+	button->idev->phys = "cpcap-pwrbutton/input0";
+	button->idev->dev.parent = button->dev;
+	input_set_capability(button->idev, EV_KEY, KEY_POWER);
+
+	err = devm_request_threaded_irq(&pdev->dev, irq, NULL,
+		powerbutton_irq, IRQF_ONESHOT, "cpcap_pwrbutton", button);
+	if (err < 0) {
+		dev_err(&pdev->dev, "IRQ request failed: %d\n", err);
+		return err;
+	}
+
+	err = input_register_device(button->idev);
+	if (err) {
+		dev_err(&pdev->dev, "Input register failed: %d\n", err);
+		return err;
+	}
+
+	device_init_wakeup(&pdev->dev, true);
+
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id cpcap_pwrbutton_dt_match_table[] = {
+	{ .compatible = "motorola,cpcap-pwrbutton" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, cpcap_pwrbutton_dt_match_table);
+#endif
+
+static struct platform_driver cpcap_power_button_driver = {
+	.probe		= cpcap_power_button_probe,
+	.driver		= {
+		.name	= "cpcap-pwrbutton",
+		.of_match_table = of_match_ptr(cpcap_pwrbutton_dt_match_table),
+	},
+};
+module_platform_driver(cpcap_power_button_driver);
+
+MODULE_ALIAS("platform:cpcap-pwrbutton");
+MODULE_DESCRIPTION("CPCAP Power Button");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Sebastian Reichel <sre@kernel.org>");
-- 
2.11.0

