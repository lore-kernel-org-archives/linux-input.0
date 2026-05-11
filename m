Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4444537B007;
	Mon, 11 May 2026 22:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778537282; cv=none; b=Y4Ws81q8ahwhJNUXonUdvwqhOAr/kyhAjF0G85u9JnR9MUiwnyn7XwpZ0sKJX7wClSnn/Ul3+/XIZ3XheOGKhs+FYEhF2QtCXWKkq4gYUSF0E5H31+mYB5j28mC9y3pIiu8QmB78oRZcbJRkdmy2fSYi1SUwfVnNkjmTe0tlT0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778537282; c=relaxed/simple;
	bh=qV+sEcyheN+xpq669VQMOYxgIVmRunOC0yhExfObnl8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=vBWzNtxzVSh0SSj5qZ+Ojg4QWdEVF6P+7UGjoHsPmrAF3Yjz3F0MNvhc0Q3KFAE6STaAlG4Mmvf44Z0TmafjJwXxoJvar9s9VR8k7GmRmriYchG4RqAaashw/mfKSYdoaKE4B5o87XpWYZAKTAznGM+ySko8AccKp/WjuTXatPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vh+WWvNJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vh+WWvNJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 875A5C2BCB0;
	Mon, 11 May 2026 22:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778537281;
	bh=qV+sEcyheN+xpq669VQMOYxgIVmRunOC0yhExfObnl8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Vh+WWvNJMogwXJshzBy7sqOMRsr4IKVAPJ2TxvHV6FyEmufLE3l/L8veSnSsGIscT
	 KYQ+gjKnsCw0fDPxTzfulPhVDSpJlWkXqZKyZxMqE8pHfzXJUcb1gVPHw+lvUyNIPD
	 hyjp/1LO7pedh7/O/IY5FXzSMzMT+qn2bdjoJGM2RB5Px5AuU94SkJAfjOeOLwqqKz
	 LjIFNFFX8G6q9XuJFONUV5l8HhBgCyECZd/U7dl0mAEXOmZ26zGva1E/pLhrIuGCt8
	 JxAtMvobGsCJSb9kGKrXnt1WQQris57gbJjdje8Iflty3yLJNDuULwN31ZRg++qiUF
	 QwMzqhd4FOkhQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/6] mfd: motorola-cpcap: diverge configuration
 per-board
Reply-To: sashiko@lists.linux.dev
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, krzk+dt@kernel.org, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260510110804.33045-6-clamor95@gmail.com>
References: <20260510110804.33045-6-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 11 May 2026 22:08:01 +0000
Message-Id: <20260511220801.875A5C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Device Tree ABI breakage for existing Mapphone boards and legacy c=
ompatibles
- [Low] Compiler warning (-Wpointer-to-int-cast) on 64-bit architectures du=
e to direct pointer-to-enum cast
--

commit 31f4e82a2615f7d51f1707bf1ca43b9d741b3c90
Author: Svyatoslav Ryhel <clamor95@gmail.com>

mfd: motorola-cpcap: diverge configuration per-board

This commit separates the CPCAP subdevice configuration to support
different board-specific settings. It introduces a default composition
and renames the existing one for Mapphone boards.

> diff --git a/drivers/mfd/motorola-cpcap.c b/drivers/mfd/motorola-cpcap.c
> index d8243b956f875..f5a7fdd89dd5e 100644
> --- a/drivers/mfd/motorola-cpcap.c
> +++ b/drivers/mfd/motorola-cpcap.c
> @@ -195,20 +197,6 @@ static int cpcap_init_irq(struct cpcap_ddata *cpcap)
>  	return 0;
>  }
> =20
> -static const struct of_device_id cpcap_of_match[] =3D {
> -	{ .compatible =3D "motorola,cpcap", },
> -	{ .compatible =3D "st,6556002", },
> -	{},
> -};

Will existing device trees relying on the st,6556002 compatible string
fail to probe since it was removed from the match tables?

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

Could this direct cast from a pointer to an enum cause a compiler warning
(-Wpointer-to-int-cast) on 64-bit architectures?

spi_get_device_match_data() returns a const void *, which is 64 bits wide on
architectures like arm64, while enum cpcap_variant is typically a 32-bit
integer. Casting through a pointer-sized integer first might prevent this.

[ ... ]

> +static const struct of_device_id cpcap_of_match[] =3D {
> +	{
> +		.compatible =3D "motorola,cpcap",
> +		.data =3D (void *)CPCAP_DEFAULT
> +	}, {

Will this mapping break backwards compatibility for existing Mapphone board=
s?

Existing device trees use compatible =3D "motorola,cpcap" for the parent MFD
node, but define their child nodes with Mapphone-specific compatibles like
motorola,mapphone-cpcap-adc.

By mapping motorola,cpcap to CPCAP_DEFAULT, the driver now expects child
cells to use motorola,cpcap-adc. This means mfd_add_devices() might fail
to bind child platform devices to their DT nodes since
of_device_is_compatible() won't match.

If this happens, the child platform devices will be created with
pdev->dev.of_node =3D=3D NULL, completely breaking driver probing for subde=
vices
on existing boards.

Could motorola,cpcap continue to map to the historical CPCAP_MAPPHONE
configuration to preserve the ABI?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260510110804.3304=
5-1-clamor95@gmail.com?part=3D5
