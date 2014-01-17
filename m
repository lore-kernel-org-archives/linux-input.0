From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCHv2 1/3] Input: edt_ft5x06: use devm_* functions where
 appropriate
Date: Thu, 16 Jan 2014 16:28:13 -0800
Message-ID: <20140117002813.GB837@core.coreip.homeip.net>
References: <1389859338-11685-1-git-send-email-LW@KARO-electronics.de>
 <1389859338-11685-2-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:60547 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314AbaAQA2S (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Jan 2014 19:28:18 -0500
Content-Disposition: inline
In-Reply-To: <1389859338-11685-2-git-send-email-LW@KARO-electronics.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: linux-input@vger.kernel.org, Simon Budig <simon.budig@kernelconcepts.de>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Rob Landley <rob@landley.net>, Thierry Reding <thierry.reding@gmail.com>, Grant Likely <grant.likely@linaro.org>, Jonathan Cameron <jic23@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Silvio F <silvio.fricke@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Jingoo Han <jg1.han@samsung.com>, Fugang Duan <B38611@freescale.com>, Sachin Kamat <sachin.kamat@linaro.org>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jan 16, 2014 at 09:02:16AM +0100, Lothar Wa=DFmann wrote:
> Simplify the error path and remove() function by using devm_*
> functions for requesting gpios and irq and allocating the input
> device.
>=20
> Signed-off-by: Lothar Wa=DFmann <LW@KARO-electronics.de>

Applied, thank you.

> ---
>  drivers/input/touchscreen/edt-ft5x06.c |   62 ++++++++++------------=
---------
>  1 files changed, 20 insertions(+), 42 deletions(-)
>=20
> diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/t=
ouchscreen/edt-ft5x06.c
> index af0d68b..acb6b9f 100644
> --- a/drivers/input/touchscreen/edt-ft5x06.c
> +++ b/drivers/input/touchscreen/edt-ft5x06.c
> @@ -623,8 +623,9 @@ static int edt_ft5x06_ts_reset(struct i2c_client =
*client,
> =20
>  	if (gpio_is_valid(reset_pin)) {
>  		/* this pulls reset down, enabling the low active reset */
> -		error =3D gpio_request_one(reset_pin, GPIOF_OUT_INIT_LOW,
> -					 "edt-ft5x06 reset");
> +		error =3D devm_gpio_request_one(&client->dev, reset_pin,
> +					GPIOF_OUT_INIT_LOW,
> +					"edt-ft5x06 reset");
>  		if (error) {
>  			dev_err(&client->dev,
>  				"Failed to request GPIO %d as reset pin, error %d\n",
> @@ -723,7 +724,7 @@ static int edt_ft5x06_ts_probe(struct i2c_client =
*client,
>  		return error;
> =20
>  	if (gpio_is_valid(pdata->irq_pin)) {
> -		error =3D gpio_request_one(pdata->irq_pin,
> +		error =3D devm_gpio_request_one(&client->dev, pdata->irq_pin,
>  					 GPIOF_IN, "edt-ft5x06 irq");
>  		if (error) {
>  			dev_err(&client->dev,
> @@ -734,11 +735,10 @@ static int edt_ft5x06_ts_probe(struct i2c_clien=
t *client,
>  	}
> =20
>  	tsdata =3D kzalloc(sizeof(*tsdata), GFP_KERNEL);
> -	input =3D input_allocate_device();
> -	if (!tsdata || !input) {
> -		dev_err(&client->dev, "failed to allocate driver data.\n");
> -		error =3D -ENOMEM;
> -		goto err_free_mem;
> +	input =3D devm_input_allocate_device(&client->dev);
> +	if (!input) {
> +		dev_err(&client->dev, "failed to allocate input device.\n");
> +		return -ENOMEM;
>  	}
> =20
>  	mutex_init(&tsdata->mutex);
> @@ -749,7 +749,7 @@ static int edt_ft5x06_ts_probe(struct i2c_client =
*client,
>  	error =3D edt_ft5x06_ts_identify(client, tsdata->name, fw_version);
>  	if (error) {
>  		dev_err(&client->dev, "touchscreen probe failed\n");
> -		goto err_free_mem;
> +		return error;
>  	}
> =20
>  	edt_ft5x06_ts_get_defaults(tsdata, pdata);
> @@ -776,27 +776,30 @@ static int edt_ft5x06_ts_probe(struct i2c_clien=
t *client,
>  	error =3D input_mt_init_slots(input, MAX_SUPPORT_POINTS, 0);
>  	if (error) {
>  		dev_err(&client->dev, "Unable to init MT slots.\n");
> -		goto err_free_mem;
> +		return error;
>  	}
> =20
>  	input_set_drvdata(input, tsdata);
>  	i2c_set_clientdata(client, tsdata);
> =20
> -	error =3D request_threaded_irq(client->irq, NULL, edt_ft5x06_ts_isr=
,
> -				     IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> -				     client->name, tsdata);
> +	error =3D devm_request_threaded_irq(&client->dev, client->irq, NULL=
,
> +					edt_ft5x06_ts_isr,
> +					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +					client->name, tsdata);
>  	if (error) {
>  		dev_err(&client->dev, "Unable to request touchscreen IRQ.\n");
> -		goto err_free_mem;
> +		return error;
>  	}
> =20
>  	error =3D sysfs_create_group(&client->dev.kobj, &edt_ft5x06_attr_gr=
oup);
>  	if (error)
> -		goto err_free_irq;
> +		return error;
> =20
>  	error =3D input_register_device(input);
> -	if (error)
> -		goto err_remove_attrs;
> +	if (error) {
> +		sysfs_remove_group(&client->dev.kobj, &edt_ft5x06_attr_group);
> +		return error;
> +	}
> =20
>  	edt_ft5x06_ts_prepare_debugfs(tsdata, dev_driver_string(&client->de=
v));
>  	device_init_wakeup(&client->dev, 1);
> @@ -806,40 +809,15 @@ static int edt_ft5x06_ts_probe(struct i2c_clien=
t *client,
>  		pdata->irq_pin, pdata->reset_pin);
> =20
>  	return 0;
> -
> -err_remove_attrs:
> -	sysfs_remove_group(&client->dev.kobj, &edt_ft5x06_attr_group);
> -err_free_irq:
> -	free_irq(client->irq, tsdata);
> -err_free_mem:
> -	input_free_device(input);
> -	kfree(tsdata);
> -
> -	if (gpio_is_valid(pdata->irq_pin))
> -		gpio_free(pdata->irq_pin);
> -
> -	return error;
>  }
> =20
>  static int edt_ft5x06_ts_remove(struct i2c_client *client)
>  {
> -	const struct edt_ft5x06_platform_data *pdata =3D
> -						dev_get_platdata(&client->dev);
>  	struct edt_ft5x06_ts_data *tsdata =3D i2c_get_clientdata(client);
> =20
>  	edt_ft5x06_ts_teardown_debugfs(tsdata);
>  	sysfs_remove_group(&client->dev.kobj, &edt_ft5x06_attr_group);
> =20
> -	free_irq(client->irq, tsdata);
> -	input_unregister_device(tsdata->input);
> -
> -	if (gpio_is_valid(pdata->irq_pin))
> -		gpio_free(pdata->irq_pin);
> -	if (gpio_is_valid(pdata->reset_pin))
> -		gpio_free(pdata->reset_pin);
> -
> -	kfree(tsdata);
> -
>  	return 0;
>  }
> =20
> --=20
> 1.7.2.5
>=20

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
