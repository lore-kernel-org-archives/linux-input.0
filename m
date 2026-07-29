Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8E6469859
	for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 17:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785344840; cv=none; b=VeyqdNw3DUQyHj61bJu18IAcD8S/m1jOv4j63xm7kAJEAQg9CrXs5tPLXUGFGmBxDe6ItrRjhbtohy2N07qPbQ7uW7rZiSYbEFaW6ers3yNZBOrdNK3ung113nA61gD0hsc1wcibdelwyhpp2Mah+onrywysT+DlaD/ktb8Ssjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785344840; c=relaxed/simple;
	bh=G6CO+Lmw19lkav5cZ6qwvSDXk33rIcXYuifn8QkOrSg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mY3r34Ta1kpkhHiN3d9KyjVNFFYveFwNuxUZJJMSp067ETtRiXNEQXszwh8W9Lkwr5x9FOz61FT+WOdfrR38hpeOgwBNKhqneszwzzlAcJPfAzZXd28BxEjoBCytUOf73ymsdRnIMEe1eFZJc/eS9TPCvEMngSudvt2gyq3ZXJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jafl2jKp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jafl2jKp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 440C01F000E9;
	Wed, 29 Jul 2026 17:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785344838;
	bh=2TKmPiTTZZ1pYTxhMkhWZEP2Dl2WLVTZm4o2OFndYPc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jafl2jKp1yQzjTmCYOpof3pcmQh7dSoPJCSJHGotyzKT12ssCW/dOXHxAr7Ru5yXK
	 1NVTsJ/SW8am7SNw3OI1RC61n9XM+FQDuVRCEOxEToDvz6gq7mZ5i/hvJew6E2Eju9
	 X6aDZn8EPiGmPbZpTt72iUfl0lkeBRyf9qmpWtE/XWASUdSZY1RHqeFaMp8J+mqHkH
	 hvLbQI4kwInTvO9DZX0yTlU5By/3A3gzmihJ/xqjgb9tBdZjD2hPoBWW4YrBnnquub
	 aCokVUMmwYaME/Y0srKki16qIFkL+8P77iu45U1mOfmeT3YtgRxeZ29KV+vJsYNpRH
	 GH4lmS7Phb4nA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] HID: wiimote: replace spinlock pairs with
 scoped_guard
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rafael Passos" <rafael@rcpassos.me>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260729164928.1138468-3-rafael@rcpassos.me>
References: <20260729164928.1138468-1-rafael@rcpassos.me>
 <20260729164928.1138468-3-rafael@rcpassos.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 17:07:17 +0000
Message-Id: <20260729170718.440C01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] Mixing `goto` error handling with `scoped_guard` cleanup helpers=
 in the same function.
- [Medium] Incomplete refactoring and unfulfilled commit message claims reg=
arding lock replacements.

Pre-existing issues:
- [High] Race condition in teardown sequence allows re-scheduling of cancel=
ed work, leading to Use-After-Free.
--

--- Patch [2]: [PATCH v3 2/4] HID: wiimote: replace spinlock pairs with sco=
ped_guard ---
commit 20054d5c329a400384a729c4fe3021c525d804b5
Author: Rafael Passos <rafael@rcpassos.me>

HID: wiimote: replace spinlock pairs with scoped_guard

Cleanup code replacing manual lock/unlock with scoped guards.
This does not change any behavior, but makes it safer to modify.

The multi line spinlock blocks were replaced by braced scoped_guard,
and one-liners by a scoped_guard without braces nor indentation.

> There are two cases left in this driver using lock/unlock, because
> guard would make the code more complex than current implementation.

[Severity: Medium]
Is this statement accurate? It appears that drivers/hid/hid-wiimote-modules=
.c
was mostly skipped during this refactoring, leaving over 30 manual
spin_lock_irqsave() and spin_lock_irq() calls on wdata->state.lock in
functions like wiimod_rumble_worker() and wiimod_battery_get_property().

> diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-cor=
e.c
> index 48830f2ffcb50..762b3c383194e 100644
> --- a/drivers/hid/hid-wiimote-core.c
> +++ b/drivers/hid/hid-wiimote-core.c
[ ... ]
> @@ -675,11 +673,8 @@ static void wiimote_modules_load(struct wiimote_data=
 *wdata,
>  			goto error;
>  	}
> =20
> -	spin_lock_irq(&wdata->state.lock);
> -	wdata->state.devtype =3D devtype;
> -	spin_unlock_irq(&wdata->state.lock);
> -
>  	scoped_guard(spinlock_irqsave, &wdata->state.lock) {
> +		wdata->state.devtype =3D devtype;
>  		/* after loading modules, set the Player ID LED cycling from 1 to 4*/
>  		wiiproto_req_leds(wdata, player_leds[(wdata->player_id - 1) % 4]);
>  	}

[Severity: Medium]
Does this violate the cleanup helper guidelines? This function uses a
"goto error" label for manual error handling earlier in the function,
but now introduces a scoped_guard(). The subsystem guidelines typically
forbid mixing goto-based error handling and scope-based cleanup helpers
in the same function to avoid confusing ownership semantics. This also
happens in wiimote_init_detect() and wiimote_init_check().

[ ... ]
> @@ -1774,14 +1747,11 @@ static struct wiimote_data *wiimote_create(struct=
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
This is a pre-existing issue, but does the teardown sequence later in this
function have a race condition?=20

In wiimote_destroy(), cancel_work_sync() is called on wdata->queue.worker
before the hardware transport is stopped via hid_hw_stop():

	cancel_work_sync(&wdata->queue.worker);
	hid_hw_close(wdata->hdev);
	hid_hw_stop(wdata->hdev);
	kfree(wdata);

If an incoming hardware event arrives in the window after cancel_work_sync()
but before hid_hw_stop(), it can be processed by wiimote_hid_event(). This
could trigger a status reply that queues data and re-schedules the worker v=
ia
schedule_work(&wdata->queue.worker).

Since the worker can be re-enqueued after it was intended to be canceled,
could it execute after kfree(wdata) and cause a use-after-free? Should
the hardware source be stopped before canceling works that the hardware
can schedule?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729164928.1138=
468-1-rafael@rcpassos.me?part=3D2
