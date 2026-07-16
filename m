Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E763347FC8
	for <linux-input@vger.kernel.org>; Thu, 16 Jul 2026 08:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784190791; cv=none; b=HRQlZQmcSIcq9FhRkPArNUsbcmpibuTrPlGl7JgvEtriCFgAe8Ye13WJG+LMJMgfr1YNY8ZBfdcMcukITYnfCD5mQHdLLWAtva1+VRLSb4dOFW5+xZDRkPh+gU0nVA9QfHLsIypPiP4L+2/oj3NJZ77yMnwbZG8vSXnQiXg0OWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784190791; c=relaxed/simple;
	bh=ATNjUMcNDjKDfU9+R9aX9FCKQ+nqFDIMiRFU9VUy4xo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UIEgPDD+UzPbTgwEx4ExpKDdNVIIE9kTiQ2oJtFGRhGzgoy8EPwsq3xYR2n3pvHE2qEHbqtqquY5vIOKH4mz4wdEzy8MH8faUzLau++nMSAc45VtsS169WUruol68xsIwvtd2CSk5rxpIPRGm1GuGl94q9ZA1s7NPrEe/IhEaYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ofszt5Qu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ofszt5Qu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C461F000E9;
	Thu, 16 Jul 2026 08:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784190790;
	bh=GRyS8kE7OyQ0eCwGAsUCYN5TJ7ED9JzwMO6/u/Nuxeo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ofszt5QuKlR/nPJhbmN/03GoWqs6WY28j3CUCB4Vb4BF4ot+8DIDDPUHG0cpeDKzq
	 sslQxvTvBdkTKlKJp71jJq0xzCtG5C4+f3/aXZUget3xwltO+m4YbBFlspkXRp2WIv
	 XwyZoPQwppzhhgUAtElx/571uXD6bh/yD1ZRAhpqL0064lV+9vw0tkXrpi+E816mzb
	 aWG+n3z0SDgWFk7FIKhGSn7zFp+k+2O4VLYvZRuZ4R+/GRU8fh5xXtbTQqjNmh+5SY
	 +e+y3bimHFJwwhrl8fTC3D4vCTpeRjpL34Ff5tJcIfNSIe6h7yJZIYbd4McesDzmvj
	 5GY6R14kBsA/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] HID: Intel-thc-hid: Remove redundant dev_err()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pan Chuang" <panchuang@vivo.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260716075203.593012-5-panchuang@vivo.com>
References: <20260716075203.593012-1-panchuang@vivo.com>
 <20260716075203.593012-5-panchuang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 08:33:09 +0000
Message-Id: <20260716083310.47C461F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Device removal manually frees non-devm DMA scatterlist buffers=
 before disabling hardware interrupts and the threaded IRQ handler, leading=
 to a Use-After-Free.
- [High] The primary interrupt handlers unconditionally return `IRQ_HANDLED=
` when the device is in the `DISABLED` state, without checking the hardware=
 interrupt source or clearing the interrupt condition.
--

--- Patch [4]: [PATCH v2 4/4] HID: Intel-thc-hid: Remove redundant dev_err(=
) ---
commit d99357f50f34b4097b4c3b9ec6cfab0677cc831e
Author: Pan Chuang <panchuang@vivo.com>
Subject: HID: Intel-thc-hid: Remove redundant dev_err()

This commit removes redundant driver-specific dev_err calls following
devm_request_threaded_irq failures, as detailed error messages are already
logged by the core subsystem on failure.

> diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c b/dr=
ivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> index 46d3e9a019995..59f500345acbf 100644
> --- a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> +++ b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> @@ -682,11 +682,8 @@ static int quicki2c_probe(struct pci_dev *pdev, cons=
t struct pci_device_id *id)
>  					quicki2c_irq_thread_handler,
>  					IRQF_ONESHOT, KBUILD_MODNAME,
>  					qcdev);

[Severity: High]
This is a pre-existing issue, but while we are touching the threaded IRQ
setup, does quicki2c_irq_quick_handler() properly handle shared INTx
interrupts?

drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c:quicki2c_irq_quick_=
handler() {
    ...
    if (qcdev->state =3D=3D QUICKI2C_DISABLED)
        return IRQ_HANDLED;
    ...
}

The device initializes with PCI_IRQ_ALL_TYPES, allowing fallback to INTx.
If an interrupt fires when the device state is QUICKI2C_DISABLED, the
handler unconditionally returns IRQ_HANDLED without clearing the hardware
condition. Could this prevent the generic IRQ subsystem from detecting and
disabling spurious interrupts, resulting in an interrupt storm?

[Severity: Critical]
This is a pre-existing issue, but does relying on a devm-managed IRQ here
cause a use-after-free regression during driver unbind?

During driver unbind, quicki2c_remove() explicitly frees non-devm DMA
scatterlist buffers before the devm framework tears down this IRQ:

drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c:quicki2c_remove() {
    ...
    quicki2c_dma_deinit(qcdev);
    pm_runtime_get_noresume(qcdev->dev);
    quicki2c_dev_deinit(qcdev);
    ...
}

Because devres cleans up the IRQ only after remove() returns, and hardware
interrupts are disabled later in quicki2c_dev_deinit(), the IRQ can still
fire after quicki2c_dma_deinit() unmaps and frees the scatterlist arrays.

If a concurrent hardware interrupt fires, the unlocked read_dma_buffer()
might access the freed scatterlists:

drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c:read_dma_buffer() {
    ...
    sg =3D read_config->sgls[prd_table_index];
    ret =3D sg_copy_to_buffer(sg, nent, read_buff, mes_len);
    ...
}

Can this lead to memory corruption if the handler executes on freed memory?

> -	if (ret) {
> -		dev_err_once(&pdev->dev,
> -			     "Failed to request threaded IRQ, irq =3D %d.\n", pdev->irq);
> +	if (ret)
>  		goto dev_deinit;
> -	}

[ ... ]

> diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c b/dr=
ivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> index 4ae2e1718b30c..504ef3c842ab6 100644
> --- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> +++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> @@ -636,11 +636,8 @@ static int quickspi_probe(struct pci_dev *pdev,
>  					quickspi_irq_thread_handler,
>  					IRQF_ONESHOT, KBUILD_MODNAME,
>  					qsdev);

[Severity: High]
This isn't a bug introduced by this patch, but does the same regression
regarding shared INTx interrupts exist in quickspi_irq_quick_handler()?

drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c:quickspi_irq_quick_=
handler() {
    ...
    if (qsdev->state =3D=3D QUICKSPI_DISABLED)
        return IRQ_HANDLED;
    ...
}

Returning IRQ_HANDLED without clearing the hardware condition might cause
an interrupt storm if the IRQ line is shared.

[Severity: Critical]
This is a pre-existing issue, but does the same use-after-free pattern
exist here during QuickSPI device removal?

drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c:quickspi_remove() {
    ...
    quickspi_dma_deinit(qsdev);
    pm_runtime_get_noresume(qsdev->dev);
    quickspi_dev_deinit(qsdev);
    ...
}

The devm-managed IRQ will remain active after quickspi_dma_deinit() frees
the scatterlists. Could a concurrent interrupt corrupt memory?

> -	if (ret) {
> -		dev_err(&pdev->dev,
> -			"Failed to request threaded IRQ, irq =3D %d.\n", pdev->irq);
> +	if (ret)
>  		goto dev_deinit;
> -	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716075203.5930=
12-1-panchuang@vivo.com?part=3D4
