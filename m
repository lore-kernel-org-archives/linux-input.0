Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDC54219E8;
	Tue, 30 Jun 2026 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782826124; cv=none; b=LIJYtED5mJzHO4GFJF4onHLeoXHHjThiI/dp8JtgY8Z5DUUGPOVUKPbdA3BD8iPVmxZqfzKl7gKrMWh4ypuWEMYpynQsNIPwhjspRh4U9S8rjOC3G2nh6FRjdxIaMX/NrkOeb18SpO3RttG4HtPU/69WrPs15PCB0RpG8yFCiEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782826124; c=relaxed/simple;
	bh=mwiLLlab1AraJ2oXobzlrrABJwNTHHdY6faSFfy/GOw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JnBbMFGR0I4PB6E/QqJ/wTiCwUudvD1vfhqzOgXucN9XpkGQuBSXrkDtdVoOOdk2ViQt1g6Mi9O2BjY0EhcTr/mlkQ1ji6yxG9tqoxiNWVI2ufio/h9OxtYT9R11+C0owtNN4Eb+xBcdIm4vyS7VsV/1PTXL0iYcJAOQPSKavVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAO/nXJv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAO/nXJv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39AF01F000E9;
	Tue, 30 Jun 2026 13:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782826122;
	bh=StRupOAA1WebvV+A5T+jqB4tjQ20irjm2lrsEBfpF8Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GAO/nXJvCHd3vBWELfb6n5YGt2IfcN1m9XAOvnTtTGfJqzfUPbTTU96HBZkykgF62
	 nUmFKT4GOuaYZ9semtOlj2yo/pMpeZgYBo/kxaaA6UVkYE5t9TW7hVhp0E77EEPt+w
	 T8tEBQcgbeVs/zCU8nanMPXVzH0iiaKoDec/d8I3xojqCtEMKExkDWJeER3g9ICDqN
	 LUCdqqGX4Ikri4uOlJb0nnR1zt4x51Yw5sGSYt/PbPnbFA0VENy+2hKFmYUk3+fliv
	 trMYurfyNvlPRDjDOYofXaP9kHG5VYlDJTjNs6wU3oB9GP+6FtgrbDZ2/RK6/eJIN6
	 EBZmRYqxv9wbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/13] phy: replace linux/gpio.h inclusions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: neil.armstrong@linaro.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, linux-sunxi@lists.linux.dev, vkoul@kernel.org, linux-phy@lists.infradead.org, olteanv@gmail.com
In-Reply-To: <20260629132633.1300009-10-arnd@kernel.org>
References: <20260629132633.1300009-1-arnd@kernel.org>
 <20260629132633.1300009-10-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 13:28:41 +0000
Message-Id: <20260630132842.39AF01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Replacing `#include <linux/gpio.h>` with `#include <linux/gpio/cons=
umer.h>` results in duplicate include directives.
--

commit 172e670e08c06c1b704f9f5d80187a66ba9bb20c
Author: Arnd Bergmann <arnd@arndb.de>

phy: replace linux/gpio.h inclusions
   =20
linux/gpio.h should no longer be used, convert these instead to
either linux/gpio/consumer.h or linux/gpio/legacy.h as needed.

> diff --git a/drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c b/drivers/phy/broa=
dcom/phy-bcm-ns2-usbdrd.c
> index 8473fa5745296..d9c06129ed23e 100644
> --- a/drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c
> +++ b/drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c
> @@ -3,7 +3,7 @@
> =20
>  #include <linux/delay.h>
>  #include <linux/extcon-provider.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/gpio/consumer.h>

[Severity: Low]
This isn't a bug, but the replacement leaves us with consecutive duplicate
linux/gpio/consumer.h inclusions. Could the redundant include be removed?

[ ... ]

> diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wi=
z.c
> index 7531a8a049123..2233babc00781 100644
> --- a/drivers/phy/ti/phy-j721e-wiz.c
> +++ b/drivers/phy/ti/phy-j721e-wiz.c
> @@ -11,7 +11,7 @@
>  #include <linux/slab.h>
>  #include <linux/clk.h>
>  #include <linux/clk-provider.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/gpio/consumer.h>

[Severity: Low]
This isn't a bug, but similar to the broadcom phy driver, this creates
duplicate linux/gpio/consumer.h inclusions here as well. Should the second
one be dropped?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629132633.1300=
009-1-arnd@kernel.org?part=3D9
