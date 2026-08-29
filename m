Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6099B4A32
	for <linux-input@vger.kernel.org>; Sat, 29 Aug 2026 12:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788006752; cv=none; b=YjXuOcqkT9Ajz+Yn2VCrzXvqgY7hPaqyboT5EwgTT0fdtDq4lgYj/c4497qE92NeJ3EN4q7Pu4xFbDcidD5F/WWe9uJsVdFEyIFr79+Ymalnftzs1nE4jD69YaoTp118ty1xKr3f2awMq8iy2Q/lAlH6dzw2UZGKXuvoYf8sLRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788006752; c=relaxed/simple;
	bh=lwxS7CEO4FN3nZ7Ps1CrnWE9EAD9GthkpGpEiD4qb7w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZQHgAD/1ZaISBy/Ft0HF1REdGuZaA2R8upY7Fa8FBCjZpgir5pXohPVrd6KdOI+czpJyTQr6d979Zp++KOiyKp46gRGibu6n6bP5WYyUj0TnlF7VpXUCIwOHSgloU0CexGTzPPJbQ2VsVyIa3+prlby8HhrUvJpHB9mbbiwHarY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4xiDDOl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4xiDDOl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE8231F000E9;
	Sat, 29 Aug 2026 12:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788006750;
	bh=26KHlqPOyTEFLuSdCQG1od/MU+Z4fLhNsfZ04I55dzY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X4xiDDOlfcNBeuKUlN9UfflimMQFrTCPCMKyh6L3unjy/PCQY17Viuz9rbPdcvOMW
	 w5lEYI9QnGWJ69XiPoVtyZWQmbJ5ak9zZj7wPAARfzf9lrpRTyvkpGfjHI6TJao1aT
	 qgdaT5msZSMFPDHhfVWc3T6a7V7yhm0xCxMKCe7uIkTi88VG2Us0rv+gKKenBqpRLY
	 DBl6aA4MfqeRM/gzIJa2TW1aSPRaTQ48Y8rCxiONUojYeC73Y06Z3TAmQlLNkTnpS/
	 493QKFHy3OE1dyOO6uYnJFyUQYxyMbXHn+7dzg/mN8+xuXwVp6FnwAQBVwuSzdhmex
	 35l3y14KjxWvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: drv260x - switch to using fsleep()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <apLOXaWFZ8ueIEAm@google.com>
References: <apLOXaWFZ8ueIEAm@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 29 Aug 2026 12:32:30 +0000
Message-Id: <20260829123230.BE8231F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] I2C communication failure in drv260x_resume due to incorrect GPIO =
sequence.
- [High] Lack of synchronization between haptic workqueue and system suspen=
d leads to I2C transfers to a powered-off device.
- [Medium] Incorrect timeout handling in drv260x_init loop may cause spurio=
us calibration failures.
--

commit 00b4c6fa5b7a9a1b697cc946bec3e6c6ae2eff9c
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

    Input: drv260x - switch to using fsleep()
   =20
    Switch from udelay() to fsleep() in drv260x_worker() as it runs in a
    sleepable workqueue context where busy-waiting is unnecessary.

> diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
> index 6c5c4c53753b1..477ec84ea09b8 100644
> --- a/drivers/input/misc/drv260x.c
> +++ b/drivers/input/misc/drv260x.c
> @@ -222,7 +222,7 @@ static void drv260x_worker(struct work_struct *work)
> =20
>  	gpiod_set_value(haptics->enable_gpio, 1);
>  	/* Data sheet says to wait 250us before trying to communicate */
> -	udelay(250);
> +	fsleep(250);

[Severity: High]
This is a pre-existing issue, but does switching to fsleep() widen the race
window between drv260x_worker() and system suspend?

If a haptic effect is playing during system suspend, drv260x_suspend() disa=
bles
the regulator without canceling haptics->work:

drivers/input/misc/drv260x.c:drv260x_suspend() {
    ...
	gpiod_set_value(haptics->enable_gpio, 0);

	error =3D regulator_disable(haptics->regulator);
    ...
}

Since fsleep() voluntarily yields the CPU, could this allow the suspend thr=
ead
to run and power down the device, resulting in regmap_write() attempting I2C
transfers to a powered-off chip when the worker resumes?

> =20
>  	error =3D regmap_write(haptics->regmap,
>  			     DRV260X_MODE, DRV260X_RT_PLAYBACK);

[Severity: High]
This isn't a bug introduced by this patch, but can I2C communication fail in
drv260x_resume() due to the GPIO enable sequence?

In drv260x_resume(), regmap_update_bits() is called before setting the
enable_gpio pin high:

drivers/input/misc/drv260x.c:drv260x_resume() {
    ...
		error =3D regmap_update_bits(haptics->regmap,
					   DRV260X_MODE,
					   DRV260X_STANDBY_MASK, 0);
		if (error) {
			dev_err(dev, "Failed to unset standby mode\n");
			regulator_disable(haptics->regulator);
			return error;
		}

		gpiod_set_value(haptics->enable_gpio, 1);
    ...
}

Since the hardware disables the I2C interface when the EN pin is low, won't
this transaction NACK and cause the resume sequence to abort?

[Severity: Medium]
This isn't a bug introduced by this patch, but could the timeout handling in
drv260x_init() cause spurious calibration failures?

In drv260x_init(), the loop checks for a timeout unconditionally after read=
ing
the register:

drivers/input/misc/drv260x.c:drv260x_init() {
    ...
		if (time_after(jiffies, timeout)) {
			dev_err(&haptics->client->dev,
				"Calibration timeout. The device cannot be used.\n");
			return -ETIMEDOUT;
		}
	} while (cal_buf =3D=3D DRV260X_GO_BIT);
    ...
}

If the timeout expires on the exact same iteration that the calibration
successfully completes (the GO bit is cleared), will this erroneously return
-ETIMEDOUT instead of successfully exiting the loop?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/apLOXaWFZ8ueIEAm@go=
ogle.com?part=3D1
