Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7373D16EF;
	Tue, 21 Jul 2026 10:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784628141; cv=none; b=Gkr345K2KDjXLTl/f4cba7YmoU5WpCUylmonPbqiRqd//Yh+VsSt/CrulOvuPYXpeN385tmMlxAy00gy0T1Cp+hbGvAlMKppc40oa+penFZiiqry2PGk0FUAgoQZqe0kUzihvP2EcJ/WWn2u0nLEibM6ickdy3e/+TGdUSKyfaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784628141; c=relaxed/simple;
	bh=9qBRIB8bijsPPLUKPCt/f4UBuIEZqpmhUDCceoiUxpM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G9CbIfcDMOgbuXNn/iSQWrjDpqFYEjIC0UcArJ1ScNtVglSmtw/+nEDt2EssR2MktqvczlAQIakfvxthaLKlKtE+U3GP0Le+5uJo4Mph0x+QwCRlYIHR1wd3tk86KXNnbYJbWlw8OLjSlQX3tD8EANw28iN5VK5oQuD66D5e9mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J40RZrPq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J40RZrPq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C751F000E9;
	Tue, 21 Jul 2026 10:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784628139;
	bh=58lFvlNf3RInnDmhIl1LViDS/gzOcWQM2UirZa4pvrM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J40RZrPqOfpHSafUHkJhKgoKsuaC/hQdvAYSJkkpBlR+IA/yZ3dtAHtpb/MCBPKqq
	 L9meseBS8dVJNPuXcPzoILaDCzcQKBPQ6ntcpvUi3skUZtS/8aqiKzASm9FaUNPLqi
	 K8S+2FxVCzAMJ2iQFlRDeQoSc/53cua1wIyBfPVmMBIsUNMjAxT8hWk+46k8y9mgGv
	 tjNBjKDV5d2T8mBHWU0Sh1mB4vcqlND3gC1oQKb9GmQxyO4jfm98XTeXY5ygNube8t
	 0BfSTn9CKkBhA3TQcXETuyqcsH4zxn6u0UDs4GSvzU+ZKRPC9TWfZISDPknq7/KxMb
	 Xi2fE94ARJHVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 5/7] leds: Add driver for ASUS Transformer LEDs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, linux-leds@vger.kernel.org, robh@kernel.org, lee@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260721095233.420823-6-clamor95@gmail.com>
References: <20260721095233.420823-1-clamor95@gmail.com>
 <20260721095233.420823-6-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 10:02:19 +0000
Message-Id: <20260721100219.93C751F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] The manually constructed LED sysfs name incorrectly places the c=
olor in the function field.
- [Medium] The child driver uses a bespoke custom accessor function exposed=
 by the MFD parent, violating MFD API layering guidelines.
- [Low] The commit message subject prefix does not adhere to the mandatory =
subsystem prefix format.
- [Low] The Kconfig help text contains a grammatical error, using "it's" in=
stead of "its".
--

--- Patch [5]: [PATCH v10 5/7] leds: Add driver for ASUS Transformer LEDs -=
--
commit 177b0b82c65e4fc0357f15d45f7c0353ef5cb99a
Author: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>

leds: Add driver for ASUS Transformer LEDs

ASUS Transformer tablets have a green and an amber LED on both the Pad
and the Dock. If both LEDs are enabled simultaneously, the emitted light
will be yellow.

> leds: Add driver for ASUS Transformer LEDs

[Severity: Low]
This isn't a bug, but does the commit subject prefix follow the LED subsyst=
em
guidelines? The subsystem typically expects the format
leds: <Driver>: <Capitalized description>.

> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index f4a0a3c8c8705..f637d23400a89 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -120,6 +120,17 @@ config LEDS_OSRAM_AMS_AS3668
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called leds-as3668.
> =20
> +config LEDS_ASUS_TRANSFORMER_EC
> +	tristate "LED Support for Asus Transformer charging LED"
> +	depends on LEDS_CLASS
> +	depends on MFD_ASUS_TRANSFORMER_EC
> +	help
> +	  This option enables support for charging indicator on
> +	  Asus Transformer's Pad and it's Dock.
                                           ^^^^

[Severity: Low]
This isn't a bug, but should "it's" be "its" here?

[ ... ]

> diff --git a/drivers/leds/leds-asus-transformer-ec.c b/drivers/leds/leds-=
asus-transformer-ec.c
> new file mode 100644
> index 0000000000000..4421d629911ed
> --- /dev/null
> +++ b/drivers/leds/leds-asus-transformer-ec.c

[ ... ]

> +static enum led_brightness asus_ec_led_get_brightness(struct led_classde=
v *cdev)
> +{
> +	struct asus_ec_led *led =3D container_of(cdev, struct asus_ec_led, cdev=
);
> +	const struct asusec_core *ec =3D led->ddata->ec;
> +	u64 ctl;
> +	int ret;
> +
> +	ret =3D asus_dockram_access_ctl(ec->dockram, &ctl, 0, 0);

[Severity: Medium]
Does using the custom parent accessor asus_dockram_access_ctl() violate
MFD API layering guidelines?=20

MFD core drivers should usually expose standard shared resources like regmap
rather than bespoke helper functions for child drivers to use, as it creates
tight coupling between the parent and child.

> +	if (ret)
> +		return LED_OFF;
> +
> +	return ctl & led->ctrl_bit ? LED_ON : LED_OFF;
> +}
> +
> +static int asus_ec_led_set_brightness(struct led_classdev *cdev,
> +				      enum led_brightness brightness)
> +{
> +	struct asus_ec_led *led =3D container_of(cdev, struct asus_ec_led, cdev=
);
> +	const struct asusec_core *ec =3D led->ddata->ec;
> +
> +	if (brightness)
> +		return asus_dockram_access_ctl(ec->dockram, NULL,
> +					       led->ctrl_bit, led->ctrl_bit);

[Severity: Medium]
This is the same custom accessor as above, used again here in
asus_ec_led_set_brightness(). Should this be refactored to use standard
accessors?

[ ... ]

> +static int asus_ec_led_probe(struct platform_device *pdev)
> +{
> +	const struct asusec_core *ec =3D dev_get_drvdata(pdev->dev.parent);
> +	struct asus_ec_leds_data *ddata;
> +	struct device *dev =3D &pdev->dev;
> +	int ret;
> +
> +	ddata =3D devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
> +	if (!ddata)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, ddata);
> +	ddata->ec =3D ec;
> +
> +	for (int i =3D 0; i < ASUSEC_LED_MAX; i++) {
> +		const struct asus_ec_led_config *cfg =3D &asus_ec_leds[i];
> +		struct asus_ec_led *led =3D &ddata->leds[i];
> +
> +		led->cdev.name =3D devm_kasprintf(dev, GFP_KERNEL, "%s::%s",
> +						ddata->ec->name, cfg->name);

[Severity: Medium]
Since cfg->name contains the color (amber or green), does this format string
incorrectly place the color in the function segment of the standard
devicename:color:function naming scheme?

This will generate devicename::color instead of devicename:color:function,
which might confuse userspace LED managers that rely on standard sysfs
directories.

> +		if (!led->cdev.name)
> +			return -ENOMEM;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721095233.4208=
23-1-clamor95@gmail.com?part=3D5
