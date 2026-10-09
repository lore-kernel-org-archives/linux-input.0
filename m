Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF42837F73A;
	Fri,  9 Oct 2026 22:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791585685; cv=none; b=SiBxKses2yS0XJy56o7Yj5X4oT0/pcSNg9XMfVp9CQ7O1UILm8alMHIyCSadIso/WTg4SOM8XmfaZwdSlyMMSOEV47Sr55uy566pQv27y1/+cWcnff8RaRGpWrks2AYx8bqW48DTZ9yrPI3z6YsxPFGDgcHRCFP8vHoJmHqAahk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791585685; c=relaxed/simple;
	bh=NXK12ECb4GzcRP+G0Dt72yGak2eQ0jzoFdT4Z0RmLBg=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=AnMzI25UdwEg9alA7R5T1evzxUkZaAM7nWvtq6PyXsKSyXzpJQlGUlvKo+gJ7bYqzfO/6Qy7MTvNjYF6UEnPUEeTwc3hBahBzxyqsSbkfUBU5Adyjaiveqt1wdOEFTiiZy3p6+tJh+e64SU5T63EAwROY9l58PrF+7hRbdreejs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGmWyl9f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGmWyl9f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3CC11F000FF;
	Fri,  9 Oct 2026 22:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791585684;
	bh=S2VzOu1QZIDDGG4+G9IP1g5eXXTaBy43FTGfFeVMiT8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iGmWyl9ftOvV8Yj1y9ifkpzDO3Fu8dXW3pr3mukQC3De0nCj2Iwo4g6v2ZvawqQXk
	 eDJRpeNdnId2TKvpUo/38WxeU3sBRUQ8w4FJA1Mqw84YfAymgalNXP/UZHeHwsqTiB
	 sqvSBdk6U3YoZcpV+Pfzv7YtwK7a4NjXc7sbB5geixMzjeJP2HljZBWZOtIvMweMt/
	 IZhTqbiNbN/pZhivauVCirAhwTU2UHg7FHm+i/K5LzAKxfRgdCh/DDVFq8A3fTt4+O
	 N4IOP6ek++tfUj+Buj/UjVFnIl69JKtK93kPbMvjsu5w0upEhbx0FqDa71ycF4uYK9
	 Ez6FiTqbvM1jA==
Message-ID: <sashiko-outbox-166152@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/11] HID: spi-hid: add ACPI support for HID over
 SPI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jingyuan Liang" <jingyliang@chromium.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-trace-kernel@vger.kernel.org, robh@kernel.org
In-Reply-To: <20261009-send-upstream-v5-7-384af01da3ee@chromium.org>
References: <20261009-send-upstream-v5-0-384af01da3ee@chromium.org>
 <20261009-send-upstream-v5-7-384af01da3ee@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 22:41:23 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] spi-hid: data race on bus_error_count in spi_hid_error_handler
--

commit a262e333d16eb58c8aa593f81c7497790c2b01b7
Author: Angela Czubak <acz@semihalf.com>

HID: spi-hid: add ACPI support for HID over SPI
   =20
Detect SPI HID devices described in ACPI.

> diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/spi=
-hid-core.c
> index 83678e6835818..f4e9b4e1294ed 100644
> --- a/drivers/hid/spi-hid/spi-hid-core.c
> +++ b/drivers/hid/spi-hid/spi-hid-core.c

[ ... ]

> @@ -327,8 +303,21 @@ static void spi_hid_error_handler(struct spi_hid *sh=
id)
> =20
>  	shid->power_state =3D HIDSPI_ON;
> =20
> -	shid->ops->deassert_reset(shid->ops);
> +	error =3D shid->ops->deassert_reset(shid->ops);
> +	if (error) {
> +		dev_err(dev, "failed to deassert reset: %d\n", error);
> +		shid->bus_error_count++;
> +		shid->bus_last_error =3D error;
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: Low]
Does this introduce a data race with other updaters of bus_error_count?

Userspace sending an output report via __spi_hid_send_output_report() checks
SPI_HID_READY locklessly. If SPI_HID_READY is read as 1 just before
spi_hid_error_handler() clears it, the output report path proceeds to acqui=
re
io_lock and invoke spi_hid_output(), which updates bus_error_count on error
(under io_lock).

Because spi_hid_error_handler() updates bus_error_count here without holding
io_lock, both threads can execute shid->bus_error_count++ concurrently, whi=
ch
can lead to lost increments or torn reads via sysfs.

> +		/*
> +		 * Without a successful reset the device will not send a reset
> +		 * response, so no IRQ would trigger another recovery attempt.
> +		 * Retry from here; reset_attempts bounds the number of tries.
> +		 */
> +		set_bit(SPI_HID_ERROR, &shid->flags);
> +		schedule_work(&shid->reset_work);
> +	}
> =20
> +	/* Balance disable_irq() above; a retry disables it again. */
>  	enable_irq(shid->spi->irq);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-send-upstr=
eam-v5-0-384af01da3ee@chromium.org?part=3D7
