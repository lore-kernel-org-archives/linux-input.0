From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 5/6] input: Add MediaTek PMIC keys support
Date: Mon, 23 Oct 2017 22:44:09 -0700
Message-ID: <20171024054409.6qbuzenzymkkjdth@dtor-ws>
References: <1506509048-19032-1-git-send-email-chen.zhong@mediatek.com>
 <1506509048-19032-6-git-send-email-chen.zhong@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1506509048-19032-6-git-send-email-chen.zhong-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chen Zhong <chen.zhong-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Jaechul Lee <jcsing.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rtc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, Sep 27, 2017 at 06:44:07PM +0800, Chen Zhong wrote:
> This patch add support to handle MediaTek PMIC MT6397/MT6323 key
> interrupts including pwrkey and homekey, also add setting for
> long press key shutdown behavior.
> 
> Signed-off-by: Chen Zhong <chen.zhong-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> ---
>  drivers/input/keyboard/Kconfig         |    9 +
>  drivers/input/keyboard/Makefile        |    1 +
>  drivers/input/keyboard/mtk-pmic-keys.c |  341 ++++++++++++++++++++++++++++++++
>  3 files changed, 351 insertions(+)
>  create mode 100644 drivers/input/keyboard/mtk-pmic-keys.c
> 
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
> index 4c4ab1c..bd4e20a 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -756,4 +756,13 @@ config KEYBOARD_BCM
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called bcm-keypad.
>  
> +config KEYBOARD_MTK_PMIC
> +	tristate "MediaTek PMIC keys support"
> +	depends on MFD_MT6397
> +	help
> +	  Say Y here if you want to use the pmic keys (powerkey/homekey).
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called pmic-keys.
> +
>  endif
> diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
> index d2338ba..20c0b98 100644
> --- a/drivers/input/keyboard/Makefile
> +++ b/drivers/input/keyboard/Makefile
> @@ -40,6 +40,7 @@ obj-$(CONFIG_KEYBOARD_MATRIX)		+= matrix_keypad.o
>  obj-$(CONFIG_KEYBOARD_MAX7359)		+= max7359_keypad.o
>  obj-$(CONFIG_KEYBOARD_MCS)		+= mcs_touchkey.o
>  obj-$(CONFIG_KEYBOARD_MPR121)		+= mpr121_touchkey.o
> +obj-$(CONFIG_KEYBOARD_MTK_PMIC) 	+= mtk-pmic-keys.o
>  obj-$(CONFIG_KEYBOARD_NEWTON)		+= newtonkbd.o
>  obj-$(CONFIG_KEYBOARD_NOMADIK)		+= nomadik-ske-keypad.o
>  obj-$(CONFIG_KEYBOARD_NSPIRE)		+= nspire-keypad.o
> diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
> new file mode 100644
> index 0000000..529fd95
> --- /dev/null
> +++ b/drivers/input/keyboard/mtk-pmic-keys.c
> @@ -0,0 +1,341 @@
> +/*
> + * Copyright (C) 2017 MediaTek, Inc.
> + *
> + * Author: Chen Zhong <chen.zhong-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/input.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/kernel.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/mt6323/registers.h>
> +#include <linux/mfd/mt6397/registers.h>
> +#include <linux/mfd/mt6397/core.h>
> +
> +#define MTK_PMIC_PWRKEY_RST_EN_MASK	0x1
> +#define MTK_PMIC_PWRKEY_RST_EN_SHIFT	6
> +#define MTK_PMIC_HOMEKEY_RST_EN_MASK	0x1
> +#define MTK_PMIC_HOMEKEY_RST_EN_SHIFT	5
> +#define MTK_PMIC_RST_DU_MASK		0x3
> +#define MTK_PMIC_RST_DU_SHIFT		8
> +
> +#define MTK_PMIC_PWRKEY_RST		\
> +	(MTK_PMIC_PWRKEY_RST_EN_MASK << MTK_PMIC_PWRKEY_RST_EN_SHIFT)
> +#define MTK_PMIC_HOMEKEY_RST		\
> +	(MTK_PMIC_HOMEKEY_RST_EN_MASK << MTK_PMIC_HOMEKEY_RST_EN_SHIFT)
> +
> +#define MTK_PMIC_PWRKEY_INDEX	0
> +#define MTK_PMIC_HOMEKEY_INDEX	1
> +#define MTK_PMIC_MAX_KEY_COUNT	2
> +
> +struct mtk_pmic_keys_regs {
> +	u32 deb_reg;
> +	u32 deb_mask;
> +	u32 intsel_reg;
> +	u32 intsel_mask;
> +};
> +
> +#define MTK_PMIC_KEYS_REGS(_deb_reg, _deb_mask,		\
> +	_intsel_reg, _intsel_mask)			\
> +{							\
> +	.deb_reg		= _deb_reg,		\
> +	.deb_mask		= _deb_mask,		\
> +	.intsel_reg		= _intsel_reg,		\
> +	.intsel_mask		= _intsel_mask,		\
> +}
> +
> +struct mtk_pmic_regs {
> +	const struct mtk_pmic_keys_regs keys_regs[MTK_PMIC_MAX_KEY_COUNT];
> +	u32 pmic_rst_reg;
> +};
> +
> +static const struct mtk_pmic_regs mt6397_regs = {
> +	.keys_regs[MTK_PMIC_PWRKEY_INDEX] =
> +		MTK_PMIC_KEYS_REGS(MT6397_CHRSTATUS,
> +		0x8, MT6397_INT_RSV, 0x10),
> +	.keys_regs[MTK_PMIC_HOMEKEY_INDEX] =
> +		MTK_PMIC_KEYS_REGS(MT6397_OCSTATUS2,
> +		0x10, MT6397_INT_RSV, 0x8),
> +	.pmic_rst_reg = MT6397_TOP_RST_MISC,
> +};
> +
> +static const struct mtk_pmic_regs mt6323_regs = {
> +	.keys_regs[MTK_PMIC_PWRKEY_INDEX] =
> +		MTK_PMIC_KEYS_REGS(MT6323_CHRSTATUS,
> +		0x2, MT6323_INT_MISC_CON, 0x10),
> +	.keys_regs[MTK_PMIC_HOMEKEY_INDEX] =
> +		MTK_PMIC_KEYS_REGS(MT6323_CHRSTATUS,
> +		0x4, MT6323_INT_MISC_CON, 0x8),
> +	.pmic_rst_reg = MT6323_TOP_RST_MISC,
> +};
> +
> +struct mtk_pmic_keys_info {
> +	struct mtk_pmic_keys *keys;
> +	const struct mtk_pmic_keys_regs *regs;
> +	unsigned int keycode;
> +	int irq;
> +	bool wakeup:1;
> +};
> +
> +struct mtk_pmic_keys {
> +	struct input_dev *input_dev;
> +	struct device *dev;
> +	struct regmap *regmap;
> +	struct mtk_pmic_keys_info keys[MTK_PMIC_MAX_KEY_COUNT];
> +};
> +
> +enum mtk_pmic_keys_lp_mode {
> +	LP_DISABLE,
> +	LP_ONEKEY,
> +	LP_TWOKEY,
> +};
> +
> +static void mtk_pmic_keys_lp_reset_setup(struct mtk_pmic_keys *keys,
> +		u32 pmic_rst_reg)
> +{
> +	int ret;
> +	u32 long_press_mode, long_press_debounce;
> +
> +	ret = of_property_read_u32(keys->dev->of_node,
> +		"power-off-time-sec", &long_press_debounce);
> +	if (ret)
> +		long_press_debounce = 0;
> +
> +	regmap_update_bits(keys->regmap, pmic_rst_reg,
> +			   MTK_PMIC_RST_DU_MASK << MTK_PMIC_RST_DU_SHIFT,
> +			   long_press_debounce << MTK_PMIC_RST_DU_SHIFT);
> +
> +	ret = of_property_read_u32(keys->dev->of_node,
> +		"mediatek,long-press-mode", &long_press_mode);
> +	if (ret)
> +		long_press_mode = LP_DISABLE;
> +
> +	switch (long_press_mode) {
> +	case LP_ONEKEY:
> +		regmap_update_bits(keys->regmap, pmic_rst_reg,
> +				   MTK_PMIC_PWRKEY_RST,
> +				   MTK_PMIC_PWRKEY_RST);
> +		regmap_update_bits(keys->regmap, pmic_rst_reg,
> +				   MTK_PMIC_HOMEKEY_RST,
> +				   0);
> +		break;
> +	case LP_TWOKEY:
> +		regmap_update_bits(keys->regmap, pmic_rst_reg,
> +				   MTK_PMIC_PWRKEY_RST,
> +				   MTK_PMIC_PWRKEY_RST);
> +		regmap_update_bits(keys->regmap, pmic_rst_reg,
> +				   MTK_PMIC_HOMEKEY_RST,
> +				   MTK_PMIC_HOMEKEY_RST);
> +		break;
> +	case LP_DISABLE:
> +		regmap_update_bits(keys->regmap, pmic_rst_reg,
> +				   MTK_PMIC_PWRKEY_RST,
> +				   0);
> +		regmap_update_bits(keys->regmap, pmic_rst_reg,
> +				   MTK_PMIC_HOMEKEY_RST,
> +				   0);
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
> +static irqreturn_t mtk_pmic_keys_irq_handler_thread(int irq, void *data)
> +{
> +	struct mtk_pmic_keys_info *info = data;
> +	u32 key_deb, pressed;
> +
> +	regmap_read(info->keys->regmap, info->regs->deb_reg, &key_deb);
> +
> +	key_deb &= info->regs->deb_mask;
> +
> +	pressed = !key_deb;
> +
> +	input_report_key(info->keys->input_dev, info->keycode, pressed);
> +	input_sync(info->keys->input_dev);
> +
> +	dev_dbg(info->keys->dev, "(%s) key =%d using PMIC\n",
> +		 pressed ? "pressed" : "released", info->keycode);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int mtk_pmic_key_setup(struct mtk_pmic_keys *keys,
> +		struct mtk_pmic_keys_info *info)
> +{
> +	int ret;
> +
> +	info->keys = keys;
> +
> +	ret = regmap_update_bits(keys->regmap, info->regs->intsel_reg,
> +				 info->regs->intsel_mask,
> +				 info->regs->intsel_mask);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = devm_request_threaded_irq(keys->dev, info->irq, NULL,
> +					mtk_pmic_keys_irq_handler_thread,
> +					IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
> +					"mtk-pmic-keys", info);
> +	if (ret) {
> +		dev_err(keys->dev, "Failed to request IRQ: %d: %d\n",
> +			info->irq, ret);
> +		return ret;
> +	}
> +
> +	input_set_capability(keys->input_dev, EV_KEY, info->keycode);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int mtk_pmic_keys_suspend(struct device *dev)

Please use __maybe_unused annotation instead of #ifdef guard.

> +{
> +	struct mtk_pmic_keys *keys = dev_get_drvdata(dev);
> +	int index;
> +
> +	for (index = 0; index < MTK_PMIC_MAX_KEY_COUNT; index++) {
> +		if (keys->keys[index].wakeup)
> +			enable_irq_wake(keys->keys[index].irq);
> +	}
> +
> +	return 0;
> +}
> +
> +static int mtk_pmic_keys_resume(struct device *dev)

__maybe_unused here as well.

> +{
> +	struct mtk_pmic_keys *keys = dev_get_drvdata(dev);
> +	int index;
> +
> +	for (index = 0; index < MTK_PMIC_MAX_KEY_COUNT; index++) {
> +		if (keys->keys[index].wakeup)
> +			disable_irq_wake(keys->keys[index].irq);
> +	}
> +
> +	return 0;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(mtk_pmic_keys_pm_ops, mtk_pmic_keys_suspend,
> +			mtk_pmic_keys_resume);
> +
> +static const struct of_device_id of_mtk_pmic_keys_match_tbl[] = {
> +	{
> +		.compatible = "mediatek,mt6397-keys",
> +		.data = &mt6397_regs,
> +	}, {
> +		.compatible = "mediatek,mt6323-keys",
> +		.data = &mt6323_regs,
> +	}, {
> +		/* sentinel */
> +	}
> +};
> +MODULE_DEVICE_TABLE(of, of_mtk_pmic_keys_match_tbl);
> +
> +static int mtk_pmic_keys_probe(struct platform_device *pdev)
> +{
> +	int error, index = 0;
> +	unsigned int keycount;
> +	struct mt6397_chip *pmic_chip = dev_get_drvdata(pdev->dev.parent);
> +	struct device_node *node = pdev->dev.of_node, *child;
> +	struct mtk_pmic_keys *keys;
> +	const struct mtk_pmic_regs *mtk_pmic_regs;
> +	struct input_dev *input_dev;
> +	const struct of_device_id *of_id =
> +		of_match_device(of_mtk_pmic_keys_match_tbl, &pdev->dev);
> +
> +	keys = devm_kzalloc(&pdev->dev, sizeof(*keys), GFP_KERNEL);
> +	if (!keys)
> +		return -ENOMEM;
> +
> +	keys->dev = &pdev->dev;
> +	keys->regmap = pmic_chip->regmap;
> +	mtk_pmic_regs = of_id->data;
> +
> +	keys->input_dev = input_dev = devm_input_allocate_device(keys->dev);
> +	if (!input_dev) {
> +		dev_err(keys->dev, "input allocate device fail.\n");
> +		return -ENOMEM;
> +	}
> +
> +	input_dev->name = "mtk-pmic-keys";
> +	input_dev->id.bustype = BUS_HOST;
> +	input_dev->id.vendor = 0x0001;
> +	input_dev->id.product = 0x0001;
> +	input_dev->id.version = 0x0001;
> +
> +	keycount = device_get_child_node_count(keys->dev);

Since you are using of_* API everywhere else I'd rather we used
of_get_available_child_count() here.


Once these 2 issues are fixed please feel free to add 

Acked-by: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

I assume it will all go though MFD tree, right?

> +	if (keycount > MTK_PMIC_MAX_KEY_COUNT) {
> +		dev_err(keys->dev, "too many keys defined (%d)\n", keycount);
> +		return -EINVAL;
> +	}
> +
> +	for_each_child_of_node(node, child) {
> +		keys->keys[index].regs = &mtk_pmic_regs->keys_regs[index];
> +
> +		keys->keys[index].irq = platform_get_irq(pdev, index);
> +		if (keys->keys[index].irq < 0)
> +			return keys->keys[index].irq;
> +
> +		error = of_property_read_u32(child,
> +			"linux,keycodes", &keys->keys[index].keycode);
> +		if (error) {
> +			dev_err(keys->dev,
> +				"failed to read key:%d linux,keycode property: %d\n",
> +				index, error);
> +			return error;
> +		}
> +
> +		if (of_property_read_bool(child, "wakeup-source"))
> +			keys->keys[index].wakeup = true;
> +
> +		error = mtk_pmic_key_setup(keys, &keys->keys[index]);
> +		if (error)
> +			return error;
> +
> +		index++;
> +	}
> +
> +	error = input_register_device(input_dev);
> +	if (error) {
> +		dev_err(&pdev->dev,
> +			"register input device failed (%d)\n", error);
> +		return error;
> +	}
> +
> +	mtk_pmic_keys_lp_reset_setup(keys, mtk_pmic_regs->pmic_rst_reg);
> +
> +	platform_set_drvdata(pdev, keys);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver pmic_keys_pdrv = {
> +	.probe = mtk_pmic_keys_probe,
> +	.driver = {
> +		   .name = "mtk-pmic-keys",
> +		   .of_match_table = of_mtk_pmic_keys_match_tbl,
> +		   .pm = &mtk_pmic_keys_pm_ops,
> +	},
> +};
> +
> +module_platform_driver(pmic_keys_pdrv);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Chen Zhong <chen.zhong-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>");
> +MODULE_DESCRIPTION("MTK pmic-keys driver v0.1");
> -- 
> 1.7.9.5
> 

Thanks.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
