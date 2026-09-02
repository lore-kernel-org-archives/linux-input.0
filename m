Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4117229B76C
	for <linux-input@vger.kernel.org>; Wed,  2 Sep 2026 14:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788357856; cv=none; b=uofgC01M2XC29KKAQsTZhEYYx7j5OHk8YsCHY9N/I+jXlO6kBvFSKQjaBdVFGA0eVqS78tbZxRiEgyXz2s8ic4eMNb7WyzNRAGw3LwuMUWUwip8MQty0eV8I1EPI9TI/drjlWFfQtXKR4C5PrGsTiF9vZITWkKVQRyy4Gn9ob6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788357856; c=relaxed/simple;
	bh=mMMFsv+rxnLe2vL/Z3WDkQigK/bLIJlgOuYL2x2aB9M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qbS9MC7rWslmVDnZMy5k6AW5/yx0WOl2bmbbW1cQ2UOzgzY4iaZccph2C5aYqNRC4kE5qm9LeRmdZ+Qiqlu4Usycd2fvW/E6jTlzXBeI3ThqxgtirPBezH/5Wb8IzXxqkA4b3J1ogIH8D39sZ/9UtmpK/Vwz9gAg2EPoF+e++0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMW2UObE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMW2UObE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B476E1F000E9;
	Wed,  2 Sep 2026 14:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788357854;
	bh=10CALePqn7Lwk7WdOlWY72d2vZvqJnQoPfTu5VAweT4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IMW2UObERMJGEn+kmHwu3beZS5N9TegOe/vvuOc7liRAQPUW5eavt06BkVGHR4TVV
	 op6M0INl7hnq+nD/vbbHwgl7GcXILsGeYFcaCkMxUGoXZ2uULKys+7Y7biBNca3YfP
	 VPOv2rh4DLvy/GTKleVLlWOv4SQX2hYxIR7q4qj4ZW8sliRzGLXgY+4SZXMaaDIyhz
	 KpntP1vL5B/EV2+HdsDX5BenObwsneyuTRt/uqBK5jqAUDEYz/zlNc94EecjLjhKlw
	 iTr4pKBSIzQo+SrW8LcjZ172ykVeYSukhetnThzuD9aP8Ow663v1EKA4gZ0e92UReG
	 xHzu+OM9ouJ1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 3/5] HID: wacom: Fix Use-After-Free in
 wacom_intuos_pad
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lee Jones" <lee@kernel.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260902134417.1270552-3-lee@kernel.org>
References: <20260902134417.1270552-1-lee@kernel.org>
 <20260902134417.1270552-3-lee@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 14:04:14 +0000
Message-Id: <20260902140414.B476E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing cancellation of asynchronous work queues and timers in the=
 probe error path after hardware start.
- [High] Lockless access to `shared->touch` and `shared->pen` in `wacom_mod=
e_change_work` can lead to Use-After-Free during concurrent device removal.
--

commit 1b2b5cb79815a8638c58444b1176590871426b5f
Author: Lee Jones <lee@kernel.org>

    HID: wacom: Fix Use-After-Free in wacom_intuos_pad

    This patch addresses a Use-After-Free race condition in wacom_intuos_pa=
d()
    by adding RCU protection to the touch_input pointer. It also wraps devi=
ce
    assignments in wacom_udev_list_lock to serialize concurrent probe
    assignments.

> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 026a6be467d3d..1af0d518260d6 100644
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
> +			}
> +		}
> +
> +		synchronize_rcu();
> =20
>  		kref_put(&data->kref, wacom_release_shared_data);
>  		wacom_wac->shared =3D NULL;

[ ... ]

While reviewing this code, I noticed a couple of pre-existing issues in the
surrounding functions.

drivers/hid/wacom_sys.c:wacom_parse_and_register() {
    ...
	error =3D hid_hw_start(hdev, connect_mask);
	if (error) {
		hid_err(hdev, "hw start failed\n");
		goto fail;
	}

	error =3D wacom_register_inputs(wacom);
	if (error)
		goto fail_hw_stop;
    ...
fail_hw_stop:
	hid_hw_stop(hdev);
fail:
	wacom_release_resources(wacom);
	return error;
}

[Severity: High]
This is a pre-existing issue and was not introduced by the patch under
review, but does this error path omit the cancellation of asynchronous
resources?

Once hid_hw_start() is called, the device hardware can generate interrupts
and schedule background work such as wireless_work, battery_work, or the
idleprox_timer. If a subsequent initialization step fails, the probe error
path calls hid_hw_stop() and wacom_release_resources(), and then returns.
This causes devres to free the wacom structure. Because the scheduled work
is not explicitly canceled using cancel_work_sync() or timer_delete_sync(),
the work could execute later and access the freed structure, leading to a
Use-After-Free.

drivers/hid/wacom_sys.c:wacom_mode_change_work() {
    ...
	if (shared->pen) {
		wacom1 =3D hid_get_drvdata(shared->pen);
		wacom_release_resources(wacom1);
		hid_hw_stop(wacom1->hdev);
		wacom1->wacom_wac.has_mode_change =3D true;
    ...
}

[Severity: High]
This is a pre-existing issue and was not introduced by the patch under
review, but could this lockless access to sibling devices lead to a
Use-After-Free?

The wacom_mode_change_work function locklessly accesses sibling device
pointers like shared->pen and shared->touch. If the sibling device is
concurrently hot-unplugged and unbound, the synchronize_rcu() call in the
unbind path does not block this work from using a cached pointer, since
there is no RCU read-side critical section (such as guard(rcu)()). This
allows hid_get_drvdata() to dereference a freed device structure, resulting
in a Use-After-Free.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902134417.1270=
552-1-lee@kernel.org?part=3D3
