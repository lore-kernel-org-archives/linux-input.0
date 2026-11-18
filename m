Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794986385;
	b=ZgznHv0xkVOvD/5fS4HSx53gVUWB9jSOiWjwcTQWiFYorNzKCR1h4sf76qbbudsCzrSI
	 Q0tRQjiwaI0OrvXzXeZuAYHqzY4H8xvHyt70r8ZgFngM1HRGQ2NkdYLUF/itjxFo2moyI
	 UTfYktZgO3e8q0CZQ33QAahh8203+XkmImsb6eUym9jIE3KMvngA5BUp/vmRxn/Pb9j5/
	 6JLhKeW4tduXoGpTRQYIoWSnm2tbqtIlCcES2DBHEql310dO7srE9mEyCtp8zYcsdNqjw
	 uKsG57MUjuSnTikgrvJyrckrfwmHeKVmbDXFYKS1fIGYkD7BW3IX/1gxkpHr1V370Qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794986385;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=D2jY/VOoV3LSIKXpv5T9qglhK4fZVVJPMQyYuX/cWKk=;
	b=k+ubEn42qVk9bQZeBX/r26CG4RzkF2YjVFDPRCDcElF757x3k3SkyE/lNakNp5dz8a0y
	 C+Rc2Sc0ztdN9TMfAYUwT5p2rcaEHmDE+vKzksitAiinINFZtqG/Q/OHzut175PVCeAYE
	 aaJszags3OjTcpJ0nyg673YWWLEfgJ7gN3ragOHoneh7zudzfyRHOFFtBD/e6U28Mg65v
	 ia6UdyLEiE7NKf1AnUKDi5X9XMV+5yebwopWHU82PQKAH/DqOgPlEDeHOG7IEtVKbuLlF
	 bYnmoGpHCaLRGHNKzbvVsa3QlkB4hInP3frHteQfrTPn2aje/15a2usZa3gSt9FkwEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bVJsfZIb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CB2606A31C
	for <linux-input@vger.kernel.org>; Wed, 18 Nov 2026 07:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bVJsfZIb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920F01F000C4;
	Wed, 18 Nov 2026 07:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794986384;
	bh=D2jY/VOoV3LSIKXpv5T9qglhK4fZVVJPMQyYuX/cWKk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bVJsfZIbJXvYe6QatHH5EF4+JOn+SzZpEiy3gxFV2tRyBg5wTHFH+VNzsYvSJ0AUX
	 DvguBdD0Wgb9Gik40bdOdpHDLulrmSQvAAs7ZXvwjOrOPfAKNrQwbOmb7GJDTZDVIQ
	 4mxGzUqsHZIYq3OZmNO/8zOOcj1MmY8cjF7JdrdISg+bx4jHDWP9mFJ2N2v1jIDH8i
	 ln5Z99XgpDbjvEs46joBC+EYqVvC4uqUH9N7r9YF3Ee0s82waiSaklzI4Mwhgk08KC
	 bUW7oYPbf9ZykqJR4jhQJ2sl1DHfWne/7UkeTbAjZDkpYgRl6XS2ww1N9iWKVf1OCC
	 lw7w3zcu1BFNQ==
Message-ID: <sashiko-outbox-220301@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/5] HID: intel-thc-hid: intel-ipts: receive reports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emfox Zhou" <emfox@debian.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261118065725.673090-3-emfox@debian.org>
References: <20261118065725.673090-1-emfox@debian.org>
 <20261118065725.673090-3-emfox@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 07:19:43 +0000
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
- [Medium] HID: intel-thc-hid: intel-ipts: invalid wait context in
  thc_ipts_hardirq()
- [Medium] HID: intel-ipts: thc_ipts_thread() claims foreign shared IRQs
  when recovering
--

commit 2c695eb72f038a390034bb1c66eb88c4e1603067
Author: Emfox Zhou <emfox@debian.org>

HID: intel-thc-hid: intel-ipts: receive reports

This commit configures the receive and transmit DMA engines, requests the
port interrupt with error recovery, and decodes incoming frames.

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
> +
> +	/*
> +	 * A reset or a teardown in flight still gets the thread: the status it
> +	 * drains is where a pending transmit completion is delivered, and a
> +	 * write waiting for that one holds the bus lock the reset needs.
> +	 */
> +	return IRQ_WAKE_THREAD;
> +}

[Severity: Medium]
Can calling thc_interrupt_enable() here trigger a lockdep invalid wait
context splat when sharing the legacy INTx line with an IRQF_ONESHOT
handler?

thc_ipts_probe() requests a PCI_IRQ_INTX vector with IRQF_SHARED |
IRQF_COND_ONESHOT.  When another handler on that line uses IRQF_ONESHOT,
__setup_irq() promotes this action to IRQF_ONESHOT on an IO-APIC chip
without IRQCHIP_ONESHOT_SAFE, so __handle_irq_event_percpu() runs
thc_ipts_hardirq() in LD_WAIT_SPIN context without calling
lockdep_hardirq_threaded().  thc_interrupt_enable() then calls
regmap_write_bits() on dev->thc_regmap, which uses a non-raw spinlock_t
because thc_regmap_cfg sets .fast_io =3D true without .use_raw_spinlock =3D
true.

[ ... ]

> +void thc_ipts_recover(struct work_struct *work)
> +{
> +	struct thc_ipts *idev =3D container_of(work, struct thc_ipts,
> +					     recover_work);
[ ... ]
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
[ ... ]
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
Does returning IRQ_HANDLED whenever idev->recovering is set claim foreign
interrupts on the shared INTx line?

While thc_ipts_recover() is running, or permanently if thc_rxdma_reset()
fails and returns early with idev->recovering and idev->dma_ready still
true, the port interrupt is masked in hardware.  Every interrupt from
another device sharing the INTx line still causes thc_ipts_hardirq() to
write MMIO and return IRQ_WAKE_THREAD, and thc_ipts_thread() then writes
MMIO again and returns IRQ_HANDLED without checking any status registers,
adding a thread wakeup on every shared interrupt and defeating spurious
interrupt detection if a sibling device gets stuck.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118065725.6730=
90-1-emfox@debian.org?part=3D2
