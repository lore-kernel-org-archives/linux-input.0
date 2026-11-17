Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794876487;
	b=vgazJBhbfaM56P3JQfBDwvk12uPXoSpJozHyaBniIVGXT4YB4HnsvHDEd6Mvhqfpe5k7
	 MfMIMfJRD/gUzYP7OtP8fV9+4+/ynZ0GyPm3KO8c0qnpz2MmYWejR36o8hpa3/MI0F7aU
	 uu0faf7rExxMtt/YNLH/Djtum/E5qsLAPBh+y52/sw7qSgf/4M2B3u++gXgTE2tFwTrDp
	 hks5cuKIIq2sCIIxHzs+CJaeFiVSBJ1dK4tnDP49lOUJ67RSkmOdbKL5zYtXihN388nAl
	 C6z8LA4iRaEl7uvbvgJcgpO5I0tole9ZPXUYy4NJUUxH+nNkX2s5Hjion7DKyrzuNYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794876487;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/GxTeIJgufz0vwsUTaeBgCid36oa7FA8YPPS7Hn8GEI=;
	b=eYLrKywdispfY90KngUJOY3bUROIPPFUC8If/60HkrGL25RAV4ddcFCXdyTRFV+LMXeY
	 OsnjXQJU272EKupMqD1Ljgs2WZQNe1wDOuflW+efW8vuXans3vjGw6NcKyBfikopBRNeN
	 U1X9DbaCR9o5s7dz4LNywjcVn98d+TgFFgwCgqyxMMPamMsjmZukWili80+PAijkganPE
	 qW14NZ7D9fIJ0HEkxMtAA/pCxl6jXU34a01FF0DEScJafTZd0LZai3+bMv0rlsYnm3cWK
	 fA7V1Mz9iiu5ShBmhoPx8uXYbVbONAIMi2Y211O6OIilr9zvTNqamNHx8HODLNHPl4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NRfwrNFK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039A1606A31C
	for <linux-input@vger.kernel.org>; Tue, 17 Nov 2026 00:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NRfwrNFK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 565111F000C5;
	Tue, 17 Nov 2026 00:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794876486;
	bh=/GxTeIJgufz0vwsUTaeBgCid36oa7FA8YPPS7Hn8GEI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NRfwrNFK/HdoigCo2ATTvsODYnwIjUgUhRMDzAsQwNvJU00im4OMJDZmAnbLDUH4Q
	 EXTS0e3WFoJHDDMZH2LcUM06XRZR+AjJTAm1hltpMAtY8Tx2fVy7EZ7MvDa69QGOYm
	 rqg8Zc93aOD5lvUXMMNY/7PtKh4RUCfmuj4lDsxW4Eczbz7A1WEvlhmB4+y7y3fljC
	 M3+5TVTL0rcoK+xcI6SeNKA7rLorvd1Q4q8OhdfgWk7CLcaVso5xB/QNTG3uqr9Y8B
	 y/sIRE9AxN9ee5slbsjlzLLTPkm3JqGXQ7UVcGKHq9cQGPX1RB7Ko83UncDMUnw0tk
	 /w5+WjnYMkf7w==
Message-ID: <sashiko-outbox-218024@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] HID: intel-thc-hid: intel-thc: restore PRD table
 capacity
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emfox Zhou" <emfox@debian.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261117002755.936097-1-emfox@debian.org>
References: <20261117002755.936097-1-emfox@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 00:48:04 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] HID: intel-thc-hid: race between ring pointer reset and
  thc_dma_read()
--

commit c665e6597716a85d87cab2130b44755b45a6cc6e
Author: Emfox Zhou <emfox@debian.org>

HID: intel-thc-hid: intel-thc: restore PRD table capacity

This commit reinitializes RxDMA and SWDMA PRD table entries from their
scatter-gather lists before starting the DMA engines and adds a mutex to
serialize PRD table rebuilds with thc_dma_read().

Link: https://lore.kernel.org/r/20261115040756.602092-1-emfox@debian.org

> diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c b/driver=
s/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
> index c80ef8c205742..413f264e30106 100644
> --- a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
> +++ b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
> @@ -211,12 +211,27 @@ static void thc_copy_sgls_to_prd(struct thc_device =
*dev,
>  {
>  	unsigned int i;
> =20
> +	guard(mutex)(&dev->dma_ctx->prd_lock);
> +
> +	if (!config->is_enabled || !config->prd_tbls)
> +		return;
> +
>  	memset(config->prd_tbls, 0, array_size(PRD_TABLE_SIZE, config->prd_tbl_=
num));
> =20
>  	for (i =3D 0; i < config->prd_tbl_num; i++)
>  		thc_copy_one_sgl_to_prd(dev, config, i);
>  }
> =20
> +/*
> + * A frame that is never read leaves its entry short, and the engine rea=
ds
> + * the table again on every start: put the capacity back.
> + */
> +static void thc_rebuild_rx_prd(struct thc_device *dev)
> +{
> +	thc_copy_sgls_to_prd(dev, &dev->dma_ctx->dma_config[THC_RXDMA1]);
> +	thc_copy_sgls_to_prd(dev, &dev->dma_ctx->dma_config[THC_RXDMA2]);
> +}

[ ... ]

> @@ -491,6 +507,9 @@ int thc_dma_configure(struct thc_device *dev)
>  		return -EINVAL;
>  	}
> =20
> +	/* An entry may still be short from a frame nobody read. */
> +	thc_rebuild_rx_prd(dev);
> +
>  	for (chan =3D 0; chan < MAX_THC_DMA_CHANNEL; chan++) {
>  		dma_set_prd_base_addr(dev,
>  				      dma_ctx->dma_config[chan].prd_tbls_dma_handle,
> @@ -685,6 +704,8 @@ static int thc_dma_read(struct thc_device *dev,
>  	u8 read_ptr, write_ptr, prd_table_index;
>  	int status;
> =20
> +	guard(mutex)(&dev->dma_ctx->prd_lock);
> +
>  	if (!is_dma_buf_empty(dev, read_config, &read_ptr, &write_ptr)) {
>  		prd_table_index =3D write_ptr & THC_POINTER_MASK;
> =20
> @@ -765,11 +786,16 @@ static int thc_swdma_read_start(struct thc_device *=
dev, void *write_buff,
>  	if (ret)
>  		return ret;
> =20
> -	if (thc_wait_for_dma_pause(dev, THC_RXDMA1) || thc_wait_for_dma_pause(d=
ev, THC_RXDMA2))
> +	if (thc_wait_for_dma_pause(dev, THC_RXDMA1) ||
> +	    thc_wait_for_dma_pause(dev, THC_RXDMA2) ||
> +	    thc_wait_for_dma_pause(dev, THC_SWDMA))
>  		return -EIO;
> =20
>  	thc_reset_dma_settings(dev);
> =20
> +	/* A transfer that timed out left its frame length in the entry. */
> +	thc_copy_sgls_to_prd(dev, &dev->dma_ctx->dma_config[THC_SWDMA]);

[ ... ]

> @@ -854,6 +880,9 @@ static int thc_swdma_read_completion(struct thc_devic=
e *dev)
> =20
>  	thc_reset_dma_settings(dev);
> =20
> +	/* The receive engine starts again just below. */
> +	thc_rebuild_rx_prd(dev);
> +
>  	dma_set_start_bit(dev, &dev->dma_ctx->dma_config[THC_RXDMA2]);
> =20
>  	ret =3D thc_interrupt_quiesce(dev, false);

[Severity: High]
Can thc_dma_read() race with the ring pointer reset around
thc_rebuild_rx_prd() and overflow qsdev->input_buf?

prd_lock is only held inside thc_copy_sgls_to_prd(), leaving
thc_reset_dma_settings() and dma_set_start_bit() outside the lock in both
thc_dma_configure() and thc_swdma_read_start() /
thc_swdma_read_completion():

CPU0                                  CPU1 (IRQ thread)
thc_dma_configure()
  thc_reset_dma_settings()
    /* TPCRP =3D 0, TPCWP =3D 0 */
  thc_rebuild_rx_prd()
    guard(mutex)(&prd_lock)
    /* PRD len =3D max_packet_size */
                                      quickspi_irq_thread_handler()
                                        thc_rxdma_read()
                                          thc_dma_read()
                                            guard(mutex)(&prd_lock)
                                            !is_dma_buf_empty()
                                            read_dma_buffer()
                                              <-- copies SZ_4K-aligned entry
                                            update_write_pointer()
  dma_set_start_bit()

is_dma_buf_empty() only treats the ring as empty when the masked pointers
match and the wraparound bits differ, so between thc_reset_dma_settings()
(TPCRP =3D=3D 0, TPCWP =3D=3D 0) and dma_set_start_bit() (TPCWP =3D=3D 0x80=
) it
returns false.  thc_dma_read() then copies a rebuilt PRD entry whose
length was restored to max_packet_size (aligned up to SZ_4K by
dma_set_max_packet_size()), which exceeds qsdev->input_buf in
quickspi_irq_thread_handler() and corrupts TPCWP when
update_write_pointer() races with dma_set_start_bit().

Conversely, if the reset and dma_set_start_bit() finish emptying the ring
before thc_dma_read() acquires prd_lock, is_dma_buf_empty() returns true
and thc_dma_read() returns 0 without setting *read_len, causing
quickspi_irq_thread_handler() and handle_input_report() to process stale
input_buf data and an uninitialized stack input_len.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117002755.9360=
97-1-emfox@debian.org?part=3D1
