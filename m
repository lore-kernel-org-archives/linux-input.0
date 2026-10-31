Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793469647;
	b=MQH07jX7JSAw6sF07j1JFYxTrNA2viAYCIvyn2pU2n/1fopXvyvfY+7u3jw9G9ibtBQR
	 uNeh3hKe+AMJfhLNHca9jm2K5E1s5GoXWYW/w0qyVlRIRi1cDDlm4wSAQF/03ZOi7B/nH
	 N3naBsD3PWf3vOb73eatOnyakXA3Y/wmUb3+JKcG/qarU53sVxMBU/UPZ/dpAHv4w/ymd
	 mBRzZt+vKDLcpqtlpXDWyZu3jXggvz4HmGlPqcx592hDrSpZPN6V0l2d4glt/mFUooFtv
	 sjeqN6ok+JW6m8zPCXRIe9nBJoarsoKdW3MnxYBjH2aG0LKQz0uSIplm+XlbGoxAhPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793469647;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=o9FrlUlxGdSci9V43Grjt+ICmuMfuKLN1dVhL35gBjk=;
	b=T7lOgLa8F1TJd7ae/Jz00sv8YKf9ob9N+UUp8WhIkpBd53szZEP9ZtvnWUBRglEFK8qC
	 clkE9K9iZXOe3+lb9nQK8YL7h5IpOGsIAB9LgX/EYqutTaRuIHfdwnXA4117nke0enWXS
	 vd3yCJ4l90tEuEVorjdKD1HKTcbeXsqxSNwo0uijSqam8HRt5CiMxYkGb67jQ4P7rD3XS
	 LTXFFGrH8Cn9G3yZrm8ZN3w/0QCHTjwdJUX93415lwFI0PQl2kVim6YJI3QJ5VlJBkn/+
	 YP0TZZ8Fr21Ea8qJnC94HODeGTTjiuSQThtFPh8wgd/GhMzVRtqrL6y4mSMNjBxtXAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bxQUE9F8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8A1606A31A
	for <linux-input@vger.kernel.org>; Sat, 31 Oct 2026 18:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bxQUE9F8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 426491F000C1;
	Sat, 31 Oct 2026 18:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793469646;
	bh=o9FrlUlxGdSci9V43Grjt+ICmuMfuKLN1dVhL35gBjk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bxQUE9F8/w8oLnRBRTsrM/8iSo1+H5ouRF91CuxwAKRl4CIvuxUUaq7hUopsa8Yud
	 lA+60ib7yOfmJZMuj+1GSlGK1dFH/tihVwF1ST6+gkJNmV25aNan9IxsqiFnkTs9sK
	 cv9wcXC5hGfWgPVmNZCfNuJDN8CU8JAVjnB0fEMG0tzEkxTNybAoOG6NTu/DYnXE3H
	 aCRRuzbvWTJMdDseUn4AO1gA9cVNOOynF0pN6Zg9V2XO0HY0yBxT16cQr/n4vge1h/
	 7Wv4BVDA5o5fajt/Q7qQZg6odp+Oh97WIfLkhlkqDtgE8PwNaXse1QJpr2k/LeeXkO
	 Z1pfPzlNiiSHg==
Message-ID: <sashiko-outbox-192087@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 12/17] HID: asus: add support for btn remapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261031174130.208240-13-denis.benato@linux.dev>
References: <20261031174130.208240-1-denis.benato@linux.dev>
 <20261031174130.208240-13-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 18:00:45 +0000
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
- [High] HID: asus: ABBA deadlock between ally_prefs.lock and sysfs active =
refs
- [Low] HID: asus: mixed cleanup helpers and goto in button_remap_store()
- [Low] HID: asus: commit message refers to remap_index instead of remap_av=
ailable
--

commit eab19113fde5452095dfc729f53ab98ff0fc3365
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: add support for btn remapping

This commit adds button and macro remapping support for ASUS ROG Ally
devices via per-button sysfs attributes (remap, macro, and
remap_available), validating mappings against the active gamepad mode and
restoring or refreshing the cached mappings across mode switches and MCU
resets.

>     HID: asus: add support for btn remapping
>    =20
>     Add support for buttons remapping: the ability to assign different
>     button events to each one of the physical button on the device.
>    =20
>     Each button exposes a remap_index sysfs attribute listing the valid
>     remap target names for the current gamepad mode: M1 and M2 can be
>     remapped to anything at any time, while other buttons may only be
>     remapped to gamepad codes in gamepad mode and keyboard/mouse/media
>     codes in desktop mode.
>    =20
>     When the gamepad mode is changed the firmware automatically restores
>     its internal defaults, so the software cache is refreshed to reflect
>     the hardware state.
>    =20
>     Co-developed-by: Luke Jones <luke@ljones.dev>
>     Signed-off-by: Luke Jones <luke@ljones.dev>
>     Signed-off-by: Denis Benato <denis.benato@linux.dev>
>     Signed-off-by: Jonathan LoBue <jlobue10@gmail.com>

[Severity: Low]
This isn't a bug, but the commit message refers to a remap_index sysfs
attribute, whereas ally_create_button_attributes() in drivers/hid/hid-asus.c
registers this attribute as remap_available alongside the remap and macro
attributes created in button_remap_attr_create(). Should the commit message
be updated to mention remap, macro, and remap_available instead of
remap_index?

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index d20e433af5740..b94cb8c50b28b 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c

[ ... ]

> +static ssize_t button_remap_store(struct device *dev,
> +				  struct device_attribute *attr,
> +				  const char *buf, size_t count)
> +{
> +	struct hid_device *hdev =3D to_hid_device(dev);
> +	struct button_remap_attr *btn_attr =3D to_button_remap_attr(attr);
> +	enum ally_button_id button_id =3D btn_attr->button_id;
> +	struct ally_button_mapping *mode_map;
> +	const struct btn_code_map *code;
> +	const struct btn_code_map *old_code;
> +	enum btn_pair_index pair_idx;
> +	struct button_pair_map *pair;
> +	struct button_map *btn_map;
> +	char btn_name[32];
> +	bool is_first;
> +	int ret, i;
> +
> +	if (sscanf(buf, "%31s", btn_name) !=3D 1)
> +		return -EINVAL;
> +
> +	code =3D find_button_by_name(btn_name);
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
> +	if (btn_attr->is_macro) {
> +		old_code =3D btn_map->macro;
> +		btn_map->macro =3D code;
> +	} else {
> +		old_code =3D btn_map->remap;
> +		btn_map->remap =3D code;
> +	}
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
> +	if (btn_attr->is_macro)
> +		btn_map->macro =3D old_code;
> +	else
> +		btn_map->remap =3D old_code;
> +
> +	/* Try to recover the mapping presented to the user. */
> +	ally_set_button_mapping(hdev, pair);
> +	goto err_out;
> +
> +err_restore:
> +	if (btn_attr->is_macro)
> +		btn_map->macro =3D old_code;
> +	else
> +		btn_map->remap =3D old_code;
> +
> +err_out:
> +	hid_err(hdev, "Failed to set button mapping: %d\n", ret);
> +	return ret;
> +}

[Severity: Low]
This isn't a bug, but button_remap_store() in drivers/hid/hid-asus.c mixes
scope-based cleanup via guard(mutex)(&ally_prefs.lock) with goto-based error
labels (err_restore_hw, err_restore, and err_out), and
ally_create_button_attributes() similarly mixes __free(kfree) on entries
with goto ally_btn_err_cleanup. Could these functions avoid mixing cleanup
helpers and goto error paths in the same routine?

[ ... ]

> @@ -2429,11 +3248,9 @@ static void ally_btn_turbo_init_attrs(struct ally_=
btn_sysfs_entry *entry)
> =20
>  static struct ally_btn_sysfs_entry *ally_create_button_attributes(struct=
 hid_device *hdev)
>  {
> +	const size_t entries_attr_index =3D ally_prefs.turbo_support ? 4 : 0;
>  	int i, ret;
> =20
> -	if (!ally_prefs.turbo_support)
> -		return NULL;
> -
>  	struct ally_btn_sysfs_entry *entries __free(kfree) =3D kzalloc_objs(*en=
tries, ALLY_BTN_MAX);
>  	if (!entries)
>  		return ERR_PTR(-ENOMEM);
> @@ -2441,13 +3258,33 @@ static struct ally_btn_sysfs_entry *ally_create_b=
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
> @@ -2465,6 +3302,11 @@ static struct ally_btn_sysfs_entry *ally_create_bu=
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
> =20
> @@ -2477,11 +3319,19 @@ static void ally_remove_button_attributes(struct =
hid_device *hdev)
>  	if (!entries)
>  		return;
> =20
> -	for (i =3D 0; i < ALLY_BTN_MAX; i++)
> +	/*
> +	 * Unpublish first. A mode-store notify holds the prefs lock and must
> +	 * see either the live array or NULL.
> +	 */
> +	ally_prefs.button_entries =3D NULL;
> +
> +	for (i =3D 0; i < ALLY_BTN_MAX; i++) {
>  		sysfs_remove_group(&hdev->dev.kobj, &entries[i].group);
> +		kfree(entries[i].remap_attr);
> +		kfree(entries[i].macro_attr);
> +	}
> =20
>  	kfree(entries);
> -	ally_prefs.button_entries =3D NULL;
>  }

[Severity: High]
Can this cause a lock ordering inversion and deadlock between
ally_prefs.lock and the sysfs kernfs active references on the button and
gamepad_mode attributes?

When userspace reads or writes the remap, macro, remap_available, or
gamepad_mode sysfs attributes, kernfs acquires an active reference on the
kernfs node before invoking button_remap_show(), button_remap_store(),
btn_remap_available_show(), or gamepad_mode_store(), which then acquire
ally_prefs.lock:

  kernfs_fop_read_iter() / kernfs_fop_write_iter()
    kernfs_get_active()                 /* acquires kn->active */
    button_remap_show() / button_remap_store() /
    btn_remap_available_show() / gamepad_mode_store()
      guard(mutex)(&ally_prefs.lock);   /* acquires ally_prefs.lock */

In the opposite direction, during device removal or error rollback in
ally_prefs_setup(), ally_prefs.lock is held while calling
sysfs_remove_group(), which drains active kernfs references:

  ally_sysfs_remove() / ally_prefs_setup()
    guard(mutex)(&ally_prefs.lock);     /* acquires ally_prefs.lock */
    ally_remove_button_attributes() / ally_create_button_attributes()
      sysfs_remove_group()
        __kernfs_remove()
          kernfs_drain()                /* waits for kn->active */

If a sysfs read or write is waiting to acquire ally_prefs.lock while
ally_sysfs_remove() or ally_prefs_setup() holds ally_prefs.lock and enters
kernfs_drain(), won't both threads block on each other?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031174130.2082=
40-1-denis.benato@linux.dev?part=3D12
