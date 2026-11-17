Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794902462;
	b=EmPJIH8c6CDpoaOuyZ8HftsXZmdHMevnCVKWm3ZcfO0fywI076oqHEKYh9YYrXEDfWSg
	 hjDJvFB0nfe76DSE2X9tGqLZ+wcPZjydU6SFmMCGG4EjJWvDtmJ81jKRss7MU5TLBa0NA
	 asl99SbWkC4rUUeo9L6T8oWmCFLUlg5J/1FxwEnYPl/7om9VVisuF68apsul2sxmbZ3+L
	 5/lrAfJ2YZ72XBG+H92KySwIjFJEwlqZ7SxyFAC25s84abuBDeXuNBs/4BOYgUKUYn79E
	 edMpG/jNU/qkiTHJjdBnfiJfk6XOP+EyFOsL9IzfAHx0Yq6cOCGb9v217sjMbyyaE0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794902462;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kwp8eFATo6MZC47TVutvw3L5hk5j6/5NcPvxcFPJiTE=;
	b=H3RRsT4VvePvzT+tvhDFuv9sdz4NDw3EZ/hCw7tPMPPPF4AebljbRlntRA3TCb/OT9Ie
	 KN/Zr50rmBOvFXligp+/nENm7jlkZuiGSroxNKy/Fen0N2sZYBJSJU0LVFykW/On5PsSh
	 QxW7baP8V/SYP0TzK+GO3JIDBVbPN07tW7VAo6nBsSbRy6ZJJf9+Yh5vgWZO7FEq5rbuT
	 7anzlAo5ExImASmhTrKBh1zlBIUmy2+1eH6GBlZbEbwwcowwZhrbfhwrYB5UwqttooloV
	 BiwImqApKs408c8CKUZmtNrY+9lhSCEaMIGCrmqgOqvIdYBavlkpWxRA88oMiaS0ncw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AwZiSbyl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F96606A31C
	for <linux-input@vger.kernel.org>; Tue, 17 Nov 2026 08:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AwZiSbyl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC0CB1F000C4;
	Tue, 17 Nov 2026 08:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794902462;
	bh=kwp8eFATo6MZC47TVutvw3L5hk5j6/5NcPvxcFPJiTE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AwZiSbylS7v7pC5O3VcOwP1uM8AxemhsrkV/ZlqRxN+xSLx4pskMEsClGm2yJdhM5
	 zF7bm+y3LpNLof62T6/dQC/07qnZlEFkFSOFfBE25GxCVc9zBJZnjK922sEA1rl6FZ
	 jw1x0DTBiaoggvtLxWrx6NCsQb2kUE3RUyKMUmEyNJK1QZtGjXHYDN43k8jAZUdc74
	 L3f4AuvWKlqKNhywGGHerJRdfNXyHhD9SXSoK8IWHPcpgn+GiocNfKeGSLI6K6nsyx
	 zbgGD2af1Tx7NWaHWMlCviG4tY4mtxWj/CAWsqtDgukEpuMFWYc/Wy8RGgv5zGyw6J
	 HY7dag+jtRLYw==
Message-ID: <sashiko-outbox-218393@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/5] HID: intel-thc-hid: intel-ipts: receive reports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emfox Zhou" <emfox@debian.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261117073554.11557-3-emfox@debian.org>
References: <20261117073554.11557-1-emfox@debian.org>
 <20261117073554.11557-3-emfox@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 08:01:01 +0000
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
- [Medium] HID: intel-thc-hid: intel-ipts: race between
  thc_ipts_thread() and recovery
- [Medium] HID: intel-thc-hid: intel-ipts: invalid wait context in
  thc_ipts_hardirq()
--

commit e88c3279dbafcea638f20c7e327484d006236ae1
Author: Emfox Zhou <emfox@debian.org>

HID: intel-thc-hid: intel-ipts: receive reports

This commit configures the receive and transmit DMA engines, requests the
port interrupt with legacy INTx preference and threaded recovery, and
decodes incoming frame headers.

> diff --git a/drivers/hid/intel-thc-hid/intel-ipts/ipts.c b/drivers/hid/in=
tel-thc-hid/intel-ipts/ipts.c
> index 696a33d17f703..2265d07355221 100644
> --- a/drivers/hid/intel-thc-hid/intel-ipts/ipts.c
> +++ b/drivers/hid/intel-thc-hid/intel-ipts/ipts.c
[ ... ]
> +irqreturn_t thc_ipts_hardirq(int irq, void *data)
> +{
> +	struct thc_ipts *idev =3D data;
> +
> +	/* Level triggered and shared: mask first, or it stays asserted. */
> +	thc_interrupt_enable(idev->thc, false);

[Severity: Medium]
Does calling thc_interrupt_enable() from thc_ipts_hardirq() violate the
hardirq wait context when the shared INTx line uses oneshot?

thc_ipts_probe() requests a legacy PCI_IRQ_INTX vector with
IRQF_SHARED | IRQF_COND_ONESHOT.  When another device on the shared line
uses IRQF_ONESHOT, __setup_irq() sets IRQF_ONESHOT on this action as well,
and __handle_irq_event_percpu() runs thc_ipts_hardirq() in LD_WAIT_SPIN
context without calling lockdep_hardirq_threaded().  thc_interrupt_enable()
calls regmap_write_bits() on dev->thc_regmap, whose regmap_config sets
.fast_io =3D true without .use_raw_spinlock =3D true:

drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c:
static const struct regmap_config thc_regmap_cfg =3D {
	...
	.cache_type =3D REGCACHE_NONE,
	.fast_io =3D true,
};

Because regmap protects this map with a non-raw spinlock_t, taking it in
thc_ipts_hardirq() triggers a lockdep invalid wait context warning under
CONFIG_PROVE_RAW_LOCK_NESTING=3Dy and sleeps in hardirq context on PREEMPT_=
RT.

> +
> +	/* Nothing of ours is pending: the cause belongs to a sharer. */
> +	if (!READ_ONCE(idev->dma_ready))
> +		return IRQ_NONE;
> +
> +	/*
> +	 * A reset or a teardown in flight still gets the thread: the status it
> +	 * drains is where a pending transmit completion is delivered, and a
> +	 * write waiting for that one holds the bus lock the reset needs.
> +	 */
> +	return IRQ_WAKE_THREAD;
> +}
[ ... ]
> +static void thc_ipts_request_recover(struct thc_ipts *idev)
> +{
> +	if (READ_ONCE(idev->recovering))
> +		return;
> +
> +	WRITE_ONCE(idev->recovering, true);
> +	thc_interrupt_enable(idev->thc, false);
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
> +	/* A handler may have unmasked after the error; keep it masked. */
> +	thc_interrupt_enable(idev->thc, false);
> +
> +	if (thc_rxdma_reset(idev->thc)) {
> +		/* Nothing left: keep the port masked until it restarts. */
> +		dev_err(idev->dev, "cannot reset the receive engine\n");
> +		return;
> +	}
> +
> +	/* The reset drops whatever the engines had queued. */
> +	WRITE_ONCE(idev->recover_seq, READ_ONCE(idev->recover_seq) + 1);
> +	WRITE_ONCE(idev->recovering, false);
> +	if (!READ_ONCE(idev->stopping))
> +		thc_interrupt_enable(idev->thc, true);
> +}
> +
> +irqreturn_t thc_ipts_thread(int irq, void *data)
> +{
> +	struct thc_ipts *idev =3D data;
> +	irqreturn_t ret =3D IRQ_NONE;
> +	bool need_recover =3D false;
> +	int pass;
> +
> +	/* A sharer can queue a second run of this thread with no hardirq of
> +	 * ours in between: mask again, the write is idempotent. The port then
> +	 * stays masked, so a cause that arrives meanwhile leaves only its
> +	 * status bit.
> +	 */
> +	thc_interrupt_enable(idev->thc, false);
> +
> +	for (pass =3D 0; pass < THC_IPTS_IRQ_PASSES; pass++) {
> +		int mask =3D thc_interrupt_handler(idev->thc);
> +
> +		if (mask =3D=3D BIT(THC_UNKNOWN_INT))
> +			break;
> +
> +		ret =3D IRQ_HANDLED;
> +		if (mask & (BIT(THC_FATAL_ERR_INT) | BIT(THC_TXN_ERR_INT))) {
> +			dev_err(idev->dev,
> +				"transfer error, resetting the engine\n");
> +			/* The teardown has its own reset to wait for. */
> +			if (!READ_ONCE(idev->stopping))
> +				need_recover =3D true;
> +			/* The core stops at the first cause: a Tx completion
> +			 * behind the error would time out under the bus lock.
> +			 */
> +			continue;
> +		}
> +
> +		/* A reset is in flight or the port is going away: the ring is
> +		 * not ours to read, only its status was.
> +		 */
> +		if (need_recover || READ_ONCE(idev->recovering) ||
> +		    READ_ONCE(idev->stopping))
> +			continue;
> +
> +		if (mask & BIT(THC_RXDMA2_INT) && thc_ipts_read_frames(idev))
> +			need_recover =3D true;
> +	}
> +
> +	/* The work item resets the engine and unmasks again; a frame read
> +	 * meanwhile would corrupt the ring.
> +	 */
> +	if (need_recover) {
> +		thc_ipts_request_recover(idev);
> +		return IRQ_HANDLED;
> +	}
> +
> +	if (!READ_ONCE(idev->stopping) && !READ_ONCE(idev->recovering))
> +		thc_interrupt_enable(idev->thc, true);
> +
> +	return ret;
> +}

[Severity: Medium]
Can a shared interrupt waking thc_ipts_thread() during thc_ipts_recover()
drop post-reset frames or recovery requests?

thc_ipts_hardirq() returns IRQ_WAKE_THREAD whenever idev->dma_ready is true,
so a shared interrupt can run thc_ipts_thread() concurrently with
thc_ipts_recover().  Inside thc_rxdma_reset(), thc_dma_configure() restarts
THC_RXDMA2 and thc_interrupt_quiesce(dev, false) re-enables device interrup=
ts
before thc_ipts_recover() clears idev->recovering:

CPU0 (kworker)                        CPU1 (irq thread)
thc_ipts_recover()
  thc_rxdma_reset()
    thc_dma_configure()
    thc_interrupt_quiesce(..., false)
                                      <new frame or error arrives>
                                      thc_ipts_thread()
                                        thc_interrupt_handler()
                                          /* clears EOF or error status */
                                        if (READ_ONCE(idev->recovering))
                                          continue;  <-- skips frame read
                                        thc_ipts_request_recover()
                                          if (READ_ONCE(idev->recovering))
                                            return;  <-- drops recovery
  WRITE_ONCE(idev->recovering, false)
  thc_interrupt_enable(..., true)

If a frame arrives right after thc_rxdma_reset() restarts the engine,
thc_interrupt_handler() clears THC_M_PRT_READ_DMA_INT_STS_EOF_INT_STS in
hardware, but thc_ipts_thread() still sees idev->recovering =3D=3D true and=
 skips
thc_ipts_read_frames(), leaving the frame unread in the ring.  If a transfer
error occurs in that same window, thc_interrupt_handler() clears the error
status bit and thc_ipts_request_recover() returns early because
idev->recovering is still true, leaving the engine stalled once
thc_ipts_recover() finishes.

Similarly, if thc_ipts_thread() drains a pre-reset error status bit during
thc_rxdma_reset() and reaches thc_ipts_request_recover() just after
thc_ipts_recover() clears idev->recovering, it queues a second reset on the
freshly reset engine, and the trailing thc_interrupt_enable(idev->thc, true)
in thc_ipts_recover() (or in thc_ipts_port_start() after thc_ipts_dma_start=
()
sets idev->dma_ready) can unmask the port while thc_ipts_thread() or recove=
ry
expects it to stay masked.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117073554.1155=
7-1-emfox@debian.org?part=3D2
