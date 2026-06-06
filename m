Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379CA3A7F6B
	for <linux-input@vger.kernel.org>; Sat,  6 Jun 2026 12:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780748889; cv=none; b=S6/h2bLHoJAXpS3dWFFpKxZKHLIi0wlp1BO6ag6hQFFjdRaRUCp9E93eE5YEAFgdawzCSCiw9Wig/EBDdzM1Js8TBUPlWaZn0LSrbimr7Mj4p+uTJK8s0NxNDsbHbsjDIjgb2LNSlDc24YmMgbmtze56Il5VNDTwj5x8Nxmd4as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780748889; c=relaxed/simple;
	bh=t9NQ+LEWU5qy/4Z43YDPJ4xqHXLzKkMKWnYemG/PUGY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ivedeN8Fq50v1qQSrHg9mMSYwTKnuV+Rxa0VD5IHIlNRAG9qqGSkjPpXoRjy4JHtro/REON5DB5n/1z8LFPsx2/WVaqqrP5nRSyz3DT3RXLzamgr6I1+kl/IvhEPUqsOus0Uq3tdyMxYHciibaMktaYHSu3DB/tqhi0/ZdE/KJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfXif8tv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfXif8tv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42CC11F00893;
	Sat,  6 Jun 2026 12:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780748887;
	bh=Z+X3wv1aphRZc0D6jexshD+rCDkJcEBrXtBoT7peU9U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TfXif8tv+Ah7M3INrrVLljNv82N7nScuh8zVFg+yO+cAlirR0rclRiCM8a9d2itBm
	 DG0Q1hP2//4FvUBDMCYkCkoxPtgd03CPMlO4jygJ0AHwA9chglfDznyKJgnugKSVSg
	 B5lgOpdHQqwy+iqbMMOPf3M1XRYkA9LNcrpOUq8997jbD1P0Gmi6Z5q6iUHV2HMNHS
	 FpVBetwzhBrvjI71Lk+7maq8k1YYSJoJN9CvQ5qt9PewVNBkz7fZpbXhlt3gssKzBH
	 zWbpjguyhQYZ+rLnh6JOaP7qnVjFW3inG6NmyoPaf3hGcxW943m/jfD3iTnCHWu3+d
	 1SoQtvcwmUtLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/7] iio: light: hid-sensor-als: use u32 instead of
 unsigned
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Chitroda" <sanjayembeddedse@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260606-6-june-hid-iio-correct-usage-id-v1-3-dd4a6820b674@gmail.com>
References: <20260606-6-june-hid-iio-correct-usage-id-v1-3-dd4a6820b674@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 12:28:06 +0000
Message-Id: <20260606122807.42CC11F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unconditional casting and dereferencing of `raw_data` to `u32*` an=
d `s64*` without checking `raw_len` causes out-of-bounds reads, kernel memo=
ry disclosure, unaligned access exceptions, and incorrect endianness handli=
ng.
--

commit 7ad652d49fe4e7dcab137b42945a51bbeaea25a3
Author: Sanjay Chitroda <sanjayembeddedse@gmail.com>

iio: light: hid-sensor-als: use u32 instead of unsigned

This commit updates the HID sensor ALS driver to use 'u32' instead of a bare
'unsigned' variable for the usage_id parameter. This improves code clarity
and consistency with kernel style.

> --- a/drivers/iio/light/hid-sensor-als.c
> +++ b/drivers/iio/light/hid-sensor-als.c

[ ... ]

>  /* Capture samples in local storage */
>  static int als_capture_sample(struct hid_sensor_hub_device *hsdev,
> -				unsigned usage_id,
> +				u32 usage_id,
>  				size_t raw_len, char *raw_data,
>  				void *priv)
>  {
>  	struct iio_dev *indio_dev =3D platform_get_drvdata(priv);
>  	struct als_state *als_state =3D iio_priv(indio_dev);
>  	int ret =3D -EINVAL;
>  	u32 sample_data =3D *(u32 *)raw_data;

[Severity: High]
This isn't a bug introduced by this patch, but does this direct cast cause
out-of-bounds reads or unaligned accesses if raw_len is less than 4 or
raw_data is unaligned?

Since raw_len is derived from the HID report descriptor, a malicious or
malfunctioning device could specify a smaller field size, potentially expos=
ing
adjacent kernel memory. Should this code check raw_len and use something li=
ke
get_unaligned_le32() since HID data is little-endian?

> =20
>  	switch (usage_id) {
>  	case HID_USAGE_SENSOR_LIGHT_ILLUM:

[ ... ]

>  	case HID_USAGE_SENSOR_TIME_TIMESTAMP:
>  		als_state->timestamp =3D hid_sensor_convert_timestamp(&als_state->comm=
on_attributes,
>  								    *(s64 *)raw_data);

[Severity: High]
This is also a pre-existing issue, but does this face similar risks with
8-byte reads from raw_data?

Could this trigger an out-of-bounds read if raw_len is less than 8, or cause
alignment faults on strict-alignment architectures?

>  		ret =3D 0;
>  		break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260606-6-june-hid=
-iio-correct-usage-id-v1-0-dd4a6820b674@gmail.com?part=3D3
