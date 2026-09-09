Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385CE5616D4;
	Wed,  9 Sep 2026 13:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788961752; cv=none; b=SWIB6h8sHTs5bW/9tzw9ugVvZ9AohlAHj/gtJj/vWRvGwiHXtCX/TqaoL5b4rHh0FJiVn4UNb7qsyxrlalBDm4/cksG2uNyn1LZtnNcyiRyap/qQVnGMEP2UxQHfR2zbCBr2p5FM+nC0AaQ9HAmoslT1j7tPU/iFd3Q6OANftNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788961752; c=relaxed/simple;
	bh=rGnXHRCo/EauHzhR09qNfILwi1LUyO0ATm01L7YveoY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KX+6Dq+XtkKe3pOomktHasLuKg06Epa05GC6qlioS2FXeD3bQpSJvt7M+LG7p741yaaBCXtJ2uUAIdmF8aD+Crt5ElPsgUEgGZFjsbLgZDlDUYKBtcIpFreo+fL3UKFof+zfudfgXJATs/28Glyq0DM0Nl0aBL/XJfMJWmZH6/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZWGVuzS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZWGVuzS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A1C1F00A3D;
	Wed,  9 Sep 2026 13:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788961751;
	bh=hcgjalMECnLuMbthiuSDs90fSHJDbnvEcBIuT741nWU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eZWGVuzSPhslknQqCoR9lAStqAcZcrvV4O3xLFc5quRwUbL57naOMcok0Qmy7fZit
	 lxc6K/MXp/mLdczlXp504jd9ih+1gKf3IjwArYuIfm01VJ0OowpDnmKmMBDL/PDQ0+
	 7nCug01Qcp6nBKmF3aBpjwSLKFZsyVVk/rvAkipPDBfzUXiVrouf8pUdAlzSrm51ec
	 jxS1cjKOqxVb869Q/NF1v5rhLIU8SQiaaymnd+HO51p1s1jZuJn3RbKCEVMNdOaJso
	 KMTISRuD2zJ1DD9KsbB7wXuamNJsPX0e0LeEemtndfOx+4xhXB8fcNSbhgfdvfzhXd
	 yAk4pQRP7j/xA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/14] mfd: remove unused menelaus driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-watchdog@vger.kernel.org, linux-input@vger.kernel.org, linux-rtc@vger.kernel.org, conor+dt@kernel.org, media-ci@linuxtv.org, linux-leds@vger.kernel.org, robh@kernel.org, lee@kernel.org, devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org, dmitry.torokhov@gmail.com, mfd@lists.linux.dev, dri-devel@lists.freedesktop.org
In-Reply-To: <20260909132153.1596191-14-arnd@kernel.org>
References: <20260909132153.1596191-1-arnd@kernel.org>
 <20260909132153.1596191-14-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 13:49:09 +0000
Message-Id: <20260909134910.33A1C1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Low] Removing `include/linux/mfd/menelaus.h` breaks the build for `arch/=
arm/mach-omap2/` because the OMAP24xx platform and N8x0 board files were no=
t actually removed from the kernel.
- [Low] Selection of a non-existent Kconfig symbol (`MENELAUS`).
- [Low] Dangling file reference in the MAINTAINERS file and orphaned defcon=
fig entry.
--

commit a734289fbadac21de1944b368a0a47eb10c6d46e
Author: Arnd Bergmann <arnd@arndb.de>

mfd: remove unused menelaus driver
   =20
Menelaus was a companion chip for the omap24xx platform, which has
been remvoed from the kernel, so now the menelaus driver is unused
and can be removed.

> Menelaus was a companion chip for the omap24xx platform, which has
> been remvoed from the kernel, so now the menelaus driver is unused
> and can be removed.

[Severity: Low]
Is the omap24xx platform completely removed?

It looks like arch/arm/mach-omap2/board-n8x0.c and=20
arch/arm/mach-omap2/common-board-devices.h still exist and unconditionally
include the deleted header, which breaks the build for OMAP2 configurations:

arch/arm/mach-omap2/board-n8x0.c:
    #include <linux/mfd/menelaus.h>

arch/arm/mach-omap2/common-board-devices.h:
    #include <linux/mfd/menelaus.h>
    extern struct menelaus_platform_data n8x0_menelaus_platform_data;

This isn't a bug, but there's a typo (remvoed) in the commit message.

> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 0395af7270f9e..02e52398fcd28 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1893,16 +1893,6 @@ config TWL6040_CORE
>  	  additional drivers must be enabled in order to use the
>  	  functionality of the device (audio, vibra).
> =20
> -config MENELAUS
> -	bool "TI TWL92330/Menelaus PM chip"

[Severity: Low]
Does removing this config break Kconfig dependencies?

arch/arm/mach-omap2/Kconfig still selects this for ARCH_OMAP2PLUS_TYPICAL:

arch/arm/mach-omap2/Kconfig:config ARCH_OMAP2PLUS_TYPICAL
    select MENELAUS if ARCH_OMAP2

Selecting a non-existent symbol triggers a Kconfig warning.

[ ... ]

> diff --git a/drivers/mfd/menelaus.c b/drivers/mfd/menelaus.c
> deleted file mode 100644
> index a125d40fa121b..0000000000000
> --- a/drivers/mfd/menelaus.c
> +++ /dev/null
> @@ -1,1251 +0,0 @@

[Severity: Low]
Should the reference to this file in MAINTAINERS also be removed?

MAINTAINERS:
    F: drivers/mfd/menelaus.c

[ ... ]

> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index ec73533703f72..9dfe1ea08c250 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -570,15 +570,6 @@ config RTC_DRV_BQ32K
>  	  This driver can also be built as a module. If so, the module
>  	  will be called rtc-bq32k.
> =20
> -config RTC_DRV_TWL92330
> -	bool "TI TWL92330/Menelaus"

[Severity: Low]
Does this leave an orphaned defconfig entry?

arch/arm/configs/omap2plus_defconfig still references the removed config:

arch/arm/configs/omap2plus_defconfig:
    CONFIG_RTC_DRV_TWL92330=3Dy

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909132153.1596=
191-1-arnd@kernel.org?part=3D13
