Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7890C39524D
	for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 05:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785302015; cv=none; b=ojreqSAW/H2Eq3evt2OApEIhsuviGAivdIeGJ3SbNuil8q8HFP3qLIjcBVFd9XVTSV11lFOUZat/XjgMrj9vQQH3y3JQRAcSmWf9lK34ozmhgi6XgUBD74GAT1xqG/ar6+CMI0zrAqYaO026lIG/0Zdmq0+K6nuvt1jODW5tpHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785302015; c=relaxed/simple;
	bh=IeItcribYZBiE3M+fVbn0YNuZnQfC33wPjYHfQJdSNE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dQVxROfuE5rJS4WxSn8Fb/HgPTNSVoc69J1xB1jAeAdAkg01D9iIAVfZmf5q17v67WC6gpeG4sHkNyD9GN8Is4fvcSZ8WFOmBxI7SLDvveiIihSFf9cBDkTUer1PJfOrilfXWELYp3J2PMnk9rfWdlSuRyIvt99vmXzy2JN/8rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPJHSPOK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPJHSPOK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 581D81F000E9;
	Wed, 29 Jul 2026 05:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785302011;
	bh=CH33MiReCql9fLVZ8riLMY6QvD1ptc08WsPeDODlWW0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RPJHSPOKfEMfGaznAQLFEnI2AjcCKaCqHlxcZH8l3IWHwe6oK6Uw4qg5NcGlC0MgZ
	 cGszX6fnT0UfTpqoha5izdUlUvI5BuPzOgkj3A7X5dhq2MTn/2wK1w9/KLcNFqmQNc
	 q11KoHP/btIuIbe4dDMrKTjWvEcasWqHapzmDlMacBA7H8o+wHa6uxZE0sCD1H7/br
	 1Uq/0rUHsarRfsiTFcaR+Ekq5E7pnmuWJ+sO0MAiDidB016M0pROqyN7oWUn1YxeE0
	 YX67nzHUUzGPt3GSlf1Skk/tWSu193bG3Hp32NUSCdj7UjzyJRh+MNLnceI3BGCv7+
	 mAYxKKoki23xA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/3] HID: Intel-thc-hid: Intel-thc: Add API to reset
 read DMA
Reply-To: sashiko-reviews@lists.linux.dev
To: "Even Xu" <even.xu@intel.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260729050145.2272597-2-even.xu@intel.com>
References: <20260729050145.2272597-1-even.xu@intel.com>
 <20260729050145.2272597-2-even.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 05:13:30 +0000
Message-Id: <20260729051331.581D81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [Critical] thc_rxdma_reset() destructively unconfigures all DMA channels =
(including TX and SW) without pausing them first, risking severe memory cor=
ruption if they were left active by a previous timeout.
- [High] Error paths in thc_rxdma_reset() bypass the interrupt unquiesce op=
eration, leaving device interrupts permanently disabled.
- [High] The PRD (Physical Region Descriptor) tables are not re-initialized=
 before restarting the RxDMA engines, leading to immediate buffer overruns =
upon hardware restart.
- [Medium] The return value of thc_interrupt_quiesce(dev, false) is ignored=
, potentially masking a failure that leaves the device permanently incapabl=
e of generating interrupts.

Pre-existing issues:
- [High] thc_dma_write() overwrites its timeout error code, falsely returni=
ng success to callers.
- [High] thc_swdma_read() leaks interrupt quiesced state and leaves hardwar=
e wedged on error paths.
--

--- Patch [1]: [PATCH v5 1/3] HID: Intel-thc-hid: Intel-thc: Add API to res=
et read DMA ---
commit c2eb7694465cfedd737d39cb05604d90ef90d739
Author: Even Xu <even.xu@intel.com>
Subject: HID: Intel-thc-hid: Intel-thc: Add API to reset read DMA

This commit adds a helper function thc_rxdma_reset() to perform a read DMA
reset, which can be called when a fatal DMA error happens.

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
> +	int ret;
> +
> +	if (mutex_lock_interruptible(&dev->thc_bus_lock))
> +		return -EINTR;
> +
> +	ret =3D thc_interrupt_quiesce(dev, true);
> +	if (ret) {
> +		dev_err(dev->dev, "Quiesce interrupt failed during RxDMA reset\n");
> +		goto end;
> +	}
> +
> +	ret =3D thc_wait_for_dma_pause(dev, THC_RXDMA1);
> +	if (ret) {
> +		dev_err(dev->dev, "Wait for RxDMA1 pause failed during RxDMA reset\n");
> +		goto end;

[Severity: High]
Does this error path bypass the interrupt unquiesce operation?

If wait_for_dma_pause fails, execution jumps directly to the 'end' label.
The 'end' label simply unlocks the mutex and returns, entirely skipping the
thc_interrupt_quiesce(dev, false) cleanup step.

Could this leave the hardware in an inconsistent state where device
interrupts are permanently disabled and the device cannot be recovered?

> +	}
> +
> +	ret =3D thc_wait_for_dma_pause(dev, THC_RXDMA2);
> +	if (ret) {
> +		dev_err(dev->dev, "Wait for RxDMA2 pause failed during RxDMA reset\n");
> +		goto end;
> +	}
> +
> +	thc_dma_unconfigure(dev);

[Severity: Critical]
Is it safe to call thc_dma_unconfigure() here while TX and SW DMA engines
might still be active?

If a synchronous operation like thc_dma_write() or thc_swdma_read() times o=
ut,
it releases thc_bus_lock while leaving its respective hardware DMA engine
active (START bit =3D 1). If thc_rxdma_reset() is subsequently called to
recover the device, it invokes thc_dma_unconfigure().

thc_dma_unconfigure() loops over all four DMA channels and sets their
Physical Region Descriptor (PRD) base addresses to 0, but it does not clear
the START bits for TXDMA and SWDMA:

void thc_dma_unconfigure(struct thc_device *dev)
{
	int chan;

	for (chan =3D 0; chan < MAX_THC_DMA_CHANNEL; chan++) {
		dma_set_prd_base_addr(dev, 0, &dev->dma_ctx->dma_config[chan]);
		dma_clear_prd_control(dev, &dev->dma_ctx->dma_config[chan]);
	}

	regmap_write_bits(dev->thc_regmap, THC_M_PRT_READ_DMA_CNTRL_1_OFFSET,
			  THC_M_PRT_READ_DMA_CNTRL_START, 0);

	regmap_write_bits(dev->thc_regmap, THC_M_PRT_READ_DMA_CNTRL_2_OFFSET,
			  THC_M_PRT_READ_DMA_CNTRL_START, 0);
}

By zeroing out the PRD base address for a still-running DMA engine, could
this direct the hardware to fetch descriptors or write data to physical
address 0, leading to severe memory corruption or IOMMU faults?

> +
> +	ret =3D thc_dma_configure(dev);

[Severity: High]
Are the PRD tables correctly re-initialized in memory before restarting the
RxDMA engines?

The hardware modifies PRD table entries (e.g., updating length fields) upon
receiving data. Under normal operation, the driver restores these original
sizes in thc_dma_read() using thc_copy_one_sgl_to_prd().

When a fatal error occurs and thc_rxdma_reset() is called, the hardware
read and write pointers are abruptly reset to 0 via thc_dma_configure().
However, if the in-memory PRD tables are not re-initialized, could the
hardware fetch PRD index 0 containing a reduced length and stale flags from
a past partial transaction?

Would this cause the hardware to assume a smaller buffer capacity, triggeri=
ng
a Buffer Overrun or PRD Entry Error upon the next DMA write?

> +	if (ret) {
> +		dev_err(dev->dev, "Re-config DMA failed during RxDMA reset\n");
> +		goto end;
> +	}
> +
> +	thc_interrupt_quiesce(dev, false);

[Severity: Medium]
Should the return value of thc_interrupt_quiesce() be checked and propagate=
d?

This function polls the hardware and can return -ETIMEDOUT if the hardware
state is lost or unresponsive. By discarding this return value and instead
returning the 0 (success) from the prior thc_dma_configure() step, could the
caller falsely assume recovery was successful while the device remains
incapable of generating interrupts?

> +
> +end:
> +	mutex_unlock(&dev->thc_bus_lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL_NS_GPL(thc_rxdma_reset, "INTEL_THC");

[Severity: High]
This isn't a bug introduced by this patch, but does thc_dma_write()
overwrite its timeout error code on failure paths?

Looking at thc_dma_write() in the same file:

	ret =3D wait_event_interruptible_timeout(dev->write_complete_wait,
					       dev->write_done, 1 * HZ);
	if (ret <=3D 0 || !dev->write_done) {
		dev_err_once(dev->dev, "timeout for waiting TxDMA completion\n");
		ret =3D -ETIMEDOUT;
		goto end;
	}
	...
end:
	mutex_unlock(&dev->thc_bus_lock);

	if (restore_interrupts)
		ret =3D thc_interrupt_quiesce(dev, false);

	return ret;

If wait_event_interruptible_timeout() times out, ret is set to -ETIMEDOUT.
However, since unquiescing typically succeeds and returns 0, the original
-ETIMEDOUT error is overwritten by 0.

Could this falsely return success to callers when the DMA write actually
timed out, leading to data loss and state desynchronization?

[Severity: High]
This isn't a bug introduced by this patch, but do the error paths in
thc_swdma_read() leak the interrupt quiesced state?

Looking at thc_swdma_read() in the same file:

	ret =3D thc_swdma_read_start(dev, write_buff, write_len, prd_tbl_len);
	if (ret)
		goto end;

	ret =3D wait_event_interruptible_timeout(dev->swdma_complete_wait,
					       dev->swdma_done, 1 * HZ);
	if (ret <=3D 0 || !dev->swdma_done) {
		dev_err_once(dev->dev, "timeout for waiting SWDMA completion\n");
		ret =3D -ETIMEDOUT;
		goto end;
	}

	ret =3D thc_dma_read(dev, &dev->dma_ctx->dma_config[THC_SWDMA],
			   read_buff, read_len, NULL);
	if (ret)
		goto end;

	ret =3D thc_swdma_read_completion(dev);

end:
	mutex_unlock(&dev->thc_bus_lock);
	return ret;

If the software DMA read times out or if thc_dma_read() fails, execution
jumps to the 'end' label, bypassing thc_swdma_read_completion().

Since thc_swdma_read_start() previously quiesced interrupts and stopped
RXDMA2, could bypassing the completion routine cause the device to
permanently leak its interrupt quiesced state? Would this leave the SWDMA
engine active and prevent THC_RXDMA2 from being restarted?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729050145.2272=
597-1-even.xu@intel.com?part=3D1
