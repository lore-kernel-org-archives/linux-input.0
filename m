Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794683428;
	b=U25JtuUONkQH/O9RX38+2InKomseEP/9tm+B/3gth9vdma+Yu/6A8q2cU01O59fnSvLN
	 XSyI3Z7ZJV4XphZkbDoVKi6QpyhPRXOZv5s1zL/kREDJrxnIn3WSl7LcmJTmiejw+36cV
	 YvCj+F2MkHMpWevbeDDRLyVSZxZIEwZZCMHbF226NUQbXpjPs+Joo4VxThwHS7MiHEBVQ
	 0ANyXpWuvtHRBEZgIM7Qg22LcGLv33LwEh9Y/3ARx9wcODdXdU1yQ+PFtgpuNx826uB7d
	 b7a2u0waW8EK/ARTCtNPPJlzHrbMVYHbbLxkwn8v3mP/+K5tHdbm0dhvRd0L6Nv+V7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794683428;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pxxb+EMMd4ZGxguSQKjNk11Aj/R897GaWiPZDMZEbBk=;
	b=nzulFtfcQfqcrIvqILFScEFU5WuHbYcsR9bNatrUAwWHhULon/0dbjEzo7IKvrzWG8W6
	 VvXKKk4MWTA34uadEzlaRAm9F2pyUB/D1p1ctf5T2oU7sS1iLe44X5ToUYcCmq73z3Uua
	 uewGvd5oNvcG9po5XWiYOM48OjyIMircxzJQ1X35QCg5iC6tnF99aeC/BytLjl/NQwOkN
	 mXl1kj/jHVsoyr0og7Bpa0VIEgNK4y2MLfUl3uARlYA9WEqjt0lOo53mIUy3T/sovhS6O
	 ULbX8TufH6g9LXGCQgCPPRq0xigMXi93YKbZ/mcwW8fuENxJ+xb9vWu+7BvPEt3OBTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=myMuH1w5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBAB606A884
	for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 19:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=myMuH1w5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 770F61F000CB;
	Sat, 14 Nov 2026 19:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794683428;
	bh=pxxb+EMMd4ZGxguSQKjNk11Aj/R897GaWiPZDMZEbBk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=myMuH1w53d1erW/+sBKlpoZqbIglK5lVMcXD1gbxaS2rTgBF0K2lAlhQ9qnf0lLXF
	 Wn9L8VDkDC+imBpuMISDddME+W6hwYqdb9S6wuLinJUeVe+pvXw9Y9lJWxE88XlPV2
	 f3oG26jIgPTsYhQ47oy4CSWp1x7I5RJesdcievsb2bQu3D7Irtdfn5SM9gmd7OfP5v
	 cKef6JqmUjBWWTkDURDhcV3Ds2rQ7Xb/l6ILbn1GyXPDJ+p1f6AUevLnoWVLmYPzNZ
	 Uh8VCVUOh0tnl+BVtctoIjlxDJRRasUor8/0qdMaFglnbJjuU7eT1JoH9IPVV6FNAN
	 fdMtkJxd9BaFQ==
Message-ID: <sashiko-outbox-214954@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/5] HID: intel-thc-hid: intel-ipts: receive reports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emfox Zhou" <emfox@debian.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261114183624.2379573-3-emfox@debian.org>
References: <20261114183624.2379573-1-emfox@debian.org>
 <20261114183624.2379573-3-emfox@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 19:10:28 +0000
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
- [Medium] HID: intel-thc-hid: intel-ipts: false IRQ_HANDLED in
  thc_ipts_hardirq()
- [Medium] HID: intel-thc-hid: intel-ipts: shared IRQ race unmasks
  thc_ipts_thread()
- [Medium] HID: intel-thc-hid: intel-ipts: stopping race in
  thc_ipts_port_stop()
- [Medium] HID: intel-thc-hid: intel-ipts: PRD descriptors not reset in
  thc_ipts_recover()
- [Medium] HID: intel-ipts: thc_dma_write() still stalls when recovery
  masks IRQ
--

commit b17ea629fa85b2d8eee1f00ee19bff9913e9e83b
Author: Emfox Zhou <emfox@debian.org>

HID: intel-thc-hid: intel-ipts: receive reports

This commit configures the RXDMA2 and TXDMA engines on the THC port,
registers a shared threaded interrupt handler to receive and log incoming
frames, and adds a recovery work item to reset RXDMA on transfer errors.

> diff --git a/drivers/hid/intel-thc-hid/intel-ipts/ipts.c b/drivers/hid/in=
tel-thc-hid/intel-ipts/ipts.c
> index 264479630ff6e..ac0074a85bfa4 100644
> --- a/drivers/hid/intel-thc-hid/intel-ipts/ipts.c
> +++ b/drivers/hid/intel-thc-hid/intel-ipts/ipts.c

[ ... ]

> @@ -127,6 +139,209 @@ static int thc_ipts_touch_set(struct thc_ipts *idev=
, bool enable)

[ ... ]

> +irqreturn_t thc_ipts_hardirq(int irq, void *data)
> +{
> +	struct thc_ipts *idev =3D data;
> +
> +	/*
> +	 * The pin is shared and level triggered: mask first, or it stays
> +	 * asserted on the way out. The cause itself can only be read in the
> +	 * thread.
> +	 */
> +	thc_interrupt_enable(idev->thc, false);
> +
> +	/* A reset in flight owns the engine, and the interrupt is ours. */
> +	if (READ_ONCE(idev->recovering))
> +		return IRQ_HANDLED;
> +
> +	/*
> +	 * Nothing of ours is pending in these two states and the port is
> +	 * masked: the interrupt belongs to another function on the line.
> +	 */
> +	if (READ_ONCE(idev->stopping) || !READ_ONCE(idev->dma_ready))
> +		return IRQ_NONE;
> +
> +	return IRQ_WAKE_THREAD;
> +}

[Severity: Medium]
Should thc_ipts_hardirq() and thc_ipts_thread() return IRQ_NONE instead of
IRQ_HANDLED when idev->recovering is set?

idev->recovering is only set in thc_ipts_thread() after thc_ipts_hardirq()
has already masked the port via thc_interrupt_enable(idev->thc, false),
and the port remains masked until thc_ipts_recover() finishes.  While
masked, this port cannot assert the shared INTx line, so any interrupt
arriving during recovery comes from another device on the shared pin.
Furthermore, if thc_rxdma_reset() fails in thc_ipts_recover() (or if
thc_ipts_port_stop() cancels recover_work), idev->recovering stays true
forever and causes thc_ipts_hardirq() to claim every subsequent interrupt
on the shared line, defeating spurious-interrupt detection.

[ ... ]

> +void thc_ipts_recover(struct work_struct *work)
> +{
> +	struct thc_ipts *idev =3D container_of(work, struct thc_ipts,
> +					     recover_work);
> +
> +	if (thc_rxdma_reset(idev->thc)) {
> +		/* Nothing left: keep the port masked until it restarts. */
> +		dev_err(idev->dev, "cannot reset the receive engine\n");
> +		return;
> +	}

[Severity: Medium]
Does thc_rxdma_reset() leave mutated PRD descriptors in the RXDMA2 ring
after an error?

When RXDMA2 writes a frame into a PRD table, the hardware updates each
consumed entry's len, sets end_of_prd on the final entry, and sets the
PRD table hw_status.  During normal operation, thc_dma_read() calls
thc_copy_one_sgl_to_prd() to restore those fields before advancing the
write pointer.  When thc_ipts_thread() sets need_recover on a transfer
error and skips thc_ipts_read_frames() (or when read_dma_buffer() fails
before thc_copy_one_sgl_to_prd() runs), thc_rxdma_reset() only calls
thc_dma_unconfigure() and thc_dma_configure(), which reset the hardware
ring pointers without calling thc_copy_sgls_to_prd().  Those unconsumed
PRD tables retain truncated entry lengths and stale end_of_prd bits, so
later larger frames can trigger PRD buffer overrun errors.

> +
> +	WRITE_ONCE(idev->recovering, false);
> +	if (!READ_ONCE(idev->stopping))
> +		thc_interrupt_enable(idev->thc, true);
> +}
> +
> +irqreturn_t thc_ipts_thread(int irq, void *data)
> +{

[ ... ]

> +	/*
> +	 * The work item resets the engine and unmasks the port again; a frame
> +	 * read while it rewrites the ring would corrupt the descriptors, so
> +	 * ->recovering keeps the handler off the line until it is done.
> +	 */
> +	if (need_recover) {
> +		WRITE_ONCE(idev->recovering, true);
> +		schedule_work(&idev->recover_work);
> +		return IRQ_HANDLED;
> +	}

[Severity: Medium]
Can a concurrent thc_dma_write() still stall until its timeout when
recovery masks the port?

thc_rxdma_reset() is deferred to recover_work because thc_dma_write()
holds dev->thc_bus_lock while waiting on dev->write_complete_wait for
thc_interrupt_handler() to process THC_M_PRT_WRITE_INT_STS_THC_WRDMA_CMPL_S=
TATUS.
However, when need_recover is true, thc_ipts_thread() sets idev->recovering
and returns with the port interrupt still masked, and both
thc_ipts_hardirq() and thc_ipts_thread() ignore further interrupts until
thc_ipts_recover() finishes.  If an in-flight TxDMA transfer completes
after the polling loop in thc_ipts_thread() exits (or if a caller enters
thc_dma_write() and takes dev->thc_bus_lock before recover_work runs),
thc_ipts_recover() blocks on dev->thc_bus_lock while the TxDMA completion
interrupt stays masked, stalling thc_dma_write() for its full timeout.

> +
> +	if (!READ_ONCE(idev->stopping))
> +		thc_interrupt_enable(idev->thc, true);
> +
> +	/* An interrupt with no cause of ours is not ours to claim. */
> +	return ret;
> +}

[Severity: Medium]
Can a shared interrupt race with port unmasking and run thc_ipts_thread()
while the port interrupt is enabled?

thc_ipts_probe() requests the interrupt with IRQF_SHARED |
IRQF_COND_ONESHOT, which leaves IRQS_ONESHOT unset when no earlier handler
on the line requested IRQF_ONESHOT, so thc_ipts_hardirq() can run on
another CPU while thc_ipts_thread() is executing:

CPU0                              CPU1
thc_ipts_thread()
  for (pass =3D 0; ...)
    thc_interrupt_handler()
                                  <hardirq: shared INTx>
                                  thc_ipts_hardirq()
                                    thc_interrupt_enable(thc, false)
                                    return IRQ_WAKE_THREAD
                                    (sets IRQTF_RUNTHREAD)
  thc_interrupt_enable(thc, true)
thc_ipts_thread()                 <-- runs with port unmasked

The same inverted state also occurs even with IRQS_ONESHOT if a shared
interrupt fires between WRITE_ONCE(idev->recovering, false) and
thc_interrupt_enable(idev->thc, true) in thc_ipts_recover(), or between
WRITE_ONCE(idev->dma_ready, true) and thc_interrupt_enable(idev->thc, true)
in thc_ipts_port_start().  If that second thc_ipts_thread() run hits an
error and takes the need_recover path, neither it nor thc_ipts_recover()
masks the port, so thc_rxdma_reset() runs with interrupts enabled on the
port.

[ ... ]

> @@ -220,6 +451,16 @@ void thc_ipts_port_stop(struct thc_ipts *idev)
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

[Severity: Medium]
Can thc_ipts_thread() or thc_ipts_recover() re-enable interrupts during
thc_ipts_port_stop()?

CPU0                              CPU1
thc_ipts_thread()
  if (!READ_ONCE(idev->stopping))
                                  thc_ipts_port_stop()
                                    WRITE_ONCE(idev->stopping, true)
                                    thc_interrupt_enable(thc, false)
    thc_interrupt_enable(thc, true) <-- re-enables IRQ during stop
                                    synchronize_irq(idev->irq)
                                    cancel_work_sync(&idev->recover_work)

Because thc_ipts_port_stop() masks the port before synchronize_irq() and
cancel_work_sync(), an in-flight thread or recovery work item that has
already passed its !READ_ONCE(idev->stopping) check will unmask the port
again, leaving THC_M_PRT_INT_EN_GBL_INT_EN set while the controller and
DMA buffers are torn down.  Calling thc_interrupt_enable(idev->thc, false)
after synchronize_irq() and cancel_work_sync() as well would close this
window.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114183624.2379=
573-1-emfox@debian.org?part=3D2
