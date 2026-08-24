Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15ADA47127B
	for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 17:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787593463; cv=none; b=Gy8h/mOMjZZ9LBKsSp5n6xG6iZkA45sIuo+w3fpEaygD7EGI1z5cwky9TdNgDcPPcRaOTEdMLWC6kvm4hwB8pMr0CT7PsMQOVuK9AyM6hSVrRN5ntB0XF2PlqSW/9pFmWlm2jHm/0VPQkgAiax8dbH1Dn7+o8VszSTIAz2dGFHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787593463; c=relaxed/simple;
	bh=kWuciWvzIwmjVSLv223xne998/zfNDnRexZEX5ezHRk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f2cTbfumKgsSY2ZyIq/O92zef01RZA8lWc6BcBq+aPdtMXbO3jti3jUJ8uXKeWwveAQNQEzwbQlxPqSBmk3GfD+I+3t+044l/Ko6Or/lTw7RLuCvlIqvBcHxGd8rCiDCqIZVy39+FlFFduRbtUeU1czN0/kgnIntGxlMbcotxWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjzpRq93; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PjzpRq93"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E4811F000E9;
	Mon, 24 Aug 2026 17:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787593447;
	bh=Y9Ci6vS8LkqvVZrzXxDCYFAj6AqPA8zEFuH/Drx6OLE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PjzpRq93p+F7BNfDWGNCz/N15faNvorBB3m456avQbi5RXWZJjQw4t9JNhQrNIOxg
	 OE3S1NaKjv9308J/Ek4yXMO8ORpQGZ5Z4ZHArbytovxMswwMUJJa/OLt7JQEdCnGDC
	 yQr/yzcqKyHs1Iw5JwnnCfSiiv9D+OkVDtVzlkdbjIEtEGA0jqRqVs7N+kABxXyVK5
	 xh06L/WHsT4lwR29/qsYNL5GbcRmrB351qv1bWxERqit6hlWpy5PIpRHQnxyKVUIy2
	 eA1h8B3p4ct6CAt6IcAjBfaUW9k/w2xi7EC0lQSIuelSMp4ht9I0UUZ8a8JnCfp7/M
	 QfZ7KDsj2YHuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] HID: logitech-hidpp: add native touchpad support for
 K400 Plus
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitriy Geels" <dmitriy.geels@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260824173042.13679-1-dmitriy.geels@gmail.com>
References: <20260824173042.13679-1-dmitriy.geels@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 17:44:06 +0000
Message-Id: <20260824174407.0E4811F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Use-after-free of `wd->input` on input device registration failure.
- [Medium] Devres memory leak of `devm_name` on connection error paths.
- [Medium] Mismatch between advertised clickpad capabilities and actual but=
ton events.
- [Low] Compilation failure due to use of undeclared variable `wd`.
- [Low] Missing READ_ONCE barrier when accessing `wd->input`.
--

--- Patch [1]: [PATCH v2] HID: logitech-hidpp: add native touchpad support =
for K400 Plus ---
commit b543fab9a342a739672bb20ebed2d0f4a5885b83
Author: Dmitriy Geels <dmitriy.geels@gmail.com>

HID: logitech-hidpp: add native touchpad support for K400 Plus

This commit adds support for the native raw touchpad reports on the
Logitech K400 Plus by creating a separate multitouch input device.

Link: https://lore.kernel.org/linux-input/20260824132445.C64EE1F000E9@smtp.=
kernel.org/

> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-=
hidpp.c
> index 1504de32b1c84..9a6b04283130f 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -2963,8 +2966,13 @@ static int wtp_populate_input(struct hidpp_device =
*hidpp,
> =20
> [ ... ]
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

[Severity: Medium]
Are these capabilities accurately reflecting the device's behavior?

The commit message states that clickpad buttons should not be exposed
for the CLASS_KBD_WTP device. However, wtp_populate_input() still sets
the INPUT_PROP_BUTTONPAD property and the BTN_LEFT capability.

Userspace input stacks might see these capabilities and treat the device
as a clickpad, waiting for physical clicks that the driver explicitly
suppresses.

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

[Severity: Low]
Since wd->input is published locklessly using WRITE_ONCE() in
hidpp_connect_event(), shouldn't we use READ_ONCE() here in
wtp_raw_event() to ensure proper memory ordering?

> @@ -4524,7 +4562,54 @@ static void hidpp_connect_event(struct work_struct=
 *work)
>  		return;
>  	}
> =20
> -	if (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP) {
> +	if (hidpp->quirks & HIDPP_QUIRK_CLASS_KBD_WTP) {
> +		if (!wd->input) {
> +			struct wtp_data *wd =3D hidpp->private_data;

[Severity: Low]
Does this cause a compilation failure? The if condition evaluates
wd->input before the wd variable is declared and initialized on the
very next line.

> +
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
> +			if (!devm_name)
> +				return;

[Severity: Medium]
Can this cause a memory leak if a subsequent step like
wtp_populate_input() or input_register_device() fails?

If a failure occurs, the function returns without setting wd->input.
Because the string is devres-managed and bound to the parent HID device,
the next time hidpp_connect_event() runs, the if (!wd->input) check will
still be true, allocating another string that won't be freed until the
parent device is unbound.

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

[Severity: High]
Could this lead to a use-after-free on the event reporting path if
registration fails?

In hidpp_populate_input(), the pointer is assigned to the private
structure:

hidpp_populate_input() {
        ...
        wd->input =3D input;
        ...
}

If input_register_device() fails shortly after, this error path frees the
input device and clears hidpp->input, but does not clear wd->input.

When the hardware sends a raw HID event, wtp_raw_event() will fetch and
dereference the dangling wd->input pointer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824173042.1367=
9-1-dmitriy.geels@gmail.com?part=3D1
