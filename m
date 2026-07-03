Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01EF433E7C
	for <linux-input@vger.kernel.org>; Fri,  3 Jul 2026 08:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783066356; cv=none; b=DWAA1r7P+bARhO1U4Fy57Ay9EIGdE9jNt5hz//KG4Iw7kQBUscD7CmpLSkSohA0cpJZpq+C5TYy+dGCuHe5WW+19Bj10j/bbKJfty2ReYDSc7vtBwGnyMVglDWFVdXQ5N1TUunfR3jCmWY+axT2w8JgdjFdfpwWJqBi3giPhK1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783066356; c=relaxed/simple;
	bh=jkSfsn4nbyeZ0WctmiTvK/uDtf0Bzy5cQJxUxzZ9qLk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oOOouuTn7KgVn53O5WaXcChePo7wvLoovtIEs/PbmG/wo7//uuXyF2ENsM50wlx6GSpkzzuPDzmazRWP0+BCu/TQgnhsyab670VdsuNJ+BLW462IteMgpLqL/pSrGa0TrrF6TbCrHsHAlWTjpiOGHxrJE3hx7HLP9vcBMidkPZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LwozF28F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LwozF28F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A85D41F00A3E;
	Fri,  3 Jul 2026 08:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783066354;
	bh=EXMWnnUoSMkI86B8lnY2OGRit9DTwZuoo0WyvRouZdM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LwozF28Fvof4YU4qMT1fDvVwJGxz94oU/zV0v0grXUTYVbj6NSUQIFROJNZtUFJPV
	 ZRSyvp3Q9lmSr6X0zgaAet7hsmjPaccTnfnJnxael7Y7es3LN9v1bt+evBq+Up8vJx
	 UTv7mel+F55//iID0XsKnRv3F3mNcxneCqxe+C0tHzleVFISsR2IbcDIAjgxw7EBwB
	 0wUPgw9KM0RJUUvkGJLgMv/yGaz5mkaW5Uq+Pz4zE3JmVG7n+ueH0Mk5QNRFCQad8V
	 KSCTJuXc9mUzw+/XSQgdYNLDzAOuT9/EswtwayJzxraVQGVn3nPD8wW4TTKBgS2GT3
	 PuByC5NbNFLPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] HID: Intel-thc-hid: Intel-thc: Add API to reset
 read DMA
Reply-To: sashiko-reviews@lists.linux.dev
To: "Even Xu" <even.xu@intel.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260703075858.2780398-2-even.xu@intel.com>
References: <20260703075858.2780398-1-even.xu@intel.com>
 <20260703075858.2780398-2-even.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 08:12:34 +0000
Message-Id: <20260703081234.A85D41F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] thc_rxdma_reset() fails to re-initialize the RxDMA PRD tables, lea=
ding to hardware reading shrunken buffer sizes on restart.
- [High] thc_rxdma_reset() unsafely clears PRD base addresses for all DMA c=
hannels while TX or SW DMA engines may still be running.
- [Medium] thc_rxdma_reset() ignores the return value of thc_interrupt_quie=
sce(dev, false) on the success path.

Pre-existing issues:
- [High] Incorrect polling condition and execution order in thc_interrupt_q=
uiesce during unquiesce (int_quiesce =3D false).
--

commit b0beafd1bc7a02f7a2277c5a6d69c17c58724f01
Author: Even Xu <even.xu@intel.com>

HID: Intel-thc-hid: Intel-thc: Add API to reset read DMA

Add a helper function thc_rxdma_reset() to do read DMA reset, it can be
called when fatal DMA error happens.

> diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c b/driver=
s/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
> index 6ee675e0a7384..7ceb8aeeccd37 100644
> --- a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
> +++ b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
> @@ -561,6 +561,57 @@ static int thc_wait_for_dma_pause(struct thc_device =
*dev, enum thc_dma_channel c
[ ... ]
> +int thc_rxdma_reset(struct thc_device *dev)
> +{
[ ... ]
> +	ret =3D thc_wait_for_dma_pause(dev, THC_RXDMA2);
> +	if (ret) {
> +		dev_err(dev->dev, "Wait for RxDMA2 pause failed during RxDMA reset\n");
> +		goto end;
> +	}
> +
> +	thc_dma_unconfigure(dev);

[Severity: High]
Could this cause memory corruption or IOMMU faults if TX or SW DMA engines
are still running?

thc_rxdma_reset() explicitly pauses RxDMA1 and RxDMA2 but does not pause
TXDMA or SWDMA. It then calls thc_dma_unconfigure(), which loops over all
DMA channels (MAX_THC_DMA_CHANNEL) and blindly overwrites their PRD base
addresses to 0x0.

If TXDMA was left running (for instance, if a prior thc_dma_write() timed
out without clearing the TXDMA start bit), setting its PRD base address to 0
while it is actively fetching could cause the hardware to fetch descriptors
from physical address 0.

> +
> +	ret =3D thc_dma_configure(dev);

[Severity: High]
Does this leave dirty 'len' descriptors in the PRD memory layout?

thc_dma_configure() restarts the DMA engine pointers to 0, but it does not
re-initialize the PRD memory layout. The hardware updates the 'len' field
of PRD entries to indicate the actual length of received packets.

Restarting the DMA from index 0 without restoring 'len' to the maximum
buffer capacity could cause the hardware to use previously received smaller
packet sizes as the maximum capacity for new transfers, resulting in
truncated packets or DMA errors.

> +	if (ret) {
> +		dev_err(dev->dev, "Re-config DMA failed during RxDMA reset\n");
> +		goto end;
> +	}
> +
> +	thc_interrupt_quiesce(dev, false);

[Severity: Medium]
Is it safe to ignore the return value of thc_interrupt_quiesce() here?

Discarding this return value on the success path could silently hide a
hardware timeout or regmap read failure, potentially leaving interrupts
disabled while the function reports success.

[Severity: High]
This is a pre-existing issue, but is the polling condition and execution
order in thc_interrupt_quiesce() correct when unquiescing?

When thc_interrupt_quiesce() is called with int_quiesce =3D false, it polls
the HW_STS bit expecting it to be 1 BEFORE it clears the QUIESCE_EN bit:

drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c:thc_interrupt_quiesce()=
 {
    ...
    ret =3D regmap_read_poll_timeout(dev->thc_regmap, THC_M_PRT_CONTROL_OFF=
SET, ctrl,
                                   ctrl & THC_M_PRT_CONTROL_THC_DEVINT_QUIE=
SCE_HW_STS,
                                   THC_REGMAP_POLLING_INTERVAL_US, THC_QUIE=
SCE_EN_TIMEOUT_US);
    ...
    /* Unquiesce device interrupt - Clear the quiesce bit */
    if (!int_quiesce)
        regmap_write_bits(dev->thc_regmap, THC_M_PRT_CONTROL_OFFSET,
                          THC_M_PRT_CONTROL_THC_DEVINT_QUIESCE_EN, 0);
}

Since the device is already quiesced, HW_STS is already 1, causing the poll
to return immediately. It then clears the QUIESCE_EN bit and returns without
ever waiting for HW_STS to become 0 to acknowledge the unquiesce. This could
cause the driver to proceed before interrupts are actually re-enabled.

> +
> +end:
> +	mutex_unlock(&dev->thc_bus_lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL_NS_GPL(thc_rxdma_reset, "INTEL_THC");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703075858.2780=
398-1-even.xu@intel.com?part=3D1
