Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAF333A9DA
	for <linux-input@vger.kernel.org>; Wed, 22 Jul 2026 14:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784730189; cv=none; b=RsGtCYkjvyvHXrVRhpbLNkZcfk5nsoqZJ8HOA6+2CuzkmHNvq3TrJRcOhcGFen8tsF8ipYU54+dxW2TL55ezurvUWl/aT8u0FC+1MPo350d/xju0cObY08L5r1WTm+1cUIgILYaLKPg6zeLv9+GPs7umdIild8NsFTVravYcRBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784730189; c=relaxed/simple;
	bh=QA1GpHiz9+gbtdPzdl6wSbbV2mTMyzUJEpK+Y+mYBAI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hmx4sjEH78hWZjJOxNUYdkkwJXhQu+MV336obn34NOkBLfL7hW+zhV9GhV7hSF7VcU0ussWUDA23FMdlYz5Meau6F7IGSg18PUKEL7o11msfqQf55UnowlOXYwhYz25nuFJvL2TFYu7NT5xEMWWOCzxwq47imcn5yFlNSIw8SKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NVnWlakO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NVnWlakO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB141F000E9;
	Wed, 22 Jul 2026 14:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784730188;
	bh=jMvJnMQc3V3kvxGpZkZdO/SXI8s7b6rG8bA81twp5dY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NVnWlakOb1cAsWXjUQs9Hchd+WtWSaems6t3OeFy5dLELkmdpwp8NLvKYkQmzNYYR
	 GcmW29RMkBgPCh5CXQ4VFig8FjiQX0AKlnWBM2lDgZAhrjsmJSDCrFKvNpSvfl5ls7
	 F0HrAJsKngbRIZA2tS4QG+XPtx5uYrhowU5o1puQMkvA/L4gqn2txupFXp5osxY5G+
	 Of+m91RfojlctKRI/ojHLeN8iq89CZZxCn+0xC6btkmAr/igq9hfjMmZij8o9DuR/b
	 ZLBhmpL10c/FOWqWcB87fX+uKGepbSszIiTNshGBSYfiXRaSFOGVrIrmgLnbmNzRf2
	 NqrSfO6SY27Dg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] HID: appletb-kbd: support layer switching on Fn
 double press
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andre Eikmeyer" <dev@deq.rocks>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260722141221.13844-1-dev@deq.rocks>
References: <20260722141221.13844-1-dev@deq.rocks>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 14:23:06 +0000
Message-Id: <20260722142308.1BB141F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The double-press logic mutates a read-only global module parameter=
 dynamically from a per-device interrupt-driven event handler, causing a da=
ta race and state corruption.
- [Medium] Failure of `appletb_kbd_set_mode()` is ignored in the double-pre=
ss path, causing software tracking state to desynchronize from actual hardw=
are state.

Pre-existing issues:
- [High] Calling `appletb_kbd_set_mode()` from the atomic input event handl=
er causes a sleep in atomic context (BUG: scheduling while atomic).
--

--- Patch [1]: [PATCH v3] HID: appletb-kbd: support layer switching on Fn d=
ouble press ---
commit 3f8289667f750dcd9fc87072f493735127cd7f85
Author: Aditya Garg <gargaditya08@proton.me>

HID: appletb-kbd: support layer switching on Fn double press
   =20
Holding Fn temporarily switches the Touch Bar between media controls and
function keys. An optional double_press_switch_time module parameter makes
a double press persistently switch the default layer.

> diff --git a/drivers/hid/hid-appletb-kbd.c b/drivers/hid/hid-appletb-kbd.c
> index 462010a758993..b7bbb81a8d473 100644
> --- a/drivers/hid/hid-appletb-kbd.c
> +++ b/drivers/hid/hid-appletb-kbd.c

[ ... ]

> @@ -250,15 +269,36 @@ static void appletb_kbd_inp_event(struct input_hand=
le *handle, unsigned int type
> =20
>  	reset_inactivity_timer(kbd);
> =20
> -	if (type =3D=3D EV_KEY && code =3D=3D KEY_FN && appletb_tb_fn_toggle &&
> -		(kbd->current_mode =3D=3D APPLETB_KBD_MODE_SPCL ||
> -		 kbd->current_mode =3D=3D APPLETB_KBD_MODE_FN)) {
> +	if (type =3D=3D EV_KEY && code =3D=3D KEY_FN &&
> +	    (kbd->current_mode =3D=3D APPLETB_KBD_MODE_SPCL ||
> +	     kbd->current_mode =3D=3D APPLETB_KBD_MODE_FN)) {
>  		if (value =3D=3D 1) {
> -			kbd->saved_mode =3D kbd->current_mode;
> -			appletb_kbd_set_mode(kbd, kbd->current_mode =3D=3D APPLETB_KBD_MODE_S=
PCL
> -						? APPLETB_KBD_MODE_FN : APPLETB_KBD_MODE_SPCL);
> +			if (appletb_tb_double_press_switch_time > 0) {
> +				unsigned long now =3D jiffies;
> +
> +				if (time_before(now, kbd->last_fn_press +
> +					msecs_to_jiffies(appletb_tb_double_press_switch_time))) {
> +					appletb_tb_def_mode =3D
> +						appletb_switch_mode(appletb_tb_def_mode);

[Severity: High]
Does this double-press logic mutate a read-only global module parameter
dynamically from a per-device interrupt-driven event handler? Modifying
it changes the initialization default for any subsequently probed devices.

If a user changes the mode via sysfs, a subsequent double-press will blindly
toggle the global variable and overwrite the user's per-device sysfs
configuration.

> +
> +					appletb_kbd_set_mode(kbd, appletb_tb_def_mode);

[Severity: High]
This is a pre-existing issue, but does calling appletb_kbd_set_mode() from
the atomic input event handler cause a sleep in atomic context?

The input core invokes appletb_kbd_inp_event() from input_pass_values()
which holds dev->event_lock (spinlock) and disables local interrupts.

The callback then calls appletb_kbd_set_mode(), which calls
hid_hw_power(hdev, PM_HINT_FULLON). For USB HID devices, this maps to
usbhid_power(), which calls usb_autopm_get_interface(), subsequently
calling pm_runtime_get_sync() which sleeps.

[Severity: Medium]
Is the return value of appletb_kbd_set_mode() ignored here? If the hardware
mode switch fails, the software tracking variables are updated anyway,
causing the software to assume the mode switched successfully.

> +
> +					kbd->saved_mode =3D appletb_tb_def_mode;
> +					kbd->last_fn_press =3D 0;
> +
> +					return;
> +				}
> +
> +				kbd->last_fn_press =3D now;
> +			}
> +			if (appletb_tb_fn_toggle) {
> +				kbd->saved_mode =3D kbd->current_mode;
> +
> +				appletb_kbd_set_mode(kbd, appletb_switch_mode(kbd->current_mode));
> +			}
>  		} else if (value =3D=3D 0) {
> -			if (kbd->saved_mode !=3D kbd->current_mode)
> +			if (appletb_tb_fn_toggle &&
> +			    kbd->saved_mode !=3D kbd->current_mode)
>  				appletb_kbd_set_mode(kbd, kbd->saved_mode);
>  		}
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722141221.1384=
4-1-dev@deq.rocks?part=3D1
