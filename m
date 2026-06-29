Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AB21F2380;
	Mon, 29 Jun 2026 13:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782740775; cv=none; b=N4bYFMaEVmhjATtJjWc0RVEkX0nWbCNW2WKyev6lyFlg4H9hp/T0a8cSBPGUNQsVGGmnHv+wyBqDF82D9dBnhFEjbAzFBf0+ewTRYDdqbJ/Rfr1s6NK/3FuoWJorB+hjP9bfBjwaCVzgu0DXwxRcqAkBrkAsFAUtiFK5morx+8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782740775; c=relaxed/simple;
	bh=ycMCDqX2RofTZZbrE3vCaIyK13N1cECiyG9cwPgnbSM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XJBs2O8jwu3MYu5OCk56a+y0NChqNrfML9PMZQemWFxS3V2xEXTPKw08z14g6UeP0GQDppSLCtx+qMNx7i110YCPfPOlDXkz5M3BT9s1k2g3iYDJByyMbCHM3CLBKs8ldNaFmB0hv75Ig3XWXofK5yhku9WsCFP1O+5amUFlVWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5QfJu8I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5QfJu8I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F154B1F000E9;
	Mon, 29 Jun 2026 13:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782740774;
	bh=RK0XsgXnFviwdtIwWGULJYGL8GaNcz34XQuV4ICnbXc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m5QfJu8Iesfh7z8yBY26vpDQOS74+RnQEwaMXIW9Rrw+M6glF7H+VmgIDGXiXrV4f
	 6KGBKeiFJY9fXdA4Bbvys9OG7do4Nnd3+CunO+9yCf6acpGyL6MH7zaRcpCfBIrfw3
	 ySBkO/Hl8N6b9pvg3f5kmtgzKO8yfr6ZIJhMDCSQXFrklfCwWF84/Va+2GavIH6c2B
	 nWERl0rjSM4wzbNYVdEvTzKbqAxfvvpc5vL2Om978hgnYmvemmIUDIMu/731OSrLfp
	 4toUPEgT3w6TxOq3TLshpi17aJJZ5GRUzhPUN8VYJyFPsBh84+lvJe8HqoChzEDoFe
	 ZnLGmc6BAkFMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/6] [v5] gpiolib: turn off legacy interface by default
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: linux-input@vger.kernel.org, linux-leds@vger.kernel.org, dmitry.torokhov@gmail.com, lee@kernel.org
In-Reply-To: <20260629130329.1291953-7-arnd@kernel.org>
References: <20260629130329.1291953-1-arnd@kernel.org>
 <20260629130329.1291953-7-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 13:46:12 +0000
Message-Id: <20260629134613.F154B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Drivers depending on `GPIOLIB_LEGACY` rather than selecting it are=
 rendered unselectable and silently disabled on normal builds.
- [Low] Disabling CONFIG_GPIOLIB_LEGACY by default causes widespread build =
failures for platforms and drivers still relying on legacy GPIO functions.
--

commit bad1a2df68babe59200c7570528e8b8606464b68
Author: Arnd Bergmann <arnd@arndb.de>

gpiolib: turn off legacy interface by default

This commit changes the GPIOLIB_LEGACY configuration to default to 'n' inst=
ead
of 'y'. It restricts manual selection to builds where COMPILE_TEST is enabl=
ed,
intending to only build the legacy interface on platforms that require it.

> All users of the legacy interface now select CONFIG_GPIOLIB_LEGACY,
> so it can be turned off by default and only get built on platforms
> that still have one unconverted driver.

[Severity: High]
Is this description entirely accurate?

There appear to be drivers that use 'depends on GPIOLIB_LEGACY' rather than
selecting it, such as MFD_AAT2870_CORE, MFD_SI476X_CORE, and
SND_SOC_TLV320DAC33.

If GPIOLIB_LEGACY defaults to 'n' without COMPILE_TEST enabled, will these
drivers be rendered unselectable and silently disabled on normal builds?

> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 020e51e30317a..543de15a12f63 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -4,7 +4,14 @@
>  #
> =20
>  config GPIOLIB_LEGACY
> -	def_bool y
> +	bool "Legacy GPIO interfaces" if COMPILE_TEST

[Severity: Low]
Could disabling this by default cause build failures on legacy platforms th=
at
still call GPIO functions but do not explicitly select GPIOLIB_LEGACY?

For instance, arch/arm/mach-pxa/am200epd.c still uses gpio_request():

arch/arm/mach-pxa/am200epd.c:am200_init_gpio_regs() {
        ...
        err =3D gpio_request(gpios[i], gpio_names[i]);
        ...
}

Because include/linux/gpio.h excludes the legacy prototypes when
CONFIG_GPIOLIB_LEGACY is disabled, will this cause implicit declaration
compiler errors during standard builds for architectures like PXA?

> +	help
> +	  There are a few legacy platforms that use the traditional GPIO
> +	  number based interfaces instead of GPIO descriptors.
> +	  Say Y here to enable build testing drivers that are specific
> +	  to those platforms.
> +
> +	  If unsure, say N.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629130329.1291=
953-1-arnd@kernel.org?part=3D6
