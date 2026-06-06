Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EA730CDA2
	for <linux-input@vger.kernel.org>; Sat,  6 Jun 2026 12:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780748831; cv=none; b=eUnXE4bjt5J2VMU9KyPFywXU61pRBvAscYmsy+2CHJmEbjAYAgahRE/UNHZv504P7n7Q+3JVEbbJ7G3n3DXohlh0+EzOcWrkzIc1/9mbRRUaeNVZsHPJyNzZNTiZGvqZ7uylPv1X4QiJJMJKzI/ZLznzy9rMX2KK+VcRYw+7+Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780748831; c=relaxed/simple;
	bh=zOZoTMA1fJh7IC8ByGbRQkbXmzmJX2WHAHoK6pzGU0w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LXOWg5T58JxjAh3wguXGbjRb26KY/+wkS/2eiGFqjO+g527yD3Y6nzg5nYuJx/6+9dfuisKW6qd//49/LWvXLKihnVJLdjQYALr82UUgA28r4SJW12TNPgl1bRvhER2YD8OWz/PomaFsl3qFSWJlQeIZMNgZTfGJFOFEphUC8oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5douF03; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5douF03"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C98EC1F00893;
	Sat,  6 Jun 2026 12:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780748830;
	bh=zXPcUFIjpbCMlYeogyN/bQTNiBqw4BZ/aftETOo76Us=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b5douF03sKHDEbqjnZwqbYlEzfMnqQnK+eUnQ1EsmH1/hHmTOOIYylvO9V6rZgxLL
	 FMoDfREdp7Eeo4aCHtWXh8YB5lzW7e4rfjLjBsk9g8GZLd+TrPUD51qPxloL/e4sAB
	 x2FChEPLk4a2omLadfx+iVg6l5hlzEC4Xij2VbNbTSoaQXAMoUAUFVm1Tx+UjXBwaO
	 cxoTURhicFJ2cxY04fh8NXibzSaFHoaFkDl1dSbolSFMQ3Wjg0K8mbrKbm2nZbFFf7
	 5D9ql6DkgeTVfYZ1IUpPPVZCu2iw5QDGNEtL6tcj9nRWWA+2WDeoupnQGY7LhvwQhQ
	 ORbZEPfTsLTdg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/7] iio: accel: hid-sensor-accel-3d: use u32 instead of
 unsigned
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Chitroda" <sanjayembeddedse@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260606-6-june-hid-iio-correct-usage-id-v1-2-dd4a6820b674@gmail.com>
References: <20260606-6-june-hid-iio-correct-usage-id-v1-2-dd4a6820b674@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 12:27:09 +0000
Message-Id: <20260606122709.C98EC1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unsafe memory access via out-of-bounds read and unaligned derefere=
nce.
--

commit f0677ef9176d20b908a2aa7a22d8817abe7925a7
Author: Sanjay Chitroda <sanjayembeddedse@gmail.com>

iio: accel: hid-sensor-accel-3d: use u32 instead of unsigned

This commit updates the hid-sensor-accel-3d driver to use u32 instead of
unsigned for the usage_id variables. This improves code clarity and maintai=
ns
consistency with kernel coding styles.

> diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/=
hid-sensor-accel-3d.c
> --- a/drivers/iio/accel/hid-sensor-accel-3d.c
> +++ b/drivers/iio/accel/hid-sensor-accel-3d.c

[ ... ]

> @@ -247,7 +247,7 @@ static int accel_3d_proc_event(struct hid_sensor_hub_=
device *hsdev,
> =20
>  /* Capture samples in local storage */
>  static int accel_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
> -				unsigned usage_id,
> +				u32 usage_id,
>  				size_t raw_len, char *raw_data,
>  				void *priv)
>  {
>  	struct iio_dev *indio_dev =3D platform_get_drvdata(priv);
>  	struct accel_3d_state *accel_state =3D iio_priv(indio_dev);
>  	int offset;
>  	int ret =3D -EINVAL;
> =20
>  	switch (usage_id) {
>  	case HID_USAGE_SENSOR_ACCEL_X_AXIS:
>  	case HID_USAGE_SENSOR_ACCEL_Y_AXIS:
>  	case HID_USAGE_SENSOR_ACCEL_Z_AXIS:
>  		offset =3D usage_id - HID_USAGE_SENSOR_ACCEL_X_AXIS;
>  		accel_state->scan.accel_val[CHANNEL_SCAN_INDEX_X + offset] =3D
>  						*(u32 *)raw_data;

[Severity: High]
This is a pre-existing issue, but I noticed a potential problem with how
raw_data is accessed here. Does this direct cast to a 32-bit integer pointer
assume that raw_len is always at least 4 bytes and that raw_data is always
4-byte aligned?

If a device provides a smaller report, could this result in an out-of-bounds
read? Also, since raw_data comes from a HID report buffer, could this trigg=
er
an alignment fault on architectures with strict alignment requirements if t=
he
data is unaligned?

>  		ret =3D 0;
>  	break;
>  	case HID_USAGE_SENSOR_TIME_TIMESTAMP:
>  		accel_state->timestamp =3D
>  			hid_sensor_convert_timestamp(
>  					&accel_state->common_attributes,
>  					*(int64_t *)raw_data);

[Severity: High]
This is also a pre-existing issue, but similar to the above, does this dire=
ct
cast to a 64-bit integer pointer require raw_len to be at least 8 bytes and
raw_data to be 8-byte aligned?

Would it be safer to use get_unaligned() and check raw_len before
dereferencing these pointers to avoid potential slab-out-of-bounds panics
or alignment faults?

>  		ret =3D 0;
>  	break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260606-6-june-hid=
-iio-correct-usage-id-v1-0-dd4a6820b674@gmail.com?part=3D2
