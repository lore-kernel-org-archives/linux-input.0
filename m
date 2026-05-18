Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC1B3FA5C5;
	Mon, 18 May 2026 12:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779105755; cv=none; b=Pdw/EwYhXiiuQOzn+/5yswsFaI3EU6zFQJK7j2oFLV4isueIAboxvMJMfik5F7rdEn0VY5udP+L3frXuf2n/Pw5aHBP3k3hYtzQh9fl7Je1CiyOUNVWVOgTOoWfywsTkIYzgaq/Y6oI4GoFKZilpN7GF1UAEdBk4utPg3VQjzEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779105755; c=relaxed/simple;
	bh=v0XudB6/WzKpCCMEXx+EwPw5TDfqGX+OFUd9Oj1c8C4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LaIvtnit8UkA45D4WcvGfTG4VvL/i+jNvd/XZqA8tnklK2KKtw7ZS77Zff6P8QE8g3ch1xeBdEIq4aEZBT5IjmRodSCwNnBv86MktddORQ9AsHHMZjPRRpGlvgsh1pjWDFOmRCOHR3lmq9KkOEqmzjMB8PLOat8h0WuKLU82WVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KOGG0vpN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KOGG0vpN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF605C2BCB8;
	Mon, 18 May 2026 12:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779105755;
	bh=v0XudB6/WzKpCCMEXx+EwPw5TDfqGX+OFUd9Oj1c8C4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=KOGG0vpNuf/xUIC1vq8FOuGau6zyH/VLOwAycEsOEXRC6VyMMXIGj5Jxnijthc7cs
	 UFV/DhxcdzxFeBn+WUKHCH6KYjan46vHeyEJSdTkVK7sPa5Dj0p7XSMSAX6dz6UiTC
	 lB2ySC3xM4+qm+OSB4tuEaqoNeWwt54VYeossPu3DE9xdSnISKlob6aun4ClWbL7XE
	 zcRqZeI7+mufsRDONMbY7zDyq4DIJTNN5pk9st+06kCWwmfgmq5p8GZzMjqQe7Ae5S
	 41mqRtF2UGQA03iu+kxVxABQ7kpFPlDDE3rr9bYYBcLyZg/SeKDoK66Igp4KQUA5Y7
	 uouwH9NxbLBRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 5/7] leds: Add driver for ASUS Transformer LEDs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: dmitry.torokhov@gmail.com, robh@kernel.org, conor+dt@kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260518095907.36158-6-clamor95@gmail.com>
References: <20260518095907.36158-6-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 12:02:34 +0000
Message-Id: <20260518120234.BF605C2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Incorrect use of `LED_CORE_SUSPENDRESUME` for charging indicators.
- [Medium] Lack of hardware state synchronization (`brightness_get`) at ini=
tialization.
- [Medium] Missing `MODULE_ALIAS` prevents automatic module loading.
- [Low] The driver exposes a physical bi-color LED as two independent singl=
e-color LED devices instead of utilizing the LED Multicolor class.
--

commit f02de4369b03c2d6785dea5fb4edfab53036130d
Author: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>

leds: Add driver for ASUS Transformer LEDs

ASUS Transformer tablets have a green and an amber LED on both the Pad
and the Dock. If both LEDs are enabled simultaneously, the emitted light
will be yellow.

> ASUS Transformer tablets have a green and an amber LED on both the Pad
> and the Dock. If both LEDs are enabled simultaneously, the emitted light
> will be yellow.

Since this describes a physically multi-color LED, shouldn't the driver use
the LED Multicolor class API (CONFIG_LEDS_CLASS_MULTICOLOR) instead of expo=
sing
them as two separate single-color LED devices?

> diff --git a/drivers/leds/leds-asus-transformer-ec.c b/drivers/leds/leds-=
asus-transformer-ec.c
> new file mode 100644
> index 0000000000000..c9bdc46c02e15
> --- /dev/null
> +++ b/drivers/leds/leds-asus-transformer-ec.c
[ ... ]
> +	for (i =3D 0; i < ASUSEC_LED_MAX; i++) {
> +		const struct asus_ec_led_config *cfg =3D &asus_ec_leds[i];
> +		struct asus_ec_led *led =3D &ddata->leds[i];
> +
> +		led->cdev.name =3D devm_kasprintf(dev, GFP_KERNEL, "%s::%s",
> +						ddata->ec->name, cfg->name);
> +		if (!led->cdev.name)
> +			return -ENOMEM;
> +
> +		led->cdev.max_brightness =3D 1;
> +		led->cdev.color =3D cfg->color;
> +		led->cdev.flags =3D LED_CORE_SUSPENDRESUME | LED_RETAIN_AT_SHUTDOWN;

Does LED_CORE_SUSPENDRESUME make sense for a charging indicator?

This flag instructs the LED core to explicitly turn off the LED during susp=
end,
which turns off the charging indicator while the device is sleeping.

Also, could the Embedded Controller have already turned the LED on before t=
he
driver probes?

Since there is no brightness_get callback to synchronize the initial hardwa=
re
state, the LED core will initialize the software brightness to 0. If the de=
vice
resumes from suspend, the LED core will restore this saved brightness of 0,
permanently turning off the LED even if it was physically on before.

[ ... ]
> +static struct platform_driver asus_ec_led_driver =3D {
> +	.driver.name =3D "asus-transformer-ec-led",
> +	.probe =3D asus_ec_led_probe,
> +};
> +module_platform_driver(asus_ec_led_driver);
> +
> +MODULE_AUTHOR("Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>");
> +MODULE_AUTHOR("Svyatoslav Ryhel <clamor95@gmail.com>");
> +MODULE_DESCRIPTION("ASUS Transformer's charging LED driver");
> +MODULE_LICENSE("GPL");

Will this module load automatically when the platform device is registered?

Since there is no MODULE_ALIAS("platform:asus-transformer-ec-led") declarat=
ion,
udev might not be able to automatically load the module during boot when the
MFD core registers the corresponding platform device.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518095907.3615=
8-1-clamor95@gmail.com?part=3D5
