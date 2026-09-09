Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E903546C1;
	Wed,  9 Sep 2026 13:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788961197; cv=none; b=CZlp8NAg5xKBk/+vTHfdtySsuOl7eopLayrPcvCnf6TF5DWUasgZb3UJ2tFXYwneQLX/A0ZI7i+4LmZwG+tzF6+e0Fo2zo1xP9FVVOOjNmba77QffY83yWCPilC8XYkQDx6RJs3G/ZbMw9etzEHLr6isUPtOsd9mZIsoNFFfdDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788961197; c=relaxed/simple;
	bh=Qmt4GMbfwdKRr8SEhI6qpGNVAp1O+4/XoQtd+QgAVcY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P/hj0Ivi4tJkIZ0EkHTJaeTs924TdCsVMHj57dMBZuHRlqz/NmkFv+z9K4J+foUm8Gjfn7DjEEGuWORGjVUMlltMJ5IoSGGcZP6WuTxu7OOzB+FkZ9Hp4ikZJZQoUf0ATDdRL2HKf4nVbIAmAp3zo7BKIBLhFBeeiosK6bWi1gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RStrXrZT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RStrXrZT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD5FC1F00A3A;
	Wed,  9 Sep 2026 13:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788961196;
	bh=3sx/8+b19P+3KuWUHTPZEvdaV3mA3HPGKEAeTZLTHcI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RStrXrZTIman062uHENY0up1qxLRqVdxLVc7Hgdi8R2nD9LEbyI3MHwB/9ZMq3BcU
	 za0ZlyaaYbuoce+GuN20I901SiNhfVoKKbn4wYLEfmED4SbVYhSVtZp9KntKdn3RfC
	 Px1MA/6QyDZwyUTnKCtcpR28hoyfhEDaKesLtzKmgacqjOIGHTIhicUPIfSqq5F+NQ
	 DIF9Th85HvMNr/pGNIkrj+3eZaG5RmcGjmGvoQU4nnMV7H1Zl00FLPwojCAMXGUdQ5
	 RwqIkxtt623oDC9N12qsnVhoQb2qxy8XVC7gayUq9D5HLSLTIA9laHndBnb9SyV/L4
	 /e2ZcpYzsOeqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/14] mfd: remove unused lp8788 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: linux-watchdog@vger.kernel.org, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, linux-leds@vger.kernel.org, robh@kernel.org, mfd@lists.linux.dev, media-ci@linuxtv.org, conor+dt@kernel.org, linux-hwmon@vger.kernel.org, dmitry.torokhov@gmail.com, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, lee@kernel.org
In-Reply-To: <20260909132153.1596191-8-arnd@kernel.org>
References: <20260909132153.1596191-1-arnd@kernel.org>
 <20260909132153.1596191-8-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 13:39:55 +0000
Message-Id: <20260909133955.BD5FC1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Incomplete cleanup: orphaned Makefile entry for `rtc-lp8788.o`.
--

commit b9b327cd8a968733772283e939af3a5d5a3cf637
Author: Arnd Bergmann <arnd@arndb.de>

mfd: remove unused lp8788 driver

This commit removes the unused lp8788 driver and its sub-device drivers
across multiple subsystems. The driver lacks devicetree support and has
apparently never been used upstream.

> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index ad5c9b8ceb242..0ce7c1a8f4517 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
[ ... ]
> @@ -317,12 +317,6 @@ config RTC_DRV_HYM8563
>  	  This driver can also be built as a module. If so, the module
>  	  will be called rtc-hym8563.
> =20
> -config RTC_DRV_LP8788
> -	tristate "TI LP8788 RTC driver"
> -	depends on MFD_LP8788
> -	help
> -	  Say Y to enable support for the LP8788 RTC/ALARM driver.
> -

[Severity: Low]
This patch removes the CONFIG_RTC_DRV_LP8788 symbol here, and also deletes
the drivers/rtc/rtc-lp8788.c source file. Should the corresponding build=20
rule in drivers/rtc/Makefile also be removed?

Currently, drivers/rtc/Makefile still contains this entry:
obj-$(CONFIG_RTC_DRV_LP8788) +=3D rtc-lp8788.o

Since the Kconfig symbol is no longer defined, it evaluates to an empty
string, leaving a dead configuration line in the build system.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909132153.1596=
191-1-arnd@kernel.org?part=3D7
