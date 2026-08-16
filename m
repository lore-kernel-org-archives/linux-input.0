Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560101F5825
	for <linux-input@vger.kernel.org>; Sun, 16 Aug 2026 06:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786861148; cv=none; b=hUrdoD+neZmI9l8KMdTHkwC9nMYrmfCTC7ml0LJ6YzXuXXKrd+MnnilGj5kAytLx16VvXAAXjNn4qDcMrakQdjZ4OVkBmZPbiodF5SQh5zfUIHmAUaz7iFJPSKME+z6jKYfoSCa6p5zcWle3fj0o2L2tj5XDf5nOK+IJXBbQk7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786861148; c=relaxed/simple;
	bh=jUrFacCeNP+WX+QLGIceBh3VA7/VKO+dknQNd3hLQyo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ukyelzSKxXelHRopFjrKXvObEKRQ0Vy7N+T8zkwvMuleVriKK5CHk/2mAM5b8EkvNFs8tKsWr0pF9aJWv02HeJDcPbJSmRhZND93B+mnKaQ7nJlhsHZx7p9jIxEE+fMNamGTaVo4d1jHWlAImBOVYyaxirRHKAkwZanOWrCCjGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAjgI8BN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAjgI8BN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 915E61F000E9;
	Sun, 16 Aug 2026 06:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786861146;
	bh=iPeDILrf+tSEYCY2uR3p4YROuciiDO3iHD9C8vvFp8k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bAjgI8BNKscor9mzxbKV1sdIGhnuLcY+Yhra/F0wMHKzfR9zfm3zvTeAuza7Wx+HO
	 BRpkVPBQIFhnLyAKEernFhDDji4PopADw2Af6k/LJBH8nlsrnRiCmIXcItbvvsDTYY
	 rzmNy7R/3WrE0pBqTnPYDivGqPcECgr40wCdlk1JxuMueqkXhFxmhTVx0lujV8cQGY
	 zmgMPeEQRa1i7npuUM2GIMSXmHQwL3h/iH0uEdYKVi0+NIZTvKmlj4qnrO88kWHE3D
	 YolzonYCKLXMAw/N6y2t7wH423tuBX3agEax5T0oR0MKRfx+/U0TVu9fv2H2oH8JRC
	 tIQSdl7g2wThg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 01/13] notifier: add device-managed registration APIs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eliav Farber" <farbere@amazon.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260816060648.4030-2-farbere@amazon.com>
References: <20260816060648.4030-1-farbere@amazon.com>
 <20260816060648.4030-2-farbere@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 16 Aug 2026 06:19:06 +0000
Message-Id: <20260816061906.915E61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] The patch omits explicitly callable devm_*_unregister() function=
s, preventing safe early unregistration in drivers.
- [Medium] devm_atomic_notifier_chain_register() is implicitly restricted t=
o process context but its documentation does not state this.
- [Low] Device-managed registration for SRCU notifiers is omitted without j=
ustification.
--

--- Patch [1]: [PATCH v5 01/13] notifier: add device-managed registration A=
PIs ---
commit 123931abf8d80f91fce35443259e0df9e2736a4e
Author: Eliav Farber <farbere@amazon.com>

notifier: add device-managed registration APIs

This patch adds devm_atomic_notifier_chain_register() and
devm_blocking_notifier_chain_register() that automatically unregister
the notifier when the device is unbound. This reduces boilerplate in
drivers by eliminating per-driver unregister callbacks.

> diff --git a/include/linux/notifier.h b/include/linux/notifier.h
> index 01b6c9d9956f9..4eeae9741a6e8 100644
> --- a/include/linux/notifier.h
> +++ b/include/linux/notifier.h

[ ... ]

> @@ -145,8 +146,14 @@ extern void srcu_init_notifier_head(struct srcu_noti=
fier_head *nh);
> =20
>  extern int atomic_notifier_chain_register(struct atomic_notifier_head *n=
h,
>  		struct notifier_block *nb);
> +int devm_atomic_notifier_chain_register(struct device *dev,
> +		struct atomic_notifier_head *nh,
> +		struct notifier_block *nb);

[Severity: Medium]
Should there be corresponding devm_atomic_notifier_chain_unregister() and
devm_blocking_notifier_chain_unregister() functions provided?

If a driver needs to unregister early to quiesce hardware, manually calling
the non-devm unregister function leaves a stale devres action. This performs
a useless double-unregister during devres_release_all(), which
unconditionally hits the slow synchronize_rcu() and delays unbind.

>  extern int blocking_notifier_chain_register(struct blocking_notifier_hea=
d *nh,
>  		struct notifier_block *nb);
> +int devm_blocking_notifier_chain_register(struct device *dev,
> +		struct blocking_notifier_head *nh,
> +		struct notifier_block *nb);
>  extern int raw_notifier_chain_register(struct raw_notifier_head *nh,
>  		struct notifier_block *nb);
>  extern int srcu_notifier_chain_register(struct srcu_notifier_head *nh,

[Severity: Low]
Is there a reason the devm variant for SRCU notifiers was omitted?

The commit message justifies omitting raw notifiers due to locking
constraints, but SRCU notifiers manage their own internal mutex which should
be safe to lock in the devres teardown context.

> diff --git a/kernel/notifier.c b/kernel/notifier.c
> index 2f9fe7c30287f..0c39627ea69c5 100644
> --- a/kernel/notifier.c
> +++ b/kernel/notifier.c

[ ... ]

> @@ -197,6 +198,56 @@ int atomic_notifier_chain_unregister(struct atomic_n=
otifier_head *nh,
>  }
>  EXPORT_SYMBOL_GPL(atomic_notifier_chain_unregister);
> =20
> +struct atomic_notifier_chain_devres {
> +	struct atomic_notifier_head *nh;
> +	struct notifier_block *nb;
> +};
> +
> +static void devm_atomic_notifier_chain_unregister(struct device *dev, vo=
id *res)
> +{
> +	struct atomic_notifier_chain_devres *dr =3D res;
> +
> +	atomic_notifier_chain_unregister(dr->nh, dr->nb);
> +}
> +
> +/**
> + *	devm_atomic_notifier_chain_register - Device-managed atomic notifier =
registration
> + *	@dev: Device to tie the notifier lifetime to
> + *	@nh: Pointer to head of the atomic notifier chain
> + *	@nb: New entry in notifier chain
> + *
> + *	Adds a notifier to an atomic notifier chain and registers a cleanup
> + *	action to automatically unregister it when @dev is unbound.
> + *
> + *	Return:
> + *	0 on success, negative errno on error.
> + */

[Severity: Medium]
Should this kerneldoc include a context warning like "Must be called in
process context."?

Unlike atomic_notifier_chain_register() which is safe in atomic context,
this function uses devres_alloc() with GFP_KERNEL which can sleep, making it
unsafe to call from atomic context.

> +int devm_atomic_notifier_chain_register(struct device *dev,
> +					struct atomic_notifier_head *nh,
> +					struct notifier_block *nb)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260816060648.4030=
-1-farbere@amazon.com?part=3D1
