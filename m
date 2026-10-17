Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0325483804;
	Sat, 17 Oct 2026 14:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792247384; cv=none; b=pByBi8/xpqOZkZbCxA9eOPTiVb6kBgWpNAwviNC4Gj7k87Sdm3QQIrk+gERuLY000Wn80ugJksOZadN510ajDr5ThFMl+JlG6U/HyNmpBv82IKCzsTMBU+9HmMyjRN6gpbxAyEQDxyPcqJ+iXkV+onmwdjSPiLDA63gqXDE3sQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792247384; c=relaxed/simple;
	bh=Z+0UT6wkH5YIJvqK86y1UGVwEhViyUTH99RaaqRPA3Q=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Y/7V2oB/GdylpBk6JIziGFYWRsbAKdWwnaqPY1Wrk61Uk2tJYvF60wlQPOBFC4onRIWii0Udz0htt5/nKKWt9TKkPFF44rnPIfcCGTRABouIJ5KgupTJzHTXOxMPs2aBh4/VzKKIUOI12N7g6hchuVD08zllk7nghkfrRLMmmho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KfUhYG1l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KfUhYG1l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E5F1F000C4;
	Sat, 17 Oct 2026 14:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792247382;
	bh=RQgG0VzTa3aTt9qNxCmwEkzQEguGF162Q9vn4gJB3Fw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KfUhYG1loOmA7KS1lZ/pz9FFSOyY61tBX7cO+5Ku3Tlel9rptjajBOtqDJIExdXfp
	 7WYw+Q+nFSdRgydcG8LMiwRwFhvQpVeLX4JnQLmXAxJVCyRD+IuofjhWKjfhCOWKEG
	 xP/FO1O1EcjUup2T8IOG1vC/vs/MLshCVm6s0EXyqxQ8uzN6mopyAKGS3g64O6WeqV
	 QRlsj0Kkgr3Dr4ANdo8xWAauyYYct1ZcEgBrJEKv51SE/b2NIPBgdqFDCR+dcg2XMl
	 hQuH3wymwNFBpX/OqU0KjHEkVD3s/q9TV4OOYpCqJS/abCWO10AgGOJbnWgID1J0Hc
	 lJ9Hti30w7hPg==
Message-ID: <sashiko-outbox-175548@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/7] Input: edt-ft5x06 - add SPI transport and FT8722
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luka Panio" <lukapanio@gmail.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261017140827.290666-7-lukapanio@gmail.com>
References: <20261017140827.290666-1-lukapanio@gmail.com>
 <20261017140827.290666-7-lukapanio@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 14:29:41 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Input: edt-ft5x06 - unaligned DMA rx buffer sharing cacheline with=
 tx
--

commit 6c4cc2125db365d716cb624219a2c7fd67fb674b
Author: Luka Panio <lukapanio@gmail.com>

Input: edt-ft5x06 - add SPI transport and FT8722 support

This commit adds an SPI transport driver for FocalTech touchscreen
controllers handled by the edt-ft5x06 driver, along with firmware
download support for the RAM-only FT8722 controller.

> diff --git a/drivers/input/touchscreen/edt-ft5x06-spi.c b/drivers/input/t=
ouchscreen/edt-ft5x06-spi.c
> new file mode 100644
> index 0000000000000..d0ae0d4b621dd
> --- /dev/null
> +++ b/drivers/input/touchscreen/edt-ft5x06-spi.c
> @@ -0,0 +1,475 @@

[ ... ]

> +static int fts_spi_xfer(struct spi_device *spi, const u8 *tx, u8 *rx,
> +			size_t len)
> +{
> +	struct spi_transfer xfer =3D {
> +		.tx_buf =3D tx,
> +		.rx_buf =3D rx,
> +		.len =3D len,
> +	};
> +	int ret;
> +
> +	ret =3D spi_sync_transfer(spi, &xfer, 1);
> +	fsleep(FTS_SPI_CS_HIGH_US);
> +
> +	return ret;
> +}
> +
> +static int fts_spi_write(struct spi_device *spi, u8 reg, const void *val,
> +			 size_t len)
> +{
> +	size_t xlen =3D FTS_SPI_HEADER_LEN + (len ? FTS_SPI_DUMMY_LEN + len : 0=
);
> +	u8 *tx, *rx;
> +	int ret, i;
> +
> +	if (len > U16_MAX)
> +		return -EINVAL;
> +
> +	tx =3D kzalloc(2 * xlen, GFP_KERNEL);
> +	if (!tx)
> +		return -ENOMEM;
> +	rx =3D tx + xlen;
> +
> +	tx[0] =3D reg;
> +	tx[1] =3D FTS_SPI_CTRL_WRITE;
> +	put_unaligned_be16(len, &tx[2]);
> +	if (len)
> +		memcpy(&tx[FTS_SPI_HEADER_LEN + FTS_SPI_DUMMY_LEN], val, len);
> +
> +	for (i =3D 0; i < FTS_SPI_RETRIES; i++) {
> +		ret =3D fts_spi_xfer(spi, tx, rx, xlen);
> +		if (!ret && !(rx[3] & FTS_SPI_STATUS_ERR))
> +			break;
> +		if (!ret)
> +			ret =3D -EIO;
> +	}
> +
> +	kfree(tx);
> +	return ret;
> +}
> +
> +static int fts_spi_read(struct spi_device *spi, u8 reg, void *val,
> +			size_t len)
> +{
> +	size_t dp =3D FTS_SPI_HEADER_LEN + FTS_SPI_DUMMY_LEN;
> +	size_t xlen =3D dp + len + FTS_SPI_CRC_LEN;
> +	u8 *tx, *rx;
> +	int ret, i;
> +
> +	if (!len || len > U16_MAX)
> +		return -EINVAL;
> +
> +	tx =3D kzalloc(2 * xlen, GFP_KERNEL);
> +	if (!tx)
> +		return -ENOMEM;
> +	rx =3D tx + xlen;

[Severity: High]
Does placing rx at tx + xlen in fts_spi_write() and fts_spi_read() cause
tx and rx to share a cacheline during full-duplex SPI DMA transfers?

In both functions, a single buffer of size 2 * xlen is allocated, with tx
at offset 0 and rx =3D tx + xlen. Both buffers are then passed to
fts_spi_xfer() -> spi_sync_transfer() in a single full-duplex
spi_transfer, where the SPI core maps tx as DMA_TO_DEVICE and rx as
DMA_FROM_DEVICE concurrently.

Because xlen is typically not aligned to ARCH_DMA_MINALIGN (for example,
xlen is 4 or 8 for control writes, 10 or 11 for short reads, 71 for
touch report reads in edt_ft5x06_ts_isr(), and 32759 for firmware RAM
writes in fts_boot_write_ram()), rx starts in the middle of the cacheline
where tx ends.

On systems with DMA-capable SPI controllers, this overlapping mapping in
opposite DMA directions triggers DMA-API debug EEXIST warnings and risks
cacheline corruption between tx and rx during cache maintenance on
non-coherent architectures (particularly when xlen is large enough to
bypass swiotlb bouncing under CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC, or
across retries in the FTS_SPI_RETRIES loop), as well as presenting an
unaligned rx_buf pointer to SPI controllers that require aligned buffers.

Could tx and rx be allocated separately, or could the offset of rx be
aligned with ALIGN(xlen, ARCH_DMA_MINALIGN)?

[ ... ]

>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017140827.2906=
66-1-lukapanio@gmail.com?part=3D6
