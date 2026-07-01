Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6502191
	for <linux-input@vger.kernel.org>; Wed,  1 Jul 2026 02:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782872204; cv=none; b=DbYF1InPh3ByewdmG8IwhG5Cby77ekqP6IdChoB4oqRys5mZjHrx3Mj+zMD4Scz2wg9Adk+tqesHBYcUehYoBarC/jAW0CGTYnVPIUYPhRnq2qs9m3MZQ6VfaeDxI8AxKyvZ6VOEPh51+hoUq+cPfg2O4fOkLAKDShsp2/vX4P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782872204; c=relaxed/simple;
	bh=N7gtUm23fKGajj9uAkLT84EaotFdJDJjxeRblnc4Dr8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VUkN10iB9lJi1dDecKONg5SGPzVe4tmegJWyC9xQuc6j7xIlP5kIA61/L73yZ/h6PReMyxH7YBKS8xtcP0hDEbSv9kFD20+m3Uae88ed0XjcOuPzY2EU/3nUVs2HzmScTzNhGBeFSQYNxmooPGtVAAzuk9poAKqKHkD483zh4sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGeEBoIS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGeEBoIS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BCF01F000E9;
	Wed,  1 Jul 2026 02:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782872203;
	bh=YYm1jVniu/geLn6M//JisLMxowQUsw9oyrMQwbfgqsY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PGeEBoISzGhYifFTGFm9/ZAMqBgGVDUPl1n/SzBmuvdfdGRwUTEdCX48iSwXGZ6wQ
	 8gR/PlXPFEriRn1EDzKjM1r97HVuGK9Mhoh0xPDOJsHsJQq009cm9/gq/lEXvGv80q
	 o4ljr5VpbADL4OBzKylnf2D8FSo+dJIeNbUR3ZnAZic7jVDxiPHCXktvkoScu86R5m
	 iLjkmlg13j29+gGoqdDfnGtpafDRZnMVqMPzMxCfFBIq5MpRrrBWQrFnmS9UZJ/+0/
	 hc1qCBbBwomy/aTqN2xukH2hdadgUfRWz0EWAXOBhe6TI7FzhQqZy/j26SEgad9U+z
	 1MBFkZFsfZV/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] HID: Intel-thc-hid: Intel-quickspi: Refine recover
 callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Even Xu" <even.xu@intel.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260701020432.3774514-4-even.xu@intel.com>
References: <20260701020432.3774514-1-even.xu@intel.com>
 <20260701020432.3774514-4-even.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 02:16:42 +0000
Message-Id: <20260701021643.4BCF01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Use-after-free of qsdev during device removal due to uncanceled as=
ync work
- [High] Missing runtime PM protection during asynchronous hardware recovery
- [High] Unconditional interrupt unmasking causes severe interrupt storm
- [High] Data race on DMA configuration between IRQ thread and async recove=
ry

Pre-existing issues:
- [High] Invalid runtime PM teardown causes unpowered hardware accesses dur=
ing removal
--

commit b4ff70b4c528a251392ae3368aa0d2f80233ab2e
Author: Even Xu <even.xu@intel.com>
Subject: HID: Intel-thc-hid: Intel-quickspi: Refine recover callback

This commit refines the recovery flow by using a workqueue to handle
recovery instead of processing it in the IRQ handler. It calls
thc_rxdma_reset() to simplify operations and disables interrupts during
the recovery process.

> diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c b/dr=
ivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> index 4ae2e1718b30c..a2428db5f9414 100644
> --- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> +++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> @@ -252,34 +252,23 @@ static irqreturn_t quickspi_irq_quick_handler(int i=
rq, void *dev_id)
[ ... ]
> +static void try_recover(struct work_struct *work)
> +{
> +	struct quickspi_device *qsdev =3D container_of(work, struct quickspi_de=
vice, recover_work);
> +
> +	thc_interrupt_enable(qsdev->thc_hw, false);
> +

[Severity: High]
Does this asynchronously scheduled work need to acquire its own runtime PM
reference?

The IRQ thread drops its PM reference with pm_runtime_put_autosuspend()
immediately after scheduling this work. If the autosuspend delay expires
before this workqueue executes, the device may enter a suspended state.

Will calling thc_interrupt_enable() and thc_rxdma_reset() here cause a syst=
em
crash or silent failure by accessing unpowered hardware registers?

> +	if (thc_rxdma_reset(qsdev->thc_hw))

[Severity: High]
Is there a potential data race here with the IRQ thread?

The try_recover() function calls thc_rxdma_reset(), which holds the
thc_bus_lock while unconfiguring and reconfiguring the DMA hardware.
However, if a concurrent interrupt occurs, quickspi_irq_thread_handler()
calls thc_rxdma_read() without holding thc_bus_lock.

Could this allow the IRQ thread to read from DMA rings while they are
actively being torn down and rebuilt by the recovery work on another CPU?

> +		qsdev->state =3D QUICKSPI_DISABLED;
> +	else
> +		thc_interrupt_enable(qsdev->thc_hw, true);
>  }
[ ... ]
> @@ -340,8 +329,7 @@ static irqreturn_t quickspi_irq_thread_handler(int ir=
q, void *dev_id)
>  	thc_interrupt_enable(qsdev->thc_hw, true);
> =20
>  	if (err_recover)
> -		if (try_recover(qsdev))
> -			qsdev->state =3D QUICKSPI_DISABLED;
> +		schedule_work(&qsdev->recover_work);

[Severity: High]
Could this unconditional interrupt unmasking cause an interrupt storm?

When the hardware signals a fatal error, the handler unmasks the interrupt
here before returning, but the hardware reset is deferred to the asynchrono=
us
workqueue.

Since the hardware error condition hasn't been cleared yet, won't the
device immediately re-assert the interrupt and trap the CPU in an endless
hardirq-to-thread loop before the workqueue ever has a chance to execute?

> =20
>  	pm_runtime_put_autosuspend(qsdev->dev);
> =20
> @@ -385,6 +373,7 @@ static struct quickspi_device *quickspi_dev_init(stru=
ct pci_dev *pdev, void __io
>  	init_waitqueue_head(&qsdev->report_desc_got_wq);
>  	init_waitqueue_head(&qsdev->get_report_cmpl_wq);
>  	init_waitqueue_head(&qsdev->set_report_cmpl_wq);
> +	INIT_WORK(&qsdev->recover_work, try_recover);

[Severity: High]
Does this newly added work item need to be explicitly canceled during device
removal?

In the driver removal path in quickspi_remove(), there is no call to
cancel_work_sync().

Since qsdev is allocated with devm_kzalloc(), it will be freed shortly after
quickspi_remove() returns. If a fatal error interrupt schedules this work j=
ust
before or during driver unbind, could the workqueue execute after qsdev is
freed, causing a use-after-free when try_recover() dereferences it?

[Severity: High]
This is a pre-existing issue, but does quickspi_remove() properly wake the
device before accessing its hardware registers?

Currently, quickspi_remove() uses pm_runtime_get_noresume():

quickspi_remove() {
    ...
    pm_runtime_get_noresume(qsdev->dev);
    quickspi_dev_deinit(qsdev);
    ...
}

Calling pm_runtime_get_noresume() only increments the usage counter, it does
not resume the device. If the device was already auto-suspended,
quickspi_dev_deinit() will write to unpowered registers.

Could this lead to dropped writes or a PCIe bus error?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701020432.3774=
514-1-even.xu@intel.com?part=3D3
