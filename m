Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CCA3F99FE
	for <linux-input@vger.kernel.org>; Tue,  7 Jul 2026 12:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783427218; cv=none; b=d0O8QImtnrJ2hxln9N+slUY9/lBuBMKeZh2Sxq8NfCbGAdbsYx3FaZMkSakW09oY4C4eelnUDxJY6Syp/qE/Hc6yrDoIU7B+elTJl4Z+5IBZbCNKCyo/Y9eq/w4FCvNNcttrRlzdf37/W+NsLsp9w+pd48Yljttpws31aGGkdb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783427218; c=relaxed/simple;
	bh=oqXd2zn7zHLLf02hweIsGPuj7yoXA9bY5BsyAMHb/1w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BrLBGuYmsS2xm422blkJkAV2tlLFBsHqMf+nJAnfqarO3R+gV5MX3eip/GZA9hsgNsSRpaJJw7Pkao+rYP1vK7Bdso4IBWo1YpVD0rXK1qSqb9VI7oQemMEq/H5D7WvBjX5UPnlXDNUpK9u/T+42W94Ou3YIiP2/yxanDUnTcm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fLSQmsb/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLSQmsb/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6AB71F00A3A;
	Tue,  7 Jul 2026 12:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783427217;
	bh=lxxAb1BO6mGs0K2hbUx53YsiNVSw0UQ5zrbAp/cJgmg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fLSQmsb/03et5gE58z9crjm4lr0j/V0BbjmpmfKcJBMpHSV04Yy2C/+dhevTvnXPe
	 6nrZg2UcIQ86l0fkin+igB4lEN60DtaRCtrz76j8GyLTbunYEm+GYQvsJ1ADu/JqOY
	 SGFnd6jaiZwwV8Yt8rUxclfiPNOqVZH0xX87OWLKZypYx+b1xQmELpOglo9wo5RpmS
	 KzWXZx8G41iKfM1R4Nt1QWnauBdc1f9aTsWB5nWqzBhfqo8qnS32KIr3Bgz7DihZQ1
	 ors8PtS+EjTxXhyBklN9i/pVikXGgzmbtmbjxvS8roJMAJyJ91Ut/kZZxX3yPqO9ev
	 +xGCA9KglRtEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] HID: wacom: Fix Use-After-Free in wacom_intuos_pad
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lee Jones" <lee@kernel.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260707121051.1683937-2-lee@kernel.org>
References: <20260707121051.1683937-1-lee@kernel.org>
 <20260707121051.1683937-2-lee@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 12:26:56 +0000
Message-Id: <20260707122656.C6AB71F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Pre-existing use-after-free race between kref_put() in wacom_remov=
e_shared_data() and list traversal in wacom_get_hdev_data().
- [High] Lockless reads of `shared->pen` and `shared->touch` lead to TOCTOU=
 Use-After-Free.
--

--- Patch [2]: [PATCH 2/4] HID: wacom: Fix Use-After-Free in wacom_intuos_p=
ad ---
commit 7367a08b48f1d1fc2e7dc8823f95547c3c03eb51
Author: Lee Jones <lee@kernel.org>

HID: wacom: Fix Use-After-Free in wacom_intuos_pad

wacom_intuos_pad() accesses wacom->shared->touch_input locklessly
inside the interrupt handler context.  If the Touch sibling device
is disconnected, wacom_remove_shared_data() clears touch_input
outside any lock, creating a Time-of-Check to Time-of-Use (TOCTOU)
race condition.

Resolve this by introducing RCU protection for the touch_input
pointer.

> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 6c2a3ddfe366a..c6b37931d02d1 100644
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

[Severity: High]
This isn't a bug introduced by this patch, but since we are introducing
RCU protection for touch_input, do shared->pen and shared->touch need
similar RCU annotations and read guards?

wacom_mode_change_work() reads both pointers locklessly in preemptible
workqueue context:

drivers/hid/wacom_sys.c:wacom_mode_change_work() {
    ...
    if (shared->pen) {
        wacom1 =3D hid_get_drvdata(shared->pen);
    ...
    if (shared->touch) {
        wacom2 =3D hid_get_drvdata(shared->touch);
    ...
}

Similarly, wacom_bamboo_pad_pen_event() dereferences shared->pen without
protection:

drivers/hid/wacom_wac.c:wacom_bamboo_pad_pen_event() {
    ...
    hid_input_report(wacom->shared->pen, HID_INPUT_REPORT, data, ...);
    ...
}

Because these readers run without rcu_read_lock() or guard(rcu), the new
synchronize_rcu() call won't wait for them, potentially leaving them to
dereference freed pointers when the sibling device unbinds. Should pen and
touch also be converted to RCU pointers?

> +
> +		synchronize_rcu();
> =20
>  		kref_put(&data->kref, wacom_release_shared_data);

[Severity: High]
This is a pre-existing issue, but does this lockless kref_put() create a
race condition with concurrent device probes?

If a concurrent unbind and probe occurs, kref_put() can drop the refcount
to 0 and synchronously call wacom_release_shared_data(). Before the
release function can acquire the wacom_udev_list_lock to remove the
object, a concurrent wacom_add_shared_data() might call
wacom_get_hdev_data().

wacom_get_hdev_data() iterates the list under the lock, finds the still-
linked object, and blindly calls kref_get(&data->kref) on the 0-refcount
object:

drivers/hid/wacom_sys.c:wacom_get_hdev_data() {
    ...
    list_for_each_entry(data, &wacom_udev_list, list) {
        if (strncmp(data->phys, hdev->phys, sizeof(data->phys) - 2) =3D=3D =
0) {
            kref_get(&data->kref);
            return data;
        }
    ...
}

When the lock is dropped, the release function proceeds to kfree() the
object, leaving the prober with a freed pointer. Should this be using
kref_put_mutex() or kref_get_unless_zero() to safely handle the list
removal?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707121051.1683=
937-1-lee@kernel.org?part=3D2
