Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA3848E0E4;
	Wed,  9 Sep 2026 13:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788961705; cv=none; b=Nf76CZGQMbt6v4jK3EmKHp+aBRReEHwW7Y2MCm4RCOww2wWMMRsqK58TfsM00a62ss8cNNijdvpy64fHEhurVl/v/8a82D1xUcrX/x3spDbHTRcCxzI/ADgvfPmY6sD58t/Hjbm1SIjid2Dh9QoryDsKKMhAYqaw+mrf5I1mFik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788961705; c=relaxed/simple;
	bh=k4G1/gPcr9IBn4QKb9RO3EMPF1pv6O/TibdRj47ZmFs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PGXRjndQc41rvO2zDPPXZFZaq/z1yPYT/kGNepUCVSw9o+B84RfLC07DJcrx71k/ld/RmBLczr4Pj8i79ReQBN2Jn7Pbry3IOBBXulkYOOfd/bL5bRtHoGYzg32w7tHtbeOPGd4jHdLIZFj4ukbRvZ4Am8y5ZbHPRCm65X9lZt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YXPExu/8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YXPExu/8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3201F00A3D;
	Wed,  9 Sep 2026 13:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788961704;
	bh=P0LCF/vM4GtMw0rLBxXxpnT4vsixmrxsX4Y53vmwMNo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YXPExu/87zyaAeqylfvDy60HhdX15xPYW8SdTcSIUxSiOtSPStbXYo9C3hwDNIjeG
	 DJzl32EX3QKUz0XakM0cuf5rkze+2/jqH4JXgChC1dZ5lK5Gjt2xKOQM/F07qCdWRP
	 xbXodNiX9cxzCl8wniH+TmFmeS7avMoWcCGA1EITmMTVvCHmV+KLifWiIEfXBhGq9o
	 gEK3mNaAeyM6tWk37HEGC40qiT1akmvfMKEicD4/6uO0IypZ9vWadtzUKTtETm2Ddw
	 4cGNpGVJytJ1rGMz9mIA6FICV9wEK8og4f7F+50fPMnfcnfaBhgSguf1CpGl77cEie
	 G3Qiljl+C18RA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/14] mfd: remove unused mcp-sa11x0/ucb1x00 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: devicetree@vger.kernel.org, dmitry.torokhov@gmail.com, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, linux-hwmon@vger.kernel.org, lee@kernel.org, robh@kernel.org, dri-devel@lists.freedesktop.org, mfd@lists.linux.dev, linux-watchdog@vger.kernel.org, conor+dt@kernel.org, linux-rtc@vger.kernel.org, media-ci@linuxtv.org, linux-leds@vger.kernel.org, linux-input@vger.kernel.org
In-Reply-To: <20260909132153.1596191-13-arnd@kernel.org>
References: <20260909132153.1596191-1-arnd@kernel.org>
 <20260909132153.1596191-13-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 13:48:23 +0000
Message-Id: <20260909134823.AA3201F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The commit deletes headers `<linux/platform_data/mfd-mcp-sa11x0.h>=
` and `<linux/mfd/ucb1x00.h>`, but the SA1100 platform still exists and rel=
ies on them, causing build errors.
- [Medium] Referencing a removed Kconfig symbol `MCP_UCB1200` leaves the `c=
ollie_battery` driver as orphaned dead code.
--

commit 3e512215b27ee60439f00d2cbf7fccc06602c45a
Author: Arnd Bergmann <arnd@arndb.de>
Subject: mfd: remove unused mcp-sa11x0/ucb1x00 driver

This commit removes the MCP and UCB1x00 MFD drivers, along with their assoc=
iated platform data headers and Kconfig entries. The removal is based on th=
e premise that the sa1100 platform has been removed and these drivers are n=
o longer used anywhere.

> mfd: remove unused mcp-sa11x0/ucb1x00 driver
>
> The sa1100 platform has been removed, so these drivers are no longer
> used anywhere.

[Severity: High]
Is the sa1100 platform fully removed in this series? Looking at the tree,
arch/arm/mach-sa1100/assabet.c and arch/arm/mach-sa1100/collie.c still
exist and unconditionally include the headers deleted by this patch.

For example, arch/arm/mach-sa1100/assabet.c includes the headers and
instantiates the platform data:

#include <linux/platform_data/mfd-mcp-sa11x0.h>
...
static struct mcp_plat_data assabet_mcp_data =3D {
...

Since this commit deletes include/linux/mfd/ucb1x00.h and
include/linux/platform_data/mfd-mcp-sa11x0.h, does this cause a build
failure when compiling the assabet or collie boards?

[ ... ]

> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 8a3bbb6286933..0395af7270f9e 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -2258,30 +2258,6 @@ config MFD_QCOM_PM8008
>  	  under it in the device tree. Additional drivers must be enabled in
>  	  order to use the functionality of the device.
> =20
> -menu "Multimedia Capabilities Port drivers"
> -	depends on ARCH_SA1100
> -
> -config MCP
> -	tristate
> -
> -# Interface drivers
> -config MCP_SA11X0
> -	tristate "Support SA11x0 MCP interface"
> -	depends on ARCH_SA1100
> -	select MCP
> -
> -# Chip drivers
> -config MCP_UCB1200
> -	tristate "Support for UCB1200 / UCB1300"
> -	depends on MCP_SA11X0
> -	select MCP
> -
> -config MCP_UCB1200_TS
> -	tristate "Touchscreen interface support"
> -	depends on MCP_UCB1200 && INPUT
> -
> -endmenu
> -
>  config MFD_VEXPRESS_SYSREG
>  	tristate "Versatile Express System Registers"
>  	depends on VEXPRESS_CONFIG && GPIOLIB

[Severity: Medium]
Does removing the MCP_UCB1200 config symbol leave the collie_battery
driver as orphaned dead code?

Looking at drivers/power/supply/Kconfig, BATTERY_COLLIE depends on
SA1100_COLLIE && MCP_UCB1200. Furthermore,
drivers/power/supply/collie_battery.c still includes the now-deleted
include/linux/mfd/ucb1x00.h header.

If this Kconfig symbol is removed without cleaning up the power supply
subsystem, it causes an unmet dependency warning and leaves the battery
driver unselectable.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909132153.1596=
191-1-arnd@kernel.org?part=3D12
