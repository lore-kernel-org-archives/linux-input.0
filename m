Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6562848AE12
	for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 15:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106456; cv=none; b=XgUeudcGhqmlKAKybXkfvCOzrV9IR4Fv9wencOAZh8a42/pVAtxMqjkq5DM/of0STWwh07amfUKeyXR8dEV+1Q5FzBQwGe5A/NwcnoQVtXoDuTF51Mxd0hvTvjaalnVT6x3lrY8WgL+M1ThPqNJwkhOpAcoK9vOtK8tnJK68NR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106456; c=relaxed/simple;
	bh=zPs1qKJe5nWrHrQqXwKxo9wsgKVvwBenTrOvSPT7Cck=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YetlV2rAbRFs6XLEgkYM3ziF39qcvKZwYChOl4HdqNpYfDmU2RJcF95U4/4TeYA2ZsXBq7FJ1GKm1hSaDMpniCFhqIEG/EZc0htLpeyWCxHP7etQKEC1qCH9UYcM0I1nZvseNld53eG5U8Q15JX4Ognq9Kn9zM20jV/MD1ii60s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ixNGZy43; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixNGZy43"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D7201F00893;
	Wed, 10 Jun 2026 15:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781106453;
	bh=9iuSPit/bgB/M2QumlKoeaqSCz0R2x2F0F41APUAGPQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ixNGZy43kvPVAlgpwPhZgQHlOL+ssv1r5+rc5L8LbauJE45SN8drxya9MqV1b+Ec1
	 zBOICue11kOQBrQMLnTVFabj19dzOUzNus/rswhSD32cbyG/UPngGSYtEpLEWe0Iks
	 kqu/iHN/nrD4+NOxSP60ZTcP9c0dHWaIo2W4yXR+NCg3HdXkXAqItx5x9N2JCgMp2s
	 4e0uxrZf879GEwXZd0Ig7uY7qH28XUZm4Ncyu75BoPqbI6ZR0+Cjtjgkal+aCvd9P2
	 2GrxESK/2r5B8pJz9TLhiRtgEXbv1rNYKexq6lgGCKejDdxreXuWnK0RiHc2BwDskL
	 MLSApXd32ma1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/7] iio: light: hid-sensor-prox: use u32 instead of
 unsigned
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Chitroda" <sanjayembeddedse@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260610-6-june-hid-iio-correct-usage-id-v2-4-c3c5f0720493@gmail.com>
References: <20260610-6-june-hid-iio-correct-usage-id-v2-4-c3c5f0720493@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 15:47:33 +0000
Message-Id: <20260610154733.9D7201F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unaligned and endian-dependent memory access from raw HID report b=
uffer
--

commit 15de0e06ef54de0333e9e716c38314e57230ae3f
Author: Sanjay Chitroda <sanjayembeddedse@gmail.com>

iio: light: hid-sensor-prox: use u32 instead of unsigned

This commit changes the type of the usage_id parameter from unsigned to u32
in the callback functions of the HID sensor proximity driver. This matches
the expected API and improves code clarity, with no functional changes
intended.

> diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-=
sensor-prox.c
> index edc9274a2c076..9059f00f0cedf 100644
> --- a/drivers/iio/light/hid-sensor-prox.c
> +++ b/drivers/iio/light/hid-sensor-prox.c

[ ... ]

> @@ -183,7 +183,7 @@ static int prox_proc_event(struct hid_sensor_hub_devi=
ce *hsdev,
> =20
>  /* Capture samples in local storage */
>  static int prox_capture_sample(struct hid_sensor_hub_device *hsdev,
> -				unsigned usage_id,
> +				u32 usage_id,
>  				size_t raw_len, char *raw_data,
>  				void *priv)
>  {

[Severity: High]
This is a pre-existing issue, but does this function safely access the raw
data from the HID report?

Since raw_data points into a packed HID report buffer, the data might not be
naturally aligned for 16-bit or 32-bit boundaries. It looks like we cast
directly to u16* and u32* later in this function:

drivers/iio/light/hid-sensor-prox.c:prox_capture_sample() {
    ...
    case 2:
        prox_state->human_presence[chan] =3D *(u16 *)raw_data * multiplier;
        return 0;
    case 4:
        prox_state->human_presence[chan] =3D *(u32 *)raw_data * multiplier;
    ...
}

Could this trigger unaligned memory access faults on architectures that do
not support them in hardware?=20

Also, since HID reports encode data in little-endian format, would using the
host's native byte order here cause incorrect sensor readings on big-endian
architectures?

Would it be safer to use get_unaligned_le16() and get_unaligned_le32()
instead of direct casting?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610-6-june-hid=
-iio-correct-usage-id-v2-0-c3c5f0720493@gmail.com?part=3D4
