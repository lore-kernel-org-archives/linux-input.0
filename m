Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24391A9F96
	for <linux-input@vger.kernel.org>; Mon, 31 Aug 2026 01:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788138927; cv=none; b=rxkindEeyyqr7QzLFvXo+HxL1L2hovOv6qzn/22jo9a75zWvLJeA+Hygg8ZNgPMqDjVyr4JJbei6CwIemHhbusK1Xt54s4Z4jHw9Uwu0RbVtBi1G58udIRkKbuzaOv2zsxbR2GI5bH3qzZiRHETHvISMUrSKwBenOODoTjebG4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788138927; c=relaxed/simple;
	bh=dy5YndHjSQFgchucVFoVgrYiIXzsRr7rE59p+08b4SE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MYDyDX7YllBcuYbO6pbUb+ytOJCbhAOEQtio5qapeByisNUphkjWAz5l464POv5TzEYr3YWhR66ap6omaJAbc/40UIc2uAMOtgbTFIguO/gw+WK+0/f74IB+1QjhWg2eY9doLy3aBThuvEqB+lY28iUSmfaHxnxgBnK/6DwxLCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZvSy9lj7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZvSy9lj7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24AB11F000E9;
	Mon, 31 Aug 2026 01:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788138926;
	bh=WE17dMqjpHZfU0jTcP+e36nbzVUqIVr6xbBLD+cTwqY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZvSy9lj7XiqerEGbWjgI0ipBr4iAzOwGf7OTMvWQAlZ8SZN5cFqmN+0e7n5ZmAruP
	 jTNth45I+P78zSNZMLzJsBgbR7CDUpnYlfOUOMRnrfbAngWoPuZaXugn1OofvVTAfr
	 qcX1t+R6WUTE8X0fdtXcFriZPtYZ69psya6NmxsA8DsVT2OY9JIz2h6F2n656Q5Yfs
	 G5FR4npj6l2botDkc9DJQkhoqt/g4ooDY8KQ7QoVhp1Ld0+bVhCCuNgInJolrNerX8
	 lbL3TutFSDFQgCok6AabU1Qv6RqXPpPIlIx2OkFKP5KAuFBxzPjouMUUdP4uw/qE1g
	 /3ygQJ1oXOOLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] Input: drv260x: Fix suspend and resume sequencing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maurizio Casciano" <mauriziocasciano7@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260831010020.673316-1-mauriziocasciano7@gmail.com>
References: <20260830143050.03E081F000E9@smtp.kernel.org>
 <20260831010020.673316-1-mauriziocasciano7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 01:15:25 +0000
Message-Id: <20260831011526.24AB11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Device loses custom configuration and DT-provided calibration data=
 after system suspend because power is cut and registers are not restored u=
pon resume.
- [High] Unbalanced regulator disable when driver is unbound after a resume=
 failure.
- [High] I2C register access during suspend and close fails because the ena=
ble GPIO is not asserted when no effects have been played, causing system s=
uspend to abort.
--

commit bc29da04cf5ab833e43a374e3220aeca730bd6a9
Author: Maurizio Casciano <mauriziocasciano7@gmail.com>

    Input: drv260x: Fix suspend and resume sequencing
   =20
This commit addresses race conditions between the asynchronous force-feedba=
ck
playback worker and system suspend. It manually stops the worker and sequen=
ces
the regulator, GPIO, and standby mode transitions, attempting to gracefully
unwind on failure.

Link: https://lore.kernel.org/linux-input/20260829230740.126461F000E9@smtp.=
kernel.org/
Link: https://lore.kernel.org/linux-input/20260830143050.03E081F000E9@smtp.=
kernel.org/
Link: https://lore.kernel.org/linux-input/apLD91vzHIrLOPWC@google.com/

> diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
> index 6c5c4c53753b1..f261bb32fdc08 100644
> --- a/drivers/input/misc/drv260x.c
> +++ b/drivers/input/misc/drv260x.c

[ ... ]

> @@ -569,18 +593,22 @@ static int drv260x_probe(struct i2c_client *client)
>  static int drv260x_suspend(struct device *dev)
>  {
>  	struct drv260x_data *haptics =3D dev_get_drvdata(dev);
> -	int error;
> +	bool restore_work =3D false;
> +	int error, restore_error;
> =20
> -	guard(mutex)(&haptics->input_dev->mutex);
> +	mutex_lock(&haptics->input_dev->mutex);
> =20
>  	if (input_device_enabled(haptics->input_dev)) {
> +		restore_work =3D !haptics->work_disabled;
> +		drv260x_disable_work(haptics);
> +
>  		error =3D regmap_update_bits(haptics->regmap,
>  					   DRV260X_MODE,
>  					   DRV260X_STANDBY_MASK,
>  					   DRV260X_STANDBY);

[Severity: High]
This is a pre-existing issue, but will this I2C register access fail if the
enable GPIO is not asserted?

If a user opens and then closes the device, drv260x_close() sets the enable
GPIO to 0. Because there is no open() callback, reopening the device leaves
the GPIO at 0. If the system then suspends before any effects are played, t=
he
chip is disabled.

Will the resulting I2C NACK cause regmap_update_bits() to return an error a=
nd
abort the entire system suspend?

>  		if (error) {
>  			dev_err(dev, "Failed to set standby mode\n");
> -			return error;
> +			goto err_enable_work;
>  		}

[ ... ]

> @@ -603,28 +645,40 @@ static int drv260x_resume(struct device *dev)
>  	struct drv260x_data *haptics =3D dev_get_drvdata(dev);
>  	int error;
> =20
> -	guard(mutex)(&haptics->input_dev->mutex);
> +	mutex_lock(&haptics->input_dev->mutex);
> =20
>  	if (input_device_enabled(haptics->input_dev)) {
> +		drv260x_disable_work(haptics);
> +
>  		error =3D regulator_enable(haptics->regulator);
>  		if (error) {
>  			dev_err(dev, "Failed to enable regulator\n");
> -			return error;
> +			goto err_unlock;
>  		}
> =20
> +		gpiod_set_value(haptics->enable_gpio, 1);
> +		fsleep(250);
> +
>  		error =3D regmap_update_bits(haptics->regmap,
>  					   DRV260X_MODE,
>  					   DRV260X_STANDBY_MASK, 0);

[Severity: High]
This isn't a bug introduced by this patch, but does the device lose its cus=
tom
configuration here?

Because the regulator was disabled during suspend, power to the device was =
cut
and the registers were wiped. Since the driver uses REGCACHE_NONE for its
regmap configuration, clearing the standby mode won't automatically reapply=
 the
device settings.

Are critical initialization settings like rated voltage, overdrive voltage,=
 and
calibration data lost after a suspend/resume cycle?

>  		if (error) {
> -			dev_err(dev, "Failed to unset standby mode\n");
> -			regulator_disable(haptics->regulator);
> -			return error;
> +			dev_err(dev, "Failed to leave standby mode: %d\n", error);
> +			goto err_disable_regulator;
>  		}
> =20
> -		gpiod_set_value(haptics->enable_gpio, 1);
> +		drv260x_enable_work(haptics);
>  	}
> =20
> +	mutex_unlock(&haptics->input_dev->mutex);
>  	return 0;
> +
> +err_disable_regulator:
> +	gpiod_set_value(haptics->enable_gpio, 0);
> +	regulator_disable(haptics->regulator);
> +err_unlock:
> +	mutex_unlock(&haptics->input_dev->mutex);
> +	return error;
>  }

[Severity: High]
This is a pre-existing issue, but does this error unwinding break the invar=
iant
expected by devm cleanup?

If regulator_enable() fails (goto err_unlock) or if regmap_update_bits() fa=
ils
(goto err_disable_regulator), drv260x_resume() exits with the regulator cou=
nt
at 0.

If the device is subsequently unbound after this resume failure (for exampl=
e,
the driver module is removed), the devm cleanup action unconditionally calls
regulator_disable() again.

Will this cause an unbalanced regulator disable, triggering a kernel WARN a=
nd
prematurely cutting power to other hardware sharing the same regulator?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831010020.6733=
16-1-mauriziocasciano7@gmail.com?part=3D1
