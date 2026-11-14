Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794660161;
	b=NX9MY3xBaCiJAM7dvGjE9QA6pg99SgpSAGJ3Qi4803RwCZj4dKd0yRUZA7t5/f0pqbUZ
	 UL8dYFSnogNRtDeCl1pL3adHaXDIj9qNsMVV0JX+0Hcp7lZbXeiMBy/vfxt9b2O35KppZ
	 NR890QEVI8vpluNpENqoq/4sgvCCQsJ4oYQGfMU0cE11CmwTwYaOGJItVzzcr11PzmqR6
	 THBwgEthGBVuiJtMWM3CLiqlywqanrSL4d2fZ+Uyico+RP5wZdDyiaqBzR4TpOUOcUW0R
	 iEOu3JbdwewVp+IxGWA8jVBleum3vDC8cZ9p717EkpjdM+m76SyofSEz43lCQOc8hyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794660161;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eJtwi7ALFbLY/rYy4IfjGxOHsoo3ozDTceg74kwDYl8=;
	b=sN7qh0nHCiD8whaNWMSwomd8Gi3N+X0BJm0UXnA81Z7D6aX3mwGZwI0MOQ2u4GGLUEIp
	 R2IszLxu6py4Bq50OjElPWiQm6ya0IYyGuKbBMQ/+lUK4uXGyRocHFxndeObjQ57Rwl29
	 n81+0yt7iw213HY4EA3lQCgd8Hr+peQSzOOqhoYJ/hzozbgDJ7dLRLhSRtlGq96to5aRW
	 d9MS3DO5JZnGRI8KrzzKPR5B9VYf+lCHwBnxqF9SMaPM5g8+F9FtcJRmPWqYs4xB6mvLW
	 aaQ5qZIcVwa18RnJGkP8kL5n/3r1q2Lnny3kWwZl9LecICb0FzMoD2Gtl0xypD7yOQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UIAUwThP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A05606A32D
	for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 12:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UIAUwThP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F8C71F000C5;
	Sat, 14 Nov 2026 12:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794660161;
	bh=eJtwi7ALFbLY/rYy4IfjGxOHsoo3ozDTceg74kwDYl8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UIAUwThPeJrLlfJSHsgg4GlUO3kNoK/+mY/FDFSK0XP7RqRJ7YV3JXlN0usfVw9jT
	 t1xvHAGR4ToC1xqcAIvneZxWw5UGRZHSNYW0MM4+vgJFAb9lBo+Jazwu9tUzsblUU4
	 5oeBwm2/5kj4bi2xc/edrmVmx6AX910MKMtvf50ZIkIdIu+V2KIhCae6bXIu3vUDep
	 Vs5FZuQ0q5QEa0v2T7ldlEUHGxHXQdSutCgtdD8vLEFhkLwbIRpvm6YdY6JFT9a3QM
	 OR46pgp6kfNSdsYx0p6x85mN1Z1fbwzGTh98QO0hMqhaS/4ba/o9OxqU7jmM5hXxGr
	 Gd8bedaPB1xOg==
Message-ID: <sashiko-outbox-214505@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: microsoft: normalize Xbox Series X|S controller
 axes over Bluetooth
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adolf Hirthe" <ohirthe@proton.me>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261114-hid-ms-xbox-ble-v1-1-0b114dc5dcf3@proton.me>
References: <20261114-hid-ms-xbox-ble-v1-1-0b114dc5dcf3@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 12:42:40 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] HID: microsoft: swapped left and right trigger axes in
  ms_input_mapping()
- [High] HID: microsoft: breaking evdev ABI and trigger mapping in
  ms_input_mapping()
- [Medium] HID: microsoft: unfiltered stick events in ms_event() cause
  defuzz drift
--

commit b00037d015a7b7ec287323be001d24d5b680b0c0
Author: Adolf Hirthe <ohirthe@proton.me>

HID: microsoft: normalize Xbox Series X|S controller axes over Bluetooth

This commit adds an MS_QUIRK_BLE_XBOX_AXES quirk to hid-microsoft to remap
the Bluetooth LE stick and trigger axes of the Xbox Series X|S controller
(045e:0b13) to the xpad axis layout and signed stick range.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D222266

> diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.c
> index 226733718c488..7e426ee85a289 100644
> --- a/drivers/hid/hid-microsoft.c
> +++ b/drivers/hid/hid-microsoft.c

[ ... ]

> @@ -186,6 +187,41 @@ static int ms_input_mapping(struct hid_device *hdev,=
 struct hid_input *hi,
>  	struct ms_data *ms =3D hid_get_drvdata(hdev);
>  	unsigned long quirks =3D ms->quirks;
> =20
> +	/*
> +	 * Xbox controllers over Bluetooth report the right stick as Z/Rz and
> +	 * the analog triggers as Accelerator/Brake (ABS_GAS/ABS_BRAKE), and
> +	 * expose the sticks in the 0..65535 range centered on 32767 instead
> +	 * of the usual +-32767 around 0. Remap everything to the xpad-style
> +	 * layout so that consumers get the same axes regardless of the
> +	 * connection type.
> +	 */
> +	if (quirks & MS_QUIRK_BLE_XBOX_AXES) {
> +		switch (usage->hid) {
> +		case HID_GD_X:
> +			hid_map_usage(hi, usage, bit, max, EV_ABS, ABS_X);
> +			return 1;
> +		case HID_GD_Y:
> +			hid_map_usage(hi, usage, bit, max, EV_ABS, ABS_Y);
> +			return 1;
> +		case HID_GD_Z:
> +			hid_map_usage(hi, usage, bit, max, EV_ABS, ABS_RX);
> +			return 1;
> +		case HID_GD_RZ:
> +			hid_map_usage(hi, usage, bit, max, EV_ABS, ABS_RY);
> +			return 1;
> +		}
> +		if ((usage->hid & HID_USAGE_PAGE) =3D=3D HID_UP_SIMULATION) {
> +			switch (usage->hid & HID_USAGE) {
> +			case 0xc5: /* Brake -> right trigger */
> +				hid_map_usage(hi, usage, bit, max, EV_ABS, ABS_RZ);
> +				return 1;
> +			case 0xc4: /* Accelerator -> left trigger */
> +				hid_map_usage(hi, usage, bit, max, EV_ABS, ABS_Z);
> +				return 1;
> +			}
> +		}
> +	}

[Severity: High]
Are the left and right triggers swapped here relative to xpad?

In the Xbox Bluetooth HID report descriptor, Simulation Controls usage
0xc5 (Brake) is the physical left trigger and 0xc4 (Accelerator) is the
physical right trigger.  In xpad, the left trigger is reported on ABS_Z
and the right trigger on ABS_RZ:

drivers/input/joystick/xpad.c:xpadone_process_packet() {
    ...
		/* triggers left/right */
		if (xpad->mapping & MAP_TRIGGERS_TO_BUTTONS) {
			input_report_key(dev, BTN_TL2,
					(__u16) le16_to_cpup((__le16 *)(data + 6)));
			input_report_key(dev, BTN_TR2,
					(__u16) le16_to_cpup((__le16 *)(data + 8)));
		} else {
			input_report_abs(dev, ABS_Z,
					(__u16) le16_to_cpup((__le16 *)(data + 6)));
			input_report_abs(dev, ABS_RZ,
					(__u16) le16_to_cpup((__le16 *)(data + 8)));
		}
    ...
}

Mapping 0xc5 to ABS_RZ and 0xc4 to ABS_Z inverts the left and right
triggers on every pull.

[ ... ]

> @@ -232,6 +268,22 @@ static int ms_event(struct hid_device *hdev, struct =
hid_field *field,
> =20
>  	input =3D field->hidinput->input;
> =20
> +	/*
> +	 * The sticks are reported as unsigned 0..65535 values centered on
> +	 * 32767; convert them to the +-32767 range we advertise.
> +	 */
> +	if (quirks & MS_QUIRK_BLE_XBOX_AXES && usage->type =3D=3D EV_ABS) {
> +		switch (usage->code) {
> +		case ABS_X:
> +		case ABS_Y:
> +		case ABS_RX:
> +		case ABS_RY:
> +			input_report_abs(input, usage->code,
> +					 clamp(value - 32768, -32767, 32767));
> +			return 1;
> +		}
> +	}

[Severity: Medium]
Can calling input_report_abs() unconditionally in ms_event() cause
spurious stick drift events when other buttons or triggers are pressed?

hid_process_report() calls hid_process_event() for every variable field in
an incoming report before updating field->value.  Normally,
hidinput_hid_event() drops unchanged values when value =3D=3D
field->value[usage->usage_index].  Because ms_event() intercepts the stick
axes and returns 1 without that check, input_report_abs() runs for all
four stick axes on every button or trigger report.  With fuzz set to 255
in ms_input_configured(), each repeated call with an unchanged raw stick
value within the defuzz window re-runs input_defuzz_abs_event() against
dev->absinfo[code].value, stepping the reported stick position and
emitting EV_ABS events while the stick is stationary.

[ ... ]

> @@ -428,7 +490,7 @@ static const struct hid_device_id ms_devices[] =3D {
>  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_XBOX_C=
ONTROLLER_MODEL_1708_BLE),
>  		.driver_data =3D MS_QUIRK_FF },
>  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_XBOX_C=
ONTROLLER_MODEL_1914),
> -		.driver_data =3D MS_QUIRK_FF },
> +		.driver_data =3D MS_QUIRK_FF | MS_QUIRK_BLE_XBOX_AXES },
>  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_XBOX_C=
ONTROLLER_MODEL_1797),
>  		.driver_data =3D MS_QUIRK_FF },
>  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_XBOX_C=
ONTROLLER_MODEL_1797_BLE),

[Severity: High]
Won't changing the evdev axis codes and ranges for
USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1914 (045e:0b13) cause a
regression for existing userspace input stacks?

This device ID has been bound by hid-microsoft since commit f5554725f304
("HID: microsoft: Add rumble support to latest xbox controllers") with the
standard 1:1 HID mapping (ABS_Z/ABS_RZ for the right stick in 0..65535 and
ABS_GAS/ABS_BRAKE for triggers).  Userspace libraries such as SDL,
gamecontrollerdb, Steam Input, and joydev match (BUS_BLUETOOTH, 0x045e,
0x0b13) and expect those axis codes, ranges, and ordinal axis positions.
In addition, 0xc5 (Brake) and 0xc4 (Accelerator) are mapped to ABS_RZ and
ABS_Z backwards relative to xpad, and sibling BLE models
USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1708_BLE (045e:0b20) and
USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1797_BLE (045e:0b22) added in the
same commit are left with the old layout.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-hid-ms-xbo=
x-ble-v1-1-0b114dc5dcf3@proton.me?part=3D1
