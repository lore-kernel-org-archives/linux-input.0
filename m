From: yassinjaffer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH 3/4] input: Add new sun4i-keypad driver
Date: Wed, 16 Sep 2015 00:05:56 +1000
Message-ID: <1442325957-10102-4-git-send-email-yassinjaffer@gmail.com>
References: <1442325957-10102-1-git-send-email-yassinjaffer@gmail.com>
Reply-To: yassinjaffer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDCKXM7WZYLRBB6M4CXQKGQEAXRDKCA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1442325957-10102-1-git-send-email-yassinjaffer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Yassin Jaffer <yassinjaffer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

From: Yassin Jaffer <yassinjaffer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Allwinnner SUN4i Keypad controller is used to interface a SoC
with a matrix-typekeypad device.
The keypad controller supports multiple row and column lines.
A key can be placed at each intersection of a unique
row and a unique column.
The keypad controller can sense a key-press and key-release and report the
event using a interrupt to the cpu.
This patch adds a driver support to this.
The keypad controller driver does not give proper information
if more that two keys are selected.

Signed-off-by: Yassin Jaffer <yassinjaffer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/input/keyboard/Kconfig        |  11 ++
 drivers/input/keyboard/Makefile       |   1 +
 drivers/input/keyboard/sun4i-keypad.c | 361 ++++++++++++++++++++++++++++++++++
 3 files changed, 373 insertions(+)
 create mode 100644 drivers/input/keyboard/sun4i-keypad.c

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 2e80107..4f2f3f8 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -590,6 +590,17 @@ config KEYBOARD_SUN4I_LRADC
 	  To compile this driver as a module, choose M here: the
 	  module will be called sun4i-lradc-keys.
 
+config KEYBOARD_SUN4I_KEYPAD
+	tristate "Allwinner sun4i keypad support"
+	depends on ARCH_SUNXI
+	select INPUT_MATRIXKMAP
+	help
+	  This selects support for the Allwinner keypad
+	  on Allwinner sunxi SoCs.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called sun4i-keypad.
+
 config KEYBOARD_DAVINCI
 	tristate "TI DaVinci Key Scan"
 	depends on ARCH_DAVINCI_DM365
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index 1d416dd..d9f54b4 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -57,6 +57,7 @@ obj-$(CONFIG_KEYBOARD_STMPE)		+= stmpe-keypad.o
 obj-$(CONFIG_KEYBOARD_STOWAWAY)		+= stowaway.o
 obj-$(CONFIG_KEYBOARD_ST_KEYSCAN)	+= st-keyscan.o
 obj-$(CONFIG_KEYBOARD_SUN4I_LRADC)	+= sun4i-lradc-keys.o
+obj-$(CONFIG_KEYBOARD_SUN4I_KEYPAD)	+= sun4i-keypad.o
 obj-$(CONFIG_KEYBOARD_SUNKBD)		+= sunkbd.o
 obj-$(CONFIG_KEYBOARD_TC3589X)		+= tc3589x-keypad.o
 obj-$(CONFIG_KEYBOARD_TEGRA)		+= tegra-kbc.o
diff --git a/drivers/input/keyboard/sun4i-keypad.c b/drivers/input/keyboard/sun4i-keypad.c
new file mode 100644
index 0000000..995f9665
--- /dev/null
+++ b/drivers/input/keyboard/sun4i-keypad.c
@@ -0,0 +1,361 @@
+/*
+ * Allwinner sun4i keypad Controller driver
+ *
+ * Copyright (C) 2015 Yassin Jaffer <yassinjaffer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
+ *
+ * Parts of this software are based on (derived from):
+ * Copyright (C) 2013-2015 liming-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org,
+ *			 qys<qinyongshen-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org>
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
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/interrupt.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of_platform.h>
+#include <linux/slab.h>
+#include <linux/input.h>
+#include <linux/input/matrix_keypad.h>
+
+/*
+ * Keypad Controller registers
+ */
+#define KP_CTL			0x00  /* Keypad Control register */
+#define KP_TIMING		0x04  /* Keypad Timing register */
+#define KP_INT_CFG		0x08  /* Keypad interrupt Config register */
+#define KP_INT_STA		0x0c  /* Keypad interrupt Status register */
+
+#define KP_IN_OFFSET		0x10 /* Keypad Input Data register 0 */
+#define KP_INX_OFFSET(reg_n)	(KP_IN_OFFSET + 4 * (reg_n))
+
+/* KP_CTL bits */
+#define ENABLE(x)		((x) << 0)
+#define COLMASK(x)		((~x & 0xff) << 8)
+#define ROWMASK(x)		((~x & 0xff) << 16)
+
+/* KP_TIMING bits */
+#define SCAN_CYCLE(x)		((x) << 0)
+#define DBC_CYCLE(x)		((x) << 16)
+
+/* KP_INT_CFG bits */
+#define KP_IRQ_FEDGE		BIT(0)
+#define	KP_IRQ_REDGE		BIT(1)
+
+/* KP_INT_STA bits */
+#define KP_STA_FEDGE		BIT(0)
+#define	KP_STA_REDGE		BIT(1)
+
+#define KP_MAX_ROWS		8
+#define KP_MAX_COLS		8
+#define N_ROWS_REG		2
+#define KP_ROW_SHIFT		3
+#define KP_BIT_SHIFT            32
+
+#define MAX_MATRIX_KEY_NUM	(KP_MAX_ROWS * KP_MAX_COLS)
+
+#define KP_BASE_CLK		1000000
+#define MIN_CYCLE		0x10
+#define MIN_SCAN_CYCLE		0x100
+#define MIN_DBC_CYCLE		0x200
+
+/*
+ * keypad Controller structure: stores sunxi keypad controller information
+ *
+ * @dev:		parent device
+ * @input:		pointer to input device object
+ * @apb_clk:		keypad Controller APB clock
+ * @clk:		keypad Controller mod clock
+ * @base:		keypad controller registers
+ * @irq:		interrupt
+ * @rows_en_mask:	Masks for enabled rows
+ * @cols_en_mask:	Masks for enabled cols
+ * @keymap:		matrix scan code table for keycodes
+ * @key_press_state:	cached keys press state
+ * @debounce_cycl:	keypad specific debounce cycle
+ * @scan_cycl:		keypad specific scan cycle
+ * @autorepeat:         flag for auto repetition
+ */
+struct sun4i_keypad_data {
+	struct device *dev;
+	struct input_dev *input;
+
+	struct clk *apb_clk;
+	struct clk *clk;
+	void __iomem *base;
+	int	irq;
+
+	unsigned short	rows_en_mask;
+	unsigned short	cols_en_mask;
+
+	unsigned short	keymap[MAX_MATRIX_KEY_NUM];
+
+	unsigned int press_state[N_ROWS_REG];
+
+	unsigned int debounce_cycl;
+	unsigned int scan_cycl;
+	bool	autorepeat;
+};
+
+static void sun4i_keypad_scan(struct sun4i_keypad_data *keypad, bool edge)
+{
+	struct input_dev *input_dev = keypad->input;
+	u32 key_scan[N_ROWS_REG];
+	unsigned long change;
+	unsigned short code;
+	int reg_nr, bit_nr, key_up;
+
+	for (reg_nr = 0; reg_nr < N_ROWS_REG; reg_nr++) {
+		key_scan[reg_nr] = ~(readl(keypad->base +
+					KP_INX_OFFSET(reg_nr)));
+
+		change = edge ? key_scan[reg_nr] :
+			keypad->press_state[reg_nr] ^ key_scan[reg_nr];
+
+		key_up = edge || (change & keypad->press_state[reg_nr]);
+
+		for_each_set_bit(bit_nr, &change, BITS_PER_LONG) {
+			code = keypad->keymap[KP_BIT_SHIFT * reg_nr + bit_nr];
+			input_report_key(input_dev, code, key_up);
+			input_sync(input_dev);
+		}
+
+		keypad->press_state[reg_nr] = edge ?  0 : key_scan[reg_nr];
+	}
+}
+
+static irqreturn_t sun4i_keypad_irq(int irq, void *dev_id)
+{
+	struct sun4i_keypad_data *keypad = dev_id;
+	u32 intr_status;
+
+	intr_status  = readl(keypad->base + KP_INT_STA);
+
+	/* release only gives a valid information for a single key release */
+	if (intr_status & KP_STA_REDGE)
+		sun4i_keypad_scan(keypad, true);
+
+	/* press does not give valid information when
+	 * multiple rows are selected
+	*/
+	if (intr_status & KP_STA_FEDGE)
+		sun4i_keypad_scan(keypad, false);
+
+	writel(intr_status, keypad->base + KP_INT_STA);
+
+	return IRQ_HANDLED;
+}
+
+static int sun4i_keypad_open(struct input_dev *dev)
+{
+	struct sun4i_keypad_data *keypad = input_get_drvdata(dev);
+	int reg_nr;
+
+	if (clk_prepare_enable(keypad->apb_clk))
+		return -EINVAL;
+
+	if (clk_prepare_enable(keypad->clk)) {
+		clk_disable_unprepare(keypad->apb_clk);
+		return -EINVAL;
+	}
+
+	for (reg_nr = 0; reg_nr < N_ROWS_REG; reg_nr++)
+		keypad->press_state[reg_nr] = ~(readl(keypad->base +
+							KP_INX_OFFSET(reg_nr)));
+
+	writel(KP_IRQ_FEDGE | KP_IRQ_REDGE, keypad->base + KP_INT_CFG);
+
+	writel(SCAN_CYCLE(keypad->scan_cycl) |
+		DBC_CYCLE(keypad->debounce_cycl), keypad->base + KP_TIMING);
+
+	writel(ENABLE(1) | ROWMASK(keypad->rows_en_mask) |
+		COLMASK(keypad->cols_en_mask), keypad->base + KP_CTL);
+
+	return 0;
+}
+
+static void sun4i_keypad_close(struct input_dev *dev)
+{
+	struct sun4i_keypad_data *keypad = input_get_drvdata(dev);
+
+	writel(ENABLE(0) | ROWMASK(keypad->rows_en_mask) |
+		COLMASK(keypad->cols_en_mask), keypad->base + KP_CTL);
+
+	clk_disable_unprepare(keypad->clk);
+	clk_disable_unprepare(keypad->apb_clk);
+}
+
+static int sun4i_keypad_parse_dt(struct device *dev,
+				 struct sun4i_keypad_data *keypad)
+{
+	struct device_node *np;
+
+	np = dev->of_node;
+	if (!np)
+		return -EINVAL;
+
+	of_property_read_u32(np, "debounce-cycle", &keypad->debounce_cycl);
+	if (keypad->debounce_cycl < MIN_CYCLE)
+		keypad->debounce_cycl = MIN_DBC_CYCLE;
+
+	of_property_read_u32(np, "scan-cycle", &keypad->scan_cycl);
+	if (keypad->scan_cycl < MIN_CYCLE)
+		keypad->scan_cycl = MIN_SCAN_CYCLE;
+
+	if (of_property_read_bool(np, "autorepeat"))
+		keypad->autorepeat = true;
+
+	return 0;
+}
+
+static int sun4i_keypad_probe(struct platform_device *pdev)
+{
+	struct sun4i_keypad_data *keypad;
+	struct device *dev = &pdev->dev;
+	int row, col, code;
+	int ret = 0;
+
+	keypad = devm_kzalloc(dev, sizeof(struct sun4i_keypad_data),
+			      GFP_KERNEL);
+	if (!keypad)
+		return -ENOMEM;
+
+	ret  = sun4i_keypad_parse_dt(dev, keypad);
+	if (ret)
+		return ret;
+
+	keypad->base = devm_ioremap_resource(dev,
+			      platform_get_resource(pdev, IORESOURCE_MEM, 0));
+	if (IS_ERR(keypad->base))
+		return PTR_ERR(keypad->base);
+
+	keypad->dev = dev;
+	keypad->input = devm_input_allocate_device(dev);
+	if (!keypad->input)
+		return -ENOMEM;
+
+	keypad->input->name = pdev->name;
+	keypad->input->phys = "sun4i_keypad/input0";
+
+	keypad->input->id.bustype = BUS_HOST;
+	keypad->input->id.vendor  = 0x0001;
+	keypad->input->id.product = 0x0001;
+	keypad->input->id.version = 0x0100;
+
+	keypad->input->open = sun4i_keypad_open;
+	keypad->input->close = sun4i_keypad_close;
+
+	/* matrix keypad keymap as:
+	 * row << 24 | column << 16 | key-code
+	 */
+	ret = matrix_keypad_build_keymap(NULL, NULL,
+					 KP_MAX_ROWS,
+					 KP_MAX_COLS,
+					 keypad->keymap,
+					 keypad->input);
+	if (ret) {
+		dev_err(dev, "failed to build keymap\n");
+		return ret;
+	}
+
+	/* Search for enabled rows and cols */
+	for (row = 0; row < KP_MAX_ROWS; row++) {
+		for (col = 0; col < KP_MAX_COLS; col++) {
+			code = MATRIX_SCAN_CODE(row, col, KP_ROW_SHIFT);
+			if (keypad->keymap[code] != KEY_RESERVED) {
+				keypad->rows_en_mask |= 1 << row;
+				keypad->cols_en_mask |= 1 << col;
+			}
+		}
+	}
+
+	if (keypad->autorepeat)
+		__set_bit(EV_REP, keypad->input->evbit);
+
+	input_set_capability(keypad->input, EV_MSC, MSC_SCAN);
+	input_set_drvdata(keypad->input, keypad);
+
+	keypad->irq = platform_get_irq(pdev, 0);
+	if (keypad->irq < 0) {
+		dev_err(dev, "failed to get keypad IRQ\n");
+		return -ENXIO;
+	}
+
+	ret = devm_request_irq(dev, keypad->irq,
+			       sun4i_keypad_irq, 0,
+			       "sun4i-a10-keypad", keypad);
+	if (ret) {
+		dev_err(dev, "failed to request IRQ\n");
+		return ret;
+	}
+
+	keypad->apb_clk = devm_clk_get(dev, "apb");
+	if (IS_ERR(keypad->apb_clk)) {
+		dev_err(dev, "failed to get a apb clock.\n");
+		return PTR_ERR(keypad->apb_clk);
+	}
+
+	keypad->clk = devm_clk_get(dev, "keypad");
+	if (IS_ERR(keypad->clk)) {
+		dev_err(dev, "failed to get a keypad clock.\n");
+		return PTR_ERR(keypad->clk);
+	}
+
+	ret = clk_set_rate(keypad->clk, KP_BASE_CLK);
+	if (ret) {
+		dev_err(dev, "set keypad base clock failed!\n");
+		return ret;
+	}
+
+	ret = input_register_device(keypad->input);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, keypad);
+
+	return 0;
+}
+
+static int sun4i_keypad_remove(struct platform_device *pdev)
+{
+	struct sun4i_keypad_data *keypad = platform_get_drvdata(pdev);
+
+	free_irq(keypad->irq, keypad);
+	input_unregister_device(keypad->input);
+	kfree(keypad);
+
+	return 0;
+}
+
+static const struct of_device_id sun4i_keypad_of_match[] = {
+	{ .compatible = "allwinner,sun4i-a10-keypad", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, sun4i_keypad_of_match);
+
+static struct platform_driver sun4i_keypad_driver = {
+	.driver = {
+		.name	= "sun4i-a10-keypad",
+		.of_match_table = of_match_ptr(sun4i_keypad_of_match),
+	},
+	.probe	= sun4i_keypad_probe,
+	.remove = sun4i_keypad_remove,
+};
+
+module_platform_driver(sun4i_keypad_driver);
+
+MODULE_DESCRIPTION("Allwinner sun4i keypad controller driver");
+MODULE_AUTHOR("Yassin Jaffer <yassinjaffer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>");
+MODULE_LICENSE("GPL");
+
-- 
1.9.1
