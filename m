Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FEB242D67;
	Fri, 16 Oct 2026 20:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792183076; cv=none; b=osxKp7Lt+KfBrviiAOaZ5h7G5QrHfur6hqQp1/AKHonVrWeTinbIjHJSQUv5OVExA6cLPpqnm4rHM1lQnf2sdmzXjHX89jbHwqaDO3RFcs8IP2e2eR2G/0KX0LcvPzSE118IS1jzWwJUROVKPqG9TfkSrAjc81nkTxh9gZqGXQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792183076; c=relaxed/simple;
	bh=ZPPjnG2/Ysp+hy0+T/3mpTk5uYFv91hjvLHifurCnPI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=VKyvYgvpNjiSoHgpf3aclHN4ti/QG9S+LAzTjfCc0ptzkxIdtKEiV7LKYGmj0zTJZAJPmTlHwbDC8NbIcbFy3+C+9T04l2O3J5CKsgzxCZRpn+mqU6EWraqhwsNCFS0rfc0Qy62AfOcqem7mU9+hwJK6nkbAZ4Ylgeu/C3Rh9o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNPixDCK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNPixDCK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F09A1F000C5;
	Fri, 16 Oct 2026 20:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792183075;
	bh=bZAw7+7PvgA0WO/aS8bAWUUgFUmsMWx6e6O5Uj9bxwk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dNPixDCKrj5tTE9qdlcdt1QxDaX0vPdr+emtovEoR9enDCiD/l1UKGEdAoc4xuj/X
	 tqC2duYaat/rmyFwhaIEw5RrQ1oO9tWcKC/tatO8+a6pDv14Tf5RH/+i78zq24q+Vs
	 aVfSsKv/XPBq3G4zPQPEipvZzo3AUU6E550+V2EpygFAtFoUWRTtFUHxOoMBRn5LKH
	 pj7dGTuWYoWDm3iMbY9Bbr+FDo1I48+NG5H85W3Td7KT6hPVe6k5w39Rb+oSO5sxnQ
	 6tW/O1YkCzx+2mRk5xpSOqFsBRoVFD1Ia60fgjHMU/XZqqJ/7MGem9kJ0ONQdpHGjn
	 OWxqVQUwuh0pg==
Message-ID: <sashiko-outbox-174919@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dt-bindings: input: ti,ads7843: Allow SPI clock
 polarity
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fabio Estevam" <festevam@gmail.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261016203131.454640-1-festevam@gmail.com>
References: <20261016203131.454640-1-festevam@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 20:37:54 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] dt-bindings: input: ti,ads7843: invalid spi-cpol ignored by ads7=
846_probe()
--

commit d8ba40e3cdda072fca3161a79055b07f36780581
Author: Fabio Estevam <festevam@gmail.com>

dt-bindings: input: ti,ads7843: Allow SPI clock polarity

This commit adds the spi-cpol property to the ti,ads7843 device tree
binding schema to address a dtbs_check warning for the ads7846@0 node in
arch/arm/boot/dts/nxp/imx/imx27-eukrea-mbimxsd27-baseboard.dts.

> diff --git a/Documentation/devicetree/bindings/input/touchscreen/ti,ads78=
43.yaml b/Documentation/devicetree/bindings/input/touchscreen/ti,ads7843.ya=
ml
> index 1b58fc263dce8..24172d206d6da 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/ti,ads7843.yaml
> +++ b/Documentation/devicetree/bindings/input/touchscreen/ti,ads7843.yaml
> @@ -32,6 +32,8 @@ properties:
>      description:
>        GPIO handle describing the pin the !PENIRQ line is connected to.
> =20
> +  spi-cpol: true
> +
>    vcc-supply:
>      description:
>        A regulator node for the supply voltage.

[Severity: Medium]
Should spi-cpol be removed from the ads7846@0 node in
arch/arm/boot/dts/nxp/imx/imx27-eukrea-mbimxsd27-baseboard.dts instead of
being added to the properties block in
Documentation/devicetree/bindings/input/touchscreen/ti,ads7843.yaml?

The commit message states:

  Allow spi-cpol so the binding describes the existing configuration
  without changing its SPI mode.

However, in drivers/input/touchscreen/ads7846.c, ads7846_probe()
unconditionally clears SPI_MODE_X_MASK (SPI_CPOL | SPI_CPHA) and forces
SPI_MODE_0 before calling spi_setup():

  spi->bits_per_word =3D 8;
  spi->mode &=3D ~SPI_MODE_X_MASK;
  spi->mode |=3D SPI_MODE_0;
  err =3D spi_setup(spi);

Because ads7846_probe() overrides any polarity flags parsed from Device
Tree, the spi-cpol property in imx27-eukrea-mbimxsd27-baseboard.dts has no
effect on the operating SPI mode of the touchscreen driver, and removing it
from the DTS would not change the operational SPI mode.

Furthermore, the TI ADS7843, ADS7845, ADS7846, ADS7873, and TSC2046
controllers latch DIN on the rising edge of DCLK and shift DOUT on the
falling edge (SPI Mode 0: CPOL=3D0, CPHA=3D0). Allowing spi-cpol without
spi-cpha in the binding schema permits SPI Mode 2 (CPOL=3D1, CPHA=3D0), whi=
ch
does not match the hardware protocol or the forced SPI_MODE_0 configuration
in ads7846_probe().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016203131.4546=
40-1-festevam@gmail.com?part=3D1
