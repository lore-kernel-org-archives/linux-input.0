Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D363D1CB0
	for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 21:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784151562; cv=none; b=nTJ1xdDSjaUvw80AEn5vZmufSkRR8g6w3lB5CJlyFuGwbl/Rh5YvzUO/cXngLW4TH9gkzReitr4XPNSct2I2DCUiAiJBwpy+NNogtDSuAcPozaGBRQMuntPtp8xEHVxG8fIRv3vyi77GUgwJXUE5anXx6FxHAVVo1Q3T1Ncr/sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784151562; c=relaxed/simple;
	bh=RkSSJVgfWrT8Sg8WFmkegiVsVj6yY1FFREU9T+NDLUo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IUxkNV9LgbOixU105LgAuR520sajzXBe4Yo5l52Ru6YrSfegogbjX+ZB4Rp2vz3EK6fjv1Ey+oiUIqiiWU6LYdALdL2JusR80OCbumxgngLqBBID2O6bNCEEXXk3w3EWEapHwyrqMpRdEZDdDmL8IcGVzK/XYWVTyEW2AAnwPWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JvfzP+JS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvfzP+JS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 091FE1F00A3A;
	Wed, 15 Jul 2026 21:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784151559;
	bh=I6zJ5jINVd5UQeiiPdntnf4gENcqNTkztgR91Afqkz0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JvfzP+JSSlOsKVFCZZc5fX6FChxaUznX6QaEgCGTWc57zdEikGSGM8yg6Gy62SQ46
	 ri0y95YYvFuzlxnWyxplViZQlP+SMglYk0cloG4evzs2P6YgZ0or2JDcDqH5PASz95
	 xqZYVuYRTOx3fCSMAMF69E31mW0XGRteu4aSOFY5Edr8MluZprhkgKrBxZO3Pu2h4h
	 OXmW5odKQ5pD9ceRav5EV4carnZJgrcba0alYTHlMMwIz8cpD0RCJWEe1r6hleKGBt
	 IvB5p0iJ/CYH9dWxR3PlBvEs6W7tqYlcz5sjTAJciXgQCQHOOy2PKwUDdZErI+nJbi
	 vOOtfSamVWaSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] HID: wiimote: replace spinlock pairs with
 scoped_guard
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rafael Passos" <rafael@rcpassos.me>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260715212501.3920033-3-rafael@rcpassos.me>
References: <20260715212501.3920033-1-rafael@rcpassos.me>
 <20260715212501.3920033-3-rafael@rcpassos.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 21:39:18 +0000
Message-Id: <20260715213919.091FE1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] Functions mix `goto`-based error handling cleanup labels with sc=
ope-based cleanup (`scoped_guard()`), violating the cleanup subsystem archi=
tectural rule.
- [Low] Incorrect 4-space indentation within `scoped_guard` blocks instead =
of standard kernel tabs.

Pre-existing issues:
- [High] Use-after-free of `wdata` because `queue.worker` can be reschedule=
d after it is cancelled in `wiimote_destroy()`.
--

--- Patch [2]: [PATCH v2 2/4] HID: wiimote: replace spinlock pairs with sco=
ped_guard ---
commit 343c163a7f9f1368f62e298a4bac0953c054d9f3
Author: Rafael Passos <rafael@rcpassos.me>

HID: wiimote: replace spinlock pairs with scoped_guard
   =20
Cleanup code replacing manual lock/unlock with scoped guards.
This does not change any behavior, but makes it safer to modify.

> diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-cor=
e.c
> index 91c2cec35f6eb..d37d740a7162f 100644
> --- a/drivers/hid/hid-wiimote-core.c
> +++ b/drivers/hid/hid-wiimote-core.c
> @@ -362,13 +363,12 @@ void wiiproto_req_rmem(struct wiimote_data *wdata, =
bool eeprom, __u32 offset,
>  int wiimote_cmd_write(struct wiimote_data *wdata, __u32 offset,
>  						const __u8 *wmem, __u8 size)
>  {
[ ... ]
> -	spin_lock_irqsave(&wdata->state.lock, flags);
> -	wiimote_cmd_set(wdata, WIIPROTO_REQ_WMEM, 0);
> -	wiiproto_req_wreg(wdata, offset, wmem, size);
> -	spin_unlock_irqrestore(&wdata->state.lock, flags);
> +	scoped_guard(spinlock_irqsave, &wdata->state.lock) {
> +	    wiimote_cmd_set(wdata, WIIPROTO_REQ_WMEM, 0);
> +	    wiiproto_req_wreg(wdata, offset, wmem, size);
> +	}

[Severity: Low]
this isn't a bug, but did the indentation get changed to 4 spaces here inst=
ead
of standard kernel tabs?

[ ... ]
> @@ -885,19 +874,19 @@ static void wiimote_init_detect(struct wiimote_data=
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

[Severity: Medium]
Does this mix goto-based cleanup labels with scope-based cleanup?

The cleanup guidelines state that for a given routine, all resources requir=
ing
cleanup should be converted to scope-based cleanup, or none of them should =
be.

This function (as well as wiimote_init_check() and wiimote_modules_load())
still uses goto-based cleanup like goto out_release; and goto error;
combined with the new scoped_guard() declarations.

[ ... ]
> @@ -1120,16 +1108,15 @@ static void wiimote_init_hotplug(struct wiimote_d=
ata *wdata)
> =20
>  	wiimote_cmd_acquire_noint(wdata);
> =20
> -	spin_lock_irq(&wdata->state.lock);
> -
> -	/* get state snapshot that we will then work on */
> -	flags =3D wdata->state.flags;
> +	scoped_guard(spinlock_irq, &wdata->state.lock) {
> =20
> -	/* disable event forwarding temporarily */
> -	wdata->state.flags &=3D ~WIIPROTO_FLAG_EXT_ACTIVE;
> -	wdata->state.flags &=3D ~WIIPROTO_FLAG_MP_ACTIVE;
> +	    /* get state snapshot that we will then work on */
> +	    flags =3D wdata->state.flags;

[Severity: Low]
this isn't a bug, but it looks like the contents of this scoped_guard block=
=20
are also indented with 4 spaces instead of a tab.

[ ... ]
> @@ -1774,14 +1749,11 @@ static struct wiimote_data *wiimote_create(struct=
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
> +	scoped_guard(spinlock_irqsave, &wdata->state.lock)
> +		wdata->state.flags |=3D WIIPROTO_FLAG_EXITING;
> =20
>  	cancel_work_sync(&wdata->init_worker);
>  	timer_shutdown_sync(&wdata->timer);

[Severity: High]
This isn't a bug introduced by this patch, but does the teardown sequence
in wiimote_destroy() have a use-after-free race condition?

Looking at the rest of wiimote_destroy(), cancel_work_sync(&wdata->queue.wo=
rker)
is called before hid_hw_stop(wdata->hdev). If a HID interrupt arrives
immediately after the worker is cancelled:

HID core calls wiimote_hid_event() ->
    handler_status_K() ->
    wiiproto_req_drm() ->
    wiimote_queue()

wiimote_queue() then calls schedule_work(&wdata->queue.worker) without
checking if the device is exiting.

Since hid_hw_stop() hasn't been called yet, the new worker is queued. After
hid_hw_stop() and kfree(wdata) complete, the queued worker can execute and
dereference the freed wdata.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715212501.3920=
033-1-rafael@rcpassos.me?part=3D2
