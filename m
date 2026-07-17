Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993B232A3C9
	for <linux-input@vger.kernel.org>; Fri, 17 Jul 2026 04:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784261323; cv=none; b=kmGE5BHgwmi/LHQUUJM6cY5IIe3VTGtt04Kx3Ax3gkJ4HC9o07kfT9LzymyG7BjsJi8cd8g74ay7Cb41UWb4Ty5WfWhSdCenoaOr6GxmMUf2r1VXh/XUBzEhMruIMRUQgf6eRES+8hc0p+CoUgOU3ntsjefb0y5aoXRvsJ9/cH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784261323; c=relaxed/simple;
	bh=iSE9og50eDHs8ynfI2qbi6GCrQ+3Am6KZeMQh/IVSk4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WpIBNfiurw3MOZDtcf747Rq6apRtBRTQuoxj27HcwI5LVGUsWf7NQejIVP+T6G26Pmzm1NNYYOeajHO/U0MtahGr/1QyDUHrMA9ZX/72MHTm7aIln8v+4ZyCkVK5gbUfemTAXcC+2U9FUmEvcUJ5dskTYeQridfu2Q3izhByjyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BIS/txAC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BIS/txAC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAAFA1F000E9;
	Fri, 17 Jul 2026 04:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784261322;
	bh=bq/uLgJvXmkir/lrwaHmKhuC32h+DpjH1snlLf7Ny/E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BIS/txACwLvsJvsssL7CnNe67+h02OqZvJER5PRhJZJ+OI2PsWzbtIToM5cWOk2Xv
	 jXhlEDkPMd/xMunwRdhL2Ht24KxxdYi1hx/7GAQSHqcuTqYFgBAwZJnX3+i3a6lj3r
	 qt5Zj+ec10qAf+G1QT+B3575hQT0Qypbt6HN00xbqDIP7PFL3jQtDj+tTvYPEA8EaL
	 W2kspNONx4P0kX+9uI9z/HaePZnLTpBMADaqUK8J8yS8MIySq0jQ93PZ1IBIXLQ6t7
	 rfxIH/5McoG57jhnbAZTsQhY41xKPIWWoGMc1uifnY+7+vjA2ti4MXX1199UHow43A
	 vL4UslmwsozqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/3] HID: Intel-thc-hid: Intel-thc: Add API to reset
 read DMA
Reply-To: sashiko-reviews@lists.linux.dev
To: "Even Xu" <even.xu@intel.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260717035609.3874015-2-even.xu@intel.com>
References: <20260717035609.3874015-1-even.xu@intel.com>
 <20260717035609.3874015-2-even.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 04:08:41 +0000
Message-Id: <20260717040841.EAAFA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] `thc_rxdma_reset()` aborts the reset sequence if pausing THC_RXD=
MA1 fails, leaving THC_RXDMA2 running.

Pre-existing issues:
- [High] thc_dma_unconfigure() zeroes PRD base addresses before DMA engines=
 are stopped, risking IOMMU faults.
--

--- Patch [1]: [PATCH v4 1/3] HID: Intel-thc-hid: Intel-thc: Add API to res=
et read DMA ---
commit b0b099ba1dc08199ebeeb23013c7c472a6f2c1bb
Author: Even Xu <even.xu@intel.com>

HID: Intel-thc-hid: Intel-thc: Add API to reset read DMA

This commit adds a helper function thc_rxdma_reset() to perform a read DMA
reset. It is intended to be called for recovery when a fatal DMA error
happens.

> diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c b/driver=
s/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
> index 6ee675e0a7384..7ceb8aeeccd37 100644
> --- a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
> +++ b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c

[ ... ]

> @@ -561,6 +561,57 @@ static int thc_wait_for_dma_pause(struct thc_device =
*dev, enum thc_dma_channel c
>  	return 0;
>  }
> =20
> +/**
> + * thc_rxdma_reset - Reset all read DMA engines

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
> +	}
> +

[Severity: Medium]
If pausing THC_RXDMA1 fails and times out, does jumping to the end label
leave THC_RXDMA2 running?=20

Bailing out here without attempting to stop the second RX DMA engine might
leave the hardware in an inconsistent state during a fatal error recovery.

> +	ret =3D thc_wait_for_dma_pause(dev, THC_RXDMA2);
> +	if (ret) {
> +		dev_err(dev->dev, "Wait for RxDMA2 pause failed during RxDMA reset\n");
> +		goto end;
> +	}
> +
> +	thc_dma_unconfigure(dev);
> +

[Severity: High]
This isn't a bug introduced by this patch, but does calling
thc_dma_unconfigure() here without first pausing TXDMA or SWDMA risk IOMMU
faults?

Looking at thc_dma_unconfigure(), it zeroes the PRD base addresses for all
channels before clearing the START bits:

void thc_dma_unconfigure(struct thc_device *dev)
{
	int chan;

	for (chan =3D 0; chan < MAX_THC_DMA_CHANNEL; chan++) {
		dma_set_prd_base_addr(dev, 0, &dev->dma_ctx->dma_config[chan]);
...

If a previous thc_dma_write() timed out, its TXDMA engine might still be
active since the timeout handler does not pause it.

Zeroing the PRD base address of an active DMA engine could force the
hardware to fetch descriptors at physical address 0, which would cause an
immediate memory corruption or IOMMU panic.

> +	ret =3D thc_dma_configure(dev);
> +	if (ret) {
> +		dev_err(dev->dev, "Re-config DMA failed during RxDMA reset\n");
> +		goto end;
> +	}
> +
> +	thc_interrupt_quiesce(dev, false);
> +
> +end:
> +	mutex_unlock(&dev->thc_bus_lock);
> +	return ret;
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717035609.3874=
015-1-even.xu@intel.com?part=3D1
