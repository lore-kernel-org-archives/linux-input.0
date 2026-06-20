Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E812DC32C
	for <linux-input@vger.kernel.org>; Sat, 20 Jun 2026 11:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781955633; cv=none; b=ButHW7h3dpg10XBrFHAvwd5AAd1DwjTeT8hI8xdfEhQxKYM9spf4MbG6wprAZy+ZAEmIUK5AydmmQU1wo/R/qOLI8MZV1dSK7ZowYoGA+LCCDtl65lpO/zqa0rNhN9YiFqXq0nJ8aW3OLxNGE+Hz8VSxHRZmJKveCsAysIjgVjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781955633; c=relaxed/simple;
	bh=HxLhnvc97lsFYSvPkObvqg5FDcfii45Uk7F0H3yUUfY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dSO7Owyj3eoTi8gtlaYB9NucRgB13vqOO03sQo5s+qPeSyJBzQ8WYAwZq8Pr8BYLPoIq6ZruO1g+55eG0AUEYCYnnxi+1Bh8RZ5F37rR2jRsuqG5NRawe7U2dfXgWOmeQLgYN9vGHZcVmGlAu2HPXCxvtntyTUHFd2cg0qadROQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7n4GL69; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7n4GL69"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D7F51F000E9;
	Sat, 20 Jun 2026 11:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781955632;
	bh=WyYD4DmIoSB8HwaJ2ZeuKjyhRj88y8AL8kdQCALfqUs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V7n4GL690aqCzTO7m1bM7/WMlbzYb2twSaeLgvY5mTUy1blANiqyQSQ9VfnqtGdYJ
	 qEWn42WQNN2fHmm6XmLZHmPb09ZcF+dd7KZQtjVj8JROa29HyurORmPvU+KDvLlDYA
	 WOLu5FUbBoybqVI4RDzT081MgD61PJ8101UTUdfFpMX9wfODyJxlRrVinvJDHfBr9v
	 zpRhOQo8FGCYFYyo/i/6Y3Dx0fEutQkakaO1JVXBK+ssdi6I7YKXruuT0yHgJCIr5y
	 HV7bU3pNe3X0vRIqKoxMg6vdgcZHAfsaAJwSk0yOZYRO0xzfSMhxECzQYgARth3Vsf
	 Gxfu5q6EAAuMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 RESEND] HID: appletb-kbd: add option to switch
 default layer on double pressing fn key
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aditya Garg" <gargaditya08@proton.me>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260620112635.17246-1-gargaditya08@proton.me>
References: <20260620112635.17246-1-gargaditya08@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 11:40:30 +0000
Message-Id: <20260620114031.4D7F51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Medium] The driver dynamically mutates a read-only global module paramet=
er without synchronization.
- [Medium] Zero-initialization of `kbd->last_fn_press` paired with jiffies =
wrap logic causes spurious double-press detections during the first 5 minut=
es of system uptime.

Pre-existing issues:
- [High] Calling sleeping functions (`hid_hw_power`, `pm_runtime_get_sync`)=
 from the atomic input event handler causes 'BUG: scheduling while atomic'.
- [High] Probe enables hardware events before setting driver data, causing =
a NULL pointer dereference.
--

commit e33a32d065a3f43246ae8063aed73e4573a2176b
Author: Aditya Garg <gargaditya08@proton.me>

HID: appletb-kbd: add option to switch default layer on double pressing fn =
key

This patch enables a user to switch the default layer from media to fn
keys and vice-versa upon double pressing the fn key. This behaviour can
be configured using the double_press_switch_time module parameter whose
value depicts the time in milliseconds within which the fn key must be
pressed again to switch the default layer. If set to 0, it simply
disables this behaviour.

> diff --git a/drivers/hid/hid-appletb-kbd.c b/drivers/hid/hid-appletb-kbd.c
> index 462010a758993..34bfc595949dc 100644
> --- a/drivers/hid/hid-appletb-kbd.c
> +++ b/drivers/hid/hid-appletb-kbd.c

[ ... ]

> @@ -250,15 +269,42 @@ static void appletb_kbd_inp_event(struct input_hand=
le *handle, unsigned int type
>  			      unsigned int code, int value)
>  {
>  	struct appletb_kbd *kbd =3D handle->private;
> =20
>  	reset_inactivity_timer(kbd);
> =20
> -	if (type =3D=3D EV_KEY && code =3D=3D KEY_FN && appletb_tb_fn_toggle &&
> -		(kbd->current_mode =3D=3D APPLETB_KBD_MODE_SPCL ||
> -		 kbd->current_mode =3D=3D APPLETB_KBD_MODE_FN)) {
> +	if (type =3D=3D EV_KEY && code =3D=3D KEY_FN &&
> +	    (kbd->current_mode =3D=3D APPLETB_KBD_MODE_SPCL ||
> +	     kbd->current_mode =3D=3D APPLETB_KBD_MODE_FN)) {
> +
>  		if (value =3D=3D 1) {
> -			kbd->saved_mode =3D kbd->current_mode;
> -			appletb_kbd_set_mode(kbd, kbd->current_mode =3D=3D APPLETB_KBD_MODE_S=
PCL
> -						? APPLETB_KBD_MODE_FN : APPLETB_KBD_MODE_SPCL);
> +			if (appletb_tb_double_press_switch_layers > 0) {
> +				unsigned long now =3D jiffies;
> +
> +				if (time_before(now, kbd->last_fn_press +
> +					msecs_to_jiffies(appletb_tb_double_press_switch_layers))) {

[Severity: Medium]
Since the system jiffies timer initializes to a negative value at boot, does
evaluating time_before() with a zero-initialized kbd->last_fn_press cause
spurious double-press detections during the first 5 minutes of system uptim=
e?

> +
> +					appletb_tb_def_mode =3D
> +						appletb_switch_mode(
> +							appletb_tb_def_mode);

[Severity: Medium]
Since appletb_tb_def_mode is a global module parameter with read-only
permissions, does dynamically reassigning it here violate its read-only
contract and globally modify the default layer for all device instances
instead of applying the state locally to the specific kbd instance?

> +
> +					appletb_kbd_set_mode(kbd,
> +						appletb_tb_def_mode);

[Severity: High]
This isn't a bug introduced by this patch, but does appletb_kbd_set_mode()
unconditionally call hid_hw_power(), which can sleep via pm_runtime_get_syn=
c()?

Since the input core invokes appletb_kbd_inp_event() from atomic context wi=
th
the dev->event_lock spinlock held and local IRQs disabled, can this trigger=
 a
scheduling while atomic bug?

> +
> +					kbd->saved_mode =3D appletb_tb_def_mode;
> +					kbd->last_fn_press =3D 0;

[Severity: Medium]
Does explicitly resetting last_fn_press back to 0 here cause the spurious
evaluations to continue for subsequent presses within the first 5 minutes of
uptime?

> +
> +					return;
> +				}
> +
> +				kbd->last_fn_press =3D now;
> +			}
> +			if (appletb_tb_fn_toggle) {
> +				kbd->saved_mode =3D kbd->current_mode;
> +
> +				appletb_kbd_set_mode(kbd,
> +					appletb_switch_mode(kbd->current_mode));
> +			}
> +
>  		} else if (value =3D=3D 0) {
> -			if (kbd->saved_mode !=3D kbd->current_mode)
> +			if (appletb_tb_fn_toggle &&
> +			    kbd->saved_mode !=3D kbd->current_mode)
>  				appletb_kbd_set_mode(kbd, kbd->saved_mode);
>  		}
>  	}

[Severity: High]
This is a pre-existing issue, but does appletb_kbd_probe() enable hardware
events before setting the driver data?

drivers/hid/hid-appletb-kbd.c:appletb_kbd_probe() {
    ...
    ret =3D hid_hw_start(hdev, HID_CONNECT_HIDINPUT);
    ...
    hid_set_drvdata(hdev, kbd);
    ...
}

Once the hardware is opened, it can immediately begin delivering HID reports
which invoke appletb_kbd_hid_event(). Could appletb_kbd_hid_event() fetch an
uninitialized NULL pointer from hid_get_drvdata(hdev) and pass it to
reset_inactivity_timer(), causing a NULL pointer dereference?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620112635.1724=
6-1-gargaditya08@proton.me?part=3D1
