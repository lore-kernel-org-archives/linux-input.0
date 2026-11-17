Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794908816;
	b=tJ3dOLX45X8UP+8+LZIrf3hLpodxvY92D2mfvIXi1xubkVoJvwlFh5qsOvVjDLPvMP7n
	 7x7aB4YsD+DTfxOxj15yms12I7Z3vGC2avAW9mu+oYZEAjslL79wtoLd3ZMLKY0l/7mjG
	 extYjS79L30gYwcitUxMia96bHwU6cUHbIfEbxt8zK1gik5mGQECPfVz4ZTGtPgjXfeO7
	 +tn1aR4pFGfrGOMs9Wx4kC74/JeHUfHu3iPirQQJ2xSi1lPm1NXC/vk+YuZCaD2/1UUZl
	 T9xlz1ueWZoMi4WLQzDj6Q7GVh8xG1BfRuDxN0pJnaJ2U2O9pTSQhpy9oWTs6f/dzhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794908816;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kfzlmF2ETtxwS7R4FR6W2gGeZt7nAI0pzIYO1N6c2Sw=;
	b=fmjhlNowLzUiVmh0kLV9LlaUqLiaqymYlHjlzZ/W6CjWOUsFJRNav781mqtyDyD17LpV
	 sQU0zDYqAGM2DJkNpgUWU2n6m0Ukx5OWGW4cInapHPRA4gS+EtPJQze6WD0Hh1P7luHBh
	 zaXO4vaLnUnSIIaq/etubInfbpM1OgdZjMa429mDPDkDyhNLSy8mWoB2exgcG+aRvVwJ2
	 9jFOiPdQ7OrFAeA43bMZRE1LD6yNw1h3wN5Ct2FD1BKFpCgcCRH2dLpU76+8rZXc+kJPq
	 nEWHKGRd3rTlUnA5+m8hDnlUrWIVSk33gZ7r7GO1R3JmbvKR3VEcqxNuu+jgWiYCBQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bms5G0FU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7066606A31C
	for <linux-input@vger.kernel.org>; Tue, 17 Nov 2026 09:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bms5G0FU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21B7C1F000C4;
	Tue, 17 Nov 2026 09:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794908816;
	bh=kfzlmF2ETtxwS7R4FR6W2gGeZt7nAI0pzIYO1N6c2Sw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bms5G0FUjlGuuxCrId64grngRWwh6LDA7CLrdyVprAnXOWeT4vsmN2Pj920zlpGiT
	 VuWF1wI4v2tnTkErSLpobewq5ZMNH9DbU4GMLIRlQHqSx3bJds1Lu54vW7wDihVrap
	 ZaeJChMF/MzKId5FciGJ9c2ntKQUN7Rus/wrX9GPwtSlgVVYFrqFdxru9iyhHOQD80
	 PUfvIczX3vamTes4vmD8/8lb30Hz9gDxFocFFPWLSIIc+CqSbY4sQq7tkthqRMPSth
	 zswjuyRr7iICh2D4BiwKafYJXQ2Jreao9ke1+7IkGv6HYtl1AiRjpIckhWt67kX12L
	 SYGEOMf5DhH+A==
Message-ID: <sashiko-outbox-218522@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] HID: intel-thc-hid: intel-thc: restore PRD table
 capacity
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emfox Zhou" <emfox@debian.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261117093212.4122283-1-emfox@debian.org>
References: <20261117093212.4122283-1-emfox@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 09:46:55 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] HID: intel-thc-hid: unlocked DMA stop and pointer rewind races
  with thc_dma_read()
- [High] HID: intel-thc-hid: callers process stale buffer when
  thc_dma_read() reads 0 bytes
--

commit e37dcedb282f37ff3f31a83e6e9909efb70e1d60
Author: Emfox Zhou <emfox@debian.org>

HID: intel-thc-hid: intel-thc: restore PRD table capacity

This commit reinitializes PRD tables before DMA engines are started,
serializes table rebuilds and ring reads with a mutex, and tracks whether
each DMA channel is running so stopped rings are not read.

Link: https://lore.kernel.org/r/20261117003247.940876-1-emfox@debian.org

> diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c b/driver=
s/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
> index c80ef8c205742..e315989a4c8fd 100644
> --- a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
> +++ b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
[ ... ]
> @@ -266,6 +302,14 @@ static int setup_dma_buffers(struct thc_device *dev,
> =20
>  static void thc_reset_dma_settings(struct thc_device *dev)
>  {
> +	struct thc_dma_context *dma_ctx =3D dev->dma_ctx;
> +	int chan;
> +
> +	/* The rewind below discards the queue, so no read may start. */
> +	if (dma_ctx)
> +		for (chan =3D 0; chan < MAX_THC_DMA_CHANNEL; chan++)
> +			WRITE_ONCE(dma_ctx->dma_config[chan].is_started, false);
> +
>  	/* Stop all DMA channels and reset DMA read pointers */
>  	regmap_write_bits(dev->thc_regmap, THC_M_PRT_READ_DMA_CNTRL_1_OFFSET,
>  			  THC_M_PRT_READ_DMA_CNTRL_START, 0);

[Severity: High]
Can thc_reset_dma_settings() rewind the hardware read pointer while
thc_dma_read() is already past the is_started check?

thc_wait_for_dma_pause(), thc_reset_dma_settings() and
thc_dma_unconfigure() clear is_started and stop or rewind the channel
without taking dev->dma_ctx->prd_lock, while the threaded IRQ handler
drains THC_RXDMA2 outside dev->thc_bus_lock:

CPU0                                  CPU1
quickspi_irq_thread_handler()         thc_swdma_read()
  thc_rxdma_read()                      thc_swdma_read_start()
    thc_dma_read()                        thc_wait_for_dma_pause(THC_RXDMA2)
      guard(mutex)(&prd_lock)               is_started =3D false
      if (!READ_ONCE(is_started))         thc_reset_dma_settings()
                                            /* rewinds TPCRP to 0 */
      is_dma_buf_empty()
        /* TPCRP =3D=3D 0, TPCWP =3D=3D 0x81 */
      read_dma_buffer()               <-- reads unwritten PRD entry

Because thc_copy_one_sgl_to_prd() restored that entry's length to
max_packet_size (ALIGN(size, SZ_4K)), read_dma_buffer() copies up to a
4K-aligned buffer into read_buff (overflowing qsdev->input_buf in
intel-quickspi when max_input_len is smaller than SZ_4K) and
update_write_pointer() corrupts TPCWP on the stopped ring.  Similarly,
on probe error unwind, quicki2c_dma_deinit() and quickspi_dma_deinit()
call thc_dma_unconfigure() and thc_dma_release() before interrupts are
quiesced, which can unmap and free sgls and prd_tbls while an in-flight
thc_dma_read() is still using them under prd_lock.

Acquiring dev->dma_ctx->prd_lock when stopping the engines, rewinding
the pointers, and releasing the buffers would serialize against an
in-progress thc_dma_read().

[ ... ]
> @@ -685,6 +735,21 @@ static int thc_dma_read(struct thc_device *dev,
>  	u8 read_ptr, write_ptr, prd_table_index;
>  	int status;
> =20
> +	/* The caller may look at this when nothing was read. */
> +	*read_len =3D 0;
> +
> +	guard(mutex)(&dev->dma_ctx->prd_lock);
> +
> +	/*
> +	 * Nothing in the ring is ours until the engine is started: after a
> +	 * reset the pointers alone say nothing about what was written.
> +	 */
> +	if (!READ_ONCE(read_config->is_started)) {
> +		if (read_finished)
> +			*read_finished =3D 1;
> +		return 0;
> +	}
> +
>  	if (!is_dma_buf_empty(dev, read_config, &read_ptr, &write_ptr)) {
>  		prd_table_index =3D write_ptr & THC_POINTER_MASK;

[Severity: High]
When thc_dma_read() returns 0 with *read_len =3D 0 and *read_finished =3D 1,
won't callers process stale data in read_buff?

If the threaded IRQ handler drains THC_RXDMA2 while the engine is paused
for an SWDMA transfer or reset, thc_rxdma_read() returns 0 without
touching the buffer, and neither caller checks for a zero length:

drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c:handle_input_report=
() {
	while (!rx_dma_finished) {
		ret =3D thc_rxdma_read(qcdev->thc_hw, THC_RXDMA2,
				     (u8 *)pkt, &report_len,
				     &rx_dma_finished);
		if (ret)
			return ret;

		if (!pkt->len) {
...
		quicki2c_hid_send_report(qcdev, pkt->data, qcdev->input_len,
					 HIDI2C_DATA_LEN(le16_to_cpu(pkt->len)));
	}
}

handle_input_report() will either replay the previous packet in
qcdev->input_buf to the HID core or, if pkt->len was 0, falsely mark
qcdev->reset_ack =3D true.  In intel-quickspi,
quickspi_irq_thread_handler() passes input_len =3D=3D 0 to
quickspi_handle_input_data(), logging a false report length error, and
thc_swdma_read() returns 0 to quicki2c_get_report() and
quicki2c_get_report_descriptor() without populating read_buff.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117093212.4122=
283-1-emfox@debian.org?part=3D1
