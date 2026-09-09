Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961D7346AFB
	for <linux-input@vger.kernel.org>; Wed,  9 Sep 2026 11:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953466; cv=none; b=ayfRHhBMj3D2n3fjh/oR9Qg1MrUSdzRYlnszKgg9LqfzIwqHa5ArkMJrcKQsxizFD8XT7MJGlPSZKsYYKw3NmGwh6Gx59rkJ5WcAFvpOxNSI7urMbN5UKQ0mabL7SF1lQnUWQVEk+A520jI5S9hq+f5q+HTGrHRGVF8Ngxd8vBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953466; c=relaxed/simple;
	bh=cwo9zjOz68Ab3BZfB0uH1qlrx8f528QX2Hwa8MiOtkk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pPFWtsI3dvRy/Zi4bgGKAC32fjsed75/Rhqkjd/loL+aO1Abr4L7xpuJZjX9cMT4ePZ1uhJU4aQbexGfdQWXM+OTZfJ6/Lmr66kyTdQW4nzN7T6ZoRGzLNVkouO674OWPkLAtTtYoXwnxDbLsRT8oTb9iNgcVxX33817CDjX858=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hxzKOKIi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxzKOKIi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E551F00A3A;
	Wed,  9 Sep 2026 11:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788953464;
	bh=Qh7Aw40SWUbRSbiHVxgy317MzDB8ybusSLB+kfe9MtI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hxzKOKIiPbMj2bdkyieogOIHXEaXG0E4wHsiRG28JbnicQEIegkD0spOG6Dj807jZ
	 dTwBwMaRqMKjF6NYGapx/83XIosJqDBkySRob3Ch2lJC2GooqcmqO/t3/K2n31CLP2
	 XvpiUs2eNvpk7DmnRuxN5TbZJBbnu2Gafa09PqpHmpR7ZdAC9U9HuCWeVBjO2YaSH/
	 NdAh0Dy20hBj609Lr22bw1QF0wb3mhK5XIO8LOSXaYx5pUYhf3NnESy4cQfRJLvhFg
	 2/Tq0ZLMZMd8O8RLDJfco9YJJVo0oIa/zK7iATKqGtDWltaE/2teHZt50G7phsAPC3
	 okgPEXigDDP7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 4/5] HID: wacom: Fix Use-After-Free in
 wacom_bamboo_pad
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lee Jones" <lee@kernel.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <210915d7d09103727159be5a6b7c229d4d03522b.1788868602.git.lee@kernel.org>
References: <fa3cb42f7b58c1b3022d8208969a81882783a5ec.1788868602.git.lee@kernel.org>
 <210915d7d09103727159be5a6b7c229d4d03522b.1788868602.git.lee@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 11:31:03 +0000
Message-Id: <20260909113104.22E551F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Lockless access to `shared->pen` and `shared->touch` in `wacom=
_mode_change_work()` leads to a Use-After-Free.
--

commit 128e0f492fb46bf1508b21d7d9f05ef9e57ed2be
Author: Lee Jones <lee@kernel.org>

HID: wacom: Fix Use-After-Free in wacom_bamboo_pad
   =20
This commit introduces RCU protection for the pen and touch pointers in the
wacom_shared structure to resolve a Use-After-Free during sibling device
removal. It updates lockless readers with rcu_read_lock() and uses
rcu_assign_pointer() in writers.

> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 10f7de515ea28..307eda9bbdd07 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c

[ ... ]

> @@ -2852,16 +2861,19 @@ static void wacom_mode_change_work(struct work_st=
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

[Severity: Critical]
This is a pre-existing issue, but could this lockless access to shared->pen
and shared->touch lead to a Use-After-Free here?

The commit message explicitly notes that lockless access in this work item
remains a pre-existing issue. The removal path nullifies the shared pointer
and calls synchronize_rcu(). However, wacom_mode_change_work() accesses the
pointers using rcu_access_pointer() without establishing an RCU read-side
critical section using rcu_read_lock().

Because there is no active RCU reader, synchronize_rcu() does not wait for
this work item to finish. If a device report schedules this work, and the
sibling device is concurrently unplugged, won't the sibling device's
resources be freed while wacom_mode_change_work() is actively dereferencing
the stale pointer via hid_get_drvdata(pen) and hid_hw_stop()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/fa3cb42f7b58c1b3022=
d8208969a81882783a5ec.1788868602.git.lee@kernel.org?part=3D4
