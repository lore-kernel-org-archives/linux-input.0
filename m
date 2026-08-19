Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19D542A96
	for <linux-input@vger.kernel.org>; Wed, 19 Aug 2026 20:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787170942; cv=none; b=GFZctRPkaNN5znay/naK3WkGYHQp5ndEBB4gBwVFeZzYJPRRR1jbfyIq3Zyk9EE5CtHHWSyqVj+J4jISAO5VWjUouJnQp2rj/Y3nJal95U5afzjgAFAmVyVlyb33szI0ZrWo8pSVJRbHP/07+HxNaKSoRN03j1YE31hpFUQw4fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787170942; c=relaxed/simple;
	bh=If3tWcOtsH5ahAOYAJAlSUnXBfjwWk2oqgq2mHfZnkA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bT6ybICRS4wIyLb2cKPojas9TrA7bZI62Ab0vzqb8rJNf4Zex4FkNuKOIuR18EsoRITOlI7iq8fKNd/rHoYc/L2ymWa52PzbJHIKfpxlLWeZlZtOvIU7ICW6M49QkdKSjjMlZ3YRoJeyXayf6pt9cgDnnTe2G5pedka5C0RzhuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/oX/A/t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/oX/A/t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7563A1F000E9;
	Wed, 19 Aug 2026 20:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787170940;
	bh=cd3P/WXiZ7dSmhD/Vyw9SoRuw/lkTW/MSrYHeLMco38=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b/oX/A/tCvTO2hOXUdmmTPbh4iHNmhdnk95pAW9KGythAR0gqiqi5/54BlVggiRA2
	 BDa6wtfVRyAMsLkQ60EF3kFb6HEUlvMtI0dfcjI3xrJApKnUI/BiwV4+VV9IEqtIj6
	 zMeB/5kgxTPF1J1cj36ghMTL4b9ayU54GOmN9M7rY/gOMjYjHwgH1wASeNslD2WuYN
	 KL7jC/AqzJOIWci2rOG3T6liSsyJpPp9krmTzyNuswDjoA4bpxeX7tzliAfNXBYEBp
	 oWYSW76CPUOK5XELU2ABpA/4PIjR3WnVfluYyvlJ0igrhGrhm4nbw3lFgGH4E6hw63
	 7/8PpM1kCbXAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/12] HID: asus: add support for btn remapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260819195835.1649657-13-denis.benato@linux.dev>
References: <20260819195835.1649657-1-denis.benato@linux.dev>
 <20260819195835.1649657-13-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 20:22:20 +0000
Message-Id: <20260819202220.7563A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Software mapping cache rollback logic introduces state desync wh=
en a sequential hardware update fails on first-generation devices.
- [Low] Default button mapping initialization uses highly brittle hardcoded=
 array indices that will silently break if the button code map array change=
s.
--

--- Patch [12]: [PATCH v2 12/12] HID: asus: add support for btn remapping -=
--
commit a8628b197357f3dab376cf274ae63c642d78d4ff
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: add support for btn remapping

This commit adds support for button remapping on ROG Ally devices, exposing
sysfs attributes to allow configuring gamepad and desktop mode button codes
for individual physical buttons.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index d6ab906b7e782..06dceb77d1086 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
[ ... ]
> @@ -976,6 +984,325 @@ static int ally_set_gamepad_mode(struct ally_handhe=
ld *ally, struct hid_device *
>  	return 0;
>  }
> =20
> +enum btn_map_type {
> +	BTN_TYPE_NONE =3D 0,
> +	BTN_TYPE_PAD =3D 0x01,
> +	BTN_TYPE_KB =3D 0x02,
> +	BTN_TYPE_MOUSE =3D 0x03,
> +	BTN_TYPE_MEDIA =3D 0x05,
> +};
> +
> +struct btn_code_map {
> +	unsigned char type;
> +	unsigned char value;
> +	const char *name;
> +};
> +
> +static const struct btn_code_map ally_btn_codes[] =3D {
> +	{ BTN_TYPE_NONE, 0x00, "NONE" },
> +	/* Gamepad button codes */
> +	{ BTN_TYPE_PAD, 0x01, "PAD_A" },
[ ... ]
> +	/* Media button codes */
> +	{ BTN_TYPE_MEDIA, 0x16, "MEDIA_SCREENSHOT" },
> +	{ BTN_TYPE_MEDIA, 0x19, "MEDIA_SHOW_KEYBOARD" },
> +	{ BTN_TYPE_MEDIA, 0x1C, "MEDIA_SHOW_DESKTOP" },
> +	{ BTN_TYPE_MEDIA, 0x1E, "MEDIA_START_RECORDING" },
> +	{ BTN_TYPE_MEDIA, 0x01, "MEDIA_MIC_OFF" },
> +	{ BTN_TYPE_MEDIA, 0x02, "MEDIA_VOL_DOWN" },
> +	{ BTN_TYPE_MEDIA, 0x03, "MEDIA_VOL_UP" },
> +};
> +
> +static const size_t keymap_len =3D ARRAY_SIZE(ally_btn_codes);
[ ... ]
> +static void ally_set_default_keyboard_mapping(struct ally_button_mapping=
 *mappings)
> +{
> +	struct ally_button_mapping *map =3D &mappings[ALLY_GAMEPAD_MODE_KEYBOAR=
D];
> +	int i;
> +
> +	/* Set all pair indexes and initialize to NONE */
> +	for (i =3D 0; i < 9; i++) {
> +		map->button_pairs[i].pair_index =3D i + 1;
> +		map->button_pairs[i].first.remap =3D
> +			&ally_btn_codes[0];
> +		map->button_pairs[i].first.macro =3D
> +			&ally_btn_codes[0];
> +		map->button_pairs[i].second.remap =3D
> +			&ally_btn_codes[0];
> +		map->button_pairs[i].second.macro =3D
> +			&ally_btn_codes[0];
> +	}
> +
> +	/*
> +	 * Desktop mode defaults: keyboard and mouse mappings.
> +	 * Buttons not listed here (dpad, view, menu) remain NONE.
> +	 */
> +
> +	/* btn_a =3D> KB_SPACE, btn_b =3D> KB_E */

[Severity: Low]
This isn't a bug, but does hardcoding these array indices create a risk of
breaking the mappings if the ally_btn_codes array is modified in the future=
?=20
If new codes are added, removed, or reordered, explicit numbers like 91 and=
 53
will silently point to the wrong button codes, causing the default mappings
to silently regress.

> +	map->button_pairs[BTN_PAIR_AB - 1].first.remap =3D
> +		&ally_btn_codes[91]; /* KB_SPACE */
> +	map->button_pairs[BTN_PAIR_AB - 1].second.remap =3D
> +		&ally_btn_codes[53]; /* KB_E */
> +
> +	/* btn_x =3D> KB_R, btn_y =3D> KB_F */
> +	map->button_pairs[BTN_PAIR_XY - 1].first.remap =3D
> +		&ally_btn_codes[54]; /* KB_R */
> +	map->button_pairs[BTN_PAIR_XY - 1].second.remap =3D
> +		&ally_btn_codes[68]; /* KB_F */
[ ... ]
> @@ -2775,6 +3120,515 @@ static void ally_btn_turbo_init_attrs(struct ally=
_btn_sysfs_entry *entry)
>  	entry->attrs[4] =3D NULL;
>  }
[ ... ]
> +static ssize_t button_remap_store(struct device *dev,
> +				  struct device_attribute *attr,
> +				  const char *buf, size_t count)
> +{
[ ... ]
> +		/*
> +		 * Send mapping to device with the caveat that first
> +		 * generation devices require individual button pair updates.
> +		 */
> +		if (cfg->is_ally_x) {
> +			ret =3D ally_set_button_mapping(hdev, ally, pair);
> +		} else {
> +			mode_map =3D &cfg->button_mappings[cfg->gamepad_mode];
> +			ret =3D 0;
> +			for (i =3D 0; i < 9; i++) {
> +				mode_map->button_pairs[i].pair_index =3D i + 1;
> +				ret =3D ally_set_button_mapping(hdev, ally,
> +					&mode_map->button_pairs[i]);
> +				if (ret < 0)
> +					break;
> +			}
> +		}
> +
> +		/*
> +		 * The hardware rejected the update: restore the previous
> +		 * mapping so that the software cache keeps describing the
> +		 * state the device is actually in.
> +		 */

[Severity: Medium]
Could this rollback logic cause a desynchronization between the software ca=
che
and the hardware state?

When iterating over the 9 button pairs on older devices, if a USB transfer
fails on an iteration after the target pair was already successfully written
to the device (e.g. failure at iteration 5 when the target was pair 2), the
loop breaks and this rollback path triggers.

This unrolls old_code in the software cache, but the hardware has already
accepted and applied the new mapping, causing the sysfs cache to incorrectly
report the previous state.

> +		if (ret < 0) {
> +			if (btn_attr->is_macro)
> +				btn_map->macro =3D old_code;
> +			else
> +				btn_map->remap =3D old_code;
> +
> +			hid_err(hdev, "Failed to set button mapping: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	return count;
> +}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819195835.1649=
657-1-denis.benato@linux.dev?part=3D12
