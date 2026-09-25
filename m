Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B65479885;
	Fri, 25 Sep 2026 21:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790372038; cv=none; b=n7J/X0QBP+qbjhGFSCJX586OrtXMCsu2nwryTep/K1MOo3eg7jy2ltYFsnCzGN2WclaaQiDsCAymBiS2QvlxoXnMvIpo6b4tp9rKJQLsyUjooX3Cz4ig/Tx4cp95VnjdKMSGKHed8+ylINN3wEsZGGDyvP5+cQTRRlgW7uqdij0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790372038; c=relaxed/simple;
	bh=eFa4AeqTe6f4No/S8RoCwtVxj9jQNhGxKMn3lig4KVc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rsDQ9BGTJvYaBQCuOMXb4Iyq81G9MFNQexra+8Gc9IuqF/b5d09swrndjpvt6JejUyCg8UTBoIogMGJSot7WoTqHv9v/juxiZvAdh4SOsxIBgv9dgExjCOLmSI04tvI5YdYwLJ0+ABZswA+Mmx0nS0Yk/sfBuCnXa0josRLgNWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/xRvm5p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/xRvm5p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C08E1F000FF;
	Fri, 25 Sep 2026 21:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790372036;
	bh=DncvLaXl7l4jX5zGUGP8fOek5nyUaztpmtxGukp/xtk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N/xRvm5po+EN+9H7MLcEyIngh9IpUA6B13w/k9whTqw0KyXafYY3vvOvpWfPXEQGa
	 FnUhn5uwpFR+WDymdgJATpad93qdCgl506hSnAh3IV0OSkJyDIHfYh2bWJnh9NOO7r
	 XcHR0K1OrV0SuJPqP0838kRloeAdALVyqs7laprJfu26Sb1DNR6P1STMlXoHgPAK51
	 WjHUlGWJsIize1FQUOvKPoQFK5VLsp9GTLFQmoCoieCg5/Y7kOdP3FLOOW/fkwf14s
	 XItQs7sh/P5YAYxUF8J5kbaj1FvWmHemN8gEGzWi0maqCTxvTAS4OVzaCslNWZuzGG
	 1vjITBz5pYHBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 4/5] Input: stmfts - support FTS5
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Heidelberg" <david@ixit.cz>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260925-stmfts5-v8-4-0fcf49e2c85f@ixit.cz>
References: <20260925-stmfts5-v8-0-0fcf49e2c85f@ixit.cz>
 <20260925-stmfts5-v8-4-0fcf49e2c85f@ixit.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 21:33:56 +0000
Message-Id: <20260925213356.6C08E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] input: missing ABS_MT_TOOL_TYPE capability breaks stylus/palm re=
porting
- [Medium] input: missing NULL check for i2c_get_match_data() in probe
--

commit 997befb9927821c565f6d2664205f5c6f9c83d19
Author: David Heidelberg <david@ixit.cz>

Input: stmfts - support FTS5

This commit adds FTS5 support to the STMicroelectronics FTS Touchscreen
driver. It introduces a mode-switch GPIO and device-specific ops to handle
FTS4 and FTS5 variations.

> diff --git a/drivers/input/touchscreen/stmfts.c b/drivers/input/touchscre=
en/stmfts.c
> index 1720202d6186b..2b9faeef7e462 100644
> --- a/drivers/input/touchscreen/stmfts.c
> +++ b/drivers/input/touchscreen/stmfts.c
[ ... ]
> @@ -656,6 +882,50 @@ static void stmfts_power_off(void *data)
>  	regulator_bulk_disable(ARRAY_SIZE(stmfts_supplies), sdata->supplies);
>  }
> =20
[ ... ]
> +static int stmfts5_setup_input(struct stmfts_data *sdata)
> +{
> +	struct device *dev =3D &sdata->client->dev;
> +
> +	sdata->mode_switch_gpio =3D devm_gpiod_get_optional(dev, "mode-switch",
> +							  GPIOD_OUT_HIGH);
> +	if (IS_ERR(sdata->mode_switch_gpio))
> +		return dev_err_probe(dev, PTR_ERR(sdata->mode_switch_gpio),
> +				     "Failed to get GPIO 'switch'\n");
> +
> +	/* Set resolution for accurate calibration */
> +	if (!input_abs_get_res(sdata->input, ABS_MT_POSITION_X)) {
> +		input_abs_set_res(sdata->input, ABS_MT_POSITION_X, 10);
> +		input_abs_set_res(sdata->input, ABS_MT_POSITION_Y, 10);
> +	}
> +
> +	input_set_abs_params(sdata->input, ABS_MT_DISTANCE, 0, 255, 0, 0);
> +
> +	/* Enable stylus support if requested */
> +	sdata->stylus_enabled =3D device_property_read_bool(dev, "stylus-enable=
d");
> +
> +	return input_mt_init_slots(sdata->input, STMFTS_MAX_FINGERS,
> +				   INPUT_MT_DIRECT);

[Severity: Medium]
Will this break stylus and palm reporting?

In stmfts5_setup_input(), the driver configures absolute axes but omits cal=
ling
input_set_abs_params() for ABS_MT_TOOL_TYPE.

Later, when stmfts5_report_contact_event() attempts to report MT_TOOL_PEN or
MT_TOOL_PALM using input_mt_report_slot_state(), won't the input core disca=
rd
these tool type events because ABS_MT_TOOL_TYPE is missing from dev->absbit?

> +}
> +
[ ... ]
> @@ -701,6 +971,8 @@ static int stmfts_probe(struct i2c_client *client)
>  	mutex_init(&sdata->mutex);
>  	init_completion(&sdata->cmd_done);
> =20
> +	sdata->ops =3D i2c_get_match_data(client);
> +

[Severity: Medium]
Is it possible for i2c_get_match_data() to return NULL here if the driver is
bound to an I2C device via sysfs using the driver_override attribute?

>  	err =3D devm_regulator_bulk_get_const(dev,
>  					    ARRAY_SIZE(stmfts_supplies),
>  					    stmfts_supplies,
> @@ -728,18 +1000,9 @@ static int stmfts_probe(struct i2c_client *client)
> =20
>  	input_set_abs_params(sdata->input, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
>  	input_set_abs_params(sdata->input, ABS_MT_TOUCH_MINOR, 0, 255, 0, 0);
> -	input_set_abs_params(sdata->input, ABS_MT_ORIENTATION, 0, 255, 0, 0);
>  	input_set_abs_params(sdata->input, ABS_MT_PRESSURE, 0, 255, 0, 0);
> -	input_set_abs_params(sdata->input, ABS_DISTANCE, 0, 255, 0, 0);
> =20
> -	sdata->use_key =3D device_property_read_bool(dev, "touch-key-connected"=
);
> -	if (sdata->use_key) {
> -		input_set_capability(sdata->input, EV_KEY, KEY_MENU);
> -		input_set_capability(sdata->input, EV_KEY, KEY_BACK);
> -	}
> -
> -	err =3D input_mt_init_slots(sdata->input,
> -				  STMFTS_MAX_FINGERS, INPUT_MT_DIRECT);
> +	err =3D sdata->ops->setup_input(sdata);

[Severity: Medium]
If i2c_get_match_data() returned NULL above, will this result in a NULL
pointer dereference?

>  	if (err)
>  		return err;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-stmfts5-v8=
-0-0fcf49e2c85f@ixit.cz?part=3D4
