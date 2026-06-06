Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAD7396579
	for <linux-input@vger.kernel.org>; Sat,  6 Jun 2026 12:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780748940; cv=none; b=uHt6xL5QHHWvry7GrdHrrZDFfONTQzaTs7GHdV/rdz0Fq5yXMD7R09FJ5qBUnTEEtKtnHHQ466F/qzgOQTjliBUo5DxmJTH6YEWE4GqnvhnnnD+sMmCUnBRxQxY0q0A1qU0RyUoCCWu5ST8Rhzz5cd7kwZWDmmj8gQ3qXCdhNyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780748940; c=relaxed/simple;
	bh=L/yg3oVFD+uRVf+EEB57CtC4Qat1fg1iZQ+E15Eit/E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GMr1Lb+jweNpG9OS1zuYQZ2SC6AoCV8iQQxZOOr/PBPQl8Zxk1FfLai2phIAouBzp/MzxL8HQs6Yfa511xpxUD42MRtayMOxLgGW7xYy4hjirIzSTsPACz53uFh8SSDbPkGvgEIzG8s3PvjQBmpwPwzWwYD4mvCtNsHgznlycDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qs4qI6RR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qs4qI6RR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 014A11F00893;
	Sat,  6 Jun 2026 12:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780748939;
	bh=Mom2Z3+G0SrxZ3CFF29NRg92B7oYgT13IiimzvYcYIQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qs4qI6RRA/9qwbJRW6jFGzui4jTK3JPFhF4TSWhM2r67+9Bsvdc6p4pcPFDPXNbal
	 wAsakSVLMQk4oMEZTHkV/oRwILSSw8hsgG0Uk45ua2ApB5bww6OOeE6gdEzBOigco6
	 ADc1PRMEy1+zQYGLmGPEPhKEfPK/3CHMGycbda/aofCA7fwSinBi+AvGRGBJgQh505
	 hw6qSLszBqzAYgZachAHGeRJRxEmnCTsoy6Yyrgl5ytdGDLCwE4YK47rbCha7f7Ue5
	 T5ZYj+LqR1nMiEq7qBqzoZaWOA/fhesBTWTmb2XiHGddk0qA2Sg8dTFMoKyK1eceZv
	 JvEO0+VjSYepg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/7] iio: gyro: hid-sensor-gyro-3d: use u32 instead of
 unsigned
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Chitroda" <sanjayembeddedse@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260606-6-june-hid-iio-correct-usage-id-v1-1-dd4a6820b674@gmail.com>
References: <20260606-6-june-hid-iio-correct-usage-id-v1-1-dd4a6820b674@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 12:28:58 +0000
Message-Id: <20260606122859.014A11F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The capture_sample callback casts the `raw_data` pointer to `u32*`=
 and `s64*` without validating `raw_len` or pointer alignment, potentially =
causing out-of-bounds reads, kernel memory leaks, and unaligned access faul=
ts.
--

commit e250748ae8811d708c463dcef4e525db238816e3
Author: Sanjay Chitroda <sanjayembeddedse@gmail.com>

iio: gyro: hid-sensor-gyro-3d: use u32 instead of unsigned

This commit replaces bare unsigned variables with the u32 type in the HID
sensor 3D gyro driver to improve code clarity and adhere to kernel style
guidelines.

> diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid=
-sensor-gyro-3d.c
> index e48c25c87b6d6..bbca2111e79bb 100644
> --- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
> +++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
[ ... ]
> @@ -199,7 +199,7 @@ static int gyro_3d_proc_event(struct hid_sensor_hub_d=
evice *hsdev,
> =20
>  /* Capture samples in local storage */
>  static int gyro_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
> -				unsigned usage_id,
> +				u32 usage_id,
>  				size_t raw_len, char *raw_data,
>  				void *priv)
>  {

[Severity: High]
This is a pre-existing issue, but looking at the rest of this function, it
appears we cast the raw_data pointer directly to u32* and s64* without chec=
king
raw_len or alignment:

gyro_3d_capture_sample() {
	...
	gyro_state->scan.gyro_val[CHANNEL_SCAN_INDEX_X + offset] =3D
			*(u32 *)raw_data;
	...
	gyro_state->timestamp =3D
		hid_sensor_convert_timestamp(&gyro_state->common_attributes,
					     *(s64 *)raw_data);
	...
}

Could a buggy or malicious HID device supply a field size smaller than 4 or=
 8
bytes, leading to an out-of-bounds read that leaks kernel heap data into the
IIO buffer?

Also, since raw_data is only guaranteed to be byte-aligned, could these nat=
ive
casts trigger unaligned access exceptions on architectures that do not supp=
ort
unaligned loads? Would it be safer to validate raw_len and use get_unaligne=
d()
or memcpy() here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260606-6-june-hid=
-iio-correct-usage-id-v1-0-dd4a6820b674@gmail.com?part=3D1
