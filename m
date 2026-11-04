Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793757481;
	b=SNw+kbHCbmnzuqWoFhUzNtISDKzuM+qjVTjPlaDCtd9lragGPTI4wtoKhHyA5hxdpKs1
	 ZLM4bZFWQ98b7cFNGAQuys0igfxwtKdqlviUrrp2mITyXKNyVsQGl3zc95fHFf1n8stPZ
	 Xo7a3EfONgwLU25J3d2d0tHTL246hLp3dJhhAWfW5qKS9bgE1OB1bIKE2Oxf+ZSLWnK5C
	 AEW9sQWF93IaXF2ZFGgoYNCHWnBxfGxPCW6lb69f0+ddXcXblTwafE20PbBNXrHo0R1pE
	 qZ/L19r8fmNZ3yRjUKGEweOIP4YUqJ6ggwCDe6YRSvCU88PaYYwvRUC1ABWIBW0xQKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793757481;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mYGWC8xsUuLiIPdNBLqIuGuYKKcz0EeVuH8AcrakmFM=;
	b=z0SAqbygm9jL9i4KjpwsM3df9PbEWlRZAsgUpoXI+QSfituL1CVIcc6Y6D0hRQALp7Jv
	 LewGiqd7Mz2dr4ECXBzFYhtmkBTq98gCI4SkVY+06/uUifj49HBS7EyZx+3vnb2+LhPBF
	 cpd4ZGj0CtKqfvWxwbAqOZy+1G/pdq9Q8P9nvBOfQDHmPstop1N+Mjlo8NCGC8p9aQ6os
	 c5YQa3v0DrxAgUHlaqapK4Hjfnnb0v67g41hRmL5fLhimLNfJyQ7wNDsht1C29fDl4f1/
	 NmdFAuTIhai41W1wjd2+cxUG1vHNf5T+1aG5XgKPe+OLbeDiciIOqE+F96PpsUAS7/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K9MaR+6E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935B4606A31B
	for <linux-input@vger.kernel.org>; Wed,  4 Nov 2026 01:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K9MaR+6E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB4D1F000C1;
	Wed,  4 Nov 2026 01:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793757481;
	bh=mYGWC8xsUuLiIPdNBLqIuGuYKKcz0EeVuH8AcrakmFM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K9MaR+6E7GnGuSoV3Oz8u24CT7NByrxNs9vb6c/kv+9CeLUyH8wTHrm2Jd9YeO3xw
	 r1L1pmk35Hoao8SSMLRGlzA4DrvuWpdaqNu4s58M75bE5rSC9qdgb6KXdBtCO2iFe1
	 rhJU+TFfm+V/0jvQmoe+lVRSDUmLNbIqOu87obDQFZmtsWjVv3SdWylaCG9lzg84dr
	 x2EhHaWbr7IxKodT07dRDkYuE+WOkr2EcP24LxHYRV3wzJ5Y6J0vRT453Z7X3FZ3tt
	 B/+vbnquMEnesiywQY6sXMmSih0tLLNundDMeWIHxXlKORJye7E+adIvR3cLJN8Z/j
	 RIKB6lLOK6zlg==
Message-ID: <sashiko-outbox-196417@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 12/18] HID: asus: add support for btn remapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261104013935.512713-13-denis.benato@linux.dev>
References: <20261104013935.512713-1-denis.benato@linux.dev>
 <20261104013935.512713-13-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 01:58:00 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] HID: asus: inverted sysfs_streq() check in find_button_by_name()
- [Medium] HID: asus: inconsistent pair update and rollback in button_remap=
_store()
- [Low] HID: asus: mixed cleanup helpers and goto in button_remap_store()
--

commit 72acf6c4d3c76532f8563fc72f2841557666f18a
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: add support for btn remapping

This commit adds sysfs support for remapping physical buttons and assigning
macro codes on Asus ROG Ally devices, updating the cached mappings when the
gamepad mode changes.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 70c9d71fc5fa9..dcb3c9f5d23e8 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c

[ ... ]

> @@ -978,10 +1186,587 @@ static struct ally_prefs {
>  	struct ally_joystick_resp_curve right_curve;
> =20
>  	struct ally_turbo_config turbo;
> +	struct ally_button_mapping button_mappings;
>  } ally_prefs =3D {
>  	.lock =3D __MUTEX_INITIALIZER(ally_prefs.lock),
>  };
> =20
> +/**
> + * find_button_by_name() - Find a button code map by its name
> + * @name: name of the button code to look up
> + *
> + * This function deals with data from userspace therefore it
> + * must not trust the input blindly.
> + *
> + * Return: the matching button code map, or NULL if not found.
> + */
> +static const struct btn_code_map *find_button_by_name(const char *name)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(ally_btn_codes); i++) {
> +		if (!sysfs_streq(ally_btn_codes[i].name, name))
> +			return &ally_btn_codes[i];
> +	}
> +
> +	return NULL;
> +}

[Severity: High]
Is the sysfs_streq() condition in find_button_by_name() inverted?

Unlike strcmp(), sysfs_streq() returns true when the strings match. Because
ally_btn_codes[0] is "NONE" and ally_btn_codes[1] is "BTN_SOUTH", negating
sysfs_streq() causes find_button_by_name("NONE") in
ally_set_button_pair_mappings_default() to return &ally_btn_codes[1]
(BTN_SOUTH), and causes lookups for any other button name (or invalid strin=
gs
written by userspace to button_remap_store()) to immediately return
&ally_btn_codes[0] (NONE).

When hid_asus_ally_init() calls ally_apply_button_mappings(), or when
gamepad_mode_store() or button_remap_store() updates mappings, all default
remaps resolve to NONE, all default macros resolve to BTN_SOUTH, and invalid
button names from userspace never fail with -EINVAL.

[ ... ]

> +static ssize_t button_remap_store(struct device *dev,
> +				  struct device_attribute *attr,
> +				  const char *buf, size_t count)
> +{
> +	struct hid_device *hdev =3D to_hid_device(dev);
> +	struct button_remap_attr *btn_attr =3D to_button_remap_attr(attr);
> +	enum ally_button_id button_id =3D btn_attr->button_id;
> +	const struct btn_code_map *old_code, *code;
> +	const struct btn_code_map **target_map;
> +	struct ally_button_mapping *mode_map;
> +	enum btn_pair_index pair_idx;
> +	struct button_pair_map *pair;
> +	struct button_map *btn_map;
> +	bool is_first;
> +	int ret, i;
> +
> +	code =3D find_button_by_name(buf);
> +	if (!code)
> +		return -EINVAL;
> +
> +	ret =3D get_button_pair_info(button_id, &pair_idx, &is_first);
> +	if (ret < 0)
> +		return ret;
> +
> +	guard(mutex)(&ally_prefs.lock);
> +
> +	/*
> +	 * Validate the remap target while holding the lock: the
> +	 * gamepad mode can change concurrently, and the check must
> +	 * be done against the very mode the mapping is written to.
> +	 */
> +	if (!ally_remap_code_valid(button_id, ally_prefs.gamepad_mode, code,
> +				   btn_attr->is_macro))
> +		return -EINVAL;
> +
> +	/* Access the mapping for current gamepad mode */
> +	pair =3D &ally_prefs.button_mappings.button_pairs[pair_idx - 1];
> +	btn_map =3D is_first ? &pair->first : &pair->second;
> +
> +	target_map =3D btn_attr->is_macro ? &btn_map->macro : &btn_map->remap;
> +	old_code =3D *target_map;
> +	*target_map =3D code;
> +
> +	/* Update pair index */
> +	pair->pair_index =3D pair_idx;
> +
> +	/*
> +	 * Send mapping to device with the caveat that first
> +	 * generation devices require individual button pair updates.
> +	 */
> +	if (ally_prefs.is_ally_x) {
> +		ret =3D ally_set_button_mapping(hdev, pair);
> +		if (ret < 0)
> +			goto err_restore;
> +	} else {
> +		mode_map =3D &ally_prefs.button_mappings;
> +		for (i =3D 0; i < ARRAY_SIZE(mode_map->button_pairs); i++) {
> +			mode_map->button_pairs[i].pair_index =3D i + 1;
> +			ret =3D ally_set_button_mapping(hdev,
> +						      &mode_map->button_pairs[i]);
> +			if (ret < 0) {
> +				/*
> +				 * Pairs are pushed one at a time. This pair
> +				 * already reached the hardware when a later
> +				 * pair is the one that failed.
> +				 */
> +				if (i > pair_idx - 1)
> +					goto err_restore_hw;
> +				goto err_restore;
> +			}
> +		}
> +	}
> +	sysfs_notify(&dev->kobj, ally_button_names[btn_attr->button_id],
> +		     btn_attr->is_macro ? "macro" : "remap");
> +	return count;
> +
> +err_restore_hw:
> +	*target_map =3D old_code;
> +
> +	/* Try to recover the mapping presented to the user. */
> +	ally_set_button_mapping(hdev, pair);
> +	goto err_out;
> +
> +err_restore:
> +	*target_map =3D old_code;
> +
> +err_out:
> +	hid_err(hdev, "Failed to set button mapping: %d\n", ret);
> +	return ret;
> +}

[Severity: Medium]
Does the err_restore_hw path in button_remap_store() properly roll back the
hardware state on first-generation ROG Ally devices?

In ally_detect_capabilities(), ally_prefs.is_ally_x is set only for the sec=
ond-
generation ROG Ally X (USB_DEVICE_ID_ASUSTEK_ROG_NKEY_ALLY_X). In
button_remap_store(), the comment says first-generation devices require
individual button pair updates, yet the code sends a single pair when
ally_prefs.is_ally_x is true and loops over all 9 pairs in
mode_map->button_pairs when ally_prefs.is_ally_x is false.

Furthermore, err_restore_hw is only reachable from the !ally_prefs.is_ally_x
loop when ally_set_button_mapping() fails at iteration i > pair_idx - 1, but
err_restore_hw then calls ally_set_button_mapping(hdev, pair) for only that
single pair. If !ally_prefs.is_ally_x devices require all 9 pairs to be sen=
t,
wouldn't a single-pair update in err_restore_hw fail to restore the hardware
mapping, or if single-pair updates work on !ally_prefs.is_ally_x, why does =
the
else branch send all 9 pairs?

[ ... ]

> @@ -2399,11 +3200,11 @@ static void ally_btn_turbo_init_attrs(struct ally=
_btn_sysfs_entry *entry)
> =20
>  static struct ally_btn_sysfs_entry *ally_create_button_attributes(struct=
 hid_device *hdev)
>  {
> +	size_t entries_attr_index;
>  	int i, ret;
> =20
>  	scoped_guard(mutex, &ally_prefs.lock)
> -		if (!ally_prefs.turbo_support)
> -			return NULL;
> +		entries_attr_index =3D ally_prefs.turbo_support ? 4 : 0;
> =20
>  	struct ally_btn_sysfs_entry *entries __free(kfree) =3D kzalloc_objs(*en=
tries, ALLY_BTN_MAX);
>  	if (!entries)
> @@ -2412,13 +3213,33 @@ static struct ally_btn_sysfs_entry *ally_create_b=
utton_attributes(struct hid_dev
>  	for (i =3D 0; i < ALLY_BTN_MAX; i++) {
>  		entries[i].btn =3D i;
> =20
> -		if (!ally_btn_param(i)) {
> -			hid_err(hdev, "Invalid button id %d for turbo attributes\n", i);
> -			ret =3D -EINVAL;
> +		if (ally_prefs.turbo_support) {
> +			if (!ally_btn_param(i)) {
> +				hid_err(hdev, "Invalid button id %d for turbo attributes\n", i);
> +				ret =3D -EINVAL;
> +				goto ally_btn_err_cleanup;
> +			}
> +
> +			ally_btn_turbo_init_attrs(&entries[i]);
> +		}
> +
> +		entries[i].remap_attr =3D button_remap_attr_create(i, false);
> +		entries[i].macro_attr =3D button_remap_attr_create(i, true);
> +		if (!entries[i].remap_attr || !entries[i].macro_attr) {
> +			ret =3D -ENOMEM;
>  			goto ally_btn_err_cleanup;
>  		}
> =20
> -		ally_btn_turbo_init_attrs(&entries[i]);
> +		sysfs_attr_init(&entries[i].attr_remap_available.attr);
> +		entries[i].attr_remap_available.attr.name =3D "remap_available";
> +		entries[i].attr_remap_available.attr.mode =3D 0444;
> +		entries[i].attr_remap_available.show =3D btn_remap_available_show;
> +
> +		entries[i].attrs[entries_attr_index + 0] =3D &entries[i].remap_attr->d=
ev_attr.attr;
> +		entries[i].attrs[entries_attr_index + 1] =3D &entries[i].macro_attr->d=
ev_attr.attr;
> +		entries[i].attrs[entries_attr_index + 2] =3D &entries[i].attr_remap_av=
ailable.attr;
> +		entries[i].attrs[entries_attr_index + 3] =3D NULL;
> +
>  		entries[i].group.name =3D ally_button_names[i];
>  		entries[i].group.attrs =3D entries[i].attrs;
> =20
> @@ -2436,6 +3257,11 @@ static struct ally_btn_sysfs_entry *ally_create_bu=
tton_attributes(struct hid_dev
>  	while (i--)
>  		sysfs_remove_group(&hdev->dev.kobj, &entries[i].group);
> =20
> +	for (i =3D 0; i < ALLY_BTN_MAX; i++) {
> +		kfree(entries[i].remap_attr);
> +		kfree(entries[i].macro_attr);
> +	}
> +
>  	return ERR_PTR(ret);
>  }

[Severity: Low]
As reported by Sashiko on v12 [1], this isn't a bug, but button_remap_store=
()
mixes guard(mutex)(&ally_prefs.lock) with goto labels (err_restore_hw,
err_restore, and err_out) while also holding ally_prefs.lock across
sysfs_notify(), and ally_create_button_attributes() similarly mixes
scoped_guard() and __free(kfree) on entries with goto ally_btn_err_cleanup.

Could button_remap_store() and ally_create_button_attributes() avoid mixing
scope-based cleanup helpers with goto error paths (and could remap_attr and
macro_attr be embedded directly in struct ally_btn_sysfs_entry like
attr_turbo_period, attr_toggle_period, and attr_remap_available)?

[1] https://lore.kernel.org/r/sashiko-outbox-192087@kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104013935.5127=
13-1-denis.benato@linux.dev?part=3D12
