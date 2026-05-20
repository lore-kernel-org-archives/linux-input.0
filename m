Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1763403F3;
	Wed, 20 May 2026 19:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779305301; cv=none; b=U6t9PhvopX+SRvFgesE+YyyY8oh8R4nhAav5VAcZtXxrHzw2Rhuz/ckn/oKmxQnrQ9d/C5ZRmB6KxJpufJIPg+KdnvPoPn2OfG5T3czbQX/MRvKVHYXlXHq7HLGapxnMY/y03ERC6gg/8Yj5f4osZkXGcT8WTKvvxgp+dfViXyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779305301; c=relaxed/simple;
	bh=LmQ6lnqRA4s4CZ3Lbhu3jdZSE6S3hW7M7u/DZ7lLQlA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EwuUllNpSaRLK3uvmz9xY8eDzDKg8VXcYjeenqeuUe2aT5KxBLZfa9W6L0lec+bei6E936sbx8hGnSR/DxJwIdJENu0kWwpvCJSymR1uphuBtGVBblq+96tqP9xT72NH3I4SKfk0h5su/8zNiTxlWnAm/7vO/hYzBpZjfZzVQIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eebYPSnA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eebYPSnA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 629261F00894;
	Wed, 20 May 2026 19:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779305299;
	bh=R1p8w1drNI+AR0PuSgVW+GhI1+mq2HwsvaVlruKlb84=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eebYPSnAyKm43Fr10MfhwIXYUpFqqOZccQ+RzIvZ+/0ihK/+I2c5AnvTLiVIBHP34
	 vhtGIU8USMiSVSJbpuRCyW/Hwo1NYFhsJ/rVnF6V9g9BWy3YhKnczQKghNu42SzNmF
	 O0TL6I/6Wo88GehvVno2tznAx/6c6OzuVH2Q7a9FuTtirVf4Yh2XvZUWdJMCenp0th
	 Ol394Ltpr3MVAKRk6jOkZ1Vxy/496Gx0idIi1N2aPeVpTHRpMRuSEPPYygQsCxcaNl
	 u0pS38I5eZhtvzBCv4J1Q7Ro6xmltM/5+6VoxsQSftKNE7HeJNWui5zbb8JW7Fe3Zp
	 thkOOHq1L6Ddg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/6] mfd: motorola-cpcap: diverge configuration
 per-board
Reply-To: sashiko-reviews@lists.linux.dev
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260520182124.117863-6-clamor95@gmail.com>
References: <20260520182124.117863-6-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 19:28:18 +0000
Message-Id: <20260520192819.629261F00894@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Modifying the OF match table breaks backward compatibility wit=
h existing Device Trees.
- [Low] Casting a pointer directly to an enum causes a `-Wpointer-to-int-ca=
st` compiler warning on 64-bit architectures.
--

commit d4fffaca1e4a78c4406875cbdeef7c59b0fe0b1a
Author: Svyatoslav Ryhel <clamor95@gmail.com>

mfd: motorola-cpcap: diverge configuration per-board

This commit introduces board-specific subdevice configurations for the
Motorola CPCAP MFD. It defines common, default, and mapphone device lists
and uses SPI/OF match data to select the variant.

> diff --git a/drivers/mfd/motorola-cpcap.c b/drivers/mfd/motorola-cpcap.c
> index d8243b956f875..5b6ca6b81c232 100644
> --- a/drivers/mfd/motorola-cpcap.c
> +++ b/drivers/mfd/motorola-cpcap.c
[ ... ]
> @@ -241,62 +229,58 @@ static int cpcap_resume(struct device *dev)
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

[Severity: Low]
Does this direct cast from a pointer to an enum cause a compiler warning on
64-bit architectures?

spi_get_device_match_data() returns a const void *, which is 64-bit on
64-bit architectures, while enum cpcap_variant is typically a 32-bit intege=
r.
Casting directly from a 64-bit pointer to a 32-bit enum can trigger a
-Wpointer-to-int-cast warning and cause build failures when compiled with
-Werror.

Should the pointer be cast to an intermediate integer type like
(uintptr_t) or (unsigned long) first?

[ ... ]
> @@ -331,10 +315,29 @@ static int cpcap_probe(struct spi_device *spi)
[ ... ]
> +static const struct of_device_id cpcap_of_match[] =3D {
> +	{ .compatible =3D "motorola,cpcap", .data =3D (void *)CPCAP_DEFAULT },
> +	{ .compatible =3D "motorola,mapphone-cpcap", .data =3D (void *)CPCAP_MA=
PPHONE },
> +	{ /* sentinel */ }
> +};

[Severity: Critical]
Does this modification to the OF match table break backward compatibility w=
ith
existing Device Trees?

The Device Tree is considered a stable ABI in the kernel. This change reass=
igns
the existing "motorola,cpcap" compatible string to map to CPCAP_DEFAULT ins=
tead
of preserving its legacy behavior (which included Mapphone-specific child
nodes).

Older DTBs rely on "motorola,cpcap" to instantiate devices such as the batt=
ery
charger and Mapphone-specific ADC/regulator/USB-PHY. By mapping to
CPCAP_DEFAULT, the MFD core uses generic compatible strings (e.g.,
"motorola,cpcap-adc" instead of "motorola,mapphone-cpcap-adc") and entirely
omits the charger. As a result, the child devices fail to match their DT no=
des,
leaving them without of_node pointers and breaking critical functionality.

Additionally, could the complete removal of the "st,6556002" compatible str=
ing
(mentioned in the commit message) break devices relying on it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520182124.1178=
63-1-clamor95@gmail.com?part=3D5
