From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] Input: rotary_encoder - convert to devm-* api
Date: Sat, 16 Jan 2016 20:43:52 -0800
Message-ID: <20160117044352.GA38485@dtor-ws>
References: <1452890030-23316-1-git-send-email-timo.teras@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33694 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753336AbcAQEn4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 16 Jan 2016 23:43:56 -0500
Received: by mail-pa0-f44.google.com with SMTP id cy9so415876380pac.0
        for <linux-input@vger.kernel.org>; Sat, 16 Jan 2016 20:43:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1452890030-23316-1-git-send-email-timo.teras@iki.fi>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Timo =?iso-8859-1?Q?Ter=E4s?= <timo.teras@iki.fi>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Fri, Jan 15, 2016 at 10:33:48PM +0200, Timo Ter=E4s wrote:
> Use managed resource API for simplifying error paths.
>=20
> Signed-off-by: Timo Ter=E4s <timo.teras@iki.fi>
> ---
>  drivers/input/misc/rotary_encoder.c | 73 ++++++++++-----------------=
----------
>  1 file changed, 20 insertions(+), 53 deletions(-)
>=20
> diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc=
/rotary_encoder.c
> index 8aee719..0f23d32 100644
> --- a/drivers/input/misc/rotary_encoder.c
> +++ b/drivers/input/misc/rotary_encoder.c
> @@ -211,8 +211,8 @@ static struct rotary_encoder_platform_data *rotar=
y_encoder_parse_dt(struct devic
>  	if (!of_id || !np)
>  		return NULL;
> =20
> -	pdata =3D kzalloc(sizeof(struct rotary_encoder_platform_data),
> -			GFP_KERNEL);
> +	pdata =3D devm_kzalloc(dev, sizeof(struct rotary_encoder_platform_d=
ata),
> +			     GFP_KERNEL);
>  	if (!pdata)
>  		return ERR_PTR(-ENOMEM);
> =20
> @@ -277,12 +277,10 @@ static int rotary_encoder_probe(struct platform=
_device *pdev)
>  		}
>  	}
> =20
> -	encoder =3D kzalloc(sizeof(struct rotary_encoder), GFP_KERNEL);
> -	input =3D input_allocate_device();
> -	if (!encoder || !input) {
> -		err =3D -ENOMEM;
> -		goto exit_free_mem;
> -	}
> +	encoder =3D devm_kzalloc(dev, sizeof(struct rotary_encoder), GFP_KE=
RNEL);
> +	input =3D devm_input_allocate_device(dev);
> +	if (!encoder || !input)
> +		return -ENOMEM;
> =20
>  	encoder->input =3D input;
>  	encoder->pdata =3D pdata;
> @@ -301,16 +299,16 @@ static int rotary_encoder_probe(struct platform=
_device *pdev)
>  	}
> =20
>  	/* request the GPIOs */
> -	err =3D gpio_request_one(pdata->gpio_a, GPIOF_IN, dev_name(dev));
> +	err =3D devm_gpio_request_one(dev, pdata->gpio_a, GPIOF_IN, dev_nam=
e(dev));
>  	if (err) {
>  		dev_err(dev, "unable to request GPIO %d\n", pdata->gpio_a);
> -		goto exit_free_mem;
> +		return err;
>  	}
> =20
> -	err =3D gpio_request_one(pdata->gpio_b, GPIOF_IN, dev_name(dev));
> +	err =3D devm_gpio_request_one(dev, pdata->gpio_b, GPIOF_IN, dev_nam=
e(dev));
>  	if (err) {
>  		dev_err(dev, "unable to request GPIO %d\n", pdata->gpio_b);
> -		goto exit_free_gpio_a;
> +		return err;
>  	}
> =20
>  	encoder->irq_a =3D gpio_to_irq(pdata->gpio_a);
> @@ -331,30 +329,29 @@ static int rotary_encoder_probe(struct platform=
_device *pdev)
>  	default:
>  		dev_err(dev, "'%d' is not a valid steps-per-period value\n",
>  			pdata->steps_per_period);
> -		err =3D -EINVAL;
> -		goto exit_free_gpio_b;
> +		return-EINVAL;

It is customary to put a space between return and return value.

>  	}
> =20
> -	err =3D request_irq(encoder->irq_a, handler,
> -			  IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> -			  DRV_NAME, encoder);
> +	err =3D devm_request_irq(dev, encoder->irq_a, handler,
> +			       IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> +			       DRV_NAME, encoder);
>  	if (err) {
>  		dev_err(dev, "unable to request IRQ %d\n", encoder->irq_a);
> -		goto exit_free_gpio_b;
> +		return err;
>  	}
> =20
> -	err =3D request_irq(encoder->irq_b, handler,
> -			  IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> -			  DRV_NAME, encoder);
> +	err =3D devm_request_irq(dev, encoder->irq_b, handler,
> +			       IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> +			       DRV_NAME, encoder);
>  	if (err) {
>  		dev_err(dev, "unable to request IRQ %d\n", encoder->irq_b);
> -		goto exit_free_irq_a;
> +		return err;
>  	}
> =20
>  	err =3D input_register_device(input);
>  	if (err) {
>  		dev_err(dev, "failed to register input device\n");
> -		goto exit_free_irq_b;
> +		return err;
>  	}
> =20
>  	device_init_wakeup(&pdev->dev, pdata->wakeup_source);
> @@ -362,42 +359,12 @@ static int rotary_encoder_probe(struct platform=
_device *pdev)
>  	platform_set_drvdata(pdev, encoder);
> =20
>  	return 0;
> -
> -exit_free_irq_b:
> -	free_irq(encoder->irq_b, encoder);
> -exit_free_irq_a:
> -	free_irq(encoder->irq_a, encoder);
> -exit_free_gpio_b:
> -	gpio_free(pdata->gpio_b);
> -exit_free_gpio_a:
> -	gpio_free(pdata->gpio_a);
> -exit_free_mem:
> -	input_free_device(input);
> -	kfree(encoder);
> -	if (!dev_get_platdata(&pdev->dev))
> -		kfree(pdata);
> -
> -	return err;
>  }
> =20
>  static int rotary_encoder_remove(struct platform_device *pdev)
>  {
> -	struct rotary_encoder *encoder =3D platform_get_drvdata(pdev);
> -	const struct rotary_encoder_platform_data *pdata =3D encoder->pdata=
;
> -
>  	device_init_wakeup(&pdev->dev, false);

I think we can get rid of this as well (most of the drivers do not rese=
t
wakeup capability on unbind, and if this is needed it is better be done
at bus level), so rotary_encoder_remove() can be removed altogether.

> =20
> -	free_irq(encoder->irq_a, encoder);
> -	free_irq(encoder->irq_b, encoder);
> -	gpio_free(pdata->gpio_a);
> -	gpio_free(pdata->gpio_b);
> -
> -	input_unregister_device(encoder->input);
> -	kfree(encoder);
> -
> -	if (!dev_get_platdata(&pdev->dev))
> -		kfree(pdata);
> -
>  	return 0;
>  }

I fixed up the above points and applied.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
