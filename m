Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AAD3ACA7A
	for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 08:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784537993; cv=none; b=PEO3BcPSs5I29EReSwEH0/BM/8XFQ8nO/uMh8gH/l+mQqH/7ryzcJkst1DQLPvydipnJMP+k2/VLU51gAqn8nSF7owcnWXPmvXnscIW/fkrgVxDHul8m7fBv6vXM+x6mtITOCO17EUE4pr4Wz+1MuAyyDt+cL/997ABNHpdQxWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784537993; c=relaxed/simple;
	bh=E5Gh8sP/092yabA5jk21moSTAUiH+IrBMcUdAUgyaGQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iG4y+z5iQN0fqk3ndpe686Ppxy/CTqfDJk/TLVGpUsus/l1z9eRMXAYD2BNPrNN6EBdEBU0aFHp/5yhADiIrmzTbwXwOWKPuNGwCQUyDS7fKjXIUXtFTHQg3nRgHBEU42wBY/wrEpp/dcM1337q4Hq/zx6RD0MVzOgqgEt/wmhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElLkmxLh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElLkmxLh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1DEF1F000E9;
	Mon, 20 Jul 2026 08:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784537992;
	bh=6LYEvl+/P43zSgzxSLO6AX2Oz+T2xeIIWFU9Cgc0d1A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ElLkmxLhzVNiycekccu7m75lbQV9Z//vQiEzxXHj535VnyA1tEiLre0/jIqPNvmOi
	 pdO1xAhgyRI+5mTFMwmLYSRVySaUx+V1sILMn+bKmZP5h7InsRPx+fsLYdnBOWYQ2p
	 MDQkyPGRmbuBHR6kFHNvHfJL9BkbRbZ7jcOfYMhfBnolrcB28uJqrKwrSJm1Ct65ns
	 1DB6n6q+h5F+oos7/mvVbwc6c3OaVXLOkO3k+9tiv30hfRTObqzsgfzBLZ5aThZl1Z
	 SwUubdFCVxdhYlqVAEE+IZy8PgQIqgwEWT4TDWIajo2j8DmiwGt//TjFKeityLr8bf
	 4ZTS4t10YZNIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] HID: Intel-thc-hid: Remove redundant dev_err()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pan Chuang" <panchuang@vivo.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260720084310.210976-5-panchuang@vivo.com>
References: <20260720084310.210976-1-panchuang@vivo.com>
 <20260720084310.210976-5-panchuang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 08:59:51 +0000
Message-Id: <20260720085951.E1DEF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Requesting the IRQ before allocating report buffers and initia=
lizing DMA causes an infinite interrupt storm that hangs the CPU.
- [High] Bypassing `quicki2c_dma_deinit()` on the error path causes a memor=
y leak of non-managed DMA buffers and mappings.
--

--- Patch [4]: [PATCH v3 4/4] HID: Intel-thc-hid: Remove redundant dev_err(=
) ---
commit 7eb5c91c4d9eb3ab7af0dabaab924561ec278776
Author: Pan Chuang <panchuang@vivo.com>

HID: Intel-thc-hid: Remove redundant dev_err()

This patch removes redundant driver-specific dev_err() calls after
devm_request_threaded_irq(). The core genirq/devres code automatically
logs detailed error messages on failure now.

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
> -	if (ret) {
> -		dev_err_once(&pdev->dev,
> -			     "Failed to request threaded IRQ, irq =3D %d.\n", pdev->irq);
> +	if (ret)
>  		goto dev_deinit;
> -	}

[Severity: Critical]
This is a pre-existing issue, but does requesting the IRQ here before alloc=
ating
report buffers and initializing DMA cause an interrupt loop?

If a pending or spurious interrupt occurs right after devm_request_threaded=
_irq()
is called but before quicki2c_alloc_report_buf() and quicki2c_dma_init(), t=
he
RT-priority threaded handler could execute.

The handler would find input_buf is NULL and fail to read the DMA buffer. A=
ny
attempt to recover would fail because dma_init() hasn't run. The handler wo=
uld
then unmask the interrupt. Because the hardware interrupt condition was nev=
er
cleared, it could immediately fire again, preempting the probe thread and
hanging the CPU.

> =20
>  	ret =3D quicki2c_get_device_descriptor(qcdev);
>  	if (ret) {

[Severity: High]
This isn't a bug introduced by this patch, but could the error handling fur=
ther
down in this function leak unmanaged DMA memory?

After quicki2c_dma_init() successfully allocates DMA buffers, subsequent
failures in thc_interrupt_quiesce(), quicki2c_set_power(), or
quicki2c_reset() jump to the dev_deinit label:

	ret =3D quicki2c_set_power(qcdev, HIDI2C_ON);
	if (ret) {
		dev_err(&pdev->dev, "Set Power On command failed, ret=3D %d\n", ret);
		goto dev_deinit;
	}

Jumping to dev_deinit bypasses the dma_deinit label and quicki2c_dma_deinit=
(),
which leaves the DMA resources allocated.

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
> -	if (ret) {
> -		dev_err(&pdev->dev,
> -			"Failed to request threaded IRQ, irq =3D %d.\n", pdev->irq);
> +	if (ret)
>  		goto dev_deinit;
> -	}

[Severity: Critical]
This is a pre-existing issue, but might requesting the IRQ here before allo=
cating
report buffers and initializing DMA lead to a similar interrupt loop?

Just like in quicki2c_probe(), if an interrupt fires right after
devm_request_threaded_irq() is called but before quickspi_alloc_report_buf()
and quickspi_dma_init(), the handler could fail to recover DMA state. It wo=
uld
then unmask the interrupt, which immediately fires again, hanging the CPU in
an RT-priority interrupt loop.

> =20
>  	ret =3D reset_tic(qsdev);
>  	if (ret) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720084310.2109=
76-1-panchuang@vivo.com?part=3D4
