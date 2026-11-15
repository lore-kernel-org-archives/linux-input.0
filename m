Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794701224;
	b=UaDt3YPDfLPFM1myLHm+zUXZ2Gy/zHKpE20WzEBlIgqTH/giHyEd2BU1j1TI/HdPPK7d
	 UtqvoL5HK8RdlaYq+GLRTeyB49yXZoCLZoCX2tWOofOtdiAMo2rV5x/hcT/Bt3Nb0rLa4
	 CkG5rQiqmoM5r0i+sIr2/kgWAKoak4DPGPiKP9P3RSQ9DxDVMFoYDhXLDwk5zYjB6X+XR
	 hvjskLBrK/PNT8d7ZACoBJ+gurVyc9Bt6IBlxl3WXjdDzC8ryGeBlDqm3cF8zpWz7/BtR
	 i5gIhai4hFwzKWIOnpOO7UWleAopDIfWJN/rKespmKYieeMisdk4kbg7oT5z5B4vWFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794701224;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VytKNIQy0C6b1jm25J+uQquMT5LQ5O+WfLfG600neOQ=;
	b=hFiOOBj5eJLnxxnJCR3M5hjsaMeK6Yd5G8QJzosqfs+wUzPgFjC1pjZ2PWeakk78RAGD
	 LqgagDWJBbrug41ZtVD14SkzQgR1K84KxuPV/OteVbf5jfR7JQi1NZnMiY1PWlqrnFiWN
	 X3mreNpKfru1iN9Dk3Pw6qbI1PIbDAm/y8kwvq0FncZzzFRtGFLfV9fR4UoZZtOnlVxy6
	 0VD7SDOCsHBYK9xzJj7hm38B+s1gnr9ffjMUivj9Imwf8+P3Pi38zr6wI/+halu0r8rnt
	 kxUgU56h/BPdtFr3uOO+iPVN/kWO0xXwI0QsaQb4lt4/MhIeiSta+o+TvrlXMH2Rfeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="SBSW/mij";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F37606A323
	for <linux-input@vger.kernel.org>; Sun, 15 Nov 2026 00:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SBSW/mij
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 863541F000C4;
	Sun, 15 Nov 2026 00:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794701223;
	bh=VytKNIQy0C6b1jm25J+uQquMT5LQ5O+WfLfG600neOQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SBSW/mijDX9UCi2V8XSnHbu1KdQ4lHdVzkIIKiS6OAA3NIDKodAHdBAletVXC5GAv
	 R5UzFX6m3ou5lqE8U4fFLHIwPoL+PkbIIFnWaSYrHNx/5T4liiq4qBw+g8epkQfX+p
	 P/s40b38LG8SCgl7eCcn29gCs2ddJ1+83reTOjwR/t6ZbpXGdZBGHwc5mblzhGx2Ri
	 hUrUtj5v+6n4RKkGHbuLagKRKme804l1TwMxu85FS4XdQfzPUeMzkSdj2YRx7Ytcqy
	 j9GPzpSPErpEudmYtsag7d6yKO20JsIBubrpxiZt50+5mSTNEYunXQ5JgxWtUVF7oP
	 Qok6AY5+zhUeg==
Message-ID: <sashiko-outbox-215139@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/5] HID: intel-thc-hid: intel-ipts: receive reports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emfox Zhou" <emfox@debian.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261114234242.177387-3-emfox@debian.org>
References: <20261114234242.177387-1-emfox@debian.org>
 <20261114234242.177387-3-emfox@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 00:07:03 +0000
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
- [Medium] HID: intel-thc-hid: intel-ipts: shared IRQ race unmasks
  thc_ipts_thread()
- [Medium] HID: intel-thc-hid: intel-ipts: DMA buffer leak on
  thc_dma_allocate() failure
--

commit bc2c54076d407e032aad5ea9b6b5fb2d73e4ce2a
Author: Emfox Zhou <emfox@debian.org>

HID: intel-thc-hid: intel-ipts: receive reports

This commit configures the Rx and Tx DMA engines for Intel IPTS ports,
registers a threaded interrupt handler to drain incoming frames, and adds a
work item to recover from transfer errors.

> diff --git a/drivers/hid/intel-thc-hid/intel-ipts/ipts.c b/drivers/hid/in=
tel-thc-hid/intel-ipts/ipts.c
> index b0e3fe8ea8aef..76224f4444828 100644
> --- a/drivers/hid/intel-thc-hid/intel-ipts/ipts.c
> +++ b/drivers/hid/intel-thc-hid/intel-ipts/ipts.c
[ ... ]
> @@ -122,6 +132,198 @@ static int thc_ipts_touch_set(struct thc_ipts *idev=
, bool enable)
[ ... ]
> +static int thc_ipts_dma_start(struct thc_ipts *idev)
> +{
> +	int ret;
> +
> +	/* Allocated once: a start that failed must not leave a NULL buffer. */
> +	if (!idev->rx_frame) {
> +		/* The core rounds the packet size up to a page. */
> +		idev->rx_frame =3D devm_kzalloc(idev->dev,
> +					      round_up(idev->max_rx, SZ_4K),
> +					      GFP_KERNEL);
> +		if (!idev->rx_frame)
> +			return -ENOMEM;
> +	}
> +
> +	ret =3D thc_dma_set_max_packet_sizes(idev->thc, 0, idev->max_rx,
> +					   idev->max_tx, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D thc_dma_allocate(idev->thc);
> +	if (ret)
> +		return ret;

[Severity: Medium]
Does this leak config->prd_tbls and scatterlist buffers when
thc_dma_allocate() fails?

idev->max_rx is decoded from a 14-bit field (up to 1 MiB) and only checked
against THC_IPTS_RX_HDR_SIZE in thc_ipts_port_start().  If idev->max_rx
exceeds PRD_ENTRIES_NUM * SZ_4K (64 KiB on 4K-page systems) or sgl_alloc()
fails, setup_dma_buffers() returns -ENOMEM after allocating config->prd_tbls
and any earlier config->sgls[i], while thc_dma_allocate()'s rollback skips
the failing channel:

drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c:setup_dma_buffers() {
    ...
	config->prd_tbls =3D cpu_addr;
	config->prd_tbls_dma_handle =3D dma_handle;

	buf_sz =3D dma_get_max_packet_size(dev, config);

	/* Allocate and map the scatter-gather lists, one for each PRD table */
	for (i =3D 0; i < config->prd_tbl_num; i++) {
		config->sgls[i] =3D sgl_alloc(buf_sz, GFP_KERNEL, &nent);
		if (!config->sgls[i] || nent > PRD_ENTRIES_NUM) {
			dev_err_once(dev->dev, "sgl_alloc (%uth) failed, nent %u\n",
				     i, nent);
			return -ENOMEM;
		}
    ...
}

drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c:thc_dma_allocate() {
    ...
release_bufs:
	while (chan--)
		release_dma_buffers(dev, &dev->dma_ctx->dma_config[chan]);

	return ret;
}

Because thc_ipts_dma_start() returns before setting idev->dma_ready,
thc_ipts_dma_stop() also skips thc_dma_release(), leaking the unmanaged
coherent PRD table and scatterlists.

> +
> +	ret =3D thc_dma_configure(idev->thc);
> +	if (ret) {
> +		thc_dma_release(idev->thc);
> +		return ret;
> +	}
> +
> +	WRITE_ONCE(idev->dma_ready, true);
> +
> +	return 0;
> +}
> +
> +irqreturn_t thc_ipts_hardirq(int irq, void *data)
> +{
> +	struct thc_ipts *idev =3D data;
> +
> +	/* Level triggered and shared: mask first, or it stays asserted. */
> +	thc_interrupt_enable(idev->thc, false);
> +
> +	/* A reset in flight: the port is masked, so this is not ours. */
> +	if (READ_ONCE(idev->recovering))
> +		return IRQ_NONE;
> +
> +	/* Nothing of ours is pending: the cause belongs to a sharer. */
> +	if (READ_ONCE(idev->stopping) || !READ_ONCE(idev->dma_ready))
> +		return IRQ_NONE;
> +
> +	return IRQ_WAKE_THREAD;
> +}
[ ... ]
> +void thc_ipts_recover(struct work_struct *work)
> +{
> +	struct thc_ipts *idev =3D container_of(work, struct thc_ipts,
> +					     recover_work);
> +
> +	/* A handler may have unmasked after the error; keep it masked. */
> +	thc_interrupt_enable(idev->thc, false);
> +
> +	if (thc_rxdma_reset(idev->thc)) {
> +		/* Nothing left: keep the port masked until it restarts. */
> +		dev_err(idev->dev, "cannot reset the receive engine\n");
> +		return;
> +	}
> +
> +	WRITE_ONCE(idev->recovering, false);
> +	if (!READ_ONCE(idev->stopping))
> +		thc_interrupt_enable(idev->thc, true);
> +}
> +
> +irqreturn_t thc_ipts_thread(int irq, void *data)
> +{
[ ... ]
> +	if (!READ_ONCE(idev->stopping))
> +		thc_interrupt_enable(idev->thc, true);
> +
> +	return ret;
> +}

[Severity: Medium]
Can a shared interrupt cause thc_ipts_thread() or recovery to run with the
THC port interrupt unmasked?

thc_ipts_probe() requests the interrupt with IRQF_SHARED | IRQF_COND_ONESHO=
T,
which leaves IRQS_ONESHOT unset unless an earlier sharer requested
IRQF_ONESHOT.  While thc_ipts_thread() is running on CPU0, an interrupt from
another device sharing the INTx line can run thc_ipts_hardirq() on CPU1:

CPU0                                  CPU1
irq_thread()
  thc_ipts_thread()
    for (pass =3D 0; ...; pass++)
      ...
                                      thc_ipts_hardirq()
                                        thc_interrupt_enable(..., false)
                                        return IRQ_WAKE_THREAD
                                        /* sets IRQTF_RUNTHREAD */
    thc_interrupt_enable(..., true)
  /* sees IRQTF_RUNTHREAD set */
  thc_ipts_thread()
    /* runs with port unmasked */     <-- invariant violated

The second invocation of thc_ipts_thread() runs without thc_ipts_hardirq()
masking the port in between.  In addition, thc_ipts_recover() clears
idev->recovering before calling thc_interrupt_enable(idev->thc, true), and
thc_ipts_dma_start() sets idev->dma_ready before thc_ipts_port_start()
unmasks the port; a shared IRQ in either window can wake thc_ipts_thread()
(and even enter thc_ipts_request_recover()) before the delayed
thc_interrupt_enable(idev->thc, true) re-enables the port interrupt.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114234242.1773=
87-1-emfox@debian.org?part=3D2
