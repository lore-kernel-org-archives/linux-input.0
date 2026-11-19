Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795080692;
	b=p0A4Ne6zjF7xKUm7vafZkdyCTDe/PrRbpWk98eF3DrgthOC8qkCbLf5NzyUq8zkjQr0x
	 6IpnimWPpUpk0O7R4LwhW6uNl83iCE5ESg88xmNtDtXzPv1ExyR6zNIQJ5kCRsJ4G0XUk
	 /Er3eV5pzRQlLU3b+NdxfIjt6us7uTY4y2TsxjhHG5hmpZi9FGdZ8XgVFaMkXSF0lkcJa
	 dYkwXO6XjLHP78a8M/vsCFu4yA05Ykz4o3iXGAhHY3XW4VTqXHiQBMPKdcKUUs1lrS5G1
	 RJ7BDMQqmAoUHvArMurYg57mLACfgjpnkWv8weiUAoxByFR0hPxJZZFx2WbU7p/uMtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795080692;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=r9OtFocrUfDFQynFAvSAVBIm7GDXswguxy2vvPe3dns=;
	b=nq7EGBosj2hUYqtNAs7vVNDifm0cVkasILM53JAE+T0acxr7sZpJGQnxkBa0m8rr803q
	 GbQqTV48zbTEsINHrORNGhupqLh4+AAQMWycPGO0SR8yod1Q7Zk5BND06pkcJwU4LBrIl
	 At6cciYp8oWnHFEZDtlNhW+WGG/V59rt/odkuDd0+CJmPl+kNXgikgwOEbQg4iH0dmRXq
	 CQu4rTk9CUEuyh2J8yyKCyPRGfIih7d0hVW7VdoHsndjRMc8ibUQzZ0EZ8+65tsQEOwfE
	 OtiYRqs/1okBEvIPyCfs35pAFD1P2MEQzqMpXVEgr0oQNqv3n6V2vj93w2GtcexgzlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HdDPK3fu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04170606A320
	for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 09:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HdDPK3fu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626B71F000C5;
	Thu, 19 Nov 2026 09:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795080691;
	bh=r9OtFocrUfDFQynFAvSAVBIm7GDXswguxy2vvPe3dns=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HdDPK3fu56/rZS+pG/ZI4WKWFF1j6IP5IIMDBguXEEDFWCOaoj0Wnw0U7eiSUhkxC
	 0yTbmJt+VHnIpNuDBpCLr1opfq8UA7pl0ReRqCY0GRiU5FFTiSFrtPal0zFY7ZDFOM
	 horq72vo+Zqr4NZizX/EEssRT1jLlES+hFubopsTNwxR9nbiZOsuNbiqinHnRsYemB
	 cY39DuB57ietpQ7YVgJFsJ/tCJxSdf5fHlExFI+W21+d8VMcfljyKU9R2FfNgdIg9Q
	 tnsD7KXMtcmP2scP3KtZTCKTiKxlAaPgsYmULAhcb8ssK+krcrmNeNjq2B9EPbaKer
	 X0owcRLdcmR6A==
Message-ID: <sashiko-outbox-222839@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 2/5] HID: intel-thc-hid: intel-ipts: receive reports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emfox Zhou" <emfox@debian.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261119091152.470384-3-emfox@debian.org>
References: <20261119091152.470384-1-emfox@debian.org>
 <20261119091152.470384-3-emfox@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 09:31:30 +0000
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
- [Medium] HID: intel-thc-hid: intel-ipts: invalid wait context in
  thc_ipts_hardirq()
- [Medium] HID: intel-ipts: thc_ipts_thread() claims foreign shared IRQs
  when recovering
- [Medium] HID: intel-thc-hid: intel-ipts: premature IRQ mask in
  thc_ipts_thread()
--

commit e3ecea8c718b8bb20502f799773e9526e0beb0ef
Author: Emfox Zhou <emfox@debian.org>

HID: intel-thc-hid: intel-ipts: receive reports

This commit configures the receive and transmit DMA engines, requests the
port interrupt with error recovery, and decodes incoming report frames.

> diff --git a/drivers/hid/intel-thc-hid/intel-ipts/ipts.c b/drivers/hid/in=
tel-thc-hid/intel-ipts/ipts.c
> index 2d14e5278f986..e7896b16f1ada 100644
> --- a/drivers/hid/intel-thc-hid/intel-ipts/ipts.c
> +++ b/drivers/hid/intel-thc-hid/intel-ipts/ipts.c
[ ... ]
> @@ -129,6 +144,283 @@ static int thc_ipts_touch_set(struct thc_ipts *idev=
, bool enable)
[ ... ]
> +irqreturn_t thc_ipts_hardirq(int irq, void *data)
> +{
> +	struct thc_ipts *idev =3D data;
> +
> +	/* Nothing of ours is pending: the cause belongs to a sharer. */
> +	if (!READ_ONCE(idev->dma_ready))
> +		return IRQ_NONE;
> +
> +	/* Level triggered and shared: mask first, or it stays asserted. */
> +	thc_interrupt_enable(idev->thc, false);

[Severity: Medium]
Can calling thc_interrupt_enable() from thc_ipts_hardirq() trigger an
invalid wait context warning under lockdep (and sleep in hardirq context on
PREEMPT_RT)?

thc_ipts_probe() requests a shared PCI_IRQ_INTX vector with
IRQF_SHARED | IRQF_COND_ONESHOT.  When the line is shared with an
IRQF_ONESHOT handler, __setup_irq() promotes this action to IRQF_ONESHOT,
so __handle_irq_event_percpu() runs thc_ipts_hardirq() in LD_WAIT_SPIN
context without calling lockdep_hardirq_threaded().  thc_interrupt_enable()
then calls regmap_write_bits() on dev->thc_regmap, which is initialized
with .fast_io =3D true but without .use_raw_spinlock =3D true:

drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c:
static const struct regmap_config thc_regmap_cfg =3D {
	...
	.cache_type =3D REGCACHE_NONE,
	.fast_io =3D true,
	.use_single_read =3D true,
	.use_single_write =3D true,
};

Because .use_raw_spinlock is not set, __regmap_init() protects the regmap
with a regular spinlock_t (LD_WAIT_CONFIG) rather than a raw_spinlock_t.

> +
> +	/*
> +	 * A reset or a teardown in flight still gets the thread: the status it
> +	 * drains is where a pending transmit completion is delivered, and a
> +	 * write waiting for that one holds the bus lock the reset needs.
> +	 */
> +	return IRQ_WAKE_THREAD;
> +}

[ ... ]

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
> +		/* Nothing left: keep the port masked until it restarts. */
> +		dev_err(idev->dev, "cannot reset the receive engine\n");
> +		return;
> +	}

[ ... ]

> +irqreturn_t thc_ipts_thread(int irq, void *data)
> +{
> +	struct thc_ipts *idev =3D data;
> +	irqreturn_t ret =3D IRQ_NONE;
> +	bool need_recover =3D false;
> +	bool reported =3D false;
> +	int pass;
> +
> +	/* Reports are handed to the HID core from here, and a driver callback
> +	 * that sends a request would wait for a completion this very thread
> +	 * delivers: it is recorded so the send path can tell.
> +	 */
> +	WRITE_ONCE(idev->irq_thread, current);
> +
> +	/* A sharer can queue a second run of this thread with no hardirq of
> +	 * ours in between: mask again, the write is idempotent.
> +	 */
> +	thc_interrupt_enable(idev->thc, false);
> +
> +	/* The port stays masked, so a cause that arrives meanwhile leaves only
> +	 * its status bit: read until the core reports none.
> +	 */
> +	for (pass =3D 0; pass < THC_IPTS_IRQ_PASSES; pass++) {
> +		int mask;
> +
> +		/*
> +		 * The reset owns the status registers while it runs: a frame
> +		 * acknowledged here but not read is never announced again.
> +		 */
> +		if (READ_ONCE(idev->recovering)) {
> +			/* Nothing acknowledged, but the line is still ours. */
> +			ret =3D IRQ_HANDLED;
> +			break;
> +		}

[Severity: Medium]
Does returning IRQ_HANDLED here when idev->recovering is true on the first
pass claim every foreign interrupt on the shared INTx line?

While idev->recovering is set (which stays true permanently if
thc_rxdma_reset() fails in thc_ipts_recover() because idev->dma_ready is
left set), every interrupt from another device sharing the line causes
thc_ipts_hardirq() to mask the already-masked port and return
IRQ_WAKE_THREAD.  thc_ipts_thread() then sees idev->recovering on pass 0
and returns IRQ_HANDLED without checking any status registers, adding a
thread wakeup and two MMIO writes to every shared interrupt and preventing
note_interrupt() from detecting a stuck screaming interrupt on a peer
device.

[ ... ]

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
Can checking !READ_ONCE(idev->stopping) before re-enabling the port
interrupt leave the line masked while an in-flight TXDMA transfer is still
waiting for its completion interrupt?

In the next patch in the series ("HID: intel-thc-hid: intel-ipts: exchange
commands with the controller"), thc_ipts_port_stop() sets idev->stopping to
true and then waits on idev->tx_lock for any active thc_ipts_send() ->
thc_dma_write() call to finish before masking the interrupt:

Thread A                     Thread B                   IRQ / thread
thc_ipts_send()
  mutex_lock(&idev->tx_lock)
  thc_dma_write()
    write_dma_buffer()
                             thc_ipts_port_stop()
                               idev->stopping =3D true
                               mutex_lock(&idev->tx_lock)
                                                        <shared/RX IRQ>
                                                        thc_ipts_hardirq()
                                                          thc_interrupt_ena=
ble(false)
                                                        thc_ipts_thread()
                                                          sees idev->stoppi=
ng
                                                          (leaves IRQ maske=
d)
    wait_event_interruptible_timeout(
      dev->write_complete_wait, ...)
      <-- stalls for 1s timeout

Unlike recovery, which splits idev->recover_pending and idev->recovering so
the interrupt stays enabled until thc_ipts_recover() acquires
idev->tx_lock, setting idev->stopping before waiting on idev->tx_lock
causes any intervening run of thc_ipts_thread() to leave the port masked
before the TXDMA completion interrupt arrives.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119091152.4703=
84-1-emfox@debian.org?part=3D2
