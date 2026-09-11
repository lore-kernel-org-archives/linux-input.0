Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEA9346E5E;
	Fri, 11 Sep 2026 08:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789117161; cv=none; b=HVdxI27Xr1z6xpV5Gl0IlVPToM8q+rrcm0aHkHFTR54BMBkXOxgPNivc0XvbHQwD9jGmUuJ2mgJER3GQPl+kfcr627BmEQfsdu1sC0MJGAuMi9kW8M5gsF1AlnFP29Ta7+vW8KGVULLWcNrnhf5KHmem1azoSW7gQEkFNUvWDyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789117161; c=relaxed/simple;
	bh=sviKYOrHUFO4pK1RGGriEtuyXfG56l1EXHpapich3s8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q1CsTdscnauK+a+rC6Vs3eIWQbLYP+rrGTLbLP8GmgPQs/9l9mfLihPgiVaQjq1UZlqzORt7EHDn+0yJa3/sWMHnewNSjEmaPxkd6aqsRA7HvTXXLXUeTKLkvONACrlc+5Q+oFQs4tGII8ce5e8lu5rDP3mYkWVoJQ6kzB+/f4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZFm4KMAP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFm4KMAP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24FB01F00893;
	Fri, 11 Sep 2026 08:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789117159;
	bh=Ys/tUVJvHVGuXu+amQC6wNskaxbwuG9xabRhoc0x7Us=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZFm4KMAP1Wk419lJO/eVyQozlN6zJ2Yq+5Fh6HEMlRsJFyeFwVHg43lzhI4G1h00E
	 +2KhmBlRRCAui8go6m4WHFJslCg3613oOSw26xMpwroiU0c7dhUddKswBVrnR5A9rQ
	 7jAoVD57AJuTcPq0EIZr4osefK4OrgnMma2l0OpFOvl+SxsPSmWBpGwN6lbqfQ6qEN
	 yXwxC4Ra7Gv+CqlyZQWbUWziBdJH76oJVPR/cbHsMhCe0204atLnuo0NlNhVSjNY6M
	 PtenngNj2ZCU7mtqUhjmOb5YOdzrzo4uJD6/zyoLDC/Fbem5SbLiY3Ty69aNsl4YiP
	 l+A4XVTuytcyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 02/10] backlight: add Kinetic KTD3136 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?WcSwxJ7EsFRDQU4gS0FWQUtMSQ==?= <kavakliyigitcan@gmail.com>
Cc: lee@kernel.org, linux-leds@vger.kernel.org, dmitry.torokhov@gmail.com, conor+dt@kernel.org, dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260911-ginkgo-submission-final-v1-2-0e68e63a18d4@gmail.com>
References: <20260911-ginkgo-submission-final-v1-0-0e68e63a18d4@gmail.com>
 <20260911-ginkgo-submission-final-v1-2-0e68e63a18d4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 08:59:18 +0000
Message-Id: <20260911085919.24FB01F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] The 'vin' regulator is enabled during probe but never disabled on =
error paths or during module removal.
- [High] Missing `i2c_set_clientdata()` in probe causes `ktd3136_remove()` =
to silently skip hardware power-off.
- [Medium] Missing lock acquisition in `ktd3136_remove` causes a data race =
with concurrent backlight sysfs updates.
- [Medium] State mismatch leaves backlight physically ON when initial brigh=
tness is 0.
- [Low] Unnecessary and unused `select REGMAP_I2C` in Kconfig.
--

commit 15d6d172969378ae4661195e2320fcd1b4ed08c1
Author: Y=C4=B0=C4=9E=C4=B0TCAN KAVAKLI <kavakliyigitcan@gmail.com>

backlight: add Kinetic KTD3136 driver

This commit implements a generic Linux backlight driver for the Kinetic
Technologies KTD3136 36V, 6-channel LED driver. It uses the standard
backlight class interface over I2C.

> diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kc=
onfig
> index dbf4ca23a9b6d..010e2ae3fa8cb 100644
> --- a/drivers/video/backlight/Kconfig
> +++ b/drivers/video/backlight/Kconfig
[ ... ]
> +config BACKLIGHT_KTD3136
> +	tristate "Backlight Driver for Kinetic KTD3136"
> +	depends on I2C
> +	select REGMAP_I2C

[Severity: Low]
Does this driver actually use the regmap API? Looking at the code, it appea=
rs
to exclusively use raw I2C SMBus operations (e.g., i2c_smbus_read_byte_data=
).
Could this select REGMAP_I2C be safely removed to avoid forcing an unnecess=
ary
dependency?

> +	help
> +	  Say Y to enable the backlight driver for the Kinetic Technologies
[ ... ]
> diff --git a/drivers/video/backlight/ktd3136-backlight.c b/drivers/video/=
backlight/ktd3136-backlight.c
> new file mode 100644
> index 0000000000000..a8ebe3b23c99f
> --- /dev/null
> +++ b/drivers/video/backlight/ktd3136-backlight.c
[ ... ]
> +static int ktd3136_probe(struct i2c_client *client)
> +{
> +	struct device *dev =3D &client->dev;
> +	struct backlight_properties props;
> +	struct ktd3136_data *chip;
> +	int ret, val;
> +	u32 def_brightness =3D KTD3136_DEFAULT_BRIGHTNESS;
> +	u32 max_brightness =3D KTD3136_DEFAULT_MAX_BRIGHTNESS;
> +
> +	chip =3D devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
> +	if (!chip)
> +		return -ENOMEM;
> +
> +	chip->client =3D client;
> +	mutex_init(&chip->lock);

[Severity: High]
Is a call to i2c_set_clientdata(client, chip) missing here? Later in
ktd3136_remove(), the code calls i2c_get_clientdata(client), which will
return NULL if it wasn't set, silently bypassing the hardware power-off.

> +
> +	chip->vin =3D devm_regulator_get_optional(dev, "vin");
> +	if (IS_ERR(chip->vin)) {
> +		ret =3D PTR_ERR(chip->vin);
> +		if (ret !=3D -ENODEV)
> +			return dev_err_probe(dev, ret, "Failed to get vin regulator\n");
> +		chip->vin =3D NULL;
> +	}
> +
> +	if (chip->vin) {
> +		ret =3D regulator_enable(chip->vin);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "Failed to enable vin regulator\n");
> +	}
> +
> +	chip->enable_gpio =3D devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_=
HIGH);
> +	if (IS_ERR(chip->enable_gpio))
> +		return dev_err_probe(dev, PTR_ERR(chip->enable_gpio),
> +				     "Failed to get enable GPIO\n");

[Severity: High]
If devm_gpiod_get_optional() fails here, the function returns immediately.
Does this leave the vin regulator enabled since there is no devm action or
manual regulator_disable(chip->vin) on this error path?

[Severity: Medium]
The enable GPIO is asserted HIGH here (powering the hardware), but
chip->is_enabled remains false. If the default brightness evaluates to 0,
backlight_update_status() calls ktd3136_power_off(). Because chip->is_enabl=
ed
is false, ktd3136_power_off() returns early without de-asserting the GPIO.
Could this state mismatch leave the backlight physically ON when the initial
brightness is 0?

> +
> +	if (chip->enable_gpio)
> +		usleep_range(2000, 3000);
[ ... ]
> +static void ktd3136_remove(struct i2c_client *client)
> +{
> +	struct ktd3136_data *chip =3D i2c_get_clientdata(client);
> +
> +	if (chip)
> +		ktd3136_power_off(chip);

[Severity: Medium]
Does ktd3136_power_off(chip) need to be protected by mutex_lock(&chip->lock)
here? Since the backlight device is registered with
devm_backlight_device_register, its sysfs interface might still be active
during .remove(). Could this cause a data race with concurrent sysfs writes
to the brightness attribute?

[Severity: High]
Does the vin regulator need to be disabled here? It was enabled during probe
but there doesn't seem to be a corresponding regulator_disable() call when =
the
driver is unbound.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-ginkgo-sub=
mission-final-v1-0-0e68e63a18d4@gmail.com?part=3D2
