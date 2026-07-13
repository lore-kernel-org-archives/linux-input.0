Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C953B30648A
	for <linux-input@vger.kernel.org>; Mon, 13 Jul 2026 03:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783912673; cv=none; b=Juctcrw/EV4DXp57x0MM071m630RBUzkF+hQC5gNnsaSjRDRCg2/8OSHLEMpVFDJ1Q2AeV0B8oumoZBzHAiSso5EBk/GVlAUVM4O61qG1tVUJWOV0+eIQLWV55VquXMjYc7OnPmTBCjWMNZhVIoNuG/GW1bDWRowPN5xI1RA14U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783912673; c=relaxed/simple;
	bh=JVlTLXyPrPwzh/396fb/mMR956OzLayBv1LJBgdLr9g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VThvAfv/4xrzezd5iC6vcVXx0LUD7o8z310lDYKrB5qCfxLotgPRKZ+yxsr41uevJpVwbv4XqM5V5nTToPRH8Vzh4lDt9FtLEIrdLrNZ+zpwf00vrif/Q2nlH8k7hgZF1GUTVEIjjOIICY1dBJevHmyq5eSOwL+RthXiT4lGo98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SR/BhsCi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SR/BhsCi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC211F000E9;
	Mon, 13 Jul 2026 03:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783912669;
	bh=Kif7u4yYi3yjPEDQWlWFVP49THzDOxrRzKbxJV8Lf9o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SR/BhsCifNvjUHJSpohGKTron5YryZUlgljLfgTGHtjCXSMfuJz5x87hg0p0wzmPk
	 COSlK/GIGbKym6U67dFZHQ8jW06b3bI3WoazwmX6lPKUDsXPSMJtMBApynq146mf8+
	 U2qqL0aNQ4NpTPVBKBfoC2+etz2PQmPwDWtqL0WONRlqVtlLxaSnP5JZqZ4rMUYQAj
	 EYrkfHhgXeWmybdg9xCvCoLIRwx1jfq92rDNupfubr85zAiRloTpbQ77jrHmu+djC0
	 hzrBVbQbSaXihY16Zr7EmaJonyKh5nkASu64HOwCTNkfIoaHdpCFRTSirHEoIHkDEK
	 H9T2cW5SaWWiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] HID: Intel-thc-hid: Intel-thc: Add API to reset
 read DMA
Reply-To: sashiko-reviews@lists.linux.dev
To: "Even Xu" <even.xu@intel.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260713030412.2531933-2-even.xu@intel.com>
References: <20260713030412.2531933-1-even.xu@intel.com>
 <20260713030412.2531933-2-even.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 03:17:48 +0000
Message-Id: <20260713031749.2DC211F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] `thc_rxdma_reset` improperly clears descriptor addresses for a=
ll DMA channels without pausing them first, potentially causing active TX/S=
W DMA to access physical address 0.
- [High] Error paths in `thc_rxdma_reset` fail to restore the interrupt qui=
esce state, permanently disabling device interrupts.
--

--- Patch [1]: [PATCH v3 1/3] HID: Intel-thc-hid: Intel-thc: Add API to res=
et read DMA ---
commit 64b22c0d882751a67b709351d2c2e3daf211bb52
Author: Even Xu <even.xu@intel.com>

HID: Intel-thc-hid: Intel-thc: Add API to reset read DMA

This commit adds a new helper function thc_rxdma_reset() to perform a read =
DMA
reset. It is intended to be called for RxDMA recovery when fatal DMA errors
occur.

> diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c b/driver=
s/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
> index 6ee675e0a7384..7ceb8aeeccd37 100644
> --- a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
> +++ b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
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
Does this skip unquiescing the interrupts?  If thc_wait_for_dma_pause() fai=
ls,
we jump to the end label and return without calling=20
thc_interrupt_quiesce(dev, false).  Will this leave device interrupts=20
permanently disabled?

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
Can this cause active TX or SW DMA engines to access physical address 0?

thc_rxdma_reset() pauses THC_RXDMA1 and THC_RXDMA2, but thc_dma_unconfigure=
()=20
unconditionally iterates over MAX_THC_DMA_CHANNEL and sets the PRD base
address to 0 for all channels, including THC_TXDMA and THC_SWDMA:

void thc_dma_unconfigure(struct thc_device *dev)
{
	int chan;

	for (chan =3D 0; chan < MAX_THC_DMA_CHANNEL; chan++) {
		dma_set_prd_base_addr(dev, 0, &dev->dma_ctx->dma_config[chan]);
		dma_clear_prd_control(dev, &dev->dma_ctx->dma_config[chan]);
	}
        ...
}

If a previous thc_dma_write() or thc_swdma_read() timed out, it unlocks=20
thc_bus_lock but leaves the TX/SW DMA engine running in hardware. Overwriti=
ng=20
the PRD base address to 0 while the engine is active could result in memory=
=20
corruption or an IOMMU fault.

> +
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

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713030412.2531=
933-1-even.xu@intel.com?part=3D1
