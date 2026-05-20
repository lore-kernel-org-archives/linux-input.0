Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2158113A3F7
	for <linux-input@vger.kernel.org>; Wed, 20 May 2026 00:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779237500; cv=none; b=uHJ7oaRHssiVIGC45GYk6XI8vAIiu56rZFDXv/DDbdHl0fw0OwiAnBo5x/IC7eZKxWEnqB0Py6EC1XBMdgpe0vwnNbdj2LAJ6Y5cncaz7e5Wz3nKPK/qrXT0Y0Bj4UC96pxXZtNNM3wDBTodxyvfZOJw5vLIybiXSdPF+rTauKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779237500; c=relaxed/simple;
	bh=W5N6r0JlZEpad1sR19esd6T9hMyih4jg2V7Tu0MXqv0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AIcJOjRTlnRpnswXsne/VyVvUfuBQANQXuYUT3dcQGHwKXCOT9gbDqnZf1dw+47vCHTGxjBVkp1vE+7ktU9JLa3W2pf+rMtO5MTd6n4l2b26Zo3VcY1Up6NhdSA/YWn4rcQBSAUvHBvy2wPR71iYYWXWHxFHSCNxHtSoAU+87n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XtMoKtX6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XtMoKtX6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8677C1F000E9;
	Wed, 20 May 2026 00:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779237498;
	bh=450dC+NORKMj07znGZ1o8dPrgNNakfv/ywb/itfqlro=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XtMoKtX6rimUWuE2JJPvXyiLeCE5t2o7i0c2yQHzs+XKZQ4rD3CWwpSxrJ9EEcsaF
	 FD/+33SFm04Db5MklDGQ1bvlWBjoSHcbNHoXc4yDWvxoAvFNdTi797vF6XOSkBiS36
	 7JfgnDfmkU6jk2x89DowSfQg2UjeudwCTrBrL81KiHAFmx0nWdrn1fkgNKFJWb2xiW
	 rual6bZQvrLBjVSbwzeqmfTZCcI3WxhiWLrU4YKHANXiCJL7OxXjxMRL2V/W0grG1C
	 JZKi0xgOepKgAqw3HijSVH0KcapCTyiRRmG4CisLU3iXt3/qgwJSxbOk3stN4R+8TN
	 1twTPqZVWMueA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/6] iio: light: HID: hid-sensor-als: Refactor
 channel initialization
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TmF0w6FsaWEgU2FsdmlubyBBbmRyw6k=?= <natalia.andre@ime.usp.br>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260519234752.23911-4-natalia.andre@ime.usp.br>
References: <20260519234752.23911-4-natalia.andre@ime.usp.br>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 00:38:18 +0000
Message-Id: <20260520003818.8677C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Incorrect member name `.format` used in `struct iio_scan_type` init=
ialization.
--

commit 6e85d51443d3e127d310915780d0c6f113e03de0
Author: Nat=C3=A1lia Salvino Andr=C3=A9 <natalia.andre@ime.usp.br>

iio: light: HID: hid-sensor-als: Refactor channel initialization

This patch refactors the channel initialization by replacing the local
function als_adjust_channel_bit_mask() with a compound literal to
initialize scan_type.

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

[Severity: Low]
Does struct iio_scan_type have a .format member? Looking at
include/linux/iio/iio.h, the member for indicating signedness is .sign, whi=
ch
was used in the original als_adjust_channel_bit_mask() code.=20

Will this cause a compilation failure due to an unknown field?

> +			.realbits =3D BYTES_TO_BITS(st->als[i].size),
> +			.storagebits =3D BITS_PER_TYPE(u32),
> +		};
>  		++index;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519234752.2391=
1-1-natalia.andre@ime.usp.br?part=3D3
