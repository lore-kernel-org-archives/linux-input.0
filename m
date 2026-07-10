Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F2A3BFAD1;
	Fri, 10 Jul 2026 21:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783719340; cv=none; b=Luh58pfBee+uY925gxfcat/p1X/nMzT1fgfiPijqddL5iQ8FV8K7HHGznHPJivqQQbBChBXtsxJycqLjqGSqvNLj5qHW73aXtDVYDpuOSFPmh1vi1RE0LK92XSbrb+wOsdGgeBwIVNVjOfbHMcj4TWQGNRxMEhxl7q1I8NvjKFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783719340; c=relaxed/simple;
	bh=V4kgPQSc8K4Zo3Pq5H4OO4x4rBHh5iFPReI/ayyS/30=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ftShsM+vIqxAl+yo+tb8kIy4t7B64FR/oP9BIvfKu4I8eTRlpGumxExFAiF4kGLiP45lpnsXO6L8j+mYv7iE6WhLXqxS7o74kj/eRdhnFFM/oRUpogbMZt4TfMmIYYOy/05/YmybD1cEX40jQoQO/JpAdKEDVPh1+6x5GHKSGDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sf1LPH/3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sf1LPH/3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 872CD1F000E9;
	Fri, 10 Jul 2026 21:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783719338;
	bh=gUcdAN00xf/L23XBL4KYjYS87AgViYvbm6bXPWTc55Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Sf1LPH/3JDkHvvdSgKyWqmGqKmVNRnD6lIpz9lJZ0QUT27yis4Na/6VDAvvwVxV6A
	 RDGD68HVMoRTAnGBxy2YwMq4Yrff2VXxYn3l7XAjWKu3qaCUtB/4NTsoIqD0hycaXW
	 2BpsfDiLEE5OD7OhjbHFeH9LCxnZZ1HXs/rsTI0JPKBmcbhac44XMwMR3d4/Ugaze5
	 B2ujdQWY2HG7Y5z/Wq2ADQWxHHwpQW1iaNwBdteI9l8tWWG7PW+rwGma5kl0Bs7kky
	 /Oou6/NbubTPLNYrTNj6ZUZhubkR4HKTqPQRQMz7vYifBu9rbwaZlizZ/+XFSNoPrJ
	 CttN7PDI8thew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/6] [v6] gpiolib: turn off legacy interface by default
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, lee@kernel.org
In-Reply-To: <20260710211854.1371746-7-arnd@kernel.org>
References: <20260710211854.1371746-1-arnd@kernel.org>
 <20260710211854.1371746-7-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 21:35:38 +0000
Message-Id: <20260710213538.872CD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Drivers MFD_AAT2870_CORE, MFD_SI476X_CORE, and SND_SOC_TLV320DAC33=
 become silently unselectable on standard kernels because they still use `d=
epends on GPIOLIB_LEGACY`.
--

--- Patch [6]: [PATCH 6/6] [v6] gpiolib: turn off legacy interface by defau=
lt ---
commit c81360523a83f6de8b9f91867c27fb9f36e0da52
Author: Arnd Bergmann <arnd@arndb.de>

gpiolib: turn off legacy interface by default

This commit turns off the legacy GPIO interface by default, allowing it to
be enabled manually only for compile testing. It relies on the assumption
that all legacy users now select CONFIG_GPIOLIB_LEGACY.

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

[Severity: High]
Does this change silently disable MFD_AAT2870_CORE, MFD_SI476X_CORE, and
SND_SOC_TLV320DAC33 in production builds?

The commit message states that all users of the legacy interface now select
CONFIG_GPIOLIB_LEGACY, but it appears these drivers still depend on it
instead:

drivers/mfd/Kconfig:
config MFD_AAT2870_CORE
    ...
    depends on GPIOLIB_LEGACY

drivers/mfd/Kconfig:
config MFD_SI476X_CORE
    ...
    depends on GPIOLIB_LEGACY

sound/soc/codecs/Kconfig:
config SND_SOC_TLV320DAC33
    ...
    depends on GPIOLIB_LEGACY

Since GPIOLIB_LEGACY now defaults to n and its prompt is hidden without
COMPILE_TEST, won't these dependencies prevent the drivers from being
selected on standard kernels, causing their hardware to stop functioning?

> +	help
> +	  There are a few legacy platforms that use the traditional GPIO
> +	  number based interfaces instead of GPIO descriptors.
> +	  Say Y here to enable build testing drivers that are specific
> +	  to those platforms.
> +
> +	  If unsure, say N.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710211854.1371=
746-1-arnd@kernel.org?part=3D6
