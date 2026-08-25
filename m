Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E691E11CA9;
	Tue, 25 Aug 2026 04:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787633252; cv=none; b=PPpTjam+U3184B4DL5UfuNfHgT/zOSZipD8V6qMbT0b0jc5SIUdbgOIum9dyyUZ4rstceL1GxytK0xgZ6i8oVTxc7qE4/Mf2mdBbF5rfzbdjdL5EHmtIEvsXHKRPUqi59P4voLusZh6GKpncWwh9rfC07jzdcNx2CbPaTEzakkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787633252; c=relaxed/simple;
	bh=R8O129ym7Wphfvd2+iweYn8BtzF+ACJNt6fEw7oozQs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t3lT/ThNXNX4eudpntAcs0lysVryfg5UJ8x6Svft5l3e6gkSLbK5UYokSSBqew7GFNTLGgUOwbbtRpvlvGQ7pnWjdb7aklK2F4zRVmZN4Kx1LiRmLYzwKgPsEQX2s07GUTjO81alxp533oli7YYWiavW4iJSbFT9k7pxeaeGUAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsgRw1ki; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsgRw1ki"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29A151F000E9;
	Tue, 25 Aug 2026 04:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787633250;
	bh=ckekgV5OPY2rHPkVfyxAE2QotpKAy8HlTiVAi9aqKMY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UsgRw1kiXCc6ypjIXoNiPgR2AkHmfOrQVVguF8UhfZCPbpVvk61z+x2af+WVKZ3Q9
	 q8GpwgxgtMu/Rc2yUpGgjvCfTUcUQWGVn/S3671ikWZ0mSunyg15+UjJg36NnKG0mb
	 CnTXgUO0SiIDryij3tAwidXJ6h7skH0HbXP21BXH46QPRrQ2oFZLHbXG6KTOx4jC46
	 pYb6lz3ccPWXG1S+nRhEGz1Dtb8jfI1BiuSZiMQXyabdhVOnFyTjPqM6sc/nD7WrBC
	 AhIBTdjehI5OHsDA7ScjO1wOH9Dbnl3yeTXkmN9+dhVTGOXXO4ifMslnGlGIZ6nl1i
	 PcCG8pITU03Zw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/7] regulator: core: Add "enable and wait" functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chen-Yu Tsai" <wenst@chromium.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260825041628.988369-2-wenst@chromium.org>
References: <20260825041628.988369-1-wenst@chromium.org>
 <20260825041628.988369-2-wenst@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 04:47:29 +0000
Message-Id: <20260825044730.29A151F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] regulator_bulk_enable_and_wait incorrectly assigns wait_us only to=
 the first consumer, leaving the rest uninitialized.
- [High] regulator_register accesses hardware state via _regulator_is_enabl=
ed and updates rdev->last_on without holding rdev->mutex after the device i=
s exposed.
- [Medium] _regulator_is_enabled() and _regulator_is_enabled_recursive() ca=
n return negative error codes, but they are used in boolean contexts where =
negative values evaluate to true.
--

--- Patch [1]: [PATCH v5 1/7] regulator: core: Add "enable and wait" functi=
ons ---
commit 5fd97a59a5c2607c473a3bc31a58415b701f2335
Author: Chen-Yu Tsai <wenst@chromium.org>

regulator: core: Add "enable and wait" functions

This patch introduces "enable and wait" functions to the single and bulk
regulator consumer APIs. It tracks a "last turned on" timestamp to shorten
or skip delays if the regulator is already on. The timestamp is also best
effort populated for regulators left on by hardware or firmware.

> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index 1797929dfe566..f70be7e38e599 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -2352,6 +2390,14 @@ static int regulator_resolve_supply(struct regulat=
or_dev *rdev)
>  		}
>  		rdev->constraints_pending =3D false;
>  	}
> +
> +	/*
> +	 * regulator was left on but not enabled with .always_on or .boot_on
> +	 * constraints, and thus .last_on timestamp is still invalid.
> +	 */
> +	if (!rdev->last_on && _regulator_is_enabled_recursive(rdev))
> +		rdev->last_on =3D ktime_get_boottime();
> +

[Severity: Medium]
_regulator_is_enabled_recursive() can return negative error codes. Since it
is evaluated in a boolean context here, won't negative values evaluate to
true, causing last_on to be incorrectly updated if there is a hardware read
failure?

>  	regulator_unlock_dependent(rdev, &ww_ctx);
> =20
>  	if (!do_final_setup)

[ ... ]

> @@ -5372,30 +5444,38 @@ static void regulator_bulk_enable_async(void *dat=
a, async_cookie_t cookie)
>  int regulator_bulk_enable_and_wait(int num_consumers,
>  				   struct regulator_bulk_data *consumers,
>  				   unsigned int wait_us)
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
Does this loop assign wait_us only to the first element of the array instead
of using the loop counter i? For subsequent consumers where i > 0, the
wait_us field remains uninitialized.

When regulator_bulk_enable_async() executes for these subsequent consumers,
could it read uninitialized memory and pass it to fsleep(), potentially
hanging the kernel thread indefinitely or skipping required delays? Should
this be ACCESS_PRIVATE(&consumers[i], wait_us)?

>  	async_synchronize_full_domain(&async_domain);

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

[Severity: Medium]
Similar to the case in regulator_resolve_supply(), _regulator_is_enabled()
can return negative error codes. Could this cause last_on to be updated
incorrectly if the hardware read fails during probe?

[Severity: High]
Since device_add(&rdev->dev) is called earlier in regulator_register(),
exposing the device globally and allowing concurrent regulator_enable()
calls, is it safe to call _regulator_is_enabled(rdev) and update
rdev->last_on here without holding rdev->mutex? This could lead to a data
race on last_on and unsynchronized hardware callbacks.

>  	rdev_init_debugfs(rdev);
> =20
>  	/* try to resolve regulators coupling since a new one was registered */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825041628.9883=
69-1-wenst@chromium.org?part=3D1
