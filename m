Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B49430FC27
	for <linux-input@vger.kernel.org>; Wed, 13 May 2026 02:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778640640; cv=none; b=a6aUrEMrZ2RO12dyryrmBaKHSl8wzBk5oPp30aRasgrDxKi7lxnkgnOm0iU7s4DbL+GEV+dV5rg/1VQNz7AXpu8O1GI6IwSDb45Is7qi2dZZAwvy8i6B1zeHOUBD5EDh6ZR6uyRM8vxQeXcuCjhgtGlZuYCIgrvZov8a51vZX0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778640640; c=relaxed/simple;
	bh=sT6kJfQ6KDgi/0cJuvDbjonMD+4iBb0u3egcU07eCcY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PgbJ4F/mci8jHfDthcqefeU//zpZehPWk314wOJMyGHw03eehc35mQ3gLxWOwJ8GZfFtC5t7ss8hMCAuADTKy/VPFZUlxlT5sxiWhH06hT3lZ5RQymIOvKPk25SVPFDdmIebcNSE61rqr5Xmvmzru2bY/yKHfMGBceAROPCv9AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQ5XtzKZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQ5XtzKZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 171C3C2BCB0;
	Wed, 13 May 2026 02:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778640640;
	bh=sT6kJfQ6KDgi/0cJuvDbjonMD+4iBb0u3egcU07eCcY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=QQ5XtzKZJj4HevV+mYL4eAbQowtDHhKCO3GyXWwS75muuKuMoArNtYq6NtcMjA4jY
	 yeFFc/7AY27MMEXsJBNCJNElMYiyhpiHp1Lt8Mq3VKL7BmroWk/VddzFzKVU5G44nL
	 GBg80Td8LSYMvKnsGUoCBSOgOKouwIezMydLjimv0BwzZ7jMY7XWkp5JMuKZvNZ5Q/
	 yEE/RT0OmgRnLsMoleBt5mBiTqjNm9Lj5a947xonOoMkiISBie1qkLrNXnz9ocT+2N
	 93Z7DJnOVuSkWlEfOFSZrYmhnLnbipGL5IJUtSaCJZy48LnhznLzm8Z66Q6Ar1uXtd
	 MzCvrAoXTe8lQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/6] iio: gyro: HID: hid-sensor-gyro-3d: Refactor
 channel initialization
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TmF0w6FsaWEgU2FsdmlubyBBbmRyw6k=?= <natalia.andre@ime.usp.br>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260512012302.20883-3-natalia.andre@ime.usp.br>
References: <20260512012302.20883-3-natalia.andre@ime.usp.br>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 02:50:39 +0000
Message-Id: <20260513025040.171C3C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The struct iio_scan_type does not have a member named 'format', whi=
ch causes a build failure.
--

commit 8a26f68e644f245021a8896a54c6e164b2d81277
Author: Nat=C3=A1lia Salvino Andr=C3=A9 <natalia.andre@ime.usp.br>

iio: gyro: HID: hid-sensor-gyro-3d: Refactor channel initialization

This commit refactors the channel initialization in the hid-sensor-gyro-3d
driver by replacing the local gyro_3d_adjust_channel_bit_mask function with
a compound literal for scan_type initialization to improve readability.

> diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid=
-sensor-gyro-3d.c
> index c43990c518f77..be8406da32f0e 100644
> --- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
> +++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c

[ ... ]

> -/* Adjust channel real bits based on report descriptor */
> -static void gyro_3d_adjust_channel_bit_mask(struct iio_chan_spec *channe=
ls,
> -						int channel, int size)
> -{
> -	channels[channel].scan_type.sign =3D 's';
> -	/* Real storage bits will change based on the report desc. */
> -	channels[channel].scan_type.realbits =3D size * 8;
> -	/* Maximum size of a sample to capture is u32 */
> -	channels[channel].scan_type.storagebits =3D sizeof(u32) * 8;
> -}
> -

[ ... ]

> @@ -251,16 +241,20 @@ static int gyro_3d_parse_report(struct platform_dev=
ice *pdev,
>  	int i;
> =20
>  	for (i =3D 0; i <=3D CHANNEL_SCAN_INDEX_Z; ++i) {

[ ... ]

> -		gyro_3d_adjust_channel_bit_mask(channels,
> -				CHANNEL_SCAN_INDEX_X + i,
> -				st->gyro[CHANNEL_SCAN_INDEX_X + i].size);
> +		channels[ch].scan_type =3D (struct iio_scan_type) {
> +			.format =3D 's',

Will this cause a build failure?

Struct iio_scan_type defines the field as sign, not format. The original
code being replaced here correctly assigned the value using
channels[channel].scan_type.sign =3D 's'.

> +			.realbits =3D BYTES_TO_BITS(st->gyro[ch].size),
> +			.storagebits =3D BITS_PER_TYPE(u32),
> +		};
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512012302.2088=
3-1-natalia.andre@ime.usp.br?part=3D2
