Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794981604;
	b=AbHB22P/fnoKm6VMZ9t2/ABJIR27EbwzN2P0mCZ9ki4wdc+gzoX9EjBh/UyWQ+awV6FC
	 drQ4RaogU+o1J9pW3B4LEhA200FTAqVNwBnL6+z3JAfWn/PvnHfL3Wq74aC8a/XS7O+oO
	 NSfBsm+FyZVIJDJ2dtnUn7yS1mJV9dMyvhHBD7eS8DGfwTSt8ZwEUXS0AVpG3K+rTKeE8
	 psBJIX7721hb6e41oFzDIuzppEsZ3ApVPSqn9z+fW1o5cFw+6zYHU7jvINm0Ut2JOJNPD
	 NBfOvSaLomB0YdvD9VCp1Co8Oh2IMYpf1lq/lkUIqmw4cylQx5iRTN5H+xtMlv5NseQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794981604;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QVM22WD958MBL5p5NSrVBiAwTrKQQhx+pwYntXsgL5Q=;
	b=vpP1svqojm4P99kAuohbf5W/6SZro+j0eiU1kWnmjQwIIviz+1i8KWs0WuqLD33oDag7
	 aMpyWEFquOS03jmDX+87xscK3iHsLql7jACeK+VEWNWhFoW6c3bwcKURLPhSaeXWkovdV
	 /5J5kH5W13t9mCtxksLEZ2QI0POXSZZ4ekuFfNH77+izAOE6YtUXB6TJ4b77mJqhYlj7m
	 1itHvTLMru5XC8UHe6irXjAUpwOZvEbQktNn+tvL+TEx32AuXUWa3YElv+TRhnfQ7Tia0
	 uX9GSXn8nQ8A94Zbi36f1iitIw8+hsOjrn2UJKhuWBo3nxMPTdk7V4HEF2uQH8aBSng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X1Ro6tog;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBFA606A31C
	for <linux-input@vger.kernel.org>; Wed, 18 Nov 2026 06:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X1Ro6tog
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF7D1F000C5;
	Wed, 18 Nov 2026 06:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794981603;
	bh=QVM22WD958MBL5p5NSrVBiAwTrKQQhx+pwYntXsgL5Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X1Ro6togGN098J6z5A0ayReojcVxdz8uZ/O7U0Qr+1gh5S1YGnZOuGa0oJtEG5FUH
	 u3i8n8C+DMa9vmTbaEm1hCPiyxqj9IBK4PbGKlfHkeYB3j0TjlLNap8QI2SsDQpuLf
	 WsePKfF9aFTalVLgsZyKkMcLQmsjH4gVGn5FV07ClXHpSZGH920iapB6OwCBAxDpbv
	 dY4GpDyrfYPO7KRGnCm8I2va+ckz6DQhcBi0A7QC1bdeYimOf8/aQjti0AypLApcdF
	 itdUkQEV/KkuSDFwFr6/A1No7K4uIP7/kZuJGCt+GCdIbnZt0kjerXm8KgEzlN0IP8
	 zDcaTf/6qS+Qg==
Message-ID: <sashiko-outbox-220188@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/5] HID: intel-thc-hid: intel-ipts: add the HID
 device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emfox Zhou" <emfox@debian.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261118054004.363766-4-emfox@debian.org>
References: <20261118054004.363766-1-emfox@debian.org>
 <20261118054004.363766-4-emfox@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 06:00:02 +0000
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
- [High] HID: intel-thc-hid: device-wide in_thread in thc_ipts_send()
  causes -EBUSY
- [Medium] HID: intel-thc-hid: early recover_seq read in
  thc_ipts_get_feature()
- [Medium] HID: intel-thc-hid: IRQ unmask race in thc_ipts_thread() on
  reset and stop
--

commit 6e11ece02bde2a13fad79dc0bf400dc9dc7577a0
Author: Emfox Zhou <emfox@debian.org>

HID: intel-thc-hid: intel-ipts: add the HID device

This commit registers a HID device for the Intel IPTS transport and
implements report descriptor parsing, input report forwarding, and raw
feature and output report requests over THC DMA.

> diff --git a/drivers/hid/intel-thc-hid/intel-ipts/ipts.c b/drivers/hid/in=
tel-thc-hid/intel-ipts/ipts.c
> index 17f6f664e95b5..347a705719e6e 100644
> --- a/drivers/hid/intel-thc-hid/intel-ipts/ipts.c
> +++ b/drivers/hid/intel-thc-hid/intel-ipts/ipts.c
[ ... ]
> @@ -144,8 +146,86 @@ static int thc_ipts_touch_set(struct thc_ipts *idev,=
 bool enable)
>  				 &touch);
>  }
> =20
> +/*
> + * Frames are built in @idev->tx_frame, so the lock is taken here rather=
 than
> + * by the callers: none of them may hold it across a wait.
> + */
> +static int thc_ipts_send(struct thc_ipts *idev, u32 code, const void *da=
ta,
> +			 size_t len)
> +{
> +	size_t padded =3D round_up(len, 4);
> +	u8 *frame =3D idev->tx_frame;
> +
> +	/* The completion of a write is delivered by the threaded handler, so
> +	 * one issued from there would wait out its timeout: refuse it instead,
> +	 * and let the caller retry from its own context.
> +	 */
> +	if (READ_ONCE(idev->in_thread))
> +		return -EBUSY;

[Severity: High]
Does checking the device-wide idev->in_thread flag reject normal process-co=
ntext
callers on other CPUs whenever thc_ipts_thread() is running?

thc_ipts_thread() sets idev->in_thread for its entire execution, including
when woken by a shared INTx interrupt or while delivering touch input
reports.  In thc_ipts_port_start(), interrupts are enabled while
idev->dma_ready is true before calling thc_ipts_hid_add() ->
hid_add_device() -> thc_ipts_hid_parse():

CPU0                              CPU1
thc_ipts_port_start()
  thc_interrupt_enable(..., true)
                                  thc_ipts_thread()
                                    WRITE_ONCE(idev->in_thread, true)
  thc_ipts_hid_add()
    ...
      thc_ipts_hid_parse()
        thc_ipts_send()
          if (READ_ONCE(idev->in_thread))
            return -EBUSY;  <-- aborts hid_add_device() and probe

Because thc_ipts_hid_parse() only retries -EAGAIN and -ETIMEDOUT, -EBUSY
immediately fails HID registration and driver probe, and at runtime hidraw
feature and output requests fail with -EBUSY whenever they overlap with
incoming touch frames.

[ ... ]
> @@ -399,17 +525,19 @@ irqreturn_t thc_ipts_thread(int irq, void *data)
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
> -	/* A reset unmasks when it is done. A teardown masks on its own, so the
> -	 * line stays open here: a write already on the wire needs the
> -	 * completion this handler delivers.
> +	/*
> +	 * A reset unmasks when it is done, and a teardown masks on its own.
> +	 * Leaving the line open here is what a write already on the wire
> +	 * needs: this handler is where its completion is delivered, and
> +	 * masking it away would make that write time out over the bus lock
> +	 * the reset is waiting for.
>  	 */
>  	if (!READ_ONCE(idev->recovering))
>  		thc_interrupt_enable(idev->thc, true);

[Severity: Medium]
Can thc_ipts_thread() unmask interrupts while thc_ipts_recover() or
thc_ipts_port_stop() expects the port to stay masked?

In the recovery path, thc_ipts_recover() does not mask interrupts again
after synchronize_irq(), so a handler that checked idev->recovering just
before it was set leaves interrupts enabled across thc_rxdma_reset() and
after a reset failure:

CPU0 (thc_ipts_thread)            CPU1 (thc_ipts_recover)
if (!READ_ONCE(idev->recovering))
                                  WRITE_ONCE(idev->recovering, true)
                                  thc_interrupt_enable(idev->thc, false)
  thc_interrupt_enable(..., true)
                                  synchronize_irq(idev->irq)
                                  thc_rxdma_reset(idev->thc)  <-- IRQ unmas=
ked

Inaddition, thc_ipts_thread() does not check idev->stopping before calling
thc_interrupt_enable(idev->thc, true), so any shared interrupt that wakes
the thread in thc_ipts_port_stop() before thc_ipts_dma_stop() clears
idev->dma_ready will re-enable device interrupts during teardown.

[ ... ]
> @@ -419,6 +547,274 @@ irqreturn_t thc_ipts_thread(int irq, void *data)
[ ... ]
> +/* A feature report comes back as a frame of its own: the request waits.=
 */
> +static int thc_ipts_get_feature(struct thc_ipts *idev, unsigned char rep=
ortnum,
> +				u8 *buf, size_t len)
> +{
[ ... ]
> +	seq =3D READ_ONCE(idev->recover_seq);
> +
> +	/* A refusal happens before anything is written, so the channel stays
> +	 * open for it; a timeout is a different matter, see below.
> +	 */
> +	ret =3D thc_ipts_send(idev, THC_IPTS_TX_GET_FEATURE, &reportnum, 1);
[ ... ]
> +	wait_event_timeout(idev->wq, READ_ONCE(idev->feature_done) ||
> +			   READ_ONCE(idev->recover_pending) ||
> +			   READ_ONCE(idev->recovering) ||
> +			   READ_ONCE(idev->stopping), timeout);
> +
> +	mutex_lock(&idev->feature_lock);
> +	/* An answer that landed while the wait was expiring counts too. */
> +	if (!idev->feature_done) {
> +		/* A reset discards what the engines had queued, so an answer
> +		 * that was on its way is gone and cannot be waited for.
> +		 */
> +		if (READ_ONCE(idev->recover_seq) !=3D seq ||
> +		    READ_ONCE(idev->recover_pending) ||
> +		    READ_ONCE(idev->recovering) ||
> +		    READ_ONCE(idev->stopping))
> +			ret =3D -EIO;
> +		else
> +			ret =3D -ETIMEDOUT;
> +
> +		idev->feature_pending =3D false;
> +		/* Only a timeout leaves a frame out there: after a reset the
> +		 * answer was dropped and the channel is still in step.
> +		 */
> +		if (ret =3D=3D -ETIMEDOUT)
> +			WRITE_ONCE(idev->feature_off, true);

[Severity: Medium]
Can sampling idev->recover_seq before thc_ipts_send() leave idev->feature_o=
ff
false after a feature request times out on the wire?

CPU0 (thc_ipts_get_feature)       CPU1 (thc_ipts_recover)
seq =3D READ_ONCE(idev->recover_seq)
                                  WRITE_ONCE(idev->recover_seq, ... + 1)
                                  WRITE_ONCE(idev->recover_pending, false)
                                  WRITE_ONCE(idev->recovering, false)
thc_ipts_send()
  guard(mutex)(&idev->tx_lock)
  thc_dma_write()  <-- sent after reset
wait_event_timeout()  <-- times out
if (READ_ONCE(idev->recover_seq) !=3D seq ...)
  ret =3D -EIO;  <-- feature_off not set

Because thc_ipts_recover() finishes before thc_ipts_send() checks
idev->recover_pending and idev->recovering under idev->tx_lock, the request
is transmitted after the reset, but a subsequent timeout sees
idev->recover_seq !=3D seq and leaves the feature channel open while an
unanswered request is still in flight.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118054004.3637=
66-1-emfox@debian.org?part=3D3
