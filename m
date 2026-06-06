Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A9A39EB47
	for <linux-input@vger.kernel.org>; Sat,  6 Jun 2026 12:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780749007; cv=none; b=pgkvgVBKH0vctnsQM542EZNJs9V4z/S2QdZ0yL7PXGejm91BLZAvDPSH6MzedytGO2EbUFwZIbZjhes/sFaAwsw99kunzvG/slQzDjSt36w/qF1ZDuLonmnIO6JGCsZnCdEtQc2I7wY2Qk1+tXrA9qvUG9Xw6+jbTWeqv6e3Kls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780749007; c=relaxed/simple;
	bh=CsfFMI6NORtyCjAnWAcZyXLRPHs/PgsubxW0aZETi/k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ePfjKH/Q3osfoNJu9tiYqei3qF1aKq88opfYReyrIxuJbtpT80XQP0Vyr3FdyQHoCdLgaj2xWP9Yd4gQWRngom+SvGXajG/9kAvT4HPFTIWyaCbH4O+S2vvgnOZDKRNWqsiDN34+KLe8waSivPUySVeoi6AEwUJRe5HXH1ibDok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMvGO4sm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMvGO4sm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E56491F00893;
	Sat,  6 Jun 2026 12:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780749006;
	bh=dej+qLKpitm34FAK9EHpS3iO/sDU1UckvfOI3PDbcMs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oMvGO4smWAWfWgjuFMpDDrAVMDm7/J4UXj8RYi+IYj9CNCBDiRqLYOxEjAX/rETla
	 Lo7/ByyWgE8Mfd/oeHj0CZA1p7uE/R6I4QrFNdWr9JaHi75yvwZXAudWEK+R9WH4Y0
	 SopJPCZ1GeWZ7xn0JKfITBXHqaEP2F0yTZHJsQNNnpMkSSraixC4CSCx9ulMoUT8ZF
	 AK+vOfHniQQT0n4Scx9tPzKAkzSbQh2eVnxopBc6Bcoyui281xDtmTrJ1dwoC47TLM
	 huVhuSearXnyCk2xQSAiDqLA+KWYEJn2Qrfdto3rrM0XB5w07fifBqhx/5Om0aOy8R
	 h85AlvjEuxfJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/7] iio: orientation: hid-sensor-incl-3d: use u32
 instead of unsigned
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Chitroda" <sanjayembeddedse@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260606-6-june-hid-iio-correct-usage-id-v1-5-dd4a6820b674@gmail.com>
References: <20260606-6-june-hid-iio-correct-usage-id-v1-5-dd4a6820b674@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 12:30:05 +0000
Message-Id: <20260606123005.E56491F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Out-of-bounds read and information leak in `incl_3d_capture_sample=
` due to ignored `raw_len`.
- [High] Endianness mismatch in `incl_3d_capture_sample` due to direct poin=
ter cast.
- [High] Unaligned memory access in `incl_3d_capture_sample`.
--

commit bb48c83224153ec8c20c69c57c293183eb5211a7
Author: Sanjay Chitroda <sanjayembeddedse@gmail.com>

iio: orientation: hid-sensor-incl-3d: use u32 instead of unsigned

This patch updates the hid-sensor-incl-3d driver to use u32 instead of a
bare unsigned type in callback signatures, improving code clarity and
consistency.

> diff --git a/drivers/iio/orientation/hid-sensor-incl-3d.c b/drivers/iio/o=
rientation/hid-sensor-incl-3d.c
> index 4e23a598a3fb9..c7fbff498be7a 100644
> --- a/drivers/iio/orientation/hid-sensor-incl-3d.c
> +++ b/drivers/iio/orientation/hid-sensor-incl-3d.c

[ ... ]

> @@ -212,7 +212,7 @@ static int incl_3d_proc_event(struct hid_sensor_hub_d=
evice *hsdev,
> =20
>  /* Capture samples in local storage */
>  static int incl_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
> -				unsigned usage_id,
> +				u32 usage_id,
>  				size_t raw_len, char *raw_data,
>  				void *priv)
>  {

[Severity: High]
This is a pre-existing issue, but by ignoring raw_len in
incl_3d_capture_sample(), could we read out-of-bounds if a malicious HID
device provides a report descriptor with a smaller field size?

It appears we unconditionally cast char *raw_data to u32 * or s64 * and
dereference it:

drivers/iio/orientation/hid-sensor-incl-3d.c:incl_3d_capture_sample() {
    ...
    case HID_USAGE_SENSOR_ORIENT_TILT_X:
        incl_state->scan.incl_val[CHANNEL_SCAN_INDEX_X] =3D *(u32 *)raw_dat=
a;
    ...
}

If the field is placed at the end of the HID report buffer, this might
read past the allocated buffer and leak kernel heap memory into the
sensor readings.

[Severity: High]
This is a pre-existing issue, but does this direct cast also cause
incorrect sensor values on big-endian architectures?

The USB HID protocol specifies that report data is strictly little-endian,
but casting directly to u32 * and dereferencing it uses the CPU native
byte order.

[Severity: High]
This is a pre-existing issue, but can this dereference trigger alignment
exceptions on architectures that do not support unaligned accesses?

Since the pointer passed as raw_data is iteratively incremented by the
byte sizes of preceding fields, it might not be aligned to a 4-byte
boundary when we cast it to u32 * and dereference it.

Should we be extracting these values safely using helpers like
get_unaligned_le32() instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260606-6-june-hid=
-iio-correct-usage-id-v1-0-dd4a6820b674@gmail.com?part=3D5
