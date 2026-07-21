Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105C740800F;
	Tue, 21 Jul 2026 08:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784621311; cv=none; b=F8jEOloShYLtPMjN3uINhIHx5HdBD1oVYgUGU8YW7vtfxN0XENyfR9KaZiUR1au76YUIhfWiRxbcGQvqKMzsosZ2VwwwuQwl4fYyn5vNwK5gAi9kCu/k37bi3bxB4GUQHI9KrACt0ljX84Icz1K95BXgNsejIc1g69Fky8/FdjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784621311; c=relaxed/simple;
	bh=bcHeo/RVdLntmhSQtlWiBZmOzYrW3V2BLdtdGcpBC74=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nSnCw9T1OCEG74VXxO5bvpNBH2/iVNogpk6CjwKa2K/uAP8qB6S/yhkKXTYO9vzumqXVTO1C/BPsL9B0yxLhdbti/5M0ARgUKdCW5jV37pTjB6bO1+AZQXiH28L63rTeFLkXFqMlp65Jh9bwdLR8Fxpd0ErIjSodrTiJJYpf8Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBSUrZsd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBSUrZsd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4153C1F000E9;
	Tue, 21 Jul 2026 08:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784621309;
	bh=9dxEszODnUqhamKgqYauyDeZ8XRE/FAWeLfWfAHAr/I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oBSUrZsd2gUxAdt3ah+NXO9yOILiPVAwEXQkKADhtKpSW2S4M749ZbmXffuq7VAhf
	 NEyF3qB9wpADe9EHpRMYiKl1J40wiSukVJYUghfTt8VPG53u28LzOVpFbDM5iZn3NF
	 K+rk8yOMbfCSBUIF2+5W6ctxAUKXOEGtKUkKGKrnCBitx6UHwCkP11+ZPEsQ4A07j3
	 9e3RzarXJEaBJ1QMHiY68UGycusm4gU2NhX+1LlxjZcu60LE68DnmpOEPrALk3grbb
	 UXMuEg0Zyrx4+eqKhuEmqcXI7GwC1Rp/GcwLcRptzZmwSZpYenKxSBdMQ/hESmXc5/
	 +kgwQcmgU6YCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/9] regulator: core: Add "enable and wait" functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chen-Yu Tsai" <wenst@chromium.org>
Cc: conor+dt@kernel.org, dmitry.torokhov@gmail.com, robh@kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260721075226.2347933-2-wenst@chromium.org>
References: <20260721075226.2347933-1-wenst@chromium.org>
 <20260721075226.2347933-2-wenst@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 08:08:28 +0000
Message-Id: <20260721080829.4153C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The prototype for `regulator_enable_and_wait` in `consumer.h` inco=
rrectly names the delay parameter `ms` instead of `wait_us`, inviting devel=
opers to pass millisecond values that will be incorrectly interpreted as mi=
croseconds.
- [High] Sleeping for the consumer delay while holding the recursive `ww_mu=
tex` for the regulator and its entire parent supply chain severely degrades=
 concurrency, blocking shared regulators and serializing async bulk enablem=
ent.
--

--- Patch [1]: [PATCH v3 1/9] regulator: core: Add "enable and wait" functi=
ons ---
commit 73793dc0bdc3050ff22074a860d438d5d9cc0b49
Author: Chen-Yu Tsai <wenst@chromium.org>

regulator: core: Add "enable and wait" functions

This commit introduces new "enable and wait" functions to the regulator cor=
e,
allowing consumers to ensure a minimum amount of time has passed since a
regulator was actually turned on. It adds a last_on timestamp to the
regulator device and updates single and bulk enable APIs to accept a wait t=
ime.

> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index 1797929dfe566..d14ce86d8f7bb 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c

[ ... ]

> @@ -3159,13 +3162,24 @@ static int _regulator_enable(struct regulator *re=
gulator)
>  		} else if (ret < 0) {
>  			rdev_err(rdev, "is_enabled() failed: %pe\n", ERR_PTR(ret));
>  			goto err_consumer_disable;
> +		} else {
> +			/* regulator already enabled somehow, but timestamp might be invalid =
*/
> +			if (!rdev->last_on)
> +				rdev->last_on =3D ktime_get_boottime();
>  		}
> -		/* Fallthrough on positive return values - already enabled */
>  	}
> =20
>  	if (regulator->enable_count =3D=3D 1)
>  		rdev->use_count++;
> =20
> +	if (wait_us) {
> +		ktime_t end =3D ktime_add_us(rdev->last_on, wait_us);
> +		s64 remaining =3D ktime_us_delta(end, ktime_get_boottime());
> +
> +		if (remaining > 0)
> +			fsleep(remaining);
> +	}
> +

[Severity: High]
Does sleeping here while holding the recursive ww_mutex for the regulator a=
nd
its parent supply chain cause concurrency issues?

Since regulator_enable_and_wait() acquires these locks via
regulator_lock_dependent() before calling _regulator_enable_and_wait(), this
sleep happens while the locks are held.

In cases like regulator_bulk_enable_and_wait() where async workers are crea=
ted
to enable regulators in parallel, won't this serialize the wait times for a=
ny
consumers sharing a parent supply, defeating the purpose of the async desig=
n?

>  	return 0;
> =20
>  err_consumer_disable:

[ ... ]

> diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator=
/consumer.h
> index 56fe2693d9b22..a69157c9b5b51 100644
> --- a/include/linux/regulator/consumer.h
> +++ b/include/linux/regulator/consumer.h

[ ... ]

> @@ -192,7 +193,7 @@ int devm_regulator_bulk_register_supply_alias(struct =
device *dev,
>  					      int num_id);
> =20
>  /* regulator output control and status */
> -int __must_check regulator_enable(struct regulator *regulator);
> +int __must_check regulator_enable_and_wait(struct regulator *regulator, =
unsigned int ms);

[Severity: High]
Could the naming of this parameter cause consumers to inadvertently pass
millisecond values that get interpreted as microseconds?

The prototype here defines the parameter as ms, but the implementation and
the parameter passed to ktime_add_us() inside _regulator_enable_and_wait()
treat it strictly as microseconds.

If a driver developer passes 10 expecting a 10-millisecond delay based on t=
his
header, the core will interpret it as 10 microseconds. Could this lead to
hardware initialization failures due to premature access to unstable power
supplies?

>  int regulator_disable(struct regulator *regulator);
>  int regulator_force_disable(struct regulator *regulator);
>  int regulator_is_enabled(struct regulator *regulator);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721075226.2347=
933-1-wenst@chromium.org?part=3D1
