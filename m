Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08D8456E1E
	for <linux-input@vger.kernel.org>; Tue,  4 Aug 2026 10:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785840463; cv=none; b=RrngTmrjBy2UleQHuaFWQCEg+jkWqMP/VX1VosLmTI/4EMMEb4E0QvMxGy6yVQ2Nwnzgqc0tpgJCcZnZYvtXk7bNmx8kiCRVN2PVQaGFgDRQgsinQ/iJfnyFtpOOsUnNxOZX+fPoUVrCgQRlTAupGtpIeNpbQAGXx/xKkBrfQyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785840463; c=relaxed/simple;
	bh=bpi5MVgSiKUjMtNSNMv8zqXVsaHaQonenv1WdaOE6qQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NekBM27MfOSOovGPV/bpGw63N0jzoXt0DXle7mi6T1GuAccpwMEBV94QjpJ4Hq2vX4pteVYqFrXQRNvOFymuU+gIox+LvsDi2WGO/GZuk6pziMZMZceen3J6j/JAdl1ZsRKHPKkICEwzCN32Umtpr0f46W0nc/iT35dPwKRBfFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJtc8hoG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJtc8hoG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 495F61F00A3A;
	Tue,  4 Aug 2026 10:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785840462;
	bh=N/qaXabNEGIDtju6u2Jef2rTgtAjiz4wtIkf7T60aNs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HJtc8hoG1c2JTjOYrYvYYg6Ya4PAfcxZJmSHQKqzcFo4SiHAUZKuxaihLzAAeVGtZ
	 OyDSFGYRUtPqztZPS4un373ODmv/3/DNWqNBgMsRzCQNuQC/zkbgewXTKULlXpFocV
	 cw4L6Ro4UO9ipdnJQQSwop8kyfTdDMDaS/a1KhITz1JeibfvEhaRmcAjD+u5HtK3Ax
	 s2ohftPmrZG/AJ4ZEB9sOcEpK0K+KLEbCNrFSPdOo13H9/mL22sWbMa1FD9A+ulJ73
	 TF4DZT8JLr8vhFk1iexeqv6JOKTmymfA0gzTPBeGXm34QuOh/ja7qz4NMAN0BYnuLi
	 2la8C2VgV/r7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/4] HID: wacom: Fix Use-After-Free in
 wacom_bamboo_pad
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lee Jones" <lee@kernel.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260804103209.1496683-3-lee@kernel.org>
References: <20260804103209.1496683-1-lee@kernel.org>
 <20260804103209.1496683-3-lee@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 10:47:41 +0000
Message-Id: <20260804104742.495F61F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] wacom_mode_change_work() accesses shared->pen and shared->touch lo=
cklessly outside of an RCU read-side critical section, leading to a Use-Aft=
er-Free if a sibling device is removed.
- [High] wacom_remove_shared_data() calls kref_put() without holding wacom_=
udev_list_lock, creating a race condition where a concurrent probe can resu=
rrect the object while it is being freed.
--

--- Patch [3]: [PATCH v7 3/4] HID: wacom: Fix Use-After-Free in wacom_bambo=
o_pad ---
commit 2aec7c2beec55f0a42e84d2a747129503b809e66
Author: Lee Jones <lee@kernel.org>

HID: wacom: Fix Use-After-Free in wacom_bamboo_pad

This commit introduces RCU protection for pen and touch pointers in the
wacom_bamboo_pad driver. It adds RCU annotations and wraps lockless readers=
=20
in rcu_read_lock() to prevent Use-After-Free bugs when sibling devices=20
are removed.

> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index cf9c12f3cff53..05d27fcd311f8 100644
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
This isn't a bug introduced by this patch, but does wacom_remove_shared_dat=
a()
have a race condition when calling kref_put()?

If kref_put(&data->kref, wacom_release_shared_data) is executed without hol=
ding
wacom_udev_list_lock, it drops the refcount to 0 and jumps to the release=20
callback wacom_release_shared_data().

Before the release callback acquires wacom_udev_list_lock, a concurrent dev=
ice
probe executing wacom_add_shared_data() could iterate over wacom_udev_list =
and
call kref_get() on the zero-refcount object.

Could a concurrent probe resurrect the object while it is being freed, lead=
ing
to a Use-After-Free?

[ ... ]

> @@ -2810,16 +2821,19 @@ static void wacom_mode_change_work(struct work_st=
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
This is a pre-existing issue, but does wacom_mode_change_work() have a
Use-After-Free risk because it accesses the pointers without RCU read-side
protection?

Since this workqueue does not hold rcu_read_lock(), a concurrent unbind
operation calling synchronize_rcu() can return immediately.

If a sibling device is unbound concurrently, could the pointer be freed whi=
le
this function continues to dereference it via hid_get_drvdata() and calls
blocking functions like hid_hw_stop()?

>  		wacom_release_resources(wacom1);
>  		hid_hw_stop(wacom1->hdev);
>  		wacom1->wacom_wac.has_mode_change =3D true;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804103209.1496=
683-1-lee@kernel.org?part=3D3
