Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDD122B594
	for <linux-input@vger.kernel.org>; Wed, 26 Aug 2026 13:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787751472; cv=none; b=QTlBHcIjQiOkGFa/PfGAKwEDYwu6tL332jQGgLm6/cpNgJhFdnDL49/JYTTuMZjbP2YO4LYe/+KwNGe9/cHwIEG2C+eyxHOIdUrr0+CCsNrEWyVJANj0AZe+KZU0I2Voyqbwil9U7xBLYaUYbVHP5sr6a/DtcFIfTDn3skzYoDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787751472; c=relaxed/simple;
	bh=8IhNq9A+chBcglScBKjfR96qklcEX9N9DHGpDRgafgk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XDLmbNuZWdebAxlBaem6pZUDeNQbvT0h2VrGYQTPRfhlbiNcO+Sb0jERIH4WqRbULeKVPScHsMLTzlwt71xvI/qmlgF7cs6c+FoAF0COI+ir3yF70BCdmWoXulkDLRa/DFhl3zkH2Ktl3fEPZGU+7dOf2q9/onmzgPt4bdwrI9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PlhM7VGw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PlhM7VGw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3B6D1F000E9;
	Wed, 26 Aug 2026 13:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787751471;
	bh=BSsqzIU4oBRu5oZhI7JHhqjIKkjp3ml6ZquTUP4aFhI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PlhM7VGwtLNZIG4HS5TNQuGy9BoyDYgixq9wAo9NUDkkHBy3wM1GaG9QquJhyNLux
	 1PMzaB5dxw0Fez0Eru0xWdnBMshw+O8Y+0OMuXOEOp78ICxtQhaHRtTLoKVMGMlwro
	 IwMKEEQknvDGfQwGKf73l7fQFc1EnyY9ATC+n0316QPT0gd4kneTrEkbwwk/vtS/KL
	 OcIMolm9MsPCTJF+9+8bsUY8vKDbk3dXkfC3Y6jPmkfLI7BT9vPJTdJMxF+P144gzp
	 +wYJU5Y9x06MEV5pfgw73Nd7PfkKWPs695/3wCVmYYzk2KSL/8LacXubc1TU0f2l7M
	 Noe8o09cjlGUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] Input: drv260x: Map ACPI enable GPIO
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maurizio Casciano" <mauriziocasciano7@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260826132211.3341936-3-mauriziocasciano7@gmail.com>
References: <20260826132211.3341936-1-mauriziocasciano7@gmail.com>
 <20260826132211.3341936-3-mauriziocasciano7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 13:37:50 +0000
Message-Id: <20260826133750.F3B6D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] I2C writes in `drv260x_resume()` and error paths of `drv260x_suspe=
nd()` will fail because the enable GPIO is not asserted.
--

commit 3813e86cb3a701e0633edd349e11dd4b241aa914
Author: Maurizio Casciano <mauriziocasciano7@gmail.com>

Input: drv260x: Map ACPI enable GPIO
   =20
Some ACPI DRV2604 devices describe the enable line as the first GPIO
resource in _CRS but provide no _DSD mapping for its function. Add a managed
ACPI GPIO mapping before requesting the optional enable line so these devic=
es
can power their haptic path.

> diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
> index c4fbb10b254e9..b6243ce8157d6 100644
> --- a/drivers/input/misc/drv260x.c
> +++ b/drivers/input/misc/drv260x.c

[ ... ]

> @@ -448,6 +455,14 @@ static int drv260x_probe(struct i2c_client *client)
>  	u32 voltage;
>  	int error;
> =20
> +	if (has_acpi_companion(dev)) {
> +		error =3D devm_acpi_dev_add_driver_gpios(dev,
> +						       drv260x_acpi_gpios);
> +		if (error)
> +			return dev_err_probe(dev, error,
> +					     "Failed to add ACPI GPIO mapping\n");
> +	}
> +
>  	haptics =3D devm_kzalloc(dev, sizeof(*haptics), GFP_KERNEL);
>  	if (!haptics)
>  		return -ENOMEM;

[Severity: High]
This isn't a bug introduced by this patch, but it appears there is a
pre-existing issue in the suspend and resume paths related to the enable GP=
IO.

Looking at drv260x_resume():

drivers/input/misc/drv260x.c:drv260x_resume() {
...
		error =3D regmap_update_bits(haptics->regmap,
					   DRV260X_MODE,
					   DRV260X_STANDBY_MASK, 0);
		if (error) {
			dev_err(dev, "Failed to unset standby mode\n");
			if (haptics->regulator)
				regulator_disable(haptics->regulator);
			return error;
		}

		gpiod_set_value(haptics->enable_gpio, 1);
...
}

Will this I2C transaction fail because it occurs while the chip is still he=
ld
in reset/shutdown by the GPIO? Since the enable GPIO is not asserted until
after the I2C write, and the driver aborts the resume on error, does this
leave the chip permanently disabled?

Additionally, because pulling the enable GPIO low resets all chip registers=
 and
REGCACHE_NONE is used, is the device configuration (calibration, over-drive
voltage, library selection) lost and never restored during resume?

A similar issue appears to exist in the error path of drv260x_suspend():

drivers/input/misc/drv260x.c:drv260x_suspend() {
...
		gpiod_set_value(haptics->enable_gpio, 0);

		if (haptics->regulator) {
			error =3D regulator_disable(haptics->regulator);
			if (error) {
				dev_err(dev, "Failed to disable regulator\n");
				regmap_update_bits(haptics->regmap,
						   DRV260X_MODE,
						   DRV260X_STANDBY_MASK, 0);
				return error;
			}
		}
...
}

Does the error path attempt to communicate with the chip via I2C without
restoring the enable GPIO to 1?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826132211.3341=
936-1-mauriziocasciano7@gmail.com?part=3D2
