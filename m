Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FC24519AF
	for <linux-input@vger.kernel.org>; Fri, 11 Sep 2026 20:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789157500; cv=none; b=Ng8LPZ24YVoo1FbJ3ZqMebCjBSzaUyI9VJ2M97y30AaOxRBDSmUNY9ZwlfL+nxVpVJtNQqroNjbIMB92KtySMqkAAFpOcRoxC44scbLfQNw0BDxi/lEQOGB1pkUBpJunLzjYxls46m1n0Vlj0G7kU72csSQb7ZITXfy3UmRg3Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789157500; c=relaxed/simple;
	bh=zTMCMdmWbQWVHz13zIZWqqrgx5+jJNwqqh8noRntdKc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SRsI+o1PdkBZDIKhwbnrSiHn1JQap1CFi7RubSFEk/0V6T0kukSzbSfvod5dKpuA7wftPdqdesTTNbIeyG1eMoXtq4GEQeTBVLDJSaQJ2oBDhE9lHastJONTJvlXRDoAzalDN91m5Vp9yogORckMQMJ4NINLs4oNmCoyHJWrYxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WS/IDAdF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WS/IDAdF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E9DB1F000FF;
	Fri, 11 Sep 2026 20:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789157499;
	bh=vQ/BI7qNvbmdGeETyk18s6L8jjBnKyoVCKIqGMGDJ5I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WS/IDAdFzGUf8c7Irh3MnVIWTlxibQlTVYOI3pf4RbznY1bNZTNr9wb+1YFMy8mYY
	 slMclTgOPe7hzrnempJJnPn9g8zB9GgjE2yHHWWS33atz2oc6REm8wks4HipzfSiNp
	 xxbyVee9eMJsyw0xIAKf11vVBjiKFTiesx+wqB/kRr47UOHkcpjODgd6UCO6/7j8H3
	 CYil4PX08RPulhnytjtxp2fRkySg5Gj91CDGuEvCeaaZb7rA2/kHtop9+r3ug5DttD
	 GaD+FMpHppovjEZJ1+PRqdCH4cYMXQHbijnSUxs2CYNIgq7tq24qHjA6FG1FsijN9y
	 PcW8/EeVbZMkg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] HID: appletb-kbd: support layer switching on Fn
 double press
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aditya Garg" <aditya.garg@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260911200019.17028-1-aditya.garg@linux.dev>
References: <20260911200019.17028-1-aditya.garg@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 20:11:38 +0000
Message-Id: <20260911201139.2E9DB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Double-press detection falsely triggers on every single press duri=
ng the first ~5 minutes of system uptime due to jiffies wrap and zero initi=
alization.
- [Medium] Runtime mutation of a global, read-only module parameter from wi=
thin a device-specific event handler without synchronization.

Pre-existing issues:
- [High] The input event handler calls a function that can sleep (`hid_hw_p=
ower`), violating the atomic context requirements of the input subsystem.
--

commit 8744bab7e31d541dd6e18fb45fd65fb8da3adc97
Author: Aditya Garg <aditya.garg@linux.dev>

HID: appletb-kbd: support layer switching on Fn double press

This commit adds an optional module parameter double_press_switch_time
to switch the default touch bar layer persistently upon a double-press
of the Fn key. It introduces new logic in the input event handler to
detect double presses.

> diff --git a/drivers/hid/hid-appletb-kbd.c b/drivers/hid/hid-appletb-kbd.c
> index 5cc27066f6026..02b938daeb2b3 100644
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

[Severity: High]
Does this time_before check falsely trigger on every single press during the
first ~5 minutes of system uptime?

On Linux, jiffies is initialized to a large negative number (e.g., -300 * H=
Z)
to catch wrapping bugs early. Because kbd->last_fn_press is 0 initially,
the check mathematically evaluates as:

(long)now - (long)timeout < 0

Since now is negative and timeout is positive, this evaluates to true on the
very first press, causing the double-press feature logic to completely fail
and convert single presses into double-press actions.

> +					appletb_tb_def_mode =3D
> +						appletb_switch_mode(appletb_tb_def_mode);

[Severity: Medium]
Does mutating the global read-only module parameter appletb_tb_def_mode
inside a device-specific event handler break per-device isolation?

Since this parameter is defined with 0444 permissions and intended to
configure default initialization, changing it dynamically bleeds the runtime
state of one device instance into the global configuration, applying it to
any future device probes or suspend/resume cycles.

> +
> +					appletb_kbd_set_mode(kbd, appletb_tb_def_mode);

[Severity: High]
This is a pre-existing issue, but does calling appletb_kbd_set_mode() from
the atomic input event callback cause a kernel panic?

The input core invokes event callbacks with the device's event_lock spinlock
held and interrupts disabled. Inside appletb_kbd_set_mode():

appletb_kbd_set_mode()
    hid_hw_power(..., PM_HINT_FULLON)
        usb_autopm_get_interface()
            pm_runtime_get_sync()

This translates into synchronous PM runtime resume calls which will sleep,
leading to a scheduling-while-atomic oops. Although this existed prior to
this patch for the fn_toggle feature, this patch adds new execution paths
that trigger the identical crash.

> +
> +					kbd->saved_mode =3D appletb_tb_def_mode;
> +					kbd->last_fn_press =3D 0;

[Severity: High]
Does resetting the tracker to 0 instead of a valid timestamp re-arm
the jiffies wrapping bug indefinitely?

Setting this back to 0 guarantees that subsequent single presses will
also falsely trigger as double-presses until jiffies eventually wraps
to a positive value.

> +
> +					return;
> +				}
> +
> +				kbd->last_fn_press =3D now;
> +			}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911200019.1702=
8-1-aditya.garg@linux.dev?part=3D1
