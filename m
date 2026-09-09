Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BA155D861;
	Wed,  9 Sep 2026 13:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788961172; cv=none; b=FQ7/l8xd1WOb91Pu4JGiUbaLPLzNWMz19c6BdUhAHtOCgSSLMvkpU3dv8xniTnSZTNA1P3kcdk8ugCi+9Ia+nEHj1cF5Aet3uZ2y6/F/uq3ueB4f0V7Q69wJGcVTfwJb55XPA0X/MsshjNjJ5ojTNGjtUGr/cJ76zzdmKaNMpy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788961172; c=relaxed/simple;
	bh=RjGEmAOTkb70wzd3z4FhjpKzRuYX57rlQIRzH7xyIX8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kyOi48aKelQxv68KkKdh9bdR8//2W6WTkKqyrKSrBsRQpgQOx4iicKuFKuczBvokfDac+GQYY+UxtyTw70DGQ9kyfLo7DqaZk/7n+zjYxMjT/3wrwGLfn04YBfg/RlM5yFYLp4xVcahZT0GpYrn02Z5Z2ou902f1IfPqt8xV7g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BE/vCTJ/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BE/vCTJ/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9A01F00A3D;
	Wed,  9 Sep 2026 13:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788961170;
	bh=8Xmtb0gjRJEnI8n7CoVdt4HiBVODVmmu+Ac+R1zAeGY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BE/vCTJ/j6D/E44YVipxZ3Z1cCFSOu08+uJttVjNF0h102Qsx3FyQREBYztVtUrkF
	 SUZNJ5S6RXYamB2+Fo6POTTv4WU4I6ofVBytwMqKI/LPPg+CaIgak3TOQD9ZM+kd/P
	 iwrdoVzCOzQzTVu/oCncRomNVfO3XQiHI3pCZTWyMJEqnKVwItS4m0hmrQOceU3nh2
	 GdppmWEZF2q+MF99akfiYGFh67l3OjAM4xVt2gP+N2viFsSDw1X60Gx5gHyUR4EQVx
	 zEp64ZmtKGMY4cXyqdCmK0sJLRPHnEzFMdoEk31mY+37X8ec5G8URIBHWVfVGFm3AV
	 S6r1jSzieeu9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/14] mfd: remove unused rc5t583 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: mfd@lists.linux.dev, lee@kernel.org, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, linux-input@vger.kernel.org, media-ci@linuxtv.org, conor+dt@kernel.org, linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org, robh@kernel.org, linux-leds@vger.kernel.org, dri-devel@lists.freedesktop.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260909132153.1596191-11-arnd@kernel.org>
References: <20260909132153.1596191-1-arnd@kernel.org>
 <20260909132153.1596191-11-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 13:39:29 +0000
Message-Id: <20260909133929.AB9A01F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Incomplete feature removal: the patch deletes the core MFD_RC5T583 =
driver and header, but leaves behind the GPIO driver and its Kconfig/Makefi=
le entries.
--

commit 311a4001bd9ad092f34b02c5b27077bd1e8dfc62
Author: Arnd Bergmann <arnd@arndb.de>

mfd: remove unused rc5t583 driver
   =20
The commit removes the Ricoh RC5T583 MFD, regulator, and RTC drivers
along with their header file due to the lack of platform data and devicetree
support.

> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 2cb2efafa8a48..fbcc45d2b0c40 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1291,20 +1291,6 @@ config MFD_RT5120
>  	  is targeted at providing the CPU voltage, memory, I/O and peripheral
>  	  power rails in home entertainment devices.
> =20
> -config MFD_RC5T583
> -	bool "Ricoh RC5T583 Power Management system device"
> -	depends on I2C=3Dy
> -	select MFD_CORE
> -	select REGMAP_I2C
> -	help
> -	  Select this option to get support for the RICOH583 Power
> -	  Management system device.

[Severity: Low]
Does this removal break Kconfig consistency and leave dead code in the tree?

The config GPIO_RC5T583 in drivers/gpio/Kconfig still depends on MFD_RC5T58=
3,
which violates Kconfig rules since the target dependency is now missing.

Additionally, drivers/gpio/gpio-rc5t583.c is left in the tree and still inc=
ludes
the deleted <linux/mfd/rc5t583.h> header, making it unbuildable, and its en=
try
is still present in drivers/gpio/Makefile.

Should the GPIO driver be removed in this patch as well?

> -	  This driver provides common support for accessing the device
> -	  through i2c interface. The device supports multiple sub-devices
> -	  like GPIO, interrupts, RTC, LDO and DCDC regulators, onkey.
> -	  Additional drivers must be enabled in order to use the
> -	  different functionality of the device.
> -
>  config MFD_RK8XX
>  	tristate
>  	select MFD_CORE

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909132153.1596=
191-1-arnd@kernel.org?part=3D10
