Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794287505;
	b=ziejlh5BFXheGjpPLciCSvXIW20Bmjw91LboyeRyiKa3gNGyEJbuI4YBJ4zqsbxcPmWG
	 B2Y3VH3F3LSgirFMAVhVZ4hDb7nNe3SR3e4zKri17ivPzfrOfspYY2FyAj6YuVRDcwmtb
	 Ra4P3LQPN/fILPUpUDg5LOSJEzJNtehthzy9qMSaVCgvWvZfB/aFUK5DhZE+KdYJTPaYK
	 dHzbMZ1y6Zb7rjDobMowO7IEwrkTQqm99ZhSO+mxNIG7hg5+z3ugcw3qyk9gtFRFsVaps
	 x+3VRVoAtlBrOu8LVvOQsgSGQz+64fjqMmr+G62vtx+lPkATEU8KGn7qP1TJJ2j/cBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794287505;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6OFrbBHBxIVPOYUrR23H2976j8z4XMEES6X4irA2Xno=;
	b=UF5407ycretcGnr7aUrKx436HoSKtgfZSb5R+/45E8lL8nDsVhAzfWt23dgGftBFLm27
	 JwrSsxEONlGloZBKkcVXSC+1UpelGMJyl8kZ57+piUMNRrCBVfqocIX0idPVoW2eEqFr2
	 fS2A9MnPC/nGlgokO2ELPsRaxz92nxBd135/nEcB+VKK9Aa6+Fbgik84aEANnM/RRI9ga
	 8uDcKrCXL/Oynhp85Nr8TNiEu5DhtcG9yh/X2m7uLBz29G26q/0JF1yJzJAMMF6SYSojP
	 CeaMfMesJszzwu3wGbD2sLu8CnBALKQe9zrP2jS4hyxiGKKkoyCz1XD4qGKD9XqkYzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HgY13Lbp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D23D606A32E
	for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 05:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HgY13Lbp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0307D1F0089F;
	Tue, 10 Nov 2026 05:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794287505;
	bh=6OFrbBHBxIVPOYUrR23H2976j8z4XMEES6X4irA2Xno=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HgY13LbpbBGHtUjjiWvIace03LGSONeYtHlbuN1S4Ac93DByQuomQQNKCmKRwsvIH
	 twprjoltDtgCPmV3TjAXCGdXhvmDLGG8owE574iog/8qtMbjfZcj3yrcMscfHavllX
	 q/fagjgSs+nv5Nmypto9sAlRLY7lbclCO97S5PLw24dFM6lx/TdWy/+2A14PWXztK7
	 KwesY6SoyjE+vCy64b+tPYMiteBH2dq2DU8HPSyyTIZBlP+4wvHO0aMQ+uNOK6+moq
	 hJ3L0ZL6Azjiy0nFOyinWDKK7PiL6WgbLmhW6a4yqffbnroF/W0FalKPfvHjnPYc1Q
	 sOpBQI2IYHpig==
Message-ID: <sashiko-outbox-206266@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] HID: intel-thc-hid: quickspi: quiesce IRQs
 during teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Myeonghun Pak" <mhun512@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261109-thc-rebase-v2-1-mhun512@gmail.com>
References: <20261109-thc-rebase-v2-0-mhun512@gmail.com>
 <20261109-thc-rebase-v2-1-mhun512@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 05:11:44 +0000
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

commit fefc2e678efd20341c68b06e3be50ff1570c6a3b
Author: Myeonghun Pak <mhun512@gmail.com>

HID: intel-thc-hid: quickspi: quiesce IRQs during teardown

This commit disables and frees the device IRQ and stops recovery work
before tearing down HID and DMA resources during probe error unwind,
driver removal, and shutdown.

> diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c b/dr=
ivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> index bf49d8ce5f07b..acb4d2716ea74 100644
> --- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> +++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c

[ ... ]

> @@ -721,9 +731,12 @@ static void quickspi_remove(struct pci_dev *pdev)
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
Does moving quickspi_hid_remove() after disable_irq(),
quickspi_dev_deinit(), and devm_free_irq() break synchronous HID requests
issued during hid_destroy_device()?

When a hid-multitouch input device is open during unbind,
hid_destroy_device() closes it synchronously via mt_on_hid_hw_close() ->
mt_set_modes(), which calls quickspi_hid_raw_request() ->
quickspi_set_report() -> write_cmd_to_txdma() -> thc_dma_write(). Because
neither quickspi_hid_raw_request() nor thc_dma_write() checks qsdev->state
and THC_TXDMA remains enabled until quickspi_dma_deinit(), thc_dma_write()
starts hardware TxDMA and stalls until timeout waiting for a THC_TXDMA_INT
completion interrupt that can no longer fire.

In addition, when thc_dma_write() times out or is interrupted by a signal,
its error path calls thc_interrupt_quiesce(dev, false) if dev->perf_limit
is set (re-enabling external touch interrupts after quickspi_dev_deinit()),
and quickspi_dma_deinit() then unmaps and frees the TxDMA scatterlist and
PRD table while hardware TxDMA may still be active.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-thc-rebase=
-v2-0-mhun512@gmail.com?part=3D1
