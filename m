Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBEE13C9C4
	for <linux-input@vger.kernel.org>; Wed, 13 May 2026 03:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778643021; cv=none; b=VOsBH9wpZB693z8KLKZfQTzDeiKxxRceK8/DFNNsAxJ/2my40p9ezfM3h0UnIBaTKNSeVFLr7e10rWuAQBsfonBSC+du8m8YgIXTmWH4laqVPYQUz3Pp+6fmK28ab3jC13QlVdFa6WhOMaP2tqbg2qiOV/WNsGDlhG10V98wuIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778643021; c=relaxed/simple;
	bh=aEFdIHk3MupDfx2oL1ZTwCifLyRDTOv2AbRnTD9PDCE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kJQOk/sCM0929Iso8sV5S+4W70KrTy/7tG+jrlFOYxYfRO/lZVubpYuSUtqBYs7iNr/T/lVF2/xKHHHk3Sq5GdoYIrLb54MZH9ybOHxdaq++K79YplItARwpOhnB3olzrpgWaGK4r63rFX0B9iv7HYAl4Lcwq4KJ4XTcG2hpitU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MtGefa4p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MtGefa4p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE188C2BCB0;
	Wed, 13 May 2026 03:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778643021;
	bh=aEFdIHk3MupDfx2oL1ZTwCifLyRDTOv2AbRnTD9PDCE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=MtGefa4p/U9P18bUCBm4i4VQuABoSfqnx/3sXVCz0Uouylc7fvgmu1ff1jAZm+xiO
	 MqL3RtmyK3DV7s6dSCMBCJpdhSK1diVDR7yJfw0p67UTYpZzt6IshqfTtswIDvEg2J
	 +mk8b1CYaxHKm+6NWbPHD0y3oyPKimNlNwi5S28C9GOXtz5HUzEUEon8d6y6aub+Df
	 2EJFSXK/lKLljCeWn7rHYvdH7e3+ZhTAjywQO/Wb/dlHEoK66Y76q/A1eo6/b3ctGj
	 Zab4qcHBVdXVSWuKj0+/hoO5xn0cU9sp7Du4gIZH2NqzmiZBJ1bSKll+eLgkLsd9xw
	 i8wxA6G5HgVeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/6] iio: pressure: HID: hid-sensor-press: Refactor
 channel initialization
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TmF0w6FsaWEgU2FsdmlubyBBbmRyw6k=?= <natalia.andre@ime.usp.br>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260512012302.20883-7-natalia.andre@ime.usp.br>
References: <20260512012302.20883-7-natalia.andre@ime.usp.br>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 03:30:20 +0000
Message-Id: <20260513033020.CE188C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The struct iio_scan_type compound literal uses a non-existent field=
 `.format` instead of `.sign`.
--

commit a042b8c22df5e0522e82213c0d6f025b115babe7
Author: Nat=C3=A1lia Salvino Andr=C3=A9 <natalia.andre@ime.usp.br>

iio: pressure: HID: hid-sensor-press: Refactor channel initialization

This commit refactors the initialization of the pressure sensor's scan_type
by replacing a local helper function with a compound literal to improve
code readability.

> diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressu=
re/hid-sensor-press.c
> index 5f1d6abda3e40..a039b99d9851d 100644
> --- a/drivers/iio/pressure/hid-sensor-press.c
> +++ b/drivers/iio/pressure/hid-sensor-press.c
[ ... ]
> @@ -225,8 +215,11 @@ static int press_parse_report(struct platform_device=
 *pdev,
>  			&st->press_attr);
>  	if (ret < 0)
>  		return ret;
> -	press_adjust_channel_bit_mask(channels, CHANNEL_SCAN_INDEX_PRESSURE,
> -					st->press_attr.size);
> +	channels[CHANNEL_SCAN_INDEX_PRESSURE].scan_type =3D (struct iio_scan_ty=
pe) {
> +		.format =3D 's',

Is .format correct here? Looking at struct iio_scan_type in
include/linux/iio/iio.h, it appears the member for indicating the sign is
named .sign, not .format.=20

Could this assignment cause a compilation error due to a missing member?

> +		.realbits =3D BYTES_TO_BITS(st->press_attr.size),
> +		.storagebits =3D BITS_PER_TYPE(u32),
> +	};
> =20
>  	dev_dbg(&pdev->dev, "press %x:%x\n", st->press_attr.index,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512012302.2088=
3-1-natalia.andre@ime.usp.br?part=3D6
