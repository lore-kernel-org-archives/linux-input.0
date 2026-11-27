Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795794587;
	b=O8XRQ33z9n6JRQ1vPyP7HX0tHbCMyMl1aN6C/7BzAcOaD4pAr6lZt1UWO6NVmH9CK7Rk
	 J4jw1/IadGNjn/Rm777V1DaFu6HVzCrwrbcmLJp/auxmsPPVIuc3rYFbr88Hkz7CRznns
	 2sqt6069Uhflcq+Z8l8n/6fGWAKMPf+gsyIETlmJXKKxijidQ/DXu+WqktOBnB+Emy/f/
	 To5GZ/2s429v/WjRDt/WNKtYiNu7TB7j+h5UmBiGWiZyje+QmyrF9pVn+I59VyxppHG30
	 dkbHbObBNqJHaMCwNxQw9yVZumWOQqHwOGDKWAkcKo6Ma6NxC8TD/eAmWcFkhLfMErg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795794587;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6mKJ6yo54h/M/lvQ25pTtcfNrAPq9qSKcBrrZr8IETM=;
	b=5hihqQI3ewxcFkQSNg6sDbLbljkScSaPkHELixUSit597aVkyRxbH3MLZfj5QgAcxkq6
	 607TxB3l9eZ0DBycMor/xWrt7Ojlh3LScJ3a997BwP99W87qk4EKMKkiiY5OqZejJvjbT
	 EZjNFc2r2I1/iO2lGIrKhtyex+7Q17uTMI1ln0xjQIs+fH9KGLj2B5vf7al3Wp5V41CBK
	 kXd4MKwc6ex60omhypFA4scxAtMgXcwQWR0QBtjvy40ZRNX7lY8R2PoEAFGdpwLJcpUtt
	 5qxFHZc5e/WxY6EaK1M4WJuhqnvW1Fk0bOWQeb8GLgZ+yYekLwa/kWk96bVHsDYqApQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wqkzcfme;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FE7606A323
	for <linux-input@vger.kernel.org>; Fri, 27 Nov 2026 15:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wqkzcfme
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0474B1F00893;
	Fri, 27 Nov 2026 15:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795794587;
	bh=6mKJ6yo54h/M/lvQ25pTtcfNrAPq9qSKcBrrZr8IETM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WqkzcfmeK6vB1qZ3XbNgccpic22yhOP6l631v5RQVfqd7Ah5bgduYm+v7hKspfhJ7
	 GtuyAFozQZgdX0+fIqgUwADXQK0+aUvzcDvdqi0LZVbg4bqMKnu4hTXKAY/rtgh0Vg
	 IAHiGz0HQmtepK4xS7ZzYUY13b12NHO86GAYMUO02SuKyFdsSefNSYDZ4vEJ8BXJbG
	 Z7PI0IpCnXX99jFkIm16N0tzXcuTS9BR5VBI/kTIZssU4n0HpwY/9h/4xBCTag4RRh
	 c5mnaXWxxa7cUOx3MStQx0NExVmZRiBEgv39n6uXxV/GwbZ5BN/3d9jCfryVqCIp/l
	 x/UoHu+rpwteQ==
Message-ID: <sashiko-outbox-237786@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8] HID: intel-thc-hid: intel-thc: restore PRD table
 capacity
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emfox Zhou" <emfox@debian.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261127234500.424242-1-emfox@debian.org>
References: <20261127234500.424242-1-emfox@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 15:49:46 +0000
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
- [Medium] HID: intel-thc-hid: stale buffer use on stopped-engine
  thc_dma_read()
--

commit 0cc3c55388fa9f5be9c9821cafb9f0a08de39647
Author: Emfox Zhou <emfox@debian.org>

HID: intel-thc-hid: intel-thc: restore PRD table capacity

This commit rebuilds PRD tables before restarting DMA engines, adds a
prd_lock mutex to serialize PRD table operations with the DMA read path,
and skips reading from stopped DMA engines via an is_started flag.

> diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c b/driver=
s/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
> index 01b96c00d5da7..8bff8d5b36051 100644
> --- a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
> +++ b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
[ ... ]
> @@ -703,6 +762,18 @@ static int thc_dma_read(struct thc_device *dev,
> =20
>  	*read_len =3D 0;
> =20
> +	guard(mutex)(&dev->dma_ctx->prd_lock);
> +
> +	/*
> +	 * Nothing in the ring is ours until the engine is started: after a
> +	 * reset the pointers alone say nothing about what was written.
> +	 */
> +	if (!READ_ONCE(read_config->is_started)) {
> +		if (read_finished)
> +			*read_finished =3D 1;
> +		return 0;
> +	}

[Severity: Medium]
Can returning 0 here with *read_len =3D 0 and read_buff untouched cause the
RxDMA callers to re-process stale or concurrently modified buffers?

Neither handle_input_report() in pci-quicki2c.c nor
quickspi_irq_thread_handler() in pci-quickspi.c checks whether the
returned length is 0 when thc_rxdma_read_safe() returns 0:

drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c:handle_input_report=
() {
    ...
		ret =3D thc_rxdma_read_safe(qcdev->thc_hw, THC_RXDMA2, (u8 *)pkt,
					  HIDI2C_PACKET_LEN(qcdev->input_len), &report_len,
					  &rx_dma_finished);
		if (ret =3D=3D -EMSGSIZE)
			continue;

		if (ret)
			return ret;

		if (!pkt->len) {
    ...
}

When a threaded IRQ drain in handle_input_report() races with
quicki2c_get_report() -> thc_swdma_read_safe() pausing THC_RXDMA2 (or with
thc_rxdma_reset()), thc_dma_read() returns 0 without writing to
qcdev->input_buf.  handle_input_report() then either replays the previous
frame in qcdev->input_buf via quicki2c_hid_send_report(), races on
qcdev->input_buf while quicki2c_get_report() writes the SWDMA response
into that same buffer, or treats a zero pkt->len as a Device-Initiated
Reset.

On the SPI side, quickspi_irq_thread_handler() passes input_len =3D 0 to
quickspi_handle_input_data(), where HIDSPI_INPUT_BODY_SIZE(input_len) >
buf_len is always true for buf_len =3D=3D 0 and logs a spurious "Wrong input
report length" error.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127234500.4242=
42-1-emfox@debian.org?part=3D1
