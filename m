Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8721943D515
	for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 15:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106433; cv=none; b=iHAezPfvpteTHLeifx8+KLfjShzHyPQu1gU50nn4sFmjd4wU7CJQr9W+yvlrXd+2F8WjMoSjqBtfIlfta52KfEAynKDu55lzHG6aJNLELCy/Y/cC5raNuWE1PfpVAUBSUDtbD8CKZ4rYWJEeaVcz7MHYpgKVqm5O/i+sGBN71CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106433; c=relaxed/simple;
	bh=s9p/fwdYhkhyuMHCSz5SXaRRo5/Ptq3LDw7Qbjt/RTg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J6NEuyG3Qc8ptowFsjqnk6qVjYZ5tFpn1V+KkR36Hp9Rx/HeJfms2MayeWCvoTKyt5ZtTv0MFjvtbhezxp0sEvw+mOoRzhWvlKXU09t0lcKZpsYhc0RBzX25AUwyFUjQ9YFHtGBkUit0LaRxbxGNEEsUYNmrZuAeDz4TOozEOcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FpYhQeNe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FpYhQeNe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064001F00893;
	Wed, 10 Jun 2026 15:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781106431;
	bh=D+zXy8ispY/TGo4Q3o/EIzdtix17HgYO3lSOh99t/YQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FpYhQeNeBoNtkTveAlhrQ1cpxWqVps6Vi7+OfGQe4ujYkC+s5rL5/uNS1vUjacs2C
	 7wxluSCnJ4VlgSs7NGEiQWCOvp7gSrTWDyNPJx8XYeyR4zU0aIY0OiglRfxVLT3UFK
	 36SJybAwxgeQH5BV3KrR5IEgKDheE+2EE+bAat0aZc5j9KBsDdbmGO9ofwAXEgbX1B
	 0V1Na0FMC/Fr3bfhqzVappVnQaVVvfAxqnVHOKAziae8+0mMR0dOGFLk8t4SYiBPhM
	 0wGdLuYbbRG4nbd+XakEM65M7cQ3Nu9PLV4XL+W8cCc10haV3VROXC6FCiYQoGT7KA
	 0H9eY/iqp3zEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/7] iio: light: hid-sensor-als: use u32 instead of
 unsigned
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Chitroda" <sanjayembeddedse@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260610-6-june-hid-iio-correct-usage-id-v2-3-c3c5f0720493@gmail.com>
References: <20260610-6-june-hid-iio-correct-usage-id-v2-3-c3c5f0720493@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 15:47:10 +0000
Message-Id: <20260610154711.064001F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Directly casting the `raw_data` byte array to `u32*` and `s64*` in=
 capture callbacks causes unaligned memory accesses, incorrect endianness h=
andling, and potential out-of-bounds reads.
--

commit 8c6bb48eb0d753aea033d76922dc45a105550e60
Author: Sanjay Chitroda <sanjayembeddedse@gmail.com>

iio: light: hid-sensor-als: use u32 instead of unsigned
   =20
Prefer 'u32' instead of bare 'unsigned' for usage_id variable.
This matches expected callback API type and improves code clarity.

> diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-s=
ensor-als.c
> index d72e260b82668..ae2fda8dc500a 100644
> --- a/drivers/iio/light/hid-sensor-als.c
> +++ b/drivers/iio/light/hid-sensor-als.c

[ ... ]

> @@ -263,7 +263,7 @@ static int als_proc_event(struct hid_sensor_hub_devic=
e *hsdev,
> =20
>  /* Capture samples in local storage */
>  static int als_capture_sample(struct hid_sensor_hub_device *hsdev,
> -				unsigned usage_id,
> +				u32 usage_id,
>  				size_t raw_len, char *raw_data,
>  				void *priv)
>  {

[Severity: High]
This is a pre-existing issue, but does the direct cast in this function cau=
se
unaligned memory accesses or endianness issues?

Just a few lines down in als_capture_sample(), raw_data is cast directly:

	int ret =3D -EINVAL;
	u32 sample_data =3D *(u32 *)raw_data;

The HID sensor hub core passes a byte pointer raw_data which points directly
into the raw HID report. In sensor_hub_report(), the pointer is incremented
by 1 to skip the report ID, making it immediately unaligned.

Dereferencing this unaligned pointer directly via *(u32 *) or *(s64 *) can
cause unaligned memory access faults on architectures that do not support
them.=20

Additionally, since HID reports are strictly little-endian, a direct
cast on a big-endian host might result in corrupted sensor data.

Should this code use get_unaligned_le32() and get_unaligned_le64() instead,
and also validate that raw_len is sufficient to prevent out-of-bounds reads?

The same direct cast pattern appears to be present in other HID sensors,
such as accel_3d_capture_sample() and gyro_3d_capture_sample().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610-6-june-hid=
-iio-correct-usage-id-v2-0-c3c5f0720493@gmail.com?part=3D3
