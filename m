Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793976124;
	b=DaKdVrYX963QBaHAS3j4N/kEm2BVBcpzfJsxz4cwbjNHNIl5F6gcJa8YIPnol7vyZZ92
	 uRup7mOoFZAJinaEqpBxdu9JtAfkOqo+MgtbqAD0mZ+AknnbawG0SgegN6o1EbHsNOpMe
	 FB/24fnfw+4FvtXr+Y7hZwMUzmWtJMcRIMJwUbD5435eoWZ2zWGG6mRhOG6wdyZGBMZZ3
	 OoauRNXXdsrpE0XvJgjXmFgRZsf82PY37BbMvjXm6e7PQOfWUmBQ5qBidPZrTXBekvQn4
	 7XpulQ2dhfQTQvTl5S1b+Jbzj0VMxNPcdaNHI33HdwI2kQ0WRmr7gIKXdkFTkhuz5Eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793976124;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0aq+Q+tH+20HuxVM9aUa787stDzEDhfrTiNvt1xDlRY=;
	b=G1ygrhRwH4BLjiZ9lha2vQHWh/u45e3F2WUXakvV3FYUFD00n8Nc+9J6op87mNd27ggt
	 ots/7MfY2tCkq7uJjsIppsH/Q83DKJ7HVbnYRtDBEGh0gHVN/O8Das0r/vipFjjxoIsVn
	 NIcu3i6KdjO+gZCoJ9MQiZvBP8OGD8vzWZcx7ZsRvGxgdu9q6EbQ2/FBum3e9jHt3zdxp
	 tYhd9UeBCyUvainvZVor1XBSAaPE6ISIo2dUX0Jz6HJHYLL/Gal4PPwaHjh29Hm6xpMA8
	 ZB+z/GnyAF3QpBwq2EcOjyiWmLfBeZa1hdJB7uwY5C9/Yj3rqk9DJ6eQPrOdIfCY3Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="gFnPd/3R";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C618A606A326
	for <linux-input@vger.kernel.org>; Fri,  6 Nov 2026 14:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gFnPd/3R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 219061F008A1;
	Fri,  6 Nov 2026 14:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793976123;
	bh=0aq+Q+tH+20HuxVM9aUa787stDzEDhfrTiNvt1xDlRY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gFnPd/3RvkIauHZwxVtEg78WcWmc8W8PK571X79/neGm3B/GNW9jX41zbjfXWNa/2
	 W9VS+MQmETz72D/xvhKSAJ4xGKeLl3mRQWkFUNgiDijRuaHbpdwPhynHFXGZWB7Cfr
	 n7V4r3CFW7Zcka1rZJTJZloI4OaqDrMpTniH5Xr9ByH4abeIiTEdxLqZ95PWv7swGn
	 6U8KGm1EUVCvd6SVCL8A1bf48ip7T2pC0zy8/+itbuhtLD6Wa3eXWp/GRv7M4GR236
	 aO+oirKs3YGe5SUurKYEVGhFL/DQVtC251KAhpTe2HyhMFnt9ujr3/v87xicq3KoBK
	 V0wPLjpf9x7aA==
Message-ID: <sashiko-outbox-201599@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 11/18] HID: asus: add support for turbo buttons
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261106142334.1881-12-denis.benato@linux.dev>
References: <20261106142334.1881-1-denis.benato@linux.dev>
 <20261106142334.1881-12-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 14:42:01 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Low] HID: asus: mix of cleanup helpers and goto in
  ally_create_button_attributes()
- [Low] HID: asus: per-call stack lookup table in ally_btn_param()
--

commit 41d2b47a8b98d8711a6cf26beaa8f9fb7b5092d2
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: add support for turbo buttons

This commit adds sysfs attributes to configure per-button turbo and toggle
periods on ROG Ally devices and restores those parameters on device
initialization.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index cf33ccefcc2b3..c0c337a5fcba9 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c

[ ... ]

> @@ -2143,8 +2222,261 @@ static const struct attribute_group ally_attr_gro=
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
This isn't a bug, but table[] holds fixed pointers into the static
ally_prefs.turbo struct and is rebuilt on the stack on every call.  Could it
be declared static const like the other lookup tables in this file?

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

[Severity: Low]
This isn't a bug, but ally_create_button_attributes() mixes __free(kfree)
with goto ally_btn_err_cleanup, contrary to the cleanup.h guideline against
combining scope-based cleanup helpers and goto error handling in the same
function.  Since ally_btn_err_cleanup already unwinds the loop on failure,
entries could be freed explicitly with kfree(entries) there instead of using
__free(kfree) and no_free_ptr().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106142334.1881=
-1-denis.benato@linux.dev?part=3D11
