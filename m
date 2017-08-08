From: Chen Zhong <chen.zhong@mediatek.com>
Subject: Re: [PATCH v2 4/5] input: Add MediaTek PMIC keys support
Date: Tue, 8 Aug 2017 17:22:04 +0800
Message-ID: <1502184124.28466.11.camel@mhfsdcap03>
References: <1502071065-6745-1-git-send-email-chen.zhong@mediatek.com>
         <1502071065-6745-5-git-send-email-chen.zhong@mediatek.com>
         <20170808030318.GC12328@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170808030318.GC12328@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Lee Jones <lee.jones@linaro.org>, Eddie Huang <eddie.huang@mediatek.com>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Jaechul Lee <jcsing.lee@samsung.com>, Jonathan Cameron <jic23@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Beomho Seo <beomho.seo@samsung.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

	Thanks for your suggestions. I'll modify them and send the next version
later.

On Mon, 2017-08-07 at 20:03 -0700, Dmitry Torokhov wrote:
> Hi Chen,
> 
> On Mon, Aug 07, 2017 at 09:57:44AM +0800, Chen Zhong wrote:
> > This patch add support to handle MediaTek PMIC MT6397/MT6323 key
> > interrupts including pwrkey and homekey, also add setting for
> > long press key shutdown behavior.
> > 
> > Signed-off-by: Chen Zhong <chen.zhong@mediatek.com>
> > ---
> >  drivers/input/keyboard/Kconfig         |    9 +
> >  drivers/input/keyboard/Makefile        |    1 +
> >  drivers/input/keyboard/mtk-pmic-keys.c |  331 ++++++++++++++++++++++++++++++++
> >  3 files changed, 341 insertions(+)
> >  create mode 100644 drivers/input/keyboard/mtk-pmic-keys.c
> > 
> > diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
> > index 4c4ab1c..730d9b5 100644
> > --- a/drivers/input/keyboard/Kconfig
> > +++ b/drivers/input/keyboard/Kconfig
> > @@ -756,4 +756,13 @@ config KEYBOARD_BCM
> >  	  To compile this driver as a module, choose M here: the
> >  	  module will be called bcm-keypad.
> >  
> > +config KEYBOARD_MTK_PMIC
> > +	tristate "MediaTek PMIC keys support"
> > +	depends on MFD_MT6397
> > +	help
> > +	  Say Y here if you want to use the pmic keys (pwrkey/homekey).
> > +
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called pmic-keys.
> > +
> >  endif
> > diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
> > index d2338ba..20c0b98 100644
> > --- a/drivers/input/keyboard/Makefile
> > +++ b/drivers/input/keyboard/Makefile
> > @@ -40,6 +40,7 @@ obj-$(CONFIG_KEYBOARD_MATRIX)		+= matrix_keypad.o
> >  obj-$(CONFIG_KEYBOARD_MAX7359)		+= max7359_keypad.o
> >  obj-$(CONFIG_KEYBOARD_MCS)		+= mcs_touchkey.o
> >  obj-$(CONFIG_KEYBOARD_MPR121)		+= mpr121_touchkey.o
> > +obj-$(CONFIG_KEYBOARD_MTK_PMIC) 	+= mtk-pmic-keys.o
> >  obj-$(CONFIG_KEYBOARD_NEWTON)		+= newtonkbd.o
> >  obj-$(CONFIG_KEYBOARD_NOMADIK)		+= nomadik-ske-keypad.o
> >  obj-$(CONFIG_KEYBOARD_NSPIRE)		+= nspire-keypad.o
> > diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
> > new file mode 100644
> > index 0000000..5d1f133
> > --- /dev/null
> > +++ b/drivers/input/keyboard/mtk-pmic-keys.c
> > @@ -0,0 +1,331 @@
> > +/*
> > + * Copyright (C) 2017 MediaTek, Inc.
> > + *
> > + * Author: Chen Zhong <chen.zhong@mediatek.com>
> > + *
> > + * This software is licensed under the terms of the GNU General Public
> > + * License version 2, as published by the Free Software Foundation, and
> > + * may be copied, distributed, and modified under those terms.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/kernel.h>
> > +#include <linux/input.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/kernel.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +#include <linux/regmap.h>
> > +#include <linux/mfd/mt6323/registers.h>
> > +#include <linux/mfd/mt6397/registers.h>
> > +#include <linux/mfd/mt6397/core.h>
> > +#include <linux/slab.h>
> > +#include <linux/irqdomain.h>
> 
> Not needed.

Sorry for that. All not needed parts will be removed.
> 
> > +
> > +#define PWRKEY_RST_EN_MASK	0x1
> > +#define PWRKEY_RST_EN_SHIFT	6
> > +#define HOMEKEY_RST_EN_MASK	0x1
> > +#define HOMEKEY_RST_EN_SHIFT	5
> > +#define RST_DU_MASK		0x3
> > +#define RST_DU_SHIFT		8
> > +
> > +struct pmic_keys_regs {
> > +	u32 deb_reg;
> > +	u32 deb_mask;
> > +	u32 intsel_reg;
> > +	u32 intsel_mask;
> > +};
> > +
> > +#define PMIC_KEYS_REGS(_deb_reg, _deb_mask, _intsel_reg, _intsel_mask)	\
> > +{									\
> > +	.deb_reg		= _deb_reg,				\
> > +	.deb_mask		= _deb_mask,				\
> > +	.intsel_reg		= _intsel_reg,				\
> > +	.intsel_mask		= _intsel_mask,				\
> > +}
> > +
> > +struct pmic_regs {
> > +	const struct pmic_keys_regs pwrkey_regs;
> > +	const struct pmic_keys_regs homekey_regs;
> > +	u32 pmic_rst_reg;
> > +};
> > +
> > +static const struct pmic_regs mt6397_regs = {
> > +	.pwrkey_regs = PMIC_KEYS_REGS(MT6397_CHRSTATUS,
> > +		0x8, MT6397_INT_RSV, 0x10),
> > +	.homekey_regs = PMIC_KEYS_REGS(MT6397_OCSTATUS2,
> > +		0x10, MT6397_INT_RSV, 0x8),
> > +	.pmic_rst_reg = MT6397_TOP_RST_MISC,
> > +};
> > +
> > +static const struct pmic_regs mt6323_regs = {
> > +	.pwrkey_regs = PMIC_KEYS_REGS(MT6323_CHRSTATUS,
> > +		0x2, MT6323_INT_MISC_CON, 0x10),
> > +	.homekey_regs = PMIC_KEYS_REGS(MT6323_CHRSTATUS,
> > +		0x4, MT6323_INT_MISC_CON, 0x8),
> > +	.pmic_rst_reg = MT6323_TOP_RST_MISC,
> > +};
> > +
> > +struct pmic_keys_info {
> > +	struct mtk_pmic_keys *keys;
> > +	const struct pmic_keys_regs *regs;
> > +	int keycode;
> > +	int irq;
> > +};
> > +
> > +struct mtk_pmic_keys {
> > +	struct input_dev *input_dev;
> > +	struct device *dev;
> > +	struct regmap *regmap;
> > +	struct irq_domain *irq_domain;
> 
> Not needed.
> 
> > +	struct pmic_keys_info pwrkey, homekey;
> > +};
> > +
> > +enum long_press_mode {
> > +	LP_DISABLE,
> > +	LP_ONEKEY,
> > +	LP_TWOKEY,
> > +};
> > +
> > +static void long_press_reset_setup(struct mtk_pmic_keys *keys, u32 pmic_rst_reg)
> > +{
> > +	int ret;
> > +	u32 long_press_mode, long_press_duration;
> > +
> > +	ret = of_property_read_u32(keys->dev->of_node,
> > +		"mediatek,long-press-duration", &long_press_duration);
> > +	if (ret)
> > +		long_press_duration = 0;
> > +
> > +	regmap_update_bits(keys->regmap, pmic_rst_reg,
> > +			   RST_DU_MASK << RST_DU_SHIFT,
> > +			   long_press_duration << RST_DU_SHIFT);
> > +
> > +	ret = of_property_read_u32(keys->dev->of_node,
> > +		"mediatek,long-press-mode", &long_press_mode);
> > +	if (ret)
> > +		long_press_mode = LP_DISABLE;
> > +
> > +	switch (long_press_mode) {
> > +	case LP_ONEKEY:
> > +		regmap_update_bits(keys->regmap, pmic_rst_reg,
> > +				   PWRKEY_RST_EN_MASK << PWRKEY_RST_EN_SHIFT,
> > +				   PWRKEY_RST_EN_MASK << PWRKEY_RST_EN_SHIFT);
> > +		regmap_update_bits(keys->regmap, pmic_rst_reg,
> > +				   HOMEKEY_RST_EN_MASK << HOMEKEY_RST_EN_SHIFT,
> > +				   0);
> > +		break;
> > +	case LP_TWOKEY:
> > +		regmap_update_bits(keys->regmap, pmic_rst_reg,
> > +				   PWRKEY_RST_EN_MASK << PWRKEY_RST_EN_SHIFT,
> > +				   PWRKEY_RST_EN_MASK << PWRKEY_RST_EN_SHIFT);
> > +		regmap_update_bits(keys->regmap, pmic_rst_reg,
> > +				   HOMEKEY_RST_EN_MASK << HOMEKEY_RST_EN_SHIFT,
> > +				   HOMEKEY_RST_EN_MASK << HOMEKEY_RST_EN_SHIFT);
> > +		break;
> > +	case LP_DISABLE:
> > +		regmap_update_bits(keys->regmap, pmic_rst_reg,
> > +				   PWRKEY_RST_EN_MASK << PWRKEY_RST_EN_SHIFT,
> > +				   0);
> > +		regmap_update_bits(keys->regmap, pmic_rst_reg,
> > +				   HOMEKEY_RST_EN_MASK << HOMEKEY_RST_EN_SHIFT,
> > +				   0);
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +}
> > +
> > +static irqreturn_t mtk_pmic_keys_irq_handler_thread(int irq, void *data)
> > +{
> > +	struct pmic_keys_info *info = data;
> > +	u32 key_deb, pressed;
> > +
> > +	regmap_read(info->keys->regmap, info->regs->deb_reg, &key_deb);
> > +
> > +	key_deb &= info->regs->deb_mask;
> > +
> > +	pressed = !key_deb;
> > +
> > +	input_report_key(info->keys->input_dev, info->keycode, pressed);
> > +	input_sync(info->keys->input_dev);
> > +
> > +	dev_dbg(info->keys->dev, "[PMICKEYS] (%s) key =%d using PMIC\n",
> > +		 pressed ? "pressed" : "released", info->keycode);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int mtk_pmic_key_setup(struct mtk_pmic_keys *keys,
> > +		const char *propname, struct pmic_keys_info *info, bool wakeup)
> > +{
> > +	int ret;
> > +
> > +	ret = of_property_read_u32(keys->dev->of_node,
> > +		propname, &info->keycode);
> > +	if (ret)
> > +		return 0;
> > +
> > +	if (!info->keycode)
> > +		return 0;
> > +
> > +	info->keys = keys;
> > +
> > +	ret = regmap_update_bits(keys->regmap, info->regs->intsel_reg,
> > +				 info->regs->intsel_mask,
> > +				 info->regs->intsel_mask);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = devm_request_threaded_irq(keys->dev, info->irq, NULL,
> > +					mtk_pmic_keys_irq_handler_thread,
> > +					IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
> > +					"mtk-pmic-keys", info);
> > +	if (ret) {
> > +		dev_err(keys->dev, "Failed to request IRQ: %d: %d\n",
> > +			info->irq, ret);
> > +		return ret;
> > +	}
> > +
> > +	if (wakeup)
> > +		irq_set_irq_wake(info->irq, 1);
> > +
> > +	input_set_capability(keys->input_dev, EV_KEY, info->keycode);
> > +
> > +	return 0;
> > +}
> > +
> > +static void mtk_pmic_keys_dispose_irq(struct mtk_pmic_keys *keys)
> > +{
> > +	if (keys->pwrkey.irq)
> > +		irq_dispose_mapping(keys->pwrkey.irq);
> > +
> > +	if (keys->homekey.irq)
> > +		irq_dispose_mapping(keys->homekey.irq);
> 
> You did not create the mapping, you should not destroy it.

OK.

> 
> > +}
> > +
> > +static const struct of_device_id of_pmic_keys_match_tbl[] = {
> > +	{
> > +		.compatible = "mediatek,mt6397-keys",
> > +		.data = &mt6397_regs,
> > +	}, {
> > +		.compatible = "mediatek,mt6323-keys",
> > +		.data = &mt6323_regs,
> > +	}, {
> > +		/* sentinel */
> > +	}
> > +};
> > +MODULE_DEVICE_TABLE(of, of_pmic_keys_match_tbl);
> > +
> > +static int mtk_pmic_keys_probe(struct platform_device *pdev)
> > +{
> > +	int ret;
> > +	struct resource *res_pwrkey, *res_homekey;
> > +	struct mt6397_chip *pmic_chip = dev_get_drvdata(pdev->dev.parent);
> > +	struct mtk_pmic_keys *keys;
> > +	const struct pmic_regs *pmic_regs;
> > +	struct input_dev *input_dev;
> > +	const struct of_device_id *of_id =
> > +		of_match_device(of_pmic_keys_match_tbl, &pdev->dev);
> > +
> > +	keys = devm_kzalloc(&pdev->dev, sizeof(*keys), GFP_KERNEL);
> > +	if (!keys)
> > +		return -ENOMEM;
> > +
> > +	keys->dev = &pdev->dev;
> > +	keys->regmap = pmic_chip->regmap;
> > +	keys->irq_domain = pmic_chip->irq_domain;
> 
> Not needed.
> 
> > +
> > +	pmic_regs = of_id->data;
> > +	keys->pwrkey.regs = &pmic_regs->pwrkey_regs;
> > +	keys->homekey.regs = &pmic_regs->homekey_regs;
> > +
> > +	res_pwrkey = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> > +	if (!res_pwrkey) {
> > +		dev_err(&pdev->dev, "no IRQ resource\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	keys->pwrkey.irq = res_pwrkey->start;
> > +	if (keys->pwrkey.irq <= 0)
> > +		return -EINVAL;
> 
> Please do
> 
> 	keys->pwrkey.irq = platform_get_irq(pdev, 0);
> 	if (keys->pwrkey.irq < 0)
> 		return keys->pwrkey.irq;
> 

OK, I'll do this way.Thank you.

> > +
> > +	res_homekey = platform_get_resource(pdev, IORESOURCE_IRQ, 1);
> > +	if (!res_homekey) {
> > +		dev_err(&pdev->dev, "no IRQ resource\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	keys->homekey.irq = res_homekey->start;
> > +	if (keys->homekey.irq <= 0)
> > +		return -EINVAL;
> 
> Same as above.
> 
> > +
> > +	keys->input_dev = input_dev = devm_input_allocate_device(keys->dev);
> > +	if (!input_dev) {
> > +		dev_err(&pdev->dev, "[PMICKEYS] input allocate device fail.\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	input_dev->name = "mtk-pmic-keys";
> > +	input_dev->id.bustype = BUS_HOST;
> > +	input_dev->id.vendor = 0x0001;
> > +	input_dev->id.product = 0x0001;
> > +	input_dev->id.version = 0x0001;
> > +	input_dev->dev.parent = &pdev->dev;
> 
> Not needed, devm_input_allocate_device() already does this. 
> 
> > +
> > +	ret = mtk_pmic_key_setup(keys, "mediatek,pwrkey-code",
> > +				 &keys->pwrkey, true);
> > +	if (ret)
> > +		goto out_dispose_irq;
> 
> Can you please call this variable "error" and do
> 
> 	if (error)
> 		return error;
> 

OK, I'll change that naming.

> You are using devm and no longer creating mappings, so you can return
> directly and rely on devm infrastructure to unwind.
> 
> > +
> > +	ret = mtk_pmic_key_setup(keys, "mediatek,homekey-code",
> > +				 &keys->homekey, false);
> > +	if (ret)
> > +		goto out_dispose_irq;
> > +
> > +	ret = input_register_device(input_dev);
> > +	if (ret) {
> > +		dev_err(&pdev->dev,
> > +			"[PMICKEYS] register input device failed (%d)\n", ret);
> 
> No need for [PMICKEYS] prefix, dev_err prints device and driver already.
> 
> > +		return ret;
> > +	}
> > +
> > +	long_press_reset_setup(keys, pmic_regs->pmic_rst_reg);
> > +
> > +	return 0;
> > +
> > +out_dispose_irq:
> > +	mtk_pmic_keys_dispose_irq(keys);
> > +	return ret;
> > +}
> > +
> > +static int mtk_pmic_keys_remove(struct platform_device *pdev)
> > +{
> > +	struct mtk_pmic_keys *keys = platform_get_drvdata(pdev);
> > +
> > +	mtk_pmic_keys_dispose_irq(keys);
> 
> Not needed. The whole function is not needed.
> 
> > +
> > +	return 0;
> > +}
> > +
> > +static struct platform_driver pmic_keys_pdrv = {
> > +	.probe = mtk_pmic_keys_probe,
> > +	.remove = mtk_pmic_keys_remove,
> > +	.driver = {
> > +		   .name = "mtk-pmic-keys",
> > +		   .of_match_table = of_pmic_keys_match_tbl,
> > +	},
> > +};
> > +
> > +module_platform_driver(pmic_keys_pdrv);
> > +
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_AUTHOR("Chen Zhong <chen.zhong@mediatek.com>");
> > +MODULE_DESCRIPTION("MTK pmic-keys driver v0.1");
> > -- 
> > 1.7.9.5
> > 
> 
> Thanks.
> 
