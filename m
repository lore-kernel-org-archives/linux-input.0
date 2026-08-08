Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C5A2F39C7
	for <linux-input@vger.kernel.org>; Sat,  8 Aug 2026 15:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786202099; cv=none; b=dzsIoW5zU0pk5AfVCGCylAnHwnjnEyOTRR6NvZTnCW/upHHnJaHSCSejctPBIUt6lZmYPeHuk2Nzq3ppMxF/8nfEce0fYZT3qxSsmgDDGEWaj1Sg1DkWN2suxGMeZ5V2229/vtfxZV6w5A6lKZtix6Vw6zqhdMbzPHWPXv65c04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786202099; c=relaxed/simple;
	bh=tqoUNkCwmbp3kIkR8wMqDzq/RqmSorgBN634CNsF1aw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=K03ZZg7JLZpwuqAPv9gKFUMxNPNx4bNEpnJNtp5kWL80IKuHnv3XqrGIUye5DLqL3OH0cSFAAB7U/Y7+eQCNZA7NTb+yp7b19QTQ6czpZMxI3daGxgqfSn5m7mITcw+1ZVG5DSME68+xKb312yJO0uqLoIyPBcummMctMvZk3VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=luLkww8C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="luLkww8C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F2881F000E9;
	Sat,  8 Aug 2026 15:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786202097;
	bh=Yca3ksce6KTxV8PzOK/3GTHqWpd9JkjnNnlM7RjKON0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=luLkww8CBYbjFWTVmfbq+h0mh+j06t7wlfBzk0+Xy72/mDHPzo1zOMqfU4rWge1KD
	 GSwR82VbGM5Jqheb0sx86Vthjd60lK2ryjXGc1BKxhVAj2GmEEj3/0E4It9b4ikKA7
	 DsY0U7f7axHCegn095R2WB0Skhhg14rR1KNMXWdEyXljyaFPLjPxOyctmyKiplw6pY
	 iJQoGbebr2EsdibYTSWwl8wddRzeSYqY0TyTdzZyG7cR5tHm2VeZYHvmhZ0tcD82PH
	 v+0jX/QfoMDWh06LyMTqInm86jNz95ivTV0QA4RNAqXTu6RGZsAoqPZB1+ubkRpfNN
	 YzJrZocLZhSzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: intel-thc-hid: intel-quicki2c: fix autosuspend
 cleanup during teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guangshuo Li" <lgs201920130244@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260808145748.2926096-1-lgs201920130244@gmail.com>
References: <20260808145748.2926096-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 15:14:56 +0000
Message-Id: <20260808151457.4F2881F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing bounds check on untrusted DMA data length in `handle_i=
nput_report()` leads to out-of-bounds read and potential crash.
- [High] The driver drops the Runtime PM usage count twice in `quicki2c_pro=
be()`, causing an unbalanced usage count and potential underflow.
- [High] The hard IRQ handler accesses memory-mapped hardware registers wit=
hout verifying the device is in an active power state.
- [High] The device removal routine destroys the HID device and unconfigure=
s DMA before disabling the hardware interrupt, allowing concurrent access t=
o freed structures (Use-After-Free).
--

--- Patch [1]: [PATCH] HID: intel-thc-hid: intel-quicki2c: fix autosuspend =
cleanup during teardown ---
commit 8a35b0594fb992d3e7467b6a60b895077101a1f0
Author: Guangshuo Li <lgs201920130244@gmail.com>

HID: intel-thc-hid: intel-quicki2c: fix autosuspend cleanup during teardown
   =20
quicki2c_probe() calls pm_runtime_use_autosuspend(), but
quicki2c_remove() does not call the matching
pm_runtime_dont_use_autosuspend() during teardown.
   =20
If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
during teardown, this reference is not dropped.

> diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c b/dr=
ivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> index 46d3e9a019995..4126c2408d986 100644
> --- a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> +++ b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> @@ -774,6 +774,7 @@ static void quicki2c_remove(struct pci_dev *pdev)
>  	quicki2c_hid_remove(qcdev);
>  	quicki2c_dma_deinit(qcdev);
> =20
> +	pm_runtime_dont_use_autosuspend(qcdev->dev);
>  	pm_runtime_get_noresume(qcdev->dev);
> =20
>  	quicki2c_dev_deinit(qcdev);

[Severity: High]
This isn't a bug introduced by this patch, but does this teardown sequence
allow a Use-After-Free?

The device removal routine destroys the HID device via quicki2c_hid_remove()
before disabling hardware interrupts in quicki2c_dev_deinit(). If an
interrupt fires in this window, the IRQ thread executes:

quicki2c_irq_thread_handler()
   handle_input_report()
      quicki2c_hid_send_report()

which could access the freed qcdev->hid_dev structure.


drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c:quicki2c_probe() {
    ...
	pm_runtime_use_autosuspend(qcdev->dev);
	pm_runtime_set_autosuspend_delay(qcdev->dev, DEFAULT_AUTO_SUSPEND_DELAY_MS=
);
	pm_runtime_put_noidle(qcdev->dev);
	pm_runtime_put_autosuspend(qcdev->dev);
    ...
}

[Severity: High]
This is a pre-existing issue, but does this code drop the PM usage count
twice?

Calling pm_runtime_put_noidle() followed by pm_runtime_put_autosuspend()
drops the usage count twice when it should only be dropped once to balance
the initial count of 1.

This can cause the usage count to underflow and break runtime PM logic.


drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c:quicki2c_irq_quick_=
handler() {
    ...
	if (qcdev->state =3D=3D QUICKI2C_DISABLED)
		return IRQ_HANDLED;

	/* Disable THC interrupt before current interrupt be handled */
	thc_interrupt_enable(qcdev->thc_hw, false);
    ...
}

[Severity: High]
This isn't a bug introduced by this patch, but does this hard IRQ handler
access memory-mapped registers without verifying the device is in an active
power state?

The PCI core can transition the device to D3hot while an in-flight MSI is
arriving.

When quicki2c_irq_quick_handler() executes in this suspended state, blindly
writing to the MMIO register via thc_interrupt_enable() can cause a PCIe
Master Abort, potentially freezing or crashing the system.


drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c:handle_input_report=
() {
    ...
		/* Discard samples before driver probe complete */
		if (qcdev->state !=3D QUICKI2C_ENABLED)
			continue;

		quicki2c_hid_send_report(qcdev, pkt->data,
					 HIDI2C_DATA_LEN(le16_to_cpu(pkt->len)));
	}

	return 0;
}

[Severity: Critical]
This is a pre-existing issue, but does this code lack a bounds check on the
untrusted DMA data length?

The pkt->len field is read directly from DMA memory originating from the
peripheral.

If a malicious or faulty device supplies a len of 1, the HIDI2C_DATA_LEN()
macro calculates 1 - 2, which underflows.

Passing this value to quicki2c_hid_send_report() causes an out-of-bounds re=
ad
that can leak memory or cause a kernel panic.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808145748.2926=
096-1-lgs201920130244@gmail.com?part=3D1
