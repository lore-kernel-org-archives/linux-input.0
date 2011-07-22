From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Subject: Re: [PATCH 5/6] mc13783: add power button support
Date: Fri, 22 Jul 2011 09:07:11 +0800
Message-ID: <4E28CD3F.5010006@cn.fujitsu.com>
References: <1311271463-4356-1-git-send-email-philippe.retornaz@epfl.ch> <1311271463-4356-2-git-send-email-philippe.retornaz@epfl.ch> <1311271463-4356-3-git-send-email-philippe.retornaz@epfl.ch> <1311271463-4356-4-git-send-email-philippe.retornaz@epfl.ch> <1311271463-4356-5-git-send-email-philippe.retornaz@epfl.ch> <1311271463-4356-6-git-send-email-philippe.retornaz@epfl.ch>
Reply-To: gaowanlong@cn.fujitsu.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:57422 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752687Ab1GVBIN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Jul 2011 21:08:13 -0400
In-Reply-To: <1311271463-4356-6-git-send-email-philippe.retornaz@epfl.ch>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?UGhpbGlwcGUgUsOpdG9ybmF6?= <philippe.retornaz@epfl.ch>
Cc: s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org, amit.kucheria@canonical.com, dmitry.torokhov@gmail.com, sameo@linux.intel.com, linux-input@vger.kernel.org, broonie@opensource.wolfsonmicro.com, u.kleine-koenig@pengutronix.de

On 07/22/2011 02:04 AM, Philippe R=C3=A9tornaz wrote:
> This adds support for the power-on buttons of MC13783 PMIC.
> This is done using a misc input device.
>
> Signed-off-by: Philippe R=C3=A9tornaz<philippe.retornaz@epfl.ch>
> ---
>   drivers/input/misc/Kconfig             |   10 +
>   drivers/input/misc/Makefile            |    1 +
>   drivers/input/misc/mc13783-pwrbutton.c |  288 +++++++++++++++++++++=
+++++++++++
>   drivers/mfd/mc13xxx-core.c             |    4 +
>   include/linux/mfd/mc13783.h            |    1 +
>   include/linux/mfd/mc13xxx.h            |   17 ++
>   6 files changed, 321 insertions(+), 0 deletions(-)
>   create mode 100644 drivers/input/misc/mc13783-pwrbutton.c
>
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index 45dc6aa..4272658 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -100,6 +100,16 @@ config INPUT_MAX8925_ONKEY
>   	  To compile this driver as a module, choose M here: the module
>   	  will be called max8925_onkey.
>

> +struct mc13783_pwrb {
> +	struct input_dev *pwr;
> +	struct mc13xxx *mc13783;
> +#define MC13783_PWRB_B1_POL_INVERT	(1<<  0)
> +#define MC13783_PWRB_B2_POL_INVERT	(1<<  1)
> +#define MC13783_PWRB_B3_POL_INVERT	(1<<  2)
> +	int flags;
> +	unsigned short keymap[3];
It seems like you just use the keymap[0]?


> +static int __devinit mc13783_pwrbutton_probe(struct platform_device =
*pdev)
> +{
> +	struct mc13xxx_buttons_platform_data *pdata;
> +	struct mc13xxx *mc13783 =3D dev_get_drvdata(pdev->dev.parent);
> +	struct input_dev *pwr;
> +	struct mc13783_pwrb *priv;
> +	int err =3D 0;
> +	int reg =3D 0;
> +
> +	pdata =3D dev_get_platdata(&pdev->dev);
> +	if (pdata =3D=3D NULL) {
why not !pdata ? be consistent with below?


> +static int __devexit mc13783_pwrbutton_remove(struct platform_device=
 *pdev)
> +{
> +	struct mc13783_pwrb *priv =3D platform_get_drvdata(pdev);
> +	struct mc13xxx_buttons_platform_data *pdata;
> +	pdata =3D dev_get_platdata(&pdev->dev);
> +
> +	mc13xxx_lock(priv->mc13783);
> +
> +	if (pdata->b3on_flags&  MC13783_BUTTON_ENABLE)
> +		mc13xxx_irq_free(priv->mc13783, MC13783_IRQ_ONOFD3, priv);
> +	if (pdata->b2on_flags&  MC13783_BUTTON_ENABLE)
> +		mc13xxx_irq_free(priv->mc13783, MC13783_IRQ_ONOFD2, priv);
> +	if (pdata->b1on_flags&  MC13783_BUTTON_ENABLE)
> +		mc13xxx_irq_free(priv->mc13783, MC13783_IRQ_ONOFD1, priv);
> +
> +	mc13xxx_unlock(priv->mc13783);
> +
> +	input_unregister_device(priv->pwr);
> +	kfree(priv);
	platform_set_drvdata(pdev, NULL);
> +
> +	return 0;
> +}
> +
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
