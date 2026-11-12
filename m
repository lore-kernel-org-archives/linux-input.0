Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794466259;
	b=fjirCnz7OyE6AMkfEdjeRVIKft9u9NmlDnoSSfCDjiDJKEMFznC5HwKpzYFfE+I19HzY
	 UdPSAjzXdX9mrWvoxWFkHMih5iKyCTBJe8/TJYW062/W0wCgkgIBJQLvddaECEniFoIOj
	 rm9Qwt93cb4eHUrEDKHTwEdQ4puw6bJTFGOG68IWMsfzxWtAwukpaaJEJ1Aw4sTSZuD8R
	 2RdpJStmBsVFUSGetX575cO7Z2A+xyncSHVxHpTA6o2U/tI4G0il9t6del9ahM9hGk8oY
	 oZYTsYANYoc+IAP08b8fY0sOBLTy9W8PaK6xqloB0MbTorhyYWQle3/EgRSH82f4GYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794466259;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TiMBNE0SdEanqDa46Z2oEWmTBYwnlOmuj9xGhawnj1M=;
	b=MDbJo4SbV67iyvfQBlmJMZZ0eN6lq7YOSon85D12tfD/GUtu5BqNxu5Tdnn5BO4fYs9z
	 Ux6d719z6PxqpVKA7p1n4Mznu0S4OIraaIhwRaA/SEOTd7JYOD9pJgNX7blQjH3Qyo/2l
	 TjpSgRsP4BGJM6t0cAtB4d+3s0XRlOHl8lOZe3ovMJ+RlqEN514rIh/zxTqaQZHkIf8gf
	 pPCq1baK+1+NMuV4APO33NhC7flgxNDbcMug/YAa0Rj1WtgnydsrFlMmQdI8IojALRT1w
	 nQ5ixayMYeEQrmLO0WTifHkxRftnoyYckEgB4QIxLdIPit/MSuTZszHXoQ81A5CTzIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PzG+wAJC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961A5606A8A9
	for <linux-input@vger.kernel.org>; Thu, 12 Nov 2026 06:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PzG+wAJC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D931F00A05;
	Thu, 12 Nov 2026 06:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794466259;
	bh=TiMBNE0SdEanqDa46Z2oEWmTBYwnlOmuj9xGhawnj1M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PzG+wAJCAEQTpmrEJU/3fnzkxt3E6ytgfCqFYgzQY5b/Hk8j95bUOitQRIZUMSxTo
	 lXgcblMlcrhZZc4/TvBmIOzvOuE7MGwXyzPv1n3gEHRP9ss6633DzFYsSkHg6hXCTE
	 ks1gGQJ2scABAA5de07BYijjrUM0ffkKa1LKcMZ5FGE7e53lNYveVmTrYn3kJv3ppZ
	 8ElkK7+y3ZZKGHJF/3ouR3WK8J4IIXjuQb+lQedjpCxewhoLBhcqMHjWY18+mYBg5m
	 D2Okeq0WA8Zx1bXAJdaI1VKF57d08xMiS43xxxmlC+cCA/L69E4sSsu1HKNNTDoPAu
	 3wssN+bs3gNCg==
Message-ID: <sashiko-outbox-210539@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] HID: intel-thc-hid: quickspi: quiesce IRQs
 during teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Myeonghun Pak" <mhun512@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261112T063704Z-thc-v3-1-mhun512@gmail.com>
References: <20261112T063704Z-thc-v3-0-mhun512@gmail.com>
 <20261112T063704Z-thc-v3-1-mhun512@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 06:50:58 +0000
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
- [Medium] HID: intel-thc-hid: quickspi: broken HID teardown in
  quickspi_remove()
--

commit c5d058390d4d45710eca02a89498e5e65474bafb
Author: Myeonghun Pak <mhun512@gmail.com>

HID: intel-thc-hid: quickspi: quiesce IRQs during teardown

This commit disables and frees the device IRQ and drains recovery work
during probe failure, driver removal, and shutdown before releasing HID
and DMA resources.

> diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c b/dr=
ivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> index bf49d8ce5f07b..3aa0ae81053e8 100644
> --- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> +++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c

[ ... ]

> @@ -721,9 +735,12 @@ static void quickspi_remove(struct pci_dev *pdev)
>  	if (!qsdev)
>  		return;
> =20
> -	quickspi_hid_remove(qsdev);
> -
> +	WRITE_ONCE(qsdev->recovery_disabled, true);
> +	disable_irq(pdev->irq);
>  	quickspi_dev_deinit(qsdev);
> +	devm_free_irq(&pdev->dev, pdev->irq, qsdev);
> +
> +	quickspi_hid_remove(qsdev);
> =20
>  	quickspi_dma_deinit(qsdev);

[Severity: Medium]
Does moving disable_irq(), quickspi_dev_deinit(), and devm_free_irq()
ahead of quickspi_hid_remove() break HID teardown?

When a hid-multitouch input device is open during unbind,
quickspi_hid_remove() -> hid_destroy_device() -> ... -> hid_hw_close() ->
mt_on_hid_hw_close() -> mt_set_modes() synchronously calls
quickspi_hid_raw_request() -> quickspi_set_report() ->
write_cmd_to_txdma() -> thc_dma_write(). Because quickspi_hid_raw_request()
does not check qsdev->state and THC_TXDMA remains enabled until
quickspi_dma_deinit(), thc_dma_write() starts hardware TxDMA and blocks in
wait_event_interruptible_timeout(dev->write_complete_wait, ...) waiting
for a THC_TXDMA_INT completion interrupt that can no longer arrive. When
thc_dma_write() times out or is interrupted by a signal,
quickspi_dma_deinit() then unmaps and frees the TxDMA scatterlist and PRD
table without clearing THC_M_PRT_WRITE_DMA_CNTRL_THC_WRDMA_START.

Calling quickspi_hid_remove() before disabling the IRQ and deinitializing
the controller would avoid starting new transfers after interrupts are
disabled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112T063704Z-th=
c-v3-0-mhun512@gmail.com?part=3D1
