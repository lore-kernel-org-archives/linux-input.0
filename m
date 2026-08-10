Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8373C5550
	for <linux-input@vger.kernel.org>; Mon, 10 Aug 2026 14:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786373007; cv=none; b=Xh7TPq0hSZZLqeGYNTjZ9CEqWCHIOSGP+aBwQnrTbI/EraP8kEiAXjpUtZIz2t/28M3PyE5dCdFCRNKH3bRWhTQZAR+nIHNA2YYOLwEM7EEuszRP6in8pmL5CE2xYZE9zC5emu01Ts5jGxuqyXHqURTZGElvtAEP+pOdhdj3OC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786373007; c=relaxed/simple;
	bh=eVmRAa2u/3OYZo9Ptj3XsfRXsy1Qf9c7eiwla2m3glM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=onPoN2PS4pF/rxXIjLBXfVl49Py9CYgYp59hOHmQ7MNPTr87AC3EM3WPSnInpt83i0BMFWAWaDCgavsOhTDqjzGDZfVMwW8ah9m2iKx4TqAQPzM9JkMJfKWS++bLWEwGSh3kR1/iuAf2VYpYNADYy2i5pJ89Is1vn2+uW+y8tns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=guxeB60Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="guxeB60Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58EF01F000E9;
	Mon, 10 Aug 2026 14:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786373005;
	bh=EBOglAItEO8YvkyMVCJCnLoepqwegCN9FTHmChj3i1c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=guxeB60Z8nHrFiQacvQbWRrPSeWLuGa+ow5tYA4vvhIAZAuAc4sGktL2Ces/DnUS2
	 BtRJW/rRF8cL4qgQfvCM6U1OstBbK5oaOgpDEeiMTghev/Jm0jMHVWonwsBjSbI+nz
	 Jzv+F1Xi7K7fs8MqFmfn41aSflHGNizyhjdNon7gUBXjpJaILCxxoK+DtmIVrEryWa
	 kqZxoPykzabtOmsIbIxRRi5tmL9xLaqj2tuS/9gtuqI+w7bsDEnnu4vfkiWuM+vobN
	 9xjbM/CQ9KhEYBrDS8F5ifFCuPceJ08LeiODfON6BZEJS37X3Qnb7PxwE2Wr4RXlp0
	 NJKRDaCnN55Sg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: apple-touchbar: avoid nested runtime PM in PM
 callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andre Eikmeyer" <dev@deq.rocks>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260810140352.35866-1-dev@deq.rocks>
References: <20260810140352.35866-1-dev@deq.rocks>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 14:43:24 +0000
Message-Id: <20260810144325.58EF01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] Touch Bar display OFF command is queued but not sent during runt=
ime suspend.
- [Medium] The PM callbacks `suspend` and `resume` directly propagate error=
 codes from `hid_set_field`, which can unexpectedly abort system suspend tr=
ansitions.

Pre-existing issues:
- [High] The input event handler `appletb_kbd_inp_event` triggers a sleep w=
hile holding a spinlock with IRQs disabled, leading to a kernel panic.
--

--- Patch [1]: [PATCH] HID: apple-touchbar: avoid nested runtime PM in PM c=
allbacks ---
commit d7e9b031fc57c77cbf461d6ee7d2a03d269e31be
Author: Andre Eikmeyer <dev@deq.rocks>

HID: apple-touchbar: avoid nested runtime PM in PM callbacks

This patch splits the mode update into an active-device helper and a
runtime-PM-managed wrapper to avoid nested runtime PM resume requests during
USB PM transitions. Both PM callbacks now call the active-device helper
directly without acquiring a nested runtime PM reference.

> diff --git a/drivers/hid/hid-appletb-kbd.c b/drivers/hid/hid-appletb-kbd.c
> index 462010a758993..cbaf7587feea4 100644
> --- a/drivers/hid/hid-appletb-kbd.c
> +++ b/drivers/hid/hid-appletb-kbd.c
> @@ -87,29 +87,37 @@ static const struct key_entry appletb_kbd_keymap[] =
=3D {

[ ... ]

> +static int appletb_kbd_set_mode(struct appletb_kbd *kbd, u8 mode)
> +{
> +	struct hid_device *hdev =3D kbd->mode_field->report->device;
> +	int ret;
> +
> +	ret =3D hid_hw_power(hdev, PM_HINT_FULLON);

[Severity: High]
This isn't a bug introduced by this patch, but does this function sleep in
atomic context?

The input subsystem calls the input handler event callback,
appletb_kbd_inp_event(), from input_pass_values() while holding the
dev->event_lock spinlock with local IRQs disabled.

When this handler receives a KEY_FN event, it calls appletb_kbd_set_mode(),
which invokes hid_hw_power() here. For USB HID devices, this translates to
usb_autopm_get_interface(), which invokes pm_runtime_get_sync().

If the device is currently suspended, pm_runtime_get_sync() will sleep to
synchronously resume it.

Can this cause a scheduling while atomic bug when the spinlock is held?

> +	if (ret) {
> +		hid_err(hdev, "Device didn't resume (%pe)\n", ERR_PTR(ret));
> +		return ret;
> +	}
> +
> +	ret =3D appletb_kbd_set_mode_active(kbd, mode);
> =20
> -power_normal:
>  	hid_hw_power(hdev, PM_HINT_NORMAL);
> =20
>  	return ret;
>  }

[ ... ]

> @@ -487,18 +495,19 @@ static int appletb_kbd_suspend(struct hid_device *h=
dev, pm_message_t msg)
>  	struct appletb_kbd *kbd =3D hid_get_drvdata(hdev);
> =20
>  	kbd->saved_mode =3D kbd->current_mode;
> -	appletb_kbd_set_mode(kbd, APPLETB_KBD_MODE_OFF);
> =20
> -	return 0;
> +	/* This callback already runs as part of a USB PM transition. Taking a
> +	 * nested runtime-PM reference would wait for that transition to comple=
te
> +	 * and deadlock the USB PM state machine.
> +	 */
> +	return appletb_kbd_set_mode_active(kbd, APPLETB_KBD_MODE_OFF);

[Severity: Medium]
Does this result in the display OFF command being deferred until resume?

When the device undergoes runtime suspend, usbhid's hid_suspend executes.
For runtime PM transitions, usbhid sets the HID_SUSPENDED flag before
invoking the driver's suspend callback.

When appletb_kbd_suspend() subsequently calls hid_hw_request() via the
active-device helper, usbhid detects the HID_SUSPENDED flag and enqueues
the URB without submitting it.

Will this prevent the OFF command from being sent before sleep, and cause
spurious state flapping when the device wakes up?

[Severity: Medium]
Will returning this result directly abort a system suspend?

If hid_set_field() fails due to a malformed HID descriptor, it returns -1
which evaluates to -EPERM.

Because this callback now propagates that error code directly, could a
failure to update this cosmetic feature unexpectedly abort the entire
system-wide suspend operation?

>  }
> =20
>  static int appletb_kbd_resume(struct hid_device *hdev)
>  {
>  	struct appletb_kbd *kbd =3D hid_get_drvdata(hdev);
> =20
> -	appletb_kbd_set_mode(kbd, kbd->saved_mode);
> -
> -	return 0;
> +	return appletb_kbd_set_mode_active(kbd, kbd->saved_mode);

[Severity: Medium]
Similar to the suspend path, could propagating the error code from
appletb_kbd_set_mode_active() cause issues during system resume?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810140352.3586=
6-1-dev@deq.rocks?part=3D1
