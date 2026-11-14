Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794682786;
	b=wI220NrX2v/wYRN/6TB4wPzI1v0E2ngZtlNEwtHeHIbmA3/w6NV0G5n6SdOOBlmh2f6u
	 00hUrhgpuM+DB1mDpsGkpHdKF2N3nadMOpbpGQuM14lRIYKHISvWb0Vc2CUxR1ox9GJFX
	 +Ai925siEUCUW/JO5bO5OZb7pbFKt1dO0oz1RSuubgU3qcpUgpYSqo87xl6lhUtklmSJA
	 ut6oEv6jqRtX0uPG8J+80Rv/YsoB6HPRPXFaXYwoapbHGuxNfNDvaGLfYL5yhKhzECBhj
	 kNc924s+eOzMyMu88HmPe01TkhrQ7DGImhAfaRgw+O2BLbkJWI+WXukyjvRMpZ0fufg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794682786;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=r6VxPJg/eOvJXAtKcqVNzQ6NipodXoUlwnAuSoU9YfM=;
	b=AMpqj8Hx9d8YxRCB/mmg5S/gvI19qhCG6vnA9IO4paXXPGZScJAESG8SCV5XvJkVffvU
	 52dBmW30KhPAew6bnFB/wgxaxFTHQnLRKlMdpBryrEwYm/KdL3PXqCds/pWQns2o97ps3
	 MqMq8QxMj+4LxQ00cEtr0OBcXBme2AxZO38YiuTSQbgsQfMyr5PkkdiaD+xN/K8LVe1OV
	 rfzzGVLmxRWs4S5ecsGaBH+pP/pOx6RfzEG+8poEFj6NYUf42CEYlv9t9/rkmuZCu2ikq
	 I67jinZj0QncmEpRrJPiphNjwYLWIfzBpM3qUnimi0csjqJD3wZBCvS3CnWyt6SWx+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gZ+PGYdl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A5A606A327
	for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 18:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gZ+PGYdl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2086E1F000C4;
	Sat, 14 Nov 2026 18:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794682786;
	bh=r6VxPJg/eOvJXAtKcqVNzQ6NipodXoUlwnAuSoU9YfM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gZ+PGYdlOhKpCm8P0td6tYINC/GI2k2btepZEWfFEcaSUNvufZdWmr6QLhOZG0uiH
	 I3Ie0NoCU9A9rv50/nPh2ISpLmvzFGE9UR/0qa8Ytf7sM8afJoq3DvE6XVOcx6MPmI
	 o8i6hBUvzKLl40zSL2QCqGgmB7BrP/PmD4EmBXSIEBDqcbayhNgkrYMDJQmMDnHvhx
	 teK+c/3+FpDQJ4LwsSj25ARYBL5j+qc6mMZGftHTGYVM21BA5Xy/mz6stQRvnYPeHX
	 q82pDTrAeZnk5zTp577FAsH3SlOXuXrygCu3+jDldFTkK7mqIuZIhxKlF7HucQGNXq
	 bo6szNmTRJdpA==
Message-ID: <sashiko-outbox-214934@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/5] HID: intel-thc-hid: intel-ipts: register the HID
 device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emfox Zhou" <emfox@debian.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261114183624.2379573-4-emfox@debian.org>
References: <20261114183624.2379573-1-emfox@debian.org>
 <20261114183624.2379573-4-emfox@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 18:59:45 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] HID: intel-thc-hid: intel-ipts: check recovering in
  thc_ipts_send()
--

commit 4354955543093e96e544cc3b320f82723b8a7849
Author: Emfox Zhou <emfox@debian.org>

HID: intel-thc-hid: intel-ipts: register the HID device

This commit registers a HID device for the IPTS port and implements report
descriptor parsing, input report forwarding, and feature/output report
requests over DMA.

> diff --git a/drivers/hid/intel-thc-hid/intel-ipts/ipts.c b/drivers/hid/in=
tel-thc-hid/intel-ipts/ipts.c
> index ac0074a85bfa4..bf75f8cc7994e 100644
> --- a/drivers/hid/intel-thc-hid/intel-ipts/ipts.c
> +++ b/drivers/hid/intel-thc-hid/intel-ipts/ipts.c
[ ... ]
> @@ -139,8 +141,79 @@ static int thc_ipts_touch_set(struct thc_ipts *idev,=
 bool enable)
>  				 &touch);
>  }
> =20
> +/*
> + * One frame to the controller: code, length, then the payload padded to=
 four
> + * bytes. The frame is built in @idev->tx_frame, so callers serialise wi=
th
> + * @idev->req_lock.
> + */
> +static int thc_ipts_send(struct thc_ipts *idev, u32 code, const void *da=
ta,
> +			 size_t len)
> +{
> +	size_t padded =3D round_up(len, 4);
> +	u8 *frame =3D idev->tx_frame;
> +
> +	if (READ_ONCE(idev->stopping))
> +		return -ESHUTDOWN;
> +	if (!READ_ONCE(idev->dma_ready))
> +		return -EAGAIN;
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
Should thc_ipts_send() also check READ_ONCE(idev->recovering) before
calling thc_dma_write()?

When a transfer or receive error occurs, thc_ipts_thread() leaves the port
interrupts masked, sets idev->recovering, and schedules idev->recover_work:

CPU0                              CPU1 (kworker)
thc_ipts_thread()
  WRITE_ONCE(idev->recovering, true)
  schedule_work(&idev->recover_work)
  return IRQ_HANDLED (port stays masked)

thc_ipts_send()
  thc_dma_write()
    mutex_lock_interruptible(&dev->thc_bus_lock)
    dma_set_start_bit(...)
                                  thc_ipts_recover()
                                    thc_rxdma_reset()
                                      mutex_lock_interruptible(&dev->thc_bu=
s_lock)
    wait_event_interruptible_timeout(dev->write_complete_wait, ...)
      <-- stalls 1s for masked IRQ while blocking thc_ipts_recover()

Because thc_ipts_recover() cannot unmask the port until it acquires
thc_bus_lock inside thc_rxdma_reset(), thc_dma_write() always times out
after 1 second and aborts the retry loop in thc_ipts_hid_parse() or
thc_ipts_get_feature().  Also, if thc_rxdma_reset() fails in
thc_ipts_recover(), the port stays masked with idev->recovering set while
idev->dma_ready remains true, so every subsequent thc_ipts_send() call will
start TxDMA on the masked port and stall for 1 second holding req_lock and
thc_bus_lock.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114183624.2379=
573-1-emfox@debian.org?part=3D3
