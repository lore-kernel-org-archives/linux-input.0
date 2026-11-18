Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794986044;
	b=OOEjvkNx/gAe45NX5KM9Ova9RL1n0uABiyKHmcDMCA6+lKOfWrknxkG/Oj2VvzJfDFFv
	 X7Vz9e+55TxTaQDXOaQCp+zz7/NUEHEjzRbsz08G0izFY63cFTrTqvCsnmn2eOKkJrsN5
	 9jl4IpDp4OKFC6BfyTClbrIWhoZECFa6k6LCw6+qrYGpHEeYJLLe4Zwi3QN5//tuL3j49
	 Z5WhRV9EyIn+qH54KEVdNis5xTX8Am0urlH+lEgfWaVm0hDLgkg2pCelGS1vZ33TExPcF
	 8ZUzpEJuIKyBYg0bhUR3q2rnix53BUthxEUdDcht3tovAr9pnOudhd1iheihTQqzW7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794986044;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LD+rkiO4YIwSpFejT2zd4P7+nN6zQ0ULkPohX1HbdJU=;
	b=hkhqilvxn6UNIwuqFkHR/22KYgDROzog8RC2dYqQZcX/Fuhv32ia0Wut5j8zsg/h5t+L
	 0nH6rizJmS14Y1mlQZYotc40TfzwOl+3RvAO1Wl4JinjP5804VmJ687j/Fd9Rte9gY1Kj
	 vq7AgPwXsAnfi6Yb4s6cJ3FhTwVuSZDFVHEgHZJa6ITgJ1XUmAtH251tQksR+A4mU9EEC
	 YB7fFx9LiHYvY/VKQCdOzh9a98zcd6YEl+tmiCMx4UrncJ91r9s4AQ0Hew8HnQRFjvcfb
	 zsXclad0bgz4wdprrOG7x0mDHbbCsvntz6qoK1pt2+g+/8nFRfAZeyoYZl8XyRdyl7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ez1x9oxu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC42E606A31C
	for <linux-input@vger.kernel.org>; Wed, 18 Nov 2026 07:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ez1x9oxu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF4311F000C4;
	Wed, 18 Nov 2026 07:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794986044;
	bh=LD+rkiO4YIwSpFejT2zd4P7+nN6zQ0ULkPohX1HbdJU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ez1x9oxu6PPVDyXlZHUaHMW9zrTXq1HKV4kjLRZVNxe4YtoKWbCx1Ks49h55Tl57i
	 M3iS4xvvVJC0AOJroHEtS3pTedredhyD24iuda1eRCS/9F4bz5kTwNYPTlJUYVcou7
	 xSY+/vouMSctuwN6ptANZFzOLrOav8LrBSRFcnLTNjp3ZBsV91zMOZ8ds71co5qxFz
	 VuBGu/J04oW8w8IO71epzNu4IXI2vumkkDVpU5O8RjIRSOHyIU4qARn5zwNrdbDHRT
	 dHolT8uC1HqAkgUmF/wCNqypn5dx0h86Y9lzCSvUGfmnwpt2PSsiJM0SD4FwkY8AD1
	 se41BwymBLZGQ==
Message-ID: <sashiko-outbox-220297@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/5] HID: intel-thc-hid: intel-ipts: add the HID
 device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emfox Zhou" <emfox@debian.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261118065725.673090-4-emfox@debian.org>
References: <20261118065725.673090-1-emfox@debian.org>
 <20261118065725.673090-4-emfox@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 07:14:03 +0000
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
- [Medium] HID: intel-thc-hid: intel-ipts: race on recover_seq in
  thc_ipts_get_feature()
- [Medium] HID: intel-thc-hid: intel-ipts: stale recovery state in
  thc_ipts_recover()
--

commit e0bc1fa63dd36608a943c89014dbfd5351a76676
Author: Emfox Zhou <emfox@debian.org>

HID: intel-thc-hid: intel-ipts: add the HID device

This commit registers a HID device for Intel THC ports in IPTS mode and
implements report descriptor parsing, input report forwarding, and raw
feature and output report transfers.

> diff --git a/drivers/hid/intel-thc-hid/intel-ipts/ipts.c b/drivers/hid/in=
tel-thc-hid/intel-ipts/ipts.c
> index e7896b16f1ada..f519ba2f7ce3d 100644
> --- a/drivers/hid/intel-thc-hid/intel-ipts/ipts.c
> +++ b/drivers/hid/intel-thc-hid/intel-ipts/ipts.c

[ ... ]

> @@ -318,6 +440,8 @@ void thc_ipts_recover(struct work_struct *work)
>  	if (thc_rxdma_reset(idev->thc)) {
>  		/* Nothing left: keep the port masked until it restarts. */
>  		dev_err(idev->dev, "cannot reset the receive engine\n");
> +		/* It stays masked, so the waiters learn it from the flags. */
> +		wake_up(&idev->wq);
>  		return;
>  	}

[Severity: Medium]
When thc_rxdma_reset() fails, does leaving idev->recover_pending and
idev->recovering set while idev->dma_ready remains true keep waiters and
callers of thc_ipts_send() stuck in a transient recovery state?

thc_ipts_hid_parse() waits on thc_ipts_idle(idev), which requires both
recover_pending and recovering to be false, so wake_up(&idev->wq) here does
not wake it and it waits out all THC_IPTS_REQ_TRIES timeouts.  In addition,
thc_ipts_send() checks recover_pending and recovering before dma_ready, so
subsequent sends keep returning -EAGAIN instead of -ENODEV.

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

[ ... ]

> +	ret =3D thc_ipts_send(idev, THC_IPTS_TX_GET_FEATURE, &reportnum, 1);
> +	if (ret) {
> +		mutex_lock(&idev->feature_lock);
> +		idev->feature_pending =3D false;
> +
> +		/* The start bit was written before the wait, so the frame may
> +		 * well be on the wire: its answer cannot be told from the next
> +		 * request's one.
> +		 */
> +		if (ret =3D=3D -ETIMEDOUT)
> +			WRITE_ONCE(idev->feature_off, true);
> +		mutex_unlock(&idev->feature_lock);
> +
> +		if (ret =3D=3D -ETIMEDOUT)
> +			dev_err(idev->dev, "feature report %u not acknowledged\n",
> +				reportnum);
> +
> +		return ret;
> +	}
> +
> +	/* Taken after the write, or a reset that ran before it would be
> +	 * mistaken for one that dropped this frame.
> +	 */
> +	seq =3D READ_ONCE(idev->recover_seq);
> +
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
Can a reset that was queued during thc_ipts_send() finish before
thc_ipts_get_feature() samples idev->recover_seq, causing the dropped
feature response to be treated as a timeout?

CPU0                                  CPU1 (kworker)
thc_ipts_get_feature()
  thc_ipts_send()
    lock(&idev->tx_lock)
    thc_dma_write()
      ... (Rx error queues recover_work)
                                      thc_ipts_recover()
                                        lock(&idev->tx_lock)
    unlock(&idev->tx_lock)
                                        unlock(&idev->tx_lock)
                                        thc_rxdma_reset()
                                        idev->recover_seq++
                                        idev->recover_pending =3D false
                                        idev->recovering =3D false
  seq =3D READ_ONCE(idev->recover_seq)
  wait_event_timeout(...)
  /* times out with recover_seq =3D=3D seq */
  idev->feature_off =3D true            <-- disables feature reports

Because idev->recover_seq is read after thc_ipts_send() drops
idev->tx_lock, thc_ipts_recover() can reset the receive engine (dropping
the answer), increment recover_seq, and clear recover_pending and
recovering before seq is sampled.  thc_ipts_get_feature() then sees no
change in recover_seq, returns -ETIMEDOUT instead of -EIO, and sets
idev->feature_off =3D true, shutting off all further feature requests until
the port restarts.

Also, wait_event_timeout() does not check READ_ONCE(idev->recover_seq) !=3D
seq in its condition, so if thc_ipts_recover() completes before the wait
condition is evaluated, the caller sleeps for the full timeout before
returning -EIO.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118065725.6730=
90-1-emfox@debian.org?part=3D3
