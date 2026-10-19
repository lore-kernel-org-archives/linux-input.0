Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93994C042B;
	Mon, 19 Oct 2026 10:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792405046; cv=none; b=GIrQ3LyphJVSO6+wwBhzDTWPJY+yOdZqNqq1Z4rql6HvE4HEdzW2b7QvoKVfuM8mOUHBbgmimVGJhB00+Y2cM++XJmGc8JAqa/sGsbLbqpeiXf/34OVC//LQ0IlJcUpzMk0vgehROxX1jBfcIhMx/2XDox7EEFE+lsxJmjDcrXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792405046; c=relaxed/simple;
	bh=FAHqsoUg2810z5rSDiRI7iF8uxpnaV/Znr69GSjc0/M=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=EdK01RnA7d5j4Hy4mgACygturVeV0xfI0H0MUwErKFnGpJGlweFA12NaZMYjyohQqVGGQmmIwEJun3MWbtPeGWgcxOVenBfzCQ0w8Le8+YYEfOwnIiaXJyX/QxSI7l37wB3bVlCjNU8VdlYnqMgOk3Azj4yu9JXm2xoV/JI0iGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1r6FQ/9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1r6FQ/9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C95C81F000C7;
	Mon, 19 Oct 2026 10:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792405045;
	bh=47htpg6vnn4atX2n39sDrqJNFndcLxxZM44tBWxj6RU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l1r6FQ/9qmu+xrL7fbZNO9KOJhgp0ie/QKysBYApmYb+8OqcdKInarNMXmmS1IGPw
	 zgajCxaRh/oexL86EGdIMYqrS1etd5ZIVVB0mfeJoiaV7RgpN8X95yxYEwh4V4AtzR
	 aI24LKi8dnEF5LRHClLvbrSCZavOC93uyGCkfQCd8HRYj7MkTnkaE1PIuKjEPrOePg
	 Vea0ENF30BPL39F28mkmCt7xVx7PVilrx4gEB4MR3hi7upnlV48cB23NVqMzmkOcd4
	 t5MpTDl7FvColJlf0Mu+I3qxaHSNPJwAmXK79StI6nHuy4oymP4DyxXflUlWUy41AF
	 Y4qn+iNWlIloA==
Message-ID: <sashiko-outbox-176970@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 2/7] mfd: Add driver for ASUS Transformer embedded
 controller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: devicetree@vger.kernel.org, linux-input@vger.kernel.org, mfd@lists.linux.dev, linux-leds@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com, lee@kernel.org
In-Reply-To: <20261019100406.103687-3-clamor95@gmail.com>
References: <20261019100406.103687-1-clamor95@gmail.com>
 <20261019100406.103687-3-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 10:17:24 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] mfd: asus-transformer-ec: hard-coded cell IDs instead of PLATFORM_D=
EVID_AUTO
--

commit 69f71ab310cf2527cceba8746f7a17bbb27f3ab4
Author: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>

mfd: Add driver for ASUS Transformer embedded controller

This commit adds an MFD core driver for the Nuvoton NPCE795-based embedded
controller found in ASUS Transformer series tablets and keyboard docks. It
handles I2C communication, firmware detection, interrupt notifications, and
sub-device registration.

> diff --git a/drivers/mfd/asus-transformer-ec.c b/drivers/mfd/asus-transfo=
rmer-ec.c
> new file mode 100644
> index 0000000000000..15942ea59fe1a
> --- /dev/null
> +++ b/drivers/mfd/asus-transformer-ec.c
> @@ -0,0 +1,569 @@

[ ... ]

> +static const struct mfd_cell asus_ec_sl101_dock_mfd_devices[] =3D {
> +	MFD_CELL_NAME("asus-transformer-ec-kbc"),
> +};
> +
> +static const struct mfd_cell asus_ec_tf101_dock_mfd_devices[] =3D {
> +	MFD_CELL_BASIC("asus-transformer-ec-battery", NULL, NULL, 0, 1),
> +	MFD_CELL_BASIC("asus-transformer-ec-charger", NULL, NULL, 0, 1),
> +	MFD_CELL_BASIC("asus-transformer-ec-led", NULL, NULL, 0, 1),
> +	MFD_CELL_NAME("asus-transformer-ec-kbc"),
> +	MFD_CELL_NAME("asus-transformer-ec-keys"),
> +};
> +
> +static const struct mfd_cell asus_ec_tf201_pad_mfd_devices[] =3D {
> +	MFD_CELL_NAME("asus-transformer-ec-battery"),
> +	MFD_CELL_NAME("asus-transformer-ec-led"),
> +};
> +
> +static const struct mfd_cell asus_ec_tf600t_pad_mfd_devices[] =3D {
> +	MFD_CELL_NAME("asus-transformer-ec-battery"),
> +	MFD_CELL_NAME("asus-transformer-ec-charger"),
> +	MFD_CELL_NAME("asus-transformer-ec-led"),
> +};
> +
> +static int asus_ec_probe(struct i2c_client *client)
> +{

[ ... ]

> +	/* Parent I2C controller uses DMA, ASUS EC and child devices do not */
> +	client->dev.coherent_dma_mask =3D 0;
> +	client->dev.dma_mask =3D &client->dev.coherent_dma_mask;
> +
> +	return devm_mfd_add_devices(dev, 0, cells, num_cells, NULL, 0, NULL);
> +}

[Severity: Low]
In asus_ec_probe(), devm_mfd_add_devices() is called with a hard-coded base
ID of 0, while asus_ec_tf101_dock_mfd_devices[] manually sets a cell ID of
1 via MFD_CELL_BASIC() for the battery, charger, and led subdevices to offs=
et
them from the pad EC cells (leaving kbc and keys at ID 0).

Could devm_mfd_add_devices() pass PLATFORM_DEVID_AUTO instead of 0, so that
asus_ec_tf101_dock_mfd_devices[] can use MFD_CELL_NAME() for all entries and
rely on automatic cell indexing without risk of platform device name
collisions in sysfs if multiple EC instances with identical cell IDs are
registered?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019100406.1036=
87-1-clamor95@gmail.com?part=3D2
