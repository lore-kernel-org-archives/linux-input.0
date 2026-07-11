Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FFF284690
	for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 11:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783771132; cv=none; b=UrsOzMD9w02WkcePEOiN5XuxY+oMcmzBD+/OHb//rhvyBHI5wxhZPhWk4AcVT8CsyfzyZESWS2rbWrUmS8ok4NHoMG5zo1TdFagh4VFepitB2XDnos2a0tYj75ZkmrqKqV1DNiAdZbqMzNc2W0E/kBaKO0yMZwgBi6VL8xbb9+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783771132; c=relaxed/simple;
	bh=wqVsBaiVQBaGIlev+489g2UjG4pYuoHTvoupTig0kcI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jyjid6vtopelmwY5/rAkZlXdpb+3imT+mq3P01uDWvmemFuaEB3fISTSOIcrgQ+jwUn7/AmIdBunsKQmxSsmqrzMg0Gm+dojEii9rhuXc+ewGofN62EC4UJvTDbPutH12ubdGkLmborS7ofMRIGVcdbcveJuxen9+bupDgJ3oAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ciPOkHU3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ciPOkHU3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBF941F000E9;
	Sat, 11 Jul 2026 11:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783771130;
	bh=2fBFfsbCgYBvXrARUc75D0JavfXAZ5kyJ1GW/KzjMN0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ciPOkHU3sH5Ko0TI9UZI9Pu/cKlJnHfaaR+68twmLtWZ4VRXVJdl7wBovpo8NopUV
	 NrUrmoMA14gmw7tjgwDlSgvsVWD8xlQJJZcEBpQu415JkaZOQEVh0pagiZDNFtLj/k
	 UwTHym8Hl2BoypdZuzmrT5ngdbTA5XerYsMe8lhRbkJd/l0l8ROxUSZ7VqCfE2q9k6
	 y5Tl/YD8lg359krRMwXMT+iINCL13yGwCnZmUycQk5QSJzotpzX/eq1Dg+X1IvXCGg
	 vy6PTjzcoL1cJGV27q+I5NIHeFgHaULdDZGLdusBeVH9B2g2yjNSGNluMZi2U+vNB6
	 yhfeHilJ6yzUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/3] spi: pxa2xx: disable DMA for Apple MacBook8,1
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shih-Yuan Lee" <fourdollars@debian.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260711114937.16670-4-fourdollars@debian.org>
References: <20260711055247.5412-1-fourdollars@debian.org>
 <20260711114937.16670-1-fourdollars@debian.org>
 <20260711114937.16670-4-fourdollars@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 11:58:50 +0000
Message-Id: <20260711115850.BBF941F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly introduced `force_pio` module parameter is ignored on =
Merrifield (MRFLD) SPI controllers.
--

--- Patch [3]: [PATCH v4 3/3] spi: pxa2xx: disable DMA for Apple MacBook8,1=
 ---
commit 0c8e6fc35fa52622b2ece57fb64858693816478b
Author: Shih-Yuan Lee <fourdollars@debian.org>

spi: pxa2xx: disable DMA for Apple MacBook8,1

On MacBook8,1 (early 2015 12" MacBook), the LPSS SPI controller's DMA
handshake and interrupt routing frequently fail or time out on boot,
causing the keyboard and trackpad to become unresponsive.

Avoid this architectural bug by disabling DMA and forcing the SPI
controller to use PIO mode. Move this platform/motherboard-level quirk
to the SPI host controller driver (spi-pxa2xx-pci.c) where LPSS setup
occurs, preventing layering violations, TOCTOU races, or execute-after-free
bugs in the client driver.

Additionally, introduce a force_pio module parameter in the PCI
host controller driver to allow other users to force PIO mode for
debugging.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D108331

> diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
> index cae77ac185206..96bbc7a7c3817 100644
> --- a/drivers/spi/spi-pxa2xx-pci.c
> +++ b/drivers/spi/spi-pxa2xx-pci.c

[ ... ]

> @@ -166,7 +197,7 @@ static int lpss_spi_setup(struct pci_dev *dev, struct=
 pxa2xx_spi_controller *c)
> =20
>  	c->dma_filter =3D lpss_dma_filter;
>  	c->dma_burst_size =3D 1;
> -	c->enable_dma =3D 1;
> +	c->enable_dma =3D pxa2xx_spi_pci_can_dma(dev);
>  	return 0;
>  }
> =20

[Severity: Medium]
What about mrfld_spi_setup()? It looks like the force_pio module parameter
introduced in this patch is only respected for LPSS devices.

If a user boots a Merrifield (MRFLD) system and passes
spi_pxa2xx_pci.force_pio=3D1, the parameter will be ignored since the driver
still hardcodes DMA enablement in mrfld_spi_setup():

drivers/spi/spi-pxa2xx-pci.c:mrfld_spi_setup() {
    ...
	c->dma_filter =3D lpss_dma_filter;
	c->dma_burst_size =3D 8;
	c->enable_dma =3D 1;
	return 0;
}

Could mrfld_spi_setup() also use pxa2xx_spi_pci_can_dma(dev) to ensure
the parameter works consistently across all devices supported by this drive=
r?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711114937.1667=
0-1-fourdollars@debian.org?part=3D3
