Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794876710;
	b=Uy90rL1eTdTl1OtUhL2BQGK7krETGVSv5VFxe0hZ71viLj9k44PWfN7lRtXZqdysB2Vc
	 yF7+mn36KXBua0Bnvuc7M0vB55RhWF0YeFfPYsNYZDjqSV7WsQISoNcdJ5ivLyw7hk8rf
	 EKspXTNEZm8nuw5S1wd75/SZo/slzN/Hp0oDZzlC/7WRfEas2Rnpyaj1STSbjOj9vXcpd
	 2KAtmGqQ/E/fpbfST5Zp2L2Cj0Rp7I7lE2Aje8m1hPDqSr79hHfBXnlFVeXK5L2+5Xnim
	 VSlfj/CM8vlMF7waFKrsulxexMHCR8Ab7EACS0ugCyTK1nIbhJSliw5op1CwyNcoWQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794876710;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NtvuJ69TT4Qqf3lt1vrFnuV9Ky7hbB9jnALzJnwZ2jk=;
	b=YibKQzJcncEWB5jZJQDA6TuVlPheQ5XD1+Nby+MtvwNJn3aPS4MrrYCAwJS43bLwkWG/
	 xN2ibcIfl6OO0maEcsIpANyQNNrOkqtTXX2SJqUuFOpfoNlxeZ1LC/zozZMse7OY4rHIs
	 1pDpMd8eVtjw8BnXhIcPfRcVJoSHhF80l/tkxN2FeObabYXQUWjHqXqF2PsA6afQzludN
	 8uxoteT7kYFfGgPKcQ6vlS3hERa4Z7VcEzVtLt23RfNBe9nkR7OMqGFi+8Rglsf9Z6CUk
	 sKf9F+Mph6nDecqC6g7k53gyGv1iQiKeO5/0PJ3UxDfvyDeaumjj3J23cGeU4l9sPfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gj0XIZRe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3E9606A334
	for <linux-input@vger.kernel.org>; Tue, 17 Nov 2026 00:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gj0XIZRe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21571F000C4;
	Tue, 17 Nov 2026 00:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794876710;
	bh=NtvuJ69TT4Qqf3lt1vrFnuV9Ky7hbB9jnALzJnwZ2jk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gj0XIZRejIV07+NJgV7XBr3bkvB5xuHN53AKLJzoUQYzbFOOHvRXiF2WQ3nNnpxEE
	 cOg6fh1f3nVINZqYXByfUByFAd0zCjV1p0Vg+zZVkFUa4eZW3Mj+yHVT/R2GQz+4G0
	 epy/1udP1qfOxF7LFYzvLRtxeYIj0oRD2eiZh178xg3BTVs5nUALceey0TcbtGYK+T
	 +6M7MjwOvAh/54ZHntuD1COOnCh24EnBT0e0enf987fwAd1vmwaflohYac9j/6OKQ7
	 q/gu1JBtXzhdmblS3Fjc+XuZHmQ27lNKw201po6slREUD7i/VzGxUwfaOVejVG0BbM
	 mW195tsuq/dOQ==
Message-ID: <sashiko-outbox-218028@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] HID: intel-thc-hid: intel-thc: restore PRD table
 capacity
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emfox Zhou" <emfox@debian.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261117003247.940876-1-emfox@debian.org>
References: <20261117003247.940876-1-emfox@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 00:51:49 +0000
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
- [High] HID: intel-thc-hid: race between thc_dma_read() and DMA pointer
  reset
--

commit 16c1e87f8c9f9a7660927e9a01abdc216355c96d
Author: Emfox Zhou <emfox@debian.org>

HID: intel-thc-hid: intel-thc: restore PRD table capacity

This commit rebuilds the RxDMA and SWDMA PRD tables before starting the DMA
engines to restore entry capacities overwritten by unread frames, and adds a
mutex to serialize table rebuilds with thc_dma_read().

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
> +
>  	/*
>  	 * Max input size control feature is only available for RxDMA, it must =
keep disabled
>  	 * during SWDMA operation, and restore to previous state after SWDMA is=
 done.
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
Can thc_dma_read() still race with thc_reset_dma_settings() and
dma_set_start_bit() because prd_lock only covers thc_copy_sgls_to_prd()?

is_dma_buf_empty() treats the ring as empty only when the masked TPCRP and
TPCWP pointers match with different wraparound bits.  thc_reset_dma_setting=
s()
rewinds TPCRP to 0 without setting TPCWP to THC_POINTER_WRAPAROUND (0x80), =
and
TPCWP is only set to 0x80 when dma_set_start_bit() restarts THC_RXDMA2.
Because both register updates happen outside prd_lock in thc_dma_configure(=
),
thc_swdma_read_start() and thc_swdma_read_completion(), the threaded IRQ
handler can enter thc_dma_read() in between:

CPU0                                  CPU1 (threaded IRQ)
thc_swdma_read_completion()
  thc_reset_dma_settings()
    /* TPCRP =3D 0, TPCWP !=3D 0x80 */
  thc_rebuild_rx_prd()
    thc_copy_sgls_to_prd()
      lock(&dma_ctx->prd_lock)
      /* restores entry.len =3D SZ_4K */
      unlock(&dma_ctx->prd_lock)
                                      quickspi_irq_thread_handler()
                                        thc_rxdma_read()
                                          thc_dma_read()
                                            lock(&dma_ctx->prd_lock)
                                            is_dma_buf_empty() -> false
                                            read_dma_buffer()  <-- buffer o=
verflow
                                            update_write_pointer()
                                            unlock(&dma_ctx->prd_lock)
  dma_set_start_bit()

When thc_dma_read() sees the non-empty pointers after thc_rebuild_rx_prd(),
read_dma_buffer() copies a rebuilt PRD table entry whose length was restored
to max_packet_size (aligned to SZ_4K) instead of a frame length written by
hardware, overflowing qsdev->input_buf in intel-quickspi when
HIDSPI_INPUT_BODY_SIZE(max_input_len) is smaller than SZ_4K and corrupting
TPCWP.  The same window remains open across the entire SWDMA transfer after
thc_swdma_read_start() calls thc_reset_dma_settings() while THC_RXDMA2 is
stopped.

Even if the reset and dma_set_start_bit() complete before the woken IRQ thr=
ead
calls thc_dma_read(), is_dma_buf_empty() now returns true on the first call,
so thc_dma_read() returns 0 without setting *read_len:

drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c:quickspi_irq_thread=
_handler() {
	...
		while (!read_finished) {
			ret =3D thc_rxdma_read(qsdev->thc_hw, THC_RXDMA2, qsdev->input_buf,
					     &input_len, &read_finished);
			if (ret) {
				err_recover =3D 1;
				goto end;
			}

			quickspi_handle_input_data(qsdev, input_len);
		}
}

quickspi_irq_thread_handler() then passes an uninitialized input_len and st=
ale
qsdev->input_buf to quickspi_handle_input_data() (and quicki2c's
handle_input_report() replays stale data in qcdev->input_buf).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117003247.9408=
76-1-emfox@debian.org?part=3D1
