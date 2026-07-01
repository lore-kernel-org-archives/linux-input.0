Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC967360EC9
	for <linux-input@vger.kernel.org>; Wed,  1 Jul 2026 02:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782872371; cv=none; b=LhHmqsiKf3cSs/3KYrahE7YEsCpNe1W3wFBLjNh5mz+aGOkw3Zn4QfgaIMfJr0K/9PauAJILO5uY+9CTS269FhO2em6Qyu8dNPHfcqI8u5e0reXl9uXoAra1B7BAQtm81uU8IlucfAJABqvc5jxZAUYBDhc2E/NH8Wpr4hGhctA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782872371; c=relaxed/simple;
	bh=7O4vA/DHGi4uHUBohqoE0ot5sNzQHyF8wq6/UV3KzD8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rEj2VnyM3r8bdujyzFhfSpOPuQIjDHbdEWJ8NavTU+iT5ja4a7GKJhvVymZB1BlBwx1S+TzGPPwBBINJYoGVC6Cf1NDla8tNggKbnpIZandOL56JwL7jn9ujEPueagc7uIqILP8USxu/cdYDc9byTKaDODZI7Nodsvjx5hsvgYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hn9lmdGQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hn9lmdGQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 441681F000E9;
	Wed,  1 Jul 2026 02:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782872369;
	bh=LFua3a20thz3qCwg/ENc9w5vJSFq1NMLu74o2cdBemg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hn9lmdGQ2Nd0iVPfP0zYau/5E7sBO3mW5soXWXBfWP1mQkPY+A6m1s6cm49YuWris
	 8Pl9MW0rW5p+rwxMnECLKBkn3kVqwmo8lrVGVD/DRx8Vpf1TdUgvyVXbQmFXc73pnF
	 ZZIUUbyEkf5Qt315yb7r1iKNtkz71X4s/6W8+CRq8qAt5ikWNi/qBSHfONzErS7iB3
	 eHt1KRK7epgbYvmvRY6ekrphGJlKZs3XXVBXzagv63ruoZr3lYWB53U1PvqZs+VPtR
	 TYhOwFu+YyTOy6RH2mSKLa+tkq7Hn/j/c4uXPZTWVUZaqVGxaH9GZ2iOaLuTTzJ7XL
	 rpT7jlsNm96Ig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] HID: Intel-thc-hid: Intel-thc: Add API to reset
 read DMA
Reply-To: sashiko-reviews@lists.linux.dev
To: "Even Xu" <even.xu@intel.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260701020432.3774514-2-even.xu@intel.com>
References: <20260701020432.3774514-1-even.xu@intel.com>
 <20260701020432.3774514-2-even.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 02:19:28 +0000
Message-Id: <20260701021929.441681F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Using dev_err_once() hides subsequent failures during fatal erro=
r recovery.

Pre-existing issues:
- [High] Zeroing the Physical Region Descriptor (PRD) base addresses before=
 pausing the DMA engines can cause IOMMU faults or memory corruption.
--

commit fb285a619300634b9f208053996047e32855d49b
Author: Even Xu <even.xu@intel.com>
Date:   Wed Jul 1 02:04:30 2026 +0000

HID: Intel-thc-hid: Intel-thc: Add API to reset read DMA

Add a helper function thc_rxdam_reset() to do read DMA reset, it can be
called when fatal DMA error happens.

> diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c b/driver=
s/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
> index 6ee675e0a7384..d771c85dff28b 100644
> --- a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
> +++ b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c

[ ... ]

> @@ -532,6 +532,43 @@ void thc_dma_unconfigure(struct thc_device *dev)
>  }
>  EXPORT_SYMBOL_NS_GPL(thc_dma_unconfigure, "INTEL_THC");
> =20
> +/**
> + * thc_rxdma_reset - Reset all read DMA engines
> + *
> + * @dev: The pointer of THC private device context
> + *
> + * This is a helper function to reset RxDMA configure. It's typically us=
ed
> + * for RxDMA recovery when fatal error happens.
> + */
> +int thc_rxdma_reset(struct thc_device *dev)
> +{
> +	int ret;
> +
> +	if (mutex_lock_interruptible(&dev->thc_bus_lock))
> +		return -EINTR;
> +
> +	ret =3D thc_interrupt_quiesce(dev, true);
> +	if (ret) {
> +		dev_err_once(dev->dev, "Quiesce interrupt failed during RxDMA reset\n"=
);

[Severity: Medium]
Since thc_rxdma_reset() is called as part of a recurring fatal error
recovery flow, will dev_err_once() hide subsequent failures?

If a device successfully recovers the first time but encounters an
unrecoverable failure during a subsequent fatal error later in its uptime,
the failure will be silently ignored because dev_err_once() only prints
once per boot.

Should dev_err_ratelimited() or dev_err() be used instead?

> +		goto end;
> +	}
> +
> +	thc_dma_unconfigure(dev);

[Severity: High]
This is a pre-existing issue, but does calling thc_dma_unconfigure()
here risk IOMMU faults or memory corruption?

When thc_rxdma_reset() invokes thc_dma_unconfigure() during fatal error
recovery, the hardware DMA engine might still be actively fetching or in
an unpredictable state.=20

Looking at thc_dma_unconfigure(), it zeroes out the PRD base addresses
before clearing the DMA START bits:

thc_dma_unconfigure() {
    for (chan =3D 0; chan < MAX_THC_DMA_CHANNEL; chan++) {
        dma_set_prd_base_addr(dev, 0, &dev->dma_ctx->dma_config[chan]);
        ...
    }
    regmap_write_bits(dev->thc_regmap, THC_M_PRT_READ_DMA_CNTRL_1_OFFSET,
                      THC_M_PRT_READ_DMA_CNTRL_START, 0);
}

If the hardware DMA engine is active and continues fetching descriptors
before the START bit is cleared, will it attempt to fetch from physical
address 0x0?

Should it wait for the ACTIVE status to clear (e.g., using
thc_wait_for_dma_pause()) before clearing the base addresses?

> +
> +	ret =3D thc_dma_configure(dev);
> +	if (ret) {
> +		dev_err_once(dev->dev, "Re-config DMA failed during RxDMA reset\n");
> +		goto end;
> +	}
> +
> +	thc_interrupt_quiesce(dev, false);
> +
> +end:
> +	mutex_unlock(&dev->thc_bus_lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL_NS_GPL(thc_rxdma_reset, "INTEL_THC");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701020432.3774=
514-1-even.xu@intel.com?part=3D1
