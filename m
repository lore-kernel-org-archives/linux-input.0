Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793976373;
	b=y8VyVVTkgm+U7VBPuXdKqMDOZ7xyt23qKdBQOOHU+Ps7Td3/h4XwMNVaOYcp478lH0DQ
	 DSmofjaC/82Pvo/U8AJq/N7tBR+x9wi0l4GSTwqDYzTobXPMZDGdW5DZtHkbQHvHISbuy
	 NtbmD2vHSoWK3WvOeNPpDZD1+tIgN/pyvDVn+sM3X9v1yp6m4H1O4IVZOXcHfx+XB8tTF
	 qqL3N/OIfxWp99iUZjS+nstCoN/Vacw/R/oDLse5LLXOwkPa5W0dva7aRyymFEsF5UMzN
	 MrR7Y0Zz4aly6BntHYCMktk7JBvrgjI1Q3MPiqGAJr1CEkOdjrIcMbLqm4knJkUFIyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793976373;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=thwgJWKxJb2iKxHm16F1Un53WxbapXefJ54vaAgPNJk=;
	b=v/E2WM5AYJ0NrSPa6l5sSzMJG7pJlFZccGXxHRITSGOE+ZXi1rrGV6CJzNm+uOg5BBXB
	 p2mG6aJIpWxI/bY7Ccc0LIh1YRcJG3qyZMA2PyrMQFzsrOEom2WqkOLGNwbxxdxTROFGY
	 40j9NFZv4RZPwdm97jdbxUPtOHqalayWjJ/puZpAG02uoOYcqLZa0d3lGwNqfyA2vl7P+
	 jHwlsUkXpHSFJV2e18RLeJNhUXMIqIAjqNY97H0B/SfDXEmQgEyJUZDTW/fB5fOsjB1L6
	 6qtSC3sM2IVe2DpHFyqYE2dQdnj87JVXWmJqWaXIOeOKgcGUz1SFuah9M3w0OjhpILA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hsDNsPJ9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37AE606A32D
	for <linux-input@vger.kernel.org>; Fri,  6 Nov 2026 14:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hsDNsPJ9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 360EB1F0089F;
	Fri,  6 Nov 2026 14:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793976372;
	bh=thwgJWKxJb2iKxHm16F1Un53WxbapXefJ54vaAgPNJk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hsDNsPJ9xw4gVdDwqDo63IM/HXIgjbKTtOLSaKeEZDM+TEMJGEkS7O5ZraIOuDX5E
	 d7DlLlJGesd7U/ox7N/pc0RJhB6Z0a16p46hf/cyOKntb+2XXxRDWwE2lhpn5Ls87h
	 ZrqQ1Z+Rosb1d/i/nCP8lB63h0Q3M76bpAjWbBjcvXg8QN67JB9uPGt6fqOi0AGJX7
	 uLeuvzJxRoetrceGLrJCxHaJPBwhkZWXJlLEo8FaMogrI9DLT3yVMzS/EorcPt69Jo
	 wo2RX/z9DnqbB7+Ta73LVEk4I8Psd6/tW2OXjHgMQmZtght+Hjwo9yOPFOh5n5uirC
	 G9A2Xnd0H3L4Q==
Message-ID: <sashiko-outbox-201604@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 12/18] HID: asus: add support for btn remapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261106142334.1881-13-denis.benato@linux.dev>
References: <20261106142334.1881-1-denis.benato@linux.dev>
 <20261106142334.1881-13-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 14:46:11 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] HID: asus: mixed cleanup helpers and goto in
  button_remap_store()
--

commit 0fe51bd4cd86b318227ccb9c127184422216243c
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: add support for btn remapping

This commit adds sysfs attributes and firmware command support for button
and macro remapping on ASUS ROG Ally handheld devices.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index c0c337a5fcba9..cb6c55e75e6ee 100644
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

[Severity: Low]
This isn't a bug, but button_remap_store() mixes guard(mutex) with
goto-based error handling (err_restore_hw, err_restore, err_out).
Likewise, ally_create_button_attributes() below mixes __free(kfree) on
entries with goto ally_btn_err_cleanup.  The cleanup.h convention is to
avoid mixing scope-based cleanup helpers and goto unwinding within the
same function.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106142334.1881=
-1-denis.benato@linux.dev?part=3D12
