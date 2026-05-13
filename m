Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DEC38A73F
	for <linux-input@vger.kernel.org>; Wed, 13 May 2026 02:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778638905; cv=none; b=MjBy31c8RMj9SGD61cyiI1rnimktMjhSj1gVIFzfiaT2YpgYV8DAExXeJYzIAqArDA6nYCb2+R5ShmjP9m0LCdzsbkhIYzakmjSbwukrmDxG02ObFqjPYCdGrQ5TAYJBTgHxZ81NDsn4e+iqFAOvGOwk4jgwAb47G1B3IFer0pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778638905; c=relaxed/simple;
	bh=i4mYmf7bqClxGkmFYhheW4to/zxaEemnZCjaIqzP10c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uE1nyGf4Nui75qREObPuRQv6CFThDx2oe+sHd8IICshUkdo/l2V7k47OUc+F6E5MT9UDmspU9DJU9fwzFNzwphxWJbRwJTrABv8BrP/al4K3CwrhfAq5yIR5+karV6hTA7DNWlLMUrJ7QMs3jnbgBEITTeGJQCkdcv/A2+T/dqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHcmU+29; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHcmU+29"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F84C2BCFD;
	Wed, 13 May 2026 02:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778638905;
	bh=i4mYmf7bqClxGkmFYhheW4to/zxaEemnZCjaIqzP10c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=jHcmU+29lL4RXm1WfvmRleO4kMZ9mb+jYvFngeSxOI9U6FLhEnPwOp/EsNYhH7qqw
	 1YPIzwYL7FC6EBbDPVrWxSZqJQUUf8Po9Ikzw9okTkgmTzBE4MMIdxrkDd1vPNH0oG
	 ntud4lM8vuJAHPaPL93qrViHyX7lpv5CsQP8eGgqkB7fQHvIt4D1H2v2XDc6gik7be
	 PDiHI1OWSayCavm7Xixr4995kK9dFgl3huJ/H7sNl4J5fXwPkXaoprICGNyaERJXVX
	 SnQ33mnU4GBltX2rRJzQCyzzRa6hVAKgpZujk1IUnIoIjbyyOgX6EGelZAFD9r+NCP
	 P+cLFom8oKIGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/6] iio: accel: HID: hid-sensor-accel-3d: Refactor
 channel initialization
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TmF0w6FsaWEgU2FsdmlubyBBbmRyw6k=?= <natalia.andre@ime.usp.br>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260512012302.20883-2-natalia.andre@ime.usp.br>
References: <20260512012302.20883-2-natalia.andre@ime.usp.br>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 02:21:44 +0000
Message-Id: <20260513022145.44F84C2BCFD@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Incorrect HID attribute usage ID passed to `sensor_hub_input_get_a=
ttribute_info()`, breaking device initialization.
- [Low] Invalid struct member `.format` used in `struct iio_scan_type` init=
ialization.
--

commit b8c3d6dce107c50c4bd37c0ec71526208891109a
Author: Nat=C3=A1lia Salvino Andr=C3=A9 <natalia.andre@ime.usp.br>

iio: accel: HID: hid-sensor-accel-3d: Refactor channel initialization

This commit cleans up the channel initialization loop in the HID 3D
accelerometer driver. It replaces a local helper function with a compound
literal to directly initialize the channel scan type configuration.

> diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/=
hid-sensor-accel-3d.c
> index 2ff591b3458f7..99ca67732bbe2 100644
> --- a/drivers/iio/accel/hid-sensor-accel-3d.c
> +++ b/drivers/iio/accel/hid-sensor-accel-3d.c

[ ... ]

> @@ -297,19 +287,20 @@ static int accel_3d_parse_report(struct platform_de=
vice *pdev,
>  				struct accel_3d_state *st)
>  {
>  	int ret;
> -	int i;
> =20
> -	for (i =3D 0; i <=3D CHANNEL_SCAN_INDEX_Z; ++i) {
> +	for (unsigned int ch =3D CHANNEL_SCAN_INDEX_X; ch <=3D CHANNEL_SCAN_IND=
EX_Z; ch++) {
>  		ret =3D sensor_hub_input_get_attribute_info(hsdev,
>  				HID_INPUT_REPORT,
>  				usage_id,
> -				HID_USAGE_SENSOR_ACCEL_X_AXIS + i,
> -				&st->accel[CHANNEL_SCAN_INDEX_X + i]);
> +				ch,

The fourth argument to sensor_hub_input_get_attribute_info() is the
attribute usage ID. Previously, this passed HID_USAGE_SENSOR_ACCEL_X_AXIS +=
 i.
Does passing the loop variable ch (which represents internal index values=20
like 0, 1, 2) prevent the driver from finding the accelerometer fields in=20
the HID report descriptor?

> +				&st->accel[ch]);
>  		if (ret < 0)
>  			break;
> -		accel_3d_adjust_channel_bit_mask(channels,
> -				CHANNEL_SCAN_INDEX_X + i,
> -				st->accel[CHANNEL_SCAN_INDEX_X + i].size);
> +		channels[ch].scan_type =3D (struct iio_scan_type) {
> +			.format =3D 's',

Does struct iio_scan_type have a format member? Looking at=20
include/linux/iio/iio.h, it appears the correct member name for this
field is sign.

> +			.realbits =3D BYTES_TO_BITS(st->accel[ch].size),
> +			.storagebits =3D BITS_PER_TYPE(u32),
> +		};
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512012302.2088=
3-1-natalia.andre@ime.usp.br?part=3D1
