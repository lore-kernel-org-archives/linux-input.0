Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE80437123
	for <linux-input@vger.kernel.org>; Fri, 10 Jul 2026 15:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783698450; cv=none; b=EwLg9h5uz2Ui7f/xWSRzRU/LuPMzXr/Tm8z5GQpZarrzLPJt0da5NKkxVRCX38iCtphz8HXFZqV6jGen3uPjzpJWAFusjOy9jTeVrzjD9K0U8o6pzS1VDca8g8KuAwheg26znwi+cf+i2y/2VmJZrR5OjRVfe8iMGZigTx15HIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783698450; c=relaxed/simple;
	bh=1tOhBbqmlu7KfkdO2EcdEUoLa6IRiW4YhsTDn5Klq64=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QFhI/2DJ1PpdSrfDccH0ZbB9QKK66zmwN8APPwgDiassrmu8MYC1K3niQM/P5/UREcYD09PxeMAcn+9cVFD/P06uD1InAKNkkumhQBj0UTtiDAv9ao+FJHSQdJmWvP7otMLZOM+2DzdWuxNtCa7OTSBLURz1MqzOnR2SWVy1Oz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cp1HeZLk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cp1HeZLk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7661F000E9;
	Fri, 10 Jul 2026 15:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783698446;
	bh=eqftURESdToTJ/V+tiH/uMvK8gYGQEV6YRhyFm6Daws=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Cp1HeZLkPbOtzQfK+Vr0RtvjoFbJRPI/bn4ybC5hPFIwaDSV2gIKLRkglGYXevAWd
	 dJ8P0jVC1Kc9R4CFE7cNQzVM4X7YYxHWWkSSa6Xxfqj/QgOD4Cg+st6rknrbaY8fov
	 i0sFHZjmIfYV9A8heJ9JuEGGJwlVcGlVqqgRUst55Bk/5Y6ngxn24YdPJAi3mtSIAK
	 aQ2cqmpjztZr2rfOZrAiuJMRXS20smXPDeuMr1n3SoWK5IAuVaa/7iQAo8w3a3x9/3
	 vOybc1MHgNjNyY6HgpXm7oA2HFp4bx0fRN/gvlr+t/fLLxpo7pn8ivbudS1mwbVaFE
	 E0pLs9QquhN8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] HID: wiimote: replace spinlock pairs with
 scoped_guard
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rafael Passos" <rafael@rcpassos.me>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260710153456.2093889-3-rafael@rcpassos.me>
References: <20260710153456.2093889-1-rafael@rcpassos.me>
 <20260710153456.2093889-3-rafael@rcpassos.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 15:47:25 +0000
Message-Id: <20260710154725.DA7661F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] Functions wiimote_init_detect() and wiimote_init_check() mix goto-b=
ased cleanup labels with cleanup.h helpers (scoped_guard).

Pre-existing issues:
- [High] Race condition during device teardown allows `queue.worker` to be =
re-scheduled after cancellation, leading to a Use-After-Free on `wdata`.
--

--- Patch [2]: [PATCH 2/3] HID: wiimote: replace spinlock pairs with scoped=
_guard ---
commit b72167f4bfaf6c447e5bff82a564df82f7c2a54d
Author: Rafael Passos <rafael@rcpassos.me>

HID: wiimote: replace spinlock pairs with scoped_guard

Cleanup code replacing manual lock/unlock with scoped guards.
This does not change any behavior, but makes it safer to modify.

> diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-cor=
e.c
> --- a/drivers/hid/hid-wiimote-core.c
> +++ b/drivers/hid/hid-wiimote-core.c
> @@ -878,19 +867,19 @@ static void wiimote_init_detect(struct wiimote_data=
 *wdata)
> =20
>  	wiimote_cmd_acquire_noint(wdata);
> =20
> -	spin_lock_irq(&wdata->state.lock);
> -	wdata->state.devtype =3D WIIMOTE_DEV_UNKNOWN;
> -	wiimote_cmd_set(wdata, WIIPROTO_REQ_SREQ, 0);
> -	wiiproto_req_status(wdata);
> -	spin_unlock_irq(&wdata->state.lock);
> +	scoped_guard(spinlock_irq, &wdata->state.lock) {
> +		wdata->state.devtype =3D WIIMOTE_DEV_UNKNOWN;
> +		wiimote_cmd_set(wdata, WIIPROTO_REQ_SREQ, 0);
> +		wiiproto_req_status(wdata);
> +	}
> +
> =20
>  	ret =3D wiimote_cmd_wait_noint(wdata);
>  	if (ret)
>  		goto out_release;

[Severity: Low]
Is it acceptable to mix goto-based error handling with scoped_guard() in the
same function?

According to the cleanup.h documentation, the expectation is that a function
either uses goto-based cleanup or scope-based cleanup exclusively. Since
this patch introduces scoped_guard() while leaving goto out_release, does
this violate the subsystem guidelines for mixing cleanup styles? This same
pattern also appears further down in wiimote_init_check().

[ ... ]

> @@ -1767,14 +1745,12 @@ static struct wiimote_data *wiimote_create(struct=
 hid_device *hdev)
> =20
>  static void wiimote_destroy(struct wiimote_data *wdata)
>  {
> -	unsigned long flags;
> -
>  	wiidebug_deinit(wdata);
> =20
>  	/* prevent init_worker from being scheduled again */
> -	spin_lock_irqsave(&wdata->state.lock, flags);
> -	wdata->state.flags |=3D WIIPROTO_FLAG_EXITING;
> -	spin_unlock_irqrestore(&wdata->state.lock, flags);
> +	scoped_guard(spinlock_irqsave, &wdata->state.lock) {
> +	    wdata->state.flags |=3D WIIPROTO_FLAG_EXITING;
> +	}
> =20
>  	cancel_work_sync(&wdata->init_worker);
>  	timer_shutdown_sync(&wdata->timer);
[ ... ]
> 	wiimote_mp_unload(wdata);
> 	wiimote_ext_unload(wdata);
> 	wiimote_modules_unload(wdata);
> 	cancel_work_sync(&wdata->queue.worker);
> 	hid_hw_close(wdata->hdev);
> 	hid_hw_stop(wdata->hdev);
>=20
> 	kfree(wdata);
>  }

[Severity: High]
This is a pre-existing issue, but could this teardown sequence result in a
use-after-free on wdata?

Currently, cancel_work_sync(&wdata->queue.worker) is called before
hid_hw_stop(wdata->hdev). If an incoming status report arrives after the wo=
rk
is canceled but before the HID device is stopped, wiimote_hid_event() could
handle it and call handler_status_K() -> wiiproto_req_drm() ->
wiimote_queue(), which unconditionally re-arms the work queue via
schedule_work(&wdata->queue.worker).

If the queue worker executes after wdata is freed by kfree(wdata) here,
would it dereference freed memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710153456.2093=
889-1-rafael@rcpassos.me?part=3D2
