Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793757133;
	b=Q/6tgp29ijonC8LbsFlnlyNG5YgFb/RPsGyx2sGtlueFqMEaX24TXRb+MpM4lxk2XPja
	 MD7fsaXTC7xeIAfBOL+eVjKKi8THPp3JBk8uC4iZf7Wr2F6R8/EiREzdY7QhpzBR6IBc4
	 zGqcp2tyLEeOV/mIYbzXQaEQrnRZo3kS6PAKsjZZMuIhFBjfWNIpk3Ygs5/Azgpq7qMVb
	 1ZPEiufgZ/hQdNX2GNm9LSIceiMLGdA1YuUCvCB4BV5F60wMxay5+fBD/g+9zTid0BAon
	 uAgbb+Q4LsESnXTx1B9gLMtlZGMUbrMvt38V0Qs0bUcXifX7e04yM8718UkUKKmIczA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793757133;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/NoJujnjWmv6fzRjGFozLC6UqWgpHfXA3pbPL6NPm5E=;
	b=pdDGmnsX1xnZYSkSSOjERavfpSTTWsWT/yuMeD+V7N/QcBMVNDCZVHaDERJNO871RLvG
	 Vn2ReqbUfA0KUjQA3dsCFtyqIMTH7hP/Ktt40xW8iSVwdMrlLa+Bx/kDpzYyOyrf4vPUf
	 N3VnXOL+VNNf9Wc0aTvdSiWHyUFJCMouJNM8k6ekrIi7qh4A7Bf3TkIYTHPNewkpXXjMV
	 6/EZI/IWCSvlmN4BIQREM7eZk2kqghrgGBjI8vjGijYt/pfPfvjUIyWCre/rqfFUPngx5
	 aDnncdVYhEh3u2R8ouFVl/nt/4YkJ03PqNbK8Ly+etv/lU9qkXRS19YtcKkKd6GleRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Oc4o/Vz0";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E254606A31B
	for <linux-input@vger.kernel.org>; Wed,  4 Nov 2026 01:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oc4o/Vz0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7A0F1F000C1;
	Wed,  4 Nov 2026 01:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793757133;
	bh=/NoJujnjWmv6fzRjGFozLC6UqWgpHfXA3pbPL6NPm5E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Oc4o/Vz0Y3KGhDCdGPlFGECfnvpvHoPHh88Uf80/SguAt0bOhcWMbb5HggM4QZlm3
	 31R62Ix1xDRJlJmnFwY91VMkvbh5d3q3VJ1Rk0Utib3mmAOxMPm1l+2JiZkq0v/C6n
	 i5f8/+slUGN0RE3QEEuxxKfy47L5TNF/upjMG7Grt2MV/BryunXy7j0n8gYNtQ7Jyb
	 Z8HwzGtyungFAWGdIF3KS0Yhs/1MzwIqQmJcBBnOOl72ro3sqjJZcDj/+by/SZ2cyn
	 irTUvzOK7zXzInb7iSe9349yTkNKeZ0rcvB8Py986yNd0590uPCZ3Fi4yp9DYZQ5dV
	 znUC9ZeLeyNyA==
Message-ID: <sashiko-outbox-196388@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 11/18] HID: asus: add support for turbo buttons
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261104013935.512713-12-denis.benato@linux.dev>
References: <20261104013935.512713-1-denis.benato@linux.dev>
 <20261104013935.512713-12-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 01:52:12 +0000
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
- [Medium] HID: asus: unlocked read of turbo period in ally_btn_period_show=
()
- [Low] HID: asus: mix of cleanup helpers and goto in ally_create_button_at=
tributes()
- [Low] HID: asus: non-static lookup table on stack in ally_btn_param()
--

commit 3795dba8be2afc39142aa94e1d2e669448280abb
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: add support for turbo buttons

This commit adds support for configuring ROG Ally turbo and toggle button
periods via per-button sysfs attribute groups and restores these settings on
controller initialization.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index d3dbeba529c12..70c9d71fc5fa9 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c

[ ... ]

> @@ -2132,8 +2211,252 @@ static const struct attribute_group ally_attr_gro=
ups[] =3D {
>  	},
>  };
> =20
> +static struct ally_btn_turbo_params *ally_btn_param(enum ally_button_id =
btn)
> +{
> +	struct ally_btn_turbo_params *table[ALLY_BTN_MAX] =3D {
> +		[ALLY_BTN_A] =3D &ally_prefs.turbo.btn_a,
> +		[ALLY_BTN_B] =3D &ally_prefs.turbo.btn_b,
> +		[ALLY_BTN_X] =3D &ally_prefs.turbo.btn_x,
> +		[ALLY_BTN_Y] =3D &ally_prefs.turbo.btn_y,
> +		[ALLY_BTN_LB] =3D &ally_prefs.turbo.btn_lb,
> +		[ALLY_BTN_RB] =3D &ally_prefs.turbo.btn_rb,
> +		[ALLY_BTN_DU] =3D &ally_prefs.turbo.btn_du,
> +		[ALLY_BTN_DD] =3D &ally_prefs.turbo.btn_dd,
> +		[ALLY_BTN_DL] =3D &ally_prefs.turbo.btn_dl,
> +		[ALLY_BTN_DR] =3D &ally_prefs.turbo.btn_dr,
> +		[ALLY_BTN_J0B] =3D &ally_prefs.turbo.btn_j0b,
> +		[ALLY_BTN_J1B] =3D &ally_prefs.turbo.btn_j1b,
> +		[ALLY_BTN_MENU] =3D &ally_prefs.turbo.btn_menu,
> +		[ALLY_BTN_VIEW] =3D &ally_prefs.turbo.btn_view,
> +		[ALLY_BTN_M1] =3D &ally_prefs.turbo.btn_m1,
> +		[ALLY_BTN_M2] =3D &ally_prefs.turbo.btn_m2,
> +	};
> +
> +	if (btn >=3D ALLY_BTN_MAX)
> +		return NULL;
> +
> +	return table[btn];
> +}

[Severity: Low]
As reported by Sashiko on v12 [1], in ally_btn_param() in
drivers/hid/hid-asus.c, table[ALLY_BTN_MAX] maps enum ally_button_id
values to fixed addresses inside the file-scope ally_prefs.turbo struct,
but it is not declared static const. As a result, the 16-pointer lookup
array is reconstructed on the stack on every sysfs show, store, and setup
call.

Could table be declared static struct ally_btn_turbo_params *const to
match the other lookup tables in this driver?

[ ... ]

> +static ssize_t ally_btn_period_show(struct ally_btn_sysfs_entry *entry, =
char *buf,
> +				    enum ally_btn_period which)
> +{
> +	struct ally_btn_turbo_params *params;
> +
> +	scoped_guard(mutex, &ally_prefs.lock) {
> +		if (!ally_prefs.turbo_support)
> +			return -EOPNOTSUPP;
> +
> +		params =3D ally_btn_param(entry->btn);
> +		if (!params)
> +			return -ENODEV;
> +	}
> +
> +	return sysfs_emit(buf, "%hhu\n", *ally_btn_period_field(params, which));
> +}
> +
> +static ssize_t ally_btn_period_store(struct device *dev,
> +				     struct ally_btn_sysfs_entry *entry,
> +				     const char *buf, size_t count,
> +				     enum ally_btn_period which, u8 max,
> +				     const char *name)
> +{
> +	struct hid_device *hdev =3D to_hid_device(dev);
> +	struct ally_btn_turbo_params *params;
> +	u8 old_value, value, *field;
> +	int ret;
> +
> +	ret =3D kstrtou8(buf, 10, &value);
> +	if (ret)
> +		return ret;
> +	if (value > max)
> +		return -EINVAL;
> +
> +	scoped_guard(mutex, &ally_prefs.lock) {
> +		if (!ally_prefs.turbo_support)
> +			return -EOPNOTSUPP;
> +
> +		params =3D ally_btn_param(entry->btn);
> +		if (!params)
> +			return -ENODEV;
> +
> +		field =3D ally_btn_period_field(params, which);
> +		old_value =3D *field;
> +		*field =3D value;
> +
> +		ret =3D ally_set_turbo_params(hdev);
> +		if (ret) {
> +			*field =3D old_value;
> +			return ret;
> +		}
> +	}

[Severity: Medium]
In ally_btn_period_show() in drivers/hid/hid-asus.c, scoped_guard(mutex,
&ally_prefs.lock) only covers checking ally_prefs.turbo_support and
fetching the params pointer into ally_prefs.turbo via ally_btn_param().
The mutex is released when the scoped_guard block exits, before
sysfs_emit() dereferences *ally_btn_period_field(params, which).

Meanwhile, ally_btn_period_store() modifies *field in-place inside
ally_prefs.turbo under ally_prefs.lock before blocking on the feature
report transfer in ally_set_turbo_params(hdev), and rolls *field back to
old_value if that transfer fails.

Can a concurrent read on turbo_period or toggle_period race with
ally_btn_period_store() and observe an uncommitted value that is
subsequently rolled back on error? Should ally_btn_period_show() use
guard(mutex)(&ally_prefs.lock) (or read the byte into a local variable
inside the guarded scope) so the read is serialized by ally_prefs.lock?

[ ... ]

> +static struct ally_btn_sysfs_entry *ally_create_button_attributes(struct=
 hid_device *hdev)
> +{
> +	int i, ret;
> +
> +	scoped_guard(mutex, &ally_prefs.lock)
> +		if (!ally_prefs.turbo_support)
> +			return NULL;
> +
> +	struct ally_btn_sysfs_entry *entries __free(kfree) =3D kzalloc_objs(*en=
tries, ALLY_BTN_MAX);
> +	if (!entries)
> +		return ERR_PTR(-ENOMEM);
> +
> +	for (i =3D 0; i < ALLY_BTN_MAX; i++) {
> +		entries[i].btn =3D i;
> +
> +		if (!ally_btn_param(i)) {
> +			hid_err(hdev, "Invalid button id %d for turbo attributes\n", i);
> +			ret =3D -EINVAL;
> +			goto ally_btn_err_cleanup;
> +		}
> +
> +		ally_btn_turbo_init_attrs(&entries[i]);
> +		entries[i].group.name =3D ally_button_names[i];
> +		entries[i].group.attrs =3D entries[i].attrs;
> +
> +		ret =3D sysfs_create_group(&hdev->dev.kobj, &entries[i].group);
> +		if (ret < 0) {
> +			hid_err(hdev, "Failed to create sysfs group for %s: %d\n",
> +				ally_button_names[i], ret);
> +			goto ally_btn_err_cleanup;
> +		}
> +	}
> +
> +	return no_free_ptr(entries);
> +
> +ally_btn_err_cleanup:
> +	while (i--)
> +		sysfs_remove_group(&hdev->dev.kobj, &entries[i].group);
> +
> +	return ERR_PTR(ret);
> +}

[ ... ]

> @@ -2192,7 +2515,15 @@ static int ally_prefs_setup(struct hid_device *hde=
v, struct ally_intf *intf)
>  		}
>  	}
> =20
> +	entries =3D ally_create_button_attributes(hdev);
> +	if (IS_ERR(entries)) {
> +		ret =3D PTR_ERR(entries);
> +		hid_err(hdev, "Failed to create button attributes: %d\n", ret);
> +		goto err_cal_groups;
> +	}
> +
>  	scoped_guard(mutex, &ally_prefs.lock) {
> +		intf->button_entries =3D entries;
>  		intf->cal_sysfs_live =3D cal_live;
>  		intf->sysfs_live =3D true;
>  	}

[Severity: Low]
As reported by Sashiko on v12 [2], in ally_create_button_attributes() in
drivers/hid/hid-asus.c, scope-based cleanup helpers (scoped_guard and
entries __free(kfree)) are mixed with goto ally_btn_err_cleanup in the
same function, and ally_prefs_setup() similarly mixes scoped_guard with
goto err_cal_groups.

The kernel cleanup API conventions require not mixing scope-based cleanup
helpers with goto-based error handling within the same function. Could
ally_create_button_attributes() either avoid goto (for example by calling
 a helper to unwind the created groups before returning Directly) or manage
entries with explicit kfree() on the error path?

[1] https://lore.kernel.org/r/20261031174130.208240-12-denis.benato@linux.d=
ev
[2] https://lore.kernel.org/r/20261031174130.208240-12-denis.benato@linux.d=
ev

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104013935.5127=
13-1-denis.benato@linux.dev?part=3D11
