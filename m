Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930131714AA
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 11:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781608788; cv=none; b=igF7MDPh/RO1kDFVhK5fvw8LUX5WHoJdg0b/TPsOOSMpdBFHEUzXUKESfSZTFzR5jA6heh7lbRfeV+FFFkskXyT/FdDfQWBSLWc/sHNDN7+/kGea7CJv5UtOR057LxI1hYnD2pTXj/3V1YG/s20shdLNv6LR4oGuVdj/adfnrSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781608788; c=relaxed/simple;
	bh=hRvOpyMNHlkGrunf5X9sCcVCHKwI5GCMEQsYUSc1fMA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qEVTsjKYYQ19V+t3ez+mdeuS8tXaWaTGAYdoxNgYnX4a5lB49iHOiJP/mU3/9Lak3GpxVVhmd+TFz8nD5gyarNsb1eVbYjvrQpfOMGJEtk3dGp2cNneKyCjgTkXeAx5DH3ZNKQPuJw+5qFDOoAfqYr8h+m/AUA60URVSmWB8FkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPu7zmvf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPu7zmvf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE301F000E9;
	Tue, 16 Jun 2026 11:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781608787;
	bh=IRLXw/UsGMB5dVTobSVvXyudbKhKcK3wDKTM6v4Sh+A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oPu7zmvfnr9KiRpWKCs59EBB594Zbj3wNKBC6Gw0LfJq8JVO6BH5VB2cQiwK5ZLRD
	 3vPmUlin8/gxwzE59oCNJII14SR5220JvCP5DiCbArzr/zJHYDeCVOeHBGPvVZ772p
	 p6qyLPwAmn6eMPMUXeDNhQVnJ+efXaJcM5jfUlRThOQE2NpYemf9WWkF0Vo11zTYbD
	 7NO8AqjSEKSzpvPirLIMGA4R9e4bkAsG4hHiWNeR17SMTvyS76AUG1ehGkaPFV7txr
	 MpxeOMeYz9UrqouXx2ne4e66PgZWwHlKmMXXzTBvYUxyKCHHgU4aTeF6IREyAYKc/V
	 OjUTB+2xfvNDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/11] iio: magnetometer: hid-sensor-magn-3d: align
 parenthesis for readability
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Chitroda" <sanjayembeddedse@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260616-15-jun-hid-iio-alignment-v1-4-0cd544286575@gmail.com>
References: <20260616-15-jun-hid-iio-alignment-v1-4-0cd544286575@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 11:19:46 +0000
Message-Id: <20260616111946.EEE301F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Blindly reading 32 or 64 bits from `raw_data` without verifying `r=
aw_len` can lead to slab-out-of-bounds reads.
--

commit 13804edb2c46947f67fe0d4d5d050f780422d2f7
Author: Sanjay Chitroda <sanjayembeddedse@gmail.com>

iio: magnetometer: hid-sensor-magn-3d: align parenthesis for readability

This commit adjusts the alignment of parentheses across multiple functions =
in
the hid-sensor-magn-3d driver. This improves readability and maintains
consistency with the kernel coding style.

> diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/=
magnetometer/hid-sensor-magn-3d.c
> index 23884825eb00f..82507297c55bb 100644
> --- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> +++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c

[ ... ]

> @@ -292,9 +291,9 @@ static int magn_3d_proc_event(struct hid_sensor_hub_d=
evice *hsdev,
> =20
>  /* Capture samples in local storage */
>  static int magn_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
> -				u32 usage_id,
> -				size_t raw_len, char *raw_data,
> -				void *priv)
> +				  u32 usage_id,
> +				  size_t raw_len, char *raw_data,
> +				  void *priv)
>  {
>  	struct iio_dev *indio_dev =3D platform_get_drvdata(priv);
>  	struct magn_3d_state *magn_state =3D iio_priv(indio_dev);

[Severity: High]
This is a pre-existing issue, but since this patch touches the signature of
magn_3d_capture_sample(), could we be at risk of a slab out-of-bounds read
further down in the function?

If a device presents a crafted HID report descriptor that defines the
HID_USAGE_SENSOR_TIME_TIMESTAMP field with a smaller size, it could result =
in
raw_len being less than 8.  Reading 8 bytes from raw_data in this case:

	case HID_USAGE_SENSOR_TIME_TIMESTAMP:
		magn_state->timestamp =3D
			hid_sensor_convert_timestamp(&magn_state->magn_flux_attributes,
						     *(s64 *)raw_data);

would read past the end of the buffer.

A similar dereference happens later in the function for the magnetic axes
where 4 bytes are read:

	iio_val =3D magn_state->magn_val_addr[offset];

	if (iio_val !=3D NULL)
		*iio_val =3D *((u32 *)raw_data);

Could this also trigger an out-of-bounds read if raw_len is smaller than 4?
Should we verify the size of raw_len before making these casts?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616-15-jun-hid=
-iio-alignment-v1-0-0cd544286575@gmail.com?part=3D4
