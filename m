Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794677543;
	b=XV5Hra1hldt8vuFme9HYPzotxqnRloEayTng4mfMrGJmtVf6G4wQrvZKUNhsM6BZMaYx
	 UgKhfh1YJvexivZMJtmHhbuOn6axr6bfspDZbHInCQlv4PyUQUWYiYkEzsbS2vJQ4xUyo
	 5cHCnbsG+USHePGY+v+EX2rRnWG31ASEKh87YJpD8bwJfPrcHLML16k3H+aIHPz1f4fOQ
	 eitHGImWS3/JJ0qRw8MnSWVlFjM4HVJ6ZlxiAUliRyGO7pO6uESSV29bf1SgGuRVpGyuO
	 /P6FR3hsRbYnV20uSSjf50YxsmI8QJMpCQeG74kMP46toCah9YsRbrdcO1Xh/SO5CpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794677543;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7+lO0atahR8ezQ+6g+CjddZB4PZV74gURQPAFTle244=;
	b=2b//B8QaCqMRevc91x4x5QINyNPE7c2HEeTMHVHFs/oXa8oTl+4BvVN/wOX/lJUp++Bq
	 qHhUCEZuMiTACXsZobAHiHS5i/TSF1RarDrUI3rC0ELy3f2aI757UJRBdp8BIKrhyQJPX
	 GD/09X0iiCr/cqQEVWa+sE3gHvU2FJ1IthOOHUZUF/UC5EtlWcAFSEkC3e+6HZFNsoy9O
	 SKzjdHlDCYJz258OP+nPuPF7rJyOmNr0YxzIACEjyhAVcimkavi16gXN4AVgqvTwsXAzP
	 k0eA9Q3P8DtFV4zQUssc8lJsJu6irEahSFnSxD7MzjrH6hZTAvBJ+h1DbQsCyqc6Tbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MxOeNjSU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DDB606A327
	for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 17:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MxOeNjSU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE7B1F000C4;
	Sat, 14 Nov 2026 17:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794677543;
	bh=7+lO0atahR8ezQ+6g+CjddZB4PZV74gURQPAFTle244=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MxOeNjSUKabo+8Ey73nWTMPa0mGUONLCi6TDOLeOWzZuFoPYXy37vHDfuL/2Nv4+h
	 Lhkg1ourMXjH2Y3GFPzncr6L2WjdCimumDbPoT9trUPqqLpZhdkFd2Uvhk3gQqmioG
	 +E9pb12TDNNyF1LyaI58TPzCeOBCXtxp20KkvOQ+pXpvwhobxwuedB9pS/up9d29Qb
	 1bkIEXcieRURqK9kUCRau/6E70h1fQSMzupZgRaZOktPJzHdyPR+NnQmV1h5Rp6Nzy
	 eer84QZUqf37MBOzKinRaG8dlBsNGRlpbNyM5GfFvfRdCEAWz77NUAYQjD+L6g7EhN
	 nzUxvfs7OBWrA==
Message-ID: <sashiko-outbox-214837@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/5] HID: intel-thc-hid: intel-ipts: register the HID
 device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emfox Zhou" <emfox@debian.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261114170740.2068179-4-emfox@debian.org>
References: <20261114170740.2068179-1-emfox@debian.org>
 <20261114170740.2068179-4-emfox@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 17:32:22 +0000
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
- [Medium] HID: intel-thc-hid: intel-ipts: broken teardown order in
  thc_ipts_port_stop()
- [Medium] HID: intel-thc-hid: intel-ipts: unsynchronized state in
  thc_ipts_feature()
--

commit 87c60a2c7ee93d31f389d58942f54dadcd3f0e5e
Author: Emfox Zhou <emfox@debian.org>

HID: intel-thc-hid: intel-ipts: register the HID device

This commit registers a HID low-level driver for the IPTS port to fetch
report descriptors and feature reports over DMA and pass input reports to
the HID core.

> diff --git a/drivers/hid/intel-thc-hid/intel-ipts/ipts.c b/drivers/hid/in=
tel-thc-hid/intel-ipts/ipts.c
> index 790c3eaae15f2..94731303af806 100644
> --- a/drivers/hid/intel-thc-hid/intel-ipts/ipts.c
> +++ b/drivers/hid/intel-thc-hid/intel-ipts/ipts.c

[ ... ]

> +/* The report is collected in a private buffer; the caller copies it out=
. */
> +static void thc_ipts_feature(struct thc_ipts *idev, const u8 *data,
> +			     size_t len)
> +{
> +	if (!len || !READ_ONCE(idev->feature_pending))
> +		return;
> +
> +	/* An answer to an earlier request carries its own report ID. */
> +	if (READ_ONCE(idev->feature_id) &&
> +	    data[0] !=3D READ_ONCE(idev->feature_id))
> +		return;
> +
> +	len =3D min(len, idev->max_rx);
> +	memcpy(idev->feature, data, len);
> +	idev->feature_len =3D len;
> +	WRITE_ONCE(idev->feature_pending, false);
> +	WRITE_ONCE(idev->feature_done, true);
> +	wake_up(&idev->wq);
> +}

[ ... ]

> +/*
> + * A feature report is not pushed by the controller: it is asked for and=
 comes
> + * back as a frame of its own, so the request waits for the handler.
> + */
> +static int thc_ipts_get_feature(struct thc_ipts *idev, unsigned char rep=
ortnum,
> +				u8 *buf, size_t len)
> +{
> +	int ret =3D -ETIMEDOUT;
> +	unsigned long timeout =3D msecs_to_jiffies(THC_IPTS_REQ_TIMEOUT_MS);
> +	int try;
> +
> +	guard(mutex)(&idev->req_lock);
> +
> +	WRITE_ONCE(idev->feature_done, false);
> +	WRITE_ONCE(idev->feature_id, reportnum);
> +	WRITE_ONCE(idev->feature_pending, true);
> +
> +	for (try =3D 0; try < THC_IPTS_REQ_TRIES; try++) {
> +		ret =3D thc_ipts_send(idev, THC_IPTS_TX_GET_FEATURE, &reportnum,
> +				    1);
> +		if (ret)
> +			break;
> +
> +		if (wait_event_timeout(idev->wq, READ_ONCE(idev->feature_done),
> +				       timeout)) {
> +			ret =3D 0;
> +			break;
> +		}
> +
> +		ret =3D -ETIMEDOUT;
> +	}
> +
> +	WRITE_ONCE(idev->feature_pending, false);
> +
> +	if (ret) {
> +		dev_err(idev->dev, "no feature report %u after %d tries\n",
> +			reportnum, try);
> +		return ret;
> +	}
> +
> +	/* The payload is the report as user space writes it: ID first. */
> +	len =3D min(len, idev->feature_len);
> +	if (!len)
> +		return -EPROTO;
> +	memcpy(buf, idev->feature, len);
> +
> +	return len;
> +}

[Severity: Medium]
Can a late reply in thc_ipts_feature() overwrite idev->feature or complete
a later thc_ipts_get_feature() call with the wrong report?

thc_ipts_feature() checks feature_pending and feature_id without a lock
shared with thc_ipts_get_feature():

CPU0                                  CPU1 (thc_ipts_thread)
thc_ipts_get_feature(idev, id_A, ...)
  feature_id =3D id_A
  feature_pending =3D true
  ...
                                      thc_ipts_feature()
                                        if (!READ_ONCE(idev->feature_pendin=
g))
                                        if (data[0] !=3D READ_ONCE(feature_=
id))
  /* times out or -EINTR on retry */
  feature_pending =3D false
  unlock(&idev->req_lock)

thc_ipts_get_feature(idev, id_B, ...)
  feature_done =3D false
  feature_id =3D id_B
  feature_pending =3D true
                                        memcpy(idev->feature, data, len)
                                        idev->feature_len =3D len
                                        feature_done =3D true  <-- wrong re=
port
                                        wake_up(&idev->wq)

Also, when try 0 times out and try 1 sends a second THC_IPTS_TX_GET_FEATURE
for the same report ID, the delayed reply to try 0 wakes try 1 and leaves
the reply to try 1 in flight to satisfy the next thc_ipts_get_feature()
request for that report ID with stale data.

[ ... ]

> @@ -452,5 +732,9 @@ void thc_ipts_port_stop(struct thc_ipts *idev)
>  			  THC_M_PRT_CONTROL_DEVRST);
>  	thc_ipts_quiesce(idev, true);
> =20
> -	thc_ipts_dma_stop(idev);
> +	/* Let a send inside thc_dma_write finish before the DMA goes. */
> +	scoped_guard(mutex, &idev->req_lock)
> +		thc_ipts_dma_stop(idev);
> +
> +	thc_ipts_hid_remove(idev);
>  }

[Severity: Medium]
Does thc_ipts_port_stop() disable interrupts and reset the controller
before waiting for in-flight HID requests under idev->req_lock?

drivers/hid/intel-thc-hid/intel-ipts/ipts.c:thc_ipts_port_stop() {
    ...
	WRITE_ONCE(idev->stopping, true);
	thc_interrupt_enable(idev->thc, false);
	synchronize_irq(idev->irq);
	cancel_work_sync(&idev->recover_work);

	/* Stop the controller before the buffers it writes into go away. */
	if (idev->running)
		thc_ipts_touch_set(idev, false);

	idev->running =3D false;
	regmap_clear_bits(idev->thc->thc_regmap,
			  THC_M_PRT_CONTROL_OFFSET,
			  THC_M_PRT_CONTROL_DEVRST);
	thc_ipts_quiesce(idev, true);

	/* Let a send inside thc_dma_write finish before the DMA goes. */
	scoped_guard(mutex, &idev->req_lock)
		thc_ipts_dma_stop(idev);

	thc_ipts_hid_remove(idev);
}

Because thc_ipts_hid_remove() runs last and idev->req_lock is only acquired
around thc_ipts_dma_stop(), a concurrent thc_ipts_hid_raw_request() call can
still be running while the port is being stopped:

CPU0                                  CPU1
thc_ipts_hid_raw_request()
  lock(&idev->req_lock)
  thc_ipts_send()
    if (READ_ONCE(idev->stopping))
    if (!READ_ONCE(idev->dma_ready))
                                      thc_ipts_port_stop()
                                        idev->stopping =3D true
                                        thc_interrupt_enable(..., false)
                                        regmap_clear_bits(..., DEVRST)
                                        thc_ipts_quiesce(..., true)
                                        lock(&idev->req_lock)
    thc_dma_write()
      dma_set_start_bit(...)          <-- starts TxDMA in reset/quiesced
      wait_event_interruptible_timeout(dev->write_complete_wait, ..., 1 * H=
Z)
                                      <-- times out with interrupts masked

Even if thc_dma_write() was already waiting before thc_ipts_port_stop()
started, masking interrupts prevents THC_TXDMA_INT from waking
dev->write_complete_wait, forcing a 1-second timeout on dev->thc_bus_lock
and idev->req_lock.  Likewise, a caller waiting in thc_ipts_get_feature()
on idev->wq is not woken by thc_ipts_port_stop() and does not check
idev->stopping.

Removing the HID device first (or serializing the stopping state under
idev->req_lock and waking idev->wq before masking interrupts and resetting
the controller) would let active transfers complete cleanly.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114170740.2068=
179-1-emfox@debian.org?part=3D3
