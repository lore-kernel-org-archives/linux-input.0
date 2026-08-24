Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AFD37F723
	for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 18:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787595506; cv=none; b=mpKJonFTdHzXD84c5Z1iHeRQ4DwLQHOe93qECAHMF94Rm+b8JyKGZR+tSm/lm7/8ZhgAWqoc5bqAm/Su7AmaXytIU+gtuQHy/Aur58lc2eEhFGfUQsboF5YN4Tyd6aG7o54O+D0LL/a32QFQnL9Byqr22B07Vsvc8uFLviJOX/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787595506; c=relaxed/simple;
	bh=aCzA4LsceW7ESaRQYeKWiMa0ZYs5jZfFpV1bhwbkh8I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tdZ5b/FSxbJ9OhKJoE8md9zNuG222nSW/Nu2bJJ4zIxFCJ83tTfLZa5qSriPL/9OBPbSWS/uUDhfhqNZ0chw6ozDmAeOmjlN3ZZPiHCliwromck6bVUqufL11Vwy1jNBHbaLAmgFrrcp8j/YUayeM4JTZFK0UN1MjfDvd/FVKMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKLmf6G6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKLmf6G6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B501F000E9;
	Mon, 24 Aug 2026 18:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787595504;
	bh=IB5wcgU9an1yjZv6ZgL5gY8eDkRzXsENZ6XRk3+Ri/A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XKLmf6G6kRYZZCFTOgXVpFLuiVlLdJDfiuH5YWEuz24wvgXsv9M/knh3ibk4AlL01
	 1g4Z/Fj9k0SICacAJZDFS+CVZR3ihruh6IX1Zra0qune5vIedv/5qNe38x74zweoZY
	 lcElW1N9i+kbQkDUHUcKzyqRlu3VihSqFtcUuefRocA5gEsQt02ArD+Z5jsZQRwVfE
	 aR+2okVQIrOMH4tIk9k9lEprPTK0GGRZPERsVQ6T1rWV5Jvc8efJ5bofRV4G5msF9D
	 GaIHZ21lw8ikpOBEVDQCfbmFP6I3y26OFjk2C36I/Wxb+97U/4ouR9OXEbHQ8CGh6m
	 WgQnyb0nqN04g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] HID: logitech-hidpp: add native touchpad support for
 K400 Plus
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitriy Geels" <dmitriy.geels@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260824180425.55809-1-dmitriy.geels@gmail.com>
References: <20260824180425.55809-1-dmitriy.geels@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 18:18:24 +0000
Message-Id: <20260824181824.A9B501F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [High] The K400 Plus touchpad is erroneously advertised as a clickpad (bu=
ttonpad) without emitting a left button event, breaking userspace interacti=
on.
- [High] Dangling `wd->input` pointer leads to a Use-After-Free if `input_r=
egister_device()` fails for `CLASS_WTP` devices.
- [Medium] Missing cleanup of devres-managed memory (`input_dev` and `devm_=
name`) in the error paths of `hidpp_connect_event()`.
- [Medium] The KBD_WTP touchpad input device gets assigned a generic receiv=
er name instead of the actual human-readable device name.
- [Medium] Data race due to missing `READ_ONCE()` on `wd->input` in event h=
andlers.

Pre-existing issues:
- [High] Dangling `hidpp->input` pointer leads to a Use-After-Free if `inpu=
t_register_device()` fails inside the HID core.
--

--- Patch [1]: [PATCH v3] HID: logitech-hidpp: add native touchpad support =
for K400 Plus ---
commit 0b206b299e2d55ee7d52e893ea117f7035ac35a4
Author: Dmitriy Geels <dmitriy.geels@gmail.com>
Subject: HID: logitech-hidpp: add native touchpad support for K400 Plus

The Logitech K400 Plus (WPID 0x404d) exposes its touchpad through the
HID++ TouchpadRawXY feature, but currently operates as an emulated mouse.
Add support for the native raw touchpad reports by creating a separate
multitouch input device.

Link: https://lore.kernel.org/linux-input/20260824173042.13679-1-dmitriy.ge=
els@gmail.com/

> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-=
hidpp.c
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c

[ ... ]

> @@ -2963,8 +2966,13 @@ static void wtp_populate_input(struct hidpp_device=
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
> =20
>  	if (hidpp->quirks & HIDPP_QUIRK_WTP_PHYSICAL_BUTTONS)
>  		input_set_capability(input_dev, EV_KEY, BTN_RIGHT);
>  	else
>  		__set_bit(INPUT_PROP_BUTTONPAD, input_dev->propbit);
> =20

[Severity: High]
The stated intent of this patch is to leave physical button reports on the
existing HID input device. However, since HIDPP_QUIRK_WTP_PHYSICAL_BUTTONS
is not set for the K400 Plus, does this code incorrectly advertise BTN_LEFT
and INPUT_PROP_BUTTONPAD for the new touchpad device?

Userspace libraries like libinput might expect mechanical clicks directly
on the touchpad since it's advertised as a clickpad, but those events
are explicitly suppressed in wtp_send_raw_xy_event() for CLASS_KBD_WTP.
Could this break click-and-drag functionality?

[ ... ]

> @@ -3066,8 +3079,13 @@ static int wtp_raw_event(struct hid_device *hdev, =
u8 *data, int size)
>  	struct wtp_data *wd =3D hidpp->private_data;
>  	struct hidpp_report *report =3D (struct hidpp_report *)data;
>  	struct hidpp_touchpad_raw_xy raw;
> +	struct input_dev *input;
> =20
> -	if (!wd || !hidpp->input)
> +	if (!wd)
> +		return 1;
> +
> +	input =3D wd->input;
> +	if (!input)
>  		return 1;

[Severity: Medium]
The wd->input pointer is published in hidpp_connect_event() using
WRITE_ONCE(wd->input, input).

Should this reader side use READ_ONCE(wd->input) to prevent potential
load tearing or compiler reordering?

[ ... ]

> @@ -4064,14 +4091,22 @@ static int hidpp_input_mapped(struct hid_device *=
hdev, struct hid_input *hi,
>  }
> =20
> =20
> -static void hidpp_populate_input(struct hidpp_device *hidpp,
> +static int hidpp_populate_input(struct hidpp_device *hidpp,
>  				 struct input_dev *input)
>  {
> +	int ret;
> +
>  	hidpp->input =3D input;

[Severity: High]
This is a pre-existing issue, but assigning hidpp->input here before the
device is registered can lead to a use-after-free.

If input_register_device() fails later inside the HID core (e.g., in
hidinput_connect()), the core frees the input_dev, but hidpp->input remains
populated with the freed pointer. Can this cause raw event handlers to
dereference the dangling pointer on incoming reports?

[ ... ]

> @@ -4524,7 +4562,54 @@ static void hidpp_connect_event(struct work_struct=
 *work)
>  		return;
>  	}
> =20
> -	if (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP) {
> +	if (hidpp->quirks & HIDPP_QUIRK_CLASS_KBD_WTP) {
> +		struct wtp_data *wd =3D hidpp->private_data;
> +
> +		if (!wd->input) {
> +			ret =3D wtp_get_config(hidpp);
> +			if (ret) {
> +				hid_err(hdev, "cannot get WTP config: %d\n", ret);
> +				return;
> +			}
> +
> +			input =3D hidpp_allocate_input(hdev);
> +			if (!input) {
> +				hid_err(hdev, "cannot allocate touchpad input device\n");
> +				return;
> +			}
> +
> +			devm_name =3D devm_kasprintf(&hdev->dev, GFP_KERNEL,
> +						   "%s Touchpad", hidpp->name);

[Severity: Medium]
Does this format the input device name using the generic receiver name
(e.g., "Logitech USB Receiver Touchpad") rather than the actual device name?

The actual device name is fetched using hidpp_get_device_name() and
assigned to hidpp->name further down in hidpp_connect_event(), which
happens after this registration. Could this break userspace configuration
tools or libinput quirks that rely on name matching?

> +			if (!devm_name)
> +				return;
> +
> +			input->name =3D devm_name;
> +
> +			ret =3D wtp_populate_input(hidpp, input);
> +			if (ret) {
> +				hid_err(hdev,
> +					"cannot initialize touchpad input device: %d\n",
> +					ret);
> +				input_free_device(input);
> +				return;
> +			}

[Severity: Medium]
If wtp_populate_input() or input_register_device() fails, we call
input_free_device() but return without cleaning up devm_name.

Since hidpp_connect_event() runs in a workqueue triggered by wireless
connection events, could repeated connection initialization failures leak
the devm_kasprintf() allocations on the parent device's devres list?

[ ... ]

> @@ -4615,7 +4700,12 @@ static void hidpp_connect_event(struct work_struct=
 *work)
>  		return;
>  	}
> =20
> -	hidpp_populate_input(hidpp, input);
> +	ret =3D hidpp_populate_input(hidpp, input);
> +	if (ret) {
> +		hidpp->input =3D NULL;
> +		input_free_device(input);
> +		return;
> +	}
> =20
>  	ret =3D input_register_device(input);
>  	if (ret) {
>  		hidpp->input =3D NULL;
>  		input_free_device(input);
>  		return;
>  	}

[Severity: High]
If input_register_device() fails here for a CLASS_WTP device, we free the
input device and clear hidpp->input. However, wtp_populate_input() already
saved a copy of this pointer in wd->input.

Does this leave wd->input pointing to freed memory?

If a hardware report arrives shortly after, wtp_raw_event() could bypass
its "!wd->input" check and dereference the pointer, causing a use-after-fre=
e.
Should wd->input also be cleared in these error paths?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824180425.5580=
9-1-dmitriy.geels@gmail.com?part=3D1
