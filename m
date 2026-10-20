Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792491121;
	b=oalW2Pb9qaoWrxtmzyoSlwudH13L4F86K5XaeTdxfBRKnkFyr4yrLAn6OYTkSYdxzkQB
	 a6n09Xj98eCDpF9AReW5wUIp585KRQD9Rq49Di/ItFMyxkB2BTwzOedMRfevi5c8LUtYB
	 6qW6Zef3F+jxvAdB+pxtePpYxufRzQhQ/IGhYF1C7LzT/q4iMb5pRpzcEeKjoWu8RLVcp
	 Ucum5kR5j+AHcDiTz4p75ZaPQb2wsaQLWkhCCmagBnizK9tyflNR/y2dgmHdeRlM8tDjN
	 1L0S2Jp90dbdzO95kG4mqrXeY7fZc+KwgwozkfgLOD+Rt4tRBtEK1vTgns7jaokEpEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792491121;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=exiWgB386JJrdzlIk0ve3kuw6ENufLsu74Xr/DA2eWc=;
	b=Hfe5ZIUmwebeOccNUEEHVMhQsxSttDaAIdb0dKsq07lPbIDp4UTfuzGW55HA8Y1c75wk
	 OSdC7A1zdmydnUwxzlVTyr8wU+d4c1IJscpFLWqbuDjjAbtmPwrjjjQxHAdmjfkpn1AF3
	 +wzltb8VnSqiIEEux+D+8aR56u4mRanl4m5qJNFokVF1QiE1nR/90sc+xEENLxHpKf51S
	 fxlIGW2GqoaURMe1gISoQISNrBPffWMEBfFa2mwJY4qybneofkv3KNTdaPS5+qsIChfVQ
	 ewXihqUUdO84+oLQL1yTBUp4pSG/3EhsTOyilZa+fgHDgRm/J68eMvCJmyn8ai23mWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gpmqhVfG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC01A606A323;
	Tue, 20 Oct 2026 10:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gpmqhVfG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD4B1F000C5;
	Tue, 20 Oct 2026 10:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792491120;
	bh=exiWgB386JJrdzlIk0ve3kuw6ENufLsu74Xr/DA2eWc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gpmqhVfGdYhy0xlZM+WpVybSEeXluWqt0P2xjPOMgR9/HO7J70Gp90acgEJcH7Ls7
	 mUoQdvG8aUMlpAvc4E8zMfdOdtE2m/TJhsCxqVtespIaw+Fqn+FGRq3TgsLNKWaDwk
	 QtX29P/RDWCuTcw/ZJPel10ZTx6WdXvOSievptbXtCsEKxXeOVmHfYKfIBHrOYQCaP
	 74symuYrWY/xlg9vf24Ghczze2w/QMoxcZKtF51Z/TrOOMWa9CsGlYO1fG3mTAoFi4
	 Q3Hl6fifC1n4PIJ4D+fe6g2wHWjPrEjgfsqAGreFWU1Mz5H+5+YYjZ51qSO7afxtyc
	 Rzcji1PezMTig==
Message-ID: <sashiko-outbox-178800@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/3] HID: lamparray: blank lamps across suspend and
 restore on resume
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Erhardt" <aer@tuxedocomputers.com>
Cc: linux-input@vger.kernel.org, linux-leds@vger.kernel.org, dmitry.torokhov@gmail.com, lee@kernel.org
In-Reply-To: <20261020-hid-lamparray-v7-3-47418b667b47@tuxedocomputers.com>
References: <20261020-hid-lamparray-v7-0-47418b667b47@tuxedocomputers.com>
 <20261020-hid-lamparray-v7-3-47418b667b47@tuxedocomputers.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 10:11:59 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] HID: hid-generic: missing PMSG_IS_AUTO() check in hid_generic_susp=
end()
- [Medium] HID: lamparray: missing LED_SUSPENDED and work flush in lamparra=
y_suspend()
- [Medium] HID: lamparray: race on use_leds_uapi in suspend and resume paths
--

commit eae25839ebd677bf288de15dd8a2d0952e978e6d
Author: Cristian Mazzotta <cmmazzo@icloud.com>

HID: lamparray: blank lamps across suspend and restore on resume

This commit adds lamparray_suspend() and lamparray_resume() helpers to blank
LampArray lighting before system sleep and restore the cached RGB and
brightness state on resume, wiring them up in hid-generic.

> diff --git a/drivers/hid/hid-generic.c b/drivers/hid/hid-generic.c
> index fde772c5014bb..f78c62f796fbb 100644
> --- a/drivers/hid/hid-generic.c
> +++ b/drivers/hid/hid-generic.c
> @@ -102,9 +102,34 @@ static int hid_generic_probe(struct hid_device *hdev,
> =20
>  static int hid_generic_reset_resume(struct hid_device *hdev)
>  {
> +	struct lamparray *la =3D hid_get_drvdata(hdev);
> +
>  	if (hdev->claimed & HID_CLAIMED_INPUT)
>  		hidinput_reset_resume(hdev);
> =20
> +	if (IS_ENABLED(CONFIG_HID_LAMPARRAY) && la)
> +		lamparray_resume(la);
> +
> +	return 0;
> +}
> +
> +static int hid_generic_suspend(struct hid_device *hdev, pm_message_t mes=
sage)
> +{
> +	struct lamparray *la =3D hid_get_drvdata(hdev);
> +
> +	if (IS_ENABLED(CONFIG_HID_LAMPARRAY) && la)
> +		lamparray_suspend(la);
> +
> +	return 0;
> +}
> +
> +static int hid_generic_resume(struct hid_device *hdev)
> +{
> +	struct lamparray *la =3D hid_get_drvdata(hdev);
> +
> +	if (IS_ENABLED(CONFIG_HID_LAMPARRAY) && la)
> +		lamparray_resume(la);
> +
>  	return 0;
>  }

[Severity: High]
How does this behave with USB runtime autosuspend when PMSG_IS_AUTO(message)
is true?

In drivers/hid/usbhid/hid-core.c, hid_suspend() counts only EV_LED usages in
HID_OUTPUT_REPORT via hidinput_count_leds(), not LampArray HID_FEATURE_REPO=
RT
LEDs. When a USB LampArray interface enters runtime autosuspend in S0,
hid_suspend() sets HID_SUSPENDED on usbhid->iofl before calling
hid_driver_suspend():

drivers/hid/usbhid/hid-core.c:hid_suspend() {
	if (PMSG_IS_AUTO(message)) {
		ledcount =3D hidinput_count_leds(hid);
		spin_lock_irq(&usbhid->lock);	/* Sync with error handler */
		if (!test_bit(HID_RESET_PENDING, &usbhid->iofl)
		    && !test_bit(HID_CLEAR_HALT, &usbhid->iofl)
		    && !test_bit(HID_OUT_RUNNING, &usbhid->iofl)
		    && !test_bit(HID_CTRL_RUNNING, &usbhid->iofl)
		    && !test_bit(HID_KEYS_PRESSED, &usbhid->iofl)
		    && (!ledcount || ignoreled))
		{
			set_bit(HID_SUSPENDED, &usbhid->iofl);
			spin_unlock_irq(&usbhid->lock);
			status =3D hid_driver_suspend(hid, message);
}

Because hid_generic_suspend() ignores message and calls lamparray_suspend(),
lamparray_hw_set_state() -> hid_hw_request() -> __usbhid_submit_report()
queues the (0, 0, 0, 0) report in usbhid->ctrl[] and calls
usbhid_restart_ctrl_queue(), which returns early because HID_SUSPENDED is
already set:

drivers/hid/usbhid/hid-core.c:usbhid_restart_ctrl_queue() {
	if (!hid || test_bit(HID_RESET_PENDING, &usbhid->iofl) ||
			test_bit(HID_SUSPENDED, &usbhid->iofl))
		return 0;
}

hid_hw_wait() then sees HID_CTRL_RUNNING =3D=3D 0 and returns immediately w=
hile
the blanking report remains unsent in usbhid->ctrl[].

If the system subsequently enters s2idle or S3 while the USB device is alre=
ady
runtime-suspended, usb_suspend_both() skips usb_suspend_interface() and the
blanking report is never transmitted to the hardware before system sleep. In
S0, when the device runtime-resumes via hid_resume(), hid_restart_io()
transmits the stale (0, 0, 0, 0) report and hid_generic_resume() calls
lamparray_resume(), cycling AutonomousMode (1 -> 0) and restoring state on
every runtime wakeup.

Should hid_generic_suspend() and hid_generic_resume() skip LampArray
blanking/restoration during runtime PM (or should runtime autosuspend be
prevented while LampArray LEDs are active)?

[ ... ]

> diff --git a/drivers/hid/hid-lamparray.c b/drivers/hid/hid-lamparray.c
> index fb3082f6d19a0..5c97cafbd25d2 100644
> --- a/drivers/hid/hid-lamparray.c
> +++ b/drivers/hid/hid-lamparray.c
> @@ -852,6 +852,60 @@ void lamparray_unregister(struct lamparray *la)
>  }
>  EXPORT_SYMBOL_GPL(lamparray_unregister);
> =20
> +/*
> + * Blank all lamps on suspend rather than handing control back to the fi=
rmware,
> + * which may not turn them off in low power states. On an Acer Predator =
PT14-52T,
> + * system power draw during s2idle was ~12.35W with lamps lit, and ~3.14=
W with
> + * them blanked; the lighting accounted for ~75% of the power draw durin=
g suspend.
> + * Since writing zeroes is well defined on all lamparray devices, always=
 do it.
> + * This is ignored if use_leds_uapi is 0; let userspace keep full contro=
l.
> + */
> +void lamparray_suspend(struct lamparray *la)
> +{
> +	struct lamparray_device *ldev;
> +
> +	if (!la)
> +		return;
> +
> +	ldev =3D &la->ldev;
> +
> +	if (!ldev->use_leds_uapi)
> +		return;
> +
> +	mutex_lock(&ldev->dev_lock);
> +	lamparray_hw_set_state(ldev, 0, 0, 0, 0);
> +	mutex_unlock(&ldev->dev_lock);
> +
> +	hid_hw_wait(ldev->hdev);
> +}
> +EXPORT_SYMBOL_GPL(lamparray_suspend);

[Severity: Medium]
Could pending LED work or software blink timers run after lamparray_suspend=
()
blanks the hardware, un-blanking the lamps and overwriting ldev->last_*?

lamparray_register_led() registers ldev->mc_cdev.led_cdev with
brightness_set_blocking =3D lamparray_led_brightness_set and without
LED_CORE_SUSPENDRESUME. All non-sleeping brightness updates (sysfs writes,
led_timer_function() software blink, and in-kernel LED triggers) go through
led_set_brightness_nosleep() -> led_set_brightness_nopm(), which queues
cdev->set_brightness_work onto leds_wq (a non-freezable workqueue) unless
LED_SUSPENDED is set on cdev->flags.

Because lamparray_suspend() does not set LED_SUSPENDED on
ldev->mc_cdev.led_cdev.flags or call
flush_work(&ldev->mc_cdev.led_cdev.set_brightness_work), a queued
set_brightness_work or a blink/trigger timer firing during dpm_suspend() or
s2idle can run lamparray_led_brightness_set() after lamparray_suspend() dro=
ps
ldev->dev_lock:

drivers/hid/hid-lamparray.c:lamparray_led_brightness_set() {
	...
	guard(mutex)(&ldev->dev_lock);
	...
	if (brightness)
		ret =3D lamparray_hw_set_state(ldev, r, g, b, brightness);
	else
		ret =3D lamparray_hw_set_state(ldev, 0, 0, 0, 0);
	...
	ldev->last_r =3D r;
	ldev->last_g =3D g;
	ldev->last_b =3D b;
	ldev->last_brightness =3D brightness;
}

This sends a new HID_REQ_SET_REPORT during suspend and clobbers the cached
ldev->last_r, ldev->last_g, ldev->last_b, and ldev->last_brightness values.
Similarly, during lamparray_resume(), set_brightness_work can interleave
between lamparray_hw_set_autonomous() and lamparray_restore_state() while
ldev->dev_lock is dropped.

> +
> +void lamparray_resume(struct lamparray *la)
> +{
> +	struct lamparray_device *ldev;
> +
> +	if (!la)
> +		return;
> +
> +	ldev =3D &la->ldev;
> +
> +	if (!ldev->use_leds_uapi)
> +		return;
> +
> +	/*
> +	 * After a S4 transition, some devices report
> +	 * AutonomousMode =3D 0 while still ignoring host lamp updates.
> +	 * Writing 0 again does nothing; forcing a 1 -> 0
> +	 * will guarantee the device will update.
> +	 */
> +	lamparray_hw_set_autonomous(ldev, true);
> +	hid_hw_wait(ldev->hdev);
> +	lamparray_hw_set_autonomous(ldev, false);
> +
> +	lamparray_restore_state(ldev);
> +}
> +EXPORT_SYMBOL_GPL(lamparray_resume);

[Severity: Medium]
Can lamparray_suspend() and lamparray_resume() race with concurrent writes =
to
use_leds_uapi_store()?

In use_leds_uapi_store(), transitions of ldev->use_leds_uapi, LED
registration/unregistration, and AutonomousMode updates are serialized under
ldev->sysfs_lock:

drivers/hid/hid-lamparray.c:use_leds_uapi_store() {
	guard(mutex)(&ldev->sysfs_lock);
	old_val =3D ldev->use_leds_uapi;

	if (val =3D=3D old_val)
		return count;

	ldev->use_leds_uapi =3D val;
	...
}

Neither lamparray_suspend() nor lamparray_resume() acquires ldev->sysfs_loc=
k,
and lamparray_resume() drops ldev->dev_lock between
lamparray_hw_set_autonomous(ldev, true), hid_hw_wait(),
lamparray_hw_set_autonomous(ldev, false), and lamparray_restore_state().

If use_leds_uapi_store() transitions from 1 to 0 while lamparray_resume() is
sleeping in hid_hw_wait() (for example, during USB runtime resume),
use_leds_uapi_store() unregisters the LED and sets AutonomousMode =3D 1, af=
ter
which lamparray_resume() calls lamparray_hw_set_autonomous(ldev, false)
without re-checking use_leds_uapi, leaving AutonomousMode disabled while
use_leds_uapi is 0.

Conversely, during a 0 to 1 transition in use_leds_uapi_store(),
ldev->use_leds_uapi =3D val is written before lamparray_register_led()
completes. If initial LED registration failed during lamparray_register() a=
nd
lamparray_resume() observes ldev->use_leds_uapi =3D=3D true before
lamparray_register_led() finishes initializing ldev->mc_cdev.subled_info,
lamparray_restore_state() can dereference a NULL ldev->mc_cdev.subled_info
pointer.

Should lamparray_suspend() and lamparray_resume() serialize against
use_leds_uapi_store() with ldev->sysfs_lock?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020-hid-lampar=
ray-v7-0-47418b667b47@tuxedocomputers.com?part=3D3
