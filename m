Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794981987;
	b=QA4kR3mvbBJllyZdXENidoh6Ltqgfp0r8SwfCHiS0VpP4uRwCaZlsspL+7Il/BCpiDGG
	 8jCsFhN/bHDuFfzvFmkucMs19MTRe0hHwoCctAnJU1saRuU87+T/ekj6zcVqfrfutV6DK
	 fIwsHI6WNNF5k8/buv/7ueCZm2Pc7aChez2xjgn39XYR9b+agN0NjvgqenG7YbRAT/Fa5
	 4e43uFP+ozi6XT33RfTqNYDkv2VtxhFcjTN7O2lRbzm1FxxGVNWIzxX9/6F9d9zFLSagA
	 DMgVgztdeWHaVOmpoLj5Mw4DDo9yP+6HucNVtIpps2J0ocJ/Qdq4+nMD3WdIVp+8dSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794981987;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=W9eqng2Oy4Z9TZL9OsCOcp+KqTjIgg7ZwrAoTFghQ9I=;
	b=QLb/MEFAapJTt/chTk7ANQi5U+ToSEAk/LX9Fk5dxdJUrJcBi4KHyH6JugRAfe12mJ1u
	 MoX5d2/tvWagy8w+TaJVtKQwNKaJrMhS18gL5u27+tClJcv7gaWNHxbYRnY3HJ7NqXf0z
	 MXZyDKJQDQqYQnjv//DovDa3X+oiJGXoakbx5gfpeTtHkS+j/d5pq3JKqZSoTwpB6M76d
	 RBA08Oi9PNh/oW9c0DTwPi1etAdcORY8D9dMoc0//F6FTJl4FrleuMQ2H3pZmvQZ/+NHh
	 Ng0RPea1uwiQlM5K3YuZQ4kTXfDp6qj57OlbOUIydr85St61cT87bx3ocn43y40h81g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GNqiba3A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A1C606A32F
	for <linux-input@vger.kernel.org>; Wed, 18 Nov 2026 06:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GNqiba3A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD4E61F000C4;
	Wed, 18 Nov 2026 06:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794981986;
	bh=W9eqng2Oy4Z9TZL9OsCOcp+KqTjIgg7ZwrAoTFghQ9I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GNqiba3AnYE6+9W2HEGOKO+XHnCUpLUkMYbsvuKTJian2u/mymIMgCUv7I+oYfzdk
	 GQUSsFxmLyoPfXPYqBl3rUDpB9WtOlRZHEcveiB+v4m4E7IRbaCqcOQtvkDaMST2Tt
	 7xY/6G20lWL6pjCYgPWg8AFoUfMZs1w/F3toSBz3m3ppjMGSCfceCPiG/M2AXw+SvE
	 7J6BIL9AG+EUJtiPcKADy3vsfOKKeIIxul4RLJLhdNwR74NnilmBpxrlrE7UsAA4x0
	 wdApePUVPopd2IIE9BqET49l+GPp5iHeUGkJof5hmCjNk6eAz1fwkDzvhyJ0RiWPND
	 /UiXsK6lVFeNw==
Message-ID: <sashiko-outbox-220201@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/5] HID: intel-thc-hid: intel-ipts: receive reports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emfox Zhou" <emfox@debian.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261118054004.363766-3-emfox@debian.org>
References: <20261118054004.363766-1-emfox@debian.org>
 <20261118054004.363766-3-emfox@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 06:06:26 +0000
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
- [Medium] HID: intel-thc-hid: intel-ipts: IRQ unmasking races in stop
  and recover
- [Medium] HID: intel-thc-hid: intel-ipts: invalid wait context in
  thc_ipts_hardirq()
--

commit 993aaa08c813c3f151cc4b084284f9a37d80893f
Author: Emfox Zhou <emfox@debian.org>

HID: intel-thc-hid: intel-ipts: receive reports

This commit configures the THC DMA engines for IPTS, requests the port
interrupt, and adds frame reception and error recovery handling.

> diff --git a/drivers/hid/intel-thc-hid/intel-ipts/ipts.c b/drivers/hid/in=
tel-thc-hid/intel-ipts/ipts.c
> index 2d14e5278f986..17f6f664e95b5 100644
> --- a/drivers/hid/intel-thc-hid/intel-ipts/ipts.c
> +++ b/drivers/hid/intel-thc-hid/intel-ipts/ipts.c

[ ... ]

> @@ -129,6 +144,281 @@ static int thc_ipts_touch_set(struct thc_ipts *idev=
, bool enable)
>  				 &touch);
>  }

[ ... ]

> +static void thc_ipts_dma_stop(struct thc_ipts *idev)
> +{
> +	if (!idev->dma_ready)
> +		return;
> +
> +	WRITE_ONCE(idev->dma_ready, false);
> +	thc_dma_unconfigure(idev->thc);
> +	thc_dma_release(idev->thc);
> +}

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
Does calling thc_interrupt_enable() from thc_ipts_hardirq() trigger a
lockdep invalid wait context warning when the shared legacy INTx line runs
in oneshot mode?

thc_ipts_probe() allocates a legacy PCI_IRQ_INTX vector and requests the
interrupt with IRQF_SHARED | IRQF_COND_ONESHOT.  When a sharer on the line
uses IRQF_ONESHOT, __setup_irq() sets IRQF_ONESHOT on this action as well,
and __handle_irq_event_percpu() runs thc_ipts_hardirq() in LD_WAIT_SPIN
context without calling lockdep_hardirq_threaded().

thc_interrupt_enable() then calls regmap_write_bits() on
idev->thc->thc_regmap, which is configured with .fast_io =3D true and no
.use_raw_spinlock:

drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c:
static const struct regmap_config thc_regmap_cfg =3D {
	...
	.fast_io =3D true,
};

Acquiring that non-raw spinlock_t from hardirq context violates
CONFIG_PROVE_RAW_LOCK_NESTING.

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

> +	/* A reset unmasks when it is done. A teardown masks on its own, so the
> +	 * line stays open here: a write already on the wire needs the
> +	 * completion this handler delivers.
> +	 */
> +	if (!READ_ONCE(idev->recovering))
> +		thc_interrupt_enable(idev->thc, true);
> +
> +	WRITE_ONCE(idev->in_thread, false);
> +
> +	return ret;
> +}

[ ... ]

> @@ -229,6 +531,19 @@ int thc_ipts_port_start(struct thc_ipts *idev)
>   */
>  void thc_ipts_port_stop(struct thc_ipts *idev)
>  {
> +	/*
> +	 * Mask the line, then wait for a handler that may be holding a
> +	 * frame for the HID device which is about to go away.
> +	 */
> +	WRITE_ONCE(idev->stopping, true);
> +	thc_interrupt_enable(idev->thc, false);
> +	synchronize_irq(idev->irq);
> +	cancel_work_sync(&idev->recover_work);
> +
> +	/* A handler that read ->stopping early may have unmasked. */
> +	thc_interrupt_enable(idev->thc, false);
> +
> +	/* Stop the controller before the buffers it writes into go away. */
>  	if (idev->running)
>  		thc_ipts_touch_set(idev, false);
> =20
> @@ -237,4 +552,6 @@ void thc_ipts_port_stop(struct thc_ipts *idev)
>  	regmap_write_bits(idev->thc->thc_regmap, THC_M_PRT_CONTROL_OFFSET,
>  			  THC_M_PRT_CONTROL_DEVRST, 0);
>  	thc_ipts_quiesce(idev, true);
> +
> +	thc_ipts_dma_stop(idev);
>  }

[Severity: Medium]
Can a shared interrupt or an in-flight thc_ipts_thread() re-enable the port
interrupt and race with thc_ipts_port_stop() and thc_ipts_recover()?

Because the IRQ is registered with IRQF_SHARED, any interrupt from another
device on the line causes thc_ipts_hardirq() to return IRQ_WAKE_THREAD as
long as idev->dma_ready is true.  In thc_ipts_port_stop(), idev->dma_ready
remains true until thc_ipts_dma_stop(), and thc_ipts_thread() does not
check idev->stopping before re-enabling interrupts:

CPU0                                  CPU1
thc_ipts_port_stop()
  WRITE_ONCE(idev->stopping, true)
  synchronize_irq(idev->irq)
  thc_interrupt_enable(..., false)
                                      <shared IRQ>
                                      thc_ipts_hardirq()
                                        if (!READ_ONCE(idev->dma_ready))
                                        return IRQ_WAKE_THREAD
  thc_ipts_touch_set(idev, false)
  ...
  thc_ipts_dma_stop()
    WRITE_ONCE(idev->dma_ready, false)
    thc_dma_unconfigure(idev->thc)
    thc_dma_release(idev->thc)
                                      thc_ipts_thread()
                                        thc_interrupt_handler(idev->thc)
                                        if (!READ_ONCE(idev->recovering))
                                          thc_interrupt_enable(..., true)
                                            <-- runs during DMA teardown
                                                and leaves IRQ unmasked

Even with commit "HID: intel-thc-hid: intel-ipts: add the HID device"
adding synchronize_irq() and thc_interrupt_enable(idev->thc, false) after
thc_ipts_dma_stop(), thc_dma_unconfigure() and thc_dma_release() still run
before synchronize_irq() waits for a woken thc_ipts_thread(), and the port
interrupt is briefly unmasked during shutdown.

A similar race exists in thc_ipts_recover(): if thc_ipts_thread() checks
!READ_ONCE(idev->recovering) just before thc_ipts_recover() sets
idev->recovering and masks the port, the thread can call
thc_interrupt_enable(idev->thc, true) before synchronize_irq() returns.
Because thc_ipts_recover() does not mask again after synchronize_irq(),
thc_rxdma_reset() runs with the port interrupt unmasked (and leaves it
unmasked if thc_rxdma_reset() fails).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118054004.3637=
66-1-emfox@debian.org?part=3D2
