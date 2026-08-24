Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521FA3E92B9
	for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 13:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787577887; cv=none; b=CC6n3+ZmBWw9r8krxJQnOrFTq5ygounI/3Gcq2qfSLtoj7MRj+mPSFtRN38gEAlwlJ0UojS2pgOiT4CEmpQoUKBWFwhP1l9lZ5nZtHhIo86koaoTmjX/W+r8C7JoieZPMYo87NzyK4d7c83eSOXCsyqFEM+GQ0xkEK7gWimdA/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787577887; c=relaxed/simple;
	bh=B5cdVWeirGJTJmqL+GaxsY8diFV4Pvt6hh03Aq7LL0s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DpADfh+Z2AF7oeBG11ki23rOKFdQfAddxzfZ1nF5CiPvUIhGj5CU1JXV5e/t+0SpU+lq14IAyco1bOiyQf+6Q5Bq4RFv2yHCSDMdxJEXVPkpH+FochEopa4NlT0hhTySCq9jQkK6cwUiMx0kh+2TLyWcgzNiQX3LIajjHoJ5H8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1TA8njg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1TA8njg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C64EE1F000E9;
	Mon, 24 Aug 2026 13:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787577886;
	bh=nv35fu8aHEMbjqX+wt/a9r00r/+CcyB4zXOawxAKKno=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A1TA8njgKSyR8u3JaC2ZrHUup5ahuGQS18z/zaOB2LQ7Hz8v1dWtCtslN6xvEXnfI
	 bRFnnaCjPoXA5jL+i3CjM3aEKURAOCls07RIo+QZAIqLvJRI9pC8VqAy9i4qUVzeBu
	 1mkXVsTrCzA4nu0WtOgFMmOWcLvgejrgeyCBpT/zN0SNDnF2FIP29tRRv3AdrG8bVG
	 3t5CDEOFlCBlBbHP4pJ8QkZwR8NNlF/93UYM/xqDo+kmtaFo3wGxH+UxtYxGf6BrV5
	 +6JTahCpLDHtEQFfIoYvSLcxTOiieI/xDbTOIVAP19jDJnwr+oxf136fXZnY+4OByb
	 rZw8NOJp3MUZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: logitech-hidpp: add native touchpad support for
 K400 Plus
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitriy Geels" <dmitriy.geels@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260824130901.84600-1-dmitriy.geels@gmail.com>
References: <20260824130901.84600-1-dmitriy.geels@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 13:24:45 +0000
Message-Id: <20260824132445.C64EE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Early assignment of wd->input creates a Time-of-Check to Time-of-U=
se (TOCTOU) race condition with the interrupt handler, leading to a NULL po=
inter dereference.
- [Medium] Repeated connection failures in the hidpp_connect_event workqueu=
e lead to a devres memory leak due to missing input_free_device() on error =
paths.
- [Medium] The K400 Plus touchpad device incorrectly advertises INPUT_PROP_=
BUTTONPAD and emits conflicting BTN_LEFT events.

Pre-existing issues:
- [High] The return value of input_mt_init_slots is ignored, potentially re=
gistering a broken MT device.
- [High] Missing cancel_work_sync for reset_hi_res_work in the probe error =
path leads to a Use-After-Free.
--

--- Patch [1]: [PATCH] HID: logitech-hidpp: add native touchpad support for=
 K400 Plus ---
commit f41a7d9a8fed9a9f7dba87c18d14bd22f84ca93d
Author: Dmitriy Geels <dmitriy.geels@gmail.com>

HID: logitech-hidpp: add native touchpad support for K400 Plus

This patch adds native raw touchpad support for the Logitech K400 Plus by
creating a separate multitouch input device. It ensures physical button
reports remain on the existing HID input device and disables ABS_MT_PRESSURE
when contact area is zero to prevent hover interpretation.

> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-=
hidpp.c
> index 1504de32b1c84..3cb239d818882 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c

[ ... ]

> @@ -2953,6 +2956,8 @@ static void wtp_populate_input(struct hidpp_device =
*hidpp,
>  {
>  	struct wtp_data *wd =3D hidpp->private_data;
> =20
> +	wd->input =3D input_dev;
> +

[Severity: High]
Could this early assignment create a race condition? If an interrupt arrives
here, wtp_raw_event() will see wd->input as non-NULL. If
input_register_device() subsequently fails in hidpp_connect_event(), it
sets wd->input to NULL. If wtp_raw_event() uses the pointer exactly when it
is cleared, could this cause a NULL pointer dereference in input_event()?

>  	__set_bit(EV_ABS, input_dev->evbit);
>  	__set_bit(EV_KEY, input_dev->evbit);
>  	__clear_bit(EV_REL, input_dev->evbit);

[ ... ]

> @@ -2963,8 +2968,13 @@ static void wtp_populate_input(struct hidpp_device=
 *hidpp,
>  	input_set_abs_params(input_dev, ABS_MT_POSITION_Y, 0, wd->y_size, 0, 0);
>  	input_abs_set_res(input_dev, ABS_MT_POSITION_Y, wd->resolution);
> =20
> -	/* Max pressure is not given by the devices, pick one */
> -	input_set_abs_params(input_dev, ABS_MT_PRESSURE, 0, 50, 0, 0);
> +	/*
> +	 * The driver exposes contact area as pressure.  Do not advertise a
> +	 * pressure axis when the device does not report contact area; userspace
> +	 * may otherwise interpret a permanently-zero pressure value as hover.
> +	 */
> +	if (wd->area_range)
> +		input_set_abs_params(input_dev, ABS_MT_PRESSURE, 0, 50, 0, 0);
> =20
>  	input_set_capability(input_dev, EV_KEY, BTN_LEFT);

[Severity: Medium]
Further down in this function, devices without HIDPP_QUIRK_WTP_PHYSICAL_BUT=
TONS
are assigned INPUT_PROP_BUTTONPAD. Since the K400 Plus uses
HIDPP_QUIRK_CLASS_KBD_WTP without that quirk, does this cause userspace to
misconfigure the device, given that the K400 Plus actually has discrete
physical buttons?

[Severity: High]
This is a pre-existing issue, but the return value of input_mt_init_slots()
called slightly below here is ignored. If memory allocation fails, dev->mt
remains NULL, which will cause the core to silently drop all subsequent
multitouch events.

[ ... ]

> @@ -3013,11 +3026,11 @@ static void wtp_send_raw_xy_event(struct hidpp_de=
vice *hidpp,
> =20
>  	if (raw->end_of_frame &&
>  	    !(hidpp->quirks & HIDPP_QUIRK_WTP_PHYSICAL_BUTTONS))
> -		input_event(hidpp->input, EV_KEY, BTN_LEFT, raw->button);
> +		input_event(wd->input, EV_KEY, BTN_LEFT, raw->button);

[Severity: Medium]
Could this emit conflicting BTN_LEFT events? For the K400 Plus, the
physical buttons are routed through the other interface, so raw->button
is typically 0. This might spam release events at the end of every frame
and conflict with the physical hardware buttons.

[ ... ]

> @@ -4524,7 +4549,45 @@ static void hidpp_connect_event(struct work_struct=
 *work)
>  		return;
>  	}
> =20
> -	if (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP) {
> +	if (hidpp->quirks & HIDPP_QUIRK_CLASS_KBD_WTP) {
> +		struct wtp_data *wd =3D hidpp->private_data;

[ ... ]

> +			ret =3D input_register_device(input);
> +			if (ret) {
> +				hid_err(hdev,
> +					"cannot register touchpad input device: %d\n",
> +					ret);
> +				wd->input =3D NULL;
> +				return;
> +			}

[Severity: Medium]
If input_register_device() fails, could this leak the devres allocations for
both the input device and devm_name? Since hidpp_connect_event() is a
workqueue that can run multiple times on reconnection, these allocations
might permanently accumulate without a call to input_free_device().

[ ... ]

> @@ -4755,7 +4818,8 @@ static int hidpp_probe(struct hid_device *hdev, con=
st struct hid_device_id *id)
>  	    hidpp_application_equals(hdev, HID_GD_KEYBOARD))
>  		hidpp->quirks |=3D HIDPP_QUIRK_HIDPP_CONSUMER_VENDOR_KEYS;
> =20
> -	if (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP) {
> +	if (hidpp->quirks &
> +	    (HIDPP_QUIRK_CLASS_WTP | HIDPP_QUIRK_CLASS_KBD_WTP)) {
>  		ret =3D wtp_allocate(hdev, id);
>  		if (ret)
>  			return ret;

[Severity: High]
This is a pre-existing issue, but earlier in hidpp_probe(),
hidpp->reset_hi_res_work is initialized. In the hid_hw_start_fail error path
(which executes after wtp_allocate), cancel_work_sync(&hidpp->work) is
called, but cancel_work_sync(&hidpp->reset_hi_res_work) is omitted. If the
devres group is freed, could a pending high-res scroll work item access
freed memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824130901.8460=
0-1-dmitriy.geels@gmail.com?part=3D1
