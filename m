Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9043D3D79FE
	for <linux-input@vger.kernel.org>; Tue, 26 May 2026 16:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779814317; cv=none; b=agjQ9kluZu84JM+tDtFT6e+uuuwcySpJV23atTTYJo9YP9xAWFXmWUg4Y3pcpPdWcUKVcpVuT/2d2y0nIt7j1/lMNFdZHS1+rKakPI2WEjxL2lTxwtj+JAZ7laTpW+VScbgJdeI3vLDL3zgsvjfAcMDNhAZ2iyla8eCJ143oeYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779814317; c=relaxed/simple;
	bh=NlUJ3y3+1PP7yiPqdqDMbiVhcMtFKvTBo2Qt887B0gY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fAkO1wyisbCWjJkJvTKlN8EKFOEI0h5qEChvcy3lpKQ4PNj0Rj60F749ZNMBfoyy/qws2ZHSaMWQE5h9DRhc6IPwApnuuZvYaCth2FyLiACzmmp58x6ILA54wSsY0euPSPwyGTmk3fMIYlMKdSSX+opBwM7dJDZ6J7cvay41l3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5SQo+8Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5SQo+8Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12BEE1F000E9;
	Tue, 26 May 2026 16:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779814316;
	bh=zvZnOT/PZb2Dw4Tcz9xb+RZwftxn12CEDqWxwpHlIvk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z5SQo+8Y2pMIOIOsh+hw91YsgJHQOQiAtTyDxTsP7v10evrfZH1/a+JmHWPK3LoSU
	 EYXJzJ4/NrDla+ZKIx48yFbIMgEmhLKssguRxsYvfnD+0ldnvCMbFVOFHl9lkruc2X
	 xu3gHg2bNFwhZVGh9qDC5kfncbT0BJW670xSjOfoqKwLDBV15P8t2CB/yfBSsEiNCz
	 QIiPI5Y3+Bfk888cCQU1L2dQ/3wAk1lxZ7KgQCe+5Yb2TMLNDbJ/ZUT/og/b+kCvCU
	 BmWg7ELEssiXS1WOIEQB9Rm0ZCck2eNL950uKWfikhf/4GcjK4ppTe4dbaQoNgnLKp
	 tSv+Fdo3zsO3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] HID: appletb-kbd: add option to switch default layer
 on double pressing fn key
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aditya Garg" <gargaditya08@proton.me>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260526154954.29002-1-gargaditya08@proton.me>
References: <20260526154954.29002-1-gargaditya08@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 16:51:55 +0000
Message-Id: <20260526165156.12BEE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [Medium] Dynamic mutation of a read-only global module parameter from a p=
er-device atomic event handler without synchronization.
- [Medium] Incorrect double-press detection during early system uptime on 3=
2-bit systems due to jiffies wrap-around with a 0-initialized timestamp.
- [Low] Intervening non-Fn key presses do not reset the double-press detect=
ion timer.

Pre-existing issues:
- [High] Calling sleeping functions (`hid_hw_power` and `hid_hw_request`) f=
rom an atomic context causes a kernel panic.
- [High] A race condition during `probe()` allows incoming HID events to tr=
igger a NULL pointer dereference.
--

commit 9461d5707b93702971195b71e23ddea06392c720
Author: Aditya Garg <gargaditya08@proton.me>

HID: appletb-kbd: add option to switch default layer on double pressing fn =
key

This patch enables a user to switch the default layer from media to fn
keys and vice-versa upon double pressing the fn key. This behaviour can
be configured using the double_press_switch_time module parameter.

> diff --git a/drivers/hid/hid-appletb-kbd.c b/drivers/hid/hid-appletb-kbd.c
> index 462010a758993..34bfc595949dc 100644
> --- a/drivers/hid/hid-appletb-kbd.c
> +++ b/drivers/hid/hid-appletb-kbd.c

[ ... ]

> @@ -243,6 +250,18 @@ static int appletb_kbd_hid_event(struct hid_device *=
hdev, struct hid_field *fiel
>  	return kbd->current_mode =3D=3D APPLETB_KBD_MODE_OFF;
>  }
> =20

[Severity: High]
This is a pre-existing issue, but does a race condition during probe() allow
incoming HID events to trigger a NULL pointer dereference?

If hid_hw_start() and hid_hw_open() are called before hid_set_drvdata() is
executed, an incoming keyboard event might invoke appletb_kbd_hid_event()
before probe() finishes. This would call hid_get_drvdata(hdev) returning
NULL, which is then passed to reset_inactivity_timer() and unconditionally
dereferenced.

> +static u8 appletb_switch_mode(u8 mode)
> +{

[ ... ]

> @@ -250,15 +269,42 @@ static void appletb_kbd_inp_event(struct input_hand=
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
> +

[Severity: Low]
Is it possible that intervening non-Fn key presses should reset the
double-press detection timer?

If a user presses Fn, types another key, and then presses Fn again within
the delay timeout, the driver might erroneously interpret this as a
double-press and switch the layer.

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
Could this double-press detection trigger incorrectly during early system
uptime on 32-bit systems?

Since last_fn_press is zero-initialized and jiffies starts at a large
negative value, time_before() might evaluate to true for the first 5
minutes of uptime.

This would cause any single press of the Fn key to erroneously trigger a
double-press layer switch.

> +
> +					appletb_tb_def_mode =3D
> +						appletb_switch_mode(
> +							appletb_tb_def_mode);

[Severity: Medium]
Is it safe to dynamically mutate the appletb_tb_def_mode module parameter
from a per-device atomic event handler without synchronization?

Since appletb_tb_def_mode is a global variable exported as read-only,
modifying it dynamically could violate its sysfs contract and introduce a
data race if multiple keyboards are used concurrently.

This would also improperly alter the default mode for all current and future
connected devices.

> +
> +					appletb_kbd_set_mode(kbd,
> +						appletb_tb_def_mode);

[Severity: High]
This is a pre-existing issue, but does calling appletb_kbd_set_mode() from
this atomic context cause a kernel panic?

The appletb_kbd_inp_event handler is invoked by the input subsystem with
the dev->event_lock spinlock held and interrupts disabled.

appletb_kbd_set_mode() calls hid_hw_power() and hid_hw_request(). For USB
HID devices, hid_hw_power() may sleep and will warn in atomic context,
potentially leading to a scheduling while atomic panic.

> +
> +					kbd->saved_mode =3D appletb_tb_def_mode;
> +					kbd->last_fn_press =3D 0;
> +
> +					return;
> +				}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526154954.2900=
2-1-gargaditya08@proton.me?part=3D1
