Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207B7353A96;
	Tue, 21 Jul 2026 10:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784629385; cv=none; b=EqfAwyU9qytaf2cH/UZJR9q3FxOzSdO09qf7xwvCipM6nv2MEtgJ+19ltuOjaoCD5C7qs0+e7ouwe6irNJMyuT2awO5iONMV/ozBbrFtBdl+vdWY9FIpjvTT6CfghZd6u3Cm7bkjsp2BN8mzadnG05kJhvKdHXjOCVYdk5dwm3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784629385; c=relaxed/simple;
	bh=FUyf2M7U4ewp+BWl4dtsfxAH+SMGKE1eOfuZvYV0Wms=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=USKVGbBvsBvMXUSLS3quwDBUx/Yicafmitr4iDH47hxxxtT8X24jjDRCDlnTVtaUMB9d4pxsq6FGnvaRiShBQIyIVQIkgov/fg0pUblHn/9NKg3y03bNNPjj9fF0bU4EVg0xje1vXz45O72g2pnmxcL8Ct9KychMmBrSjOpcMJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVqC0+US; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVqC0+US"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50AB81F000E9;
	Tue, 21 Jul 2026 10:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784629383;
	bh=JCrfb0sTApC31dXA8SwE48Ksr7nPzGKeiWOWP1y09C0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TVqC0+USVTEkF6cKlZ1JL3SxsfZnyg7Nc5ZygzuCcJT2JsLt98CavytTQlOE0GM65
	 0CyBUb+Cz3z/5eWlW4pc/m4BLoMMq7u4uqqeE9//iENL/qKlYzaWJTxlP9dP0HdKUu
	 P/J/+YXSXoDAyMIG53Aqchn7f8WxAESISF/CSecbIb0ryl8kKUDttZCaGXT5sFOHDK
	 LhhnYdt4QnfKLRX4ap4y7pJGpOMXuFzQzGXP/NpnKwa7KKfn8VgKMxwcujvmX1guYs
	 SQyQWS+qgC+LcCb0Vs416nWpqsNLoB/8BRojmVoVDGhrq8U37YZlieYQoubXYZ4hcz
	 l9rIOjDFrKJyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 5/6] mfd: motorola-cpcap: diverge configuration
 per-board
Reply-To: sashiko-reviews@lists.linux.dev
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: linux-leds@vger.kernel.org, lee@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260721095654.429346-6-clamor95@gmail.com>
References: <20260721095654.429346-1-clamor95@gmail.com>
 <20260721095654.429346-6-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 10:23:02 +0000
Message-Id: <20260721102303.50AB81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Removal of the 'st,6556002' compatible string breaks device tree b=
ackward compatibility.
- [Medium] Casting const void * to enum triggers a -Wpointer-to-int-cast wa=
rning on 64-bit architectures.
- [Low] The commit message description violates MFD subsystem capitalizatio=
n rules.
--

--- Patch [5]: [PATCH v7 5/6] mfd: motorola-cpcap: diverge configuration pe=
r-board ---
commit f5cc3529b5d7a3c2c11043bd5543be65ebce6656
Author: Svyatoslav Ryhel <clamor95@gmail.com>

mfd: motorola-cpcap: diverge configuration per-board

This commit modifies the CPCAP driver to support board-specific subdevice
configurations. It splits the MFD cells into common, default, and
mapphone-specific arrays. It also removes the legacy st,6556002 compatible
string.

> mfd: motorola-cpcap: diverge configuration per-board

[Severity: Low]
This isn't a bug, but the MFD subsystem guidelines request that the
description after the subsystem prefix be capitalized. Should "diverge" be
"Diverge"?

> diff --git a/drivers/mfd/motorola-cpcap.c b/drivers/mfd/motorola-cpcap.c
> --- a/drivers/mfd/motorola-cpcap.c
> +++ b/drivers/mfd/motorola-cpcap.c
> @@ -194,20 +196,6 @@ static int cpcap_init_irq(struct cpcap_ddata *cpcap)
>  	return 0;
>  }
> =20
> -static const struct of_device_id cpcap_of_match[] =3D {
> -	{ .compatible =3D "motorola,cpcap", },
> -	{ .compatible =3D "st,6556002", },
> -	{},
> -};

[Severity: High]
Does removing the "st,6556002" compatible string break backwards
compatibility for systems booting with older device tree blobs?

Device tree bindings are generally considered a stable ABI, so newer kernels
are expected to still probe devices using older DTBs.

[ ... ]

>  static int cpcap_probe(struct spi_device *spi)
>  {
>  	struct cpcap_ddata *cpcap;
> +	const struct mfd_cell *cells;
> +	unsigned int num_cells;
>  	int ret;
> =20
>  	cpcap =3D devm_kzalloc(&spi->dev, sizeof(*cpcap), GFP_KERNEL);
>  	if (!cpcap)
>  		return -ENOMEM;
> =20
> +	cpcap->variant =3D (enum cpcap_variant)spi_get_device_match_data(spi);

[Severity: Medium]
Can this direct cast from a pointer to an enum cause a -Wpointer-to-int-cast
build warning on 64-bit architectures?=20

spi_get_device_match_data() returns a const void *, which is 64-bit on
platforms like arm64. Casting it directly to a 32-bit enum might drop
the upper 32 bits. Should this be cast to a uintptr_t first?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721095654.4293=
46-1-clamor95@gmail.com?part=3D5
