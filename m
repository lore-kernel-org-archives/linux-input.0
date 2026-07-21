Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A683D1E47C5;
	Tue, 21 Jul 2026 08:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784621163; cv=none; b=iR4xH4zXUbmPBhMii2S6abcDCQfKEZzoS0uG7z7Um1sRxtHaQHN72PLk6iozju8gowSBXFhZKHM/EYJuPH52UqKsNcZdMPEZuNbCi+7Gee+SyJ0ROkcK1Di5K2S7wM6kFVjsBy8CV9Jwc6Runmx6Apypsu0rackvQIlLEgIVfZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784621163; c=relaxed/simple;
	bh=4KpYSR7eR8ZE7M2idHDkzxZ57eSbBedicUdpOqV1muU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tFtMhUbZdpNxzf2tYwExOOrUj3qmwnTihOkrPfALQI20VmwGY5nnQg7YPd8HlsfBwiouNtlgsE7w2hwc+Xf6fdgk4qpM0FczWu1pDgQYxLNaDXcZvenBD5TEtEaQ4h2DFvJPGBQmSKYKUs4q0KlkIGq+NzXq8pwZAvJ7KCWbdwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H2d4mHsC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2d4mHsC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A121F000E9;
	Tue, 21 Jul 2026 08:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784621162;
	bh=0DOJw8prIOhCGba5efQN7KjIUqWDjarjR/vSKc1mu6E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H2d4mHsCh6A9Fc76XGmZ5udDmwE9IXhLqQeDP80aSQCRE03koa9Kwd9DGx/PXCQsl
	 dRGbRqxLFbHToFuDdjMPKL9GupiZxwdhQcHLCi0wlaRZXSNtdwHwKGMgEFSnkndGX6
	 dsoa7OEiktXdAsY9A9RRL7rgu3T5A+QuwyU50pwz3tSv4vIe4G8t7vXQn9sq3CWmCR
	 e1Axa2WSrX41n66u4AS9XbIYPs/UJzQIjI0vislSTbCn6v0GQ7qJ0jclq+JHjHQPB+
	 hCXz98B8F+JhAgic1sXDy2SFU/MBG46+rgLt++WXVh+5+cST4QwSoLyeOpdb5c/ZBn
	 kA9nxwDLBHzbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/9] i2c: of-prober: Defer regulator_disable() on
 successful probe in simple helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chen-Yu Tsai" <wenst@chromium.org>
Cc: robh@kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260721075226.2347933-7-wenst@chromium.org>
References: <20260721075226.2347933-1-wenst@chromium.org>
 <20260721075226.2347933-7-wenst@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 08:06:01 +0000
Message-Id: <20260721080602.26A121F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Unconditional 100ms boot delay during cleanup when no I2C compon=
ent is found.
--

--- Patch [6]: [PATCH v3 6/9] i2c: of-prober: Defer regulator_disable() on =
successful probe in simple helper ---
commit ea6b3a85720b084309159275d4c96f6a15c76ff3
Author: Chen-Yu Tsai <wenst@chromium.org>

i2c: of-prober: Defer regulator_disable() on successful probe in simple hel=
per

This commit introduces a 100ms delay before disabling the regulator during
cleanup. This allows async drivers time to probe and increment the
regulator enable count, avoiding hardware re-initialization delays.

> diff --git a/drivers/i2c/i2c-core-of-prober.c b/drivers/i2c/i2c-core-of-p=
rober.c
> --- a/drivers/i2c/i2c-core-of-prober.c
> +++ b/drivers/i2c/i2c-core-of-prober.c

[ ... ]

> @@ -235,11 +235,23 @@ static int i2c_of_probe_simple_enable_regulator(str=
uct device *dev, struct i2c_o
>  	return 0;
>  }
> =20
> -static void i2c_of_probe_simple_disable_regulator(struct device *dev, st=
ruct i2c_of_probe_simple_ctx *ctx)
> +static void i2c_of_probe_simple_disable_regulator(struct device *dev,
> +						  struct i2c_of_probe_simple_ctx *ctx,
> +						  bool defer_disable)
>  {
>  	if (!ctx->supply)
>  		return;
> =20
> +	/*
> +	 * Wait a bit of time for async drivers to probe and increase the
> +	 * regulator enable count. This allows the drivers to check and
> +	 * skip waiting for re-initialization.
> +	 */
> +	if (defer_disable) {
> +		dev_dbg(dev, "Deferring regulator disable\n");
> +		msleep(100);
> +	}
> +
>  	dev_dbg(dev, "Disabling regulator supply \"%s\"\n", ctx->opts->supply_n=
ame);
> =20
>  	regulator_disable(ctx->supply);

[ ... ]

> @@ -401,7 +413,7 @@ void i2c_of_probe_simple_cleanup(struct device *dev, =
void *data)
>  	i2c_of_probe_simple_disable_gpio(dev, ctx);
>  	i2c_of_probe_simple_put_gpiod(ctx);
> =20
> -	i2c_of_probe_simple_disable_regulator(dev, ctx);
> +	i2c_of_probe_simple_disable_regulator(dev, ctx, true);

[Severity: Medium]
Will this cause an unconditional 100ms boot delay if no I2C component is
found?

When i2c_of_probe_component() finishes its scan without finding a
responding component, it still unconditionally calls ops->cleanup():

drivers/i2c/i2c-core-of-prober.c:i2c_of_probe_component() {
    ...
    if (ops->cleanup)
        ops->cleanup(dev, ctx);
    ...
}

This invokes i2c_of_probe_simple_cleanup(), which now passes
defer_disable =3D true, triggering the msleep(100) even when nothing was
probed.

Could this delay be skipped if no component was actually found?

>  	i2c_of_probe_simple_put_supply(ctx);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721075226.2347=
933-1-wenst@chromium.org?part=3D6
