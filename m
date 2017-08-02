From: Chen Zhong <chen.zhong-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 3/4] input: Add MediaTek PMIC keys support
Date: Wed, 2 Aug 2017 21:41:44 +0800
Message-ID: <1501681304.20093.25.camel@mhfsdcap03>
References: <1501643840-21485-1-git-send-email-chen.zhong@mediatek.com>
         <1501643840-21485-4-git-send-email-chen.zhong@mediatek.com>
         <20170802051016.GA19681@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170802051016.GA19681@dtor-ws>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

Thanks for your suggestions. I will fix them in the next version.

On Tue, 2017-08-01 at 22:10 -0700, Dmitry Torokhov wrote:
> Hi Chen,
> 
> On Wed, Aug 02, 2017 at 11:17:19AM +0800, Chen Zhong wrote:
> > This patch add support to handle MediaTek PMIC MT6397/MT6323 key
> > interrupts including pwrkey and homekey, also add setting for
> > long press key shutdown behavior.
> > 
> > Signed-off-by: Chen Zhong <chen.zhong-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > ---
> >  drivers/input/keyboard/mtk-pmic-keys.c |  320 ++++++++++++++++++++++++++++++++
> >  1 file changed, 320 insertions(+)
> >  create mode 100644 drivers/input/keyboard/mtk-pmic-keys.c
> > 
> > diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
> > new file mode 100644
> > index 0000000..0ea7d17
> > --- /dev/null
> > +++ b/drivers/input/keyboard/mtk-pmic-keys.c
> > @@ -0,0 +1,320 @@
> > +/*
> > + * Copyright (C) 2017 MediaTek, Inc.
> > + *
> > + * Author: Chen Zhong <chen.zhong-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
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
> > +#include <linux/ioctl.h>
> 
> Why do you need ioctl.h?

Indeed no need here, this will be deleted.

> 
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
> > +
> > +#define PWRKEY_RST_EN_MASK  0x1
> > +#define PWRKEY_RST_EN_SHIFT  6
> > +#define HOMEKEY_RST_EN_MASK  0x1
> > +#define HOMEKEY_RST_EN_SHIFT  5
> > +#define RST_DU_MASK  0x3
> > +#define RST_DU_SHIFT  8
> 
> Align macro values with tabs please.

I will fix the coding style issues here and below.

> 
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
> > +	u32 hw_irq;
> > +};
> > +
> > +struct mtk_pmic_keys {
> > +	struct input_dev *input_dev;
> > +	struct device *dev;
> > +	struct regmap *regmap;
> > +	struct irq_domain *irq_domain;
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
> > +		RST_DU_MASK << RST_DU_SHIFT,
> > +		long_press_duration << RST_DU_SHIFT);
> 
> Please align arguments with the opening parenthesis.
> 
> 
> > +	regmap_update_bits(keys->regmap, pmic_rst_reg,
> > +		PWRKEY_RST_EN_MASK << PWRKEY_RST_EN_SHIFT,
> > +		PWRKEY_RST_EN_MASK << PWRKEY_RST_EN_SHIFT);
> > +
> > +	ret = of_property_read_u32(keys->dev->of_node,
> > +		"mediatek,long-press-mode", &long_press_mode);
> > +
> > +	if (!ret && long_press_mode == LP_ONEKEY) {
> > +		regmap_update_bits(keys->regmap, pmic_rst_reg,
> > +			HOMEKEY_RST_EN_MASK << HOMEKEY_RST_EN_SHIFT, 0);
> > +	} else if (!ret && long_press_mode == LP_TWOKEY) {
> > +		regmap_update_bits(keys->regmap, pmic_rst_reg,
> > +			HOMEKEY_RST_EN_MASK << HOMEKEY_RST_EN_SHIFT,
> > +			HOMEKEY_RST_EN_MASK << HOMEKEY_RST_EN_SHIFT);
> > +	} else {
> > +		regmap_update_bits(keys->regmap, pmic_rst_reg,
> > +			PWRKEY_RST_EN_MASK << PWRKEY_RST_EN_SHIFT, 0);
> > +		regmap_update_bits(keys->regmap, pmic_rst_reg,
> > +			HOMEKEY_RST_EN_MASK << HOMEKEY_RST_EN_SHIFT, 0);
> > +	}
> 
> 	if (ret)
> 		long_press_mode = LP_DISABLE;
> 
> 	switch (long_press_mode) {
> 	case LP_ONEKEY:
> 		...
> 	case LP_TWOKEY:
> 		...
> 	case LP_DISABLE:
> 	default:
> 		...
> 	};

Got it.

> 
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
> > +	dev_info(info->keys->dev, "[PMICKEYS] (%s) key =%d using PMIC\n",
> > +		pressed ? "pressed" : "released", info->keycode);
> 
> dev_dbg()?
> 
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
> > +			info->regs->intsel_mask, info->regs->intsel_mask);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	info->irq = irq_create_mapping(keys->irq_domain, info->hw_irq);
> > +	if (info->irq <= 0)
> > +		return -EINVAL;
> 
> This is wrong. The leaf driver should not have to create and manage IRQ
> mappings, the core module should do that. In fact, you should pass IRQ
> domain to devm_mfd_add_devices() and it will create mapping for IRQ
> resources automatically.
> 

OK, I will pass IRQ domain to devm_mfd_add_devices() in mfd core driver
and remove the mapping here.

> > +
> > +	ret = devm_request_threaded_irq(keys->dev, info->irq, NULL,
> > +				   mtk_pmic_keys_irq_handler_thread,
> > +				   IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
> > +				   "mtk-pmic-keys", info);
> > +	if (ret) {
> > +		dev_err(keys->dev, "Failed to request IRQ: %d: %d\n",
> > +			info->irq, ret);
> > +		return ret;
> > +	}
> > +
> > +	if (wakeup)
> > +		irq_set_irq_wake(info->irq, 1);
> > +
> > +	__set_bit(info->keycode, keys->input_dev->keybit);
> 
> 	input_set_capability(keys->input_dev, EV_KEY, info->keycode);
> 

Got it.

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
> > +	struct resource *res;
> > +	struct mt6397_chip *pmic_chip = dev_get_drvdata(pdev->dev.parent);
> > +	struct mtk_pmic_keys *keys;
> > +	const struct pmic_regs *pmic_regs;
> > +	struct input_dev *input_dev;
> > +	const struct of_device_id *of_id =
> > +		of_match_device(of_pmic_keys_match_tbl, &pdev->dev);
> > +
> > +	keys = devm_kzalloc(&pdev->dev,
> > +		sizeof(struct mtk_pmic_keys), GFP_KERNEL);
> 
> sizeof(*keys)
> 
> > +	if (!keys)
> > +		return -ENOMEM;
> > +
> > +	keys->dev = &pdev->dev;
> > +	keys->regmap = pmic_chip->regmap;
> > +	keys->irq_domain = pmic_chip->irq_domain;
> > +
> > +	pmic_regs = of_id->data;
> > +	keys->pwrkey.regs = &pmic_regs->pwrkey_regs;
> > +	keys->homekey.regs = &pmic_regs->homekey_regs;
> > +	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> > +	if (!res) {
> > +		dev_err(&pdev->dev, "no IRQ resource\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	keys->pwrkey.hw_irq = res->start;
> > +	keys->homekey.hw_irq = res->end;
> 
> Why not 2 IRQ resources, one for pwrkey and another is for homekey?
> 

I will split them to 2 IRQ resources.

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
> > +
> > +	__set_bit(EV_KEY, input_dev->evbit);
> 
> Not needed.

OK, I wil remove the not needed ones here and below.

> 
> > +
> > +	ret = mtk_pmic_key_setup(keys, "mediatek,pwrkey-code",
> > +		&keys->pwrkey, true);
> > +	if (ret)
> > +		goto out_dispose_irq;
> > +
> > +	ret = mtk_pmic_key_setup(keys, "mediatek,homekey-code",
> > +		&keys->homekey, false);
> > +	if (ret)
> > +		goto out_dispose_irq;
> > +
> > +	ret = input_register_device(input_dev);
> > +	if (ret) {
> > +		dev_err(&pdev->dev,
> > +			"[PMICKEYS] register input device failed (%d)\n", ret);
> > +		input_free_device(input_dev);
> 
> Not needed as device is allocated with devm.
> 
> > +		return ret;
> > +	}
> > +
> > +	input_set_drvdata(input_dev, keys);
> 
> I do not believe you use input_get_drvdata() anywhere.
> 
OK, I will remove this operation.

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
> > +
> > +	input_unregister_device(keys->input_dev);
> 
> Not needed as input device is registered with devm.
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
> > +		   .owner = THIS_MODULE,
> 
> Not needed.
> 
> > +		   .of_match_table = of_pmic_keys_match_tbl,
> > +	},
> > +};
> > +
> > +module_platform_driver(pmic_keys_pdrv);
> > +
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_AUTHOR("Chen Zhong <chen.zhong-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>");
> > +MODULE_DESCRIPTION("MTK pmic-keys driver v0.1");
> > +MODULE_ALIAS("keypad:pmic");
> 
> This is a curious alias. Why is it needed?

It is not needed, will be removed.

> 
> Thanks.
> 


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
