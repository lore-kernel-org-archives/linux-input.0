Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09113EFD04
	for <linux-input@vger.kernel.org>; Mon, 27 Jul 2026 15:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785165107; cv=none; b=eDFUZAgKEODEXmGbBhID45f36Ur1rL7bSyaLFHY8ro8zUHD40dKD8hiLjW6ar6INzGnHariwTU4xV8CWwqyUWTTWTiEfJEqcw2yEPslyokHKQWUSuD9H2fNdGOTRkVpaVuGCqQrUaA0cD9tuGG+MChFI1LJgqwK3HY/ZVM+rP14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785165107; c=relaxed/simple;
	bh=Kc49b4D/36hmMkMQHGd0JzePpQwu3IQHYOLkv5d6d2k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EnR+O9Ok1d8vtqt9+iH33SRJOGkWoi/4YvuIYNZwo0w/3ixrvdPzvRjD12JUFQ9/388ZHBXIDFJtbV1C0IN73Go5+v+79Ux4cHDUi8ZIpJqdqROHnmDY6Ov/0et2V0cosWKip+mMtl7eA7VfxrV0aGl9unPcTlAM+edn1Hd+Rx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWFzPJ8N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWFzPJ8N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EAC11F000E9;
	Mon, 27 Jul 2026 15:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785165105;
	bh=mIg9gPiPPhkm/GSsE2n1ETPE/mHIY/whZuILQpbAbCM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hWFzPJ8NfFWIF5s5ArUCojYU296C2OB582tnzHpOX0Dqz2rKrLIjk1wRF2OiAfSC2
	 xGPdJ+YiqUR4odFUVLTTOdiNPV6HVipZG1LV54x/X/lk490HBoTxsosuNZavEwgmgw
	 riGmyEYsfg6EoAGZstl6vP/75TbEWAMLmbeyUwRXt8QyKtG7S0ehAjl1nu9/CShcMC
	 Q7+ScLLqU78Xbj7InnlCXdpF7G/2IfNcs1FMKR0ofmNki1ES8qbrQmCfCB6oyERzy5
	 2CWNzxD4p15OUaIpqf+A1o22gb+8AQojdwKdS6JDnO8QLyzePcPSrBf5ClXOcXYsuT
	 ny9r1eikSekUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/8] HID: wacom: cleanup usage of 'driver_data'
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?UGF3ZWwgWmFsZXdza2kgKFRoZSBDYXBhYmxlIEh1Yik=?= <pzalewski@thegoodpenguin.co.uk>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260727-mod-devicetable-hid_device_id-v3-6-980896ca283e@thegoodpenguin.co.uk>
References: <20260727-mod-devicetable-hid_device_id-v3-0-980896ca283e@thegoodpenguin.co.uk>
 <20260727-mod-devicetable-hid_device_id-v3-6-980896ca283e@thegoodpenguin.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 15:11:44 +0000
Message-Id: <20260727151145.5EAC11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing lower-bound check on the enum index allows an attacker to =
bypass bounds checking and trigger an out-of-bounds read by injecting a lar=
ge value via the `new_id` sysfs interface.
--

--- Patch [6]: [PATCH v3 6/8] HID: wacom: cleanup usage of 'driver_data' ---
commit b219fca8b4be38408fca90649c9b3228cd0bfa8c
Author: Pawel Zalewski (The Capable Hub) <pzalewski@thegoodpenguin.co.uk>

HID: wacom: cleanup usage of 'driver_data'

This commit changes the driver_data field in the HID device ID table
from a direct pointer to an integer index. This index is then used to
look up the appropriate wacom_features struct from a static array.
This change aims to make it safer to inject new device IDs from userspace.

> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 0eafa483b7f75..834519751a5cf 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
[ ... ]
> @@ -2843,7 +2847,15 @@ static int wacom_probe(struct hid_device *hdev,
>  	wacom->hdev =3D hdev;
> =20
>  	wacom_wac =3D &wacom->wacom_wac;
> -	wacom_wac->features =3D *((struct wacom_features *)id->driver_data);
> +
> +	const struct wacom_features *id_features =3D get_wacom_features(id->dri=
ver_data);
> +
> +	if (!id_features) {
> +		hid_err(wacom->hdev, "could not get wacom id_features.\n");
> +		return -EINVAL;
> +	}
> +	wacom_wac->features =3D *id_features;

[Severity: High]
If a large value is injected here via the new_id sysfs interface, it gets
passed as id->driver_data to get_wacom_features(). Could the returned
id_features pointer be out of bounds, causing a memory access violation
when dereferenced during this assignment in wacom_probe()?

> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index da1f0ea85625d..d0a864d525098 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
[ ... ]
> +const struct wacom_features *get_wacom_features(enum wacom_features_tabl=
e_index index)
> +{
> +	if (index >=3D NUM_OF_WACOM_FEATURES_IN_TABLE)
> +		return NULL;
> +
> +	return wacom_features_table[index];
> +}

[Severity: High]
Since the enum constants fit within a signed 32-bit integer, the compiler
typically implements the enum wacom_features_table_index as a signed int.

If id->driver_data is a large enough value, it could be implicitly downcast
to a negative signed integer when passed to get_wacom_features(). A negative
value would bypass the upper-bound check here since a negative number is
less than NUM_OF_WACOM_FEATURES_IN_TABLE.

Does this missing lower-bound check allow get_wacom_features() to return
an invalid pointer from before the wacom_features_table array? Would it be
safer to check if index is less than zero, or change the parameter to an
unsigned type?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727-mod-device=
table-hid_device_id-v3-0-980896ca283e@thegoodpenguin.co.uk?part=3D6
