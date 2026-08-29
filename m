Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9823AA4E9
	for <linux-input@vger.kernel.org>; Sat, 29 Aug 2026 23:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788044861; cv=none; b=aglQe8/8FgoU8FZdnUwgSFRitQNNweFaT7G1gByiMem3uDQDWGjtvJKMfBvP+KmT7Q1eUt4YWH8ndVof+dtZ1ynhom05B6torGctm1Nr3ozbOJ0lpMm+13sRZOOd/Neg3+30ez3VfCRM04sboAksa4XYbuIDtsFsZfu+3IsudWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788044861; c=relaxed/simple;
	bh=2A251/4ZE/2rlu1GdzMAKuec6NTT7JXqjJWKg0OKJ6g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rcyfy/XgB6VCThPEYdJUAA3BqCRThyUvhOApYr885xNI1eMNE+9+zProATKaxc6WWFfBGPaQemCuPf5m4E8nm1jfwK446HTfaeK2iDE75h6GeyQeR2yFbh81nNmN7KBuXx4b6mH8YLEBvR8uLL8MGMK3Dl+AdHK/qYFrUAgtsZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAV9Q5mz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAV9Q5mz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 126461F000E9;
	Sat, 29 Aug 2026 23:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788044860;
	bh=EVIRyDY4eDb6ozrqVGKzEEWpXAuG1qJlI4AXm7FD1Zo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bAV9Q5mzgxvoBBkkQTDX7dE6D/k7WxRT4ovl2j07e0+IfroUgqn0X4WYPFwq++YmE
	 YmxEY46l9sTBLh2BP2rVp/fKJQSeqUgcc/gaUr5IkocViUGZsR9mi9RS2fK/dbj4HM
	 YZcpzvXLpu360xix2k5L3GTykb6xYZ1fLVskkAR5H1BidRS0o45LYtY7RShKdrY2Ec
	 BKWZHDFUjH2mJUWaBQtRa/Q+3jIi6fRWT4Z7bHDvVOWjp0qaufGnlXRw83pBGyS34E
	 jAAQRVjQBL6j46UkdVW7nWyFJB6Wmz3BDv/8JqgJJKOePU5mxqniKhwA+Cqrnm8oN/
	 pKxOpELyOov5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] Input: drv260x: Fix suspend and resume sequencing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maurizio Casciano" <mauriziocasciano7@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260829225704.394707-1-mauriziocasciano7@gmail.com>
References: <apLD91vzHIrLOPWC@google.com>
 <20260829225704.394707-1-mauriziocasciano7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 29 Aug 2026 23:07:39 +0000
Message-Id: <20260829230740.126461F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The workqueue disable count becomes unbalanced if drv260x_resume()=
 fails, permanently disabling haptic playback on subsequent successful resu=
mes.
- [Medium] Mixing goto-based error handling with scope-based guard() cleanu=
p in the same function.

Pre-existing issues:
- [High] The device loses its register configuration during system suspend =
because the regulator is disabled, but resume fails to reinitialize the reg=
isters.
--

commit 38e8103cb03d4a564c39fb41cb33305800090398
Author: Maurizio Casciano <mauriziocasciano7@gmail.com>

Input: drv260x: Fix suspend and resume sequencing

This commit updates the suspend and resume routines to correctly drain and
disable the haptics worker before entering standby. It also adds goto-based
error unwinding and uses the enable GPIO to gate I2C access while enforcing
a startup delay.

Link: https://lore.kernel.org/linux-input/apLD91vzHIrLOPWC@google.com/

> diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
> --- a/drivers/input/misc/drv260x.c
> +++ b/drivers/input/misc/drv260x.c
> @@ -569,18 +569,20 @@ static int drv260x_probe(struct i2c_client *client)
>  static int drv260x_suspend(struct device *dev)
>  {
>  	struct drv260x_data *haptics =3D dev_get_drvdata(dev);
> -	int error;
> +	int error, restore_error;
> =20
>  	guard(mutex)(&haptics->input_dev->mutex);

[ ... ]

>  		if (error) {
>  			dev_err(dev, "Failed to set standby mode\n");
> -			return error;
> +			goto err_enable_work;
>  		}

[Severity: Medium]
Does this mix goto-based error handling with scope-based guard() cleanup in
the same function?

The kernel cleanup subsystem guidelines explicitly forbid mixing goto and
guard() because it creates confusing ownership semantics. While the lock is
correctly released at the function return in this specific code structure,
the pattern itself is prohibited by subsystem rules.

[ ... ]

>  		error =3D regulator_disable(haptics->regulator);

[Severity: High]
This is a pre-existing issue, but I noticed the regulator is disabled during
suspend, which completely cuts power to the chip and resets its internal
register state.

When the regulator is re-enabled during drv260x_resume(), the driver only
clears the standby bit and fails to reprogram the operational registers like
rated voltage and overdrive. Because the driver uses REGCACHE_NONE and does
not automatically restore register state, does this leave the hardware
unconfigured and functionally broken after a suspend and resume cycle?

[ ... ]

>  static int drv260x_resume(struct device *dev)
>  {
>  	struct drv260x_data *haptics =3D dev_get_drvdata(dev);
>  	int error;
> =20
>  	guard(mutex)(&haptics->input_dev->mutex);
> =20
>  	if (input_device_enabled(haptics->input_dev)) {
>  		error =3D regulator_enable(haptics->regulator);
>  		if (error) {
>  			dev_err(dev, "Failed to enable regulator\n");
>  			return error;
>  		}

[Severity: High]
If regulator_enable() fails here, we return directly without calling
enable_work(&haptics->work).

Since disable_work_sync() was called in drv260x_suspend(), doesn't this lea=
ve
the workqueue's disable count unbalanced? The PM core treats resume errors =
as
non-fatal to the system, so a subsequent suspend will increment the disable
count again to 2. A future successful resume will only decrement it to 1,
leaving the haptics playback permanently disabled.

[ ... ]

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

[Severity: High]
Similarly, if we take the err_disable_regulator goto path when leaving
standby fails, enable_work() is skipped.

Does this also permanently leak the workqueue disable count?

[Severity: Medium]
Also, just like in drv260x_suspend(), drv260x_resume() introduces a new
goto path while using guard(mutex) at the start of the function.

Could we refactor this to avoid mixing goto labels and scope-based cleanup?

> -		gpiod_set_value(haptics->enable_gpio, 1);
> +		enable_work(&haptics->work);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260829225704.3947=
07-1-mauriziocasciano7@gmail.com?part=3D1
