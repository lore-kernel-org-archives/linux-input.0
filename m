Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916B234F247
	for <linux-input@vger.kernel.org>; Sun, 30 Aug 2026 14:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788100251; cv=none; b=FjWt0lCJS2Eeo6P5zZaoAjzBIihi8dssjcdmoYAzXqIzTWTMnlZAHP8tmGWjcV/zjT5h34VJOm+VgWV0eOlUwSayqDvCUPubQH2BClg+hAtvBICbXES5PdyvFcWoV5q68apCib5JH5k0BGe9an7JzKLcZcO/bXwlympbXEU9lFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788100251; c=relaxed/simple;
	bh=JSl/KhEgmVbHFlxC8UCsHny7mh7x8An9CpM9Ps+cN3s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ci+RK9GuhoLk6E6ltfrNjIIouuwZ5i32DJAaocxjeeRY8bz4Y3+UQbUd3LJwtkQFQ0DLL6Xb2Bjj0U6O5kbWTp/qBIZgSPTS34bcg3R/QWYG/20Vcvq791J/p9cJK5h7z9LCSRCH19RkOKDvE6nKiVqnZx1613HPOofHKzrnIZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VeKT21BX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VeKT21BX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E081F000E9;
	Sun, 30 Aug 2026 14:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788100250;
	bh=5LztaWFgZ6OQUSQbFcKUQZBDpkx+yIkUt2DaWur017g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VeKT21BXB0FAehsaoA5FXItqs68tSbTV4emaV6SWHrhIs57V4SMMg0FOUFXWvtMX/
	 ufdmaLtzBiFD+LDqsxM/XYqGbV5KV8LsprtBAPk+3uNbkUPXhwhICtu+kaCxtMTnuo
	 73rf+fNPf1xTJ47XBQewp6xsGW3PovM+cK6E/602gyhm1axS+lWJt1wldigFT9atGS
	 MmqWk7/T27TEckQEDKs5GXWx02n+6Q0gxxcWSolELSLD0dniK//jMAI2iYAc0gJAAb
	 OGhi4dWiRwhQrgePk1ukO25Qc2PYtQbZlkcYJwpDFgEgljHCfdW82m35ab06qMqjoC
	 LeXDYy1UoLxrw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] Input: drv260x: Fix suspend and resume sequencing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maurizio Casciano" <mauriziocasciano7@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260830141728.53320-1-mauriziocasciano7@gmail.com>
References: <20260829230740.126461F000E9@smtp.kernel.org>
 <20260830141728.53320-1-mauriziocasciano7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 14:30:49 +0000
Message-Id: <20260830143050.03E081F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The resume error path incorrectly re-enables the haptics worker wh=
ile the hardware regulator is disabled, exposing the unpowered device to I2=
C and GPIO writes.

Pre-existing issues:
- [High] The device's calibration and configuration registers are lost acro=
ss a suspend/resume cycle because they are never restored after the regulat=
or is re-enabled.
--

commit 6d265a379cd4795d6bb19ec724655bfda45835f4
Author: Maurizio Casciano <mauriziocasciano7@gmail.com>

Input: drv260x: Fix suspend and resume sequencing

This commit fixes system suspend handling for the drv260x haptics driver
by explicitly disabling and draining the force-feedback worker before
entering standby, and conditionally enabling it upon resume. It also
introduces explicit mutex locking and goto-based error unwinding.

Link: https://lore.kernel.org/linux-input/20260829230740.126461F000E9@smtp.=
kernel.org/
Link: https://lore.kernel.org/linux-input/apLD91vzHIrLOPWC@google.com/

> diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
> index 6c5c4c53753b1..b6499b2fcd8df 100644
> --- a/drivers/input/misc/drv260x.c
> +++ b/drivers/input/misc/drv260x.c
[ ... ]
>  static int drv260x_resume(struct device *dev)
>  {
>  	struct drv260x_data *haptics =3D dev_get_drvdata(dev);
>  	int error;
> =20
> -	guard(mutex)(&haptics->input_dev->mutex);
> +	mutex_lock(&haptics->input_dev->mutex);
> =20
>  	if (input_device_enabled(haptics->input_dev)) {
>  		error =3D regulator_enable(haptics->regulator);
>  		if (error) {
>  			dev_err(dev, "Failed to enable regulator\n");
> -			return error;
> +			goto err_enable_work;
>  		}

[Severity: High]
This is a pre-existing issue, but since the regulator was disabled during
suspend, the DRV260x chip loses all internal volatile registers, including
critical calibration data like rated voltage and overdrive clamp.

Because drv260x_regmap_config uses REGCACHE_NONE, regmap will not
automatically restore these values upon resume.

Does this device need a call to drv260x_init() here to restore its
calibration and configuration settings before attempting to operate?

> =20
> +		gpiod_set_value(haptics->enable_gpio, 1);
> +		fsleep(250);
> +
>  		error =3D regmap_update_bits(haptics->regmap,
>  					   DRV260X_MODE,
>  					   DRV260X_STANDBY_MASK, 0);
>  		if (error) {
> -			dev_err(dev, "Failed to unset standby mode\n");
> -			regulator_disable(haptics->regulator);
> -			return error;
> +			dev_err(dev, "Failed to leave standby mode: %d\n", error);
> +			goto err_disable_regulator;
>  		}
> =20
> -		gpiod_set_value(haptics->enable_gpio, 1);
> +		enable_work(&haptics->work);
>  	}
> =20
> +	mutex_unlock(&haptics->input_dev->mutex);
>  	return 0;
> +
> +err_disable_regulator:
> +	gpiod_set_value(haptics->enable_gpio, 0);
> +	regulator_disable(haptics->regulator);
> +err_enable_work:
> +	enable_work(&haptics->work);

[Severity: High]
If the system resumes but the hardware initialization fails, does this
unconditionally re-enable the haptics worker while the regulator remains
disabled?

If userspace subsequently sends a force-feedback event, drv260x_worker()
will execute and attempt I2C communication with the unpowered chip.
Can this lead to I2C bus timeouts, lockups, or back-powering the chip
via GPIO/I2C lines?

Additionally, if the system later successfully retries and resumes the
device, the success path will call enable_work() again. Since the count
was already erroneously reset to 0 here, won't this underflow the disable
count and trigger a workqueue kernel warning?

> +	mutex_unlock(&haptics->input_dev->mutex);
> +	return error;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830141728.5332=
0-1-mauriziocasciano7@gmail.com?part=3D1
