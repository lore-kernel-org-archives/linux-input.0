Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794677051;
	b=N0EpMgyJupYETP68/L8PDIUKskkWB0PkHYqUU5pGCxmwAFinPkABLsG8tZ47mpZJ+Ge3
	 GJRtiGjESKpR7Bx/j0dvXIbTP4t/q69SewPUEPo+k1bKFRecqB4UuarcASoS0HNqfR0c1
	 /o2/tKN9Zfcjzzj6SrtBl9ydgGjOnjDDMtxFKeogNqw/GcEQrqTIyzwqbI8DhxeTEc6MN
	 0t03os28fZxy41CDe+F217XgT3n+VCvoMZ72VhpZ6UGiVO/ZvFxyZoyw7qn3SGnwYEUq3
	 4Piz0y7fDYGWTjwLAXZGp+UWekMRdowxS1y76k+trX8qetIlFFA99257VPLBJ88KcKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794677051;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oB87f8MoV9mzCq29v+yeYYFaNnfLWh9sMr9H5D3JbfM=;
	b=DaQzpFnt/FRV/jmq8xG413JbE+/p7GRikWCj+VnYGsYQ3YvOOTCjp6jDFVY6IjYITjnC
	 AzqEvlzoFJ1s6ObtsB87mzt0kah4zYTPCcJ+9woPriLJ8+Gh5Rz4wf18HpBeElEBjDXcC
	 5Ck8hJxWRV/B4CjC30CmtMViCPg5mOjxdqh0ME/TbUyY3OSKhOCVsJJyW4ELSuMjvxndT
	 OIX20Gp29SuwicC/tKB4bD/QshkESMccRod2LgBq27q1AsHcL6COAjoQxsLziI9krob55
	 PfgRc+22IR6/ONXOevPfHshR2xCh1APJ8k4Zbq4/8vyLix7xfHNb10txUc92vuBCuyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YZvbx2PT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91635606A323
	for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 17:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YZvbx2PT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D861F1F000C4;
	Sat, 14 Nov 2026 17:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794677051;
	bh=oB87f8MoV9mzCq29v+yeYYFaNnfLWh9sMr9H5D3JbfM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YZvbx2PTQnrnEiOS8yNF+H/71vvsT+q5CZ2s2Z6AFN6tLaRMpeR1NN+s+OO5k0vX8
	 o8WdMV1JibuskTw5lBM77M41oy2pwGQz4eSNT/0wFhxBiU9CAc7F+3ne2h7XQWmRZW
	 Wxg4Q+/iKyDzpKK5d88B4O/rBYpi1+pVTTyN1BuVDWv4aQ7qN2OPr5fD99SkFMTo2A
	 2uNnjolBgTj2KcRlwuFCzh/RhwymewSyR2yNfgXr/KVbmP5I2Ebl+BmTBXGWOV6cW4
	 qyCWyvhbnpSqp21xnWs/z0gUQTfgFCzxYDTfzNlgrxaf1o5IxAZkrEt48Ng0MZ3jAv
	 i86Mp+tJ+C0kA==
Message-ID: <sashiko-outbox-214834@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/5] HID: intel-thc-hid: intel-ipts: document the
 IPTS mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emfox Zhou" <emfox@debian.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261114170740.2068179-6-emfox@debian.org>
References: <20261114170740.2068179-1-emfox@debian.org>
 <20261114170740.2068179-6-emfox@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 17:24:08 +0000
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
- [Medium] HID: intel-thc-hid: shared IRQ wakes thc_ipts_thread() during
  recovery
--

commit 5cb5409176af14bd8dc0eade42e103266c4d54c5
Author: Emfox Zhou <emfox@debian.org>

HID: intel-thc-hid: intel-ipts: document the IPTS mode

This series adds the intel-ipts transport driver for Intel Touch Host
Controller ports operating in IPTS mode and documents the protocol details
the driver relies on.

> diff --git a/drivers/hid/intel-thc-hid/intel-ipts/ipts.c b/drivers/hid/in=
tel-thc-hid/intel-ipts/ipts.c
> new file mode 100644
> index 0000000000000..94731303af806
> --- /dev/null
> +++ b/drivers/hid/intel-thc-hid/intel-ipts/ipts.c

[ ... ]

> +irqreturn_t thc_ipts_hardirq(int irq, void *data)
> +{
> +	struct thc_ipts *idev =3D data;
> +
> +	/*
> +	 * The pin is shared and this may be another function's interrupt; the
> +	 * cause can only be read in the thread, so claim it. Mask first, or a
> +	 * level triggered line stays asserted on the way out.
> +	 */
> +	if (READ_ONCE(idev->stopping) || !READ_ONCE(idev->dma_ready)) {
> +		thc_interrupt_enable(idev->thc, false);
> +		return IRQ_HANDLED;
> +	}
> +
> +	thc_interrupt_enable(idev->thc, false);
> +
> +	return IRQ_WAKE_THREAD;
> +}

[ ... ]

> +void thc_ipts_recover(struct work_struct *work)
> +{
> +	struct thc_ipts *idev =3D container_of(work, struct thc_ipts,
> +					     recover_work);
> +
> +	if (thc_rxdma_reset(idev->thc)) {
> +		/* Nothing left: keep the port masked until it restarts. */
> +		dev_err(idev->dev, "cannot reset the receive engine\n");
> +		return;
> +	}
> +
> +	if (!READ_ONCE(idev->stopping))
> +		thc_interrupt_enable(idev->thc, true);
> +}
> +
> +irqreturn_t thc_ipts_thread(int irq, void *data)
> +{
> +	struct thc_ipts *idev =3D data;
> +	bool recovering =3D false;
> +	int pass;
> +
> +	/*
> +	 * The port stays masked until the end of this handler, so a cause that
> +	 * arrives in between leaves only its status bit: keep reading until
> +	 * the core reports none.
> +	 */
> +	for (pass =3D 0; pass < THC_IPTS_IRQ_CAUSES; pass++) {
> +		int mask =3D thc_interrupt_handler(idev->thc);
> +
> +		/* The core reports this one when no cause is pending. */
> +		if (mask =3D=3D BIT(THC_UNKNOWN_INT))
> +			break;
> +
> +		if (mask & (BIT(THC_FATAL_ERR_INT) | BIT(THC_TXN_ERR_INT))) {
> +			dev_err(idev->dev,
> +				"transfer error, resetting the engine\n");
> +			recovering =3D true;
> +			/*
> +			 * Keep reading: the core stops at the first cause, so
> +			 * a Tx completion queued behind the error would wait
> +			 * out its timeout under the bus lock.
> +			 */
> +			continue;
> +		}
> +
> +		if (recovering)
> +			continue;
> +
> +		/*
> +		 * A non-DMA cause needs no action: the core acknowledges it,
> +		 * and this port moves report data through the DMA engines.
> +		 */
> +		if (mask & BIT(THC_RXDMA2_INT) && thc_ipts_read_frames(idev))
> +			recovering =3D true;
> +	}
> +
> +	/*
> +	 * The work item resets the engine and unmasks the port again; reading
> +	 * frames while it rewrites the ring would corrupt the descriptors.
> +	 */
> +	if (recovering) {
> +		schedule_work(&idev->recover_work);
> +		return IRQ_HANDLED;
> +	}
> +
> +	if (!READ_ONCE(idev->stopping))
> +		thc_interrupt_enable(idev->thc, true);
> +
> +	return IRQ_HANDLED;
> +}

[Severity: Medium]
Can a foreign interrupt on the shared INTx line wake thc_ipts_thread()
while recover_work is running or after thc_rxdma_reset() has failed?

irq/thc_ipts                      kworker
thc_ipts_thread()
  recovering =3D true
  schedule_work(&idev->recover_work)
                                  thc_ipts_recover()
                                    thc_rxdma_reset(idev->thc)
<shared INTx from another device>
thc_ipts_hardirq()
  return IRQ_WAKE_THREAD
thc_ipts_thread()
  thc_interrupt_handler(idev->thc)
  thc_ipts_read_frames(idev)      <-- races with thc_rxdma_reset()
  thc_interrupt_enable(..., true) <-- unmasks port mid-reset

thc_ipts_probe() requests the legacy INTx vector with IRQF_SHARED, and
thc_ipts_hardirq() wakes thc_ipts_thread() whenever idev->stopping is
false and idev->dma_ready is true.  Because recovering is a local variable
in thc_ipts_thread(), any interrupt from another PCI function sharing the
line while recover_work is pending or executing wakes thc_ipts_thread()
again with recovering set to false.

That runs thc_interrupt_handler() and thc_ipts_read_frames() concurrently
with thc_rxdma_reset() rewriting the RXDMA2 descriptors, and then calls
thc_interrupt_enable(idev->thc, true), unmasking the port mid-reset or
after a failed reset that intended to keep the port masked.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114170740.2068=
179-1-emfox@debian.org?part=3D5
