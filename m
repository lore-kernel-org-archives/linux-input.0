From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] mc13783: add power button support
Date: Wed, 2 Jun 2010 00:52:58 -0700
Message-ID: <20100602075257.GJ3713@core.coreip.homeip.net>
References: <1275334140-29339-1-git-send-email-philippe.retornaz@epfl.ch>
 <1275334140-29339-2-git-send-email-philippe.retornaz@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:56054 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753403Ab0FBHxG (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Jun 2010 03:53:06 -0400
Received: by pxi18 with SMTP id 18so2332976pxi.19
        for <linux-input@vger.kernel.org>; Wed, 02 Jun 2010 00:53:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1275334140-29339-2-git-send-email-philippe.retornaz@epfl.ch>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Philippe =?iso-8859-1?Q?R=E9tornaz?= <philippe.retornaz@epfl.ch>
Cc: s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org, sameo@linux.intel.com, linux-input@vger.kernel.org, broonie@opensource.wolfsonmicro.com, u.kleine-koenig@pengutronix.de, ext-jari.vanhala@nokia.com, valentin.longchamp@epfl.ch

Hi Philippe,

On Mon, May 31, 2010 at 09:28:59PM +0200, Philippe R=E9tornaz wrote:
> This adds support for the power-on buttons of MC13783 PMIC.
> This is done using a misc input device.
>=20
> Signed-off-by: Philippe R=E9tornaz <philippe.retornaz@epfl.ch>
> ---
>  drivers/input/misc/Kconfig             |    7 +
>  drivers/input/misc/Makefile            |    1 +
>  drivers/input/misc/mc13783-pwrbutton.c |  301 ++++++++++++++++++++++=
++++++++++
>  drivers/mfd/mc13783-core.c             |    4 +
>  include/linux/mfd/mc13783.h            |   19 ++
>  5 files changed, 332 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/input/misc/mc13783-pwrbutton.c
>=20
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index 23140a3..2d25b16 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -340,4 +340,11 @@ config INPUT_PCAP
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called pcap_keys.
> =20
> +config INPUT_MC13783_ON
> +	tristate "MC13783 ON buttons"
> +	depends on MFD_MC13783
> +	help
> +	  Support the ON buttons of MC13783 PMIC as an input device
> +	  reporting power button status.
> +

To compile this driver as a module...

>  endif
> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefil=
e
> index 7e95a5d..c96311d 100644
> --- a/drivers/input/misc/Makefile
> +++ b/drivers/input/misc/Makefile
> @@ -32,4 +32,5 @@ obj-$(CONFIG_INPUT_WINBOND_CIR)		+=3D winbond-cir.o
>  obj-$(CONFIG_INPUT_WISTRON_BTNS)	+=3D wistron_btns.o
>  obj-$(CONFIG_INPUT_WM831X_ON)		+=3D wm831x-on.o
>  obj-$(CONFIG_INPUT_YEALINK)		+=3D yealink.o
> +obj-$(CONFIG_INPUT_MC13783_ON)		+=3D mc13783-pwrbutton.o

Keep makefile sorted please.

> =20
> diff --git a/drivers/input/misc/mc13783-pwrbutton.c b/drivers/input/m=
isc/mc13783-pwrbutton.c
> new file mode 100644
> index 0000000..61cfcce
> --- /dev/null
> +++ b/drivers/input/misc/mc13783-pwrbutton.c
> @@ -0,0 +1,301 @@
> +/**
> + * mc13783-pwrbutton.c - MC13783 Power Button Input Driver
> + *
> + * Copyright (C) 2010 Philippe R=E9tornaz
> + *
> + * Based on twl4030-pwrbutton driver by:
> + *	Peter De Schrijver <peter.de-schrijver@nokia.com>
> + *	Felipe Balbi <felipe.balbi@nokia.com>
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
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1=
307  USA
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
> +	struct mc13783 *mc13783;
> +#define MC13783_PWRB_B1_EMULATE_CAD	(1 << 0)
> +#define MC13783_PWRB_B2_EMULATE_CAD	(1 << 1)
> +#define MC13783_PWRB_B3_EMULATE_CAD	(1 << 2)
> +#define MC13783_PWRB_B1_POL_INVERT	(1 << 3)
> +#define MC13783_PWRB_B2_POL_INVERT	(1 << 4)
> +#define MC13783_PWRB_B3_POL_INVERT	(1 << 5)
> +	int flags;
> +	unsigned int b1on_key;
> +	unsigned int b2on_key;
> +	unsigned int b3on_key;

Make it:

	unsigned short keymap[3];

and then do

	input->keycode =3D pwrb->keymap;
	input->keycodemax =3D ARRAY_SIZE(pwrb->keymap);
	input->keycodesize =3D sizeof(pwrb->keymap[0]);

so that keys can be remapped from userspace.

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
> +static irqreturn_t b1on_irq(int irq, void *_priv)
> +{
> +	struct mc13783_pwrb *priv =3D _priv;
> +	int val;
> +
> +	mc13783_irq_ack(priv->mc13783, irq);
> +	mc13783_reg_read(priv->mc13783, MC13783_REG_INTERRUPT_SENSE_1, &val=
);
> +
> +	val =3D val & MC13783_IRQSENSE1_ONOFD1S ? 1 : 0;
> +
> +	if (priv->flags & MC13783_PWRB_B1_POL_INVERT)
> +		val ^=3D 1;
> +
> +	if (val && priv->flags & MC13783_PWRB_B1_EMULATE_CAD)
> +		kill_cad_pid(SIGINT, 1);

I do not think that individual input drivers should do this - CAD is
handled by the keyboard driver (drivers/char/keyboard) so it is just a
matter of loading proper keymap for your device.

> +
> +	input_report_key(priv->pwr, priv->b1on_key, val);
> +	input_sync(priv->pwr);
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t b2on_irq(int irq, void *_priv)
> +{
> +	struct mc13783_pwrb *priv =3D _priv;
> +	int val;
> +
> +	mc13783_irq_ack(priv->mc13783, irq);
> +	mc13783_reg_read(priv->mc13783, MC13783_REG_INTERRUPT_SENSE_1, &val=
);
> +
> +	val =3D val & MC13783_IRQSENSE1_ONOFD2S ? 1 : 0;
> +
> +	if (priv->flags & MC13783_PWRB_B2_POL_INVERT)
> +		val ^=3D 1;
> +
> +	if (val && priv->flags & MC13783_PWRB_B2_EMULATE_CAD)
> +		kill_cad_pid(SIGINT, 1);
> +
> +	input_report_key(priv->pwr, priv->b2on_key, val);
> +	input_sync(priv->pwr);
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t b3on_irq(int irq, void *_priv)
> +{
> +	struct mc13783_pwrb *priv =3D _priv;
> +	int val;
> +
> +	mc13783_irq_ack(priv->mc13783, irq);
> +	mc13783_reg_read(priv->mc13783, MC13783_REG_INTERRUPT_SENSE_1, &val=
);
> +
> +	val =3D val & MC13783_IRQSENSE1_ONOFD3S ? 1 : 0;
> +
> +	if (priv->flags & MC13783_PWRB_B3_POL_INVERT)
> +		val ^=3D 1;
> +
> +	if (val && priv->flags & MC13783_PWRB_B3_EMULATE_CAD)
> +		kill_cad_pid(SIGINT, 1);
> +
> +	input_report_key(priv->pwr, priv->b3on_key, val);
> +	input_sync(priv->pwr);
> +	return IRQ_HANDLED;

I am pretty sure these 3 functions can be combined.

> +}
> +
> +static int __devinit mc13783_pwrbutton_probe(struct platform_device =
*pdev)
> +{
> +	struct mc13783_buttons_platform_data *pdata;
> +	struct mc13783 *mc13783 =3D dev_get_drvdata(pdev->dev.parent);
> +	struct input_dev *pwr;
> +	struct mc13783_pwrb *priv;
> +	int err =3D 0;
> +	int reg =3D 0;
> +
> +	pdata =3D dev_get_platdata(&pdev->dev);
> +	if (pdata =3D=3D NULL) {
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
> +	if (!priv) {
> +		dev_dbg(&pdev->dev, "Can't allocate power button\n");
> +		goto free_input_dev;
> +	}
> +
> +	pwr->evbit[0] =3D BIT_MASK(EV_KEY);
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
> +	mc13783_lock(mc13783);
> +
> +	if (pdata->b1on_flags & MC13783_BUTTON_ENABLE) {
> +		priv->b1on_key =3D pdata->b1on_key;
> +		if (pdata->b1on_key !=3D KEY_RESERVED)
> +			pwr->keybit[BIT_WORD(pdata->b1on_key)] |=3D
> +						BIT_MASK(pdata->b1on_key);

Just use __set_bit().

> +
> +		if (pdata->b1on_flags & MC13783_BUTTON_POL_INVERT)
> +			priv->flags |=3D MC13783_PWRB_B1_POL_INVERT;
> +		if (pdata->b1on_flags & MC13783_BUTTON_EMUL_CAD)
> +			priv->flags |=3D MC13783_PWRB_B1_EMULATE_CAD;
> +
> +		if (pdata->b1on_flags & MC13783_BUTTON_RESET_EN)
> +			reg |=3D MC13783_POWER_CONTROL_2_ON1BRSTEN;
> +
> +		mc13783_irq_request(mc13783, MC13783_IRQ_ONOFD1, b1on_irq,
> +							"b1on", priv);

No error handling here?

> +	}
> +
> +	if (pdata->b2on_flags & MC13783_BUTTON_ENABLE) {
> +		priv->b2on_key =3D pdata->b2on_key;
> +		if (pdata->b2on_key !=3D KEY_RESERVED)
> +			pwr->keybit[BIT_WORD(pdata->b2on_key)] |=3D
> +						BIT_MASK(pdata->b2on_key);
> +
> +		if (pdata->b2on_flags & MC13783_BUTTON_POL_INVERT)
> +			priv->flags |=3D MC13783_PWRB_B2_POL_INVERT;
> +		if (pdata->b2on_flags & MC13783_BUTTON_EMUL_CAD)
> +			priv->flags |=3D MC13783_PWRB_B2_EMULATE_CAD;
> +
> +		if (pdata->b2on_flags & MC13783_BUTTON_RESET_EN)
> +			reg |=3D MC13783_POWER_CONTROL_2_ON2BRSTEN;
> +
> +		mc13783_irq_request(mc13783, MC13783_IRQ_ONOFD2, b2on_irq,
> +							"b2on", priv);
> +	}
> +
> +	if (pdata->b3on_flags & MC13783_BUTTON_ENABLE) {
> +		priv->b3on_key =3D pdata->b3on_key;
> +		if (pdata->b3on_key !=3D KEY_RESERVED)
> +			pwr->keybit[BIT_WORD(pdata->b3on_key)] |=3D
> +						BIT_MASK(pdata->b3on_key);
> +
> +		if (pdata->b3on_flags & MC13783_BUTTON_POL_INVERT)
> +			priv->flags |=3D MC13783_PWRB_B3_POL_INVERT;
> +		if (pdata->b3on_flags & MC13783_BUTTON_EMUL_CAD)
> +			priv->flags |=3D MC13783_PWRB_B3_EMULATE_CAD;
> +
> +		if (pdata->b3on_flags & MC13783_BUTTON_RESET_EN)
> +			reg |=3D MC13783_POWER_CONTROL_2_ON3BRSTEN;
> +
> +		mc13783_irq_request(mc13783, MC13783_IRQ_ONOFD3, b3on_irq,
> +							"b3on", priv);
> +	}
> +
> +	mc13783_reg_rmw(mc13783, MC13783_REG_POWER_CONTROL_2, 0x3FE, reg);
> +
> +	mc13783_unlock(mc13783);
> +
> +	pwr->name =3D "mc13783_pwrbutton";
> +	pwr->phys =3D "mc13783_pwrbutton/input0";
> +	pwr->dev.parent =3D &pdev->dev;
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
> +	mc13783_lock(mc13783);
> +	if (pdata->b3on_flags & MC13783_BUTTON_ENABLE)
> +		mc13783_irq_free(mc13783, MC13783_IRQ_ONOFD3, priv);
> +	if (pdata->b2on_flags & MC13783_BUTTON_ENABLE)
> +		mc13783_irq_free(mc13783, MC13783_IRQ_ONOFD2, priv);
> +	if (pdata->b1on_flags & MC13783_BUTTON_ENABLE)
> +		mc13783_irq_free(mc13783, MC13783_IRQ_ONOFD1, priv);
> +	mc13783_unlock(mc13783);
> +
> +	kfree(priv);
> +
> +free_input_dev:
> +	input_free_device(pwr);
> +	return err;
> +}
> +
> +static int __devexit mc13783_pwrbutton_remove(struct platform_device=
 *pdev)
> +{
> +	struct mc13783_pwrb *priv =3D platform_get_drvdata(pdev);
> +	struct mc13783_buttons_platform_data *pdata;
> +	pdata =3D dev_get_platdata(&pdev->dev);
> +
> +	mc13783_lock(priv->mc13783);
> +	if (pdata->b3on_flags & MC13783_BUTTON_ENABLE)
> +		mc13783_irq_free(priv->mc13783, MC13783_IRQ_ONOFD3, priv);
> +	if (pdata->b2on_flags & MC13783_BUTTON_ENABLE)
> +		mc13783_irq_free(priv->mc13783, MC13783_IRQ_ONOFD2, priv);
> +	if (pdata->b1on_flags & MC13783_BUTTON_ENABLE)
> +		mc13783_irq_free(priv->mc13783, MC13783_IRQ_ONOFD1, priv);
> +	mc13783_unlock(priv->mc13783);

Looks like this can be factored into a separate function.

> +
> +	input_unregister_device(priv->pwr);
> +
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
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Philippe Retornaz");
> +
> diff --git a/drivers/mfd/mc13783-core.c b/drivers/mfd/mc13783-core.c
> index fecf38a..fb3e98b 100644
> --- a/drivers/mfd/mc13783-core.c
> +++ b/drivers/mfd/mc13783-core.c
> @@ -683,6 +683,10 @@ err_revision:
>  		mc13783_add_subdevice_pdata(mc13783, "mc13783-led",
>  					pdata->leds, sizeof(*pdata->leds));
> =20
> +	if (pdata->flags & MC13783_USE_BUTTON)
> +		mc13783_add_subdevice_pdata(mc13783, "mc13783-pwrbutton",
> +				pdata->buttons, sizeof(*pdata->buttons));
> +
>  	return 0;
>  }
> =20
> diff --git a/include/linux/mfd/mc13783.h b/include/linux/mfd/mc13783.=
h
> index 4a894f6..66981a5 100644
> --- a/include/linux/mfd/mc13783.h
> +++ b/include/linux/mfd/mc13783.h
> @@ -128,6 +128,23 @@ struct mc13783_leds_platform_data {
>  	char tc3_period;
>  };
> =20
> +struct mc13783_buttons_platform_data {
> +#define MC13783_BUTTON_DBNC_0MS		0
> +#define MC13783_BUTTON_DBNC_30MS	1
> +#define MC13783_BUTTON_DBNC_150MS	2
> +#define MC13783_BUTTON_DBNC_750MS	3
> +#define MC13783_BUTTON_ENABLE		(1 << 2)
> +#define MC13783_BUTTON_POL_INVERT	(1 << 3)
> +#define MC13783_BUTTON_RESET_EN		(1 << 4)
> +#define MC13783_BUTTON_EMUL_CAD		(1 << 5)
> +	int b1on_flags;
> +	unsigned int b1on_key;
> +	int b2on_flags;
> +	unsigned int b2on_key;
> +	int b3on_flags;
> +	unsigned int b3on_key;
> +};
> +
>  /* to be cleaned up */
>  struct regulator_init_data;
> =20
> @@ -145,6 +162,7 @@ struct mc13783_platform_data {
>  	int num_regulators;
>  	struct mc13783_regulator_init_data *regulators;
>  	struct mc13783_leds_platform_data *leds;
> +	struct mc13783_buttons_platform_data *buttons;
> =20
>  #define MC13783_USE_TOUCHSCREEN (1 << 0)
>  #define MC13783_USE_CODEC	(1 << 1)
> @@ -152,6 +170,7 @@ struct mc13783_platform_data {
>  #define MC13783_USE_RTC		(1 << 3)
>  #define MC13783_USE_REGULATOR	(1 << 4)
>  #define MC13783_USE_LED		(1 << 5)
> +#define MC13783_USE_BUTTON	(1 << 6)
>  	unsigned int flags;
>  };
> =20
> --=20
> 1.6.3.3
>=20

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
