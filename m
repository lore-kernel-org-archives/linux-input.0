Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795796297;
	b=e1bV9CXLpn7Zfh4uluXJDt/A0WUKvN5D+Detezx+rJKh1hu03npajNmZRnVmOz9IlAFF
	 vG383xmFLAvlpE8/rZ+pA1W2LpkoQ6E48K73ZF1v2JSWz/e6iA97Aw1NFgHVlN1KDhx+6
	 CKiby7I/cvh3a+OMLn0Mhj0FYQJBDkYk+HYf52hQFFUqNGAF9Cpv6wJTE2P9c3j0v7ked
	 OFgaM5/VbEN2nJwpxcA29T1N9VStdGlqKOmlxmRgVDLPbdivE1vnVOXYQu0CqhBjIN9Vu
	 2qwiy/JiL5RvxMMg8m1pp3peI5Agx4KMImEGqFdtJTziTkHDDFh0XuskK83xDIho77Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795796297;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VXyGAy1Wi/r4dNVfnTuuazWfStqKFfqDybRx1qIjd+Y=;
	b=AAf2oGOuNa2R17G1Gh8h7zvjUpP7Q4+YYXzXvLp+XqJi7Ypk7vzDt2NgyKTDurAMUEBf
	 XS17YGvqQ780RQxnN1tGNZ0ghNbwhyzPPm+8HOYMxzJcAniBkOL2pbpISciFEwEurqJGx
	 Nm33OpNaIgiXszXML0K2Zil0jiJ9pjs+Uf9lvr/69QaQq2ueyjA2OtlhVpjNNf+E5Eo26
	 wqNY879xQZL7Ya8h4QQpUcTt0RNFo3cMx3lv2PiTbAYFnsZLFWSR3DCLI8vZlthIpQHS/
	 CbX+NqR6Ee/7XgaaHOI7mI3PlGDMjzM9Yf/c4NVPZlHvW5ovqGXXvbNyhCzO5ruF0ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hq0C+xnv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B91C606A32C
	for <linux-input@vger.kernel.org>; Fri, 27 Nov 2026 16:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hq0C+xnv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B981F000C1;
	Fri, 27 Nov 2026 16:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795796296;
	bh=VXyGAy1Wi/r4dNVfnTuuazWfStqKFfqDybRx1qIjd+Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hq0C+xnv6AD9gj2UkapX7knwkPEuMuO2zmTcdrTnYn/3Ti4uEiO0YK/T72EpZG7me
	 9eJH+MZmv30RP2DvaB6QKBVUOz6d4TqXBhbipyDxXK3psOC4TNPsKiZiqzbZmIZZLy
	 CQ2hPvS3EDC7D7iOFSDPq84ZD439TUs09GhVlw622Lp3rxHGMmvtZ4jwaxN+sRuWRK
	 WBKI1Tr/cWBCbbEL3uS5wUPTC61vknQCqHMmNh/3Lm6vbt+MtFJ1xgs/QBcJtWOvxq
	 2f2PMC3v24VRtIrMLm+XSMsNmIGOn5S6L8odTopQgs6HeZ9f3GkXa4Q4OCw8Q8ptwM
	 0aVPl0SuV+nSQ==
Message-ID: <sashiko-outbox-237865@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 3/6] HID: intel-thc-hid: intel-ipts: receive reports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emfox Zhou" <emfox@debian.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <cf9ec2b7e10689426fe07ac127cdce884879c8b5.1795794049.git.emfox@debian.org>
References: <cover.1795794049.git.emfox@debian.org>
 <cf9ec2b7e10689426fe07ac127cdce884879c8b5.1795794049.git.emfox@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 16:18:16 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] HID: intel-thc-hid: DMA buffer leak on reset failure in
  thc_ipts_recover()
- [Medium] HID: intel-thc-hid: intel-ipts: invalid wait context in
  thc_ipts_hardirq()
- [Medium] HID: intel-thc-hid: intel-ipts: IRQ left masked on
  thc_ipts_thread() recovery
--

commit 7673d514a40c57318bfb19e7aad1ebad5c468aba
Author: Emfox Zhou <emfox@debian.org>

HID: intel-thc-hid: intel-ipts: receive reports

This commit adds DMA receive ring management, shared INTx / MSI interrupt
handling, error recovery, and incoming frame decoding for Intel THC IPTS
ports.

> diff --git a/drivers/hid/intel-thc-hid/intel-ipts/ipts.c b/drivers/hid/in=
tel-thc-hid/intel-ipts/ipts.c
> index c680b09265667..f5f2cb3d2c7fe 100644
> --- a/drivers/hid/intel-thc-hid/intel-ipts/ipts.c
> +++ b/drivers/hid/intel-thc-hid/intel-ipts/ipts.c
[ ... ]
> @@ -101,6 +116,291 @@ static int thc_ipts_touch_set(struct thc_ipts *idev=
, bool enable)
[ ... ]
> +static void thc_ipts_dma_stop(struct thc_ipts *idev)
> +{
> +	if (READ_ONCE(idev->state) < THC_IPTS_DMA)
> +		return;
> +
> +	WRITE_ONCE(idev->state, THC_IPTS_CONFIG);
> +	thc_dma_unconfigure(idev->thc);
> +	thc_dma_release(idev->thc);
> +}
[ ... ]
> +irqreturn_t thc_ipts_hardirq(int irq, void *data)
> +{
> +	struct thc_ipts *idev =3D data;
> +
> +	/* Nothing of ours is pending: the cause belongs to a sharer. A reset
> +	 * in flight owns the status registers and acknowledges nothing.
> +	 */
> +	if (READ_ONCE(idev->state) < THC_IPTS_DMA ||
> +	    READ_ONCE(idev->recovering))
> +		return IRQ_NONE;
> +
> +	/* Level triggered and shared: mask first, or it stays asserted. */
> +	thc_interrupt_enable(idev->thc, false);

[Severity: Medium]
Can thc_interrupt_enable() trigger an invalid wait context splat here?

thc_ipts_probe() registers thc_ipts_hardirq() on the legacy PCI_IRQ_INTX
line with IRQF_SHARED | IRQF_COND_ONESHOT.  When the line is shared with
an IRQF_ONESHOT handler, __setup_irq() promotes the action to
IRQF_ONESHOT, so __handle_irq_event_percpu() runs thc_ipts_hardirq() in
LD_WAIT_SPIN wait context without calling lockdep_hardirq_threaded().
thc_interrupt_enable() calls regmap_write_bits() on dev->thc_regmap,
which is configured in thc_regmap_cfg with .fast_io =3D true and without
.use_raw_spinlock =3D true, acquiring a regular spinlock_t in hardirq
context.

[ ... ]
> +/*
> + * Refuse new requests and queue the reset. The line stays open: a write=
 that
> + * is already waiting for its completion needs this interrupt, and the w=
ork
> + * item takes the port once that write is done.
> + */
> +static void thc_ipts_request_recover(struct thc_ipts *idev)
> +{
> +	if (READ_ONCE(idev->recover_pending))
> +		return;
> +
> +	WRITE_ONCE(idev->recover_pending, true);
> +	schedule_work(&idev->recover_work);
> +}
> +
> +/*
> + * From a work item: the reset waits for the bus lock a pending write ho=
lds
> + * until the threaded handler delivers its completion.
> + */
> +void thc_ipts_recover(struct work_struct *work)
> +{
> +	struct thc_ipts *idev =3D container_of(work, struct thc_ipts,
> +					     recover_work);
> +
> +	/*
> +	 * From here the status registers belong to the reset: the threaded
> +	 * handler must not acknowledge a frame it is not going to read, or the
> +	 * interrupt that would announce it again never comes. The flag alone
> +	 * is only a snapshot to a run that is already inside, so the mask and
> +	 * the wait below are what keeps that run out.
> +	 */
> +	WRITE_ONCE(idev->recovering, true);
> +	thc_interrupt_enable(idev->thc, false);
> +	synchronize_irq(idev->irq);
> +	/* A run that unmasked just before synchronize_irq() returned leaves
> +	 * the line open: mask it again, the write is idempotent.
> +	 */
> +	thc_interrupt_enable(idev->thc, false);
> +
> +	if (thc_rxdma_reset(idev->thc)) {
> +		/* Nothing left to reset: keep the port masked until it
> +		 * restarts, and let the requests fail with -ENODEV instead of
> +		 * -EAGAIN, which would look like a reset that never ends.
> +		 */
> +		dev_err(idev->dev, "cannot reset the receive engine\n");
> +		WRITE_ONCE(idev->state, THC_IPTS_CONFIG);
> +		WRITE_ONCE(idev->recover_seq, READ_ONCE(idev->recover_seq) + 1);
> +		WRITE_ONCE(idev->recover_pending, false);
> +		WRITE_ONCE(idev->recovering, false);
> +		return;
> +	}

[Severity: Medium]
Does lowering idev->state to THC_IPTS_CONFIG here leak the DMA buffers
when thc_rxdma_reset() fails?

thc_rxdma_reset() does not call thc_dma_release() (and returns before
thc_dma_unconfigure() if thc_interrupt_quiesce() or
thc_wait_for_dma_pause() fails).  Once idev->state is set to
THC_IPTS_CONFIG, a subsequent thc_ipts_port_stop() sees
idev->state < THC_IPTS_DMA in thc_ipts_dma_stop() and returns without
unconfiguring DMA or releasing the coherent PRD tables and scatter-gather
buffers.

[ ... ]
> +	/* The work item resets the engine and unmasks again; a frame read
> +	 * meanwhile would corrupt the ring.
> +	 */
> +	if (need_recover) {
> +		thc_ipts_request_recover(idev);
> +		return IRQ_HANDLED;
> +	}
> +
> +	/* A reset unmasks when it is done and a teardown masks on its own, so
> +	 * the line only stays open here while neither runs: a write already
> +	 * on the wire needs the completion this handler delivers.
> +	 */
> +	if (!READ_ONCE(idev->recovering) && !READ_ONCE(idev->stopping))
> +		thc_interrupt_enable(idev->thc, true);
> +
> +	return ret;
> +}

[Severity: Medium]
Does returning early when need_recover is true leave the port interrupt
masked while an in-flight TxDMA write is waiting for completion?

thc_ipts_hardirq() and thc_ipts_thread() mask the interrupt on entry, and
the comments on thc_ipts_request_recover() and thc_ipts_recover() note
that the line must stay open until an in-flight write holding
thc_bus_lock receives its completion interrupt.  Returning here before
thc_interrupt_enable(idev->thc, true) (and masking in thc_ipts_recover()
before thc_rxdma_reset() waits on thc_bus_lock) starves thc_dma_write()
of its completion interrupt until its 1-second timeout expires.  Commit
"HID: intel-thc-hid: intel-ipts: add the HID device" later serializes
thc_ipts_recover() on idev->tx_lock and removes this early return, but
changes the unmask condition to check !READ_ONCE(idev->recover_pending),
which is already false after thc_ipts_request_recover().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795794049.gi=
t.emfox@debian.org?part=3D3
