Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257D645518A
	for <linux-input@vger.kernel.org>; Tue,  4 Aug 2026 10:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785840856; cv=none; b=og+P/BJaC8ymRWfcCp1qkC6T7mgHDTtvqSJQGpXlZlMk2rk7sQToctthVaM7k7U62B918plkVhaMt1WmQrCW4RvDjBgUrvygmEynOU+T8J150uYc2FCD+GuU4TnbrUe6ODy8T4PsOWYw2IsMobrgJcWaTTlxWWuwo6knMmrSSNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785840856; c=relaxed/simple;
	bh=+DsMzbygNvH3NagczYO+QkO+vxcMNDB0C9dLmVUe+3s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CU95yN4ylNT/lBoumBjAT4NATXHIkOzT08U4/8b/EzSybOOV+pHUxG++osuEFfJnoo8p0SOBIOXRfFbG2W/z4Exvk1Hr36VODxHUrZTzkolNz2wfTfYzcwQnzgktJ+drbyUGRHMxnBfOmJXlZY35KLl++gmmFLWX5Zt4/wsSHi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAcx1C+y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAcx1C+y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 772DA1F000E9;
	Tue,  4 Aug 2026 10:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785840852;
	bh=oyJ5igzisDQu+NWs9CwQjRsJsuxA5cFyKJRmeQVxpx0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EAcx1C+y30zVo0Mh4rv7maH8eddi1M0lqaMPDJceQutqs5y1bW1jL1+aG9xjrmszk
	 r5vOPI8yJusC8bpHqfRWRwWmsk/Xbt7g6Qx66DkQ0aNxknNU4sh4Md9LEmUeD0/kCO
	 RZ/SqsUMm4GQQTePH4utmo0PUs4HXLSDQkuw47xW3TNzJF7JURJc0ydNyd+KI2FtVw
	 ZdN3Cufu+SJ2wIoTgNjR4qmEQnpPo/3cxE2zDZpwzErY8l0PFfwRDq9IWwyF0ALEwt
	 YgfQUI4gnVO3RDg5Cxdf2BV1N3by/kjJf+sfiA7AJjHKudaBIRq4FR0fCQ9VVvJC6B
	 39KYX0adRqdUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] HID: wacom: Fix Use-After-Free in wacom_intuos_pad
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lee Jones" <lee@kernel.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260804103030.1491356-2-lee@kernel.org>
References: <20260804103030.1491356-1-lee@kernel.org>
 <20260804103030.1491356-2-lee@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 10:54:11 +0000
Message-Id: <20260804105412.772DA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lockless accesses to `shared->pen` and `shared->touch` cause a TOC=
TOU Use-After-Free race condition during concurrent sibling device removal.
- [High] Improper `kref_put()` usage during shared data removal causes a Us=
e-After-Free of `wacom_hdev_data` due to a race with list traversal.
--

--- Patch [2]: [PATCH 2/4] HID: wacom: Fix Use-After-Free in wacom_intuos_p=
ad ---
commit b17a0dd077bc2659cd08a43647ccf55bb0fc7cb0
Author: Lee Jones <lee@kernel.org>
Subject: HID: wacom: Fix Use-After-Free in wacom_intuos_pad

This commit resolves a time-of-check to time-of-use race condition by
introducing rcu protection for the touch_input pointer. It also wraps
concurrent probe assignments in wacom_udev_list_lock.

> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 92b73ed0028f1..cf9c12f3cff53 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -875,10 +875,16 @@ static void wacom_remove_shared_data(void *res)
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

[Severity: High]
This is a pre-existing issue, but was not introduced by this patch. Should
shared->pen (and shared->touch) also be annotated and cleared with
rcu_assign_pointer()?

There appear to be lockless readers of shared->pen and shared->touch in
the input event handlers, such as wacom_bamboo_pad_pen_event() calling
hid_input_report() or wacom_mode_change_work() dereferencing it via
hid_get_drvdata(). If a sibling device is unbound concurrently, those
readers might access a freed hid_device.

Since they don't hold rcu read locks, the synchronize_rcu() added below
won't wait for them unless they are also updated.

> +			}
> +		}
> +
> +		synchronize_rcu();
> =20
>  		kref_put(&data->kref, wacom_release_shared_data);

[Severity: High]
This is a pre-existing issue, but can this kref_put() cause a use-after-free
due to a race with list traversal?

If this drops the reference count to 0, wacom_release_shared_data() is
called. Concurrently, wacom_add_shared_data() might acquire the
wacom_udev_list_lock and iterate the list.

If it finds this data object before it is removed from the list, it will
call kref_get() on a 0-refcount object via wacom_get_hdev_data() and return
it.

Once the lock is released, the release function could proceed to kfree()
the data object, and the probe thread would access the freed struct.
Should this use kref_put_mutex() with wacom_udev_list_lock to safely
synchronize with the list iteration?

>  		wacom_wac->shared =3D NULL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804103030.1491=
356-1-lee@kernel.org?part=3D2
