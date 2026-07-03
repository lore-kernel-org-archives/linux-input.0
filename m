Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA88C368D4A
	for <linux-input@vger.kernel.org>; Fri,  3 Jul 2026 08:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783066126; cv=none; b=AkEFtGKXNH51fgSNeRX++IwOzt970A8iu5XBc+8WW0wLG59+x6t5uYv/aGKMNFl0lwMAhTH+r+x+yi//u2dP5Vw3ftTKr4VYXVvQI3hhbeJmtP9qVH05wPaoNJW7oCGYOt11TBn2i2kQfWyc+BRpt+OauW8b/sqJcuXKmnX0VEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783066126; c=relaxed/simple;
	bh=TLT++00mn7HTL5OpIPTgp6PxOUiMRyhmSnPoP/C81gQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k87Bw5iNrvX8Bye7CPtKVq6tC5qfz2yLl7O+wEl45URIbCeLW7z+Hii/aQV5mktyFHNZA5aUzfC1UGvP9FHksUUnuc7t2u3v5tGMl8iR+qKFNc3vgbL9hbvuAcpxpPj2tZewJMtFMGB0nmwJQt5a2RG/bW49ogUD/QBEOtxoXz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0F+MniQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0F+MniQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54CF21F000E9;
	Fri,  3 Jul 2026 08:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783066124;
	bh=SeuDRJPpeAwI4v2MpHAfYsdj8jgB+hYEVTved95W0V4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R0F+MniQ9MFqmfI3MR/btsFO0mrhpliDmqoA86b9ardz+ySnkI748ADH+/o87iULp
	 jWw66j9iiE8WXIYFsKbnCyERUW8Gx9uFBSdMOPCu5qJ1gbK/D9Id7kEn6c3McL6AoR
	 DFkPk533j2w8AdL6/VrYkCfJLF/IPNUbgL1Nhs5QR4b7NDTT7oo36Q4/fHMQ+l1bcl
	 8mmW9owC980M98+3/4MJ6o7JuzuNNZb2pMH1I2GsT8EGPNtHBDCzLzUdSUM0ZnUgS/
	 jrIgLfMxKTWyAXTqHuw84uGEl7/ic4oEsozSn2gIm/4UBRhpQiYz9yNCYX/twaqaNj
	 10LAGgGh2EO+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] HID: Intel-thc-hid: Intel-quickspi: Refine
 recover callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Even Xu" <even.xu@intel.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260703075858.2780398-4-even.xu@intel.com>
References: <20260703075858.2780398-1-even.xu@intel.com>
 <20260703075858.2780398-4-even.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 08:08:43 +0000
Message-Id: <20260703080844.54CF21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] `cancel_work_sync()` is called before interrupts are safely disabl=
ed during device teardown, and is missing entirely from the probe error pat=
h, allowing the work item to execute after the device structure is freed.
- [High] Non-fatal or spurious interrupts occurring during async recovery w=
ill prematurely re-enable hardware interrupts, racing with the DMA reset an=
d potentially causing DMA corruption.
--

commit f745eb96a11ec6734e09736d8674beb349a74ab9
Author: Even Xu <even.xu@intel.com>

HID: Intel-thc-hid: Intel-quickspi: Refine recover callback

This commit shifts the QuickSPI recover flow from the IRQ handler to a
workqueue. It relies on thc_rxdma_reset() for recovery and keeps interrupts
disabled during the process.

> diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c b/dr=
ivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> --- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> +++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
[ ... ]
> @@ -337,11 +331,10 @@ static irqreturn_t quickspi_irq_thread_handler(int =
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

[Severity: High]
If try_recover() disables device interrupts and is actively resetting DMA
engines, could a spurious or non-fatal interrupt cause
quickspi_irq_thread_handler() to evaluate err_recover =3D=3D 0 and uncondit=
ionally
re-enable hardware interrupts here?

If so, a subsequent real interrupt could race with the ongoing DMA reset
since thc_rxdma_read() does not appear to hold thc_bus_lock.

> =20
>  	pm_runtime_put_autosuspend(qsdev->dev);
> =20
[ ... ]
> @@ -710,6 +704,8 @@ static void quickspi_remove(struct pci_dev *pdev)
>  	if (!qsdev)
>  		return;
> =20
> +	cancel_work_sync(&qsdev->recover_work);
> +

[Severity: High]
Since quickspi_dev_deinit() disables hardware interrupts later in this func=
tion,
is there a race window here?

If a fatal error interrupt occurs after cancel_work_sync() but before
hardware interrupts are disabled, the IRQ thread handler could schedule
recover_work again. The qsdev structure would then be freed, leaving a
pending work item that dereferences freed memory.

Also, should cancel_work_sync() be called in the error paths of
quickspi_probe() after the work item is initialized and interrupts are
enabled?

>  	quickspi_hid_remove(qsdev);
>  	quickspi_dma_deinit(qsdev);
> =20
[ ... ]
> @@ -737,6 +733,8 @@ static void quickspi_shutdown(struct pci_dev *pdev)
>  	if (!qsdev)
>  		return;
> =20
> +	cancel_work_sync(&qsdev->recover_work);
> +

[Severity: High]
Could this have the same race window as quickspi_remove(), where a fatal
error interrupt might reschedule recover_work before quickspi_dev_deinit()
disables interrupts?

>  	/* Must stop DMA before reboot to avoid DMA entering into unknown state=
 */
>  	quickspi_dma_deinit(qsdev);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703075858.2780=
398-1-even.xu@intel.com?part=3D3
