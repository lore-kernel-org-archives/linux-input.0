Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D0E485CDC
	for <linux-input@vger.kernel.org>; Thu, 13 Aug 2026 15:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786633978; cv=none; b=jj33DSM6IItrxWQqVaCzP7ks1dyQ8WGqI/YdAATMEV9GHXz8Jz69JCQynxjSNs1uBMmheJxlVgs5/j1kpZnK7EBU8Xtp0h22iU8+mgBddZY5vucijW4eCrkWPmvZCU9FAaFvPud4uFpTBN2LwYwPKfVREU+PHXS16mZ0lmQ9Wx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786633978; c=relaxed/simple;
	bh=TeVNRwq3VEnTqjlDVW1nFjbqoU/bFFXrV1OSYFAQxb0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fWlYDjHLLmuCxQqDxyyYZOABBc7ZlpnHA0Wg+qrraOLgMiB83E+pTptqXarZAwI3GWiNLgTOIvRFlf3AhVGggVy4Uj8p2Haf462OAzSkOtjulxkSSEhqUMfN5Tsh212X23nHLG3rYVttFLmvb2zFhXb1a2MvlKOJnO0lntf1jXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAjTdvou; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAjTdvou"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BCCC1F000E9;
	Thu, 13 Aug 2026 15:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786633976;
	bh=Ge7vEbU2EqhMcbDOaI1HcTXKxoEknZD+8nf4DSMRMtM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HAjTdvouB4qd+K5Speh9FwcsP31w/9HGETPh7vlyuG7RhF9fcyvZz5ImYm4qVefdh
	 iAQMKH6/tRzTI75ADWb8nDlxZIt7zm6uGgSlcYEqRo9mPvMCoW3K6lYAsLqhaiSfya
	 Xkah6/KTzwS+APIGRzyvP6NeiNiAVhKsZAdv2GQ3c0OJyaslZXxtih4E6D51bF6Odb
	 r5LKSgMuNi6Gx34Sw1BCZNk+FxtQBzX/4qx2qKO21Nmw2GbmryvlDRB8DtNrew9xuM
	 o/i75B7srRUloTX3qHxi+c+bLOd64usUsLN5NoswJVaFHs7ZvWlyy2B6t5a0P9qsdf
	 ZO4cvrhGT/FSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/12] HID: asus: add support for btn remapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260813144736.2477941-13-denis.benato@linux.dev>
References: <20260813144736.2477941-1-denis.benato@linux.dev>
 <20260813144736.2477941-13-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 15:12:55 +0000
Message-Id: <20260813151256.1BCCC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Use-After-Free (UAF) in sysfs store functions due to manual lockle=
ss deallocation of button mappings.
- [High] Sysfs attributes are exposed before `gamepad_mode` initialization,=
 causing a reproducible NULL pointer dereference.
- [Medium] Hardware update errors are silently swallowed for non-Ally X dev=
ices, and the software cache is permanently corrupted on failure.
- [Medium] Button remapping sysfs attributes are entirely inaccessible for =
devices lacking turbo support.
- [Medium] Time-of-Check to Time-of-Use (TOCTOU) race condition in `button_=
remap_store` bypasses validation.
--

--- Patch [12]: [PATCH 12/12] HID: asus: add support for btn remapping ---
commit d94c33db2e53bcd63e5e7044bbdf330bf4916ffa
Author: Denis Benato <denis.benato@linux.dev>
Subject: HID: asus: add support for btn remapping

Add support for buttons remapping: the ability to assign different
button events to each one of the physical button on the device.

[ ... ]

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 359832395afec..5b744dba98d3e 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c

[ ... ]

> @@ -2528,29 +3311,78 @@ static struct ally_btn_turbo_attr *ally_btn_turbo=
_attr_create(struct hid_device
> +static ssize_t button_remap_show(struct device *dev,
> +				 struct device_attribute *attr, char *buf)
> +{
> +	struct hid_device *hdev =3D to_hid_device(dev);
> +	struct asus_drvdata *drvdata =3D hid_get_drvdata(hdev);
> +	struct ally_handheld *ally =3D drvdata->rog_ally;
> +	struct button_remap_attr *btn_attr =3D to_button_remap_attr(attr);
> +	struct ally_config *cfg;
> +	enum ally_button_id button_id =3D btn_attr->button_id;
> +	enum btn_pair_index pair_idx;
> +	bool is_first;
> +	struct button_pair_map *pair;
> +	struct button_map *btn_map;
> +	int ret;
> +
> +	if (!ally || !ally->config)
> +		return -ENODEV;
> +
> +	cfg =3D ally->config;
> +
> +	ret =3D get_button_pair_info(button_id, &pair_idx, &is_first);
> +	if (ret < 0)
> +		return ret;
> +
> +	guard(mutex)(&cfg->config_mutex);
> +	pair =3D &((struct ally_button_mapping
> +			  *)(cfg->button_mappings))[cfg->gamepad_mode]
> +			.button_pairs[pair_idx - 1];
> +	btn_map =3D is_first ? &pair->first : &pair->second;
> +
> +	if (btn_attr->is_macro) {
> +		if (btn_map->macro->type =3D=3D BTN_TYPE_NONE)

[Severity: High]
Could btn_map->macro be NULL here during device initialization?

When ally_create_button_attributes() registers the sysfs groups,
cfg->gamepad_mode is 0 by default. It is not set to 1 (Gamepad) until later
in the probe sequence.

If a user reads the remap or macro sysfs files before cfg->gamepad_mode is
updated, this will index cfg->button_mappings[0]. Since only indexes 1 and 2
are populated by ally_set_default_gamepad_mapping() and
ally_set_default_keyboard_mapping(), the pointers in index 0 remain
uninitialized. Dereferencing btn_map->macro->type would then cause a kernel
panic.

> +			return sysfs_emit(buf, "NONE\n");
> +		else
> +			return sysfs_emit(buf, "%s\n", btn_map->macro->name);
> +	} else {
> +		if (btn_map->remap->type =3D=3D BTN_TYPE_NONE)
> +			return sysfs_emit(buf, "NONE\n");
> +		else
> +			return sysfs_emit(buf, "%s\n", btn_map->remap->name);
> +	}
> +}

[ ... ]

> +static ssize_t button_remap_store(struct device *dev,
> +				  struct device_attribute *attr,
> +				  const char *buf, size_t count)
> +{

[ ... ]

> +	ret =3D get_button_pair_info(button_id, &pair_idx, &is_first);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Validate that the remap target is allowed for this button/mode */
> +	if (!ally_remap_code_valid(button_id, cfg->gamepad_mode, code))
> +		return -EINVAL;
> +
> +	scoped_guard(mutex, &cfg->config_mutex) {
> +		/* Access the mapping for current gamepad mode */
> +		pair =3D &((struct ally_button_mapping
> +				  *)(cfg->button_mappings))[cfg->gamepad_mode]

[Severity: Medium]
Is there a Time-of-Check to Time-of-Use (TOCTOU) race condition here?

The validation function ally_remap_code_valid() reads cfg->gamepad_mode
locklessly. If a concurrent sysfs write to gamepad_mode_store() alters the
mode right before cfg->config_mutex is acquired, an invalid mapping could
bypass the checks and be written to the new mode's configuration.

> +				.button_pairs[pair_idx - 1];
> +		btn_map =3D is_first ? &pair->first : &pair->second;
> +
> +		if (btn_attr->is_macro)
> +			btn_map->macro =3D (struct btn_code_map *)code;
> +		else
> +			btn_map->remap =3D (struct btn_code_map *)code;
> +
> +		/* Update pair index */
> +		pair->pair_index =3D pair_idx;
> +
> +		/*
> +		 * Send mapping to device with the caveat that first generation
> +		 * devices require individual button pair updates.
> +		 */
> +		if (cfg->is_ally_x) {
> +			ret =3D ally_set_button_mapping(hdev, ally, pair);
> +			if (ret < 0)
> +				return ret;
> +		} else {
> +			mode_map =3D &((struct ally_button_mapping
> +					 *)(cfg->button_mappings))[cfg->gamepad_mode];
> +			for (i =3D 0; i < 9; i++) {
> +				mode_map->button_pairs[i].pair_index =3D i + 1;
> +				ret =3D ally_set_button_mapping(hdev, ally,
> +					&mode_map->button_pairs[i]);
> +				if (ret < 0)
> +					break;
> +			}
> +		}
> +	}
> +
> +	return count;
> +}

[Severity: Medium]
For non-Ally X devices, if ally_set_button_mapping() fails, this loop breaks
but then unconditionally returns count (success) instead of ret.

Also, earlier in this block, the software cache is updated:

    if (btn_attr->is_macro)
        btn_map->macro =3D (struct btn_code_map *)code;
    else
        btn_map->remap =3D (struct btn_code_map *)code;

If the hardware update fails, does this mean the software cache is now
permanently desynchronized from the actual hardware state?

[ ... ]

> @@ -2528,29 +3311,78 @@ static struct ally_btn_turbo_attr *ally_btn_turbo=
_attr_create(struct hid_device
>  static int ally_create_button_attributes(struct hid_device *hdev, struct=
 ally_config *cfg)
>  {
>  	struct ally_btn_sysfs_entry *entries;
> +	struct ally_button_mapping *mappings;
>  	int i, ret;
> =20
> -	if (!cfg->turbo_support)
> -		return 0;
> -

[Severity: Medium]
Even though this check is removed here, does the caller (ally_config_create=
())
still restrict the creation of these attributes based on cfg->turbo_support?

If ally_create_button_attributes() is only called when cfg->turbo_support is
true, then devices without turbo support will not have access to the button
remapping sysfs attributes either.

>  	entries =3D devm_kcalloc(&hdev->dev, ALLY_BTN_MAX, sizeof(*entries), GF=
P_KERNEL);

[ ... ]

> @@ -2598,8 +3439,16 @@ static void ally_remove_button_attributes(struct h=
id_device *hdev, struct ally_c
>  	for (i =3D 0; i < ALLY_BTN_MAX; i++) {
>  		sysfs_remove_group(&hdev->dev.kobj, &entries[i].group);
>  		kfree(entries[i].turbo_attr);
> +		kfree(entries[i].remap_attr);
> +		kfree(entries[i].macro_attr);
> +	}
> +
> +	if (cfg->button_mappings) {
> +		devm_kfree(&hdev->dev, cfg->button_mappings);
> +		cfg->button_mappings =3D NULL;
>  	}

[Severity: High]
Can this cause a use-after-free if sysfs files are accessed concurrently?

The teardown path frees cfg->button_mappings manually using devm_kfree()
without holding cfg->config_mutex.

If a user writes to gamepad_mode_store() or button_remap_store() right as
this is being freed, it could lead to memory corruption or a kernel panic,
as those functions dereference cfg->button_mappings.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813144736.2477=
941-1-denis.benato@linux.dev?part=3D12
