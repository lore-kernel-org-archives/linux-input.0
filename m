Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794702762;
	b=t4ErUtqVG3v+sux6+K58okQTINyhwasrfCdJeMsxh3b6FBVqYD8nflDjpw2ZIAua9cCd
	 uwDoeSY7BobFd7kKR9xLiTdmXiEc0+BDqUp3rQQDxujFzR8s5vBkW+xXOAjMqRfVvrNVP
	 3kiga7b3Ma/uigjwm8ElSgN+sO9i+pKD3qKCKO++kJ1B7Q8thXnnV92ZOujcxaxDSsRcp
	 TDF2oTClMJFm9Joq/SyUOZbfcONvAtvdzQWiR7vOP8uWYi8UdA575vcF1WeWsuglKSfhG
	 MPUugf683xAstZN9PjQ9QbQElKyr7RLharC9Q8KX/iVZPuGlPKlESFzJrxv6FMFL4TA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794702762;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AlcxSDXZqq6iTJZaotDAcykfKMzu+QKIkXTlxKvTqiE=;
	b=iySe9KhdyWPHMixiH6LDbYG5/THI613gFFcZsMMzojUWGA13rJHyTbFfVa+Bg0Bv6E+N
	 Ci/ROEB9hlxD5P0Jc8McXsIYsK/qmlHQe5Ntjxmbzv9wpRLq2wNhWwz1bPiFhFRJg39qs
	 Kq2Lq8h4nNq1U3pURwdyrTpa/t9j2oq78yj3+42yZ0YHGlz7crBkT4wJKhR15aHBgQ1BU
	 tzjPdO/IX99Cyhx5/i3pVPYdYJHS7ZCK5b/9VU9wfvKeRSCaar9LtZuZjj+nSiNaX1XFe
	 G3V/9Opf48+BIbBKiBuMdgI7bm92EXiJfDH4d3slf/bUlr9uwS7THiGEIY2ugpMQYYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SJijdk+6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E92606A329
	for <linux-input@vger.kernel.org>; Sun, 15 Nov 2026 00:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SJijdk+6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A70671F000C4;
	Sun, 15 Nov 2026 00:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794702761;
	bh=AlcxSDXZqq6iTJZaotDAcykfKMzu+QKIkXTlxKvTqiE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SJijdk+6NDGKvnINOb7l+8X7BKwkuYsj3yTGW+t7uhpdemK8i7thbV8bNTGe86nvz
	 2eYYZ2P2+NZA0DcbzQq9B2VY/h5hTt2nhPFXUwHC5T5729j3Cbm+MzHyLARv/Oy/mg
	 lqwnrpQ+BDl97UFMPJiqAoxF7t4booxSB8mN6QIlhFDqc0b8izYliBKngKYm1zQ1Aw
	 R3Cpl1xqAalc0TLKVEBV9fN5ldGGkJlpfReGGUWsW0QhV3jVvqVPrIvdswCZzermXq
	 /b+B4bTwwxhu68tHFAjWlK91oo07O1/VfqpcQzGDS3Z/pUCy+5BNYcr9Oxm0OCYUrN
	 BlkzprkBtQYcw==
Message-ID: <sashiko-outbox-215148@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] HID: intel-thc-hid: intel-thc: restore PRD table
 capacity
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emfox Zhou" <emfox@debian.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261115001100.313270-1-emfox@debian.org>
References: <20261115001100.313270-1-emfox@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 00:32:40 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [Medium] HID: intel-thc-hid: NULL dereference of prd_tbls in
  thc_copy_sgls_to_prd()
- [Medium] HID: intel-thc-hid: missing THC_SWDMA PRD restore in
  thc_reset_dma_settings()
- [Medium] HID: intel-thc-hid: race on RXDMA2 PRD tables in
  thc_reset_dma_settings()
- [Low] HID: intel-thc-hid: inaccurate Fixes trailer for
  thc_reset_dma_settings() fix
--

commit fcb6103320761fc26aba5f1a6641b22144deb564
Author: Emfox Zhou <emfox@debian.org>

Link: https://lore.kernel.org/r/20261114231733.3916070-1-emfox@debian.org

> HID: intel-thc-hid: intel-thc: restore PRD table capacity
>
> The controller writes the frame length into the PRD entry it filled and
> marks the end of the frame there; only the read path puts the capacity
> back. thc_reset_dma_settings() rewinds the read pointers, so the ring
> reads as empty while the entries keep those lengths, and the next frame
> that does not fit runs past the end of its table: the controller reports
> a buffer overrun, which is a transfer error and leads back into the same
> reset, with the tables untouched.
>
> Restore the receive tables where the pointers are rewound, which covers
> the RxDMA reset, the resume path and the SWDMA round trips in one place.
> Every caller has the engines paused: the reset and the SWDMA paths wait
> for them, a resume finds them stopped by the suspend, and a probe has
> just rebuilt the tables anyway. thc_copy_sgls_to_prd() returns early for
> a channel that has no tables.
>
> Fixes: 1d46b8d40655 ("HID: Intel-thc-hid: Intel-thc: Add API to reset rea=
d DMA")
> Signed-off-by: Emfox Zhou <emfox@debian.org>

[Severity: Low]
Should the Fixes: tag point to a688404b2e20 ("HID: intel-thc-hid:
intel-thc: Add THC DMA interfaces") instead?

thc_reset_dma_settings() rewound the read pointers without restoring the
PRD tables in that initial commit, which already affected system resume,
error recovery via thc_dma_configure(), and SWDMA round trips via
thc_swdma_read_start() and thc_swdma_read_completion() before 1d46b8d40655
("HID: Intel-thc-hid: Intel-thc: Add API to reset read DMA") added
thc_rxdma_reset().

> diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c b/driver=
s/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
> index c80ef8c205742..544bf3a6ba1af 100644
> --- a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
> +++ b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
> @@ -211,6 +211,9 @@ static void thc_copy_sgls_to_prd(struct thc_device *d=
ev,
>  {
>  	unsigned int i;
> =20
> +	if (!config->is_enabled)
> +		return;
> +
>  	memset(config->prd_tbls, 0, array_size(PRD_TABLE_SIZE, config->prd_tbl_=
num));

[Severity: Medium]
Can this cause a NULL pointer dereference on config->prd_tbls when
thc_reset_dma_settings() calls thc_copy_sgls_to_prd()?

dma_set_max_packet_size() sets config->is_enabled =3D true before
thc_dma_allocate() allocates config->prd_tbls, and release_dma_buffers()
frees config->prd_tbls and sets it to NULL without clearing
config->is_enabled.  During hibernation, quicki2c_poweroff() and
quickspi_poweroff() release the DMA buffers via thc_dma_release(); if
hibernation rolls back or aborts and quicki2c_restore() or
quickspi_restore() calls thc_dma_configure() -> thc_reset_dma_settings(),
thc_copy_sgls_to_prd() passes the config->is_enabled check and passes a
NULL config->prd_tbls to memset().

Checking !config->prd_tbls alongside !config->is_enabled (as
read_dma_buffer() does) would avoid this.

> @@ -285,6 +288,16 @@ static void thc_reset_dma_settings(struct thc_device=
 *dev)
>  	regmap_write_bits(dev->thc_regmap, THC_M_PRT_READ_DMA_CNTRL_SW_OFFSET,
>  			  THC_M_PRT_READ_DMA_CNTRL_TPCPR,
>  			  THC_M_PRT_READ_DMA_CNTRL_TPCPR);
> +
> +	if (!dev->dma_ctx)
> +		return;
> +
> +	/*
> +	 * Pointers back at the start while the entries keep the lengths the
> +	 * controller wrote: restore the capacity for the frames that follow.
> +	 */
> +	thc_copy_sgls_to_prd(dev, &dev->dma_ctx->dma_config[THC_RXDMA1]);
> +	thc_copy_sgls_to_prd(dev, &dev->dma_ctx->dma_config[THC_RXDMA2]);

[Severity: Medium]
Can rewriting THC_RXDMA2's PRD tables here race with
quicki2c_irq_thread_handler() reading an input report during an SWDMA
transfer?

thc_swdma_read() holds dev->thc_bus_lock across thc_swdma_read_start() and
thc_swdma_read_completion(), whereas quicki2c_irq_thread_handler() reads
THC_RXDMA2 without dev->thc_bus_lock.  Because thc_interrupt_quiesce() and
thc_wait_for_dma_pause() only poll hardware status bits, they do not wait
for an in-flight threaded IRQ handler:

CPU0                                  CPU1
quicki2c_get_report()                 quicki2c_irq_thread_handler()
  thc_swdma_read()                      handle_input_report()
    thc_swdma_read_start()                thc_rxdma_read(THC_RXDMA2)
      thc_reset_dma_settings()              thc_dma_read()
        thc_copy_sgls_to_prd(THC_RXDMA2)      read_dma_buffer()
          memset(config->prd_tbls, 0, ...)
                                                calc_message_len(prd_tbl)
                                                  <-- reads zeroed or full
                                                      capacity PRD entries
          thc_copy_one_sgl_to_prd()

If calc_message_len() sees the zeroed PRD entries from memset(),
read_dma_buffer() returns 0, thc_dma_read() returns -EIO, and
quicki2c_irq_thread_handler() schedules recovery without re-enabling THC
interrupts, causing the ongoing thc_swdma_read() to time out.  If
calc_message_len() instead sees the restored sg_dma_len(sg) capacity,
read_dma_buffer() copies max_packet_size bytes of stale buffer data into
qcdev->input_buf (which is only sized to max_input_len and can be smaller
than the 4K-aligned max_packet_size).

>  }

[Severity: Medium]
Should thc_reset_dma_settings() also restore
dev->dma_ctx->dma_config[THC_SWDMA]?

thc_reset_dma_settings() rewinds THC_M_PRT_READ_DMA_CNTRL_TPCPR for
THC_SWDMA just above, and thc_swdma_read_start() does not repopulate
dma_config[THC_SWDMA].prd_tbls[0] before starting a transfer.  If
thc_swdma_read() is interrupted or times out in
wait_event_interruptible_timeout() after the controller has written a
short frame into THC_SWDMA's PRD table, or if read_dma_buffer() fails
before reaching thc_copy_one_sgl_to_prd(), dma_config[THC_SWDMA].prd_tbls[0]
keeps the reduced entry length and early end_of_prd marker across the
reset, so a subsequent larger SWDMA read can hit the same buffer overrun.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115001100.3132=
70-1-emfox@debian.org?part=3D1
