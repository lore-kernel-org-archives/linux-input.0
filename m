Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794276660;
	b=FxEzYTntSMu9Rf7IP2M4fjdDfZpx15EuoWfit0m+LNRmlba0UmLZ6HPjWLMlIPSde1BP
	 o1TlVKjZQu3EakiUP9mc624qOonENX612AoHPCXPuLF8+RRpGb/rSFTlSI3xmBEHK6xsW
	 tpMy2GREwChyMDIZ8uKzFH22ermVKY51zSaO5nABCWe/ZZXJG/bY146IzjcGsyP28vdoK
	 eVj4PfejJ0bXN1+gFVCOVnhLwmDK5wb0HRqi9ij2Hsj2QH6sjUSqyQIb7h6zGGTPI5RHJ
	 GpI+iDoMpPIQG7i//SOo7yxmSGR0PyJ0vzsPHfh/oNK4fdbey0rYmv9pugz7/CgvB0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794276660;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Nm4ZgpXZe8LYHGRORh3mxViY0i6kPZ5gFknPtQkTsYE=;
	b=zC/w5tsQ3+dDS4nygPG6NlTTBwh2qhcAyFNEx9ut3ecoFnPeYk/UOeDs3UtC5OcowFoQ
	 NnVnW4IeNFeJLHbZyi+daQxumxMeXw+JrMSBhCyZoqqgkggVO1+qtKlNCgB1BTVoqcpmV
	 SRAJU/Kfmz0jp/VKBHvh4+yYuLCRJbGK9tbEGjVorfsZgbcvJhMbgbzAa9ysiChRk9R3W
	 4A7ewt4NjvG0h+jYK2iecHlFdCigQAKNNNtdplm8gSZZ4SMrcMfjVqi8gbmIHfAfgG1ZU
	 nOS4NqsGTcSX5H4YYiJM7d/jgQJxg7K1miNdABvUHzYYCK5LcI+ehn0YxYhuoT07p/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OmoxcbI2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191FA606A31C
	for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 02:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OmoxcbI2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F991F0089F;
	Tue, 10 Nov 2026 02:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794276659;
	bh=Nm4ZgpXZe8LYHGRORh3mxViY0i6kPZ5gFknPtQkTsYE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OmoxcbI2+739gMPjYtkNzAu2R3ZRGEZ/FLS8J60wsdc11xpHoxrL0rSww7bXWhIdQ
	 6kQk0qNkIRfryLB6YuOZvR0+cmgyhRYOPoe6ZJTWxZcnKvnQBlch4Xccf5fLIRiceY
	 7C/E5YJkWSzBF01nkCHcsUzUEMfZJ++M1yNDc/qkGiftXhDCCLXq4Ovg2rqFILYcJF
	 Q08lIowusbiSe5VURZdrhPpj7BSd8bxlTZ9+py7DmFarxdYnSjEKOW5kvnJGzG7BUS
	 f4XApsuVdniVnSI4peEGEL8/zUDZH12eoWDmgsfFCy9hX80SnqpXjCHPzRJ1nT7yp+
	 7EzXW/6jRBJ4Q==
Message-ID: <sashiko-outbox-206031@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 11/18] HID: asus: add support for turbo buttons
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261110020036.112884-12-denis.benato@linux.dev>
References: <20261110020036.112884-1-denis.benato@linux.dev>
 <20261110020036.112884-12-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 02:10:59 +0000
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
- [Low] HID: asus: mix of cleanup helpers and goto in
  ally_create_button_attributes()
--

commit be0ac16d9e727b97dff90265fa1d63aeee90736b
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: add support for turbo buttons

This commit adds sysfs attributes to configure per-button turbo and toggle
periods on ROG Ally devices and restores those parameters during device
initialization.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 3a149f54a6ac8..b5a1466d327bf 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
[ ... ]
> @@ -2144,8 +2223,261 @@ static const struct attribute_group ally_attr_gro=
ups[] =3D {
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
This isn't a bug, but ally_create_button_attributes() mixes __free(kfree) on
entries with goto ally_btn_err_cleanup error unwinding, contrary to the
cleanup.h convention against mixing scope-based cleanup with goto labels in
the same function. Since ally_btn_err_cleanup already unwinds the sysfs
groups on failure, entries could be freed explicitly with kfree(entries) in
the error path instead of using __free(kfree) and no_free_ptr().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110020036.1128=
84-1-denis.benato@linux.dev?part=3D11
