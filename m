Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CFF39D6DD;
	Tue, 30 Jun 2026 13:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782826118; cv=none; b=YeWMaaFj7/9Px/BbEBVV+OGVehTxSIzaxYn3TXSM05uHr5jcnuwIwChrEN1pcHzg2xWNVlOFqQQkVJOyhvrJ/WPA2Apl7Y/kS1tvE5SnluC1+RTHgR9wNImd3thptohjkG2/Y2t0/H71ozq91Q8CYxQST/Jyl/hneIdo/bf4H4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782826118; c=relaxed/simple;
	bh=IfYEpBhZ2VQERm67C/VQynCi3uKxj1p/0g1zR93Wy3k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t+9ULl3//7DZ8n1H9Vmxb5oiPWI6LqL0q4WimuD9hV3/1XRtorCxYqfFXp7KDLMFh0mDoRvD38RFYFfQoOh+cXOO484tjCE2lJQfau0KZD6BvgaflXFVVimOEu4bRSGyCSHbEqKGanqVpyxvRVEV3rWz7C70kHbJrf5Xs4Bq7ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gu88O8ie; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gu88O8ie"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF0A1F000E9;
	Tue, 30 Jun 2026 13:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782826117;
	bh=w7gjhOObn06IZwCF2h72/yM1H2nbVXiS2binvXxNAqg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gu88O8iebsZJCi1hNxtEIPFj1XOpyvcaqbQHSb3FMW8xOkENbkxbs5RbLQPoxLyOO
	 xVupTwOgiJdZ1SAAiTyHjULy3chcDk0ozGJ38zA8umJTrH4XaUGyHkV4AeP18PFUnt
	 s/u4bRKKKKSc8abAXMBe6bHFTIu+OpJP7t1y905wRh3uQsbPJWmNuPdnLnSYgpLCsR
	 z1+5ek6xYoWU4vZK2xf+rp0cSkXkZeeKTmHZvg+vxezY9WFjSJhnnTFoPYpttNZid/
	 zlzJtTOd1fm7YsC9t+Z3mYbP+X8VKQ9tIKWp+FEFeK+Dm3foOwE7t6sIm/WFSOkWtZ
	 XA5IPev8NVbFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/13] gpib: gpio: replace linux/gpio.h inclusion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: linux-phy@lists.infradead.org, linux-sunxi@lists.linux.dev, neil.armstrong@linaro.org, vkoul@kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, olteanv@gmail.com
In-Reply-To: <20260629132633.1300009-13-arnd@kernel.org>
References: <20260629132633.1300009-1-arnd@kernel.org>
 <20260629132633.1300009-13-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 13:28:35 +0000
Message-Id: <20260630132836.5FF0A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] The patch introduces redundant duplicate `#include <linux/gpio/cons=
umer.h>` statements in multiple files.

Pre-existing issues:
- [High] Missing bounds check on `priv->count` in `bb_DAV_interrupt()` can =
lead to a buffer overflow.
--

commit 198cff3fadd8f7ab5db98a0ff2a666f4ac7f1bf0
Author: Arnd Bergmann <arnd@arndb.de>

gpib: gpio: replace linux/gpio.h inclusion

linux/gpio.h is going away, so use linux/gpio/consumer.h instead.

> diff --git a/drivers/gpib/gpio/gpib_bitbang.c b/drivers/gpib/gpio/gpib_bi=
tbang.c
> index 0e227980b493a..2e8d895db06a5 100644
> --- a/drivers/gpib/gpio/gpib_bitbang.c
> +++ b/drivers/gpib/gpio/gpib_bitbang.c
> @@ -64,7 +64,7 @@
>  #include <linux/gpio/consumer.h>
>  #include <linux/gpio/driver.h>
>  #include <linux/gpio/machine.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>

[Severity: Low]
This isn't a bug, but does this introduce a duplicate include of
linux/gpio/consumer.h? It appears to already be included a few lines above.

Similar duplicate includes might have been added to other files like
drivers/input/keyboard/matrix_keypad.c and drivers/net/phy/mdio_device.c
if they were also part of this series.

>  #include <linux/irq.h>
> =20
>  static int sn7516x_used =3D 1, sn7516x;

While reviewing this file, I noticed a separate issue in bb_DAV_interrupt().

[Severity: High]
This is a pre-existing issue, but does this lack of a bounds check on
priv->count lead to a buffer overflow?

drivers/gpib/gpio/gpib_bitbang.c:bb_DAV_interrupt() {
        ...
        priv->rbuf[priv->count++] =3D get_data_lines();
        priv->end =3D !gpiod_get_value(EOI);
        ...
}

If the hardware line DAV goes low multiple times while priv->r_busy is set
without waiting for the normal NRFD/NDAC handshake, could priv->count exceed
the allocated buffer size and corrupt memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629132633.1300=
009-1-arnd@kernel.org?part=3D12
