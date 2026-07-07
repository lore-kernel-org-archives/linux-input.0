Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E636F40A92C
	for <linux-input@vger.kernel.org>; Tue,  7 Jul 2026 12:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783427272; cv=none; b=mNETfhDmanM4V5tD4jdKHxxJrV3sUs1Nrg6w0orNsr+OPR7GvTNtFsfWu+6c/YASqEnFwxZaOx0TkAWLCtAed55t8hF9HAF5fw+R5xnPdTitE3ZfXM4oIq1Cf+D5v3/zwb/roeTlBoPIDUSfh6C/aPpjdZnB5v/10eDkbYOpRm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783427272; c=relaxed/simple;
	bh=d5Q8P5ddMBXNcfb5aAtRrRRSVPZaF0lPoh/NiLqEkBM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pV3mFyNGr/iEeeeaoohM3ao5/F1u3yzwBD5U62zfx/qaALThnz/nAp7j7/Bqn6M7Gg9zHLo/lCwFIkoSUE2qwEpexbZuhc9J0wBPB3t6CRKezWHT7y9jefgccbQdTETIDXwYGxOLJqbkr/XOjLPVg6P0RRM2tc/DV/i55KCbRXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7wliWf/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7wliWf/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71BBC1F000E9;
	Tue,  7 Jul 2026 12:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783427270;
	bh=sQ0qOY2tssrbDzvdar3w9S7O0NeSHs3il4HXVagYDN8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C7wliWf/HTOySy1NTsBaWff44BazofdBBLyP5AINvMKMkIQS+Tg1+8aka6Nr8EH33
	 vsvy/4OzF8+qWdwCRHCn2H5t7erSm49dFR/3jRxH7MOAMWE/gXCrrq/3OS5n8UISa0
	 YvQ5tYMsaq8uOKeZAWMUydxT/ir/IrrgD4JACul+vqozsdmxvESlv2t+DBzlc8JTk4
	 HV6tHjAQsxxSuU/kg+XUqBaV9EoJ5jPFrHvy+jU3kNvdAyaO6ddc/3IKxetyjBMksd
	 IUVVMKSKVqTcQ3OM28JY8YAtyzQWTTgLhxO/1qN8qd6gygfixtHTZlux95e+ukvOby
	 7P0QoNQwPRQcg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] HID: wacom: Fix Use-After-Free in wacom_bamboo_pad
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lee Jones" <lee@kernel.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260707121051.1683937-3-lee@kernel.org>
References: <20260707121051.1683937-1-lee@kernel.org>
 <20260707121051.1683937-3-lee@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 12:27:49 +0000
Message-Id: <20260707122750.71BBC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lockless access to `shared->pen` and `shared->touch` in `wacom_mod=
e_change_work()` leads to Use-After-Free if a sibling device is disconnecte=
d.
- [High] Race condition between `kref_put()` and `kref_get()` for `wacom_hd=
ev_data` leads to Use-After-Free.
--

--- Patch [3]: [PATCH 3/4] HID: wacom: Fix Use-After-Free in wacom_bamboo_p=
ad ---
commit ba24ac0ee968766a5b0db4400d76393921713f71
Author: Lee Jones <lee@kernel.org>

HID: wacom: Fix Use-After-Free in wacom_bamboo_pad

This commit introduces RCU protection for pen and touch pointers in the
wacom_shared struct to resolve a use-after-free issue. It wraps lockless
readers with RCU read locks and updates writers to use RCU assignment and
dereferencing functions.

> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index c6b37931d02d1..5578de80f4c80 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -876,11 +876,18 @@ static void wacom_remove_shared_data(void *res)
>  				    shared);
> =20
>  		scoped_guard(mutex, &wacom_udev_list_lock) {
> -			if (wacom_wac->shared->touch =3D=3D wacom->hdev) {
> -				wacom_wac->shared->touch =3D NULL;
> +			struct hid_device *touch =3D
> +				rcu_dereference_protected(wacom_wac->shared->touch,
> +							  lockdep_is_held(&wacom_udev_list_lock));
> +			struct hid_device *pen =3D
> +				rcu_dereference_protected(wacom_wac->shared->pen,
> +							  lockdep_is_held(&wacom_udev_list_lock));
> +
> +			if (touch =3D=3D wacom->hdev) {
> +				rcu_assign_pointer(wacom_wac->shared->touch, NULL);
>  				rcu_assign_pointer(wacom_wac->shared->touch_input, NULL);
> -			} else if (wacom_wac->shared->pen =3D=3D wacom->hdev) {
> -				wacom_wac->shared->pen =3D NULL;
> +			} else if (pen =3D=3D wacom->hdev) {
> +				rcu_assign_pointer(wacom_wac->shared->pen, NULL);
>  			}
>  		}
> =20

[Severity: High]
This is a pre-existing issue, but is there a race condition between
kref_put() and kref_get() for wacom_hdev_data that could lead to a
use-after-free?

In wacom_remove_shared_data(), kref_put() is called without holding
wacom_udev_list_lock:

	kref_put(&data->kref, wacom_release_shared_data);

If the refcount drops to 0, it calls wacom_release_shared_data(), which
acquires the lock to remove the element.

In the window before the lock is acquired, could another thread in
wacom_add_shared_data() iterate over wacom_udev_list, find the still-linked
data, and call kref_get(&data->kref)?

This would increment a 0-refcount object, and subsequently the first thread
frees it, leaving the second thread with a dangling pointer.

[ ... ]

> @@ -2793,16 +2804,19 @@ static void wacom_mode_change_work(struct work_st=
ruct *work)
>  	bool is_direct =3D wacom->wacom_wac.is_direct_mode;
>  	int error =3D 0;
> =20
> -	if (shared->pen) {
> -		wacom1 =3D hid_get_drvdata(shared->pen);
> +	struct hid_device *pen =3D rcu_access_pointer(shared->pen);
> +	struct hid_device *touch =3D rcu_access_pointer(shared->touch);
> +
> +	if (pen) {
> +		wacom1 =3D hid_get_drvdata(pen);

[Severity: High]
This is a pre-existing issue, but does lockless access to shared->pen and
shared->touch in wacom_mode_change_work() lead to a use-after-free if a
sibling device is disconnected?

Pointers are fetched locklessly via rcu_access_pointer() and subsequently
dereferenced without any synchronization. If a sibling device is disconnect=
ed,
wacom_remove_shared_data() nullifies the pointer and calls synchronize_rcu(=
).

Because wacom_mode_change_work() runs asynchronously and reads the pointer
without holding rcu_read_lock() or wacom_udev_list_lock, synchronize_rcu()
does not wait for it.

Can this cause the sibling device's memory to be freed and subsequently
dereferenced by the worker thread (e.g., via hid_get_drvdata(pen))?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707121051.1683=
937-1-lee@kernel.org?part=3D3
