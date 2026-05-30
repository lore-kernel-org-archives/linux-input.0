Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3FE1D54FA
	for <linux-input@vger.kernel.org>; Sat, 30 May 2026 00:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780101918; cv=none; b=CsxUJPkSoNbU2NbSETutXShOj0cZp1ueqbwWWxzbBCiZ3hnNLEjfq098Ho9T+lVXnQ50BG5FX14Otl8plk8Q/92C/fYKGw12q/+0XVSarKpmHxkwgOfHmLRqIozKgDkOneNUU3AXZPKg2y9Xo7C5Jb3t9Ql7VQLK+l8uvVO3kEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780101918; c=relaxed/simple;
	bh=n405LEmMEUnZ9EzJBbcHNB2zvB09jo1M7oq4JUWG04Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UtcgiMT+uGloo9ik/mNGNadcjiT8aQqlF3vEnoMgoDDU55Pv+NXySzW2FqZ3UN/CLkOuXJAI3rc/AD2Y4NbJSs94uS6HQYPsgI1dG2N1I+pyxKwXo9d2YnL0oLkREp0vPyxSlc9jre+3wwQBdfio/E1zBJnGSxCcrDpQYZAVYlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=akd5ozNb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="akd5ozNb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EAAC1F00893;
	Sat, 30 May 2026 00:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780101917;
	bh=iOdyJDf35ffNiIS6B9e38OhXh6RT2MYMJgd2b/+GjqY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=akd5ozNb3dA1rBO6IXdNUhHjKBUXpbJAnhhgcLN8kJIAmaPBDMefsX1EjR5YKOR4y
	 DKARmR8zCLRCWH4PDzi+wk8aDN9SWXiA7nOknjPrmUH+iveLh/PDbn0/GFvN/cODW/
	 HLv6SDyhlAILCdkNK+zCpz/sdvN30/8mlu5opO9k9FBkZPVrZt5/xS60JeW4gI7vHL
	 y6+Ac/fXsOLtUUdeijYWflYF6iLPgl6JmdhQD+6ypx/WlZxS/aLefArmgerC2OS2OQ
	 qLDLrX/KEYtxAx1ZGnoU9eq4WkDWuGo9EXtAdgyMxBoZZMM7Und+V8rAr+N6REUX1f
	 pqVZl2EwWqTfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/10] [v2] mips: select legacy gpiolib interfaces where
 used
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260520183815.2510387-6-arnd@kernel.org>
References: <20260520183815.2510387-6-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 00:45:17 +0000
Message-Id: <20260530004517.6EAAC1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] Duplicate `select GPIOLIB` in `config MIPS_ALCHEMY`.
- [Low] Unnecessary `select GPIOLIB_LEGACY` for `config MIKROTIK_RB532`.
--

commit 0726793f1a39f1a0b2ac5d24243bcbe5e8999b93
Author: Arnd Bergmann <arnd@arndb.de>

mips: select legacy gpiolib interfaces where used

This commit updates several old mips machines that have not been converted
away from the old-style gpiolib interfaces to select CONFIG_GPIOLIB_LEGACY.
This ensures the legacy code continues to work where needed but can be
omitted otherwise.

> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 4364f3dba688f..b91e62d69a5db 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -206,6 +206,8 @@ config MIPS_ALCHEMY
>  	select CSRC_R4K
>  	select IRQ_MIPS_CPU
>  	select DMA_NONCOHERENT		# Au1000,1500,1100 aren't, rest is
> +	select GPIOLIB
> +	select GPIOLIB_LEGACY

[Severity: Low]
Is this select GPIOLIB a duplicate? It appears select GPIOLIB is already
present further down in the MIPS_ALCHEMY block.

>  	select MIPS_FIXUP_BIGPHYS_ADDR if PCI
>  	select SYS_HAS_CPU_MIPS32_R1
>  	select SYS_SUPPORTS_32BIT_KERNEL

[ ... ]

> @@ -999,6 +1003,7 @@ config MIKROTIK_RB532
>  	select SWAP_IO_SPACE
>  	select BOOT_RAW
>  	select GPIOLIB
> +	select GPIOLIB_LEGACY

[Severity: Low]
Does this select GPIOLIB_LEGACY introduce an unnecessary dependency for
MIKROTIK_RB532? A look at the code indicates that MIKROTIK_RB532 and its
associated drivers (like pata_rb532_cf and rb532_button) use the modern
descriptor-based gpiod API and do not seem to call the legacy GPIO function=
s.
Could this dependency be omitted so we don't compile legacy interfaces
unnecessarily?

>  	select MIPS_L1_CACHE_SHIFT_4
>  	help

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520183815.2510=
387-1-arnd@kernel.org?part=3D5
