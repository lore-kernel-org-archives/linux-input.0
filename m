Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD623CF04C;
	Fri,  3 Jul 2026 12:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783080483; cv=none; b=cu5I9bWGT+y2kvpqpi9jwv/0E3F+ZmA/7L/ekBZncDcMaa/H1+EPt2/nQJW6xO9CxwdqzDlP5/x7k7qA4eu+7l7Hpb8VrVTtDt8RLwSEXi1f3hVKnCNyQ8zEZGIdRathtOYCVGXC6t0ef/pu2TFDiE6+XArk3VsZzAHXalBVq1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783080483; c=relaxed/simple;
	bh=sorSCel7H33Krvu9O1AD6KUVTG65pKT4PH/vej/3z2E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BXSvtmGld3D5ZoZKMlEOCuXZlCv2ClKyNO+JymTFnKR8vjI/FdpN5pzhUWylc1Nr78pJgY+BXyxJiSYyt4/uPGky6fKgMXqEobV4TIaGz4Ltb14QT6YLovWMQPjCP0NeNgT5UoNXDA8peW4WV5xdPsPMyuTwEI/qKUOgqLErb8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JuMBnS5y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JuMBnS5y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 553C01F00A3A;
	Fri,  3 Jul 2026 12:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783080481;
	bh=TRB8T9J8J3Qjo60bZILRknEcWmUMRrErAhmXWyYs054=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JuMBnS5ysRXvJCqRWZFKfkTQl/wHPqNwHo7w87c4Cjv4HgEoRtW6lm99kX4UbpPNZ
	 JeR6JuqwVi6Sldy7BB0pDzZ5qWBxH0HK71ZoV6rh6brKi4qXGYUrAy+6LBalyA64Rk
	 V6aZ2HXUjtcFBltiz5D6dB68mNTU/TG/NaSP+0WhTuyUkLloQIv2FIVMVpigFxXr8u
	 hDxH1DCv81wPfdEJiMAl70mFnS804Guh92PDLT9fd/fmj58oGpp+6X59lfWjK2WyUw
	 RB8PSr7LOOys1LQSAIty8fajh1Hnko/7mttvJSdPRg5AchbydlvJCGy6HOxUMq3gIF
	 8LxzQU8xq+y9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/7] i2c: of-prober: Defer regulator_disable() on
 successful probe in simple helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chen-Yu Tsai" <wenst@chromium.org>
Cc: dmitry.torokhov@gmail.com, devicetree@vger.kernel.org, linux-input@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260703115601.1323491-5-wenst@chromium.org>
References: <20260703115601.1323491-1-wenst@chromium.org>
 <20260703115601.1323491-5-wenst@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 12:08:00 +0000
Message-Id: <20260703120801.553C01F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The prober unconditionally sleeps for 100ms during the cleanup p=
ath even when no matching I2C component is found, unnecessarily delaying sy=
stem boot.
--

commit 772a8f5b00b1078ef6740a0746df36699760f2f2
Author: Chen-Yu Tsai <wenst@chromium.org>

i2c: of-prober: Defer regulator_disable() on successful probe in simple hel=
per

This patch defers regulator disabling in the I2C OF component prober by add=
ing
a 100ms delay. The delay allows asynchronously probing drivers to catch and
increase the regulator enable count, avoiding hardware re-initialization.

> diff --git a/drivers/i2c/i2c-core-of-prober.c b/drivers/i2c/i2c-core-of-p=
rober.c
> index f274e260353cd..17495125467ed 100644
> --- a/drivers/i2c/i2c-core-of-prober.c
> +++ b/drivers/i2c/i2c-core-of-prober.c
> @@ -243,11 +243,23 @@ static int i2c_of_probe_simple_enable_regulator(str=
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

[ ... ]

> @@ -409,7 +421,7 @@ void i2c_of_probe_simple_cleanup(struct device *dev, =
void *data)
>  	i2c_of_probe_simple_disable_gpio(dev, ctx);
>  	i2c_of_probe_simple_put_gpiod(ctx);
> =20
> -	i2c_of_probe_simple_disable_regulator(dev, ctx);
> +	i2c_of_probe_simple_disable_regulator(dev, ctx, true);

[Severity: Medium]
Does this unconditionally sleep for 100ms even when no matching I2C compone=
nt
is found?

If i2c_of_probe_component() iterates over potential components but finds no=
ne,
it calls ops->cleanup(dev, ctx), which invokes i2c_of_probe_simple_cleanup(=
).

Because defer_disable is hardcoded to true here,
i2c_of_probe_simple_disable_regulator() will execute the 100ms sleep.

Could this result in an unnecessary 100ms boot delay on systems missing the
probed component, since no async driver will ever probe in this failure pat=
h?

>  	i2c_of_probe_simple_put_supply(ctx);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703115601.1323=
491-1-wenst@chromium.org?part=3D4
