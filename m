From: Chen Zhong <chen.zhong@mediatek.com>
Subject: [PATCH v3 4/5] input: Add MediaTek PMIC keys support
Date: Fri, 25 Aug 2017 14:32:32 +0800
Message-ID: <1503642753-12385-5-git-send-email-chen.zhong@mediatek.com>
References: <1503642753-12385-1-git-send-email-chen.zhong@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503642753-12385-1-git-send-email-chen.zhong@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Lee Jones <lee.jones@linaro.org>, Eddie Huang <eddie.huang@mediatek.com>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Andi Shyti <andi.shyti@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Chen Zhong <chen.zhong@mediatek.com>, Linus Walleij <linus.walleij@linaro.org>, Jaechul Lee <jcsing.lee@samsung.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
List-Id: linux-input@vger.kernel.org

This patch add support to handle MediaTek PMIC MT6397/MT6323 key
interrupts including pwrkey and homekey, also add setting for
long press key shutdown behavior.

Signed-off-by: Chen Zhong <chen.zhong@mediatek.com>
---
 drivers/input/keyboard/Kconfig         |    9 +
 drivers/input/keyboard/Makefile        |    1 +
 drivers/input/keyboard/mtk-pmic-keys.c |  308 ++++++++++++++++++++++++++++++++
 3 files changed, 318 insertions(+)
 create mode 100644 drivers/input/keyboard/mtk-pmic-keys.c

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 4c4ab1c..bd4e20a 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -756,4 +756,13 @@ config KEYBOARD_BCM
 	  To compile this driver as a module, choose M here: the
 	  module will be called bcm-keypad.
 
+config KEYBOARD_MTK_PMIC
+	tristate "MediaTek PMIC keys support"
+	depends on MFD_MT6397
+	help
+	  Say Y here if you want to use the pmic keys (powerkey/homekey).
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called pmic-keys.
+
 endif
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index d2338ba..20c0b98 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_KEYBOARD_MATRIX)		+= matrix_keypad.o
 obj-$(CONFIG_KEYBOARD_MAX7359)		+= max7359_keypad.o
 obj-$(CONFIG_KEYBOARD_MCS)		+= mcs_touchkey.o
 obj-$(CONFIG_KEYBOARD_MPR121)		+= mpr121_touchkey.o
+obj-$(CONFIG_KEYBOARD_MTK_PMIC) 	+= mtk-pmic-keys.o
 obj-$(CONFIG_KEYBOARD_NEWTON)		+= newtonkbd.o
 obj-$(CONFIG_KEYBOARD_NOMADIK)		+= nomadik-ske-keypad.o
 obj-$(CONFIG_KEYBOARD_NSPIRE)		+= nspire-keypad.o
diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
new file mode 100644
index 0000000..40518ce
--- /dev/null
+++ b/drivers/input/keyboard/mtk-pmic-keys.c
@@ -0,0 +1,308 @@
+/*
+ * Copyright (C) 2017 MediaTek, Inc.
+ *
+ * Author: Chen Zhong <chen.zhong@mediatek.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+#include <linux/mfd/mt6323/registers.h>
+#include <linux/mfd/mt6397/registers.h>
+#include <linux/mfd/mt6397/core.h>
+
+#define PWRKEY_RST_EN_MASK	0x1
+#define PWRKEY_RST_EN_SHIFT	6
+#define HOMEKEY_RST_EN_MASK	0x1
+#define HOMEKEY_RST_EN_SHIFT	5
+#define RST_DU_MASK		0x3
+#define RST_DU_SHIFT		8
+
+#define PMIC_PWRKEY_INDEX	0
+#define PMIC_HOMEKEY_INDEX	1
+#define PMIC_MAX_KEY_COUNT	2
+
+struct pmic_keys_regs {
+	u32 deb_reg;
+	u32 deb_mask;
+	u32 intsel_reg;
+	u32 intsel_mask;
+};
+
+#define PMIC_KEYS_REGS(_deb_reg, _deb_mask, _intsel_reg, _intsel_mask)	\
+{									\
+	.deb_reg		= _deb_reg,				\
+	.deb_mask		= _deb_mask,				\
+	.intsel_reg		= _intsel_reg,				\
+	.intsel_mask		= _intsel_mask,				\
+}
+
+struct pmic_regs {
+	const struct pmic_keys_regs keys_regs[PMIC_MAX_KEY_COUNT];
+	u32 pmic_rst_reg;
+};
+
+static const struct pmic_regs mt6397_regs = {
+	.keys_regs[PMIC_PWRKEY_INDEX] = PMIC_KEYS_REGS(MT6397_CHRSTATUS,
+		0x8, MT6397_INT_RSV, 0x10),
+	.keys_regs[PMIC_HOMEKEY_INDEX] = PMIC_KEYS_REGS(MT6397_OCSTATUS2,
+		0x10, MT6397_INT_RSV, 0x8),
+	.pmic_rst_reg = MT6397_TOP_RST_MISC,
+};
+
+static const struct pmic_regs mt6323_regs = {
+	.keys_regs[PMIC_PWRKEY_INDEX] = PMIC_KEYS_REGS(MT6323_CHRSTATUS,
+		0x2, MT6323_INT_MISC_CON, 0x10),
+	.keys_regs[PMIC_HOMEKEY_INDEX] = PMIC_KEYS_REGS(MT6323_CHRSTATUS,
+		0x4, MT6323_INT_MISC_CON, 0x8),
+	.pmic_rst_reg = MT6323_TOP_RST_MISC,
+};
+
+struct pmic_keys_info {
+	struct mtk_pmic_keys *keys;
+	const struct pmic_keys_regs *regs;
+	unsigned int keycode;
+	int irq;
+	bool wakeup:1;
+};
+
+struct mtk_pmic_keys {
+	struct input_dev *input_dev;
+	struct device *dev;
+	struct regmap *regmap;
+	struct pmic_keys_info keys[PMIC_MAX_KEY_COUNT];
+};
+
+enum long_press_mode {
+	LP_DISABLE,
+	LP_ONEKEY,
+	LP_TWOKEY,
+};
+
+static void long_press_reset_setup(struct mtk_pmic_keys *keys, u32 pmic_rst_reg)
+{
+	int ret;
+	u32 long_press_mode, long_press_debounce;
+
+	ret = of_property_read_u32(keys->dev->of_node,
+		"debounce-interval", &long_press_debounce);
+	if (ret)
+		long_press_debounce = 0;
+
+	regmap_update_bits(keys->regmap, pmic_rst_reg,
+			   RST_DU_MASK << RST_DU_SHIFT,
+			   long_press_debounce << RST_DU_SHIFT);
+
+	ret = of_property_read_u32(keys->dev->of_node,
+		"mediatek,long-press-mode", &long_press_mode);
+	if (ret)
+		long_press_mode = LP_DISABLE;
+
+	switch (long_press_mode) {
+	case LP_ONEKEY:
+		regmap_update_bits(keys->regmap, pmic_rst_reg,
+				   PWRKEY_RST_EN_MASK << PWRKEY_RST_EN_SHIFT,
+				   PWRKEY_RST_EN_MASK << PWRKEY_RST_EN_SHIFT);
+		regmap_update_bits(keys->regmap, pmic_rst_reg,
+				   HOMEKEY_RST_EN_MASK << HOMEKEY_RST_EN_SHIFT,
+				   0);
+		break;
+	case LP_TWOKEY:
+		regmap_update_bits(keys->regmap, pmic_rst_reg,
+				   PWRKEY_RST_EN_MASK << PWRKEY_RST_EN_SHIFT,
+				   PWRKEY_RST_EN_MASK << PWRKEY_RST_EN_SHIFT);
+		regmap_update_bits(keys->regmap, pmic_rst_reg,
+				   HOMEKEY_RST_EN_MASK << HOMEKEY_RST_EN_SHIFT,
+				   HOMEKEY_RST_EN_MASK << HOMEKEY_RST_EN_SHIFT);
+		break;
+	case LP_DISABLE:
+		regmap_update_bits(keys->regmap, pmic_rst_reg,
+				   PWRKEY_RST_EN_MASK << PWRKEY_RST_EN_SHIFT,
+				   0);
+		regmap_update_bits(keys->regmap, pmic_rst_reg,
+				   HOMEKEY_RST_EN_MASK << HOMEKEY_RST_EN_SHIFT,
+				   0);
+		break;
+	default:
+		break;
+	}
+}
+
+static irqreturn_t mtk_pmic_keys_irq_handler_thread(int irq, void *data)
+{
+	struct pmic_keys_info *info = data;
+	u32 key_deb, pressed;
+
+	regmap_read(info->keys->regmap, info->regs->deb_reg, &key_deb);
+
+	key_deb &= info->regs->deb_mask;
+
+	pressed = !key_deb;
+
+	input_report_key(info->keys->input_dev, info->keycode, pressed);
+	input_sync(info->keys->input_dev);
+
+	dev_dbg(info->keys->dev, "(%s) key =%d using PMIC\n",
+		 pressed ? "pressed" : "released", info->keycode);
+
+	return IRQ_HANDLED;
+}
+
+static int mtk_pmic_key_setup(struct mtk_pmic_keys *keys,
+		struct pmic_keys_info *info)
+{
+	int ret;
+
+	info->keys = keys;
+
+	ret = regmap_update_bits(keys->regmap, info->regs->intsel_reg,
+				 info->regs->intsel_mask,
+				 info->regs->intsel_mask);
+	if (ret < 0)
+		return ret;
+
+	ret = devm_request_threaded_irq(keys->dev, info->irq, NULL,
+					mtk_pmic_keys_irq_handler_thread,
+					IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
+					"mtk-pmic-keys", info);
+	if (ret) {
+		dev_err(keys->dev, "Failed to request IRQ: %d: %d\n",
+			info->irq, ret);
+		return ret;
+	}
+
+	if (info->wakeup)
+		irq_set_irq_wake(info->irq, 1);
+
+	input_set_capability(keys->input_dev, EV_KEY, info->keycode);
+
+	return 0;
+}
+
+static const struct of_device_id of_pmic_keys_match_tbl[] = {
+	{
+		.compatible = "mediatek,mt6397-keys",
+		.data = &mt6397_regs,
+	}, {
+		.compatible = "mediatek,mt6323-keys",
+		.data = &mt6323_regs,
+	}, {
+		/* sentinel */
+	}
+};
+MODULE_DEVICE_TABLE(of, of_pmic_keys_match_tbl);
+
+static int mtk_pmic_keys_probe(struct platform_device *pdev)
+{
+	int error, index = 0;
+	unsigned int keycount;
+	unsigned int keycodes[PMIC_MAX_KEY_COUNT];
+	unsigned int wakeup_srcs[PMIC_MAX_KEY_COUNT];
+	struct mt6397_chip *pmic_chip = dev_get_drvdata(pdev->dev.parent);
+	struct mtk_pmic_keys *keys;
+	const struct pmic_regs *pmic_regs;
+	struct input_dev *input_dev;
+	const struct of_device_id *of_id =
+		of_match_device(of_pmic_keys_match_tbl, &pdev->dev);
+
+	keys = devm_kzalloc(&pdev->dev, sizeof(*keys), GFP_KERNEL);
+	if (!keys)
+		return -ENOMEM;
+
+	keys->dev = &pdev->dev;
+	keys->regmap = pmic_chip->regmap;
+	pmic_regs = of_id->data;
+
+	keys->input_dev = input_dev = devm_input_allocate_device(keys->dev);
+	if (!input_dev) {
+		dev_err(keys->dev, "input allocate device fail.\n");
+		return -ENOMEM;
+	}
+
+	input_dev->name = "mtk-pmic-keys";
+	input_dev->id.bustype = BUS_HOST;
+	input_dev->id.vendor = 0x0001;
+	input_dev->id.product = 0x0001;
+	input_dev->id.version = 0x0001;
+
+	keycount = device_property_read_u32_array(keys->dev, "linux,keycodes",
+						  NULL, 0);
+	if (keycount > PMIC_MAX_KEY_COUNT) {
+		dev_err(keys->dev, "too many keys defined (%d)\n", keycount);
+		return -EINVAL;
+	}
+
+	error = device_property_read_u32_array(keys->dev, "linux,keycodes",
+					       keycodes, keycount);
+	if (error) {
+		dev_err(keys->dev,
+			"failed to read linux,keycode property: %d\n", error);
+		return error;
+	}
+
+	error = device_property_read_u32_array(keys->dev, "wakeup-source",
+					       wakeup_srcs, keycount);
+	if (error) {
+		dev_err(keys->dev,
+			"failed to read wakeup-source property: %d\n", error);
+		return error;
+	}
+
+	for (index = 0; index < keycount; index++) {
+		keys->keys[index].regs = &pmic_regs->keys_regs[index];
+
+		keys->keys[index].irq = platform_get_irq(pdev, index);
+		if (keys->keys[index].irq < 0)
+			return keys->keys[index].irq;
+
+		keys->keys[index].keycode = keycodes[index];
+
+		if (wakeup_srcs[index])
+			keys->keys[index].wakeup = true;
+
+		error = mtk_pmic_key_setup(keys, &keys->keys[index]);
+		if (error)
+			return error;
+	}
+
+	error = input_register_device(input_dev);
+	if (error) {
+		dev_err(&pdev->dev,
+			"register input device failed (%d)\n", error);
+		return error;
+	}
+
+	long_press_reset_setup(keys, pmic_regs->pmic_rst_reg);
+
+	return 0;
+}
+
+static struct platform_driver pmic_keys_pdrv = {
+	.probe = mtk_pmic_keys_probe,
+	.driver = {
+		   .name = "mtk-pmic-keys",
+		   .of_match_table = of_pmic_keys_match_tbl,
+	},
+};
+
+module_platform_driver(pmic_keys_pdrv);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Chen Zhong <chen.zhong@mediatek.com>");
+MODULE_DESCRIPTION("MTK pmic-keys driver v0.1");
-- 
1.7.9.5
