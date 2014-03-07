From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 4/7] input: misc: Add driver for AXP20x
 Power Enable Key
Date: Fri, 7 Mar 2014 19:18:25 +0100
Message-ID: <20140307181825.GB607@lukather>
References: <1393692352-10839-1-git-send-email-carlo@caione.org>
 <1393692352-10839-5-git-send-email-carlo@caione.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LF/YhktBJmDzOfS4"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBU435CMAKGQE2MNRCKQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1393692352-10839-5-git-send-email-carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-input@vger.kernel.org


--LF/YhktBJmDzOfS4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 01, 2014 at 05:45:49PM +0100, Carlo Caione wrote:
> This patch add support for the Power Enable Key found on MFD AXP202 and
> AXP209. Besides the basic support for the button, the driver adds two
> entries in sysfs to configure the time delay for power on/off.
>=20
> Signed-off-by: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
> ---
>  arch/arm/configs/sunxi_defconfig |   2 +

Again, please provide a separate patch for both sunxi_defconfig and
multi_v7_defconfig.

(This can be the same patches than the one enabling the MFD though)

>  drivers/input/misc/Kconfig       |  11 ++
>  drivers/input/misc/Makefile      |   1 +
>  drivers/input/misc/axp20x-pek.c  | 265 +++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 279 insertions(+)
>  create mode 100644 drivers/input/misc/axp20x-pek.c
>=20
> diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_de=
fconfig
> index f8aa7e6..d59c826 100644
> --- a/arch/arm/configs/sunxi_defconfig
> +++ b/arch/arm/configs/sunxi_defconfig
> @@ -39,6 +39,8 @@ CONFIG_SUN4I_EMAC=3Dy
>  # CONFIG_NET_VENDOR_STMICRO is not set
>  # CONFIG_NET_VENDOR_WIZNET is not set
>  # CONFIG_WLAN is not set
> +CONFIG_INPUT_MISC=3Dy
> +CONFIG_INPUT_AXP20X_PEK=3Dy
>  CONFIG_SERIAL_8250=3Dy
>  CONFIG_SERIAL_8250_CONSOLE=3Dy
>  CONFIG_SERIAL_8250_NR_UARTS=3D8
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index 5f4967d..c9438ac 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -384,6 +384,17 @@ config INPUT_RETU_PWRBUTTON
>  	  To compile this driver as a module, choose M here. The module will
>  	  be called retu-pwrbutton.
> =20
> +config INPUT_AXP20X_PEK
> +	tristate "X-Powers AXP20X power button driver"
> +	depends on MFD_AXP20X
> +	help
> +	  Say Y here if you want to enable power key reporting via the
> +	  AXP20X PMIC.
> +
> +	  To compile this driver as a module, choose M here. The module will
> +	  be called axp20x-pek.
> +
> +
>  config INPUT_TWL4030_PWRBUTTON
>  	tristate "TWL4030 Power button Driver"
>  	depends on TWL4030_CORE
> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
> index 0ebfb6d..41d5403 100644
> --- a/drivers/input/misc/Makefile
> +++ b/drivers/input/misc/Makefile
> @@ -49,6 +49,7 @@ obj-$(CONFIG_INPUT_POWERMATE)		+=3D powermate.o
>  obj-$(CONFIG_INPUT_PWM_BEEPER)		+=3D pwm-beeper.o
>  obj-$(CONFIG_INPUT_RB532_BUTTON)	+=3D rb532_button.o
>  obj-$(CONFIG_INPUT_RETU_PWRBUTTON)	+=3D retu-pwrbutton.o
> +obj-$(CONFIG_INPUT_AXP20X_PEK)		+=3D axp20x-pek.o
>  obj-$(CONFIG_INPUT_GPIO_ROTARY_ENCODER)	+=3D rotary_encoder.o
>  obj-$(CONFIG_INPUT_SGI_BTNS)		+=3D sgi_btns.o
>  obj-$(CONFIG_INPUT_SIRFSOC_ONKEY)	+=3D sirfsoc-onkey.o
> diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp20x-=
pek.c
> new file mode 100644
> index 0000000..799275d
> --- /dev/null
> +++ b/drivers/input/misc/axp20x-pek.c
> @@ -0,0 +1,265 @@
> +/*
> + * axp20x power button driver.
> + *
> + * Copyright (C) 2013 Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
> + *
> + * This file is subject to the terms and conditions of the GNU General
> + * Public License. See the file "COPYING" in the main directory of this
> + * archive for more details.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/errno.h>
> +#include <linux/irq.h>
> +#include <linux/init.h>
> +#include <linux/input.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/axp20x.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +
> +#define AXP20X_PEK_STARTUP_MASK		(0xc0)
> +#define AXP20X_PEK_SHUTDOWN_MASK	(0x03)
> +
> +static const char const *startup_time[] =3D { "128mS", "3S" , "1S", "2S"=
 };
> +static const char const *shutdown_time[] =3D { "4S", "6S" , "8S", "10S" =
};

I guess these are seconds. If so, a lowercase s in needed.

> +
> +struct axp20x_pek {
> +	struct axp20x_dev *axp20x;
> +	struct input_dev *input;
> +	int irq_dbr;
> +	int irq_dbf;
> +};
> +
> +struct axp20x_pek_ext_attr {
> +	const char const **str;
> +	unsigned int mask;
> +};
> +
> +static struct axp20x_pek_ext_attr axp20x_pek_startup_ext_attr =3D {
> +	.str	=3D startup_time,
> +	.mask	=3D AXP20X_PEK_STARTUP_MASK,
> +};
> +
> +static struct axp20x_pek_ext_attr axp20x_pek_shutdown_ext_attr =3D {
> +	.str	=3D shutdown_time,
> +	.mask	=3D AXP20X_PEK_SHUTDOWN_MASK,
> +};
> +
> +static struct axp20x_pek_ext_attr *get_axp_ext_attr(struct device_attrib=
ute *attr)
> +{
> +	return container_of(attr, struct dev_ext_attribute, attr)->var;
> +}
> +
> +ssize_t axp20x_show_ext_attr(struct device *dev, struct device_attribute=
 *attr,
> +			     char *buf)
> +{
> +	struct axp20x_pek *axp20x_pek =3D dev_get_drvdata(dev);
> +	struct axp20x_pek_ext_attr *axp20x_ea =3D get_axp_ext_attr(attr);
> +	unsigned int val;
> +	int ret, i;
> +	int cnt =3D 0;
> +
> +	ret =3D regmap_read(axp20x_pek->axp20x->regmap, AXP20X_PEK_KEY, &val);
> +	if (ret !=3D 0)
> +		return ret;
> +
> +	val &=3D axp20x_ea->mask;
> +	val >>=3D ffs(axp20x_ea->mask) - 1;
> +
> +	for (i =3D 0; i < 4; i++) {
> +		if (val =3D=3D i)
> +			cnt +=3D sprintf(buf + cnt, "[%s] ", axp20x_ea->str[i]);
> +		else
> +			cnt +=3D sprintf(buf + cnt, "%s ", axp20x_ea->str[i]);
> +	}
> +
> +	cnt +=3D sprintf(buf + cnt, "\n");
> +
> +	return cnt;
> +}
> +
> +ssize_t axp20x_store_ext_attr(struct device *dev, struct device_attribut=
e *attr,
> +			      const char *buf, size_t count)
> +{
> +	struct axp20x_pek *axp20x_pek =3D dev_get_drvdata(dev);
> +	struct axp20x_pek_ext_attr *axp20x_ea =3D get_axp_ext_attr(attr);
> +	char val_str[20];
> +	int ret, i;
> +	size_t len;
> +
> +	val_str[sizeof(val_str) - 1] =3D '\0';
> +	strncpy(val_str, buf, sizeof(val_str) - 1);
> +	len =3D strlen(val_str);
> +
> +	if (len && val_str[len - 1] =3D=3D '\n')
> +		val_str[len - 1] =3D '\0';
> +
> +	for (i =3D 0; i < 4; i++) {
> +		if (!strcmp(val_str, axp20x_ea->str[i])) {
> +			ret =3D regmap_update_bits(axp20x_pek->axp20x->regmap,
> +						 AXP20X_PEK_KEY,
> +						 axp20x_ea->mask, i);
> +			if (ret !=3D 0)
> +				return -EINVAL;
> +			return count;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static struct dev_ext_attribute axp20x_dev_attr_startup =3D {
> +	.attr	=3D __ATTR(startup, 0644, axp20x_show_ext_attr, axp20x_store_ext_=
attr),
> +	.var	=3D &axp20x_pek_startup_ext_attr
> +};
> +
> +static struct dev_ext_attribute axp20x_dev_attr_shutdown =3D {
> +	__ATTR(shutdown, 0644, axp20x_show_ext_attr, axp20x_store_ext_attr),
> +	&axp20x_pek_shutdown_ext_attr
> +};
> +
> +static struct attribute *dev_attrs[] =3D {
> +	&axp20x_dev_attr_startup.attr.attr,
> +	&axp20x_dev_attr_shutdown.attr.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group dev_attr_group =3D {
> +	.attrs	=3D dev_attrs,
> +};
> +
> +static const struct attribute_group *dev_attr_groups[] =3D {
> +	&dev_attr_group,
> +	NULL,
> +};
> +
> +static irqreturn_t axp20x_pek_irq(int irq, void *pwr)
> +{
> +	struct input_dev *idev =3D pwr;
> +	struct axp20x_pek *axp20x_pek =3D input_get_drvdata(idev);
> +
> +	if (irq =3D=3D axp20x_pek->irq_dbr)
> +		input_report_key(idev, KEY_POWER, true);
> +	else if (irq =3D=3D axp20x_pek->irq_dbf)
> +		input_report_key(idev, KEY_POWER, false);
> +
> +	input_sync(idev);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int axp20x_pek_probe(struct platform_device *pdev)
> +{
> +	struct axp20x_pek *axp20x_pek;
> +	struct axp20x_dev *axp20x;
> +	struct input_dev *idev;
> +	int error;
> +
> +	axp20x_pek =3D devm_kzalloc(&pdev->dev, sizeof(struct axp20x_pek),
> +				  GFP_KERNEL);
> +	if (!axp20x_pek)
> +		return -ENOMEM;
> +
> +	axp20x_pek->axp20x =3D dev_get_drvdata(pdev->dev.parent);
> +	axp20x =3D axp20x_pek->axp20x;
> +
> +	axp20x_pek->irq_dbr =3D platform_get_irq_byname(pdev, "PEK_DBR");
> +	if (axp20x_pek->irq_dbr < 0) {
> +		dev_err(&pdev->dev, "No IRQ for PEK_DBR, error=3D%d\n",
> +				axp20x_pek->irq_dbr);
> +		return axp20x_pek->irq_dbr;
> +	}
> +	axp20x_pek->irq_dbr =3D regmap_irq_get_virq(axp20x->regmap_irqc,
> +						  axp20x_pek->irq_dbr);
> +
> +	axp20x_pek->irq_dbf =3D platform_get_irq_byname(pdev, "PEK_DBF");
> +	if (axp20x_pek->irq_dbf < 0) {
> +		dev_err(&pdev->dev, "No IRQ for PEK_DBF, error=3D%d\n",
> +				axp20x_pek->irq_dbf);
> +		return axp20x_pek->irq_dbf;
> +	}
> +	axp20x_pek->irq_dbf =3D regmap_irq_get_virq(axp20x->regmap_irqc,
> +						  axp20x_pek->irq_dbf);
> +
> +	axp20x_pek->input =3D devm_input_allocate_device(&pdev->dev);
> +	if (!axp20x_pek->input)
> +		return -ENOMEM;
> +
> +	idev =3D axp20x_pek->input;
> +
> +	idev->name =3D "axp20x-pek";
> +	idev->phys =3D "m1kbd/input2";
> +	idev->dev.parent =3D &pdev->dev;
> +
> +	input_set_capability(idev, EV_KEY, KEY_POWER);
> +
> +	input_set_drvdata(idev, axp20x_pek);
> +
> +	error =3D devm_request_threaded_irq(&pdev->dev, axp20x_pek->irq_dbr,
> +					  NULL, axp20x_pek_irq, 0,
> +					  "axp20x-pek-dbr", idev);
> +	if (error) {
> +		dev_err(axp20x->dev, "Failed to request dbr IRQ#%d: %d\n",
> +			axp20x_pek->irq_dbr, error);
> +
> +		return error;
> +	}
> +
> +	error =3D devm_request_threaded_irq(&pdev->dev, axp20x_pek->irq_dbf,
> +					  NULL, axp20x_pek_irq, 0,
> +					  "axp20x-pek-dbf", idev);
> +	if (error) {
> +		dev_err(axp20x->dev, "Failed to request dbf IRQ#%d: %d\n",
> +			axp20x_pek->irq_dbf, error);
> +		return error;
> +	}
> +
> +	idev->dev.groups =3D dev_attr_groups;
> +	error =3D input_register_device(idev);
> +	if (error) {
> +		dev_err(axp20x->dev, "Can't register input device: %d\n", error);
> +		return error;
> +	}
> +
> +	platform_set_drvdata(pdev, axp20x_pek);
> +
> +	return 0;
> +}
> +
> +static int axp20x_pek_remove(struct platform_device *pdev)
> +{
> +	struct axp20x_pek *axp20x_pek =3D platform_get_drvdata(pdev);
> +
> +	input_unregister_device(axp20x_pek->input);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id axp20x_pek_match[] =3D {
> +	{ .compatible =3D "x-powers,axp20x-pek", },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, axp20x_pek_match);
> +
> +static struct platform_driver axp20x_pek_driver =3D {
> +	.probe		=3D axp20x_pek_probe,
> +	.remove		=3D axp20x_pek_remove,
> +	.driver		=3D {
> +		.name		=3D "axp20x-pek",
> +		.owner		=3D THIS_MODULE,
> +		.of_match_table	=3D axp20x_pek_match,
> +	},
> +};
> +module_platform_driver(axp20x_pek_driver);
> +
> +MODULE_DESCRIPTION("axp20x Power Button");
> +MODULE_AUTHOR("Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>");
> +MODULE_LICENSE("GPL");
> --=20
> 1.8.3.2
>=20

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--LF/YhktBJmDzOfS4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTGg1xAAoJEBx+YmzsjxAgXgEP/2MoOto+aX/wm1RLv5hphuKu
LG5UlMQlkcCw3fvxydaHqygYBBLJl1aPNlyVMR04GGlyDYl+dW+XXjanRkJJgpp5
WM+KRMpXrbju1CvVWWiVKAyslWtdsWhdkQCaxvZ7eaEouWAYcpziob8kFtPvAJ+5
83970luwliAWazpNU5EJ80hECEIGexpcsjCed88NdsE1rxEZywcnHxPid/gCOjxT
L6Lf8tBBOajnpmJiIBTGEXhKPdzZbuo22rP6FMoy/OsRJKC2LlgTEpDC+LuKMT0H
eVy9MCqawtBwOMLcFU4MTLi7ZZzSkpclV8RRp3tKJCm9W+nE6b7su2Yu5E+b5CFA
DNVq2hZq1SjMBhaZAInF5cTEdZoZmOHi4yaizoIfVjCgRCvv7nZDOS5i6Q8cUKt2
N7Hs4JznhWCarmfeHAtE8l4P4X57x+E/MyXlzoDmpxKi4Du+qVM7a97vml9f8Xnl
QZOlsfXfTNShVwbw2h0MhpRfdA7Em+7z70oOZj+Rtsl8FkyXq6X68RcbB/uis5zu
0D2J9uxcE6YYxk0OQVCavudZibif3YDcLWZJsYDi240Wr8CxAduxwqiMYTxR5+HT
vaR+yM54aKkNBAoYVCIR/WYDZaqwUKyOjznAr1/ANpd/kfwArJrbMc04tTHliqei
FubJG5aCqWPuv1BiZ+Ty
=paPc
-----END PGP SIGNATURE-----

--LF/YhktBJmDzOfS4--
