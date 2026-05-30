Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F20D1EE01A
	for <linux-input@vger.kernel.org>; Sat, 30 May 2026 00:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780101919; cv=none; b=pakLNE3yrppgKiPYZHmMpFrEO2Y5tWI+IFi6rIkITF+AjoyLweo/V4NGDPeH3pP5871LC6k74RYBwLXMIaMM6661NQAgCsCCHefbaqNCIuSTofayV0vZJgKNs+vlrEht93S1ZI2snEDukiPev0KjvHFOCTNmG+wDGFvxCDdAa8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780101919; c=relaxed/simple;
	bh=wZ+fX4ActjEBrXWZk6Q6d8JSjBAR3/Bn6wIFqTRJmjQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CdAtlKV+7/9OuVAefngSEam/wlipswnHPvbj53oBwkkL3e4nTPM9ZGhwMQ0Iar+bopiZ3MjuASkqQoNLHH9jIBmMXn5YxCsZboy2ORjvtDczlURWarQVA3/yQWOvGVLVsuGCLNDQYexP+qfzheaYVfyOmP5MnpLMPll7QUkjSIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XBNehCVK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XBNehCVK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 009C71F00898;
	Sat, 30 May 2026 00:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780101918;
	bh=xYh2RfyKumEYow9QiSlRfhBFwCGTHZbhIWQEEuJeoVs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XBNehCVKtOfMxTVDCP+r4bHt8m8VZJO91vaIjoaz6BaOL1v2kd0EOM/WBFY+qs5CB
	 vyglv4Lz/7croHgryv/xRQptAqGvV30QXyCFRhyH5kmwhiTpLmV4S2rOfxyATs9NXB
	 2/2JDAavPFo0MITxu6l9PhyNCV37y92wXvHlW7cvflo+JuLVPoBnmCM6qYUNb1fOIw
	 RhtHM8Qua//GnRq1JmJ/9tIRnvkwnhonjg+rFPAg90uKFTDs/e5ArYDTC7a3WJ59HY
	 ws1dE10KowIoK8zeX2tQ9yGxmN2FeDWJ/G52parK5WvuRQabJLhLZMzuz0vP11g71b
	 PVcWSMI17jN3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/10] [v6 net-next] p54spi: convert to devicetree
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260520183815.2510387-9-arnd@kernel.org>
References: <20260520183815.2510387-9-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 00:45:17 +0000
Message-Id: <20260530004518.009C71F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] SPI transfers are using stack-allocated buffers for `tx_buf` and `=
rx_buf`, violating the SPI subsystem's DMA requirements.
--

commit 8ba2b2da7516b867a52706d993b9ce2d49c99105
Author: Arnd Bergmann <arnd@arndb.de>

p54spi: convert to devicetree
   =20
The Prism54 SPI driver hardcodes GPIO numbers and expects users to
pass them as module parameters, apparently a relic from its life as a
staging driver. This works because there is only one user, the Nokia
N8x0 tablet.
   =20
Convert this to the gpio descriptor interface and DT based probing
to improve this and simplify the code at the same time.

> diff --git a/drivers/net/wireless/intersil/p54/p54spi.c b/drivers/net/wir=
eless/intersil/p54/p54spi.c
> index 9d66dcae54e02..d18be25450285 100644
> --- a/drivers/net/wireless/intersil/p54/p54spi.c
> +++ b/drivers/net/wireless/intersil/p54/p54spi.c
[ ... ]
> @@ -30,19 +31,6 @@
>  MODULE_FIRMWARE("3826.arm");
>  MODULE_FIRMWARE("3826.eeprom");
> =20
> -/* gpios should be handled in board files and provided via platform data,
> - * but because it's currently impossible for p54spi to have a header file
> - * in include/linux, let's use module parameters for now
> - */
> -
> -static int p54spi_gpio_power =3D 97;
> -module_param(p54spi_gpio_power, int, 0444);
> -MODULE_PARM_DESC(p54spi_gpio_power, "gpio number for power line");
> -
> -static int p54spi_gpio_irq =3D 87;
> -module_param(p54spi_gpio_irq, int, 0444);
> -MODULE_PARM_DESC(p54spi_gpio_irq, "gpio number for irq line");
> -
>  static void p54spi_spi_read(struct p54s_priv *priv, u8 address,
>  			      void *buf, size_t len)
>  {

[Severity: High]
This isn't a bug introduced by this patch, but does this code use
stack-allocated buffers for SPI transfers?

It appears that p54spi_spi_read() and other similar functions pass stack
variables (e.g., addr in p54spi_spi_read(), rx_head in p54spi_rx(), and
val in p54spi_read32()) directly into spi_sync() as tx_buf and rx_buf.

If the underlying SPI controller uses DMA, the SPI core maps these buffers.
Using stack memory for DMA is unsafe because, with options like
CONFIG_VMAP_STACK enabled, the stack may not be physically contiguous.

Even without it, stack DMA leads to cache-line sharing and incoherency,
which can result in severe memory corruption or kernel panics.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520183815.2510=
387-1-arnd@kernel.org?part=3D8
