Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B4338F95A
	for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 09:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783762219; cv=none; b=Oo1pFOS5wiupGO57u5LbNeZ/iqZXUTbhDw6/IymxYavGjA4Io1SVkO5bJrAut69l/QGClsD/bBJOIiZCWDd4GFifekY4f8ijDw6SkGfai3+mF8oCQ1NkgBIjizazBtdWx78wz1bA8Cw5xTDBaM1sBNUCU7KnlUSWXgKQRQmIcAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783762219; c=relaxed/simple;
	bh=AcfbLEdZ+JeN6ZjicBPNfODHnk67E7AZBU3XCDkqy/Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nAhWq/1m1o5JW/f0UcYRLJiYsppnRg+qDmmbgR39+C/aOx0heJ6BHsOrlBCWgpVnZFmNj1qstD+YCDMDQIVCynfPVw2wQT2JdU+rbsj88B98LediJXBrUJpg91DDD/9dMDv/OxXzjr5o0WmqN8el2++vvS9p3LhRKwVJI1C56eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVAYY1wz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVAYY1wz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C2C1F00A3A;
	Sat, 11 Jul 2026 09:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783762217;
	bh=+MBjTS7nRb/ZX3AVdRj/YLRtewdTOeuKOlHDdPj/v4E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TVAYY1wzkIRxVXhyOy/hT+jMkgKl1pV4TN5kjTJ+oSv20Qa482UObZndIBqpTRMi/
	 7A8LT1fBKXFcGa57KUnfQ0QFXfdfzv07tE6OsXeux6TNrqqnXtmE3nxSjeXAqoXJ4B
	 qXvYsT16mdRZNMkoPrcg8mu9N4WneXTfmZ7VVXFumHF6VVmBoU8jZyyNoKgtb9wGzn
	 BaoAvyPiic50BObC3FoA/7qRXBHU3p1PX+bNIHTSNLWk/1qCgANlsQktcHfCOXwkbg
	 N9QKDmZz8frKngKZMQUL/zIWE7LgdXjE8jOofzBN60NfSBOkRPykfsvNEAwZLc0TtV
	 8cTTBrqthMMOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] Input: applespi - force PIO mode on MacBook8,1
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shih-Yuan Lee" <fourdollars@debian.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260711092054.13818-2-fourdollars@debian.org>
References: <20260711092054.13818-1-fourdollars@debian.org>
 <20260711092054.13818-2-fourdollars@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 09:30:16 +0000
Message-Id: <20260711093017.50C2C1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The child device driver (`applespi`) overwrites the parent SPI con=
troller's `can_dma` callback, causing an architectural layering violation, =
data races (TOCTOU) with concurrent SPI transfers, and potential execute-af=
ter-free vulnerabilities upon module unload.

Pre-existing issues:
- [High] Race condition between manual cleanup and devres unregistration le=
ads to a Use-After-Free via `applespi->work`.
--

--- Patch [1]: [PATCH v3 1/3] Input: applespi - force PIO mode on MacBook8,=
1 ---
commit fb42db4427f33df07132a7b2bd913031f55465ea
Author: Shih-Yuan Lee <fourdollars@debian.org>

Input: applespi - force PIO mode on MacBook8,1

On MacBook8,1 (early 2015 12" MacBook), the LPSS SPI controller's DMA
handshake and interrupt routing frequently fail or time out on boot,
causing the keyboard and trackpad to become unresponsive.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D108331

> diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/a=
pplespi.c
> --- a/drivers/input/keyboard/applespi.c
> +++ b/drivers/input/keyboard/applespi.c
[ ... ]
> @@ -1628,6 +1645,13 @@ static int applespi_probe(struct spi_device *spi)
> =20
>  	applespi->spi =3D spi;
> =20
> +	/* Save original can_dma and override if requested or needed */
> +	applespi->original_can_dma =3D spi->controller->can_dma;
> +	if (override_dma) {
> +		dev_info(&spi->dev, "Disabling DMA for SPI to force PIO mode\n");
> +		spi->controller->can_dma =3D applespi_can_not_dma;

[Severity: High]
Is it safe for a child device driver to overwrite the parent SPI controller=
's
shared can_dma callback?

Modifying spi->controller->can_dma directly without a controller-wide lock
could cause a data race if the SPI worker thread concurrently dereferences
ctlr->can_dma for another device on the same bus.

> +	}
> +
>  	INIT_WORK(&applespi->work, applespi_worker);
[ ... ]
> @@ -1822,6 +1861,9 @@ static void applespi_remove(struct spi_device *spi)
> =20
>  	applespi_drain_reads(applespi);
> =20
>  	cancel_work_sync(&applespi->work);

[Severity: High]
This is a pre-existing issue, but does this create a use-after-free window
during module unload?

In applespi_remove(), the work is canceled, but the input and LED devices
are managed by devm_ and aren't unregistered until the devres release phase
after applespi_remove() completes.=20

During this window, if a user writes to the LED sysfs interface, it will
call applespi_set_bl_level() which calls schedule_work(&applespi->work),
re-arming the worker. When devres subsequently frees the applespi structure,
the queued work might execute on freed memory.

> +	if (override_dma)
> +		spi->controller->can_dma =3D applespi->original_can_dma;

[Severity: High]
Could restoring the can_dma callback without synchronization leave a dangli=
ng
pointer if multiple instances bind or unbind?

The restore happens conditionally based on a dynamically recalculated
override_dma boolean. If the module is unloaded but fails to restore the
pointer properly, a dangling pointer will remain in the shared SPI controll=
er.
The SPI core could then invoke the freed applespi_can_not_dma function insi=
de
the unloaded module, resulting in an execute-after-free.

> +
>  	debugfs_remove_recursive(applespi->debugfs_root);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711092054.1381=
8-1-fourdollars@debian.org?part=3D1
