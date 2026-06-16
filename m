Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53584357CE8
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 09:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781603128; cv=none; b=atmfCQMUI1ghgUmyE4s3qsGkNHtbExuSGcXhGIFN/Fx3a5irkXdOcPIHyeVXKcPyMWJCGcuYIqP8CLl/SMrZYuhMfjK638ldX0SwapDrOIjF1rUIzfOdKamFx9uCiFFqxKzTzARYi25e1l/fi42uEsI4gNoHBKXkmc/oeruW3QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781603128; c=relaxed/simple;
	bh=4dNBN3lGK9Ak1nf8tH2xqNtXOsowRp+BXMx7GpGnxNA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LX6SPuPxW6sR+lPPC67Z10zX5PNL6JMPFyeC+jvSQaTJBEOhv2aIhgLdnT6FGrUYmKQnRY45wAIVq1pEy0EE0sV0UjrGbUyPwgOR+rxSnnPOIT42DeS2zjZ6gpnzUwGllVGLHqp+4u5rNk//hVwbiQFI0ssDaNaQ4e2e9nweAw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZf1Y2qh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZf1Y2qh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D380A1F000E9;
	Tue, 16 Jun 2026 09:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781603127;
	bh=5MwIj+t5/4n8V+Y3I7hT4yiyvNCmOB0FYiBcD5vJEPs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WZf1Y2qhtitwTQMqToPBoE/sfaBk9Gxwg+kvYtzTdpd3kDCeXXIoDiZX6Np46++UG
	 uJtkJrySew/DvbHvXEjJuPi4lbBmRan15Vag0XBK/jwmeCtU3/PtTv9eFiaB+7fFWB
	 CMzTn0qUeUrXYr+z3SVLTAQdLghUfkM5kOPS2mIEfI8B00//OKT3HpEBU18+7ge/x5
	 DJB9+PGtOOGJu5rt8IApZs8eaF/lJNrXln15jvN7Bop12MJPd8BbbVWYutXEZWFuBj
	 3rOWMa5rk1T3DQOCJvLBijg4WSuCvtZ3IFXnwfrIALN2LD9Cw3fB2WlBbyUmE9YS8v
	 sOqURHSM5W9/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/3] HID: wacom: Fix Use-After-Free in
 wacom_intuos_pad
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lee Jones" <lee@kernel.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260616092658.1714548-1-lee@kernel.org>
References: <20260616092658.1714548-1-lee@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 09:45:26 +0000
Message-Id: <20260616094526.D380A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-After-Free in `wacom_mode_change_work()` due to unprotected lo=
ckless access of sibling device pointers.
--

commit 2e75e17f7579b493b3120751d2b8cfa23bc2c814
Author: Lee Jones <lee@kernel.org>

HID: wacom: Fix Use-After-Free in wacom_intuos_pad

This commit resolves a Time-of-Check to Time-of-Use race condition by
introducing RCU protection for the touch_input pointer. It also wraps
shared value assignments in the udev list lock to prevent concurrent
desynchronization, and advertises the SW_MUTE_DEVICE capability before
registration.

> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 2220168bf1164..86895f13dbaea 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -877,10 +877,16 @@ static void wacom_remove_shared_data(void *res)
>  		data =3D container_of(wacom_wac->shared, struct wacom_hdev_data,
>  				    shared);
> =20
> -		if (wacom_wac->shared->touch =3D=3D wacom->hdev)
> -			wacom_wac->shared->touch =3D NULL;
> -		else if (wacom_wac->shared->pen =3D=3D wacom->hdev)
> -			wacom_wac->shared->pen =3D NULL;
> +		scoped_guard(mutex, &wacom_udev_list_lock) {
> +			if (wacom_wac->shared->touch =3D=3D wacom->hdev) {
> +				wacom_wac->shared->touch =3D NULL;
> +				rcu_assign_pointer(wacom_wac->shared->touch_input, NULL);
> +			} else if (wacom_wac->shared->pen =3D=3D wacom->hdev) {
> +				wacom_wac->shared->pen =3D NULL;
> +			}
> +		}
> +
> +		synchronize_rcu();

[Severity: High]
This is a pre-existing issue, but I noticed a potential Use-After-Free in
wacom_mode_change_work() due to unprotected lockless access of sibling devi=
ce
pointers.

While synchronize_rcu() is called here to ensure active RCU readers have
finished, wacom_mode_change_work() accesses sibling pointers locklessly
without an rcu_read_lock():

wacom_mode_change_work() {
        ...
        struct hid_device *pen =3D rcu_access_pointer(shared->pen);
        struct hid_device *touch =3D rcu_access_pointer(shared->touch);
        ...
        if (pen) {
                wacom1 =3D hid_get_drvdata(pen);
        ...
}

Because there is no rcu_read_lock() wrapping the access in
wacom_mode_change_work(), this synchronize_rcu() call will return without
waiting for the preempted work to finish.

If a sibling device (like the pen device) is concurrently disconnected,
wacom_remove() cancels the pen device's mode change work but leaves the
touch device's work running.

When wacom_remove_shared_data() executes for the pen, it nullifies
shared->pen and calls synchronize_rcu(). Since it won't wait for the
unprotected touch device's work, the pen device memory could be freed by
the HID core before that work resumes.

When the work eventually resumes and calls hid_get_drvdata(pen), won't it
dereference the freed pen pointer and cause a Use-After-Free?

I see from the patch 2 commit message that this lockless access is
intentionally left as-is because wacom_mode_change_work() sleeps and cannot
use RCU read locks. Could an alternative approach be used here to prevent
this use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616092658.1714=
548-1-lee@kernel.org?part=3D1
