Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64EE3EDE5F;
	Wed, 17 Jun 2026 20:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781729870; cv=none; b=mumgqzEhVfampWXWblWQlSw491+I03wBJjDWByHlUurmDCdAKUZYtUh6AjUuJ0Pj4ODxH8d4grt7OA4JN04ij9xHIXa6IL2cwHuexVPcRLaLsyJznr7/jfBxvFstYzIzjCkySkIplPYPUiWTQVl3SwGsq01fkeYfeHTVxdBntCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781729870; c=relaxed/simple;
	bh=BEVtIJyLUKR+9tc1CY0qY/GOb1ZOdaSf/hRc8Pj6lDo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Flf/Zq/g4tKim79qxT+Jb0EGnfpWdkZsxN2iv6yKbhjtdW5m+JPyBKJJTM7rKNxg5hj3kn3d++XFH/fx7XcLqR179D5telRK2pcC5U6PljQ8F3VleySJMVUCFBD0h/gL0osX8X82KcW5ArAB0faRdeDKVUtc2eJrQyQ4KZW9q3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqLxkvem; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqLxkvem"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB501F00A3A;
	Wed, 17 Jun 2026 20:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781729869;
	bh=gdPZZvR9GXX9hrUhKDkutH4iyW9I19nhURknUYn2VxY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gqLxkvem68PhTcNi5f9+aTJYz6zV0DCM3T7k22K6QybsPrbxLOyY29v1f4nF8qGpa
	 2tXkh6785XyPld+kZ0TXxweEsSJErSYinUzdGt1LQ8ivLOe3LCxanTTE+KWfPfO6hx
	 J8TbPUlJSbOwuhUns4xvURlhfkMnV964GB41SEv5ui/2Ktcf0HqHAqxX3D6vhePIE5
	 x+e0MTWLL40DaKZ+B0thSvnRvE1/JmXZat6AkIyPc3ZvWylIyp0pChUU45kL6/Us6F
	 UNKuj8WJ1+z46+Nnt/+YAPk8XU6YS5VzH5iaCeiY6Gk4cFocVJU5iby/1/yFPlN2A+
	 3lHj+GuQEGhQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/10] Input: cap11xx - refactor code for better
 CAP1114 support.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jun Yan" <jerrysteve1101@gmail.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260617150318.753148-8-jerrysteve1101@gmail.com>
References: <20260617150318.753148-1-jerrysteve1101@gmail.com>
 <20260617150318.753148-8-jerrysteve1101@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 20:57:48 +0000
Message-Id: <20260617205748.7EB501F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Bitmask truncation in `cap11xx_led_set` causing silent failure for=
 LEDs >=3D 8.
- [High] Regmap cache staleness due to missing volatile register definition=
 for the dynamic `sensor_input_reg_base`.

Pre-existing issues:
- [High] Buffer overflow and Fortify Source panic when reading `calib_sensi=
tivities` for devices with more than 8 channels.
--

commit 837f207153012dfc0860b6d46ad5d3ae4f7b3004
Author: Jun Yan <jerrysteve1101@gmail.com>

Extend cap11xx_hw_model structure to support CAP1114

This patch extends the cap11xx_hw_model structure to support CAP1114
with different register offsets and hardware characteristics.

> diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/ca=
p11xx.c
> index 1db4a9090705..0f19ee036e78 100644
> --- a/drivers/input/keyboard/cap11xx.c
> +++ b/drivers/input/keyboard/cap11xx.c

[ ... ]

> @@ -211,8 +215,8 @@ static int cap11xx_init_keys(struct cap11xx_priv *pri=
v)
>  	}
> =20
>  	if (!of_property_read_u32_array(node, "microchip,input-threshold",
> -					priv->thresholds, priv->model->num_channels)) {
> +					priv->thresholds, priv->model->num_sensor_thresholds)) {
> -		for (i =3D 0; i < priv->model->num_channels; i++) {
> +		for (i =3D 0; i < priv->model->num_sensor_thresholds; i++) {
>  			if (priv->thresholds[i] > 127) {
>  				dev_err(dev, "Invalid input-threshold value %u\n",
>  					priv->thresholds[i]);

[Severity: High]
This is a pre-existing issue, but looking at cap11xx_init_keys(), could
reading "microchip,calib-sensitivity" overflow the calib_sensitivities array
for devices with more than 8 channels?

In cap11xx_init_keys():

    } else if (!of_property_read_u32_array(node, "microchip,calib-sensitivi=
ty",
                                           priv->calib_sensitivities,
                                           priv->model->num_channels)) {

The calib_sensitivities array is statically allocated to 8 elements in
struct cap11xx_priv. For models with more than 8 channels (like the CAP1114
which has 14), could this cause a buffer overflow into the keycodes array
and trigger a kernel panic if FORTIFY_SOURCE is enabled?

[ ... ]

> @@ -308,7 +314,7 @@ static irqreturn_t cap11xx_thread_func(int irq_num, v=
oid *data)
>  	if (ret < 0)
>  		goto out;
> =20
> -	ret =3D regmap_read(priv->regmap, CAP11XX_REG_SENSOR_INPUT, &status);
> +	ret =3D regmap_read(priv->regmap, priv->model->sensor_input_reg_base, &=
status);
>  	if (ret < 0)
>  		goto out;

[Severity: High]
Will this result in reading stale cached values instead of the actual
hardware state?

The interrupt handler now dynamically reads from sensor_input_reg_base.
However, cap11xx_volatile_reg() still hardcodes CAP11XX_REG_SENSOR_INPUT as
a volatile register.

Since the new dynamic base register (and the subsequent register for devices
with more than 8 channels) is no longer marked volatile, will the regmap
cache return stale data and break input events for these models?

[ ... ]

> @@ -362,7 +368,7 @@ static int cap11xx_led_set(struct led_classdev *cdev,
>  	 * 0 (OFF) and 1 (ON).
>  	 */
>  	return regmap_update_bits(priv->regmap,
> -				  CAP11XX_REG_LED_OUTPUT_CONTROL,
> +				  priv->model->led_output_control_reg_base,
>  				  BIT(led->reg),
>  				  value ? BIT(led->reg) : 0);
>  }

[Severity: High]
Will this bitmask be truncated for LEDs with an index of 8 or higher?

The bitmask passed to regmap_update_bits() is BIT(led->reg). Since models
like CAP1114 support more than 8 LEDs, and the register operations are 8-bi=
t,
BIT(led->reg) will exceed 8 bits for higher-index LEDs.

The initialization code in cap11xx_init_leds() caps the LED clearance mask =
to
8 bits:

    GENMASK(min(num_leds, 8) - 1, 0)

Does cap11xx_led_set() also need an update to handle devices with more than
8 LEDs to avoid silently failing?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617150318.7531=
48-1-jerrysteve1101@gmail.com?part=3D7
