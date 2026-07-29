Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440063A59A7
	for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 05:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785302235; cv=none; b=s2k18HvMidSOxrKhodcA4lIN9aUsP1ilRwYHbSqfQKyEghCIQ8oTUQR+RAlf2zac9v7Wl4RZGc00jjNbhXIfZR+69AyuptetdZbVxGQfqDDqtQ6H7DWSFIjVEKuVn7nfzqNgdvj7Ajr6c5H5IQe67lye4pZdY2gt2ypaT8WKsw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785302235; c=relaxed/simple;
	bh=F6CgO4na4C6mzFdrz/UURzLQji9m152eMGe2MzS+AVQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ro1ViYJD5FrCw8JAi7ZUfMtFl/85qeaiF1bCgA4pFapExS2rST/88uzh1eElkjyQNmurgKwIN9VZgmGRStY725tqTT4gW8iA7f/39Cuaq/HF3g/mcFkrVfY8oE3DL7Jxjo63dUac00WBELHwtLQTsHPPYoGoNEjB+jjkJewim0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+ZABOzF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+ZABOzF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A59D01F000E9;
	Wed, 29 Jul 2026 05:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785302233;
	bh=5boJFaz+jPlZ3Q68X1beVfeeDCcVHgASN7Rtklu9viY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E+ZABOzFBTWacPOUwtc8DNMwkv4sQKwZGDtxXrxLBlMMV4tp2pF/WdIe1kJ2gmnUg
	 vY8FDqX7yYZH+gX+09tGickndqRg8IQIGWh7oexCkNBvzPdfLXhRqG+fuDFw6NYqCg
	 3U/BpV/7/fyySZjbG0CQqER2dnHV+8Xv/YnRp5cw2lXwCi5FvMHqM7jsEPpodkgegi
	 SmGDk1DXisRCliRSbPcL4lc7BSDXNG2YSra2cmqzOHH/ZkSsXksvGqzmGrXTilRj2m
	 Hcqvfp1YlxqLOuipQbnN8UpmkeXAtW1diLQ6xRWGxpZ79h6RhUcyGajgbj6lnIf+YI
	 6wWQAUvZEvj8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/3] HID: Intel-thc-hid: Intel-quickspi: Refine
 recover callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Even Xu" <even.xu@intel.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260729050145.2272597-4-even.xu@intel.com>
References: <20260729050145.2272597-1-even.xu@intel.com>
 <20260729050145.2272597-4-even.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 05:17:13 +0000
Message-Id: <20260729051713.A59D01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Race condition during device removal allows the recovery workqueue=
 item to be scheduled after it was cancelled, leading to a Use-After-Free o=
n `qsdev`.

Pre-existing issues:
- [High] The HID device is destroyed before hardware interrupts are disable=
d, creating a race condition where the IRQ handler can dereference a freed =
HID device pointer.
--

--- Patch [3]: [PATCH v5 3/3] HID: Intel-thc-hid: Intel-quickspi: Refine re=
cover callback ---
commit 08604fa17c3b0d7c83e325ba80b11d716e4a7d1a
Author: Even Xu <even.xu@intel.com>

HID: Intel-thc-hid: Intel-quickspi: Refine recover callback

This commit refines the recover flow by using a workqueue to handle
recovery instead of processing it in the irq handler. It also calls
thc_rxdma_reset() to simplify the operation and disables interrupts
during the recovery flow.

> --- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> +++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
[ ... ]
> @@ -337,11 +336,10 @@ static irqreturn_t quickspi_irq_thread_handler(int =
irq, void *dev_id)
>  	}
> =20
>  end:
> -	thc_interrupt_enable(qsdev->thc_hw, true);
> -
>  	if (err_recover)
> -		if (try_recover(qsdev))
> -			qsdev->state =3D QUICKSPI_DISABLED;
> +		schedule_work(&qsdev->recover_work);
> +	else
> +		thc_interrupt_enable(qsdev->thc_hw, true);
> =20
>  	pm_runtime_put_autosuspend(qsdev->dev);
> =20
[ ... ]
> @@ -461,6 +461,10 @@ static struct quickspi_device *quickspi_dev_init(str=
uct pci_dev *pdev, void __io
>   */
>  static void quickspi_dev_deinit(struct quickspi_device *qsdev)
>  {
> +	WRITE_ONCE(qsdev->recovery_disabled, true);
> +	cancel_work_sync(&qsdev->recover_work);
> +
> +	thc_interrupt_quiesce(qsdev->thc_hw, true);
>  	thc_interrupt_enable(qsdev->thc_hw, false);
>  	thc_ltr_unconfig(qsdev->thc_hw);
>  	thc_wot_unconfig(qsdev->thc_hw);

[Severity: High]
Can this sequence cause a use-after-free on qsdev?

Looking at quickspi_dev_deinit(), the recovery work is cancelled before
hardware interrupts are quiesced and disabled. If a hardware error
interrupt occurs immediately after cancel_work_sync() completes, the
IRQ thread will still run.

In quickspi_irq_thread_handler(), the work is unconditionally scheduled
without checking the recovery_disabled flag:

    if (err_recover)
        schedule_work(&qsdev->recover_work);

If this happens during device removal in quickspi_remove(), devres will
subsequently free qsdev, but the workqueue will execute try_recover()
afterwards and dereference the freed memory.

Could we either check the recovery_disabled flag before scheduling,
or disable interrupts before cancelling the work?

> @@ -711,12 +715,13 @@ static void quickspi_remove(struct pci_dev *pdev)
>  		return;
> =20
>  	quickspi_hid_remove(qsdev);
> +
> +	quickspi_dev_deinit(qsdev);
> +
>  	quickspi_dma_deinit(qsdev);
> =20
>  	pm_runtime_get_noresume(qsdev->dev);
> =20
> -	quickspi_dev_deinit(qsdev);
> -
>  	pci_clear_master(pdev);
>  }

[Severity: High]
This is a pre-existing issue, but can this sequence lead to a
use-after-free of the HID device?

In quickspi_remove(), quickspi_hid_remove() is called to destroy the
HID device before quickspi_dev_deinit() disables hardware interrupts.

If a data interrupt fires in the window between these two calls,
quickspi_irq_thread_handler() will process it:

    if (int_mask & BIT(THC_RXDMA2_INT)) {
        ...
        quickspi_handle_input_data(qsdev, input_len);
    }

Since the HID device has already been freed by quickspi_hid_remove(),
attempting to report input data could dereference a freed pointer.

Should we ensure interrupts are disabled before destroying the HID device?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729050145.2272=
597-1-even.xu@intel.com?part=3D3
