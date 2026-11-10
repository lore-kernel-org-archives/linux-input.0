Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794287214;
	b=IxnlSYpo7DabVBO5rJ8PYLQ+bT4GYnHZwIBjODRuczuzQLwb/pGh8rVRmGxRLg5siakb
	 HKrIz3CYc4Yqns8KOl0LAFdf3R2y4SBgIraLJgLeCSM9Jm/EPBbWNflh01vh79Hce/gqO
	 V1mSXLMrZi45guPxxW5hyo38mc6T3Ci7lv4b2VjAo0Al+ZssyPZq0aV64F917JCpQtEmV
	 AXY/9BBlsUQ06EjgFb9bZ72b0xqLjeDzS8YQcPFbM7CZYhem2BKe+5+4SWTG7bBMzygUg
	 O4YKUIHyLZSFh1wnf9ca0H2VKLkIzcbE3z25eEMkTKqkOeAs2gGPWasgO4VSILSdY7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794287214;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tUt+HWVux+gZPHG3KzGKmlAZSFClq01XOf9Y/FH+404=;
	b=B9ltUvgh07ZgnarsE+/c/CpYviPyiIDZZ0n4soI6VN/u1GAHDbPkHKCfEx7wLOdgvYby
	 0pD8OykARTMQKJjWAfcdQEiIS/VFXNPWR1XYBMM+4UQXuLLLaF/Y/IRFmr7IIqZ3N/AbW
	 qIbBJrDkGm8FruYnFHvxK3NMbyEW0kf3vTObM1BYjxupP1NNglXa+3xCijc31oT4YQn0m
	 N5BWgEdPQpnXHfV0ZvpELc63iKmTD/aLY4f/OhuQ2cuLRcpImERZQ7iRr3pZU1A11ZPaN
	 MWnwfU3j30PZ3KZi5c3mmSIJN+OpShm/IIX8CWHrGulfqV/EGxtnlXMnn8DUy2EQzJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LwxGKFNM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59763606A325
	for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 05:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LwxGKFNM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C68341F008A1;
	Tue, 10 Nov 2026 05:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794287214;
	bh=tUt+HWVux+gZPHG3KzGKmlAZSFClq01XOf9Y/FH+404=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LwxGKFNMxg6w6tuzL7dOEhrNMZPBS6FhfGaI4jc2bcw0C+xYLu1jZSpv9avQDfY8c
	 OGTUJRQFBn+qSpc3rS43mkq9sQaFl1hCayJbqRWUjNIRerdJ3FBa4kQcn0yX/wlbUU
	 8wZWKbDB+1/7D71fnlvBSLL4MorVmLcjj96U0TU9senjyGjS2ft5ZhjTOo91nWFooQ
	 X2D432a4VWXSgCMKaU49x/oErWg/K664q9YcqtlvEhjITB4Xo+2KDaJybzKsAXNnOY
	 aaS/f46E+pzjyZu5QjkLMI/k5Ad0d3yP7kOK9A6Wu2HFhqjkzAGnyey/BsU0k3cz8e
	 WlM8etXWTOiEw==
Message-ID: <sashiko-outbox-206258@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] HID: intel-thc-hid: quicki2c: quiesce IRQs
 during teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Myeonghun Pak" <mhun512@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261109-thc-rebase-v2-2-mhun512@gmail.com>
References: <20261109-thc-rebase-v2-0-mhun512@gmail.com>
 <20261109-thc-rebase-v2-2-mhun512@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 05:06:53 +0000
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

commit 91b9650f43556a025a9bb311fa9a30624bcb700a
Author: Myeonghun Pak <mhun512@gmail.com>

HID: intel-thc-hid: quicki2c: quiesce IRQs during teardown

This commit disables and frees the device IRQ, cancels recovery work, and
quiesces THC interrupts during probe error unwind, removal, and shutdown.

> diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c b/dr=
ivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> index 29319b6227f3f..a3e98e0faff83 100644
> --- a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> +++ b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c

[ ... ]

> @@ -788,9 +798,12 @@ static void quicki2c_remove(struct pci_dev *pdev)
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
Does disabling and freeing pdev->irq and calling quicki2c_dev_deinit()
before quicki2c_hid_remove() break synchronous HID report transfers issued
while unregistering qcdev->hid_dev?

While hid_destroy_device() runs, bound HID drivers and open hidraw clients
still invoke quicki2c_hid_raw_request() or quicki2c_hid_output_report().
For example, when an input device is open during removal, hid-multitouch
calls hid_hw_close() -> mt_on_hid_hw_close() -> mt_set_modes(), which sends
HID_REQ_SET_REPORT and HID_REQ_GET_REPORT via thc_dma_write() and
thc_swdma_read().

Because pdev->irq is already disabled and freed and THC interrupts are
masked, wait_event_interruptible_timeout() on dev->write_complete_wait and
dev->swdma_complete_wait can never be woken, stalling each transfer for 1
second until it fails with -ETIMEDOUT.

On timeout, thc_swdma_read() also skips thc_swdma_read_completion(), and
thc_dma_unconfigure() only clears THC_M_PRT_READ_DMA_CNTRL_START on
THC_RXDMA1 and THC_RXDMA2, leaving THC_SWDMA or THC_TXDMA started when
thc_dma_release() unmaps and frees the DMA buffers:

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

Conversely, if an in-flight hidraw GET_REPORT receives its THC_SWDMA_INT
wake-up just before disable_irq(), thc_swdma_read_completion() runs without
serialization against quicki2c_dev_deinit() and restarts THC_RXDMA2 and
unquiesces device interrupts after quicki2c_dev_deinit() has completed.

Calling quicki2c_hid_remove() before disabling the IRQ and running
quicki2c_dev_deinit() avoids starting or completing HID transfers after the
interrupt and hardware have been torn down.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-thc-rebase=
-v2-0-mhun512@gmail.com?part=3D2
