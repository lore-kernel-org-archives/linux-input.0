From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/2] input: gpio-keys: Disable hardware on suspend
Date: Mon, 26 Nov 2012 09:05:03 +0000
Message-ID: <20121126090503.GB12782@gmail.com>
References: <1353590617-11466-1-git-send-email-lee.jones@linaro.org>
 <20121125083229.GB21091@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20121125083229.GB21091@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, arnd@arndb.de, linus.walleij@stericsson.com, Jonas Aaberg <jonas.aberg@stericsson.com>, linux-input@vger.kernel.org, Philippe Langlais <philippe.langlais@linaro.org>
List-Id: linux-input@vger.kernel.org

> On Thu, Nov 22, 2012 at 01:23:36PM +0000, Lee Jones wrote:
> > From: Jonas Aaberg <jonas.aberg@stericsson.com>
> >=20
> > Disable hardware if active when suspending if the hw can not
> > wake the system from suspend.
>=20
> How about below instead (needs the other patch I have just sent out)?

Sorry Dmitry, I'm a little confused. What does this mean?

> Input: gpio-keys - disable hardware on suspend
>=20
> From: Jonas Aaberg <jonas.aberg@stericsson.com>
>=20
> Disable hardware if active when suspending if the hw can not
> wake the system from suspend.
>=20
> Signed-off-by: Jonas Aaberg <jonas.aberg@stericsson.com>
> Signed-off-by: Philippe Langlais <philippe.langlais@linaro.org>
> Reviewed-by: Bengt Jonsson <bengt.g.jonsson@stericsson.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/keyboard/gpio_keys.c |   27 ++++++++++++++++++++++----=
-
>  1 file changed, 22 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keybo=
ard/gpio_keys.c
> index c7764ca..79435de 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -803,6 +803,7 @@ static int gpio_keys_remove(struct platform_devic=
e *pdev)
>  static int gpio_keys_suspend(struct device *dev)
>  {
>  	struct gpio_keys_drvdata *ddata =3D dev_get_drvdata(dev);
> +	struct input_dev *input =3D ddata->input;
>  	int i;
> =20
>  	if (device_may_wakeup(dev)) {
> @@ -811,6 +812,11 @@ static int gpio_keys_suspend(struct device *dev)
>  			if (bdata->button->wakeup)
>  				enable_irq_wake(bdata->irq);
>  		}
> +	} else {
> +		mutex_lock(&input->mutex);
> +		if (input->users)
> +			gpio_keys_close(input);
> +		mutex_unlock(&input->mutex);
>  	}
> =20
>  	return 0;
> @@ -819,16 +825,27 @@ static int gpio_keys_suspend(struct device *dev=
)
>  static int gpio_keys_resume(struct device *dev)
>  {
>  	struct gpio_keys_drvdata *ddata =3D dev_get_drvdata(dev);
> +	struct input_dev *input =3D ddata->input;
> +	int error =3D 0;
>  	int i;
> =20
> -	for (i =3D 0; i < ddata->pdata->nbuttons; i++) {
> -		struct gpio_button_data *bdata =3D &ddata->data[i];
> -		if (bdata->button->wakeup && device_may_wakeup(dev))
> -			disable_irq_wake(bdata->irq);
> +	if (device_may_wakeup(dev)) {
> +		for (i =3D 0; i < ddata->pdata->nbuttons; i++) {
> +			struct gpio_button_data *bdata =3D &ddata->data[i];
> +			if (bdata->button->wakeup)
> +				disable_irq_wake(bdata->irq);
> +		}
> +	} else {
> +		mutex_lock(&input->mutex);
> +		if (input->users)
> +			error =3D gpio_keys_open(input);
> +		mutex_unlock(&input->mutex);
>  	}
> =20
> -	gpio_keys_report_state(ddata);
> +	if (error)
> +		return error;
> =20
> +	gpio_keys_report_state(ddata);
>  	return 0;
>  }
>  #endif

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
