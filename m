Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893F0345741
	for <linux-input@vger.kernel.org>; Sun, 31 May 2026 23:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780269151; cv=none; b=kZORalj5+v2YD3j2ru0vbb8HRQ6REBwF85Ldll+zcWwBtJ17Fmk8gLDQ6jrbcE02HS2k7wA7cf/jiJGCTJE9Fw7StWmRCWb9WMBQpWtexpnxqVXVmwjNE1zzhEgcOsnsXu4b0r5EJ88wos+XmbIo5H28QmnNTV8DGg6LeXVgyIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780269151; c=relaxed/simple;
	bh=NB++Hm7wvepJrShPPpiDqXINybgu5qIfeRDohJY3RBY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GhiZgDjlvvoT3/0wjeHCseDW2Ezcj8vk46I74Gy2MC+36wWdUSUK6HF//PBLo0oqIK+Kdxc3/Em5S3501v5cCH5LwT4G3dgITiJfw0ywh5kPkXkZBx0GHzuqcEjvpMWCladuWcfagvuxVNpcci3u41ve97g/+rhqp0p4RBTRGeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMcwt530; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMcwt530"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF4C21F00893;
	Sun, 31 May 2026 23:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780269150;
	bh=R+s90CKQq+b5E9M/H5RuUhjyBS9rmJVIG8Two1obeSw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NMcwt5309SC7Gj6pb/zAHnyMWO7sqgOtscuBON/ZgLkbIquIi2WW8DPK75fN0NwmL
	 kiTUWU74kwomGaplGbMPHaIew3vdMLalw1dxchOS/4om6v0yYeP2Wzh782g4t0rSKS
	 yc46aXVktivIwIYdfkSeflrdiuKngH4yGg4EDoDX8h55HdEOQ70aXE2C5RQnjS5a1F
	 AT0XKtuBQ7PrQeyNzZ8LufZBJER39CBM6F1HWHwBvtJrK6u6wz2Rwi1Ww7KesxbK31
	 Z+6wLa1z9UzNQRgOyMisS5iXHuahdn8mMIPBeVtJ5JzMTusPQs/932f4yVakd7Ezgq
	 UGa07czXhUxZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] HID: steelseries: Add MSI Raider A18 HX A9WJG RGB
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Glushkov" <david.glushkov@sntiq.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260531225329.201327-1-david.glushkov@sntiq.com>
References: <20260531225329.201327-1-david.glushkov@sntiq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 31 May 2026 23:12:29 +0000
Message-Id: <20260531231229.EF4C21F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Returning `-ENODEV` prevents `hid-generic` fallback, permanently b=
reaking the keyboard on other laptops and breaking unsupported interfaces.
- [Low] Unused static function `steelseries_msi_rgb_free_buf` in the `#else=
` fallback block causes a compiler warning.
--

commit 6fad0ba2106ff9dc9bf3d9ad4063720dca63e6b1
Author: David Glushkov <david.glushkov@sntiq.com>

HID: steelseries: Add MSI Raider A18 HX A9WJG RGB support

This commit adds DMI-gated support for MSI Raider A18 HX A9WJG internal
SteelSeries USB HID devices. The driver exposes them as multicolor LED
class devices on USB interface 0.

> diff --git a/drivers/hid/hid-steelseries.c b/drivers/hid/hid-steelseries.c
> index f98435631aa18..f0ba59bb28f97 100644
> --- a/drivers/hid/hid-steelseries.c
> +++ b/drivers/hid/hid-steelseries.c
[ ... ]
> @@ -546,6 +546,188 @@ static bool steelseries_is_vendor_usage_page(struct=
 hid_device *hdev, uint8_t us
[ ... ]
> +#else
> +static void steelseries_msi_rgb_free_buf(void *data)
> +{
> +	kfree(data);
> +}
> +
> +static int steelseries_msi_rgb_register(struct steelseries_device *sd)
> +{
> +	return -ENODEV;
> +}
> +#endif

[Severity: Low]
Is steelseries_msi_rgb_free_buf() ever called when
CONFIG_LEDS_CLASS_MULTICOLOR is disabled?

Since it is a static function, defining it without a caller in the #else
fallback block will trigger a -Wunused-function compiler warning.

> @@ -549,6 +749,12 @@ static int steelseries_probe(struct hid_device *hdev=
, const struct hid_device_id
>  	sd->hdev =3D hdev;
>  	sd->quirks =3D id->driver_data;
> =20
> +	if (sd->quirks & STEELSERIES_MSI_RGB) {
> +		if (!dmi_check_system(steelseries_msi_rgb_dmi_table) ||
> +		    !steelseries_msi_rgb_is_interface0(hdev))
> +			return -ENODEV;
> +	}

[Severity: High]
Does returning -ENODEV here prevent the device from functioning as a standa=
rd
keyboard on other laptops or on unsupported interfaces?

Because the device's USB IDs are explicitly listed in the steelseries_devic=
es[]
id_table, the HID core's fallback logic prevents hid-generic from binding t=
o it.
Returning -ENODEV instead of clearing the quirk flag and continuing
initialization abandons the device entirely.

> +
>  	ret =3D hid_parse(hdev);
>  	if (ret)
>  		return ret;
[ ... ]
> @@ -565,12 +771,28 @@ static int steelseries_probe(struct hid_device *hde=
v, const struct hid_device_id
> =20
>  	ret =3D hid_hw_open(hdev);
>  	if (ret)
> -		return ret;
> +		goto err_stop;
> +
> +	if (sd->quirks & STEELSERIES_MSI_RGB) {
> +		ret =3D steelseries_msi_rgb_register(sd);
> +		if (ret) {
> +			hid_err(hdev, "Failed to register MSI RGB LEDs: %d\n", ret);
> +			goto err_close;
> +		}
> +		return 0;
> +	}

[Severity: High]
Similarly, if LED registration fails (for example, out of memory, or if the=
 LED
subsystem is disabled and returns -ENODEV), does returning an error here al=
so
leave the device completely unbound?

> =20
> -	if (steelseries_headset_battery_register(sd) < 0)
> +	if (sd->quirks & (STEELSERIES_ARCTIS_1 | STEELSERIES_ARCTIS_9) &&
> +	    steelseries_headset_battery_register(sd) < 0)
>  		hid_err(sd->hdev,
>  			"Failed to register battery for headset\n");
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260531225329.2013=
27-1-david.glushkov@sntiq.com?part=3D1
