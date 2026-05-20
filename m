Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9413728DC4
	for <linux-input@vger.kernel.org>; Wed, 20 May 2026 00:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779235443; cv=none; b=N918YCWGR/QMNeg15/YnKgMVeU+oxZnYn4UMe2sualPgk9SQ/EsNYCAJXoiOkp2EUvwCg/KzwqZalaIf1VWQ8agciv3/JA7wFqHPSfrC4g74t12h6FFL2EuljHpoyqPz43MH4WNyx+opX4hXL9sX23Onde9NV3yb+NdZstj7obY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779235443; c=relaxed/simple;
	bh=W9HBvWkmXoAsluouletR1EE8x4OBYB0NDu0P/yYaZlA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qWQP8Rf5AB0d3sRRXKVWbVoygt9xEee7OPrY8XniPqbAqLTs82oeVcXZSnt3MwftHF6OfkdcAmKJYA+QOPiCABrumQV4dFOPNy1s024y3DcdzU/EgbqzIe+x/9n039ym0rQvdB7SL15Ef32kBBcXnwVx2LUPZcxA6tjkR8LuDT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvvBpsJ7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvvBpsJ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB00A1F000E9;
	Wed, 20 May 2026 00:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779235442;
	bh=eyhg9M+M4J3WOCa2VakSkTcfWph/b4f8Ww5r8R8uim4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fvvBpsJ70zYOYl0fi5Lo5vOKP/LvJV8a3nx4KmJrYhQUFCyxXICIE0zuoDo3/6rRs
	 Pe4wC3fkTsKsmPWGLVLgn+4XfMi1h3fepx+Q/8Ned42bsxdoXE1z69wlZmAjnu01Fl
	 4lyDLJWjGEl9wNsNotCepK3PnaYi4Jo02qGSFXASNigaVLddVhgbE6fnH6LaN/Ywr4
	 PAS1/7b6m0kH9MH1OV9dYiwm8OF1CcOmnR5+8IHCHnWFYm0IRmZYXDrR50tDaU3M1r
	 aGAYDxoHTTl2oK+X4E7Z7KQWtIIljodFfv4hBCTq++WIAv0kGx3bJ+OrCuDQc7gr1r
	 KvqwihczmPA6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/6] iio: accel: HID: hid-sensor-accel-3d: Refactor
 channel initialization
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TmF0w6FsaWEgU2FsdmlubyBBbmRyw6k=?= <natalia.andre@ime.usp.br>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260519234752.23911-2-natalia.andre@ime.usp.br>
References: <20260519234752.23911-2-natalia.andre@ime.usp.br>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 00:04:01 +0000
Message-Id: <20260520000401.DB00A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch introduces a compilation error by using a non-existent fi=
eld `.format` instead of `.sign` in the initialization of `struct iio_scan_=
type`.
--

commit 5d0645bc673099b585d567599624c53910242efc
Author: Nat=C3=A1lia Salvino Andr=C3=A9 <natalia.andre@ime.usp.br>

iio: accel: HID: hid-sensor-accel-3d: Refactor channel initialization

Clean up the channel initialization loop and replace the local
accel_3d_adjust_channel_bit_mask() function with a compound literal
to improve code readability.

> diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/=
hid-sensor-accel-3d.c
> index 2ff591b3458f7..2bf05ab5235ef 100644
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
> +				HID_USAGE_SENSOR_ACCEL_X_AXIS + ch,
> +				&st->accel[ch]);
>  		if (ret < 0)
>  			break;
> -		accel_3d_adjust_channel_bit_mask(channels,
> -				CHANNEL_SCAN_INDEX_X + i,
> -				st->accel[CHANNEL_SCAN_INDEX_X + i].size);
> +		channels[ch].scan_type =3D (struct iio_scan_type) {
> +			.format =3D 's',

[Severity: Low]
Does this code result in a compilation error? Looking at struct iio_scan_ty=
pe
defined in include/linux/iio/iio.h, it contains a sign member but no format
member. Should this be .sign =3D 's' instead?

> +			.realbits =3D BYTES_TO_BITS(st->accel[ch].size),
> +			.storagebits =3D BITS_PER_TYPE(u32),
> +		};
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519234752.2391=
1-1-natalia.andre@ime.usp.br?part=3D1
