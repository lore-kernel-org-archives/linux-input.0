Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9F7572693;
	Wed,  9 Sep 2026 15:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788968889; cv=pass; b=QDU9G+SBdCW2s6Opnq9l9G/KFKxYhbZEYKXSFzjyJeBtpBkXbn06J94ZbU2fRlMzzhpIoOyIUJSb8VLDFC7PBaBexTJUBQiR0w0NXvSicQssa7RSiPBMG1r9r8IoLD0CAWJAhs4jlKmrmambE5+Ea6NABbmS6SE+Ss0dEkyd5jY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788968889; c=relaxed/simple;
	bh=1WHu6Hc9Jk1lAvAKxEchkOqNKezm6LoV4VOS1wDm8MQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0WA3FDqHyHK316CRTjbQkpUYj7wkxN8tJDiJDNVo/PzwJ4A3Ia7SDD69dWSEZRXssfHSx/2Ls5VEH2jocz9HkGmi93Gnfyh8UhggawX+Un30HTqN85VOjBYC9r+L0BfG2FYAzwyUs45V8N9Gv/1PAihi+P8Bcb7tFmk+Yb+XnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=QK9PzuPu; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="QK9PzuPu"
ARC-Seal: i=1; a=rsa-sha256; t=1788968850; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LrNzaX7Q840JJMB22boDRMC4XbmiCXA37gNpa578E+fzZjLt4A+nukYAlA9Df2BaLC7CWgUf6+IU8BT9hMO9vRDfjnyo+MpHbnoB9zuaZX+EAxwsVGbr69mI66nXIuPXJXW59o7Ui0tvWRgxyc6sAlneJtqlRKaXBULfpIV7OUQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1788968850; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=pE7m7m2sBB5ewZCKug+UN71/5f27jp3fJnMB4dlTatU=; 
	b=T3zLm6V/V1CyF92gtMOjqhUnvmbQ87vAAOjSDUGeov26rGLxk1jR9PkMDtqgz8zqCyNd9s4+X/ncqjedqXLVdJEh69MKUib4DNZFsztCRXhl0IgcKoCMSUssdjG+vjOdH3Q29LKW79Q6xcAUwZsx31gVfcz2hZV4Kt3HW2AuIhs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788968850;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=pE7m7m2sBB5ewZCKug+UN71/5f27jp3fJnMB4dlTatU=;
	b=QK9PzuPuYguldW4zRPZuX/PxYYe7H5UaLIKA4Myro5mVihkb8oyjDNFtaSfo7bGc
	+59RM1jk+7fc0gozUFD98ZXHehTgg7k9PdbQ61Ks5qY+OgcSc6EMo9uj99nNfvythuq
	FICikCNYNnWe6xQ3Mw6nUy/LipiPEdmal8Cku4JU=
Received: by mx.zohomail.com with SMTPS id 178896884950669.76921172500283;
	Wed, 9 Sep 2026 08:47:29 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 412E7183377; Wed, 09 Sep 2026 17:47:21 +0200 (CEST)
Date: Wed, 9 Sep 2026 17:47:21 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Lee Jones <lee@kernel.org>, mfd@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Arnd Bergmann <arnd@arndb.de>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Guenter Roeck <linux@roeck-us.net>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@kernel.org>, 
	Michael Hennerich <michael.hennerich@analog.com>, Support Opensource <support.opensource@diasemi.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org, 
	linux-doc@vger.kernel.org, linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, patches@opensource.cirrus.com, linux-watchdog@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	llvm@lists.linux.dev
Subject: Re: [PATCH 11/14] mfd: remove unused wm8350 driver
Message-ID: <aqF_aeDd8oTZaiRR@venus>
References: <20260909132153.1596191-1-arnd@kernel.org>
 <20260909132153.1596191-12-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6jecggrki5ootgjo"
Content-Disposition: inline
In-Reply-To: <20260909132153.1596191-12-arnd@kernel.org>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/288.959.6
X-ZohoMailClient: External


--6jecggrki5ootgjo
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 11/14] mfd: remove unused wm8350 driver
MIME-Version: 1.0

Hi,

On Wed, Sep 09, 2026 at 03:21:48PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> This driver was used on the i.MX31 ADS reference board from Freescale
> and the smdk6410 reference board from Samsung. Both used platform_data
> based driver probing and are now gone from the kernel.
>=20
> Since probing with devicetree has never been supported by wm8350,
> it is clear that nothing can use the driver on an upstream kernel,
> and it is unlikely that anyone is still interested in a devicetree
> conversion, so remove it.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  Documentation/hwmon/index.rst                 |    1 -
>  Documentation/hwmon/wm8350.rst                |   30 -
>  .../watchdog/watchdog-parameters.rst          |    7 -
>  MAINTAINERS                                   |    1 -
>  drivers/gpio/Kconfig                          |    7 -
>  drivers/gpio/Makefile                         |    1 -
>  drivers/gpio/gpio-wm8350.c                    |  144 --
>  drivers/hwmon/Kconfig                         |   10 -
>  drivers/hwmon/Makefile                        |    1 -
>  drivers/hwmon/wm8350-hwmon.c                  |   92 -
>  drivers/leds/Kconfig                          |    8 -
>  drivers/leds/Makefile                         |    1 -
>  drivers/leds/leds-wm8350.c                    |  267 ---
>  drivers/mfd/Kconfig                           |   15 -
>  drivers/mfd/Makefile                          |    4 -
>  drivers/mfd/wm8350-core.c                     |  444 -----
>  drivers/mfd/wm8350-gpio.c                     |  217 ---
>  drivers/mfd/wm8350-i2c.c                      |   64 -
>  drivers/mfd/wm8350-irq.c                      |  542 ------
>  drivers/mfd/wm8350-regmap.c                   |  335 ----
>  drivers/power/supply/Kconfig                  |    7 -
>  drivers/power/supply/Makefile                 |    1 -
>  drivers/power/supply/wm8350_power.c           |  590 ------
>  drivers/regulator/Kconfig                     |    7 -
>  drivers/regulator/Makefile                    |    1 -
>  drivers/regulator/wm8350-regulator.c          | 1330 -------------
>  drivers/rtc/Kconfig                           |   10 -
>  drivers/rtc/Makefile                          |    1 -
>  drivers/rtc/rtc-wm8350.c                      |  474 -----
>  drivers/watchdog/Kconfig                      |    8 -
>  drivers/watchdog/Makefile                     |    1 -
>  drivers/watchdog/wm8350_wdt.c                 |  171 --
>  include/linux/mfd/wm8350/audio.h              |  620 -------
>  include/linux/mfd/wm8350/comparator.h         |  171 --
>  include/linux/mfd/wm8350/core.h               |  692 -------
>  include/linux/mfd/wm8350/gpio.h               |  356 ----
>  include/linux/mfd/wm8350/pmic.h               |  775 --------
>  include/linux/mfd/wm8350/rtc.h                |  265 ---
>  include/linux/mfd/wm8350/supply.h             |  129 --
>  include/linux/mfd/wm8350/wdt.h                |   24 -
>  sound/soc/codecs/Kconfig                      |    5 -
>  sound/soc/codecs/Makefile                     |    2 -
>  sound/soc/codecs/wm8350.c                     | 1638 -----------------
>  sound/soc/codecs/wm8350.h                     |   25 -
>  44 files changed, 9494 deletions(-)
>  delete mode 100644 Documentation/hwmon/wm8350.rst
>  delete mode 100644 drivers/gpio/gpio-wm8350.c
>  delete mode 100644 drivers/hwmon/wm8350-hwmon.c
>  delete mode 100644 drivers/leds/leds-wm8350.c
>  delete mode 100644 drivers/mfd/wm8350-core.c
>  delete mode 100644 drivers/mfd/wm8350-gpio.c
>  delete mode 100644 drivers/mfd/wm8350-i2c.c
>  delete mode 100644 drivers/mfd/wm8350-irq.c
>  delete mode 100644 drivers/mfd/wm8350-regmap.c
>  delete mode 100644 drivers/power/supply/wm8350_power.c
>  delete mode 100644 drivers/regulator/wm8350-regulator.c
>  delete mode 100644 drivers/rtc/rtc-wm8350.c
>  delete mode 100644 drivers/watchdog/wm8350_wdt.c
>  delete mode 100644 include/linux/mfd/wm8350/audio.h
>  delete mode 100644 include/linux/mfd/wm8350/comparator.h
>  delete mode 100644 include/linux/mfd/wm8350/core.h
>  delete mode 100644 include/linux/mfd/wm8350/gpio.h
>  delete mode 100644 include/linux/mfd/wm8350/pmic.h
>  delete mode 100644 include/linux/mfd/wm8350/rtc.h
>  delete mode 100644 include/linux/mfd/wm8350/supply.h
>  delete mode 100644 include/linux/mfd/wm8350/wdt.h
>  delete mode 100644 sound/soc/codecs/wm8350.c
>  delete mode 100644 sound/soc/codecs/wm8350.h

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

--6jecggrki5ootgjo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmqhf4gACgkQ2O7X88g7
+prKqQ/+PXcHDDMXmArFWKzxhSxHAA3VwPIx07accUNhGecv9r7U8GAjiSQlBv5d
gojcqTyZ5UKCZQ/g6DCGOzwb9lsRDx5njdMXtyZJUq2Z68YBxbCiKa8iGezkGRAp
e/rO3HJlQdPs8dvggypfYz+HN/YpOMf/hF9JmgvQI4KR1TYt3RLXavSVQBsb/TMk
7faKB1EKAYYbJQi+b5fc/iSfNIqxl/Rf+g8VEQtxjSmDafmeLGNJhgS+Amd/CF6i
nKYmkKALE2Xq6riwBqtqbCazqplJsGsSxWK1qmhfDZs53Ws0+VgYi5N86Qard8Oy
V8+cITjYwZlOVoRIwSs1roLjdGZFn87iPLEmTmGgBcXtjNMPh5uj4x2+vvhVwW+Y
0K+Gx3s85iJURMTCZUYqPCI+3fhsU4KQ13g4nf3DAiab3GCtlS8FfH1P+RGHJU5n
4SAZgJ+DIk7nS4CEYeq3EZJacM7/IAMAdjE/IOSkfmY7ZPui71QXNASTru/d0K23
5HdYwbYghK1kj2Lb33geTv+TP5LXDsmvvWGDnMTlf5mna6YUdyAvMtgEtF0VDtUV
CUWngQHAxaSKC2DRfTeqP6/vjUww9bj6oDpUicbnz8BrEags3kzaJWKtFqGUs7M9
n0wbYmjflYmAe/mK+1CsH7p2TuMiqpvc9pc06lXO/85PySPEqNI=
=bCBv
-----END PGP SIGNATURE-----

--6jecggrki5ootgjo--
