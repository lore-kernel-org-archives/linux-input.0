Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793555870;
	b=fsvsLJnAaE3ab6Gmh++03Tjk41AOq9k0hsq2dh6UsMkM5anzpaDqotfgwPEkuCt6rXtQ
	 o5u0Pyusgl8xaaVv0tVVE4trE9HWISN2VuI0YrWFKnCqO1klmKYZdrNbh5pgW6xuH4NG9
	 b0q4BGBSkNERNZzWC5JLopYu8ujim4tdpwBdz9Of97nUNVYSs/rGYDfvOziH0XSOtNY4g
	 2tsfTggPGlZ4u7UbdmiYlrjvRFTjplX0NE/BjiT3gFT4RQPL0K2mmd3mnpbhYa6tsrR/o
	 j8cyBDiaa8fjEY133nlyALpCNun7hMT1vHewQ3qVoabBUe8bGIe6Yc+MbURAyi9c66Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793555870;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=j3OwE8I0DytBxOWXG+MgWq4TxKsNSQsLs97fV4hHlBs=;
	b=UzVOTt5WQfTEbhwViyKrXjVCLw2aeJOQ1NnZafP6bvVCTTHYfsGGI3YiftcauOG8PkWp
	 3w6slZkQEkMtmbqi7o8UriEhSUXxBIAKao3pSE5Z/N4zkRwEAUYQF6BFnvK37seuP+Rf7
	 cpq2k5Z36zArQwlnqSpumxFoHfD6oNFWTcYxKR/k/jVFEz6sI2+hfl/TGAu66DceUNjcy
	 54zxBjI8j1CgoQ2MAvaLs2/GHEWTIG+9P50Ase3PS3FZ2Ykb6Xq7NzRPpFGE9bVz1gCNH
	 GcuIHVnqKiy+ojpVGlKHLwHy2fvOyJE/Onjb1erGglgTHVhSoViJDjrraI02uRlqd8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TDdK8rOb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C00606A324
	for <linux-input@vger.kernel.org>; Sun,  1 Nov 2026 17:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TDdK8rOb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DECDD1F000C1;
	Sun,  1 Nov 2026 17:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793555870;
	bh=j3OwE8I0DytBxOWXG+MgWq4TxKsNSQsLs97fV4hHlBs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TDdK8rObzaKv7WrTC/SINO1VOhDZjOm7UVI5lNQxuP0sbJLgYJp+y21TtuKhqrA70
	 S4DpJ+mtONBkpjyt3w/B+WrHjLA9jLk46hgh++3Hbn5v7hQktF1wW9qtL68IcTv7cZ
	 aXkQ7x790xz9ERKbkhUr+bXU/psM5dRf+uO4X50VVjeJDsPx5+d0iTOoqOQ4flOoJQ
	 GGDfVkoyURytesfB4UYAdRMocoBB2CjqyGDQGQfJ5E5n35y1x2j5/SolpzKyNEw8/A
	 wndwSqcSYlsDNjt05caGKY09xcImejOXkD8IJaC8FaFA7tBvRwA3xQp8A5D8GSD4ZS
	 PKutdS1K/49Sw==
Message-ID: <sashiko-outbox-192550@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/9] HID: haptic, multitouch: Check haptic prerequisite
 properly
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rong Zhang" <i@rong.moe>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261102-hid-haptic-kmod-v1-3-a3de5626dade@rong.moe>
References: <20261102-hid-haptic-kmod-v1-0-a3de5626dade@rong.moe>
 <20261102-hid-haptic-kmod-v1-3-a3de5626dade@rong.moe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 17:57:49 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] HID: haptic: hid_haptic_check_pressure_unit() misses non-force u=
nit mismatch
- [Medium] HID: multitouch: one-way is_haptic_touchpad leaks state to other=
 MT inputs
--

commit 8758bcd8ba263569bfbee87a3d749e9ff7ea4489
Author: Rong Zhang <i@rong.moe>

HID: haptic, multitouch: Check haptic prerequisite properly

This commit stores the HID_DG_TOUCHPAD input device and validates pressure
unit annotations across usages in hid_haptic_check_pressure_unit(), ensuring
hid_haptic_input_configured() only initializes haptics for the matching inp=
ut
device. It also converts td->is_haptic_touchpad into a one-way flag and gua=
rds
probe-time hid_haptic_*() calls with td->haptic.

> diff --git a/drivers/hid/hid-haptic.c b/drivers/hid/hid-haptic.c
> index 9cbacc827dc9c..27cc8a2d9b595 100644
> --- a/drivers/hid/hid-haptic.c
> +++ b/drivers/hid/hid-haptic.c
> @@ -48,17 +48,40 @@ void hid_haptic_feature_mapping(struct hid_device *hd=
ev,
>  }
>  EXPORT_SYMBOL_GPL(hid_haptic_feature_mapping);
> =20
> -bool hid_haptic_check_pressure_unit(struct hid_haptic_device *haptic,
> +void hid_haptic_check_pressure_unit(struct hid_haptic_device *haptic,
>  				    struct hid_input *hi, struct hid_field *field)
>  {
> -	if (field->unit =3D=3D HID_UNIT_GRAM || field->unit =3D=3D HID_UNIT_NEW=
TON) {
> -		haptic->force_logical_minimum =3D field->logical_minimum;
> -		haptic->force_physical_minimum =3D field->physical_minimum;
> -		haptic->force_resolution =3D input_abs_get_res(hi->input,
> -							     ABS_MT_PRESSURE);
> -		return true;
> +	if (hi->application !=3D HID_DG_TOUCHPAD)
> +		return;
> +
> +	/* Don't care about input devices with no pressure sensor. */
> +	if (field->unit !=3D HID_UNIT_GRAM && field->unit !=3D HID_UNIT_NEWTON)
> +		return;
> +
> +	if (IS_ERR(haptic->input_dev))
> +		return;
> +
> +	if (!haptic->input_dev) {
> +		haptic->input_dev =3D hi->input;
> +		haptic->pressure_field =3D field;
> +		haptic->force_resolution =3D input_abs_get_res(hi->input, ABS_MT_PRESS=
URE);
> +		return;
>  	}
> -	return false;
> +
> +	if (haptic->input_dev =3D=3D hi->input &&
> +	    haptic->pressure_field->unit =3D=3D field->unit &&
> +	    haptic->pressure_field->logical_minimum =3D=3D field->logical_minim=
um &&
> +	    haptic->pressure_field->physical_minimum =3D=3D field->physical_min=
imum &&
> +	    haptic->force_resolution =3D=3D input_abs_get_res(hi->input, ABS_MT=
_PRESSURE))
> +		return;
> +
> +	/*
> +	 * Reject if:
> +	 * - there are multiple input devices with pressure sensors
> +	 * - the pressure annotation mismatches
> +	 */
> +	haptic->input_dev =3D ERR_PTR(-EPROTO);
> +	return;
>  }

[Severity: Medium]
What happens if a HID_DG_TOUCHPAD input device has multiple
HID_DG_TIPPRESSURE usages where some specify HID_UNIT_GRAM or HID_UNIT_NEWT=
ON
and others have a non-force unit (such as 0)?

In mt_input_mapping() -> mt_touch_input_mapping():

	case HID_DG_TIPPRESSURE:
		set_abs(hi->input, ABS_MT_PRESSURE, field,
			cls->sn_pressure);
		if (td->haptic)
			hid_haptic_check_pressure_unit(td->haptic, hi, field);

Because hid_haptic_check_pressure_unit() returns early when field->unit is
neither HID_UNIT_GRAM nor HID_UNIT_NEWTON before checking haptic->input_dev:

1. If an earlier HID_DG_TIPPRESSURE usage on hi->input has a valid force un=
it
and a later usage on the same hi->input has unit 0, set_abs() overwrites
ABS_MT_PRESSURE parameters and resets its resolution to 0 on hi->input, whi=
le
hid_haptic_check_pressure_unit() returns early instead of setting
haptic->input_dev =3D ERR_PTR(-EPROTO).

2. Conversely, if the first HID_DG_TIPPRESSURE usage on hi->input has unit 0
and a subsequent usage has HID_UNIT_GRAM or HID_UNIT_NEWTON, the first usage
is ignored and the subsequent usage sees !haptic->input_dev and accepts the
device despite the mismatched annotations across usages.

Should hid_haptic_check_pressure_unit() reject the device when a non-force
unit is encountered on the same hi->input as a force unit?

[ ... ]

> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 4e19a0c4d2381..d744ccc3e0b0b 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c

[ ... ]

> @@ -1955,14 +1956,11 @@ static int mt_input_configured(struct hid_device =
*hdev, struct hid_input *hi)
>  	struct hid_report *report;
>  	int ret;
> =20
> -	if (td->is_haptic_touchpad && (td->mtclass.name =3D=3D MT_CLS_WIN_8 ||
> -	    td->mtclass.name =3D=3D MT_CLS_WIN_8_FORCE_MULTI_INPUT ||
> -	    td->mtclass.name =3D=3D MT_CLS_WIN_8_KEEP_LATENCY_ON_CLOSE)) {
> -		if (hid_haptic_input_configured(hdev, td->haptic, hi) =3D=3D 0)
> -			td->is_haptic_touchpad =3D false;
> -	} else {
> -		td->is_haptic_touchpad =3D false;
> -	}
> +	if (td->haptic && !td->is_haptic_touchpad &&
> +	    (td->mtclass.name =3D=3D MT_CLS_WIN_8 ||
> +	     td->mtclass.name =3D=3D MT_CLS_WIN_8_FORCE_MULTI_INPUT ||
> +	     td->mtclass.name =3D=3D MT_CLS_WIN_8_KEEP_LATENCY_ON_CLOSE))
> +		td->is_haptic_touchpad =3D hid_haptic_input_configured(hdev, td->hapti=
c, hi);
> =20
>  	list_for_each_entry(report, &hi->reports, hidinput_list) {
>  		rdata =3D mt_find_report_data(td, report);

[Severity: Medium]
When a composite HID device has a haptic HID_DG_TOUCHPAD collection alongsi=
de
another multitouch application collection (such as a HID_DG_TOUCHSCREEN or a
second non-haptic HID_DG_TOUCHPAD without a pressure sensor), does latching
td->is_haptic_touchpad to true here affect the other multitouch inputs on t=
he
same hid_device?

Once mt_input_configured() configures the haptic touchpad hid_input and sets
td->is_haptic_touchpad =3D true, any subsequent hid_input processed by
mt_input_configured() -> mt_touch_input_configured() will see:

	if (td->is_haptic_touchpad)
		app->mt_flags |=3D INPUT_MT_TOTAL_FORCE;

and set INPUT_MT_TOTAL_FORCE on that non-haptic application as well.

Similarly, at runtime, mt_process_slot() and mt_sync_frame() only check
td->is_haptic_touchpad rather than verifying whether input matches
td->haptic->input_dev:

	if (td->is_haptic_touchpad)
		hid_haptic_pressure_increase(td->haptic, *slot->p);

and:

	if (td->is_haptic_touchpad)
		hid_haptic_pressure_reset(td->haptic);

Could touches on a non-haptic multitouch input on the same HID device feed
into and reset td->haptic->pressure_sum?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-hid-haptic=
-kmod-v1-0-a3de5626dade@rong.moe?part=3D3
