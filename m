Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33144317163
	for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 06:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783749620; cv=none; b=p9qBgtrYqL1rT6abRPsJfGvj2LweMx1G0K+FBuejAEudjzXvFC2Z4bB3QX8l1D9f7sTuirzYtbrbk4DGkaQFIjCvfz0iXEjFNi33w5EuwaGwxDzOVR/upHqJdOKAcDyX8bvbxhM5wyRNnpjYsxf20pbisUzZPnFSBZDKnJWLCm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783749620; c=relaxed/simple;
	bh=RaUdLI6kDSFb7Jr+MUa4kKlMH02rymdHDwz9Yu3Mluw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jpWRYzq3TCqA9q5x9HDLpgNNdGwZdFnq2JcQ33M4TEpsbt2xNUgMHHeUciboidRYquIXnrwUC1Eb2eQOK4GwNl4WJBvK5R4dzM0DUjZaa1o041sJYx8+QXd+pN+Oji5J0lnWmWzABAjl1GzfeI43dAdJfpjWmTCdLJKamgAvUkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iBco7uPL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iBco7uPL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9558C1F000E9;
	Sat, 11 Jul 2026 06:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783749618;
	bh=9WRhHh9OkFQ3VxH/EWI+qAPNM7yyCGj5MAiHicBTTyQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iBco7uPLS9xDrtmud7NNLxcnO2BAR6NI4a3yhHv7DuIUbFRmAL6I3JWCWV9KP5Ski
	 R07TJr9SylaragdM8/ugTWZbLvCD1E/EhAvyCDlIwMCR1LqOv3GtPAG7U1JXh5ibCi
	 gvaROKudKd6TTFm7kS8QzXYrHmMhNIBSOrlw+LHuX8MwdID+EzabkTx8X8pOOPFx4W
	 HnGC5mSlv1ioMiTv0Mi545xPY/UT6m5VqcejLWnmQ0XZwwBiOmZqBKo+YnZ34kKHN9
	 eWh7UouepFMDqlEg5vT4vpUc/fsgFD2eT15vHP6agZJPEvw5V8Tbhc5K4+62JgUXLY
	 b55NDiZHlE4Mg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/1] Input: applespi - force PIO mode on MacBook8,1
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shih-Yuan Lee" <fourdollars@debian.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260711055247.5412-2-fourdollars@debian.org>
References: <20260711055247.5412-1-fourdollars@debian.org>
 <20260711055247.5412-2-fourdollars@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 06:00:18 +0000
Message-Id: <20260711060018.9558C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The client driver improperly modifies the shared SPI host controll=
er's `can_dma` callback, causing an execute-after-free vulnerability upon d=
river unbind or probe failure.

Pre-existing issues:
- [High] Missing `cancel_work_sync(&applespi->work)` during driver removal =
leads to a Use-After-Free of the managed private data structure.
- [High] The `tp_dim` debugfs file can be opened by userspace before the to=
uchpad input device is fully initialized, causing a NULL pointer dereferenc=
e.
--

--- Patch [1]: [PATCH 1/1] Input: applespi - force PIO mode on MacBook8,1 -=
--
commit e15d04076e4b2b62df355b30d858accad86794ac
Author: Shih-Yuan Lee <fourdollars@debian.org>

Input: applespi - force PIO mode on MacBook8,1

On MacBook8,1 (early 2015 12" MacBook), the LPSS SPI controller's DMA
handshake and interrupt routing frequently fail or time out after warm
reboots. Address this by introducing a DMI quirk inside the probe function
that detects the MacBook8,1 model and overrides the controller's can_dma
callback to a custom helper that always returns false.

> diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/a=
pplespi.c
> index b5ff71cd5a701..edf81e3836122 100644
> --- a/drivers/input/keyboard/applespi.c
> +++ b/drivers/input/keyboard/applespi.c
> @@ -1605,6 +1606,13 @@ static void applespi_save_bl_level(struct applespi=
_data *applespi,

[ ... ]

> +static bool applespi_can_not_dma(struct spi_controller *controller,
> +				 struct spi_device *spi,
> +				 struct spi_transfer *xfer)
> +{
> +	return false;
> +}
> +
>  static int applespi_probe(struct spi_device *spi)
>  {
>  	struct applespi_data *applespi;
> @@ -1613,6 +1621,15 @@ static int applespi_probe(struct spi_device *spi)
>  	int sts, i;
>  	unsigned long long gpe, usb_status;
> =20
> +	/*
> +	 * MacBook8,1's SPI host controller DMA is broken (timeout errors).
> +	 * Force PIO mode by overriding the controller's can_dma callback.
> +	 */
> +	if (dmi_match(DMI_PRODUCT_NAME, "MacBook8,1")) {
> +		dev_info(&spi->dev, "Disabling DMA for MacBook8,1 SPI to force PIO mod=
e\n");
> +		spi->controller->can_dma =3D applespi_can_not_dma;

[Severity: High]
Could this overwrite of the shared SPI host controller's can_dma callback
cause a regression by leaving a dangling pointer if the applespi module is
unloaded?

Since applespi_can_not_dma() is a local function inside this driver, won't
subsequent SPI transfers by other devices on this bus attempt to execute
unmapped memory after this module is removed?

> +	}
> +

This isn't a bug introduced by this patch, but looking at applespi_remove():

drivers/input/keyboard/applespi.c:applespi_remove() {
    ...
    applespi_drain_reads(applespi);

    debugfs_remove_recursive(applespi->debugfs_root);
}

[Severity: High]
Does this teardown path miss a call to cancel_work_sync(&applespi->work)?

Because devres will free the applespi structure when applespi_remove()
returns, could an already pending or running applespi_worker cause a
use-after-free here?

This is also a pre-existing issue, but looking at applespi_tp_dim_open():

drivers/input/keyboard/applespi.c:applespi_tp_dim_open() {
    ...
    snprintf(applespi->tp_dim_val, sizeof(applespi->tp_dim_val),
             "0x%.4x %dx%d+%u+%u\n",
             applespi->touchpad_input_dev->id.product,
    ...
}

[Severity: High]
Can userspace open the tp_dim debugfs file before the asynchronous worker
has finished initializing applespi->touchpad_input_dev?

Since the debugfs file is registered synchronously during applespi_probe(),
could an early read trigger a NULL pointer dereference here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711055247.5412=
-2-fourdollars@debian.org?part=3D1
