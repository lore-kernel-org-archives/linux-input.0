Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793682695;
	b=0ukw1bZVWRKh+D3i3hU3dMetgrqdaW22RuMXmwFnpIuceCooLduwi51BAOQUibR//6kc
	 vMjYKlco7XsaVY04AmGR2WTveKiT8QZhBw2ibODONV+JYt7h2rH91Qp/ecTRj2CjoIbBY
	 X9rAKR1Ac7ikzQOACWJUMa/tPcBIM23+VFtj5Na8labR8p8AGCVY1VoDvHoA7PLSTTZ6z
	 X1oNEm2bg4JzQrMXGNo4WjedK6YffJCmXVfiPf997f/kbT6QmJsqcmK6alFVqHysYrzAX
	 zGZMKiV4PMOKi4B88M7wXapC+Vr3uV1+S6nuDkE8R9YD02GssRvYPbI+U0N9utvgLWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793682695;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=f6kdy4iAT+CSo2RiVPKwwuUUR3is2RPRIL28pMq0NLo=;
	b=YSSYUstzrWvf/+CIIUf1o3mrLfskSajAE8RRFXdJjvXdXHemEOfAxxkhe9w6M/WcpO83
	 3NjGV1xobZLIIQ+e8aMKoYahKFFZCl+4OJAhFOAT52RreS6kH2jUNR1ROC1/2GGiavj/O
	 +pr5s0rDOOWq9JBPZDJOqxdjrDlo5w+W7OKj+gVHlKv9J91PLNUdKcmq9mgcssvsb4MaS
	 3hvw2/4zHoB1u5NfBVTA3oJFyYt+1/D2Y3LUM06ZwpspamWV537cRiT0HbyXnSukK2Qh7
	 30kPPQd035UdvYHj1atT0gO0pcq1igEkHDubznZ7M7UiBs7oJOf8NzitG/aL7/vC2sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JWT5S4Xe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F890606A326;
	Tue,  3 Nov 2026 05:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JWT5S4Xe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8F31F000C1;
	Tue,  3 Nov 2026 05:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793682694;
	bh=f6kdy4iAT+CSo2RiVPKwwuUUR3is2RPRIL28pMq0NLo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JWT5S4XeaeXCJa7qhGKEgufG5KeyzNgKUxBvrcCnMLwcgyqtFsoG2V55CA2GctqQt
	 GJLDBRC3LbuxalYiznvIBVZsMOMmOm5TzAM9PqWwEwQULyd7X/U8SrENjvmKS6+tqB
	 w4mGWeD/PpSEdbpohrZJfiQCBcGtDlV+4wN5auuOJubDZ26XDK2Q4yuOTEfDdvVn5d
	 rcd3yuZf6Bz6vM6rciGPpxTgCIJfEYr7t5qaSYV65kgCky5IRNilH1KN2poIonxbF/
	 uHeUFPr+YUKhWArHtRxAcEceLmsKDiIpL/GH7OpsIqjyAJUg0xGR3LYBG/tY8RpQdR
	 TNanmiweLGAcw==
Message-ID: <sashiko-outbox-194592@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/8] regulator: core: Add "enable and wait" functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chen-Yu Tsai" <wenst@chromium.org>
Cc: devicetree@vger.kernel.org, linux-input@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261103043734.2179858-2-wenst@chromium.org>
References: <20261103043734.2179858-1-wenst@chromium.org>
 <20261103043734.2179858-2-wenst@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 05:11:32 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] regulator: core: unlocked _regulator_is_enabled_recursive() in e=
arly resolve
- [Medium] regulator: core: stale last_on timestamp after disable skips ena=
ble wait
- [Medium] regulator: core: uninitialized last_on in set_machine_constraint=
s()
--

commit 10272782c962e94533f9c00c5f660ea31ea2ca13
Author: Chen-Yu Tsai <wenst@chromium.org>

regulator: core: Add "enable and wait" functions

This commit adds a last_on timestamp field to struct regulator_dev and
introduces regulator_enable_and_wait() and regulator_bulk_enable_and_wait()
to wait for the remaining turn-on delay after a regulator is actually
enabled.

> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index 14422cfe80e2d..071f9f8185f63 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c

[ ... ]

> @@ -2188,6 +2188,45 @@ static struct regulator_dev *regulator_dev_lookup(=
struct device *dev,
>  	return ERR_PTR(-ENODEV);
>  }
> =20
> +/**
> + * _regulator_is_enabled_recursive - is the regulator output enabled all
> + *				     the way to the root supply
> + * @rdev: regulator device
> + *
> + * Only intended for checking regulators that have been left on by
> + * hardware default or firmware.
> + *
> + * Assumes supplies have been resolved. Must be called with dependent
> + * locks held.
> + *
> + * Return: Positive if the regulator output backing the source/client,
> + *	   and all of its upstream supplies, have requested that their
> + *	   respective device be enabled, zero if any of them hasn't,
> + *	   else a negative error number.
> + */
> +static int _regulator_is_enabled_recursive(struct regulator_dev *rdev)
> +{
> +	int ret;
> +
> +	ret =3D _regulator_is_enabled(rdev);
> +	if (ret <=3D 0)
> +		return ret;
> +
> +	/*
> +	 * If .last_on was set, then this rdev was either enabled through
> +	 * _regulator_do_enable(), or had been checked before as the target
> +	 * of regulator_resolve_supply().
> +	 */
> +	if (rdev->last_on)
> +		return ret;
> +
> +	/* This is the root supply; we can only assume it actually has power */
> +	if (!rdev->supply)
> +		return ret;
> +
> +	return _regulator_is_enabled_recursive(rdev->supply->rdev);
> +}
> +
>  static int regulator_resolve_supply(struct regulator_dev *rdev)
>  {
>  	struct regulator_dev *r;
> @@ -2373,6 +2412,14 @@ static int regulator_resolve_supply(struct regulat=
or_dev *rdev)
>  		}
>  		rdev->constraints_pending =3D false;
>  	}
> +
> +	/*
> +	 * regulator was left on but not enabled with .always_on or .boot_on
> +	 * constraints, and thus .last_on timestamp is still invalid.
> +	 */
> +	if (!rdev->last_on && _regulator_is_enabled_recursive(rdev) > 0)
> +		rdev->last_on =3D ktime_get_boottime();
> +
>  	regulator_unlock_dependent(rdev, &ww_ctx);

[Severity: Medium]
Does this call _regulator_is_enabled_recursive(rdev) without holding any
regulator locks during the early supply resolution path in
regulator_register()?

In drivers/regulator/core.c:regulator_register(), when the initial call to
set_machine_constraints(rdev, false) returns -EPROBE_DEFER,
regulator_resolve_supply(rdev) is called before regulator_init_coupling(rde=
v)
has initialized rdev->coupling_desc.n_coupled:

drivers/regulator/core.c:regulator_register() {
    ...
	ret =3D set_machine_constraints(rdev, false);
	if (ret =3D=3D -EPROBE_DEFER) {
		rdev_dbg(rdev, "will resolve supply early: %s\n",
			 rdev->supply_name);
		ret =3D regulator_resolve_supply(rdev);
		if (!ret)
			ret =3D set_machine_constraints(rdev, false);
		else
			rdev_dbg(rdev, "unable to resolve supply early: %pe\n",
				 ERR_PTR(ret));
		tried_supply_resolve =3D true;
	}
    ...
	ret =3D regulator_init_coupling(rdev);
    ...
}

At that point, rdev->coupling_desc.n_coupled is still 0, so
regulator_lock_dependent() -> regulator_lock_recursive() performs zero loop
iterations:

drivers/regulator/core.c:regulator_lock_recursive() {
    ...
	for (i =3D 0; i < rdev->coupling_desc.n_coupled; i++) {
		c_rdev =3D rdev->coupling_desc.coupled_rdevs[i];
        ...
	}
    ...
}

Previously, rdev->constraints_pending was false during that early call, so
nothing ran inside the regulator_lock_dependent() section. With this change,
_regulator_is_enabled_recursive(rdev) runs outside the
if (rdev->constraints_pending) block and walks rdev and its live upstream
supply chain without holding rdev->mutex or any supply mutexes.

[ ... ]

> @@ -3180,13 +3231,26 @@ static int _regulator_enable(struct regulator *re=
gulator)
>  		} else if (ret < 0) {
>  			rdev_err(rdev, "is_enabled() failed: %pe\n", ERR_PTR(ret));
>  			goto err_consumer_disable;
> +		} else {
> +			/*
> +			 * Either the regulator was already enabled somehow, or this regulator
> +			 * itself has no on/off control. Either way our timestamp cannot be
> +			 * earlier than its supply's timestamp. supply_last_on =3D=3D 0 if th=
ere
> +			 * is no supply.
> +			 */
> +			if (rdev->last_on < supply_last_on)
> +				rdev->last_on =3D supply_last_on;
> +			if (!rdev->last_on)
> +				rdev->last_on =3D ktime_get_boottime();
>  		}
> -		/* Fallthrough on positive return values - already enabled */
>  	}

[Severity: Medium]
Can rdev->last_on hold a stale timestamp from before a previous disable,
causing regulator_enable_and_wait() to skip the wait_us delay?

When a regulator is disabled in drivers/regulator/core.c:_regulator_do_disa=
ble(),
rdev->last_off is updated if off_on_delay is set, but rdev->last_on is never
reset to 0:

drivers/regulator/core.c:_regulator_do_disable() {
    ...
	if (rdev->desc->off_on_delay)
		rdev->last_off =3D ktime_get_boottime();

	trace_regulator_disable_complete(rdev_get_name(rdev));

	return 0;
}

This can leave a stale rdev->last_on in two ways:

1. If a regulator is enabled at T1 (setting rdev->last_on =3D T1), disabled=
 via
_regulator_do_disable() at T2, and later re-enabled in hardware while
rdev->use_count =3D=3D 0 (for example by firmware across suspend/resume or =
via
regulator_hardware_enable()), a subsequent regulator_enable_and_wait() call
sees rdev->use_count =3D=3D 0 and _regulator_is_enabled(rdev) > 0. In
_regulator_enable(), if rdev has no supply or its supply remained on since
T1 (so supply_last_on <=3D T1), the check if (!rdev->last_on) is false beca=
use
rdev->last_on is still T1. As a result, rdev->last_on is not updated to
ktime_get_boottime() and regulator_enable_and_wait() skips the required wai=
t.

2. In _regulator_is_enabled_recursive(), if (rdev->last_on) short-circuits
the walk up the supply chain. In a supply chain root -> mid -> leaf where
root and mid are initially on (setting root->last_on and mid->last_on) and
root is later disabled while mid->use_count =3D=3D 0 and
_regulator_is_enabled(mid) > 0 (such as a passive/fixed regulator without an
is_enabled() op), mid->last_on remains non-zero. When leaf resolves its
supply in regulator_resolve_supply(), _regulator_is_enabled_recursive(mid)
returns positive without checking root, setting leaf->last_on =3D
ktime_get_boottime() while root is actually off.

Should rdev->last_on be cleared when a regulator or its upstream supply is
disabled?

[ ... ]

> @@ -6251,6 +6341,15 @@ regulator_register(struct device *dev,
>  			goto del_cdev_and_bdev;
>  	}
> =20
> +	/*
> +	 * If no supply was given, then the last_on timestamp could not have
> +	 * been updated in regulator_resolve_supply(). Check it here.
> +	 */
> +	regulator_lock(rdev);
> +	if (!rdev->supply_name && !rdev->last_on && _regulator_is_enabled(rdev)=
 > 0)
> +		rdev->last_on =3D ktime_get_boottime();
> +	regulator_unlock(rdev);

[Severity: Medium]
What happens to rdev->last_on when set_machine_constraints() enables a
regulator that has no direct enable operation (!rdev->ena_pin &&
!rdev->desc->ops->enable)?

In drivers/regulator/core.c:set_machine_constraints(), when always_on or
boot_on is set on a regulator without enable ops, _regulator_do_enable(rdev)
returns -EINVAL before reaching rdev->last_on =3D ktime_get_boottime(), and
set_machine_constraints() ignores -EINVAL and increments rdev->use_count for
always_on:

drivers/regulator/core.c:set_machine_constraints() {
    ...
		ret =3D _regulator_do_enable(rdev);
		if (ret < 0 && ret !=3D -EINVAL) {
			rdev_err(rdev, "failed to enable: %pe\n", ERR_PTR(ret));
			if (supply_enabled)
				regulator_disable(rdev->supply);
			return ret;
		}

		if (rdev->constraints->always_on)
			rdev->use_count++;
    ...
}

This appears to leave rdev->last_on as 0 in two cases:

1. For a regulator with a supply (rdev->supply_name !=3D NULL), no enable o=
ps,
and boot_on set whose supply is initially off, the first
set_machine_constraints(rdev, false) call in regulator_register() returns
-EPROBE_DEFER while rdev->constraints_pending is still false. Early supply
resolution in regulator_resolve_supply(rdev) then runs
_regulator_is_enabled_recursive(rdev) while rdev->supply is still off,
leaving rdev->last_on as 0. Next, regulator_register() calls
set_machine_constraints(rdev, false) a second time, which enables
rdev->supply, gets -EINVAL from _regulator_do_enable(rdev), and leaves
rdev->last_on as 0. Because tried_supply_resolve is true and
rdev->supply_name is non-NULL, neither the second regulator_resolve_supply()
call nor the !rdev->supply_name check above runs, leaving rdev->last_on as 0
after registration completes.

2. For a supply-less always_on regulator without enable ops,
set_machine_constraints() sets rdev->use_count =3D 1 with rdev->last_on =3D=
 0,
and regulator_register() publishes the regulator via
set_consumer_device_supply() and device_add(&rdev->dev) before reaching the
!rdev->supply_name check above. If a consumer probes concurrently on another
thread and calls regulator_enable_and_wait() in that window,
_regulator_enable() skips the rdev->use_count =3D=3D 0 branch, reads
last_on =3D=3D 0, and returns without waiting for wait_us.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103043734.2179=
858-1-wenst@chromium.org?part=3D1
