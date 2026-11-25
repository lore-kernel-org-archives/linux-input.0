Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795592075;
	b=5OKqaUQQY6yUmRaFfbamLphWTTv0Dnylkrrs6yu3xA1hZJJ3fJeKgwYRzQLhzQkPRX8C
	 4gHwGh0/xwUFOlaBc1P+HAs/KGYOiC6RvLX+yHL4+zUAxHmdW14uKmFq9kyFutZytv4Ih
	 0+Imj1ffxQlirWQwZomcAS8Ag0gapUN1m4XitAEiBk64k0NqA5T37t5QU/sDxjvpw4lrs
	 7nkv+EltyHfIdjafgF0A/52Fnbj/qXSF+j3Mx+GTkNSTb23Xq6bG0497YqFHt/a4ae75o
	 W/AVSCOxduOoOc5gs6kFALTdYiN1rTCsK+Wb7E15fg2ctp7a4IEpPFKo9P5GPFj4tww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795592075;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MKdKcr8+/21wc01D0JtVVzmA72lKLQDhn2zB0tQ7xw4=;
	b=rYEwjkjn1CrgH4mSXjv9sgQ7OABFlcESWmJlvdbik2sT1f7cbqEicHd/jVzoB+IVSncz
	 +yRiv3uzXsQSDdiNFWN/kRVvMut91XR78hnbIk8RPuiPbeNgDDjA04dwrZqt8+byNvAm/
	 Khf/5LjlbGy3LYq/hbmZp6p0JMs4Y+/Wz08nn3Y08fJ8EPAWFN6JWR/ROFckrF/cX8RhA
	 IB/0aIjjHti1bub18w/Cjm2n7fiqOVwGgDa7w0REfMVTnkEBuIvzBgzP0Qsl69FYSVtmu
	 Eg7eY4J7XrLYL6Z1RGDMdO9ifGdhz8NGuiLtDuk/522rZ/3JmcDCy4yvxAkVSQ1oDdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PnY6+qe5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFCE606A31E
	for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 07:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PnY6+qe5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 896151F000C6;
	Wed, 25 Nov 2026 07:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795592074;
	bh=MKdKcr8+/21wc01D0JtVVzmA72lKLQDhn2zB0tQ7xw4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PnY6+qe5dWSAEoa2Zjnj7ECrYcarfmJt6mCJsJ68w1rG+USCUH580SMAaX1HoyarN
	 wDpvoZZ2S4FyqqG22D2JO68zBKdLw5yPGgq+peBjq/VKznIZkizKqv6HK4ACFlyrnf
	 9U2P6Duyl6d0+ojjpf7RtYN8NcQmbqSr1qhjaRXX6YNVfEWd4v5OOvBnPzx1t+u77y
	 RZXYeWxwd5izHB8RkOUo4SHeIlM9mVVbxnrWVJEO08CI+39FA+lQU153++jF/3tr7F
	 XhkqJkO3MqZPoS+HnUZ6sTYRC6IQpyfdNz4RHOf0Os78YlxG+8WF/pcdYfHabwJa9F
	 lnQXTdLRpyL/g==
Message-ID: <sashiko-outbox-232815@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 8/9] HID: wacom: Benefit from pointer typed
 driver_data in hid_device_id
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@baylibre.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <23d19d751aea2d855bf1360fd4e84cc30d0fc8ca.1795589119.git.u.kleine-koenig@baylibre.com>
References: <cover.1795589119.git.u.kleine-koenig@baylibre.com>
 <23d19d751aea2d855bf1360fd4e84cc30d0fc8ca.1795589119.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 07:34:34 +0000
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
- [Low] HID: wacom: missed driver_data_ptr conversion in
  wacom_wireless_work()
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [Critical] HID: wacom: use-after-free in wacom_probe() [1]
--

commit 67663f15c12fe1c2768a835c0c04be50ea91f5c9
Author: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>

HID: wacom: Benefit from pointer typed driver_data in hid_device_id

This commit converts wacom_ids[] and its consumers from .driver_data to
.driver_data_ptr to avoid integer-to-pointer casts.

> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 2e3ce9b63d7af..d826a6b4d41e9 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -2657,7 +2657,7 @@ static void wacom_wireless_work(struct work_struct =
*work)
> =20
>  		/* Stylus interface */
>  		wacom_wac1->features =3D
> -			*((struct wacom_features *)id->driver_data);
> +			*(const struct wacom_features *)id->driver_data_ptr;
> =20
>  		wacom_wac1->pid =3D wacom_wac->pid;
>  		hid_hw_stop(hdev1);
> @@ -2670,7 +2670,7 @@ static void wacom_wireless_work(struct work_struct =
*work)
>  		    (wacom_wac1->features.type >=3D INTUOSHT &&
>  		    wacom_wac1->features.type <=3D BAMBOO_PT)) {
>  			wacom_wac2->features =3D
> -				*((struct wacom_features *)id->driver_data);
> +				*(const struct wacom_features *)id->driver_data;

[Severity: Low]
Should this touch interface assignment also use id->driver_data_ptr instead
of id->driver_data, matching the stylus interface assignment above?

>  			wacom_wac2->pid =3D wacom_wac->pid;
>  			hid_hw_stop(hdev2);
>  			error =3D wacom_parse_and_register(wacom2, true);
> @@ -2927,7 +2927,7 @@ static int wacom_probe(struct hid_device *hdev,
>  	struct wacom_features *features;
>  	int error;
> =20
> -	if (!id->driver_data)
> +	if (!id->driver_data_ptr)
>  		return -EINVAL;
> =20
>  	hdev->quirks |=3D HID_QUIRK_NO_INIT_REPORTS;
> @@ -2943,7 +2943,7 @@ static int wacom_probe(struct hid_device *hdev,
>  	wacom->hdev =3D hdev;
> =20
>  	wacom_wac =3D &wacom->wacom_wac;
> -	wacom_wac->features =3D *((struct wacom_features *)id->driver_data);
> +	wacom_wac->features =3D *(const struct wacom_features *)id->driver_data=
_ptr;
>  	features =3D &wacom_wac->features;
> =20
>  	if (features->check_for_hid_type && features->hid_type !=3D hdev->type)

[Severity: Critical]
This problem wasn't introduced by this patch, but can wacom_probe() cause a
use-after-free on wacom [1] if wacom_parse_and_register() fails after
hid_hw_start()?

wacom_probe() allocates wacom with devm_kzalloc_obj() and initializes
wacom->idleprox_timer and several work items without devres cleanup actions:

drivers/hid/wacom_sys.c:wacom_probe() {
    ...
	INIT_DELAYED_WORK(&wacom->init_work, wacom_init_work);
	INIT_DELAYED_WORK(&wacom->aes_battery_work, wacom_aes_battery_handler);
	INIT_WORK(&wacom->wireless_work, wacom_wireless_work);
	INIT_WORK(&wacom->battery_work, wacom_battery_work);
	INIT_WORK(&wacom->remote_work, wacom_remote_work);
	INIT_WORK(&wacom->mode_change_work, wacom_mode_change_work);
	timer_setup(&wacom->idleprox_timer, &wacom_idleprox_timeout, TIMER_DEFERRA=
BLE);
    ...
	error =3D wacom_parse_and_register(wacom, false);
	if (error)
		return error;
    ...
}

Once wacom_parse_and_register() calls hid_hw_start(), incoming events can
run wacom_wac_pen_event() and arm wacom->idleprox_timer or schedule work.
If a later step in wacom_parse_and_register() fails, only wacom->init_work
is canceled before wacom_probe() returns and devres frees wacom, leaving
any armed timer or other queued work to dereference freed memory.

[1] https://sashiko.dev/#/bug/linux-9d77fc11-57b4-4580-8967-6e5d9db474d3

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795589119.gi=
t.u.kleine-koenig@baylibre.com?part=3D8
