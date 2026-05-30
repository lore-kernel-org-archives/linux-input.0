Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDF672618
	for <linux-input@vger.kernel.org>; Sat, 30 May 2026 00:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780101919; cv=none; b=gVk/pYeP5ITxQTmoZgZB4HnfNQ5e9MOj6en9HsTl28lHhRTrgxAZ/rpleQTtbKRImewa1ht1Vu07MhQTr4SLZfL14q/6iceKzuqmP4i7FTMW/PfWGXj6/ez7YvoKccMiR1cx3jCyxVtp034Th7w6OpjFltnp4aJ5AECccgu8AAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780101919; c=relaxed/simple;
	bh=TqRF2zHTs0ErZh9ye9ZTjVO2zXVLd6KhyyFdLOMcvpc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V7SgkCKJ6iQNGCCQov8CO+7rXbDY6S+DzufLkOAHA5shQVwpBN14Dn0fzv9Q8T35Qu8kM2n7PNWzLidqSOl27HiLQWYt6iz7xEUzR8BnxOzR6Z94IiZOxG/3Ioeti7hsX9G0PCimMAa7VJpimLy/gbG9tOBPlSHFc+0BqeAzJ+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IPo25Kxt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPo25Kxt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E6AC1F00899;
	Sat, 30 May 2026 00:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780101918;
	bh=494guYzjo5NJ0bmEYUiPiiQ6mAhS5R2mACiCUC04Msw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IPo25KxtIDOS69Vftu/R9pbdmgf9yDXA+z/53dLOWsyD4LiELut1TLcm+w5Bm/X/L
	 4OzSJBPrQt5KhYrb28A7NhM6tnwq2luRkPuWMPTkMqTFR20eRNrSJI+ePkhqX+y08o
	 5aDqiGSs8i6AFVA6A3WxQEjeJkq+4jTgPRJO20UUI6pKpahRv1WrD4NmZpApBpDVhj
	 2sMuTOzVtL9H5D3eVYZU1Dp68CLU52Qaxxqhyfql0BknV+juIHpAXC1YMcWL1Sj7Jw
	 DP2jvFWcPYDvceb9Bvezipm8GXTaXxryF2HCNVEzdoWLDM1FEEn21G97BrIH3WVN+Q
	 S+E7WnlZTMwvw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/10] gpiolib: turn off legacy interface by default
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260520183815.2510387-11-arnd@kernel.org>
References: <20260520183815.2510387-11-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 00:45:18 +0000
Message-Id: <20260530004518.8E6AC1F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Turning off `CONFIG_GPIOLIB_LEGACY` by default will break the build=
 for multiple architectures and platforms that still rely on the legacy GPI=
O interface but do not select `CONFIG_GPIOLIB_LEGACY`.
--

commit a920fbf61a1d127c3a98b41cb32f7260acd5657b
Author: Arnd Bergmann <arnd@arndb.de>

gpiolib: turn off legacy interface by default

This commit removes the default enablement of GPIOLIB_LEGACY, requiring
platforms to explicitly select it if they still use the legacy interface.
It also adds a prompt to enable it manually for compile testing.

> All users of the legacy interface now select CONFIG_GPIOLIB_LEGACY,
> so it can be turned off by default and only get built on platforms
> that still have one unconverted driver.

[Severity: Low]
Is this statement accurate? There appear to be platforms like ARM PXA
(arch/arm/mach-pxa/spitz_pm.c), ARM Orion5x, and m68k Coldfire that still
contain direct calls to legacy GPIO functions like gpio_request() but do
not select GPIOLIB_LEGACY in their Kconfig files.

> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 020e51e30317a..543de15a12f63 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -4,7 +4,14 @@
>  #
> =20
>  config GPIOLIB_LEGACY
> -	def_bool y

[Severity: Low]
Will removing this default cause build regressions for the unconverted
platforms mentioned above?

It seems the legacy function declarations in include/linux/gpio.h will be
hidden, leading to implicit declaration errors when compiling those
architectures.

> +	bool "Legacy GPIO interfaces" if COMPILE_TEST
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520183815.2510=
387-1-arnd@kernel.org?part=3D10
