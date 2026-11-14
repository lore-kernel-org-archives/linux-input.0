Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794672317;
	b=en7U10p2Xl3t8XDvWCdj8u6hzPJrLqGXTqiXey36bzPF54sdAETzdP1PEozwLVfoqj6a
	 YzvB4g0g3mKEot5ADZWtssPAYe7UvlZlDQJQUi75wKh06oUHOTodZFM3RSZGOmQhvKdcu
	 4chto61Rf+NOuzRvezysSJvC85kz3Tyj7YnBTErIh4BJ48PhjmRx2zTJFY+vk5s/6f9yf
	 takCXYLWhYW36M6tG+CqCxu+XjAOdeQnQXucEKHh8s2vh6cioMhQ5xHMMCuUdh+TBrw57
	 A7mjIV+/7Ku/NsTLPKGLy9sATwab3wfxY5Gn3A09DB03NohgbHUcO4fG7rxqDaWgZJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794672317;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/CA3nssk/rRCLTZxSJKGSBWI5M+0gR5ZaIcmXbPSaQM=;
	b=4B7yILN+Cj1IPE29VwUgiCbaOetFEPYS0KvxImNEjmIBZTOC1sRnh0g+o/w5872VCkpm
	 GFCFDoqSTVRpSdsXJpS6PUrCtyw+LpfH47j2bivtsLoMBq8EDMRLrVg1O5+nYWguJQNc3
	 N/ETBvSV0ca+Bngs+mSXpimmM0ZtbAApZwaOChFvDEBYH6X8QROudBkrBVo1DAEclT7YZ
	 48amMm4LXBRFvu5gBagmGySK+BXF5wDx0s274ptC5pi2OthZL9hOCSTh/cb0rhGjIHXTk
	 rHX4luTh0AoAmkPpcwNN74AFHDjRuGleO3Xx0An1El/QR6dK+KkdZqC/B0iiBES1KjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kb1u4JS8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8769A606A323
	for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 16:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kb1u4JS8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EACD1F000C4;
	Sat, 14 Nov 2026 16:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794672317;
	bh=/CA3nssk/rRCLTZxSJKGSBWI5M+0gR5ZaIcmXbPSaQM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kb1u4JS8wDOpqNhLjUmjQNT1Pi82/oOQk/EhfpD9hSdCvztZcXFz2lBUvV4H0BGmR
	 hMTZ2oB6LNEdhlLk8bnkrhRcQYBk4cdN/E45swe9DrB50DEgtpPNH2hbV+3dXKbWVd
	 aG3tCkNf2b72vZC6t+q/rq9q4Ym53LI5LrPvLaIC15wxGWvnMWKsBV5is+MOfra9R7
	 zFZxOTVUD5sHet36jLS/pQsQ4sMclIFu7KWPBNyZQ6mmUlpZrujauA0qVfwqvNbaKw
	 Myphz0CQVcWRWxCOSwE6DEdM+FyFkXO7fJGwJSDxZO8JUu7W2jkhRKnaM4rnC8HFPf
	 r7lxRmlMlBBXA==
Message-ID: <sashiko-outbox-214734@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] HID: intel-thc-hid: intel-ipts: receive reports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emfox Zhou" <emfox@debian.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261114154611.1683519-3-emfox@debian.org>
References: <20261114154611.1683519-1-emfox@debian.org>
 <20261114154611.1683519-3-emfox@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 16:05:16 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [High] HID: intel-thc-hid: intel-ipts: missing INIT_WORK() for
  idev->recover_work
- [High] HID: intel-thc-hid: premature DMA teardown in
  thc_ipts_port_stop()
- [Medium] HID: intel-thc-hid: intel-ipts: uninitialized len in
  thc_ipts_read_frames()
- [Medium] HID: intel-thc-hid: intel-ipts: RxDMA reset race and lost
  TxDMA completion
- [Medium] HID: intel-thc-hid: intel-ipts: unconditional IRQ_HANDLED on
  shared IRQ
--

commit ad15f281d350f2110628e7e198685de7d1f1724e
Author: Emfox Zhou <emfox@debian.org>

HID: intel-thc-hid: intel-ipts: receive reports

This commit configures the RxDMA2 and TxDMA engines, requests a threaded
interrupt handler to receive and decode incoming frames, and adds a
workqueue handler to reset RxDMA on transfer errors.

> diff --git a/drivers/hid/intel-thc-hid/intel-ipts/ipts.c b/drivers/hid/in=
tel-thc-hid/intel-ipts/ipts.c
> index b16dfdc73d751..8529b91e063f7 100644
> --- a/drivers/hid/intel-thc-hid/intel-ipts/ipts.c
> +++ b/drivers/hid/intel-thc-hid/intel-ipts/ipts.c

[ ... ]

> @@ -124,6 +135,162 @@ static int thc_ipts_touch_set(struct thc_ipts *idev=
, bool enable)

[ ... ]

> +static int thc_ipts_read_frames(struct thc_ipts *idev)
> +{
> +	for (;;) {
> +		int finished =3D 0;
> +		size_t len;
> +
> +		if (thc_rxdma_read(idev->thc, THC_RXDMA2, idev->rx_frame,
> +				   &len, &finished)) {
> +			dev_warn_once(idev->dev,
> +				      "cannot read a frame from the receive engine\n");
> +			return -EIO;
> +		}
> +
> +		thc_ipts_handle_frame(idev, len);
> +		if (finished)
> +			break;
> +	}
> +
> +	return 0;
> +}

[Severity: Medium]
Can thc_ipts_read_frames() pass an uninitialized len to
thc_ipts_handle_frame()?

thc_rxdma_read() -> thc_dma_read() only writes *read_len when
!is_dma_buf_empty(), returning 0 with *read_finished =3D 1 when the ring is
already empty:

drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c:thc_dma_read() {
    ...
	if (!is_dma_buf_empty(dev, read_config, &read_ptr, &write_ptr)) {
		prd_table_index =3D write_ptr & THC_POINTER_MASK;

		status =3D read_dma_buffer(dev, read_config, prd_table_index, read_buff);
		if (status <=3D 0) {
			dev_err_once(dev->dev, "read DMA buffer failed %d\n", status);
			return -EIO;
		}

		*read_len =3D status;
    ...
}

If a second frame arrives after thc_interrupt_handler() clears the EOF
status bit on pass 0 of thc_ipts_thread() but before the loop in
thc_ipts_read_frames() finishes draining RxDMA2, pass 0 drains both frames
while the hardware latches EOF again.  Pass 1 then sees BIT(THC_RXDMA2_INT)
with an empty ring, and thc_ipts_handle_frame() reads stack garbage from
len and re-processes stale data in idev->rx_frame whenever len is at least
THC_IPTS_RX_HDR_SIZE.

Initializing len =3D 0 before thc_rxdma_read() avoids this.

> +
> +/*
> + * Run from a work item: thc_rxdma_reset() takes the bus lock, which
> + * thc_dma_write() holds while it waits for a completion this thread has=
 to
> + * deliver, so resetting inline would stall until the write times out.
> + */
> +void thc_ipts_recover(struct work_struct *work)
> +{
> +	struct thc_ipts *idev =3D container_of(work, struct thc_ipts, recover_w=
ork);
> +
> +	if (thc_rxdma_reset(idev->thc))
> +		dev_err(idev->dev, "cannot reset the receive engine\n");
> +}

[Severity: High]
Where is idev->recover_work initialized with INIT_WORK()?

Neither thc_ipts_probe() nor thc_ipts_port_start() calls
INIT_WORK(&idev->recover_work, thc_ipts_recover) in this commit (it is only
added in the next patch, commit "HID: intel-thc-hid: intel-ipts: expose the
port as a HID device").  At this commit, cancel_work_sync() in
thc_ipts_port_stop() hits WARN_ON(!work->func) in __flush_work(), and if
thc_ipts_thread() calls schedule_work(&idev->recover_work), __queue_work()
hits WARN_ON(!list_empty(&work->entry)) and leaves WORK_STRUCT_PENDING_BIT
set without queuing the work, causing cancel_work_sync() to spin forever in
work_grab_pending().

> +
> +irqreturn_t thc_ipts_thread(int irq, void *data)
> +{
> +	struct thc_ipts *idev =3D data;
> +	int pass;
> +
> +	/*
> +	 * The port stays masked until the end of this handler, so a cause that
> +	 * arrives in between leaves only its status bit: keep reading until
> +	 * the core reports none.
> +	 */
> +	for (pass =3D 0; pass < THC_IPTS_IRQ_CAUSES; pass++) {
> +		int mask =3D thc_interrupt_handler(idev->thc);
> +
> +		/* The core reports this one when no cause is pending. */
> +		if (mask =3D=3D BIT(THC_UNKNOWN_INT))
> +			break;
> +
> +		if (mask & (BIT(THC_FATAL_ERR_INT) | BIT(THC_TXN_ERR_INT))) {
> +			dev_err(idev->dev, "transfer error, resetting the receive engine\n");
> +			schedule_work(&idev->recover_work);
> +			break;
> +		}
> +
> +		/*
> +		 * A non-DMA cause needs no action: the core acknowledges it,
> +		 * and this port moves report data through the DMA engines.
> +		 */
> +		if (mask & BIT(THC_RXDMA2_INT) && thc_ipts_read_frames(idev))
> +			schedule_work(&idev->recover_work);
> +	}
> +
> +	if (!READ_ONCE(idev->stopping))
> +		thc_interrupt_enable(idev->thc, true);

[Severity: Medium]
Can thc_ipts_recover() race with thc_ipts_thread() on RxDMA2, and can
breaking out of the loop on error drop a pending TxDMA completion?

When thc_ipts_thread() schedules idev->recover_work, it still unmasks THC
interrupts before returning, and thc_rxdma_read() does not take
thc_bus_lock:

kworker                           irq/thc_ipts_thread
thc_ipts_recover()
  thc_rxdma_reset()
    thc_dma_unconfigure()
    thc_dma_configure()
                                  thc_ipts_read_frames()
                                    thc_rxdma_read()
                                      <-- corrupts PRD tables & ring ptrs

In addition, thc_interrupt_handler() returns early on THC_NONDMA_INT,
THC_TXN_ERR_INT (both transaction error and buffer overrun), and
THC_FATAL_ERR_INT before checking THC_M_PRT_WRITE_INT_STS_OFFSET.  Breaking
out of the loop on BIT(THC_FATAL_ERR_INT) | BIT(THC_TXN_ERR_INT) (and
limiting THC_IPTS_IRQ_CAUSES to 4 when those four early returns can precede
the data path) leaves a concurrent TxDMA completion unacknowledged, so an
in-flight thc_dma_write() holds thc_bus_lock until its timeout expires
before thc_rxdma_reset() can run.

> +
> +	return IRQ_HANDLED;
> +}

[Severity: Medium]
Should thc_ipts_thread() and thc_ipts_hardirq() return IRQ_NONE when the
interrupt did not come from this port?

The IRQ is requested with IRQF_SHARED, but thc_ipts_hardirq() returns
IRQ_HANDLED when idev->stopping or !idev->dma_ready, and thc_ipts_thread()
returns IRQ_HANDLED even when pass 0 sees BIT(THC_UNKNOWN_INT).  Claiming
every foreign interrupt on the shared PCH line prevents note_interrupt() in
the core IRQ spurious detector from ever counting unhandled interrupts if
another device on the line gets stuck asserting its level interrupt.

[ ... ]

> @@ -220,6 +403,16 @@ void thc_ipts_port_stop(struct thc_ipts *idev)
>  	if (!idev->thc)
>  		return;
> =20
> +	/*
> +	 * Mask the line, then wait for a handler that may be holding a
> +	 * frame for the HID device which is about to go away.
> +	 */
> +	WRITE_ONCE(idev->stopping, true);
> +	thc_interrupt_enable(idev->thc, false);
> +	synchronize_irq(idev->irq);
> +	cancel_work_sync(&idev->recover_work);
> +	thc_ipts_dma_stop(idev);
> +
>  	if (idev->running)
>  		thc_ipts_touch_set(idev, false);

[Severity: High]
Does thc_ipts_port_stop() unmap and free the DMA buffers while the
controller and THC sequencer can still DMA into them?

thc_interrupt_enable(idev->thc, false) only masks host interrupt delivery
in THC_M_PRT_INT_EN_OFFSET; it does not stop the touch controller or
quiesce the THC hardware sequencer.  Calling thc_ipts_dma_stop() before
thc_ipts_touch_set(idev, false), asserting THC_M_PRT_CONTROL_DEVRST, and
calling thc_ipts_quiesce(idev, true) unconfigures the PRD registers and
frees the scatter-gather buffers and coherent PRD tables while RxDMA2 can
still be active, risking a DMA write to freed pages or an IOMMU fault.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114154611.1683=
519-1-emfox@debian.org?part=3D2
