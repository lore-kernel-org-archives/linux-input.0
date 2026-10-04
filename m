Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F16B222597;
	Sun,  4 Oct 2026 07:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791100204; cv=none; b=Y8xno3V6KMmJyLWERQfF+w74k+XuAQW8dgNrDLAfrPrdYwLhIR6lp3n7+DK3IEvrQAix0sv9PxRembLzkSd/PdshutS7wBGNlW+rVBrb2qA1koDdUI2d9YD2mUSGhiqMbJdV7hFrt/iAcJaCyPe1OvNaolH0BOKerLE3y0b+KiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791100204; c=relaxed/simple;
	bh=XQg3u4eMzke960IRI5UsVfSFxfdLefgTkgkw5oqiIZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMr6VOn79KvVnjW/B+t9xgZmfrG8AZtbnei7f6QaeVMmNR8iSCLea2LlKZ6nMLe8mfSq3qWzpn5tLMKYxAgYeYLC5uvXhEv6w0Z429ZqYIgj8NGl/RxzhO62BUTCa1f07SAzpivZ4ZtVIe5EyuF/XyKC31dZCJo0Ydbx/7TFvSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DEO4TWsD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DEO4TWsD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7267E1F000FF;
	Sun,  4 Oct 2026 07:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791100203;
	bh=jamzlZtcZjJfzDEPCHyTED59WHCHN0O2C6tOYRv+MmM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DEO4TWsDA5C7Knse4HcVxemvo4FQlDiZ6JXv/+p7k7bU8L6SVKWHdh7LaGpA7Ff5N
	 s6N3jM/RfxcPHTIuyPQLFSjl5wxWkFaUjdv0bFWati7zW1udp+DQM4CQIHdSSLsLES
	 ekdQUyEj9tZNOBK8glpoCTBkKv/h5Kapw1mLmpV/O7nd0vSQXd8xwKof+UAOThiejK
	 pvZYxxL+x8hGg5N1y8Z3ICMgq3bjaUc8r8PjW6aO8XBi2q8rgv1VDGjLgcWUItRik5
	 J6KGtqF/LKR59XPOnVtgRnbK9ad9nkGH6WjnlHZel/osjuPcBHJfa7DxTW1dx0aIdr
	 XFhNxZkPEndNw==
Date: Sun, 4 Oct 2026 09:50:00 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?utf-8?B?TWljaGHFgiBLb3BlxIc=?= <michal@nozomi.space>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Allen Lin <allencl_lin@hotmail.com>, 
	Tylor Yang <tylor_yang@himax.corp-partner.google.com>, Felix Kaechele <felix@kaechele.ca>, 
	Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v5 2/6] HID: Add Himax HX83102J touchscreen driver
Message-ID: <20261004-enigmatic-healthy-saiga-ee2ac2@quoll>
References: <20261003142741.48634-1-michal@nozomi.space>
 <20261003142741.48634-3-michal@nozomi.space>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20261003142741.48634-3-michal@nozomi.space>

On Sat, Oct 03, 2026 at 04:27:37PM +0200, Micha=C5=82 Kope=C4=87 wrote:
> +/**
> + * himax_spi_drv_probe - Probe function for the SPI driver
> + * @spi: Pointer to the spi_device structure
> + *
> + * This function is called when the SPI driver is probed. It initializes=
 the
> + * himax_ts_data structure and assign the settings from spi device to
> + * himax_ts_data. The buffer for SPI transfer is allocate here. The SPI
> + * transfer settings also setup before any communication starts.
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +static int himax_spi_drv_probe(struct spi_device *spi)
> +{
> +	int ret;
> +	struct himax_ts_data *ts;
> +	static struct himax_platform_data *pdata;
> +
> +	dev_info(&spi->dev, "%s: Himax SPI driver probe\n", __func__);

NAK, that's not acceptable. We do not have such code upstream.

> +	ts =3D devm_kzalloc(&spi->dev, sizeof(struct himax_ts_data), GFP_KERNEL=
);
> +	if (!ts)
> +		return -ENOMEM;
> +	if (spi->controller->flags & SPI_CONTROLLER_HALF_DUPLEX) {
> +		dev_err(ts->dev, "%s: Full duplex not supported by host\n", __func__);

Stop printing __func__ everywhere.

> +		return -EIO;
> +	}
> +	pdata =3D &ts->pdata;
> +	ts->dev =3D &spi->dev;
> +	if (!spi->irq) {
> +		dev_err(ts->dev, "%s: no IRQ?\n", __func__);
> +		return -EINVAL;
> +	}
> +	ts->himax_irq =3D spi->irq;
> +	pdata->gpiod_rst =3D devm_gpiod_get(ts->dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(pdata->gpiod_rst)) {
> +		dev_err(ts->dev, "%s: gpio-rst value is not valid\n", __func__);

Syntax is return dev_err_probe

> +		return -EIO;
> +	}
> +
> +	spi->bits_per_word =3D 8;
> +	spi->mode =3D SPI_MODE_3;
> +	spi->cs_setup.value =3D HIMAX_SPI_CS_SETUP_TIME;
> +
> +	ts->spi =3D spi;
> +	/*
> +	 * The max_transfer_size is used to allocate the buffer for SPI transfe=
r.
> +	 * The size should be given by the SPI master driver, but if not availa=
ble
> +	 * then use the HIMAX_MAX_TP_EV_STACK_SZ as default. Which is the least=
 size for
> +	 * each TP event data.
> +	 */
> +	if (spi->controller->max_transfer_size)
> +		ts->spi_xfer_max_sz =3D spi->controller->max_transfer_size(spi);
> +	else
> +		ts->spi_xfer_max_sz =3D HIMAX_MAX_TP_EV_STACK_SZ;
> +
> +	ts->spi_xfer_max_sz =3D min(ts->spi_xfer_max_sz, HIMAX_BUS_RW_MAX_LEN);
> +	/* SPI full-duplex rx_buf and tx_buf should be equal */
> +	ts->xfer_rx_data =3D devm_kzalloc(ts->dev, ts->spi_xfer_max_sz, GFP_KER=
NEL);
> +	if (!ts->xfer_rx_data)
> +		return -ENOMEM;
> +
> +	ts->xfer_tx_data =3D devm_kzalloc(ts->dev, ts->spi_xfer_max_sz, GFP_KER=
NEL);
> +	if (!ts->xfer_tx_data)
> +		return -ENOMEM;
> +
> +	spin_lock_init(&ts->irq_lock);
> +	mutex_init(&ts->rw_lock);
> +	mutex_init(&ts->reg_lock);
> +	dev_set_drvdata(&spi->dev, ts);
> +	spi_set_drvdata(spi, ts);
> +
> +	ts->probe_finish =3D false;
> +	ts->initialized =3D false;
> +	ts->ic_boot_done =3D false;
> +
> +	ret =3D himax_platform_init(ts);
> +	if (ret) {
> +		dev_err(ts->dev, "%s: platform init failed\n", __func__);
> +		return ret;
> +	}
> +
> +	ret =3D himax_chip_detect(ts);
> +	if (ret) {
> +		dev_err(ts->dev, "%s: IC detect failed\n", __func__);
> +		return ret;
> +	}
> +
> +	ret =3D himax_chip_init(ts);
> +	if (ret < 0)
> +		return ret;
> +	ts->probe_finish =3D true;
> +
> +	return ret;
> +	himax_platform_deinit(ts);
> +}
> +
> +/**
> + * himax_spi_drv_remove - Remove function for the SPI driver
> + * @spi: Pointer to the spi_device structure
> + *
> + * This function is called when the SPI driver is removed. It deinitiali=
zes the

Really? Can a remove callback be called in other context? Why are you
explaining obvious parts?

> + * himax_ts_data structure and free the resources allocated for the SPI
> + * communication.
> + */
> +static void himax_spi_drv_remove(struct spi_device *spi)
> +{
> +	struct himax_ts_data *ts =3D spi_get_drvdata(spi);
> +
> +	if (ts->probe_finish) {
> +		if (ts->ic_boot_done) {
> +			himax_int_enable(ts, false);
> +
> +			if (ts->hid_probed)
> +				himax_hid_remove(ts);
> +		}
> +		himax_platform_deinit(ts);
> +	}
> +}
> +
> +/**

Really, why kerneldoc for standard functions?

> + * himax_shutdown - Shutdown the touch screen
> + * @spi: Himax touch screen spi device
> + *
> + * This function is used to shutdown the touch screen. It will disable t=
he
> + * interrupt, set the reset pin to activate state. Then remove the hid d=
evice.

Why are you describing what the code is doing? Drop all such comments.
Look at other drivers how they do it.

> + *
> + * Return: None
> + */
> +static void himax_shutdown(struct spi_device *spi)
> +{
> +	struct himax_ts_data *ts =3D spi_get_drvdata(spi);
> +
> +	if (!ts->initialized) {
> +		dev_err(ts->dev, "%s: init not ready, skip!\n", __func__);
> +		return;
> +	}
> +
> +	himax_int_enable(ts, false);
> +	gpiod_set_value(ts->pdata.gpiod_rst, 1);
> +	himax_power_deconfig(&ts->pdata);
> +	himax_hid_remove(ts);
> +}
> +
> +#if defined(CONFIG_OF)

Drop

> +static const struct of_device_id himax_table[] =3D {
> +	{ .compatible =3D "himax,hx83102j" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, himax_table);
> +#endif
> +
> +static struct spi_driver himax_hid_over_spi_driver =3D {
> +	.driver =3D {
> +		.name =3D		"hx83102j",
> +		.owner =3D	THIS_MODULE,

Drop, this is some ancient downstream code

> +#if defined(CONFIG_OF)

Drop

> +		.of_match_table =3D of_match_ptr(himax_table),
> +#endif
> +	},
> +	.probe =3D	himax_spi_drv_probe,
> +	.remove =3D	himax_spi_drv_remove,
> +	.shutdown =3D	himax_shutdown,
> +};
> +
> +static int __init himax_ic_init(void)
> +{
> +	return spi_register_driver(&himax_hid_over_spi_driver);
> +}
> +
> +static void __exit himax_ic_exit(void)
> +{
> +	spi_unregister_driver(&himax_hid_over_spi_driver);
> +}
> +
> +module_init(himax_ic_init);
> +module_exit(himax_ic_exit);

Why this is not standard module spi driver?

It seems you upstream some old, vendor code. Don't. Instead take newest,
reviewed mainline driver and customize it,  so you will not repeat
trivial issues we fixed 13 years ago like that owner thingy, wrong
return messages, usage of __func__, not using dev_err_probe and even the
kerneldoc. This is not how upstream drivers are written.

Best regards,
Krzysztof

