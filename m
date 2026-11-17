Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794902112;
	b=QpJ2kO2llspbmHBm8Ue99lq60Uo5HAsGuSgHPAhgjVEAZHO1vbcjPANyJnNnP02x2WZH
	 MaeUuftizNNLUbLs/SwVAqQyUzRJ4z3ghoScGz9BksRmnu9FDq5rFQPaXUJbrcEEDQ8RW
	 PdG7hvOKGntlghODB1Wb7dyvJA7vSrynmpTK4wwCSpk0rcCmim1Z/ZjayIP1NF7JwtHPh
	 cRGLBEqBxqv89Av1ntB2X75eBEMVBHHMYXfEz2iYjr7BM80ihm+nmK5QoFImCYE71k+y2
	 pL3Fd/qKU3Mik1gpuX6apGM47pLcvJ6O84yzgqwts0V4qKFbGbFsRXfpO0X5k7Opjig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794902112;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GR7RZlP019AoXAmFmHpWDu1e6YlqP+A+yZ+JhfMb/YQ=;
	b=ufIj5HWVImYm4CIayZ2k6cSoAb6xFLaeoxrbNGgAo/6vzBIbYzqkM5JbygRyGSerC+4R
	 fZ0MpoUkNaejZuvZfgjjCDcKw2pl7E94JGzq4Up8j0uesJLhxdxvMFxxLZ1vLJeq/AG7s
	 jo7EnJbuSIUJRli/ri0IKkRBml7fAGDVl17MXifHadyGXQWUSgobiW9N/zzcFhrNyWqtG
	 eNLsRsxbPjHO9pYBTB78/IlOZ5ZdOrBdxYAhpDm/RxuZ/10wdj7C3vJ9rZ4QZWgo0rKxB
	 Hot5JqKfy4gkH98ntlRr/YJTwXoAMi0128oVYEu4TzTQ6+Gv+kKUoXFK+2pS7Upjrew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=abyaKQLW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB7D606A31C
	for <linux-input@vger.kernel.org>; Tue, 17 Nov 2026 07:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=abyaKQLW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 861EB1F000C4;
	Tue, 17 Nov 2026 07:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794902112;
	bh=GR7RZlP019AoXAmFmHpWDu1e6YlqP+A+yZ+JhfMb/YQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=abyaKQLW6eGO43SQL8dIb7JXPgiEp5OZK75lzOzG/l/edGWJixHknDOpnFBUQLjlW
	 pQ5k1M8+nbpHpFeVeLko1wEflPEMw2uyfAJQwbF64YOtUMutI9VEL7JRdU/jdDFdbE
	 HImBgjvXhA86iQxZyQSnVuQypqr+2zKkvjC23g4rIBzpQHqGAw+oYRm7U09HH1pq0S
	 cNzvtwQ60wrMvu4fIr2cFNEk3CcUP90pg0o/lYl3UJHBUmn3uBShqhQ8bAA3X81mi9
	 OKxBIOLERj+wV5JQSH3EGxVD/1k/v5iITvJG3q3IfvF7U5TBkWh4xv5/Sp562PxLMv
	 +daBi02dgfiGQ==
Message-ID: <sashiko-outbox-218389@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/5] HID: intel-thc-hid: intel-ipts: register the HID
 device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emfox Zhou" <emfox@debian.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261117073554.11557-4-emfox@debian.org>
References: <20261117073554.11557-1-emfox@debian.org>
 <20261117073554.11557-4-emfox@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 07:55:12 +0000
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
- [Medium] HID: intel-thc-hid: intel-ipts: unset feature_off on
  thc_dma_write() timeout
- [Medium] HID: intel-thc-hid: intel-ipts: premature stopping flag in
  thc_ipts_port_stop()
- [Medium] HID: intel-thc-hid: intel-ipts: recovery masks in-flight
  thc_dma_write() IRQ
--

commit 4704713917ed8c2f944a8f47ba40eb93a02b398c
Author: Emfox Zhou <emfox@debian.org>

HID: intel-thc-hid: intel-ipts: register the HID device

This commit registers a HID device for each IPTS port and implements the
report descriptor, feature report, and input report handling over the THC
DMA transport.

> diff --git a/drivers/hid/intel-thc-hid/intel-ipts/ipts.c b/drivers/hid/in=
tel-thc-hid/intel-ipts/ipts.c
> index 2265d07355221..5fc396e1b3d13 100644
> --- a/drivers/hid/intel-thc-hid/intel-ipts/ipts.c
> +++ b/drivers/hid/intel-thc-hid/intel-ipts/ipts.c
[ ... ]
> @@ -144,8 +146,75 @@ static int thc_ipts_touch_set(struct thc_ipts *idev,=
 bool enable)
>  				 &touch);
>  }
> =20
> +/* Frames are built in @idev->tx_frame, so callers hold @req_lock. */
> +static int thc_ipts_send(struct thc_ipts *idev, u32 code, const void *da=
ta,
> +			 size_t len)
> +{
> +	size_t padded =3D round_up(len, 4);
> +	u8 *frame =3D idev->tx_frame;
> +
> +	if (READ_ONCE(idev->stopping))
> +		return -ESHUTDOWN;
> +	/* The port is masked: the write would wait out its timeout. */
> +	if (READ_ONCE(idev->recovering))
> +		return -EAGAIN;
> +	/* No engine to write into: waiting for a reset would not help. */
> +	if (!READ_ONCE(idev->dma_ready))
> +		return -ENODEV;
> +	if (THC_IPTS_TX_HDR_SIZE + padded > idev->max_tx)
> +		return -EMSGSIZE;
> +
> +	put_unaligned_le32(code, frame);
> +	put_unaligned_le32((u32)len, frame + 4);
> +	memset(frame + THC_IPTS_TX_HDR_SIZE, 0, padded);
> +	if (len && data)
> +		memcpy(frame + THC_IPTS_TX_HDR_SIZE, data, len);
> +
> +	return thc_dma_write(idev->thc, frame, THC_IPTS_TX_HDR_SIZE + padded);
> +}

[Severity: Medium]
Can a concurrent receive recovery mask the port interrupt while
thc_dma_write() is already waiting for its transmit completion?

thc_ipts_send() checks idev->recovering without synchronization against
thc_ipts_request_recover():

CPU0                              CPU1 (thc_ipts_thread)
thc_ipts_send()
  READ_ONCE(idev->recovering) -> false
  thc_dma_write()
    mutex_lock(&dev->thc_bus_lock)
    dma_set_start_bit(... THC_TXDMA)
                                  thc_ipts_request_recover()
                                    WRITE_ONCE(idev->recovering, true)
                                    thc_interrupt_enable(idev->thc, false)
                                    schedule_work(&idev->recover_work)
    wait_event_interruptible_timeout()
      <-- 1s timeout (-ETIMEDOUT)

Disabling THC_M_PRT_INT_EN_GBL_INT_EN prevents the TXDMA completion
interrupt from firing, so thc_dma_write() stalls for its full 1-second
timeout while holding thc_bus_lock (which also blocks thc_rxdma_reset() in
thc_ipts_recover()).  In thc_ipts_hid_parse(), only -EAGAIN is retried on
reset, so -ETIMEDOUT from thc_dma_write() aborts report descriptor
parsing and fails HID registration.

[ ... ]

> +/* A feature report comes back as a frame of its own: the request waits.=
 */
> +static int thc_ipts_get_feature(struct thc_ipts *idev, unsigned char rep=
ortnum,
> +				u8 *buf, size_t len)
> +{
> +	unsigned long timeout =3D msecs_to_jiffies(THC_IPTS_REQ_TIMEOUT_MS);
> +	unsigned int seq;
> +	int ret;
> +
> +	guard(mutex)(&idev->req_lock);
> +
> +	/* The frame carries only the report ID, so a late answer cannot be
> +	 * told from the next one's: after a timeout the channel stays shut.
> +	 */
> +	if (READ_ONCE(idev->feature_off))
> +		return -EIO;
> +
> +	mutex_lock(&idev->feature_lock);
> +	WRITE_ONCE(idev->feature_done, false);
> +	idev->feature_id =3D reportnum;
> +	idev->feature_pending =3D true;
> +	mutex_unlock(&idev->feature_lock);
> +
> +	seq =3D READ_ONCE(idev->recover_seq);
> +
> +	/* A frame that never reached the wire says nothing about the
> +	 * controller, so it is reported and the channel stays open.
> +	 */
> +	ret =3D thc_ipts_send(idev, THC_IPTS_TX_GET_FEATURE, &reportnum, 1);
> +	if (ret) {
> +		mutex_lock(&idev->feature_lock);
> +		idev->feature_pending =3D false;
> +		mutex_unlock(&idev->feature_lock);
> +
> +		return ret;
> +	}

[Severity: Medium]
Does an error from thc_ipts_send() guarantee that the request never
reached the wire?

thc_ipts_send() calls thc_dma_write(), which starts the hardware TXDMA
engine before waiting on dev->write_complete_wait:

drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c:thc_dma_write() {
    ...
	dma_set_start_bit(dev, &dev->dma_ctx->dma_config[THC_TXDMA]);

	ret =3D wait_event_interruptible_timeout(dev->write_complete_wait, dev->wr=
ite_done, 1 * HZ);
	if (ret <=3D 0 || !dev->write_done) {
		dev_err_once(dev->dev, "timeout for waiting TxDMA completion\n");
		ret =3D -ETIMEDOUT;
		goto end;
	}
    ...
}

If wait_event_interruptible_timeout() is interrupted by a signal or times
out, thc_dma_write() returns -ETIMEDOUT after dma_set_start_bit() has
already put the THC_IPTS_TX_GET_FEATURE frame on the wire.  Returning here
without setting idev->feature_off =3D true allows the next
thc_ipts_get_feature() call for the same report ID to consume the late
reply from this request and return stale data.

[ ... ]

> @@ -485,11 +817,15 @@ int thc_ipts_port_start(struct thc_ipts *idev)
>   */
>  void thc_ipts_port_stop(struct thc_ipts *idev)
>  {
> -	/*
> -	 * Mask the line, then wait for a handler that may be holding a
> -	 * frame for the HID device which is about to go away.
> +	/* Refuse new requests first, then wait for one that is already inside
> +	 * thc_dma_write(): it needs the interrupt the mask below takes away.
> +	 * The lock is not held across synchronize_irq(), because the threaded
> +	 * handler can issue a request of its own from a HID callback.
>  	 */
>  	WRITE_ONCE(idev->stopping, true);
> +	mutex_lock(&idev->req_lock);
> +	mutex_unlock(&idev->req_lock);
> +
>  	thc_interrupt_enable(idev->thc, false);

[Severity: Medium]
Does setting idev->stopping before acquiring idev->req_lock still cut off
interrupts and incoming frames for an in-flight request?

If an interrupt fires on the shared line while thc_ipts_port_stop() is
waiting on idev->req_lock (for example from an incoming RXDMA2 frame or a
shared IRQ peer), thc_ipts_hardirq() masks the port and wakes
thc_ipts_thread(), which sees idev->stopping =3D=3D true and exits without
unmasking:

CPU0 (request)            CPU1 (thc_ipts_port_stop)  CPU2 (IRQ)
mutex_lock(&idev->req_lock)
thc_ipts_send()
  thc_dma_write()
    dma_set_start_bit()
                          WRITE_ONCE(stopping, true)
                          mutex_lock(&idev->req_lock)
                                                     thc_ipts_hardirq()
                                                       thc_interrupt_enable=
(false)
                                                     thc_ipts_thread()
                                                       if (!stopping && ...)
                                                         /* skipped */
    wait_event_interruptible_timeout()
      <-- 1s timeout

Because the port interrupt stays masked, an in-flight thc_dma_write()
still waits out its 1-second timeout.  Similarly, if the holder of
idev->req_lock is waiting on idev->wq in thc_ipts_get_feature() or
thc_ipts_hid_parse(), thc_ipts_thread() skips thc_ipts_read_frames() when
idev->stopping is true and nothing wakes idev->wq, forcing a 300 ms
timeout and a false dev_err() message on teardown.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117073554.1155=
7-1-emfox@debian.org?part=3D3
