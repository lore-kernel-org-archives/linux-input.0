From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 5/6] mc13783: add power button support
Date: Thu, 21 Jul 2011 22:00:56 -0700
Message-ID: <20110722050056.GA16040@core.coreip.homeip.net>
References: <1311271463-4356-1-git-send-email-philippe.retornaz@epfl.ch>
 <1311271463-4356-2-git-send-email-philippe.retornaz@epfl.ch>
 <1311271463-4356-3-git-send-email-philippe.retornaz@epfl.ch>
 <1311271463-4356-4-git-send-email-philippe.retornaz@epfl.ch>
 <1311271463-4356-5-git-send-email-philippe.retornaz@epfl.ch>
 <1311271463-4356-6-git-send-email-philippe.retornaz@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44009 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294Ab1GVFBF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Jul 2011 01:01:05 -0400
Received: by iyb12 with SMTP id 12so1562426iyb.19
        for <linux-input@vger.kernel.org>; Thu, 21 Jul 2011 22:01:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1311271463-4356-6-git-send-email-philippe.retornaz@epfl.ch>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Philippe =?iso-8859-1?Q?R=E9tornaz?= <philippe.retornaz@epfl.ch>
Cc: s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org, amit.kucheria@canonical.com, sameo@linux.intel.com, linux-input@vger.kernel.org, broonie@opensource.wolfsonmicro.com, u.kleine-koenig@pengutronix.de

Hi Philippe,

On Thu, Jul 21, 2011 at 08:04:22PM +0200, Philippe R=E9tornaz wrote:
> This adds support for the power-on buttons of MC13783 PMIC.
> This is done using a misc input device.
>=20

Mostly looks good, just a couple of comments below.

> @@ -0,0 +1,288 @@
> +/**
> + * mc13783-pwrbutton.c - MC13783 Power Button Input Driver
> + *

Please drop the file name from comment - if we ever rename the file we
won't have to update it here as well.

> + * Copyright (C) 2011 Philippe R=E9tornaz
> + *
> + * Based on twl4030-pwrbutton driver by:
> + *     Peter De Schrijver <peter.de-schrijver@nokia.com>
> + *     Felipe Balbi <felipe.balbi@nokia.com>
> + *
> + * This file is subject to the terms and conditions of the GNU Gener=
al
> + * Public License. See the file "COPYING" in the main directory of t=
his
> + * archive for more details.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Suite 500, Boston, MA 02110=
-1335  USA
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/input.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/mfd/mc13783.h>
> +#include <linux/sched.h>
> +#include <linux/slab.h>
> +
> +struct mc13783_pwrb {
> +	struct input_dev *pwr;
> +	struct mc13xxx *mc13783;
> +#define MC13783_PWRB_B1_POL_INVERT	(1 << 0)
> +#define MC13783_PWRB_B2_POL_INVERT	(1 << 1)
> +#define MC13783_PWRB_B3_POL_INVERT	(1 << 2)
> +	int flags;
> +	unsigned short keymap[3];
> +};
> +
> +#define MC13783_REG_INTERRUPT_SENSE_1		5
> +#define MC13783_IRQSENSE1_ONOFD1S		(1 << 3)
> +#define MC13783_IRQSENSE1_ONOFD2S		(1 << 4)
> +#define MC13783_IRQSENSE1_ONOFD3S		(1 << 5)
> +
> +#define MC13783_REG_POWER_CONTROL_2		15
> +#define MC13783_POWER_CONTROL_2_ON1BDBNC	4
> +#define MC13783_POWER_CONTROL_2_ON2BDBNC	6
> +#define MC13783_POWER_CONTROL_2_ON3BDBNC	8
> +#define MC13783_POWER_CONTROL_2_ON1BRSTEN	(1 << 1)
> +#define MC13783_POWER_CONTROL_2_ON2BRSTEN	(1 << 2)
> +#define MC13783_POWER_CONTROL_2_ON3BRSTEN	(1 << 3)
> +
> +static irqreturn_t button_irq(int irq, void *_priv)
> +{
> +	struct mc13783_pwrb *priv =3D _priv;
> +	int val;

Please have blank lines between variable declarations and code.

> +	mc13xxx_irq_ack(priv->mc13783, irq);
> +	mc13xxx_reg_read(priv->mc13783, MC13783_REG_INTERRUPT_SENSE_1, &val=
);
> +
> +	switch (irq) {
> +	case MC13783_IRQ_ONOFD1:
> +		val =3D val & MC13783_IRQSENSE1_ONOFD1S ? 1 : 0;
> +		if (priv->flags & MC13783_PWRB_B1_POL_INVERT)
> +			val ^=3D 1;
> +		input_report_key(priv->pwr, priv->keymap[0], val);
> +		break;
> +
> +	case MC13783_IRQ_ONOFD2:
> +		val =3D val & MC13783_IRQSENSE1_ONOFD2S ? 1 : 0;
> +		if (priv->flags & MC13783_PWRB_B2_POL_INVERT)
> +			val ^=3D 1;
> +		input_report_key(priv->pwr, priv->keymap[1], val);
> +		break;
> +
> +	case MC13783_IRQ_ONOFD3:
> +		val =3D val & MC13783_IRQSENSE1_ONOFD3S ? 1 : 0;
> +		if (priv->flags & MC13783_PWRB_B3_POL_INVERT)
> +			val ^=3D 1;
> +		input_report_key(priv->pwr, priv->keymap[2], val);
> +		break;
> +	}
> +
> +	input_sync(priv->pwr);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int __devinit mc13783_pwrbutton_probe(struct platform_device =
*pdev)
> +{
> +	struct mc13xxx_buttons_platform_data *pdata;

const?

> +	struct mc13xxx *mc13783 =3D dev_get_drvdata(pdev->dev.parent);
> +	struct input_dev *pwr;
> +	struct mc13783_pwrb *priv;
> +	int err =3D 0;
> +	int reg =3D 0;
> +
> +	pdata =3D dev_get_platdata(&pdev->dev);
> +	if (pdata =3D=3D NULL) {

	if (!pdata) { ..

> +		dev_err(&pdev->dev, "missing platform data\n");
> +		return -ENODEV;
> +	}
> +
> +	pwr =3D input_allocate_device();
> +	if (!pwr) {
> +		dev_dbg(&pdev->dev, "Can't allocate power button\n");
> +		return -ENOMEM;
> +	}
> +
> +	priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
> +

Unneeded blank line here.

> +	if (!priv) {
> +		err =3D -ENOMEM;
> +		dev_dbg(&pdev->dev, "Can't allocate power button\n");
> +		goto free_input_dev;
> +	}
> +
> +	pwr->evbit[0] =3D BIT_MASK(EV_KEY);

Just use __set_bit() here as well. Also, why this initialization is
separate from the rest of the code initializing input device. I think i=
t
is good practice to keep related pieces together.

> +
> +	reg |=3D (pdata->b1on_flags & 0x3) << MC13783_POWER_CONTROL_2_ON1BD=
BNC;
> +	reg |=3D (pdata->b2on_flags & 0x3) << MC13783_POWER_CONTROL_2_ON2BD=
BNC;
> +	reg |=3D (pdata->b3on_flags & 0x3) << MC13783_POWER_CONTROL_2_ON3BD=
BNC;
> +
> +	priv->pwr =3D pwr;
> +	priv->mc13783 =3D mc13783;
> +
> +	mc13xxx_lock(mc13783);
> +
> +	if (pdata->b1on_flags & MC13783_BUTTON_ENABLE) {
> +		priv->keymap[0] =3D pdata->b1on_key;
> +		if (pdata->b1on_key !=3D KEY_RESERVED)
> +			__set_bit(pdata->b1on_key, pwr->keybit);
> +
> +		if (pdata->b1on_flags & MC13783_BUTTON_POL_INVERT)
> +			priv->flags |=3D MC13783_PWRB_B1_POL_INVERT;
> +
> +		if (pdata->b1on_flags & MC13783_BUTTON_RESET_EN)
> +			reg |=3D MC13783_POWER_CONTROL_2_ON1BRSTEN;
> +
> +		err =3D mc13xxx_irq_request(mc13783, MC13783_IRQ_ONOFD1,
> +					  button_irq, "b1on", priv);
> +

Another unneeded blank line.

> +		if (err) {
> +			mc13xxx_unlock(mc13783);

Why irregular error handling in this case? Just have a separate label
for the unlock statement and jump to it.

> +
> +			dev_dbg(&pdev->dev, "Can't request irq\n");
> +			goto free_priv;
> +		}
> +	}
> +
> +	if (pdata->b2on_flags & MC13783_BUTTON_ENABLE) {
> +		priv->keymap[0] =3D pdata->b2on_key;
> +		if (pdata->b2on_key !=3D KEY_RESERVED)
> +			__set_bit(pdata->b2on_key, pwr->keybit);
> +
> +		if (pdata->b2on_flags & MC13783_BUTTON_POL_INVERT)
> +			priv->flags |=3D MC13783_PWRB_B2_POL_INVERT;
> +
> +		if (pdata->b2on_flags & MC13783_BUTTON_RESET_EN)
> +			reg |=3D MC13783_POWER_CONTROL_2_ON2BRSTEN;
> +
> +		err =3D mc13xxx_irq_request(mc13783, MC13783_IRQ_ONOFD2,
> +					  button_irq, "b2on", priv);
> +
> +		if (err) {
> +			dev_dbg(&pdev->dev, "Can't request irq\n");
> +			goto free_irq_b1;
> +		}
> +	}
> +
> +	if (pdata->b3on_flags & MC13783_BUTTON_ENABLE) {
> +		priv->keymap[0] =3D pdata->b3on_key;
> +		if (pdata->b3on_key !=3D KEY_RESERVED)
> +			__set_bit(pdata->b3on_key, pwr->keybit);
> +
> +		if (pdata->b3on_flags & MC13783_BUTTON_POL_INVERT)
> +			priv->flags |=3D MC13783_PWRB_B3_POL_INVERT;
> +
> +		if (pdata->b3on_flags & MC13783_BUTTON_RESET_EN)
> +			reg |=3D MC13783_POWER_CONTROL_2_ON3BRSTEN;
> +
> +		err =3D mc13xxx_irq_request(mc13783, MC13783_IRQ_ONOFD3,
> +					  button_irq, "b3on", priv);
> +
> +		if (err) {
> +			dev_dbg(&pdev->dev, "Can't request irq: %d\n", err);
> +			goto free_irq_b2;
> +		}
> +	}
> +
> +	mc13xxx_reg_rmw(mc13783, MC13783_REG_POWER_CONTROL_2, 0x3FE, reg);
> +
> +	mc13xxx_unlock(mc13783);
> +
> +	pwr->name =3D "mc13783_pwrbutton";
> +	pwr->phys =3D "mc13783_pwrbutton/input0";
> +	pwr->dev.parent =3D &pdev->dev;
> +
> +	pwr->keycode =3D priv->keymap;
> +	pwr->keycodemax =3D ARRAY_SIZE(priv->keymap);
> +	pwr->keycodesize =3D sizeof(priv->keymap[0]);
> +
> +	err =3D input_register_device(pwr);
> +	if (err) {
> +		dev_dbg(&pdev->dev, "Can't register power button: %d\n", err);
> +		goto free_irq;
> +	}
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	return 0;
> +
> +free_irq:
> +	mc13xxx_lock(mc13783);
> +
> +	if (pdata->b3on_flags & MC13783_BUTTON_ENABLE)
> +		mc13xxx_irq_free(mc13783, MC13783_IRQ_ONOFD3, priv);
> +free_irq_b2:
> +	if (pdata->b2on_flags & MC13783_BUTTON_ENABLE)
> +		mc13xxx_irq_free(mc13783, MC13783_IRQ_ONOFD2, priv);
> +
> +free_irq_b1:
> +	if (pdata->b1on_flags & MC13783_BUTTON_ENABLE)
> +		mc13xxx_irq_free(mc13783, MC13783_IRQ_ONOFD1, priv);
> +
> +	mc13xxx_unlock(mc13783);
> +
> +free_priv:
> +	kfree(priv);
> +
> +free_input_dev:
> +	input_free_device(pwr);
> +
> +	return err;
> +}
> +
> +static int __devexit mc13783_pwrbutton_remove(struct platform_device=
 *pdev)
> +{
> +	struct mc13783_pwrb *priv =3D platform_get_drvdata(pdev);
> +	struct mc13xxx_buttons_platform_data *pdata;

const + entra line.

> +	pdata =3D dev_get_platdata(&pdev->dev);
> +
> +	mc13xxx_lock(priv->mc13783);
> +
> +	if (pdata->b3on_flags & MC13783_BUTTON_ENABLE)
> +		mc13xxx_irq_free(priv->mc13783, MC13783_IRQ_ONOFD3, priv);
> +	if (pdata->b2on_flags & MC13783_BUTTON_ENABLE)
> +		mc13xxx_irq_free(priv->mc13783, MC13783_IRQ_ONOFD2, priv);
> +	if (pdata->b1on_flags & MC13783_BUTTON_ENABLE)
> +		mc13xxx_irq_free(priv->mc13783, MC13783_IRQ_ONOFD1, priv);
> +
> +	mc13xxx_unlock(priv->mc13783);
> +
> +	input_unregister_device(priv->pwr);
> +	kfree(priv);
> +
> +	return 0;
> +}
> +
> +struct platform_driver mc13783_pwrbutton_driver =3D {
> +	.probe		=3D mc13783_pwrbutton_probe,
> +	.remove		=3D __devexit_p(mc13783_pwrbutton_remove),
> +	.driver		=3D {
> +		.name	=3D "mc13783-pwrbutton",
> +		.owner	=3D THIS_MODULE,
> +	},
> +};
> +
> +static int __init mc13783_pwrbutton_init(void)
> +{
> +	return platform_driver_register(&mc13783_pwrbutton_driver);
> +}
> +module_init(mc13783_pwrbutton_init);
> +
> +static void __exit mc13783_pwrbutton_exit(void)
> +{
> +	platform_driver_unregister(&mc13783_pwrbutton_driver);
> +}
> +module_exit(mc13783_pwrbutton_exit);
> +
> +MODULE_ALIAS("platform:mc13783-pwrbutton");
> +MODULE_DESCRIPTION("MC13783 Power Button");
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Philippe Retornaz");
> diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
> index 2867c21..da8d276 100644
> --- a/drivers/mfd/mc13xxx-core.c
> +++ b/drivers/mfd/mc13xxx-core.c
> @@ -776,6 +776,10 @@ err_revision:
>  		mc13xxx_add_subdevice_pdata(mc13xxx, "%s-led",
>  				pdata->leds, sizeof(*pdata->leds));
> =20
> +	if (pdata->buttons)
> +		mc13xxx_add_subdevice_pdata(mc13xxx, "%s-pwrbutton",
> +				pdata->buttons, sizeof(*pdata->buttons));
> +
>  	return 0;
>  }
> =20
> diff --git a/include/linux/mfd/mc13783.h b/include/linux/mfd/mc13783.=
h
> index 3756a30..aa824d0 100644
> --- a/include/linux/mfd/mc13783.h
> +++ b/include/linux/mfd/mc13783.h
> @@ -106,6 +106,7 @@ static inline int mc13783_irq_ack(struct mc13783 =
*mc13783, int irq)
>  #define mc13783_regulator_platform_data mc13xxx_regulator_platform_d=
ata
>  #define mc13783_led_platform_data mc13xxx_led_platform_data
>  #define mc13783_leds_platform_data mc13xxx_leds_platform_data
> +#define mc13783_buttons_platform_data mc13xxx_buttons_platform_data
> =20
>  #define mc13783_platform_data mc13xxx_platform_data
>  #define MC13783_USE_TOUCHSCREEN	MC13XXX_USE_TOUCHSCREEN
> diff --git a/include/linux/mfd/mc13xxx.h b/include/linux/mfd/mc13xxx.=
h
> index cef1497..f24be68 100644
> --- a/include/linux/mfd/mc13xxx.h
> +++ b/include/linux/mfd/mc13xxx.h
> @@ -137,6 +137,22 @@ struct mc13xxx_leds_platform_data {
>  	char tc3_period;
>  };
> =20
> +struct mc13xxx_buttons_platform_data {
> +#define MC13783_BUTTON_DBNC_0MS		0
> +#define MC13783_BUTTON_DBNC_30MS	1
> +#define MC13783_BUTTON_DBNC_150MS	2
> +#define MC13783_BUTTON_DBNC_750MS	3
> +#define MC13783_BUTTON_ENABLE		(1 << 2)
> +#define MC13783_BUTTON_POL_INVERT	(1 << 3)
> +#define MC13783_BUTTON_RESET_EN		(1 << 4)
> +	int b1on_flags;
> +	unsigned short b1on_key;
> +	int b2on_flags;
> +	unsigned short b2on_key;
> +	int b3on_flags;
> +	unsigned short b3on_key;
> +};
> +
>  struct mc13xxx_platform_data {
>  #define MC13XXX_USE_TOUCHSCREEN (1 << 0)
>  #define MC13XXX_USE_CODEC	(1 << 1)
> @@ -146,6 +162,7 @@ struct mc13xxx_platform_data {
> =20
>  	struct mc13xxx_regulator_platform_data regulators;
>  	struct mc13xxx_leds_platform_data *leds;
> +	struct mc13xxx_buttons_platform_data *buttons;
>  };
> =20
>  #endif /* ifndef __LINUX_MFD_MC13XXX_H */
> --=20
> 1.6.3.3
>=20

Otherwise:

	Acked-by: Dmitry Torokhov <dtor@mail.ru>

Please feel free to merge with the rest of the patches.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
