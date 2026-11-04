Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793757234;
	b=BkpdXZDp6XlNGqTL7Gd1uUN6vXA2/3BvdcTpA9nLz1jC1OmnI87B/C7oAVAB/ysZ9lfE
	 L683CnLNELYVgZhsEkAxPmnlG5ReR/K2Iety3uzswPmPXDLRZS1AHkud6IKIVOsbIGOVr
	 KDqGrV4fu80/Zni3HAdtFU6ARsNk5DHfEdFUht8suwpl4MYPxMaJ84kJu64AYNuE7+qPz
	 C20/TKEdB/v+/JIolt0l1RtDSjpPD9mv84zzJ6u8YjaX50ZUzwtJ/42aN/fXzNSehAOmQ
	 CTQ7CyV9+Qp3mhcfaZfMIX7GUzGxpr5y0xoh39zVVN+v47S3H6fJyZAFvkmd+cUqSgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793757234;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Eyz8E7ByvqmUfZuHbSZKfZsEK3ndNRwgoaV+hNL3v84=;
	b=a7TwTE8Zz4drB4J3lMUZ3Vnv2DBH8ebZTS4Fm4/K3gyofoFvdWw+8lTmVNVoxLcb+EsU
	 /MTDdInojVmqtf7weFWz6qMDzRZ20M1OyWyDeDmC0u1jE59Fdz3xMoHrQfYkZu2nWKI1/
	 7ijoUDuvDLcVRI9UICsQhNoDiWgyWmEsI1KdKgzt1OkP8D42HQE7oivzSeuRqQwFbxByE
	 gdEukhVucNyW11yL62NSJ9+1SEGudqD6KhxfLWSYT7pOCXuj7XRfoywniuGj9qa1Pp4jl
	 VK9k+1WFH3vPkj4nPdeWK344bMSVXa89GubUI1HD/LlvWmE1sT2X3BtbtDYjo7e34xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OOc5ySQL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AC1606A31B
	for <linux-input@vger.kernel.org>; Wed,  4 Nov 2026 01:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OOc5ySQL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4552E1F000C1;
	Wed,  4 Nov 2026 01:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793757233;
	bh=Eyz8E7ByvqmUfZuHbSZKfZsEK3ndNRwgoaV+hNL3v84=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OOc5ySQLch6dPN+auLfHYbii+aRjNV1t3at0MBLCCQMZf3BIJwRT1uL5zZhQ35swL
	 jkTJ2+xl1ZwbBfDo1/l22D+V3+vtiXS3EvW6Flo+Fu1AgaoGikS9lQd5GhZntGlo4O
	 MlCZuqXMNjklZphV67nJRkdBDyAlBwXcB1Jp7z1XD4LoHSalkt409/UpYwPWbfTPBW
	 Z+NC7w/yezd4l9updTQ1gHYYGyPTF6gEZrIJqIFg1Drf+mZY437gASWUuzSyix2rsF
	 7Awal/abBbWeuW8U4KhmZT9AGRH8NhKUmamAdaNV3RbuZrw3Ki4R5lz2V+egNX+Eir
	 iXSvS/+K8VIfg==
Message-ID: <sashiko-outbox-196411@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 05/18] HID: asus: add joysticks inner and outer
 range configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261104013935.512713-6-denis.benato@linux.dev>
References: <20261104013935.512713-1-denis.benato@linux.dev>
 <20261104013935.512713-6-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 01:53:52 +0000
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
- [Low] HID: asus: ally_prefs_setup() mixes scoped_guard() with goto error =
handling
--

commit 23b7fd753beca8abc912e5e22d7a6deed94442a0
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: add joysticks inner and outer range configuration

This commit adds sysfs attributes for configuring the inner and outer
joystick thresholds on ASUS ROG Ally devices and restores those threshold
settings on device initialization.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 459061391c378..a89ce83ae93f4 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c

[ ... ]

> @@ -1182,15 +1401,44 @@ static int ally_prefs_setup(struct hid_device *hd=
ev, struct ally_intf *intf)
>  		}
>  	}
> =20
> +	scoped_guard(mutex, &ally_prefs.lock)
> +		cal_live =3D ally_prefs.user_cal_support ||
> +			ally_prefs.anti_deadzone_support ||
> +			ally_prefs.resp_curve_support;
> +
> +	/* Skip the calibration groups when the capability is missing. */
> +	if (cal_live) {
> +		for (; cal_n < ARRAY_SIZE(ally_cal_attr_groups); cal_n++) {
> +			ret =3D sysfs_create_group(&hdev->dev.kobj,
> +						ally_cal_attr_groups[cal_n]);
> +			if (ret) {
> +				hid_err(hdev, "Failed to create Ally sysfs group '%s': %d\n",
> +					ally_cal_attr_groups[cal_n]->name, ret);
> +				goto err_cal_groups;
> +			}
> +		}
> +	}
> +
>  	scoped_guard(mutex, &ally_prefs.lock) {
> +		intf->cal_sysfs_live =3D cal_live;
>  		intf->sysfs_live =3D true;
>  	}
> =20
>  	return 0;
> +
> +err_cal_groups:
> +	while (cal_n--)
> +		sysfs_remove_group(&hdev->dev.kobj, ally_cal_attr_groups[cal_n]);
> +
> +	for (i =3D 0; i < ARRAY_SIZE(ally_attr_groups); i++)
> +		sysfs_remove_group(&hdev->dev.kobj, &ally_attr_groups[i]);
> +
> +	return ret;
>  }

[Severity: Low]
This isn't a bug, but ally_prefs_setup() uses scoped_guard() while also
introducing a goto err_cal_groups error path when sysfs_create_group()
fails for ally_cal_attr_groups.

Since the cleanup API guidelines discourage mixing scope-based cleanup
helpers with goto-based error handling in the same function, could the
unwinding be done inline (similar to the earlier ally_attr_groups loop in
ally_prefs_setup()), or by using sysfs_create_groups() and
sysfs_remove_groups() with a NULL-terminated array to avoid the goto label?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104013935.5127=
13-1-denis.benato@linux.dev?part=3D5
