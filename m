Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E724D24E4C3
	for <linux-input@vger.kernel.org>; Wed, 13 May 2026 03:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778641245; cv=none; b=uTh+QczM2Jw5PErb+vKj0voIMo30c50lOIYDQj1ph4LUQ0GW6ltS6jCOqxMcm+aPhShe2iuoxkjgXsKpL+jKupBGWWPjo7//gQLvubcTz/Ito3hkHF2e9FsseNjoFA/e0HOhguYjwD7KtoTFQiMdmiGUNxwsYbbACtO4ihuNIa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778641245; c=relaxed/simple;
	bh=DpPgmplkdiadkA4M8c3lmXu3uh2URJB8mvwUQQ/NuOI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NrlZnIYxE75Spie3cRlbeq6jDleaiRt4uLvd9iK54ml/6isrJCp/Pwhtm7L8Qafy8RIaKZJsYyouQhnkJaqFfZQT1sYkzXMl9JALiXhQ77JZlT0fVDpA3ciRoAHPTIG7vSmHAJbLvWOUvOCH4vbCuMIMttSG2wfFX1H1qZ7zDHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qo/km2jU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qo/km2jU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A45C2BCB0;
	Wed, 13 May 2026 03:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778641244;
	bh=DpPgmplkdiadkA4M8c3lmXu3uh2URJB8mvwUQQ/NuOI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=qo/km2jU5GqUIa+0UqeZ0mSwXDh/+Rf1JR+tG6xBlATEvAwcSwL++ZmVol/n0P1h+
	 fwAmYM6Sdbh1NNPwbzBCHhCJ77SiuVyrQuSIUi3AHdaBTSkej+OqPn5izRRzKkd2Yw
	 2t+lM78sProJwZT78dqeh03IwU/pbR+cZbR2jdIC/uMnnxcgAnitQjZZUbEly93KEO
	 GJpUJ7RYnNBvVDqd2QPzcnahqVHXWU94uGEFuVB+ySaRM/xVCDank7hervw+yASZKD
	 ewxbufmLAEYcexKtooJQh+g8y7sturSOTYJG6zLkASSFlo7bobN4xoqzaJjfYUNJ38
	 V/tC99lbrjm1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/6] iio: light: HID: hid-sensor-als: Refactor
 channel initialization
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TmF0w6FsaWEgU2FsdmlubyBBbmRyw6k=?= <natalia.andre@ime.usp.br>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260512012302.20883-4-natalia.andre@ime.usp.br>
References: <20260512012302.20883-4-natalia.andre@ime.usp.br>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 03:00:43 +0000
Message-Id: <20260513030044.70A45C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch introduces a build error by initializing a non-existent `=
.format` field in `struct iio_scan_type`.
--

commit 0b0eb5f75d5c3745616a7e7de9ace24a35760cff
Author: Nat=C3=A1lia Salvino Andr=C3=A9 <natalia.andre@ime.usp.br>

iio: light: HID: hid-sensor-als: Refactor channel initialization

This commit replaces the local als_adjust_channel_bit_mask() function
with a compound literal for scan_type initialization to improve code
readability.

> diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-s=
ensor-als.c
> index 830e5ae7f34a7..e5b4c5e80f1cf 100644
> --- a/drivers/iio/light/hid-sensor-als.c
> +++ b/drivers/iio/light/hid-sensor-als.c

[ ... ]

> @@ -334,7 +324,11 @@ static int als_parse_report(struct platform_device *=
pdev,
> =20
>  		channels[index] =3D als_channels[i];
>  		st->als_scan_mask[0] |=3D BIT(i);
> -		als_adjust_channel_bit_mask(channels, index, st->als[i].size);
> +		channels[index].scan_type =3D (struct iio_scan_type) {
> +			.format =3D 's',

Does this cause a build failure? Looking at struct iio_scan_type in
include/linux/iio/iio.h, there is no field named format.

The removed code assigned this value to the sign field:

	channels[channel].scan_type.sign =3D 's';

Should this compound literal initialize .sign instead of .format?

> +			.realbits =3D BYTES_TO_BITS(st->als[i].size),
> +			.storagebits =3D BITS_PER_TYPE(u32),
> +		};
>  		++index;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512012302.2088=
3-1-natalia.andre@ime.usp.br?part=3D3
