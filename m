Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E622129E11A;
	Tue,  9 Jun 2026 04:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780980857; cv=none; b=f2n97bTuAf9i+epqtK5bAcjtxGwxDAHrnvBgI6DwQBsgaaWYaOdBw5dMxY2SgbRKjOtL5BOvfsZKv9QUOVJxEF0/YezGYvMJF4wD/Ef2p1+WJJkpP0toBn87EnDU++GL0FzacPQtJR/NSpc/Fpeh2f5IPR4VAYcPa86efSzIIJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780980857; c=relaxed/simple;
	bh=FKXuUS6PJ9Am2Gz9VsUy3l/mSos+LrY5EQ+9mheNTUk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d+ilZaju/0TeOx7LpCaMcnJvp/khR7WiTkum91+RT/WSkOoY4AJYlXPJP1e2PWDS8IP1AlnfAAp7Q0gXy8J9GG1jn6qg3LU8F1e4PSM9tovRcnI4TkWt4kx0/oTF/Z12rkRVadPB401rCuPQaoXdFERr5rFG9gdYYQhRC3NNBow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGkWq9ig; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGkWq9ig"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B921F00893;
	Tue,  9 Jun 2026 04:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780980855;
	bh=MS82725bKGagfDhwSHixyeAii+aPp93AFqhWZh8GLF4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TGkWq9iggnDflsrI+qoxBNduXEiMfOgjKpRjFgP3/v9YsJzWBf9Mz02fzpUlSylWq
	 NE7aYTSe5S/uCqX//yqNcuUhOBIOHiKAe+v+hcQLIPsw/WJ0BLAOnZVW55RmH0l/Au
	 O4dIfs4Qubc0qKzgumLA6rNva7eDdynDqkROLzlpwL92cogfSqmpmpLjxwFBrV7qRQ
	 zbitzDaEY67fdYcQwDDVFjk/ydIDm6tOMvRBK1Ce/3Iq9CEZknm0ZKvi1U4+4ZGSlJ
	 hQU2/Cbc3U4EnhcSzdD6NUjGlI3by7NpTuW6QTRZGwlx9TGQhHeOBTc3ecuZFreHE+
	 nHoydKwcKZTkg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/11] HID: spi_hid: add device tree support for SPI
 over HID
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jingyuan Liang" <jingyliang@chromium.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260609-send-upstream-v4-8-b843d5e6ced3@chromium.org>
References: <20260609-send-upstream-v4-8-b843d5e6ced3@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 04:54:14 +0000
Message-Id: <20260609045415.09B921F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Heap buffer overflow via attacker-controlled `report_length`.
- [Medium] API misuse: Calling `gpiod_set_value` instead of `gpiod_set_valu=
e_cansleep`.
- [Medium] Hardware backpowering risk due to improper GPIO initialization.
- [Low] Log spam during boot due to unhandled -EPROBE_DEFER.
--

commit 0c5bcceb42b14d25affd5a3652cde4d4a22e95c2
Author: Jarrett Schultz <jaschultz@microsoft.com>

HID: spi_hid: add device tree support for SPI over HID

This commit adds Open Firmware (Device Tree) transport support for HID
over SPI devices. It introduces the spi_hid_of module to configure and
manage power and reset lines for these devices based on device tree
properties.

> diff --git a/drivers/hid/spi-hid/spi-hid-of.c b/drivers/hid/spi-hid/spi-h=
id-of.c
> new file mode 100644
> index 0000000000000..ba7d5338f5d89
> --- /dev/null
> +++ b/drivers/hid/spi-hid/spi-hid-of.c
> @@ -0,0 +1,246 @@

[ ... ]

> +static int spi_hid_of_populate_config(struct spi_hid_of_config *conf,
> +				      struct device *dev)
> +{
> +	int error;
> +	u32 val;

[ ... ]

> +	conf->supply =3D devm_regulator_get(dev, "vdd");
> +	if (IS_ERR(conf->supply)) {
> +		if (PTR_ERR(conf->supply) !=3D -EPROBE_DEFER)
> +			dev_err(dev, "Failed to get regulator: %ld.",
> +				PTR_ERR(conf->supply));
> +		return PTR_ERR(conf->supply);
> +	}
> +	conf->supply_enabled =3D false;
> +
> +	conf->reset_gpio =3D devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);

[Severity: Medium]
Could initializing the reset GPIO with GPIOD_OUT_LOW cause hardware
backpowering?

If the GPIO is specified as active-low in the Device Tree, a logical 0
drives the physical pin high. Because this initialization happens during
probe before the device regulator is turned on in spi_hid_of_power_up(),
a high voltage might be driven into an unpowered peripheral. This could
forward-bias ESD diodes and backpower the device.

> +	if (IS_ERR(conf->reset_gpio)) {
> +		dev_err(dev, "%s: error getting reset GPIO.", __func__);

[Severity: Low]
Does this code unnecessarily log errors during normal boot sequencing?

If devm_gpiod_get() returns -EPROBE_DEFER, the error is unconditionally
logged by dev_err() before being returned.

> +		return PTR_ERR(conf->reset_gpio);
> +	}
> +
> +	return 0;
> +}

[ ... ]

> +static int spi_hid_of_assert_reset(struct spihid_ops *ops)
> +{
> +	struct spi_hid_of_config *conf =3D container_of(ops,
> +						      struct spi_hid_of_config,
> +						      ops);
> +
> +	gpiod_set_value(conf->reset_gpio, 1);

[Severity: Medium]
Should this use gpiod_set_value_cansleep() instead of gpiod_set_value()?

The assert_reset callback is invoked from sleepable contexts like probe
and workqueues. If the reset GPIO is attached to a sleepable controller
such as an I2C or SPI expander, calling the non-sleeping gpiod_set_value()
will trigger a WARN_ON in the GPIO core.

> +	return 0;
> +}
> +
> +static int spi_hid_of_deassert_reset(struct spihid_ops *ops)
> +{
> +	struct spi_hid_of_config *conf =3D container_of(ops,
> +						      struct spi_hid_of_config,
> +						      ops);
> +
> +	gpiod_set_value(conf->reset_gpio, 0);

[Severity: Medium]
Similarly, should this use gpiod_set_value_cansleep() since deassert_reset
can also be called from sleepable contexts?

> +	return 0;
> +}

[ ... ]

> +static int spi_hid_of_probe(struct spi_device *spi)
> +{
> +	struct device *dev =3D &spi->dev;
> +	struct spi_hid_of_config *config;
> +	int error;

[ ... ]

> +	error =3D spi_hid_of_populate_config(config, dev);
> +	if (error) {
> +		dev_err(dev, "%s: unable to populate config data.", __func__);

[Severity: Low]
Does this code unnecessarily log a second error on probe deferral?

If spi_hid_of_populate_config() returns -EPROBE_DEFER, dev_err()
will unconditionally log it here as well.

> +		return error;
> +	}
> +
> +	return spi_hid_core_probe(spi, &config->ops, &config->property_conf);
> +}

[ ... ]

In relation to the core code enabled by this transport driver:

[Severity: High]
Does the core input handling allow a heap buffer overflow via an
attacker-controlled report_length?

In drivers/hid/spi-hid/spi-hid-core.c:spi_hid_dev_irq(), the input report
header is read, and header.report_length is checked:

	if (shid->desc.max_input_length !=3D 0 &&
	    header->report_length > shid->desc.max_input_length) {

The max_input_length is completely controlled by the SPI device and can
be set to 0 to bypass the check entirely, or set to a large value.

The driver then initiates a DMA read:

		error =3D spi_hid_input_sync(shid, shid->input->body, header.report_lengt=
h,
					   false);

Because the actual allocated buffer size (shid->bufsize) is determined
independently by the HID report descriptors, a malicious device could
send small report descriptors but huge report_length values, causing a
DMA read directly past the bounds of the shid->input->body heap buffer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609-send-upstr=
eam-v4-0-b843d5e6ced3@chromium.org?part=3D8
