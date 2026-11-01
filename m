Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793512384;
	b=OzWD8CV2/ppCzBJHiGxBQwujkFiq0vKIVINHSPcFmS2kmt/7la+4UWnfZmd/HL/L2PK/
	 kThgmrrAQdDj3/KNFAu942ZTQq+WxK4vMvfwnQ/yrApm+Z6aXR1XuOGAOyZjieDyxThnZ
	 9N00+R75MuxtJggsnHtdZ/OaMPSix8ciU6B3agyezEbFQNdsFRfaNVd7II993+cumCJxm
	 3VTtdzvb82i+1f37sf5zzgC99ciAiGxU/Pgb/Bkcy//gWpur5nUyv5rU4pzF0cTH5Guiv
	 jHq0huIPTBWlAjFtQY6u2RDxvTiDIPgL02tHyNn39Ub55fabciKGkQIAsMN1xyXxuAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793512384;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LYbHWnVZvcX6owhsqiVn0ycTfLqXg1a6rfmJWcgdZoY=;
	b=LtEU9hdZAtLjM4khX0W5BSVy9Ufmg9+YsKL2UI9IigR+BkUXV8e46m9GUy5flIR5cxP/
	 Q1pVWhdP/Yze2iZLT7tePSdABj63u455XJdGqQx0c03dHRla+yDhYFxi/HKYqbs/ldBDQ
	 Cx8Ye4xS4zc4H8Nx2WU7UIU2hPCKqpazfrE6BMet3ruBLJPTc0J/CI8Q9q42Sk3w1nQgo
	 ZccasW67M1V8ncAac+XXZyz8pDKJG729afga4MlOSV/RWpdufz1JXPBjfWz3HjHis83p8
	 2jAC7w2hReCJhgeDlrDuTadhUZrLBaTurx1VJzMkSFc10+sZ1WoG15OnFnddg6jGdFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SmdlyXD3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95F0606A324
	for <linux-input@vger.kernel.org>; Sun,  1 Nov 2026 05:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SmdlyXD3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 303821F000C1;
	Sun,  1 Nov 2026 05:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793512383;
	bh=LYbHWnVZvcX6owhsqiVn0ycTfLqXg1a6rfmJWcgdZoY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SmdlyXD30Q3kgtBnES9bWv+Iv2gRbvp6vPIpEH6J5UUR4/1vcMJ6VuIl4LSq589gl
	 71xsnrCyAG9/qRlIWnmDwaP+hYAeIaGEcyiEH3CxGOS6gTKlvJQSKp8YmPecnINjp/
	 wCbhbLl7GYNINz/KyzpHrHU4CsLwZ9LxdBalsAYdtiQJKptiwI4gQXEumNyKnTELNK
	 eCj/Le1ZjRCBKwCCApEwWfqRH0N3InytwCGjML3CcDwGN7RA6+z+1H38ESw+O8U11z
	 PWQROx3/iyx7KA2Pq6jT9hiL0LM7X2kb9sd6A97eDYZv1lIYeZ+G7qwWes3nbhJOLS
	 kTeT8n0lnWbOQ==
Message-ID: <sashiko-outbox-192283@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] HID: wacom: replace sprintf calls with safer
 alternatives
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nehuen Lian Bova" <nehuenlian.kernel@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261101054830.291749-1-nehuenlian.kernel@gmail.com>
References: <20261101011439.261812-1-nehuenlian.kernel@gmail.com>
 <20261101054830.291749-1-nehuenlian.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 05:53:02 +0000
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
- [High] HID: wacom: missing size argument in __wacom_initialize_battery() =
snprintf()
--

commit 3ae99c758bf47da8936a8a4c38001b6a0d39a084
Author: Nehuen Lian Bova <nehuenlian.kernel@gmail.com>

HID: wacom: replace sprintf calls with safer alternatives

This commit replaces sprintf() calls in drivers/hid/wacom_sys.c with
snprintf() in __wacom_initialize_battery() and sysfs_emit() in
wacom_show_remote_mode(), and includes <linux/sysfs.h>.

> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 628372ab818a2..bb5bb9c15f935 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c

[ ... ]

> @@ -1838,7 +1839,7 @@ static int __wacom_initialize_battery(struct wacom =
*wacom,
>  	bat_desc->properties =3D wacom_battery_props;
>  	bat_desc->num_properties =3D ARRAY_SIZE(wacom_battery_props);
>  	bat_desc->get_property =3D wacom_battery_get_property;
> -	sprintf(battery->bat_name, "wacom_battery_%ld", n);
> +	snprintf(battery->bat_name, "wacom_battery_%ld", n);

[Severity: High]
Is the buffer size argument missing in this snprintf() call in
__wacom_initialize_battery()?

Because snprintf() expects the buffer size as its second parameter, passing
"wacom_battery_%ld" as the second argument and n as the format string point=
er
causes a build failure due to incompatible pointer/integer types (or an
invalid pointer dereference when initializing a battery on device probe or
wireless connection).

Should this pass sizeof(battery->bat_name) as the second argument instead:

	snprintf(battery->bat_name, sizeof(battery->bat_name),
		 "wacom_battery_%ld", n);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261101054830.2917=
49-1-nehuenlian.kernel@gmail.com?part=3D1
