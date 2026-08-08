Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F7B2EDD58
	for <linux-input@vger.kernel.org>; Sat,  8 Aug 2026 15:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786203445; cv=none; b=PiDzpmOnuMOYaF2hsqdnNVGqPoLf1PGyBfijm434TVVkLCPT8oNhXpPdwv4fRpj+YtfPeL6Ui2dslZxidnBbJa46j10WE1fR7JYQ1AqVEiQMpgqu/624c0QsRztY2NU2EkOaLqJerKfrfrVvOMoGQJ6G+S6IQYSauOzrICi9Md0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786203445; c=relaxed/simple;
	bh=Mrpunl7OPxtQXRpGIXLqvK0B9XExWxQlTo3WVe3kD5I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A58911nqxYjnWPeZv/5+JFxD4ynpksTHZ9wIKEsksUI4FKhYp68T4K4YpQPmiN0wY3lNzy6ZjaISOxX5vtGdaZwW+9YCVnZeVVcI5cw+FbAONAihHF/Zru5wBOhtOaXe+7vQ50SluKdrYoHjhKBRhqD7HktxhDQ36/d5iT3tSdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUBmhMVm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUBmhMVm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACA011F00A3A;
	Sat,  8 Aug 2026 15:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786203443;
	bh=8AnAhkO9U4+kUNUzm/RNKjt/WAKuUrPh6e4N745rueU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JUBmhMVmxPQBmRAM3xgYzvxtr+0U0m0Ta4oVXn4UDV6jcRrBuvs6lfLeVZi7Ro6gp
	 wYHVF/NzcKWK5aoYUG/5MGqQC3xoLBN46RAvgfCKeNxwPqbA9kpcWMfc/FJ/cR6B9X
	 y//Ek9ttzw996bwrEAzMTjqCyTazitFMYzY4C7iVqjjR6+rYN0UJPtDzZxJ8eTn1fl
	 RHmPrxT20dpXCxcGcGlT0WjE/IWbzcSDFu0aaumUt/5DQr7TAYbPtmPQ9y75bkZWeD
	 TOShVChGWi5PcqXsUJNg7UjvvoIUswsW3PUZooGQ1/cqGzJD0wN8nFs8UdzDB+v/LP
	 SL54fhiVLWSag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: intel-thc-hid: intel-quickspi: fix autosuspend
 cleanup during teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guangshuo Li" <lgs201920130244@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260808151736.2934050-1-lgs201920130244@gmail.com>
References: <20260808151736.2934050-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 15:37:23 +0000
Message-Id: <20260808153723.ACA011F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The hard IRQ handler accesses MMIO hardware registers without veri=
fying that the device is in an active PM state, risking PCIe errors on spur=
ious interrupts.
- [High] The `quickspi_remove` function destroys the HID device and release=
s DMA resources before disabling the device interrupts and synchronizing th=
e IRQ handler, leading to a Use-After-Free race condition.
--

--- Patch [1]: [PATCH] HID: intel-thc-hid: intel-quickspi: fix autosuspend =
cleanup during teardown ---
commit c65b63d920ef0da607b2572a6bd252126299f2eb
Author: Guangshuo Li <lgs201920130244@gmail.com>

HID: intel-thc-hid: intel-quickspi: fix autosuspend cleanup during teardown

This commit fixes a runtime PM reference leak during driver removal. It add=
s a
missing call to pm_runtime_dont_use_autosuspend() in quickspi_remove() to
balance the initialization done during probe.

> diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c b/dr=
ivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> index 4ae2e1718b30c..3c87519aca84a 100644
> --- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> +++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> @@ -713,6 +713,7 @@ static void quickspi_remove(struct pci_dev *pdev)
>  	quickspi_hid_remove(qsdev);
>  	quickspi_dma_deinit(qsdev);
> =20
> +	pm_runtime_dont_use_autosuspend(qsdev->dev);
>  	pm_runtime_get_noresume(qsdev->dev);
> =20
>  	quickspi_dev_deinit(qsdev);

[Severity: High]
This isn't a bug introduced by this patch, but does this teardown sequence
create a use-after-free race condition?

During driver removal, quickspi_remove() calls quickspi_dma_deinit() to free
DMA buffers before disabling hardware interrupts in quickspi_dev_deinit().

Because the IRQ was requested with devm_request_threaded_irq(), it remains
active and is not synchronized or freed until after quickspi_remove() retur=
ns.

If an interrupt fires during this window, could the concurrently running
quickspi_irq_thread_handler() invoke thc_rxdma_read() and read from the
already freed DMA memory?


While reviewing this file, I noticed another pre-existing issue in the
interrupt handling code:

drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c:quickspi_irq_quick_=
handler() {
    ...
	/* Disable THC interrupt before current interrupt be handled */
	thc_interrupt_enable(qsdev->thc_hw, false);
    ...
}

[Severity: High]
This is a pre-existing issue, but does the hard IRQ handler access MMIO
hardware registers without verifying that the device is in an active PM sta=
te?

If a spurious or shared interrupt occurs while the device is in the PCI D3h=
ot
(runtime suspended) state, the handler calls thc_interrupt_enable() which
accesses MMIO directly without a pm_runtime_get_if_active() check.

Could this read and write powered-down MMIO registers and generate an
Unsupported Request (UR) on the PCIe bus?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808151736.2934=
050-1-lgs201920130244@gmail.com?part=3D1
