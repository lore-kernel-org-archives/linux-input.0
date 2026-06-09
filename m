Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E55419308
	for <linux-input@vger.kernel.org>; Tue,  9 Jun 2026 12:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781009320; cv=none; b=SzYZLrUEaiEX43xeuGrCPvCT+gii0cuFt4AaPKSoLJAk4D9UWb9Rux4+sYGfWMYQH4UOKjiuClZ5J3WzUjLR4p8Qiu7PXk77vb9FfcLSJ3SMJE69iEGcXMn+mqdXFfqTwTYSb7oZrkYbjJSUTLfBpNeb6Ot0UIgVEOrG2NjK2Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781009320; c=relaxed/simple;
	bh=dg3PBpsI/oJYz7tNCpsol1GQuxcmKtDphgO0yTh5jl8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nQRsePUYpBWB7rJZ7kZMeDdq4yjyQBYd5b5S+6v2FD1RmAD07Hu7q/BpfIe9OJWq+FylXD1+upFywLPy4i/WLaMJX6G6RfN1FBN5AY9t8mv+5YbtVW5pHFpu8Z+8s+Z4jJ3UFlbWcG13WkTibeDzQCE8iUOMVMsEdiNxADuu4bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eseklE6Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eseklE6Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0AD71F00893;
	Tue,  9 Jun 2026 12:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781009318;
	bh=do4gEky3yMQFcf0lhmMzrTfUOKAWcgb6jUILE37yPrE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eseklE6ZTtw597U8v8RvIsQmHv7ckiEvpUqWDlzjA8o7b1+y+LMY7xdXS2Ox/irWF
	 QOBYZ1unPqUtEQwS8/PyEgEOieDPdtf1lM//QYNE/X9f1ivloX+f3Ly6TzOITeQlKX
	 WUZvLssTXoI/VyzwO6qyHVFXuls1PIfLEPppFpM2g9KYPv+ig+BkY47/HlRj/LFR6O
	 72LSV05fuALQLha3llxJkvZl+bZkmTbZ9eiSw7bJ/qUZHd5E/I+pCPs+jSd0GGaGex
	 HSF4oppKXN0/H4I3snMQLobGBsileXTdJzHU6axw/8b0mNgoY1LWn8sQwWvHej0kDa
	 ATUQNQ9Q+W1Cw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] HID: wacom: Fix teardown order in
 wacom_mode_change_work
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lee Jones" <lee@kernel.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260609121353.3743782-4-lee@kernel.org>
References: <20260609121353.3743782-4-lee@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 12:48:38 +0000
Message-Id: <20260609124838.A0AD71F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing synchronization between sibling device removal and `wa=
com_mode_change_work` leads to Use-After-Free and double `hid_hw_stop()`.
- [Critical] Missing synchronization allows multiple `wacom_mode_change_wor=
k` instances to execute concurrently on both siblings, leading to double te=
ardown and state corruption.
- [Critical] Error paths in `wacom_parse_and_register()` after `hid_hw_star=
t()` fail to call `hid_hw_stop()`, leaving hardware IRQs active after relea=
sing resources.
- [High] If `wacom_parse_and_register()` fails for the first sibling device=
, the second device is permanently left in a stopped and uninitialized stat=
e.
- [High] Pending background workqueues and timers are not cancelled before =
releasing device resources in `wacom_mode_change_work`, violating subsystem=
 teardown guidelines and causing UAF.
- [High] `wacom_remove()` cancels `mode_change_work` after stopping the har=
dware, creating a race that leaves the device started and permanently leaks=
 HID interfaces.
--

commit 0812538ee6f90ea0ab3dbb1250c3e8460816a993
Author: Lee Jones <lee@kernel.org>

HID: wacom: Fix teardown order in wacom_mode_change_work

wacom_mode_change_work() called wacom_release_resources() before
hid_hw_stop(), which could lead to a crash if hardware IRQs fire and
dereference the nullified shared pointer. This commit fixes the teardown
order to call hid_hw_stop() first.

> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 1b019e3331b45..378dddbf7ec5b 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -2835,16 +2835,16 @@ static void wacom_mode_change_work(struct work_st=
ruct *work)
> =20
>  	if (pen) {

[Severity: Critical]
This is a pre-existing issue, but is it possible for the shared device
pointers to be dereferenced after they are freed?

In wacom_mode_change_work(), the sibling device pointers are fetched:

    struct hid_device *pen =3D rcu_access_pointer(shared->pen);
    ...

These pointers are accessed without holding an rcu_read_lock or acquiring
a device reference. If a sibling device is concurrently unbound,
wacom_remove() clears the shared pointer and calls synchronize_rcu(), but
it would not wait for this worker. Could this result in a use-after-free
when hid_hw_stop() is called on the stale pointer?

[Severity: Critical]
This isn't a bug introduced by this patch, but does this function have
sufficient synchronization if mode change events arrive concurrently on
both pen and touch interfaces?

Since the code unconditionally operates on both sibling devices without
locking:

    wacom1 =3D hid_get_drvdata(pen);
    hid_hw_stop(wacom1->hdev);
    wacom_release_resources(wacom1);

If both devices independently schedule their own mode_change_work, could
both workers run simultaneously and race to call wacom_release_resources()
on the exact same pointers, potentially causing a double-free in the
devres core?

>  		wacom1 =3D hid_get_drvdata(pen);
> -		wacom_release_resources(wacom1);
>  		hid_hw_stop(wacom1->hdev);
> +		wacom_release_resources(wacom1);

[Severity: High]
This is a pre-existing issue, but are we certain all background tasks
are cancelled before releasing resources here?

Unlike wacom_remove(), wacom_mode_change_work() does not cancel pending
tasks like init_work before calling wacom_release_resources(). Since
wacom_release_resources() destroys devres allocations (such as led groups),
could a delayed wacom_init_work() execute concurrently and access these
freed structures, resulting in a use-after-free?

>  		wacom1->wacom_wac.has_mode_change =3D true;
>  		wacom1->wacom_wac.is_direct_mode =3D is_direct;
>  	}
> =20
>  	if (touch) {
>  		wacom2 =3D hid_get_drvdata(touch);
> -		wacom_release_resources(wacom2);
>  		hid_hw_stop(wacom2->hdev);
> +		wacom_release_resources(wacom2);
>  		wacom2->wacom_wac.has_mode_change =3D true;
>  		wacom2->wacom_wac.is_direct_mode =3D is_direct;
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but what happens to the second
device if re-registration fails for the first one?

Looking at the rest of wacom_mode_change_work():

    if (wacom1) {
        error =3D wacom_parse_and_register(wacom1, false);
        if (error)
            return;
    }
    if (wacom2) {
        ...
    }

If wacom_parse_and_register() fails for wacom1, the early return bypasses
the initialization for wacom2. Does this permanently leave the touch
interface hardware stopped and its resources released without recovery?

[Severity: Critical]
This is a pre-existing issue, but is there a missing hardware teardown
in the error handling path of wacom_parse_and_register()?

When an error occurs after hid_hw_start() succeeds:

drivers/hid/wacom_sys.c:wacom_parse_and_register() {
    ...
fail_quirks:
    hid_hw_stop(hdev);
fail:
    wacom_release_resources(wacom);
    return error;
}

The goto fail jumps past hid_hw_stop(hdev). Does this leave the hid
hardware running while its resources are freed, allowing subsequent
hardware irqs to trigger wacom_raw_event() and cause a use-after-free?

[Severity: High]
This isn't a bug introduced by this patch, but does wacom_remove()
cancel the mode_change_work too late?

In wacom_remove(), the cancellation happens after stopping the hardware:

drivers/hid/wacom_sys.c:wacom_remove() {
    hid_hw_stop(hdev);
    cancel_delayed_work_sync(&wacom->init_work);
    ...
    cancel_work_sync(&wacom->mode_change_work);
}

If mode_change_work is pending and runs after hid_hw_stop(), it will
call wacom_parse_and_register(), which invokes hid_hw_start(hdev).
Once cancel_work_sync() returns, wacom_remove() completes without
re-stopping the hardware. Could this permanently leak the active hid
interfaces?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609121353.3743=
782-1-lee@kernel.org?part=3D4
