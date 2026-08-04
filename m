Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F20D3515DA
	for <linux-input@vger.kernel.org>; Tue,  4 Aug 2026 10:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785840058; cv=none; b=cABqnXOnYT2KsMf40zkaheWDiN0+Vx836VHuW9HtYChlBsBnfI8LI3Vi5ByIJP9+jnyIjO3mVp2AOLC97wwkepIOEmiWBj2R3C4aYzkIwSecgmjRR2V3NlE50iJl8pt0mhwHV7pvmPtfE/rSXdCbWppqUIo0k/5Ziex834EIbK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785840058; c=relaxed/simple;
	bh=WHSji22eyU1w6ohf+hE2CYdfzaItjXDlSdPihzxX39w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dQQhLHUaCuRjJwUODMeIfa+TLmm0lHoRXi+YsXv097ipoQK4XHFBhD8tiYSFa0p0U6fbqQmSgaSeXf6lWeMwBCOPJ9cozI2G17IeO22vWwV+Yck1nodbipJJmQDcyGXLoDUudFXKz5gHYJndzrOh9kXKqscMBwpBZJA6a7e+w4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mTOuR5RI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mTOuR5RI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DFF01F000E9;
	Tue,  4 Aug 2026 10:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785840056;
	bh=F1lJdtV/LFZT7Qdk69VeIgMXeaduhoIIE679K82VuF4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mTOuR5RIurPfh/r5ME0BPtI/leKkX2/ej6Hm9NB7YBflR0gPBtj2ij/mYQFKxlMt3
	 G8ZWwxEKdyIdkKXxedi/Ao01fSaOXhgy7JCj0rl1pkp1tlzbMDB7ktq1459CacYj3n
	 bebwULCgnvzxC5JDVE3vfSfPmYt/+70O1mE6AKf7dXIv8TgfrhutNENeTaGvaqFuGc
	 SUdd4V5/iuG+kOFTxcVH4LxyBKW7CvfD1hZA6gLkkDAFSWD3w436wEwfewVFqgMmwm
	 YuZrkK6I8XaWNz48MmhcMwwCunSsG164g7U4WX/DJDf3gvBhU/vdYaN+HQZTlroagH
	 JFZi0hQQWH7RQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] HID: wacom: Fix Use-After-Free in wacom_bamboo_pad
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lee Jones" <lee@kernel.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260804103030.1491356-3-lee@kernel.org>
References: <20260804103030.1491356-1-lee@kernel.org>
 <20260804103030.1491356-3-lee@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 10:40:56 +0000
Message-Id: <20260804104056.8DFF01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lockless and unprotected dereference of RCU pointers `shared->pen`=
 and `shared->touch` in `wacom_mode_change_work()` leading to Use-After-Fre=
e.
--

--- Patch [3]: [PATCH 3/4] HID: wacom: Fix Use-After-Free in wacom_bamboo_p=
ad ---
commit 767b68ab7301c7003f61a85491f11aed0373e519
Author: Lee Jones <lee@kernel.org>

HID: wacom: Fix Use-After-Free in wacom_bamboo_pad

This commit resolves a lockless access to wacom->shared->pen by introducing
RCU protection for pen and touch pointers. It also updates writers to use
rcu_assign_pointer() and updates mode change workers to use
rcu_access_pointer().

> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index cf9c12f3cff53..05d27fcd311f8 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c

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
>  		wacom_release_resources(wacom1);
>  		hid_hw_stop(wacom1->hdev);

[Severity: High]
This is a pre-existing issue, but could this lockless access to the RCU
pointers still lead to a use-after-free if the sibling device is removed
concurrently?

Because pen and touch are fetched using rcu_access_pointer() and
dereferenced without rcu_read_lock(), synchronize_rcu() in
wacom_remove_shared_data() won't block this worker thread.

If the sibling device is removed and freed right after rcu_access_pointer()
returns a non-NULL pointer, won't hid_get_drvdata(pen), hid_hw_stop(), and
wacom_release_resources() operate on freed memory?

>  		wacom1->wacom_wac.has_mode_change =3D true;
>  		wacom1->wacom_wac.is_direct_mode =3D is_direct;
>  	}
> =20
> -	if (shared->touch) {
> -		wacom2 =3D hid_get_drvdata(shared->touch);
> +	if (touch) {
> +		wacom2 =3D hid_get_drvdata(touch);
>  		wacom_release_resources(wacom2);
>  		hid_hw_stop(wacom2->hdev);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804103030.1491=
356-1-lee@kernel.org?part=3D3
