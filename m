Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C421C429CCF
	for <linux-input@vger.kernel.org>; Wed, 26 Aug 2026 13:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787751383; cv=none; b=RD1XkVwZDJRqcK8FFYpA8irrZNTtAOIoERnjPm/1v6S7nylv36kyZ3PJgzJM0HzTVbD1Lu0ANUm3DsekeyifnLL00R9xIUA+cwQD6j8bsd20R22R/iECIKRDSEuhxsKQunJTmb81z5tBXtg9HODhcv3zXZ0UEGYW1zry3m+DKTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787751383; c=relaxed/simple;
	bh=p9Fbv8LG+3+WECHUDZnaeaiC2xyqxJa54ssq2di73q4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KFrdP4oTd0KhknMpQTVdjWZ/R7esI49RHcdQr92NBvMwcZTN3/VNHfbDKpk3m7SpT08ilYMAnJXlnHPszlRguIAP59QQuoq82cxMcH9avQ5WaEd1jIsvwc1XRDRF14pPSiSTIZRqwyhaEZ8cDxenkQUXfZ5Ca4NdPIuSCpJ8zXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fyTIWCgm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fyTIWCgm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 704301F000E9;
	Wed, 26 Aug 2026 13:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787751374;
	bh=PVHhXb1m0VAJXLY8AgyciCKA+8Df6AfG9tIi8Oe7myI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fyTIWCgmdno8vZRM9RuEvwIRUGy6ynuaheJo+wQ/4YLWvck+qBu81nvDn3rt+BAEr
	 GF2/MN1KKrG2itTEPwc6k/4mqDzR9/p134oEBx8SFb33exwN/trHU8o/2YjY+gWsgN
	 GTjJAiOETyTuUOw7/xfWNrbKEOv7wkrOGgZBsdgJiauLJhTQH7pr4qnamv3N1snXzE
	 gqOQGzZEYhT5H+YFa78I+Wr2VdLlhvS4HHEVMRBSTeEeUKEz240r4EpewLTI380VIa
	 kycTWusoSh/+VSQR7MOUaTY6dP6dVidaK9iWmgDdYuPayXJXd2xIHvKdIEjJboDOAl
	 /mINJKjE6EcwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] Input: drv260x: Make vbat supply optional
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maurizio Casciano" <mauriziocasciano7@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260826132211.3341936-2-mauriziocasciano7@gmail.com>
References: <20260826132211.3341936-1-mauriziocasciano7@gmail.com>
 <20260826132211.3341936-2-mauriziocasciano7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 13:36:14 +0000
Message-Id: <20260826133614.704301F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the resume callb=
ack attempts I2C writes before powering on the device and fails to reinitia=
lize volatile registers after power loss. In `drv260x_resume()`, `regmap_up=
date_bits()` is called to clear the standby bit over I2C before asserting t=
he enable GPIO. Because the DRV260X entirely disables its I2C interface whe=
n the EN pin is low, the I2C write will invariably fail with `-EREMOTEIO`. =
This failure causes the resume function to abort prematurely without ever a=
sserting the enable GPIO, leaving the device permanently unpowered and brok=
en after a single suspend/resume cycle. Additionally, because power is cut =
during suspend, the device loses all volatile configurations (e.g., calibra=
tion, rated/overdrive voltages), which are never restored upon resume.
- [High] This problem wasn't introduced by this patch, but there is concurr=
ent access and a lack of synchronization between the async force-feedback w=
orker and device suspend paths. The force-feedback worker (`drv260x_worker`=
) executes asynchronously and does not hold a lock to serialize it against =
system suspend. During suspend, `drv260x_suspend` shuts down the device by =
asserting the EN pin low and disabling the vbat regulator. Because the work=
er is not canceled or flushed during suspend, it can execute while the devi=
ce is powered down, driving the EN GPIO high and attempting I2C writes whil=
e the vbat supply is disabled. This can cause I2C timeouts, corrupt device =
state, and physically stress the chip by back-powering it via the GPIO.
--

commit 71f6122d604ec11f8df6957cd8212e9dd11f888a
Author: Maurizio Casciano <mauriziocasciano7@gmail.com>

Input: drv260x: Make vbat supply optional

This patch makes the vbat regulator lookup optional to support systems that
do not describe a software-controllable supply. Systems with a vbat supply
described will retain the existing enable, disable, and power management
behaviors.

> diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
> --- a/drivers/input/misc/drv260x.c
> +++ b/drivers/input/misc/drv260x.c

[ ... ]

> @@ -585,13 +589,15 @@ static int drv260x_suspend(struct device *dev)
> =20
>  		gpiod_set_value(haptics->enable_gpio, 0);
> =20
> -		error =3D regulator_disable(haptics->regulator);
> -		if (error) {
> -			dev_err(dev, "Failed to disable regulator\n");
> -			regmap_update_bits(haptics->regmap,
> -					   DRV260X_MODE,
> -					   DRV260X_STANDBY_MASK, 0);
> -			return error;
> +		if (haptics->regulator) {
> +			error =3D regulator_disable(haptics->regulator);

[Severity: High]
This is a pre-existing issue, but is there a lack of synchronization between
the async force-feedback worker and device suspend paths?

The force-feedback worker (drv260x_worker) executes asynchronously and does
not hold a lock to serialize it against system suspend. During suspend, the
device is shut down here by asserting the EN pin low and disabling the vbat
regulator.

Because the worker is not canceled or flushed during suspend, couldn't it
execute while the device is powered down, driving the EN GPIO high and
attempting I2C writes while the vbat supply is disabled? This might cause I=
2C
timeouts, corrupt device state, and physically stress the chip by
back-powering it via the GPIO.

> +			if (error) {
> +				dev_err(dev, "Failed to disable regulator\n");
> +				regmap_update_bits(haptics->regmap,
> +						   DRV260X_MODE,
> +						   DRV260X_STANDBY_MASK, 0);
> +				return error;
> +			}
>  		}
>  	}

[ ... ]

> @@ -606,10 +612,12 @@ static int drv260x_resume(struct device *dev)
>  	guard(mutex)(&haptics->input_dev->mutex);
> =20
>  	if (input_device_enabled(haptics->input_dev)) {
> -		error =3D regulator_enable(haptics->regulator);
> -		if (error) {
> -			dev_err(dev, "Failed to enable regulator\n");
> -			return error;
> +		if (haptics->regulator) {
> +			error =3D regulator_enable(haptics->regulator);
> +			if (error) {
> +				dev_err(dev, "Failed to enable regulator\n");
> +				return error;
> +			}
>  		}
> =20
>  		error =3D regmap_update_bits(haptics->regmap,
> @@ -617,7 +625,8 @@ static int drv260x_resume(struct device *dev)
>  					   DRV260X_STANDBY_MASK, 0);
>  		if (error) {
>  			dev_err(dev, "Failed to unset standby mode\n");
> -			regulator_disable(haptics->regulator);
> +			if (haptics->regulator)
> +				regulator_disable(haptics->regulator);
>  			return error;
>  		}
> =20

[Severity: High]
This isn't a bug introduced by this patch, but does the resume callback
attempt I2C writes before powering on the device?

Here in drv260x_resume(), regmap_update_bits() is called to clear the stand=
by
bit over I2C before asserting the enable GPIO. Because the DRV260X entirely
disables its I2C interface when the EN pin is low, won't this I2C write
invariably fail with -EREMOTEIO?

This failure would cause the resume function to abort prematurely without e=
ver
asserting the enable GPIO, leaving the device permanently unpowered and bro=
ken
after a single suspend/resume cycle.

Additionally, because power is cut during suspend, does the device lose all
volatile configurations (e.g., calibration, rated/overdrive voltages) that
should be restored upon resume?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826132211.3341=
936-1-mauriziocasciano7@gmail.com?part=3D1
