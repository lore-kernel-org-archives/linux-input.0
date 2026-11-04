Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793757305;
	b=Dyz0FeBvnE45LmxLdPI2oHXYVtzOAaG8f4l/k3YBh9VH74il7xx3qub5WPNh2gTyVNJl
	 XbqsWCUOKqKc8jB1Ouz0wOgjNzCdd5ycaJmmXpCk2v9mIgdHAH2qNron2eqwNDEmhd4W8
	 NiJEqXg/IredO1JOJhlWixc7Lk1g8lsQOw9gt/xzUxolS/Es8gkbYKslf0KsaBD5iGMRY
	 /YmiNnutVtsuMohWloymJMIHTTC7Kuj0oq1l4h46hZNk77T06GhDdHl56EkVJdeKn2rp2
	 kPASYpZ231pY/Rs+8IaoXneLpbRJloqfLnI1ihD4jbakwqF0Nyr8OsVf6TJoRscwSMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793757305;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BtfLYyfIYRt9OyGSrmBq5dWvcvgqyUU7iVR/HUL9vGs=;
	b=Fjc9ErUgWYiWohMaVJMGhgVz/g0VZpqv2soy69NHMffIpdOWT0PxR1uG2Pf9LtMQ9D22
	 rrFY7xA+tKoIXLKRA3DCL9pO05J+p/D25NeWlQ+Rnz2oPtne5gAzFEyrq/cJAp3iWjbuK
	 Smf/lWaWT1iGtKvrbd9R+JvfTbVtxsBhEodTRWSPqtKWdGmkXi4IdG87lXS7yzmg2jBH2
	 /ikhhRSo6StxiwokxLPAzLqltfp71X97uarFzY28hMkXQnqKhnBYBiiHL+LUuEz5maj4H
	 mBcnFeIN71jHuIyZD4FIZYT2gDrbjxdxSAKRX1h+mE/hG7OMweAeMbTQb6wOLuZDN+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n5xIDwm3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE55B606D801
	for <linux-input@vger.kernel.org>; Wed,  4 Nov 2026 01:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n5xIDwm3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61DE71F000C1;
	Wed,  4 Nov 2026 01:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793757304;
	bh=BtfLYyfIYRt9OyGSrmBq5dWvcvgqyUU7iVR/HUL9vGs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n5xIDwm3dnVYgV6q1RC2ceVENvBsew/OgiAGi55p6advsnzFKvV5xDJgjnHdUxpVs
	 BIp7rk3HNVeF2ajxI4R/YxLPpHNPDRsqAJSScB2vk95JHnh8UHcwIO/IN2PZpFshe/
	 MOBdQjDuxIgW4JSZWDVIv98q51lL5Ldw7lSweYumC3cXVWtiAwfiRROOkn2VRIgqJ8
	 /Bc2cZQO2GHFYBYBCmcFz5an/0MxLYFdh9h85C0musOGbqH/M9V/C4rhY6qg932bGi
	 OwRRQRYssF8pQJmMynbuHWlR0GywNeXYyqLjmM0a1xe/bk/CQL+60tZW+Z6WDdXOca
	 KGMlvsm5bTd7Q==
Message-ID: <sashiko-outbox-196415@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 16/18] HID: asus: document ROG Ally sysfs attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261104013935.512713-17-denis.benato@linux.dev>
References: <20261104013935.512713-1-denis.benato@linux.dev>
 <20261104013935.512713-17-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 01:55:03 +0000
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
- [High] HID: asus: inverted sysfs_streq() check in find_button_by_name()
- [Low] HID: asus: response_curve_index ABI doc mismatches multi-line output
--

commit 82b20f9d7b18cb0817f799140de2a8d33e0549b4
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: document ROG Ally sysfs attributes

This commit documents the sysfs attributes exposed by hid-asus for configur=
ing
the ASUS ROG Ally and ROG Ally X gamepad controller, including emulation mo=
de,
vibration, joystick calibration, trigger limits, and button mappings.

> diff --git a/Documentation/ABI/testing/sysfs-driver-hid-asus b/Documentat=
ion/ABI/testing/sysfs-driver-hid-asus
> index 30e0d17d4cecc..515eb7c550fc5 100644
> --- a/Documentation/ABI/testing/sysfs-driver-hid-asus
> +++ b/Documentation/ABI/testing/sysfs-driver-hid-asus
> @@ -93,3 +93,392 @@ Description:
> =20
>  		Access: Read only
>  		Valid values: a single line of text
> +

[ ... ]

> +What:		/sys/bus/hid/drivers/asus/<dev>/left_joystick_axis/response_curve=
_index
> +		/sys/bus/hid/drivers/asus/<dev>/right_joystick_axis/response_curve_ind=
ex
> +Date:		October 2026
> +Contact:	linux-input@vger.kernel.org
> +Description:
> +		Explanation of the format of the sibling response_curve
> +		file.
> +
> +		The files are created on the configuration interface of
> +		a bound ASUS ROG Ally or ROG Ally X controller.
> +
> +		Access: Read only
> +		Valid values: a single line of text

[Severity: Low]
Does response_curve_index actually return a single line of text?

In drivers/hid/hid-asus.c, response_curve_index_show() emits six lines of t=
ext
with embedded newlines:

drivers/hid/hid-asus.c:response_curve_index_show() {
	return sysfs_emit(buf,
			  "move_1 resp_1 move_2 resp_2 move_3 resp_3 move_4 resp_4\n"
			  "\n"
			  "move_N: joystick deflection percentage at which curve point N\n"
			  "is placed (0-100, each move_N must be greater than the\n"
			  "previous one). resp_N: response percentage applied from\n"
			  "point N on (0-100).\n");
}

Should this entry describe the multi-line output, or should
response_curve_index_show() emit a single line?

[ ... ]

> +What:		/sys/bus/hid/drivers/asus/<dev>/<btn>/remap
> +Date:		October 2026
> +Contact:	linux-input@vger.kernel.org
> +Description:
> +		Target the button is remapped to, by name. A write
> +		sends the mapping to the controller and is rejected
> +		when the name is unknown or not valid for the button
> +		in the current mode; the recorded mapping is restored
> +		when the controller rejects it.
> +
> +		"NONE" is always valid. In "gamepad" mode only gamepad
> +		codes are valid, in "desktop" mode only keyboard,
> +		mouse and media codes are; btn_m1 and btn_m2 accept
> +		every code.
> +
> +		The file is created in one directory per button of the
> +		configuration interface of a bound ASUS ROG Ally or
> +		ROG Ally X controller. <btn> is one of: btn_a, btn_b,
> +		btn_x, btn_y, btn_lb, btn_rb, dpad_up, dpad_down,
> +		dpad_left, dpad_right, btn_l3, btn_r3, btn_menu,
> +		btn_view, btn_m1 and btn_m2.
> +
> +		Access: Read/Write
> +		Valid values: one name from the sibling
> +		remap_available file

[Severity: High]
Does the driver implementation match this documented behavior for <btn>/rem=
ap
and <btn>/macro?

In drivers/hid/hid-asus.c, find_button_by_name() negates sysfs_streq():

drivers/hid/hid-asus.c:find_button_by_name() {
	for (i =3D 0; i < ARRAY_SIZE(ally_btn_codes); i++) {
		if (!sysfs_streq(ally_btn_codes[i].name, name))
			return &ally_btn_codes[i];
	}

	return NULL;
}

Since sysfs_streq() returns true when the strings match, !sysfs_streq()
returns the first entry in ally_btn_codes[] whose name does not match name.

Because ally_btn_codes[0] is "NONE" and ally_btn_codes[1] is "BTN_SOUTH",
calling find_button_by_name("NONE") returns "BTN_SOUTH", while calling it w=
ith
any other string (including unknown names in button_remap_store()) matches
index 0 and returns "NONE" instead of NULL.

Consequently, ally_set_button_pair_mappings_default() initializes every but=
ton
and macro slot to "BTN_SOUTH", ally_set_default_gamepad_mapping() and
ally_set_default_keyboard_mapping() set explicitly mapped buttons to "NONE",
and writes to <btn>/remap or <btn>/macro never reject unknown names with
-EINVAL.

Should the negation in find_button_by_name() be removed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104013935.5127=
13-1-denis.benato@linux.dev?part=3D16
