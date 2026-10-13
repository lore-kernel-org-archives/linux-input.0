Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B01E3F3297;
	Tue, 13 Oct 2026 17:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791913392; cv=none; b=h92twzCej8wVtABe9KqXDC1GHmr+UB5IoR9vUBPuZFHRTb14rAVUA52qb7uZTSwwQ04reYWVUrJafpeRfMpdG7LQW547yr76OM+M9HL3n065ysG0o2f7gJ7Ok1zVtP6/ZZMTvOw0hIAo4BEx53uBezzzwyLO/qcciMzTOlpnnPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791913392; c=relaxed/simple;
	bh=BfLysc7irxR+XDTczYre+fCkPr8C+IBZcwMYjkmeQtc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=h/ihOc4VbHJ9jgaNA6Fuwrbb38IhSPCB1bbrYMxCNpY3xh7ZO99PmgYxF0xTFQHsAAposiX3FKz6RvVM7hwBDW/0KcesqXghbvls5FIllhGrQ+wzZ6uMYS/sF6mDzJknd4Wu0q2rQryIDJBnhoesHPP6B2XufSq8lAczTGb2rMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NfrvLbt+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfrvLbt+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54E1E1F00893;
	Tue, 13 Oct 2026 17:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791913390;
	bh=Clciui7Ad+2C/TJ///VSZeRTPX3odvcPRsa574mjyU4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NfrvLbt+WRBWlATlmsZyTNQE4XjAQjBUQ4Z5qn752zDqg4DLVR/LUgYixmSJWN5ke
	 NEYie6d7xQIR3GpqcojH00VhcuyxJcHWP1au7dqacibM0oV9W8w06TqKaukp6ZUEL1
	 rCnxkHVKTWkc+rP4qhQsZQqrmYRBPc+wWgF6Dtne37GErvhgeemXwaNDyaQuoXkUoF
	 QSC8dFvjKd2A0E9r5GQJxKDp2dL9nyP5SkiKRu4LRzWjPyhvxBItBvPOF1bE+7SQW2
	 rItRRSCcObgSuv5z53oDYOB/bEh0RLclHMIvFEuwQ/WWU3wxnDNihZfT7JtFd9zj9L
	 m45URVdJtyHZw==
Message-ID: <sashiko-outbox-170247@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 2/7] mfd: Add driver for ASUS Transformer embedded
 controller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: devicetree@vger.kernel.org, linux-input@vger.kernel.org, mfd@lists.linux.dev, linux-leds@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com, lee@kernel.org
In-Reply-To: <20261013173504.451391-3-clamor95@gmail.com>
References: <20261013173504.451391-1-clamor95@gmail.com>
 <20261013173504.451391-3-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 17:43:08 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] mfd: bespoke parent-child accessor and global shared header
- [Medium] mfd: hard-coded cell IDs instead of PLATFORM_DEVID_AUTO
--

commit b490e5f8ad65fb577857c831f5de2998a3c0d3de
Author: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>

mfd: Add driver for ASUS Transformer embedded controller

Support Nuvoton NPCE795-based ECs as used in Asus Transformer TF201, TF300T,
TF300TG, TF300TL and TF700T pad and dock, as well as TF101 dock and TF600T,
P1801-T and TF701T pad. This is a glue driver handling detection and common
operations for EC's functions.

> diff --git a/drivers/mfd/asus-transformer-ec.c b/drivers/mfd/asus-transfo=
rmer-ec.c
> new file mode 100644
> index 0000000000000..37dcd1b77465d
> --- /dev/null
> +++ b/drivers/mfd/asus-transformer-ec.c

[ ... ]

> +int asus_dockram_access_ctl(struct i2c_client *client, u64 *out, u64 mas=
k,
> +			    u64 xor)
> +{
> +	struct dockram_ec_data *ddata =3D i2c_get_clientdata(client);
> +	u8 *buf =3D ddata->ctl_buf;
> +	u64 val;
> +	int ret =3D 0;

[Severity: Medium]
Does this introduce a bespoke parent-child accessor?

The MFD architecture guidelines strictly prohibit writing bespoke accessors=
 or
helper functions in the parent driver to pass state to child devices, as th=
is
creates tight coupling. Instead, child drivers should retrieve parent data
using standard APIs like dev_get_drvdata(pdev->dev.parent).

[ ... ]

> +static const struct mfd_cell asus_ec_tf101_dock_mfd_devices[] =3D {
> +	MFD_CELL_BASIC("asus-transformer-ec-battery", NULL, NULL, 0, 1),
> +	MFD_CELL_BASIC("asus-transformer-ec-charger", NULL, NULL, 0, 1),
> +	MFD_CELL_BASIC("asus-transformer-ec-led", NULL, NULL, 0, 1),
> +	MFD_CELL_NAME("asus-transformer-ec-kbc"),
> +	MFD_CELL_NAME("asus-transformer-ec-keys"),
> +};

[Severity: Medium]
Are these hard-coded cell IDs intended?

The MFD guidelines require using PLATFORM_DEVID_AUTO for automatic cell
indexing to avoid sysfs naming collisions and driver load failures. Here it
appears a hard-coded ID of 1 is assigned for the battery, charger, and led
subdevices.

[ ... ]

> +	/* Parent I2C controller uses DMA, ASUS EC and child devices do not */
> +	client->dev.coherent_dma_mask =3D 0;
> +	client->dev.dma_mask =3D &client->dev.coherent_dma_mask;
> +
> +	return devm_mfd_add_devices(dev, 0, cells, num_cells, NULL, 0, NULL);
> +}

[Severity: Medium]
Could we pass PLATFORM_DEVID_AUTO instead of 0 for the base id here?

Passing 0 bypasses auto-indexing and violates the MFD subsystem constraints
for cell identification.

> diff --git a/include/linux/mfd/asus-transformer-ec.h b/include/linux/mfd/=
asus-transformer-ec.h
> new file mode 100644
> index 0000000000000..d09d3b70171ef
> --- /dev/null
> +++ b/include/linux/mfd/asus-transformer-ec.h

[ ... ]

> +/**
> + * struct asusec_core - public part shared with all cells
> + *
> + * @model: firmware version running on the EC
> + * @name: prefix associated with the EC
> + * @dockram: pointer to Dockram's i2c_client
> + * @notify_list: notify list used by cells
> + * @keyboard_mask: mask of keyboard packets
> + */
> +struct asusec_core {
> +	const char *model;
> +	const char *name;
> +	struct i2c_client *dockram;
> +	struct blocking_notifier_head notify_list;
> +	u8 keyboard_mask;
> +};

[Severity: Medium]
Is this shared structure and header required in the global include director=
y?

This appears to violate the MFD API layering guidelines, which state that
driver-specific header files should not be included in the global
include/linux/mfd/ directory if they are only used by the parent and its
immediate children. They should be kept local to drivers/mfd/ to avoid
tight coupling.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013173504.4513=
91-1-clamor95@gmail.com?part=3D2
