Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795795590;
	b=JaYGteEa+0gjQrPeL/gzri/MuRYww3Z04qBvCZ2ce8+6wgetHu02ucMyvMH7JwKOtl/K
	 GAJ0MaTvWesFCIcQPQhcCBaspIVNcJI4qxw7/a3QIflj+ovS1FM/Ovg6/gKCveNIywDxx
	 dO8VjavFC/K6Q+xqB7ve1DeL2P2skAoqeGw6s1vxCYnvwXyPmQBiNtMz1aPRZUtyIXbXE
	 QmckU6xD8p77xwoJkuGAk62gJtRcY85KSgQco0JXEm1PzWOouIBqZcot3RcGY0osfNazO
	 +mpkRLNM/8s8edc5orp+Xzzwb7qwt+R2JMZauZ51Yg8ILg4Wip/sq/lv0MB9ujzEjNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795795590;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BzZlxRjGjdKFCUszLTYPRUS6N/b56U4C0TeTvVVSdA0=;
	b=Frla/hmn7732Gp68+xNjTH7ylO+UBmDS+hlyuPYD+nJgzfuNL3fnE9gFE4GEx+RR9OGa
	 aC9OZANZIv735NIQgPsGdD1Fsqrkf7r62hxfUv46eIXY4GZSM7K7Fh8eIZOdaPolNgCMW
	 vihv7EVhRjSbre69b3sYxLyrOGDblKWY80H6ZcyyQ8hmsdLcAPY/Fnaza2i0OuDqBF0lR
	 jGh7bi+BnaDIQc3A3X1OHADZl/tJp3/1OYctUydQDRglE0aqZRCNPUgT4XrEDeFwklhdN
	 312DBOqeYAvu+qzmROl93uTFvMxu49xZ4lzkW9w8zWCBKx7hEddjnkBYBOmTcX50i/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="eNOBIR/h";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20A7606A31C
	for <linux-input@vger.kernel.org>; Fri, 27 Nov 2026 16:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eNOBIR/h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C7511F00897;
	Fri, 27 Nov 2026 16:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795795590;
	bh=BzZlxRjGjdKFCUszLTYPRUS6N/b56U4C0TeTvVVSdA0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eNOBIR/hYYVk37lQzbk1+O6/zoKWzmgWhCbcNFAf/ZToTxHdO8Z/zR6g3xJwkIh+m
	 A05+ebmpf0FDFtSe4yWOTAzoSHUC47lX5qaxdMQsevGf7z0y7jE00u60/pF8qtrPrE
	 p11y5ErMpbg4JJ3kbfae1MY9FpXm1Yt8r8kOBVS0q3p1bbg+j3UC0ct5rKlr/GuhTi
	 WkkPUISVeDG3H9Iy3yzS4hRgG05CPeGwRn3ic6wgks15bSCk1jewUIMSQ3YRuwGt8a
	 qkREo9IM0oHrq6F+KwIZC8U5+Eq4tspJ0RueIAIz6kaeuiPYTdnPe+Z1tRy5xkFIk0
	 s72ShW8zAQo6Q==
Message-ID: <sashiko-outbox-237826@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 4/6] HID: intel-thc-hid: intel-ipts: add the HID
 device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emfox Zhou" <emfox@debian.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <f8529097ea0778363ba902af07f910036f7f5b94.1795794049.git.emfox@debian.org>
References: <cover.1795794049.git.emfox@debian.org>
 <f8529097ea0778363ba902af07f910036f7f5b94.1795794049.git.emfox@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 16:06:29 +0000
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
- [High] HID: intel-thc-hid: intel-ipts: masked IRQ on recovery starves
  thc_dma_write()
- [Medium] HID: intel-thc-hid: intel-ipts: DMA leak in
  thc_ipts_dma_stop() on reset error
--

commit cf6199acae63b20d55f6ee4b4578d3004cdbf95e
Author: Emfox Zhou <emfox@debian.org>

HID: intel-thc-hid: intel-ipts: add the HID device

This commit registers a HID device for Intel THC ports operating in IPTS
mode, adding report descriptor and feature report handshakes, input report
forwarding, and transmit serialization across recovery and teardown.

> diff --git a/drivers/hid/intel-thc-hid/intel-ipts/ipts.c b/drivers/hid/in=
tel-thc-hid/intel-ipts/ipts.c
> index f5f2cb3d2c7fe..506d2f330caf6 100644
> --- a/drivers/hid/intel-thc-hid/intel-ipts/ipts.c
> +++ b/drivers/hid/intel-thc-hid/intel-ipts/ipts.c

[ ... ]

> @@ -274,6 +400,15 @@ void thc_ipts_recover(struct work_struct *work)
>  	struct thc_ipts *idev =3D container_of(work, struct thc_ipts,
>  					     recover_work);
> =20
> +	/*
> +	 * A write that is already on the wire holds this lock and needs the
> +	 * interrupt that the mask below takes away: let it finish first, or it
> +	 * times out over the bus lock the reset is waiting for.
> +	 */
> +	mutex_lock(&idev->tx_lock);
> +	WRITE_ONCE(idev->recovering, true);
> +	mutex_unlock(&idev->tx_lock);
> +
>  	/*
>  	 * From here the status registers belong to the reset: the threaded
>  	 * handler must not acknowledge a frame it is not going to read, or the
> @@ -281,7 +416,6 @@ void thc_ipts_recover(struct work_struct *work)
>  	 * is only a snapshot to a run that is already inside, so the mask and
>  	 * the wait below are what keeps that run out.
>  	 */
> -	WRITE_ONCE(idev->recovering, true);
>  	thc_interrupt_enable(idev->thc, false);
>  	synchronize_irq(idev->irq);
>  	/* A run that unmasked just before synchronize_irq() returned leaves
> @@ -299,6 +433,7 @@ void thc_ipts_recover(struct work_struct *work)
>  		WRITE_ONCE(idev->recover_seq, READ_ONCE(idev->recover_seq) + 1);
>  		WRITE_ONCE(idev->recover_pending, false);
>  		WRITE_ONCE(idev->recovering, false);
> +		wake_up(&idev->wq);
>  		return;
>  	}

[Severity: Medium]
Does setting idev->state to THC_IPTS_CONFIG when thc_rxdma_reset() fails
cause thc_ipts_dma_stop() to leak the DMA allocations on teardown?

drivers/hid/intel-thc-hid/intel-ipts/ipts.c:thc_ipts_dma_stop() {
	if (READ_ONCE(idev->state) < THC_IPTS_DMA)
		return;

	WRITE_ONCE(idev->state, THC_IPTS_CONFIG);
	thc_dma_unconfigure(idev->thc);
	thc_dma_release(idev->thc);
}

Because idev->state is lowered to THC_IPTS_CONFIG here to make
thc_ipts_send() return -ENODEV, a later thc_ipts_port_stop() will see
idev->state < THC_IPTS_DMA and skip both thc_dma_unconfigure() and
thc_dma_release(), leaking the non-devm coherent PRD tables and mapped
scatterlists.

[ ... ]

> @@ -383,24 +522,294 @@ irqreturn_t thc_ipts_thread(int irq, void *data)
>  			need_recover =3D true;
>  	}
> =20
> -	/* The work item resets the engine and unmasks again; a frame read
> -	 * meanwhile would corrupt the ring.
> +	/*
> +	 * The work item resets the engine in its own time; a frame read
> +	 * meanwhile would corrupt the ring, so only queue the reset.
>  	 */
> -	if (need_recover) {
> +	if (need_recover)
>  		thc_ipts_request_recover(idev);
> -		return IRQ_HANDLED;
> -	}
> =20
> -	/* A reset unmasks when it is done and a teardown masks on its own, so
> -	 * the line only stays open here while neither runs: a write already
> -	 * on the wire needs the completion this handler delivers.
> +	/*
> +	 * A reset unmasks when it is done, and a teardown masks on its own
> +	 * after waiting for this very run. Leaving the line open here is what
> +	 * a write already on the wire needs: this handler is where its
> +	 * completion is delivered, and masking it away would make that write
> +	 * time out over the bus lock the teardown is waiting for.
>  	 */
> -	if (!READ_ONCE(idev->recovering) && !READ_ONCE(idev->stopping))
> +	if (!READ_ONCE(idev->recovering) && !READ_ONCE(idev->recover_pending))
>  		thc_interrupt_enable(idev->thc, true);
> =20
>  	return ret;
>  }

[Severity: High]
Does checking !READ_ONCE(idev->recover_pending) here leave the interrupt
masked while an in-flight write in thc_dma_write() still needs it?

Sender                        IRQ thread                kworker
thc_ipts_send()
  mutex_lock(&idev->tx_lock)
  thc_dma_write()
                              thc_ipts_thread()
                                thc_interrupt_enable(..., false)
                                ...
                                thc_ipts_request_recover()
                                  idev->recover_pending =3D true
                                  schedule_work(...)
                                /* recover_pending is true:
                                 * IRQ is left masked
                                 */
                                                        thc_ipts_recover()
                                                          mutex_lock(&idev-=
>tx_lock)
    wait_event_timeout(..., 1 * HZ)
    <-- TxDMA IRQ masked, times out after 1s

thc_ipts_recover() waits on idev->tx_lock before setting idev->recovering
and masking the line so that a write already on the wire can finish.
However, thc_ipts_request_recover() sets idev->recover_pending =3D true just
above, so checking !READ_ONCE(idev->recover_pending) prevents
thc_ipts_thread() from unmasking the interrupt.  Any concurrent
thc_ipts_send() in thc_dma_write() stalls for its 1-second timeout holding
tx_lock and thc_bus_lock, and if that write was from
thc_ipts_get_feature(), the resulting -ETIMEDOUT permanently latches
idev->feature_off =3D true until the port is restarted.

Should the unmask check here test only !READ_ONCE(idev->recovering)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795794049.gi=
t.emfox@debian.org?part=3D4
