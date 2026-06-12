Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF556357CE0;
	Fri, 12 Jun 2026 07:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781250160; cv=none; b=Goq3NwL7NCUQ3EXYD/9dtbfOXRouHFf1d1p0flxEOUdLLSOOHghSAYx+4zh/sK3SiBr4cwAqqvqt1hh+V3hfzkyd3fHD/PMGaVBOujupwvN+e3mNxMd4WxLNw2kMBqobROoAqAXPMlte/zojvFcND8J0CvMVyrtFF0SqrWkyis0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781250160; c=relaxed/simple;
	bh=rC5snVrxLmY74RcqQSYeqHZgrqf9BYN7q6maKon4Usk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M6TOEIkR/AHwb4vOkayL+57DHSqMxhmxIJxxiO+wuUFgRE6uSqv1iXvXtYgfT2duZyX/xenIOyYAEvZT2UEgCIXZ7PiGYGkqPnPOwhUFk2zvv/Gth3FyPn5eXzM45JP4Y5D4ezx4p+pBOG7MdilCoDu63xv/Z1FM8zUxpw6Low0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDUdB4Tv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDUdB4Tv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C3371F000E9;
	Fri, 12 Jun 2026 07:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781250158;
	bh=nF+bRJ02nQ3oK8NGeBYUMV6zWvY3FVqHC5bvOB//Qu0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NDUdB4Tvfu4bvlXozKHR5V+HpEfd5ME8G+DBhBMKz6yF8196lxdxA9fKjkJgqOEQD
	 9Ki9pjTVC5NYUh04UXIWP00z2SGQTlH2r8twXN8zK8zpL3zkrIWRFzGKAbZrkVV6wB
	 yhu9RMpyghX83LzR1hw0gBOKzyjMd3ol9j5QtaPmRz+RhXo2QxRN3NeuyTW2iedpXF
	 TtMCzMIpA8mNSd3kfSYQWAYtTRAaLaeKfEu1oBZCYG8qJWce68iNDhOwi8vpmc2MWU
	 4zJ+pb6hIwl0E3YlffBEQ1NyM3ypLB6eohxLQa+QsPMJKo2ACquvG2vpvjzUgNtRNt
	 0JbjkPAq+Dyuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 9/9] Input: cap11xx - add support for CAP1114
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jun Yan" <jerrysteve1101@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260612072237.1177304-10-jerrysteve1101@gmail.com>
References: <20260612072237.1177304-10-jerrysteve1101@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 07:42:37 +0000
Message-Id: <20260612074238.4C3371F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Buffer overflow when parsing the 'microchip,calib-sensitivity' dev=
ice tree property for devices with more than 8 channels.
- [Medium] Integer truncation silently drops signal guard configurations fo=
r channels 8-13.
- [Low] Out-of-bounds `GENMASK` generates an 11-bit mask for an 8-bit LED c=
ontrol register.
- [Low] Unnecessary 9th threshold register added to regmap defaults.
--

commit a843fc20f78c2766e479b33ffb3dcd6238d1f3f0
Author: Jun Yan <jerrysteve1101@gmail.com>

Input: cap11xx - add support for CAP1114

CAP1114 is a 14-channel capacitive touch sensor with 11 LED outputs
and hardware reset support. The CAP1114 uses two control registers
for LED output management and requires two button status registers
for touch input state reporting.

> diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/ca=
p11xx.c
> index d45bb231d7a1f..e4da0e26c34a8 100644
> --- a/drivers/input/keyboard/cap11xx.c
> +++ b/drivers/input/keyboard/cap11xx.c
[ ... ]
> @@ -98,6 +105,9 @@ static const struct reg_default cap11xx_reg_defaults[]=
 =3D {
>  	{ CAP11XX_REG_SENSOR_THRESH(3),		0x40 },
>  	{ CAP11XX_REG_SENSOR_THRESH(4),		0x40 },
>  	{ CAP11XX_REG_SENSOR_THRESH(5),		0x40 },
> +	{ CAP11XX_REG_SENSOR_THRESH(6),		0x40 },
> +	{ CAP11XX_REG_SENSOR_THRESH(7),		0x40 },
> +	{ CAP11XX_REG_SENSOR_THRESH(8),		0x40 },

[Severity: Low]
Does this code inadvertently add a 9th threshold register?

Since the indexing is 0-based, an 8-threshold device should only need indic=
es
0 through 7.

Register index 8 appears to map to an unused register.

>  	{ CAP11XX_REG_CONFIG2,			0x40 },
>  };
[ ... ]
> @@ -394,6 +442,14 @@ static int cap11xx_init_leds(struct device *dev,
>  	if (error)
>  		return error;
> =20
> +	if (num_leds > 8) {
> +		error =3D regmap_update_bits(priv->regmap,
> +					   priv->model->led_output_control_reg_base + 1,
> +					   GENMASK(num_leds - 8 - 1, 0), 0);

[Severity: Low]
Can this result in an out-of-bounds mask generation when num_leds > 8?

In cap11xx_init_leds() just prior to this addition, the code calls:

    error =3D regmap_update_bits(priv->regmap,
                   priv->model->led_output_control_reg_base,
                   GENMASK(num_leds - 1, 0), 0);

When num_leds is 11 for the CAP1114 model, this generates an 11-bit mask
to update an 8-bit register.

While the regmap core safely masks this, should the mask be clamped to
min(num_leds, 8) to accurately reflect the hardware register's capacity?

> +		if (error)
> +			return error;
> +	}
[ ... ]
> @@ -572,6 +628,14 @@ static const struct cap11xx_hw_model cap1106_model =
=3D {
>  	.has_repeat_en =3D true,
>  };
> =20
> +static const struct cap11xx_hw_model cap1114_model =3D {
> +	.product_id =3D 0x3a,
> +	.num_channels =3D 14, .num_leds =3D 11, .num_sensor_thresholds =3D 8,

[Severity: High]
Does this code overflow the calib_sensitivities array during initialization?

In struct cap11xx_priv, the array is rigidly sized to 8 elements:

    u32 calib_sensitivities[8];
    u32 keycodes[];

During cap11xx_init_keys(), when parsing "microchip,calib-sensitivity", the
driver reads priv->model->num_channels elements:

    of_property_read_u32_array(node, "microchip,calib-sensitivity",
                               priv->calib_sensitivities,
                               priv->model->num_channels)

With num_channels set to 14, won't this write 14 elements into an 8-element
array, clobbering the adjacent keycodes flexible array member and potential=
ly
causing memory corruption or a kernel panic?


[Severity: Medium]
Will this configuration lead to integer truncation when parsing the
"microchip,signal-guard" property?

In struct cap11xx_priv, the mask is defined as an 8-bit value:

    u8 signal_guard_inputs_mask;

During cap11xx_init_keys(), a loop iterates up to num_channels (14) and shi=
fts
the bits:

    priv->signal_guard_inputs_mask |=3D 0x01 << i;

For channels 8 to 13, won't this bitwise shift exceed the 8-bit variable wi=
dth
and silently truncate to 0?

Even if the CAP1114 doesn't support signal guards, this drops the bitmask f=
or
the upper channels, bypassing the capability check and failing to emit the
intended 'unsupported' warning.

> +	.led_output_control_reg_base =3D CAP1114_REG_LED_OUTPUT_CONTROL1,
> +	.sensor_input_reg_base =3D CAP1114_REG_BUTTON_STATUS1,
> +	.has_grouped_sensors =3D true,
> +};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612072237.1177=
304-1-jerrysteve1101@gmail.com?part=3D9
