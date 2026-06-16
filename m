Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DF54218A3
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 09:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781602993; cv=none; b=qjHijw2/2jgoW/AbOJt4JR9Hrsdq8byNEET2CbOkAobtnKfLrjg1pOx+f0MOWB4DbtzZyyRin1dRKrMVWl+KhukS0dVE1czR5yDR6XTm4mlpwaXbfrovTyXr5GMOpkuhkcq8BqnqpV33URbWWysrP8hcuKgtRGxwK3YYXxi9KWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781602993; c=relaxed/simple;
	bh=8i55S5m8g6aqJXu8iJ5fh7uzQoqJmQo94ixFhhsVrNc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ImJb1drGUGVU8e4TVlvot807DNYvMMAGuarj08VxcbUE1GhlbvUPNwn4Nv5tJmiWlfzZ0857ITzW0Wcq510Pyk8r8TTHBSM1SVukK45FyvED2AcNWHjjwMRGBYmMyCo0+cC0+U0zhn92h04cfPepnQ87aVWmBEsFdrYQGVHG1Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQSqDDrj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQSqDDrj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B211F000E9;
	Tue, 16 Jun 2026 09:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781602992;
	bh=FlA7hz1bSV+c+udTORgMCOoKuyGg0/QfzAG+euRUx/s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SQSqDDrjiIKyKT+2jGEMGHW6jDq1Cqdv4mFiOfpu3wo/TapT+8L8Gq1JtI+uzVKWE
	 jMf0LmT7cbRb5R7mo76sUVTDjdVedxHgRmDyyTqaUYdFzIcCardrwZrseIyh7aTnJV
	 0/YaW7ls9XIHovz2jvt72X3diDEDe6slZSgDTpn3VEZsHHGZ2DChYyT9q85etua2zi
	 8XAPGOtk5RXGMGRWrDi8ODh5aZj0RrgniOvz8u5ozwSMMr7rzlPo6gfXb/rOQ/99Hf
	 EngT0WatrdbHp5gKmchZnPeUNJOkUAk1pFEH/LY/C/YZbNQ/scezRu8gHXactoDUyA
	 XFTX8zuHVWsOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/3] HID: wacom: Fix Use-After-Free in
 wacom_bamboo_pad
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lee Jones" <lee@kernel.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260616092658.1714548-2-lee@kernel.org>
References: <20260616092658.1714548-2-lee@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 09:43:12 +0000
Message-Id: <20260616094312.72B211F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lockless access to `shared->pen` and `shared->touch` in `wacom_mod=
e_change_work()` can lead to Use-After-Free.
--

commit e951961530e94aa8b795598b1d198c32fdbac428
Author: Lee Jones <lee@kernel.org>

HID: wacom: Fix Use-After-Free in wacom_bamboo_pad

Resolves a use-after-free when events are processed while a sibling device
is removed by introducing RCU protection for the shared pen and touch
pointers.

> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 86895f13dbaea..3990d8d0b40c0 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
[ ... ]
> @@ -2795,16 +2806,19 @@ static void wacom_mode_change_work(struct work_st=
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
>  		wacom1->wacom_wac.has_mode_change =3D true;
>  		wacom1->wacom_wac.is_direct_mode =3D is_direct;
>  	}

[Severity: High]
This is a pre-existing issue, but can this lockless access to the sibling
device pointers lead to a use-after-free if the sibling is concurrently
disconnected?

In wacom_mode_change_work(), rcu_access_pointer() reads the pointer outside
of an RCU read-side critical section. Since the pointer is then dereferenced
to fetch wacom1 via hid_get_drvdata(), what happens if wacom_remove_shared_=
data()
runs concurrently on the sibling?

The removal path would clear the shared pointer and call synchronize_rcu().
Because wacom_mode_change_work() is not holding the RCU read lock,
synchronize_rcu() will not wait for the work item to complete. This could
allow wacom1's driver data to be freed while wacom_mode_change_work() is
still using it to call wacom_release_resources(wacom1) and hid_hw_stop().

Since wacom_release_resources() and hid_hw_stop() can sleep, simply wrapping
this block in rcu_read_lock() wouldn't be sufficient. Is there a plan to
use reference counting or SRCU here to safely access the sibling device?

> -	if (shared->touch) {
> -		wacom2 =3D hid_get_drvdata(shared->touch);
> +	if (touch) {
> +		wacom2 =3D hid_get_drvdata(touch);
>  		wacom_release_resources(wacom2);
>  		hid_hw_stop(wacom2->hdev);
>  		wacom2->wacom_wac.has_mode_change =3D true;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616092658.1714=
548-1-lee@kernel.org?part=3D2
