Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794466768;
	b=xBlJRpn8qQ1w59Qp8/jp+ow0bgaJGj3piTiygx0g11J3qe3o56rZ8WJNV7kIZmfHBRA4
	 YLo+o/lMYLfKrM9adKWStQTUSmB0pDL0u+Chcmgg3lXTAnsKSn9KCywFKB+bXUBLnZels
	 YXkJWjTffyx2OFH4ghj7vk17DwT2o/9XCH1H7g3Segzrg5y2kft4rHEXx9wlZGKTnzJsP
	 ejlL+DAajURe5PsaWNz3xoSdwnSjznGELmNckGyCNi0aZo4zXcaYwGyUIULCFTHNazsDI
	 8X/EZ4ludIf+QpP+0ZStLr4CllBDZOts6LToJGsl7JryoExGCoLltlIn+ZPE/4GpiFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794466768;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Z1K7y6H1/5Q2fQS86EpV4i90f4o3M7cNOET7d3GpeC4=;
	b=O9A/SpDdIs7h62MVZGZbJInNqO913silRUMmLv6m90krl3PDmHnBaA/gmHf6e/yHEaST
	 B88qLAzm50R+TVUIJ25cB2L/dhSDP08cnjUpGSvyE1V77gadKvuiOVsj5vRrTrLsA2Z/Y
	 uLgSnheY64YCKnUy8Wt26SuyQ2JQhOwfJOFbwr9UjnrxOHiL0sGoaSmB0/JTA6H1VdFwF
	 wkM3lHlyAYnXUv8eHWxaIfjWSAB2nxMn/VA+p4bKUqzvfhO933ay5IjXXtijPc+nGXKG3
	 RqhXWXmgHoNzim2dGN0RTyrvZiAJCun4q4hEy9H9qJsed2QcljFKOViP4V+ldXTJihA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FnWBSKBq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D88606A323
	for <linux-input@vger.kernel.org>; Thu, 12 Nov 2026 06:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FnWBSKBq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23AD21F00A05;
	Thu, 12 Nov 2026 06:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794466767;
	bh=Z1K7y6H1/5Q2fQS86EpV4i90f4o3M7cNOET7d3GpeC4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FnWBSKBq8BUl2tSE1U2KLUUD7FZ/ziMozIGl8AbNhoDvW5L+pOyj14OgdmEXgteB0
	 HfNXP9Y2stVnZ0c3/ibHsGoXPbEB6z99+xMv+gwKbYM2keD9rCOP8XIwZV/gh11Cdw
	 ZLN5OgC10H0+GzCde/uV3qdLJrYN763mjlbveRuF63EKeQG+JzeTbjND21ILse5fGf
	 bx7fCRN/vwULrD7ZmGkm48bvlzYrRzJNf7OgkWuCG2hGutDDu97jsSB38cw9j3z36P
	 +7tqyzGcIj9dZv+YRszc78EFuOkTT/zNh0xFC4OeylrqpE5I5MRD6OqJYhWHT7Nzk3
	 +zbJfgsbBVnmA==
Message-ID: <sashiko-outbox-210560@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] HID: intel-thc-hid: quicki2c: quiesce IRQs
 during teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Myeonghun Pak" <mhun512@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261112T063704Z-thc-v3-2-mhun512@gmail.com>
References: <20261112T063704Z-thc-v3-0-mhun512@gmail.com>
 <20261112T063704Z-thc-v3-2-mhun512@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 06:59:26 +0000
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
- [High] HID: intel-thc-hid: quicki2c: premature IRQ/dev teardown in
  quicki2c_remove()
--

commit cd8b528b30521f872e42d4b36fda65f3e1f39085
Author: Myeonghun Pak <mhun512@gmail.com>

HID: intel-thc-hid: quicki2c: quiesce IRQs during teardown

This commit disables and frees the device interrupt and deinitializes the
controller before tearing down the hid and dma resources during probe
unwind, remove, and shutdown.

> diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c b/dr=
ivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> index 29319b6227f3f..84e458fdd69cc 100644
> --- a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> +++ b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c

[ ... ]

> @@ -788,9 +802,12 @@ static void quicki2c_remove(struct pci_dev *pdev)
>  	if (!qcdev)
>  		return;
> =20
> -	quicki2c_hid_remove(qcdev);
> -
> +	WRITE_ONCE(qcdev->recovery_disabled, true);
> +	disable_irq(pdev->irq);
>  	quicki2c_dev_deinit(qcdev);
> +	devm_free_irq(&pdev->dev, pdev->irq, qcdev);
> +
> +	quicki2c_hid_remove(qcdev);
> =20
>  	quicki2c_dma_deinit(qcdev);

[Severity: High]
Does tearing down pdev->irq and calling quicki2c_dev_deinit() before
quicki2c_hid_remove() break synchronous transfers issued while
hid_destroy_device() disconnects subdrivers and hidraw?

When quicki2c_hid_remove() runs hid_destroy_device(), bound subdrivers such
as hid-multitouch close the device (mt_remove() -> hid_hw_stop() -> ... ->
hid_hw_close() -> mt_on_hid_hw_close() -> mt_set_modes()) and send
synchronous requests through quicki2c_hid_raw_request().  Because
quicki2c_set_report() and quicki2c_get_report() rely on pdev->irq via
thc_dma_write() and thc_swdma_read() to signal completion on
dev->write_complete_wait and dev->swdma_complete_wait, starting those
transfers after pdev->irq is disabled and freed stalls each request for its
1-second wait timeout.

On timeout, thc_swdma_read() skips thc_swdma_read_completion(), leaving the
software dma engine started when quicki2c_dma_deinit() unmaps and frees the
scatterlists and prd tables (as thc_dma_unconfigure() only stops the two
receive dma engines):

drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c:thc_swdma_read() {
    ...
	ret =3D thc_swdma_read_start(dev, write_buff, write_len, prd_tbl_len);
	if (ret)
		goto end;

	ret =3D wait_event_interruptible_timeout(dev->swdma_complete_wait, dev->sw=
dma_done, 1 * HZ);
	if (ret <=3D 0 || !dev->swdma_done) {
		dev_err_once(dev->dev, "timeout for waiting SWDMA completion\n");
		ret =3D -ETIMEDOUT;
		goto end;
	}
    ...
	ret =3D thc_swdma_read_completion(dev);
    ...
}

In addition, if an in-flight hidraw request in thc_swdma_read() receives
its completion interrupt just before disable_irq(),
thc_swdma_read_completion() can run after quicki2c_dev_deinit() while
quicki2c_hid_remove() drains hidraw, restarting the receive dma engine and
unquiescing interrupts right before quicki2c_dma_deinit() frees the dma
buffers.

Keeping quicki2c_hid_remove(qcdev) before disabling pdev->irq and calling
quicki2c_dev_deinit(qcdev) would let hid teardown finish while interrupts
are still active.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112T063704Z-th=
c-v3-0-mhun512@gmail.com?part=3D2
