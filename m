From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 1/4] input: Add new sun4i-lradc-keys driver
Date: Thu,  2 Jan 2014 10:58:24 +0100
Message-ID: <1388656707-16181-2-git-send-email-hdegoede@redhat.com>
References: <1388656707-16181-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDL4X2GMZUKRBS7QSSLAKGQELJPW3NY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1388656707-16181-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Allwinnner sunxi SoCs have a low resolution adc (called lradc) which is
specifically designed to have various (tablet) keys (ie home, back, search,
etc). attached to it using a resistor network. This adds a driver for this.

There are 2 channels, currently this driver only supports chan0 since there
are no boards known to use chan1. The devicetree properties are already
prefixed with chan0 as preparation for chan1 support in the future.

This has been tested on an olimex a10s-olinuxino-micro, a13-olinuxino, and
a20-olinuxino-micro.

Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 .../devicetree/bindings/input/sun4i-lradc-keys.txt |  22 ++
 drivers/input/keyboard/Kconfig                     |  10 +
 drivers/input/keyboard/Makefile                    |   1 +
 drivers/input/keyboard/sun4i-lradc-keys.c          | 243 +++++++++++++++++++++
 4 files changed, 276 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt
 create mode 100644 drivers/input/keyboard/sun4i-lradc-keys.c

diff --git a/Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt b/Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt
new file mode 100644
index 0000000..7801264
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt
@@ -0,0 +1,22 @@
+Allwinner sun4i low res adc attached tablet keys
+------------------------------------------------
+
+Required properties:
+ - compatible: "allwinner,sun4i-lradc-keys"
+ - reg: mmio address range of the chip
+ - interrupts: interrupt to which the chip is connected
+ - allwinner,chan0-step: step in mV between keys must be 150 or 200
+ - linux,chan0-keycodes: array of dt-bindings/input/input.h KEY_ codes
+
+Example:
+
+#include <dt-bindings/input/input.h>
+
+	lradc: lradc@01c22800 {
+		compatible = "allwinner,sun4i-lradc-keys";
+		reg = <0x01c22800 0x100>;
+		interrupts = <31>;
+		allwinner,chan0-step = <200>;
+		linux,chan0-keycodes = <KEY_VOLUMEUP KEY_VOLUMEDOWN
+					KEY_MENU KEY_ENTER KEY_HOME>;
+	};
diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index bb174c1..d95e6e4 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -544,6 +544,16 @@ config KEYBOARD_STMPE
 	  To compile this driver as a module, choose M here: the module will be
 	  called stmpe-keypad.
 
+config KEYBOARD_SUN4I_LRADC
+	tristate "Allwinner sun4i low res adc attached tablet keys support"
+	depends on ARCH_SUNXI
+	help
+	  This selects support for the Allwinner low res adc attached tablet
+	  keys found on Allwinner sunxi SoCs.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called sun4i-lradc-keys.
+
 config KEYBOARD_DAVINCI
 	tristate "TI DaVinci Key Scan"
 	depends on ARCH_DAVINCI_DM365
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index a699b61..f3265bd 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -50,6 +50,7 @@ obj-$(CONFIG_KEYBOARD_SH_KEYSC)		+= sh_keysc.o
 obj-$(CONFIG_KEYBOARD_SPEAR)		+= spear-keyboard.o
 obj-$(CONFIG_KEYBOARD_STMPE)		+= stmpe-keypad.o
 obj-$(CONFIG_KEYBOARD_STOWAWAY)		+= stowaway.o
+obj-$(CONFIG_KEYBOARD_SUN4I_LRADC)	+= sun4i-lradc-keys.o
 obj-$(CONFIG_KEYBOARD_SUNKBD)		+= sunkbd.o
 obj-$(CONFIG_KEYBOARD_TC3589X)		+= tc3589x-keypad.o
 obj-$(CONFIG_KEYBOARD_TEGRA)		+= tegra-kbc.o
diff --git a/drivers/input/keyboard/sun4i-lradc-keys.c b/drivers/input/keyboard/sun4i-lradc-keys.c
new file mode 100644
index 0000000..5c55e17
--- /dev/null
+++ b/drivers/input/keyboard/sun4i-lradc-keys.c
@@ -0,0 +1,243 @@
+/*
+ * Allwinner sun4i low res adc attached tablet keys driver
+ *
+ * Copyright (C) 2014 Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+/*
+ * Allwinnner sunxi SoCs have a lradc which is specifically designed to have
+ * various (tablet) keys (ie home, back, search, etc). attached to it using
+ * a resistor network. This driver is for the keys on such boards.
+ *
+ * There are 2 channels, currently this driver only supports chan0 since there
+ * are no boards known to use chan1. The devicetree properties are already
+ * prefixed with chan0 as preparation for chan1 support in the future.
+ */
+
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#define LRADC_CTRL		0x00
+#define LRADC_INTC		0x04
+#define LRADC_INTS		0x08
+#define LRADC_DATA0		0x0c
+#define LRADC_DATA1		0x10
+
+/* LRADC_CTRL bits */
+#define FIRST_CONVERT_DLY(x)	((x) << 24) /* 8 bits */
+#define CHAN_SELECT(x)		((x) << 22) /* 2 bits */
+#define CONTINUE_TIME_SEL(x)	((x) << 16) /* 4 bits */
+#define KEY_MODE_SEL(x)		((x) << 12) /* 2 bits */
+#define LEVELA_B_CNT(x)		((x) << 8)  /* 4 bits */
+#define HOLD_EN(x)		((x) << 6)
+#define LEVELB_VOL(x)		((x) << 4)  /* 2 bits */
+#define SAMPLE_RATE(x)		((x) << 2)  /* 2 bits */
+#define ENABLE(x)		((x) << 0)
+
+/* LRADC_INTC and LRADC_INTS bits */
+#define CHAN1_KEYUP_IRQ		BIT(12)
+#define CHAN1_ALRDY_HOLD_IRQ	BIT(11)
+#define CHAN1_HOLD_IRQ		BIT(10)
+#define	CHAN1_KEYDOWN_IRQ	BIT(9)
+#define CHAN1_DATA_IRQ		BIT(8)
+#define CHAN0_KEYUP_IRQ		BIT(4)
+#define CHAN0_ALRDY_HOLD_IRQ	BIT(3)
+#define CHAN0_HOLD_IRQ		BIT(2)
+#define	CHAN0_KEYDOWN_IRQ	BIT(1)
+#define CHAN0_DATA_IRQ		BIT(0)
+
+#define MAX_KEYS		13
+
+/* Lookup table to map the adc val to a keycode index for 150 mv step size */
+static const u8 adc_val_to_key_index_step150[64] = {
+	0, 0, 0,
+	1, 1, 1, 1, 1,
+	2, 2, 2, 2, 2,
+	3, 3, 3, 3,
+	4, 4, 4, 4, 4,
+	5, 5, 5, 5, 5,
+	6, 6, 6, 6, 6,
+	7, 7, 7, 7,
+	8, 8, 8, 8, 8,
+	9, 9, 9, 9, 9,
+	10, 10, 10, 10,
+	11, 11, 11, 11,
+	12, 12, 12, 12, 12, 12, 12, 12, 12, 12
+};
+
+/* Lookup table to map the adc val to a keycode index for 200 mv step size */
+static const u8 adc_val_to_key_index_step200[64] = {
+	0, 0, 0, 0, 0, 0, 0, 0,
+	1, 1, 1, 1, 1, 1, 1,
+	2, 2, 2, 2, 2, 2, 2,
+	3, 3, 3, 3, 3, 3,
+	4, 4, 4, 4, 4, 4,
+	5, 5, 5, 5, 5, 5,
+	6, 6, 6, 6, 6, 6, 6, 6, 6, 6,
+	7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7
+};
+
+struct sun4i_lradc_data {
+	struct device *dev;
+	struct input_dev *input;
+	void __iomem *base;
+	u32 chan0_step;
+	u32 chan0_keycode;
+	u32 chan0_keycodes[MAX_KEYS];
+};
+
+static irqreturn_t sun4i_lradc_irq(int irq, void *dev_id)
+{
+	struct sun4i_lradc_data *lradc = dev_id;
+	u32 ints, val;
+
+	ints  = readl(lradc->base + LRADC_INTS);
+
+	/*
+	 * lradc supports only one keypress at a time, release does not give
+	 * any info as to which key was released, so we cache the keycode.
+	 */
+	if ((ints & CHAN0_KEYDOWN_IRQ) && lradc->chan0_keycode == 0) {
+		val = readl(lradc->base + LRADC_DATA0);
+		if (lradc->chan0_step == 150)
+			val = adc_val_to_key_index_step150[val];
+		else
+			val = adc_val_to_key_index_step200[val];
+
+		lradc->chan0_keycode = lradc->chan0_keycodes[val];
+		input_report_key(lradc->input, lradc->chan0_keycode, 1);
+	}
+
+	if (ints & CHAN0_KEYUP_IRQ) {
+		input_report_key(lradc->input, lradc->chan0_keycode, 0);
+		lradc->chan0_keycode = 0;
+	}
+
+	input_sync(lradc->input);
+
+	writel(ints, lradc->base + LRADC_INTS);
+
+	return IRQ_HANDLED;
+}
+
+static int sun4i_lradc_open(struct input_dev *dev)
+{
+	struct sun4i_lradc_data *lradc = input_get_drvdata(dev);
+
+	/*
+	 * Set sample time to 16 ms / 62.5 Hz. Wait 2 * 16 ms for key to
+	 * stabilize on press, wait (1 + 1) * 16 ms for key release
+	 */
+	writel(FIRST_CONVERT_DLY(2) | LEVELA_B_CNT(1) | HOLD_EN(1) |
+		SAMPLE_RATE(2) | ENABLE(1), lradc->base + LRADC_CTRL);
+
+	writel(CHAN0_KEYUP_IRQ | CHAN0_KEYDOWN_IRQ, lradc->base + LRADC_INTC);
+
+	return 0;
+}
+
+static void sun4i_lradc_close(struct input_dev *dev)
+{
+	struct sun4i_lradc_data *lradc = input_get_drvdata(dev);
+
+	/* Disable lradc, leave other settings unchanged */
+	writel(FIRST_CONVERT_DLY(2) | LEVELA_B_CNT(1) | HOLD_EN(1) |
+		SAMPLE_RATE(2), lradc->base + LRADC_CTRL);
+	writel(0, lradc->base + LRADC_INTC);
+}
+
+static int sun4i_lradc_probe(struct platform_device *pdev)
+{
+	struct sun4i_lradc_data *lradc;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	int i, ret;
+
+	lradc = devm_kzalloc(dev, sizeof(struct sun4i_lradc_data), GFP_KERNEL);
+	if (!lradc)
+		return -ENOMEM;
+
+	ret = of_property_read_u32(np, "allwinner,chan0-step",
+				   &lradc->chan0_step);
+	if (ret || (lradc->chan0_step != 150 && lradc->chan0_step != 200)) {
+		dev_err(dev, "Invalid allwinner,chan0-step dt-property\n");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < MAX_KEYS; i++)
+		of_property_read_u32_index(np, "linux,chan0-keycodes",
+					   i, &lradc->chan0_keycodes[i]);
+
+	lradc->dev = dev;
+	lradc->input = devm_input_allocate_device(dev);
+	if (!lradc->input)
+		return -ENOMEM;
+
+	lradc->input->name = pdev->name;
+	lradc->input->phys = "sun4i_lradc/input0";
+	lradc->input->open = sun4i_lradc_open;
+	lradc->input->close = sun4i_lradc_close;
+	lradc->input->id.bustype = BUS_HOST;
+	lradc->input->id.vendor = 0x0001;
+	lradc->input->id.product = 0x0001;
+	lradc->input->id.version = 0x0100;
+	lradc->input->evbit[0] =  BIT(EV_SYN) | BIT(EV_KEY);
+	for (i = 0; i < MAX_KEYS; i++)
+		set_bit(lradc->chan0_keycodes[i], lradc->input->keybit);
+	input_set_drvdata(lradc->input, lradc);
+
+	lradc->base = devm_ioremap_resource(dev,
+			      platform_get_resource(pdev, IORESOURCE_MEM, 0));
+	if (IS_ERR(lradc->base))
+		return PTR_ERR(lradc->base);
+
+	ret = devm_request_irq(dev, platform_get_irq(pdev, 0), sun4i_lradc_irq,
+			       0, "sun4i-lradc-keys", lradc);
+	if (ret)
+		return ret;
+
+	ret = input_register_device(lradc->input);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, lradc);
+	return 0;
+}
+
+static const struct of_device_id sun4i_lradc_of_match[] = {
+	{ .compatible = "allwinner,sun4i-lradc-keys", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, sun4i_lradc_of_match);
+
+static struct platform_driver sun4i_lradc_driver = {
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "sun4i-lradc-keys",
+		.of_match_table = of_match_ptr(sun4i_lradc_of_match),
+	},
+	.probe	= sun4i_lradc_probe,
+};
+
+module_platform_driver(sun4i_lradc_driver);
+
+MODULE_DESCRIPTION("Allwinner sun4i low res adc attached tablet keys driver");
+MODULE_AUTHOR("Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>");
+MODULE_LICENSE("GPL");
-- 
1.8.4.2
