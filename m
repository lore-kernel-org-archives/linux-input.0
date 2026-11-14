Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794693651;
	b=g8XolDbdzc8P5ZlLAQk2oeWTnpBVbd8sRWJVJfn8yDTZtyLu2TJBimREBZ2V8JQbEpkT
	 VQevrqZsqyXcmPbBjQ0AzR88QzR9j1w+LrvXP8hii/K7usHY+q7UAZCHGZFzxwL7/7AnH
	 FC+EXfSmiQW4Hw28SYuZer/fF5SX7B4F45glu9KkhJo0QfTipXkGVQ3Q4/j+IUsydatEX
	 YTn3eBGWz4m5Vy4h4pDsgeHoeZpZ8p8Lyl55fnwWiM1pYWaoYFr4936J9a4XZwCRFDNco
	 MHqSj1LYSclYB+kJmW2Kz8mZ8CyM58j45Fu/K72nERXi1onDhZ2N9emf6cnZY2HyFCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794693651;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Xbq1Z1zap6obJSc+xz7DNCOlsxkDb7k8lsbmS9oDD1g=;
	b=zUQVJLYVDNhlcyaL2x1CIFqIyelZeif6h0VZi45Du0U/9Qqy5HL9TyfFbjFTQyN0wClj
	 M5Iv7U5t57wxCGN55ZzvtAYgcq/vEXgOoGWWuHu6f/ex7rdk6eetx5cK/9CxK5m2ExeHy
	 RzEiSg7PRR5dLV/2YVyiOXIV8sFNlpWfwqVeXfEy+DFNgl5zeDPlrKuBSif/usnsz2nyp
	 sBkUSVTjTrPiu6pBTDM+YG77FYzETRykdN3Qtf1pFlKIMIDRYRwqymxprmixmYXQG3Z5+
	 bxBM3XgXq5QdYRqXRweH9xFdTXvNuP+K2zAdoYgL8SB3fUQPfVmxo+Lrvu1gjVfeRVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k92uuGZt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2652D606A327
	for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 22:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k92uuGZt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 834FC1F000C4;
	Sat, 14 Nov 2026 22:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794693650;
	bh=Xbq1Z1zap6obJSc+xz7DNCOlsxkDb7k8lsbmS9oDD1g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k92uuGZtmVqWrfZ69IGNCo5OZk9lzxDC8cUC2NKIrl9BBFRxAasaV7TGWtEV+N5LI
	 YsOo0I4AVTyxrsYwqI4A2Fx5IDFUpYCPxZW4ojqEfn9jFjhKid6sImDisFei67gQe+
	 fS8NCyuv2YOcC8fixWZUldkJ0AjxD3z6fTwaet+2eWGk58Z/nWQ376KuDqLtNoSmVl
	 VlVifger4tyF/1mUsJVNmWFGdjiJ4bXK5XnOukPO+b6WCqwSfz1jIwVKpDzQGHDA2l
	 lURViJFOMzaNM96hC9IiBBkPIE3Dd9jY1Li7a9GRBVTdGRhuLVTm2B4Nee8oSo5NrQ
	 MmAMquL7S1M/g==
Message-ID: <sashiko-outbox-215053@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/5] HID: intel-thc-hid: intel-ipts: receive reports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emfox Zhou" <emfox@debian.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261114214026.2809740-3-emfox@debian.org>
References: <20261114214026.2809740-1-emfox@debian.org>
 <20261114214026.2809740-3-emfox@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 22:00:50 +0000
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
- [Medium] HID: intel-thc-hid: intel-ipts: shared IRQ race unmasks
  thc_ipts_thread()
- [Medium] HID: intel-thc-hid: PRD table descriptors not reset in
  thc_ipts_recover()
--

commit 45ecfedbdb695899d182e98734d3a4bf861c6155
Author: Emfox Zhou <emfox@debian.org>

HID: intel-thc-hid: intel-ipts: receive reports

This commit configures the Rx and Tx DMA engines for IPTS ports, registers
a threaded interrupt handler, and adds frame reception and error recovery
handling.

> diff --git a/drivers/hid/intel-thc-hid/intel-ipts/ipts.c b/drivers/hid/in=
tel-thc-hid/intel-ipts/ipts.c
> index 205dc51b86cda..b48199448dbec 100644
> --- a/drivers/hid/intel-thc-hid/intel-ipts/ipts.c
> +++ b/drivers/hid/intel-thc-hid/intel-ipts/ipts.c
[ ... ]
> @@ -133,6 +145,212 @@ static int thc_ipts_touch_set(struct thc_ipts *idev=
, bool enable)
[ ... ]
> +irqreturn_t thc_ipts_hardirq(int irq, void *data)
> +{
> +	struct thc_ipts *idev =3D data;
> +
> +	/*
> +	 * The pin is shared and level triggered: mask first, or it stays
> +	 * asserted on the way out. The cause itself can only be read in the
> +	 * thread.
> +	 */
> +	thc_interrupt_enable(idev->thc, false);
> +
> +	/* A reset in flight: the port is masked, so this is not ours. */
> +	if (READ_ONCE(idev->recovering))
> +		return IRQ_NONE;
> +
> +	/*
> +	 * Nothing of ours is pending in these two states and the port is
> +	 * masked: the interrupt belongs to another function on the line.
> +	 */
> +	if (READ_ONCE(idev->stopping) || !READ_ONCE(idev->dma_ready))
> +		return IRQ_NONE;
> +
> +	return IRQ_WAKE_THREAD;
> +}
[ ... ]
> +void thc_ipts_recover(struct work_struct *work)
> +{
> +	struct thc_ipts *idev =3D container_of(work, struct thc_ipts,
> +					     recover_work);
> +
> +	/* A handler may have unmasked after the error; keep it masked. */
> +	thc_interrupt_enable(idev->thc, false);
> +
> +	if (thc_rxdma_reset(idev->thc)) {
> +		/* Nothing left: keep the port masked until it restarts. */
> +		dev_err(idev->dev, "cannot reset the receive engine\n");
> +		return;
> +	}

[Severity: Medium]
Does thc_rxdma_reset() leave hardware-modified PRD table descriptors in
place after an error?

When THC_RXDMA2 writes a frame into a PRD table, the hardware updates each
entry's len to the received byte count and sets end_of_prd on the last
entry used.  Normal reads restore those entries to SZ_4K via
thc_copy_one_sgl_to_prd() in thc_dma_read(), but when need_recover is set
in thc_ipts_thread() (or when read_dma_buffer() fails), pending frames are
left unconsumed.  thc_rxdma_reset() only calls thc_dma_unconfigure() and
thc_dma_configure(), resetting TPCRP and TPCWP without calling
thc_copy_sgls_to_prd(), so later frames that exceed the stale entry
lengths will hit PRD buffer overrun errors.

> +
> +	WRITE_ONCE(idev->recovering, false);
> +	if (!READ_ONCE(idev->stopping))
> +		thc_interrupt_enable(idev->thc, true);
> +}
> +
> +irqreturn_t thc_ipts_thread(int irq, void *data)
> +{
> +	struct thc_ipts *idev =3D data;
> +	irqreturn_t ret =3D IRQ_NONE;	/* no cause of ours yet */
> +	bool need_recover =3D false;
> +	int pass;
> +
> +	/* A reset is in flight; the engine state is not ours to read. */
> +	if (READ_ONCE(idev->recovering))
> +		return IRQ_NONE;
> +
> +	/*
> +	 * The port stays masked until the end of this handler, so a cause that
> +	 * arrives in between leaves only its status bit: keep reading until
> +	 * the core reports none.
> +	 */
> +	for (pass =3D 0; pass < THC_IPTS_IRQ_PASSES; pass++) {
> +		int mask =3D thc_interrupt_handler(idev->thc);
> +
> +		/* The core reports this one when no cause is pending. */
> +		if (mask =3D=3D BIT(THC_UNKNOWN_INT))
> +			break;
> +
> +		ret =3D IRQ_HANDLED;
> +		if (mask & (BIT(THC_FATAL_ERR_INT) | BIT(THC_TXN_ERR_INT))) {
> +			dev_err(idev->dev,
> +				"transfer error, resetting the engine\n");
> +			need_recover =3D true;
> +			/*
> +			 * Keep reading: the core stops at the first cause, so
> +			 * a Tx completion queued behind the error would wait
> +			 * out its timeout under the bus lock.
> +			 */
> +			continue;
> +		}
> +
> +		if (need_recover)
> +			continue;
> +
> +		/*
> +		 * A non-DMA cause needs no action: the core acknowledges it,
> +		 * and this port moves report data through the DMA engines.
> +		 */
> +		if (mask & BIT(THC_RXDMA2_INT) && thc_ipts_read_frames(idev))
> +			need_recover =3D true;
> +	}
> +
> +	/*
> +	 * The work item resets the engine and unmasks the port again; a frame
> +	 * read while it rewrites the ring would corrupt the descriptors, so
> +	 * ->recovering keeps the handler off the line until it is done.
> +	 */
> +	if (need_recover) {
> +		WRITE_ONCE(idev->recovering, true);
> +		schedule_work(&idev->recover_work);
> +		return IRQ_HANDLED;
> +	}
> +
> +	if (!READ_ONCE(idev->stopping))
> +		thc_interrupt_enable(idev->thc, true);
> +
> +	/* An interrupt with no cause of ours is not ours to claim. */
> +	return ret;
> +}

[Severity: Medium]
Can a shared interrupt cause thc_ipts_thread() to run while the port is
unmasked in hardware?

thc_ipts_probe() requests the interrupt with IRQF_SHARED |
IRQF_COND_ONESHOT, which leaves IRQS_ONESHOT unset when no earlier handler
on the line requested IRQF_ONESHOT.  If another device on the shared INTx
line fires while thc_ipts_thread() is running, thc_ipts_hardirq() sets
IRQTF_RUNTHREAD again before the first pass of thc_ipts_thread() unmasks
the port:

CPU0 (irq_thread)                 CPU1 (<hardirq>)
thc_ipts_thread()
  for (pass =3D 0; ...)
    ...
                                  thc_ipts_hardirq()
                                    thc_interrupt_enable(..., false)
                                    return IRQ_WAKE_THREAD
                                    /* sets IRQTF_RUNTHREAD */
  thc_interrupt_enable(..., true)
thc_ipts_thread()                 <-- runs with port unmasked

The same race also exists in thc_ipts_recover() and thc_ipts_port_start(),
which publish idev->recovering =3D false and idev->dma_ready =3D true before
calling thc_interrupt_enable(idev->thc, true): a shared interrupt in that
window wakes thc_ipts_thread() and then gets unmasked underneath it.  If
that unmasked run hits an error, the need_recover path returns without
calling thc_interrupt_enable(idev->thc, false), leaving the port unmasked
until recover_work runs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114214026.2809=
740-1-emfox@debian.org?part=3D2
