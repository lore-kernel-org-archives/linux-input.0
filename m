Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9616923EAA6;
	Tue, 25 Aug 2026 04:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787633323; cv=none; b=B9ZeE/bdQu2TxMmVkE8AMAMEEAeX/K6NT4MZohnEZp3aJuNQltBTDxK5XY+tHoS8VNFRqiVClIRf9RuNse0sx/g495N8GZN8olxK0otYTzgnhBDTP/Z8wE80Uw12z0K46aCsM2uXfQKF9KshTXExcZUTDlrV+HonB460ypO5BY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787633323; c=relaxed/simple;
	bh=rQjr82gr194SCdLAxVTubG+36Z2PmXKaxqEXYfrQ08I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZgYSijVEvdjlQNj/XAZY561nt+P7mZPqRuybVPoY5+yrnSLaSYtjbWihJBmebK7PnH7Swe+REOTB0E1pulsV50lLaehAHng0clKRLNd351ER/IB+8J7uAINzuZYybgnw2Up9R2YilNEY3bmkWSKX8CMyLt08cBgJHD9NI7QsaeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOnoGWz1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOnoGWz1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E199B1F000E9;
	Tue, 25 Aug 2026 04:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787633322;
	bh=leEzbCkAXfD3U61dCOQpjuG5uo2RLseT3RhdRhsmRRQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UOnoGWz1SNqFjvRRTmTXSDP8f/SwVkLwTEfvBDbAS0FW9koQBWXbchtqEEsZQjWN9
	 ZqXTbgrSI5Vn0KS296a17Dk5b7YudLovRRDfHO6gcC8m49iVaDKgfCPCIkO7rsfP1W
	 yTpg4ejMZzBQ4QKPjn552r1NoBaCmZG1jBlph9vqjnvdb+0Pp/GaK4+G8sBl6JhRi/
	 nmu8e86idbOEnhK9RcygTVyzKUrDw+wiiUPNsgOu2CXwlDP/gl9Zzi6IEyZ9Oxc1cO
	 go1XjvVSGrPw1h9zwrRntlCnPEqobnyuA3ij4g7ipCoIn376Vbq+w0IMZMtYUjsy2i
	 9tuOSWJCVEe5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/7] i2c: of-prober: Defer regulator_disable() on
 successful probe in simple helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chen-Yu Tsai" <wenst@chromium.org>
Cc: dmitry.torokhov@gmail.com, robh@kernel.org, linux-input@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260825041628.988369-6-wenst@chromium.org>
References: <20260825041628.988369-1-wenst@chromium.org>
 <20260825041628.988369-6-wenst@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 04:48:41 +0000
Message-Id: <20260825044841.E199B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] regulator_bulk_enable_and_wait() fails to set wait_us for all cons=
umers except the first one, leading to uninitialized memory reads
- [High] _regulator_is_enabled(rdev) is called locklessly in regulator_regi=
ster() after the device is exposed, causing data races
- [Medium] Unconditional 100ms boot penalty in i2c_of_probe_simple_cleanup =
when no I2C component is found
--

--- Patch [5]: [PATCH v5 5/7] i2c: of-prober: Defer regulator_disable() on =
successful probe in simple helper ---
commit 227ad2dc27d8706adbb141c1fb7f00da090435f9
Author: Chen-Yu Tsai <wenst@chromium.org>
Subject: i2c: of-prober: Defer regulator_disable() on successful probe in s=
imple helper

This commit delays dropping the regulator enable refcount for 100 ms when t=
he
cleanup function is called. This gives asynchronous drivers time to probe
and increase the refcount themselves, avoiding the need to wait for hardware
re-initialization if the regulator was disabled just prior to probing.

> diff --git a/drivers/i2c/i2c-core-of-prober.c b/drivers/i2c/i2c-core-of-p=
rober.c
> index f9f3c0ef93ff5..68c929b16b066 100644
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

[Severity: Medium]
Will this unconditionally penalize boot time by 100ms when no I2C component=
 is
found?

If the prober finishes without finding any responding devices, it falls back
to calling the cleanup function. Since i2c_of_probe_simple_cleanup() hardco=
des
defer_disable to true, this sleep is triggered even when there is no device
present to probe asynchronously.

[ ... ]
> @@ -401,7 +413,7 @@ void i2c_of_probe_simple_cleanup(struct device *dev, =
void *data)
>  	i2c_of_probe_simple_disable_gpio(dev, ctx);
>  	i2c_of_probe_simple_put_gpiod(ctx);
> =20
> -	i2c_of_probe_simple_disable_regulator(dev, ctx);
> +	i2c_of_probe_simple_disable_regulator(dev, ctx, true);
>  	i2c_of_probe_simple_put_supply(ctx);
>  }

While reviewing this series, I also noticed regressions introduced in
patch 1 of this series.

commit 5fd97a59a5c2607c473a3bc31a58415b701f2335
Author: Chen-Yu Tsai <wenst@chromium.org>
Subject: regulator: core: Add "enable and wait" functions

This patch introduces a "last turned on" timestamp field to the regulator
device and adds "enable and wait" functions to the single and bulk regulator
consumer APIs. The timestamp is updated each time the regulator is actually
turned on, allowing drivers to shorten or skip post-power-on delays.

> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index 1797929dfe566..f70be7e38e599 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
[ ... ]
> @@ -5372,30 +5444,38 @@ static void regulator_bulk_enable_async(void *dat=
a, async_cookie_t cookie)
>  {
>  	struct regulator_bulk_data *bulk =3D data;
> =20
> -	bulk->ret =3D regulator_enable(bulk->consumer);
> +	bulk->ret =3D regulator_enable_and_wait(bulk->consumer, ACCESS_PRIVATE(=
bulk, wait_us));
>  }
> =20
>  /**
> - * regulator_bulk_enable - enable multiple regulator consumers
> + * regulator_bulk_enable_and_wait - enable multiple regulator consumers =
and
> + *				    wait for time passed after regulators are
> + *				    actually enabled
[ ... ]
> -int regulator_bulk_enable(int num_consumers,
> -			  struct regulator_bulk_data *consumers)
> +int regulator_bulk_enable_and_wait(int num_consumers,
> +				   struct regulator_bulk_data *consumers,
> +				   unsigned int wait_us)
>  {
>  	ASYNC_DOMAIN_EXCLUSIVE(async_domain);
>  	int i;
>  	int ret =3D 0;
> =20
>  	for (i =3D 0; i < num_consumers; i++) {
> +		ACCESS_PRIVATE(consumers, wait_us) =3D wait_us;
>  		async_schedule_domain(regulator_bulk_enable_async,
>  				      &consumers[i], &async_domain);
>  	}

[Severity: High]
Does this code fail to set wait_us for all consumers except the first one?

Because consumers is an array pointer, ACCESS_PRIVATE(consumers, wait_us)
expands to consumers[0].wait_us, completely ignoring the loop index i.

This leaves consumers[1..N].wait_us uninitialized. When the async worker la=
ter
calls regulator_enable_and_wait(), it will read uninitialized memory. This =
can
cause long boot delays if the garbage value is large, or hardware
synchronization failures if it happens to be zero.

[ ... ]
> @@ -6225,6 +6305,13 @@ regulator_register(struct device *dev,
>  			goto del_cdev_and_bdev;
>  	}
> =20
> +	/*
> +	 * If no supply was given, then the last_on timestamp could not have
> +	 * been updated in regulator_resolve_supply(). Check it here.
> +	 */
> +	if (!rdev->supply_name && !rdev->last_on && _regulator_is_enabled(rdev))
> +		rdev->last_on =3D ktime_get_boottime();
> +
>  	rdev_init_debugfs(rdev);

[Severity: High]
Can this cause data races or hardware state corruption?

This calls _regulator_is_enabled(rdev) locklessly, and potentially writes to
rdev->last_on, after device_add() has already exposed the device to consume=
rs
and userspace sysfs.

If userspace reads sysfs state attributes concurrently, or a driver calls
regulator_enable(), it could invoke the driver's is_enabled hardware callba=
ck
without synchronization.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825041628.9883=
69-1-wenst@chromium.org?part=3D5
