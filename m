From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH V4] input synaptics-rmi4: Bug fixes to ATTN GPIO handling.
Date: Fri, 27 Dec 2013 18:36:12 -0800
Message-ID: <20131228023612.GE14188@core.coreip.homeip.net>
References: <1388194004-32253-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35533 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754613Ab3L1CgQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Dec 2013 21:36:16 -0500
Received: by mail-pa0-f43.google.com with SMTP id bj1so9816422pad.16
        for <linux-input@vger.kernel.org>; Fri, 27 Dec 2013 18:36:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1388194004-32253-1-git-send-email-cheiny@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On Fri, Dec 27, 2013 at 05:26:44PM -0800, Christopher Heiny wrote:
> This patch fixes some bugs in handling of the RMI4 attention line GPI=
O.
>=20
> 1) in enable_sensor(), eliminate the complicated check on ATTN and ju=
st=20
> call process_interrupt_requests().  This will have minimal overhead i=
f ATTN
> is not asserted, and clears the state of the RMI4 device in any case.
>=20
> 2) Correctly free the GPIO in rmi_driver_remove().
>=20
> 3) in rmi_driver_probe()
>     - declare the name of the attention gpio (GPIO_LABEL)
>     - use gpio_request_one() to get the gpio and export it.
>     - simplify (somewhat) conditional gpio acquisition logic and comb=
ine=20
>       with interrupt setup
>=20
> 4) use gpio_is_valid() instead of comparing to 0.
>=20
> Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>

drivers/input/rmi4/rmi_driver.c: In function =E2=80=98rmi_driver_probe=E2=
=80=99:
drivers/input/rmi4/rmi_driver.c:920:8: error: =E2=80=98struct rmi_drive=
r_data=E2=80=99
has no member named =E2=80=98gpio_held=E2=80=99
    data->gpio_held =3D true;

You forgot to include header file changes...

>=20
> ---
>=20
>  drivers/input/rmi4/rmi_driver.c | 64 ++++++++++++++++++++++++-------=
----------
>  1 file changed, 38 insertions(+), 26 deletions(-)
>=20
> diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi=
_driver.c
> index 2ae9af9..766954f 100644
> --- a/drivers/input/rmi4/rmi_driver.c
> +++ b/drivers/input/rmi4/rmi_driver.c
> @@ -140,7 +140,6 @@ static int enable_sensor(struct rmi_device *rmi_d=
ev)
>  	struct rmi_driver_data *data =3D dev_get_drvdata(&rmi_dev->dev);
>  	struct rmi_transport_dev *xport;
>  	int retval =3D 0;
> -	struct rmi_device_platform_data *pdata =3D to_rmi_platform_data(rmi=
_dev);
> =20
>  	if (data->enabled)
>  		return 0;
> @@ -169,11 +168,7 @@ static int enable_sensor(struct rmi_device *rmi_=
dev)
> =20
>  	data->enabled =3D true;
> =20
> -	if (!pdata->level_triggered &&
> -		    gpio_get_value(pdata->attn_gpio) =3D=3D pdata->attn_polarity)
> -		retval =3D process_interrupt_requests(rmi_dev);
> -
> -	return retval;
> +	return process_interrupt_requests(rmi_dev);
>  }
> =20
>  static void rmi_free_function_list(struct rmi_device *rmi_dev)
> @@ -800,13 +795,21 @@ static SIMPLE_DEV_PM_OPS(rmi_driver_pm, rmi_dri=
ver_suspend, rmi_driver_resume);
>  static int rmi_driver_remove(struct device *dev)
>  {
>  	struct rmi_device *rmi_dev =3D to_rmi_device(dev);
> +	const struct rmi_device_platform_data *pdata =3D
> +					to_rmi_platform_data(rmi_dev);
> +	const struct rmi_driver_data *data =3D dev_get_drvdata(&rmi_dev->de=
v);
> =20
>  	disable_sensor(rmi_dev);
>  	rmi_free_function_list(rmi_dev);
> =20
> +	if (gpio_is_valid(pdata->attn_gpio) && data->gpio_held)
> +		gpio_free(pdata->attn_gpio);

You only need to check data->gpio_held here...

> +
>  	return 0;
>  }
> =20
> +static const char GPIO_LABEL[] =3D "attn";
> +

While you are updating paatch could you move it in rmi_driver_probe()
under if (gpio_is_valid()).

By the way, maybe we should have platform supply gpio name or, in its
absence, generate unique gpio name, so that we could have several RMI
devices be present in a box?

That can be a followup patch at a later time.

>  static int rmi_driver_probe(struct device *dev)
>  {
>  	struct rmi_driver *rmi_driver;
> @@ -937,7 +940,9 @@ static int rmi_driver_probe(struct device *dev)
>  		mutex_init(&data->suspend_mutex);
>  	}
> =20
> -	if (pdata->attn_gpio) {
> +	if (gpio_is_valid(pdata->attn_gpio)) {
> +		ulong gpio_flags =3D GPIOF_DIR_IN;
> +
>  		data->irq =3D gpio_to_irq(pdata->attn_gpio);
>  		if (pdata->level_triggered) {
>  			data->irq_flags =3D IRQF_ONESHOT |
> @@ -948,6 +953,32 @@ static int rmi_driver_probe(struct device *dev)
>  				(pdata->attn_polarity =3D=3D RMI_ATTN_ACTIVE_HIGH)
>  				? IRQF_TRIGGER_RISING : IRQF_TRIGGER_FALLING;
>  		}
> +
> +		if (IS_ENABLED(CONFIG_RMI4_DEV))
> +			gpio_flags |=3D GPIOF_EXPORT;
> +		retval =3D gpio_request_one(pdata->attn_gpio, gpio_flags,
> +					  GPIO_LABEL);
> +		if (retval) {
> +			dev_warn(dev, "WARNING: Failed to request ATTN gpio %d, code=3D%d=
=2E\n",
> +				 pdata->attn_gpio, retval);
> +			retval =3D 0;
> +		} else {
> +			dev_info(dev, "Obtained ATTN gpio %d.\n",
> +					pdata->attn_gpio);
> +			data->gpio_held =3D true;
> +			if (IS_ENABLED(CONFIG_RMI4_DEV)) {
> +				retval =3D gpio_export_link(dev,
> +							GPIO_LABEL, pdata->attn_gpio);
> +				if (retval) {
> +					dev_warn(dev,
> +						"WARNING: Failed to symlink ATTN gpio!\n");
> +					retval =3D 0;
> +				} else {
> +					dev_info(dev, "Exported ATTN gpio %d.",
> +						pdata->attn_gpio);
> +				}
> +			}
> +		}
>  	} else

	} else {

>  		data->poll_interval =3D ktime_set(0,
>  			(pdata->poll_interval_ms ? pdata->poll_interval_ms :


Another thing I was wondering - polling support is really unusable for
device in production (battery gets killed) so maybe it should be remove=
d
altogether?

> @@ -958,25 +989,6 @@ static int rmi_driver_probe(struct device *dev)
>  		enable_sensor(rmi_dev);
>  	}
> =20
> -	if (IS_ENABLED(CONFIG_RMI4_DEV) && pdata->attn_gpio) {
> -		retval =3D gpio_export(pdata->attn_gpio, false);
> -		if (retval) {
> -			dev_warn(dev, "WARNING: Failed to export ATTN gpio!\n");
> -			retval =3D 0;
> -		} else {
> -			retval =3D gpio_export_link(dev,
> -						  "attn", pdata->attn_gpio);
> -			if (retval) {
> -				dev_warn(dev,
> -					"WARNING: Failed to symlink ATTN gpio!\n");
> -				retval =3D 0;
> -			} else {
> -				dev_info(dev, "Exported ATTN GPIO %d.",
> -					pdata->attn_gpio);
> -			}
> -		}
> -	}
> -
>  	return 0;
> =20
>   err_free_data:

Thanks!

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
