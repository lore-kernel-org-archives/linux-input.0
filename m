Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAE048B37B;
	Tue, 15 Sep 2026 11:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789470912; cv=none; b=LdmM/FTqjydOEy8LAb2t7tUcvqbScZgk3lNVujgky+YydUtUhSCEf4MLoYJtKPKoZa8oO7ctI60ssGqAlqvPULhycmxZG2F8D+vXEKbzIhRYh7+2+t7ko279A6zn6mesAYGt68x/mecHFHZB3e44/1lXveqkT2JT6O0dajYKyu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789470912; c=relaxed/simple;
	bh=4T9ypKWkNGgDbG9u69g33Ob+gh5ZDGK3t0oJaNBwCEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGhQjj28ZoijPxCpIYiuda9wqcVo1epJTbRmjetEqLBTxN9w+rlRYEjm8s2uobBDNI9n1r+2PkWmEfxk/SJmxNVW9khFysuICm2MqMYX8qyRBcAp31irTw8yMfzmaeu8DBth+7xIMESGvF/jyvUWY2/SYtbUfUQGRVPoo6Bs0sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GzGRg4aD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GzGRg4aD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA241F000FF;
	Tue, 15 Sep 2026 11:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789470909;
	bh=wCLfBUuxNPv3XS803Z/uR8KINkcBiOGeEsWT7V4HKKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GzGRg4aDit1AfIZVZqP9pZdOMdaGOtiiCK8LoKNNO759gim0NOnkHWBbn9hMc6QKW
	 oAnHKsKwmRuGxop23SHjHn9J8wdKWgjFIASggu7gj9LtFaxJH/FP8oTrfhjJx1zYQK
	 AzQTUsvrMmMQ3rEuiccjwOzPOHoYxbGS6eP4uqcbipL0J4GK7ntxemvkV54fmDWIU6
	 /YtG4+NSfuXfFDZ+Xz0q422NautoOVY249AOViQBKk3tFG98eL+PaTj93IxlVxNEZJ
	 QkyziJ1/mY9bK3nhL2jjMsIHAAM5pAVK9oxvJVZfE2liJmvbIfc7IsFUzHtrZWFD7t
	 dOgYujgvE+LjA==
Date: Tue, 15 Sep 2026 12:15:05 +0100
From: Lee Jones <lee@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: =?utf-8?B?WcSwxJ7EsFRDQU4=?= KAVAKLI <kavakliyigitcan@gmail.com>,
	linux-leds@vger.kernel.org, dmitry.torokhov@gmail.com,
	conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
	linux-input@vger.kernel.org, robh@kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH RFC 02/10] backlight: add Kinetic KTD3136 driver
Message-ID: <20260915111505.GE11487@google.com>
References: <20260911-ginkgo-submission-final-v1-0-0e68e63a18d4@gmail.com>
 <20260911-ginkgo-submission-final-v1-2-0e68e63a18d4@gmail.com>
 <20260911085919.24FB01F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260911085919.24FB01F00893@smtp.kernel.org>

On Fri, 11 Sep 2026, sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
> - [High] The 'vin' regulator is enabled during probe but never disabled on error paths or during module removal.
> - [High] Missing `i2c_set_clientdata()` in probe causes `ktd3136_remove()` to silently skip hardware power-off.
> - [Medium] Missing lock acquisition in `ktd3136_remove` causes a data race with concurrent backlight sysfs updates.
> - [Medium] State mismatch leaves backlight physically ON when initial brightness is 0.
> - [Low] Unnecessary and unused `select REGMAP_I2C` in Kconfig.

Please review, explain or fix the Sashiko review(s).

If this is a set, this request includes the other patches too.

> --
> 
> commit 15d6d172969378ae4661195e2320fcd1b4ed08c1
> Author: YİĞİTCAN KAVAKLI <kavakliyigitcan@gmail.com>
> 
> backlight: add Kinetic KTD3136 driver
> 
> This commit implements a generic Linux backlight driver for the Kinetic
> Technologies KTD3136 36V, 6-channel LED driver. It uses the standard
> backlight class interface over I2C.
> 
> > diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
> > index dbf4ca23a9b6d..010e2ae3fa8cb 100644
> > --- a/drivers/video/backlight/Kconfig
> > +++ b/drivers/video/backlight/Kconfig
> [ ... ]
> > +config BACKLIGHT_KTD3136
> > +	tristate "Backlight Driver for Kinetic KTD3136"
> > +	depends on I2C
> > +	select REGMAP_I2C
> 
> [Severity: Low]
> Does this driver actually use the regmap API? Looking at the code, it appears
> to exclusively use raw I2C SMBus operations (e.g., i2c_smbus_read_byte_data).
> Could this select REGMAP_I2C be safely removed to avoid forcing an unnecessary
> dependency?
> 
> > +	help
> > +	  Say Y to enable the backlight driver for the Kinetic Technologies
> [ ... ]
> > diff --git a/drivers/video/backlight/ktd3136-backlight.c b/drivers/video/backlight/ktd3136-backlight.c
> > new file mode 100644
> > index 0000000000000..a8ebe3b23c99f
> > --- /dev/null
> > +++ b/drivers/video/backlight/ktd3136-backlight.c
> [ ... ]
> > +static int ktd3136_probe(struct i2c_client *client)
> > +{
> > +	struct device *dev = &client->dev;
> > +	struct backlight_properties props;
> > +	struct ktd3136_data *chip;
> > +	int ret, val;
> > +	u32 def_brightness = KTD3136_DEFAULT_BRIGHTNESS;
> > +	u32 max_brightness = KTD3136_DEFAULT_MAX_BRIGHTNESS;
> > +
> > +	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
> > +	if (!chip)
> > +		return -ENOMEM;
> > +
> > +	chip->client = client;
> > +	mutex_init(&chip->lock);
> 
> [Severity: High]
> Is a call to i2c_set_clientdata(client, chip) missing here? Later in
> ktd3136_remove(), the code calls i2c_get_clientdata(client), which will
> return NULL if it wasn't set, silently bypassing the hardware power-off.
> 
> > +
> > +	chip->vin = devm_regulator_get_optional(dev, "vin");
> > +	if (IS_ERR(chip->vin)) {
> > +		ret = PTR_ERR(chip->vin);
> > +		if (ret != -ENODEV)
> > +			return dev_err_probe(dev, ret, "Failed to get vin regulator\n");
> > +		chip->vin = NULL;
> > +	}
> > +
> > +	if (chip->vin) {
> > +		ret = regulator_enable(chip->vin);
> > +		if (ret)
> > +			return dev_err_probe(dev, ret, "Failed to enable vin regulator\n");
> > +	}
> > +
> > +	chip->enable_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_HIGH);
> > +	if (IS_ERR(chip->enable_gpio))
> > +		return dev_err_probe(dev, PTR_ERR(chip->enable_gpio),
> > +				     "Failed to get enable GPIO\n");
> 
> [Severity: High]
> If devm_gpiod_get_optional() fails here, the function returns immediately.
> Does this leave the vin regulator enabled since there is no devm action or
> manual regulator_disable(chip->vin) on this error path?
> 
> [Severity: Medium]
> The enable GPIO is asserted HIGH here (powering the hardware), but
> chip->is_enabled remains false. If the default brightness evaluates to 0,
> backlight_update_status() calls ktd3136_power_off(). Because chip->is_enabled
> is false, ktd3136_power_off() returns early without de-asserting the GPIO.
> Could this state mismatch leave the backlight physically ON when the initial
> brightness is 0?
> 
> > +
> > +	if (chip->enable_gpio)
> > +		usleep_range(2000, 3000);
> [ ... ]
> > +static void ktd3136_remove(struct i2c_client *client)
> > +{
> > +	struct ktd3136_data *chip = i2c_get_clientdata(client);
> > +
> > +	if (chip)
> > +		ktd3136_power_off(chip);
> 
> [Severity: Medium]
> Does ktd3136_power_off(chip) need to be protected by mutex_lock(&chip->lock)
> here? Since the backlight device is registered with
> devm_backlight_device_register, its sysfs interface might still be active
> during .remove(). Could this cause a data race with concurrent sysfs writes
> to the brightness attribute?
> 
> [Severity: High]
> Does the vin regulator need to be disabled here? It was enabled during probe
> but there doesn't seem to be a corresponding regulator_disable() call when the
> driver is unbound.
> 
> > +}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260911-ginkgo-submission-final-v1-0-0e68e63a18d4@gmail.com?part=2

-- 
Lee Jones
