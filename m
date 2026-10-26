Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792973190;
	b=MdhgI/Yr+q7QWB58oa7MvlY9Fujr1r83jKjJcM/63fTzduPf9XPWXnpnWMa463hNePBn
	 1LebhXECiY/WBDua9HXibKTNY7vmAoTuWWDmcV3QqxYP3lODOobuNnnwTDPfuo8qNjwJJ
	 gW0ehk4GfbGjM0g4K7AznaIWfE3fwhs+T5cxlTuFGmCBmZXQ+KIsjjOGVPLoitJR2NHYN
	 i3cZjUk8hBQZ6EXrH/iMrS83hgIGmwyz8skxVw+wtGsumACQhHg/FA5yZk3R0NEY8h/sN
	 eAdQ490Zf4YBIWVdyoQniDQ1PcoXWupehEKXPGspxpzS8inAVC508BSfFdh6cglxwNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792973190;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=btY6sYmoKDsKuIhqtC0RAJd27zuhsbod2vAnuysbB+0=;
	b=lSJjr6UXHvbPaIhV7v+RouSm4wdD2GpPL6NkxPmpODZt8tz3JWI5xyS6D6P5mtQyJCM6
	 8jA7H2Eow2/ROrDJRJYpUtjxIp3L0Ggciq5a6kxtGJESs8xLKV5/EWW9y85pglOC3iW54
	 ZpKK8MP4uNFV3vqLZhDkU3LA7dQiRKi92dDvEdlynIGMv1PJgbBmYmKYrLrsSd65mYgmD
	 tJf80joIHsYc/1zg0FVGHSQFF1H8IcWTpT4E+RvzPPVNXeuJLWXxDesaquOsGvD494cQd
	 mn9yQHBUrWkU0Z09373w6xMUGR2oDnuM4QgRItvOrZsBgPDNqMt2BFRObW+eXOUjzDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=adKnVkpM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1913E606A31A
	for <linux-input@vger.kernel.org>; Mon, 26 Oct 2026 00:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=adKnVkpM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81FCE1F01825;
	Mon, 26 Oct 2026 00:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792973189;
	bh=btY6sYmoKDsKuIhqtC0RAJd27zuhsbod2vAnuysbB+0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=adKnVkpMUXbiRKZ056G0pXAkbXrJuLVKunaKDUtVl1UdN2H8mvS7JZWDG0UmU5d1h
	 7pmkbm2orhwN4MnG5t73H5KAe8nYUotL1661RJGPo0XAGFxWhW61j1oBBQSh2uAZAj
	 pEcIQD6AGh8fM+4IP8XeSt5MIehzY6lXsVB6Lgc2I7rNCgo295E+VCbSF94uT9LALb
	 ss0M/C6DrEjIh1tbt8Wmyt9kfCfwVYcLVBREhmZ6Jcp/pMyiO5OTjX7aLILvN4oDkY
	 Z8hah7Hf5uNgNzl8AuX+r7KBt7tamWWM5FPnDilK3IGa4uWIgu0tBPwCKZIau9/1pp
	 pDhbYtL/hVQVg==
Message-ID: <sashiko-outbox-184552@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 11/18] HID: asus: add support for btn remapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261025235232.129945-12-denis.benato@linux.dev>
References: <20261025235232.129945-1-denis.benato@linux.dev>
 <20261025235232.129945-12-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 00:06:29 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] HID: asus: race publishing button_entries in ally_create_button_=
attributes()
--

commit 72fcba2fa957c8a91f51c8bd2f81b7d77bbc08de
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: add support for btn remapping

This commit adds sysfs support for remapping physical buttons and macros on
ROG Ally handheld devices, including per-button remap_index attributes and
automatic cache refreshes when the gamepad mode changes.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index ed95b2cdec813..ea27495c3df66 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
[ ... ]
> @@ -1141,6 +1480,33 @@ static ssize_t gamepad_mode_store(struct device *d=
ev, struct device_attribute *a
> =20
>  	cfg->gamepad_mode =3D mode_byte;
> =20
> +	/*
> +	 * When the gamepad mode changes, the hardware automatically
> +	 * resets all button mappings to its internal defaults for the
> +	 * new mode.
> +	 *
> +	 * Refresh the software cache so that subsequent
> +	 * reads from sysfs reflect what the firmware is actually
> +	 * using.
> +	 */
> +	if (mode_byte =3D=3D ALLY_GAMEPAD_MODE_GAMEPAD)
> +		ally_set_default_gamepad_mapping(&cfg->button_mappings);
> +	else if (mode_byte =3D=3D ALLY_GAMEPAD_MODE_KEYBOARD)
> +		ally_set_default_keyboard_mapping(&cfg->button_mappings);
> +
> +	/*
> +	 * The re-defaulted mappings are what the remap and macro files
> +	 * report: wake anyone polling them about the new values.
> +	 */
> +	if (cfg->button_entries) {
> +		for (i =3D 0; i < ALLY_BTN_MAX; i++) {
> +			sysfs_notify(&dev->kobj, cfg->button_entries[i].group.name,
> +				     "remap");
> +			sysfs_notify(&dev->kobj, cfg->button_entries[i].group.name,
> +				     "macro");
> +		}
> +	}
[ ... ]
> @@ -2824,15 +3759,12 @@ static void ally_btn_turbo_init_attrs(struct ally=
_btn_sysfs_entry *entry)
>   * Return: 0 on success, negative errno on failure
>   */
>  static int ally_create_button_attributes(struct hid_device *hdev,
> -					 struct ally_handheld *ally,
> -					 struct ally_config *cfg)
> +					  struct ally_handheld *ally,
> +					  struct ally_config *cfg)
>  {
>  	struct ally_btn_sysfs_entry *entries;
>  	int i, ret;
> =20
> -	if (!cfg->turbo_support)
> -		return 0;
> -
>  	entries =3D kcalloc(ALLY_BTN_MAX, sizeof(*entries), GFP_KERNEL);
>  	if (!entries)
>  		return -ENOMEM;
> @@ -2845,13 +3777,53 @@ static int ally_create_button_attributes(struct h=
id_device *hdev,
>  		entries[i].hdev =3D hdev;
>  		entries[i].btn =3D i;
> =20
> -		if (!ally_btn_get_turbo_params(cfg, i)) {
> -			hid_err(hdev, "Invalid button id %d for turbo attributes\n", i);
> -			ret =3D -EINVAL;
> +		if (cfg->turbo_support) {
> +			if (!ally_btn_get_turbo_params(cfg, i)) {
> +				hid_err(hdev, "Invalid button id %d for turbo attributes\n", i);
> +				ret =3D -EINVAL;
> +				goto err_cleanup;
> +			}
> +
> +			ally_btn_turbo_init_attrs(&entries[i]);
> +		}
> +
> +		entries[i].remap_attr =3D button_remap_attr_create(ally, i, false);
> +		if (!entries[i].remap_attr) {
> +			ret =3D -ENOMEM;
>  			goto err_cleanup;
>  		}
> =20
> -		ally_btn_turbo_init_attrs(&entries[i]);
> +		entries[i].macro_attr =3D button_remap_attr_create(ally, i, true);
> +		if (!entries[i].macro_attr) {
> +			ret =3D -ENOMEM;
> +			goto err_cleanup;
> +		}
> +
> +		/* Initialize the remap_index attribute */
> +		sysfs_attr_init(&entries[i].attr_remap_index.attr);
> +		entries[i].attr_remap_index.attr.name =3D "remap_index";
> +		entries[i].attr_remap_index.attr.mode =3D 0444;
> +		entries[i].attr_remap_index.show =3D btn_remap_index_show;
> +		entries[i].attr_remap_index.store =3D NULL;
> +
> +		/* Set up attributes array based on what's supported */
> +		if (cfg->turbo_support) {
> +			entries[i].attrs[4] =3D
> +				&entries[i].remap_attr->dev_attr.attr;
> +			entries[i].attrs[5] =3D
> +				&entries[i].macro_attr->dev_attr.attr;
> +			entries[i].attrs[6] =3D
> +				&entries[i].attr_remap_index.attr;
> +			entries[i].attrs[7] =3D NULL;
> +		} else {
> +			entries[i].attrs[0] =3D
> +				&entries[i].remap_attr->dev_attr.attr;
> +			entries[i].attrs[1] =3D
> +				&entries[i].macro_attr->dev_attr.attr;
> +			entries[i].attrs[2] =3D
> +				&entries[i].attr_remap_index.attr;
> +			entries[i].attrs[3] =3D NULL;
> +		}
> =20
>  		entries[i].group.name =3D ally_button_names[i];
>  		entries[i].group.attrs =3D entries[i].attrs;
> @@ -2867,12 +3839,27 @@ static int ally_create_button_attributes(struct h=
id_device *hdev,
>  	return 0;
> =20
>  err_cleanup:
> +	/*
> +	 * Unpublish first: the readers of button_entries (like the
> +	 * gamepad_mode_store() cross-notification) hold config_mutex and
> +	 * must observe either the live array or NULL, never a freed one.
> +	 * The lock is released again before the removals, so a straggler
> +	 * callback waiting on it can drain against the not yet freed
> +	 * entries.
> +	 */
> +	scoped_guard(mutex, &cfg->config_mutex) {
> +		cfg->button_entries =3D NULL;
> +	}

[Severity: Medium]
Can gamepad_mode_store() observe a partially initialized cfg->button_entries
array while ally_create_button_attributes() is still running?

In hid_asus_ally_probe() -> ally_config_create(), ally->config is published
and ally_attr_groups[0] (which exposes gamepad_mode) is registered with
sysfs_create_group() before ally_create_button_attributes() is called:

drivers/hid/hid-asus.c:ally_config_create() {
	...
	spin_lock_irqsave(&ally_data_lock, flags);
	ally->config =3D cfg;
	spin_unlock_irqrestore(&ally_data_lock, flags);

	for (sysfs_i =3D 0; sysfs_i < ARRAY_SIZE(ally_attr_groups); sysfs_i++) {
		ret =3D sysfs_create_group(&hdev->dev.kobj,
					 &ally_attr_groups[sysfs_i]);
	...
	ret =3D ally_create_button_attributes(hdev, ally, cfg);
}

At the start of ally_create_button_attributes(), cfg->button_entries =3D en=
tries
is assigned without holding cfg->config_mutex and before the loop initializ=
es
entries[i].group.name and creates the sysfs groups:

drivers/hid/hid-asus.c:ally_create_button_attributes() {
	entries =3D kcalloc(ALLY_BTN_MAX, sizeof(*entries), GFP_KERNEL);
	if (!entries)
		return -ENOMEM;

	cfg->button_entries =3D entries;

	for (i =3D 0; i < ALLY_BTN_MAX; i++) {
		...
		entries[i].group.name =3D ally_button_names[i];
		...
}

If userspace writes to gamepad_mode while this loop is running (or before
err_cleanup acquires cfg->config_mutex on failure), gamepad_mode_store()
acquires cfg->config_mutex, sees a non-NULL cfg->button_entries, and iterat=
es
over all ALLY_BTN_MAX entries, racing with the unlocked writes to
entries[i].group.name and passing NULL as the directory name to
sysfs_notify() for entries that have not been initialized yet.

Should cfg->button_entries =3D entries instead be published under
cfg->config_mutex only after all ALLY_BTN_MAX groups have been initialized
and created?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025235232.1299=
45-1-denis.benato@linux.dev?part=3D11
