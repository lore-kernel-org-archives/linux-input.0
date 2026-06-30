Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2553641325C;
	Tue, 30 Jun 2026 13:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782826122; cv=none; b=RJOXjvSipuoHVlmZ74j9md5K0PU0RGgpEcFmqtKeh3pDyVJlAT+UZtRv/sr/oHO2CawrNCNd42cArFjh7hSYPWM+mSc8VDvTZeGwpC+e8xMWgfBaQulS4KGFmojw03swav5Hu5l28xNETkid7src3Tzr+kPcDwl8yBkHzO8aojM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782826122; c=relaxed/simple;
	bh=jP89KHjMqZVGOQYjm1QE9cLHjPkTMrQEUaZGe8CHv78=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I/Dr4q2tIbiZMTy4qCrbV4ACiWE1ELPNRXnROwFg5FdoB5fl9ujkzQwA1zjN9j5vhKI+33H+KGug8ekmlns9fQ8efLUuCx4K5/cyFdUIgvw3nHQt+p8fV1ZSVNP9G3aqX26mVeNLvLxDpBzi8TiHFEGKGaNakQCFILOubRrQ5GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iG3u1SBL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iG3u1SBL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A34C11F000E9;
	Tue, 30 Jun 2026 13:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782826120;
	bh=8DKqQjskTei8Td8AwrI9HvuwJR8wJP8F7KDBX2D9dyw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iG3u1SBLiCxgDkCpculo+tXEp4eKcCS21FTnZBlFfXD9j3rvzKckjlBKECqPevnq9
	 scd1yBu/G3Q3BNcQ4urPZBl34KQUNa/nJtw+A3Hul8AUrU1qQKKO79QU8dvPZSR6sg
	 A5qmphD63yuF89b8vl28IxBP+TLu1A7SaBXt3knzJgx4OqPXr3+1ZXlNy971BwZlxc
	 QZN0qNR3VnNxJnExxMsLGAqV8kT097Wq5j0vJnVgk9pwNSf68AgVJe+3jXfw8eb+f1
	 6y9EUB6qT9CwedKXxMhP9eL05uko7LHRLii8IILdvqFeWw1SkG4JiqG2b57J4hy6JS
	 9oaowZhppvAmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/13] [net-next] net: replace linux/gpio.h inclusions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: vkoul@kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-sunxi@lists.linux.dev, neil.armstrong@linaro.org, olteanv@gmail.com, linux-phy@lists.infradead.org
In-Reply-To: <20260629132633.1300009-7-arnd@kernel.org>
References: <20260629132633.1300009-1-arnd@kernel.org>
 <20260629132633.1300009-7-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 13:28:39 +0000
Message-Id: <20260630132839.A34C11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Duplicate inclusion of `<linux/gpio/consumer.h>` caused by an unche=
cked find-and-replace.
--

commit cb55ce48e23e6753d04ac5f664585feb999f1fcd
Author: Arnd Bergmann <arnd@arndb.de>

net: replace linux/gpio.h inclusions

This commit replaces obsolete linux/gpio.h includes with linux/gpio/consume=
r.h
or linux/gpio/legacy.h across various network drivers where possible.

> diff --git a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c b/drive=
rs/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
> index 48b94ce774906..88c5c52e0e381 100644
> --- a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
> +++ b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
> @@ -16,7 +16,7 @@
>  #include <linux/net_tstamp.h>
>  #include <linux/ptp_classify.h>
>  #include <linux/ptp_pch.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>

[Severity: Low]
Does this create a duplicate include in pch_gbe_main.c?

Since linux/gpio/consumer.h is already included earlier in the file alongsi=
de
linux/gpio/machine.h, changing this include results in it being included
twice. Can this replaced include simply be removed?

> =20
>  #define PCH_GBE_MAR_ENTRIES		16

[ ... ]

> diff --git a/drivers/net/phy/mdio_device.c b/drivers/net/phy/mdio_device.c
> index 56080d3d2d25e..a18263d5bb029 100644
> --- a/drivers/net/phy/mdio_device.c
> +++ b/drivers/net/phy/mdio_device.c
> @@ -8,7 +8,7 @@
> =20
>  #include <linux/delay.h>
>  #include <linux/errno.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/gpio/consumer.h>

[Severity: Low]
Did the automated replacement result in consecutive duplicate includes here?

It looks like mdio_device.c already included linux/gpio/consumer.h right be=
low
the old linux/gpio.h include. Should we just drop the old include entirely
instead of replacing it?

>  #include <linux/init.h>
>  #include <linux/interrupt.h>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629132633.1300=
009-1-arnd@kernel.org?part=3D6
