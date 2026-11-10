Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794277022;
	b=V4d6c7HFwO8SNGlb6V4FzfSiM4CA1aI8hh5HjNgWj6uWchI+BglvZZobnz3qGluKhgx3
	 p14Nqvy1DRL4YHwzAMNwMgeGbozXtwxAS7khdwy4QmvxuXFZqjCQdfHQsDSTuFxKsHfyS
	 dDUj9jUgXZJusgBKVNuScdT3DxDjn+vD6edUs/sDTI72LbkQ+PQDsjgPfz74xcPI62XKD
	 /VKEyp4OhNW86ij8UVmM/85hh5LrNrIp8NnpFaJJ33bzNmK+ETqWTEQD27nhttpvYH9NP
	 5s5Ivosn3klQIOwVaJeokc2uBgS1zgmy2SOU+PeKRCJUCULTCgs3lUO+kxPxGBoZQsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794277022;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Q+h4TOOduiBrsUe1FNHdwbfuIn0FvX5JggZl4fXeuQI=;
	b=Alik7LQzzSOcb9kP7+ZKCOw/NW6QoNBEUDxqSYiG4WVTYv05cuu7ET4TGGu+Hij4tT9w
	 6tAEtfADGX3mtDcfMtv1gReGqny20RwouW3Swcv6ElSjqFIDFf5wwh92EN3iSu6ZKllEZ
	 GjbKVsDT4tL8D3RigG0UmeUeen31+L5MMHUvTs8FQwlfgFPhnAK5b6nEmVhYpKIz8vwFt
	 B/w4kgxesN5Oe6MtnIS1iZJfJTlpSox8OpSAtv7MDaQF+XU83gXQkv+is+QaXq1+WUkMJ
	 FjC2lD1J9jb5V7QhQ7rlfetzUw1kA1JAzEMx8DiRPYnEdorKFWZCNJ96BlrqNMMwzmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FBBtanRS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2073606A326
	for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 02:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FBBtanRS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F691F0089F;
	Tue, 10 Nov 2026 02:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794277021;
	bh=Q+h4TOOduiBrsUe1FNHdwbfuIn0FvX5JggZl4fXeuQI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FBBtanRSj2F4lbFIvXtv3CXvS8SpRRNvmI8vgHgup8tGz+jYCg8YPaa5lECg0/uTa
	 f+9C+dfd/bsIzrWFyfsu7ZaLmvq2o3yuspmJ67M0mBtZXkcYSsKwOhHtWU0+YuCag8
	 3sKQxX7UGn5IBQmcJLh6p1s8lNTOy7X1t9N9EaGU+amevXAbsMtiHeDY3nv1v7MgSC
	 7+LXKQ0c3PGHvw8Pi2dSsi70Rlpcu7CHgQFX7RWuGEs0lSBM1wLxdsf4n12qusXen/
	 W4i6xjRtXlmLLeNK0blfMsSFS7NPt7GZyOmDxWhC/i45K8iBHOa5tGiVuJCihUXktc
	 odRo/fcNd9kkQ==
Message-ID: <sashiko-outbox-206038@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 12/18] HID: asus: add support for btn remapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261110020036.112884-13-denis.benato@linux.dev>
References: <20261110020036.112884-1-denis.benato@linux.dev>
 <20261110020036.112884-13-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 02:17:00 +0000
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
- [Medium] HID: asus: inconsistent pair update and rollback in
  button_remap_store()
- [Low] HID: asus: unlocked read of turbo_support in
  ally_create_button_attributes()
- [Low] HID: asus: mixed cleanup helpers and goto in
  button_remap_store()
--

commit 6cb0aa69d532f45691d60b1b758a8ac7ec0bc31a
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: add support for btn remapping

This commit adds sysfs attributes and MCU command support for remapping
physical buttons and macro assignments on ROG Ally handhelds.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index b5a1466d327bf..8f9695b54e2a5 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
[ ... ]
> @@ -998,10 +1206,586 @@ static struct ally_prefs {
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
Is the ally_prefs.is_ally_x condition or the err_restore_hw rollback
inverted here?

The comment says first-generation devices require individual button pair
updates, yet the ally_prefs.is_ally_x branch sends a single pair while the
!ally_prefs.is_ally_x branch loops over all 9 pairs.  And if first-gen
devices actually require all 9 pairs to be sent in sequence, err_restore_hw
(which is only reachable when !ally_prefs.is_ally_x) only sends the single
pair instead of all 9, leaving the hardware with the failed mapping.

[Severity: Low]
This isn't a bug, but button_remap_store() mixes guard(mutex) with goto
error labels and holds ally_prefs.lock across sysfs_notify().  Using
scoped_guard(mutex, &ally_prefs.lock) like gamepad_mode_store() does would
avoid mixing cleanup styles and move sysfs_notify() outside the lock.

[ ... ]
> @@ -2420,11 +3220,11 @@ static void ally_btn_turbo_init_attrs(struct ally=
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
> @@ -2433,13 +3233,33 @@ static struct ally_btn_sysfs_entry *ally_create_b=
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

[Severity: Low]
Should this check entries_attr_index (or a local bool snapshotted under
ally_prefs.lock) instead of re-reading ally_prefs.turbo_support without
holding ally_prefs.lock?

[ ... ]
> @@ -2457,6 +3277,11 @@ static struct ally_btn_sysfs_entry *ally_create_bu=
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
This isn't a bug, but ally_create_button_attributes() also mixes
__free(kfree) on entries with goto ally_btn_err_cleanup.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110020036.1128=
84-1-denis.benato@linux.dev?part=3D12
