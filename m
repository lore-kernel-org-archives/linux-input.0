Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A777C29B228
	for <linux-input@vger.kernel.org>; Mon,  1 Jun 2026 21:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780349515; cv=none; b=GXmfdSorgCQwj8y6EqcFFX7TH4rhiRpBnobSyX+mAyja0pB22I+E/+XACVsusTHtlwS4whxIgCSD5MEIm0eZWbqGfJJLPYq4WyBxrD3Cw9mfak6516BGg8rKS4HFZi2H8WD0s7XKWBLpd8n9v0YcR5i4oTVI6CD8YVyY8W6lB3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780349515; c=relaxed/simple;
	bh=NBJv5oAnl8dqklRRLHl3KdoAh7umMRLfEEyWDf59TlY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uWIEsVyL82gfrsenOExp+E/vdvf86Vgh+XayLoU+4q6iWYl416jXCGQwM220/jzmVUJ7WfXa4T4gLxYwdedgCiMKTaZwiIv3ToQjRX87+hV3F07qvww+QnRVuhrJ0uEo3g5+gBZyHPnV2SZZ+Fcf6t8nDI3olhO+kbIGJyBwTqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TX9xWU6J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TX9xWU6J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37AA01F00893;
	Mon,  1 Jun 2026 21:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780349514;
	bh=nPlQLS6UUNA8sFSVI2Lwh1Rdaj7WADdMdULuT0d6CKI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TX9xWU6JHocoEGKCyl0kBdqoq4EzCqpTR6WrjnSFPxLHcMWSOUjE6DZGQa24Vuo7J
	 qgsIkNvVRouMqY7K+fmbJnFSsa2Oig0L9esejqdBbORjCrmat1IQJZWghdaRKTPwlD
	 h/tvmmpyDqnvvx2vaEbv5hoPkdeys0SXaPGKy1Z1uFsajr4h4k3F2OwjLT7YHFn8vw
	 hTlA22DLNv0RKHbz0VlVLQW1tOiDoot0AMA5OPdDXP6UDV6Sy2jimckLsWdrSHrrwf
	 fNGfZ1mVxQt9fKVdIENfxK5WbtH7YvQ1AZVpRN9XFt7yiBSdiur2OCRfUS6EzzJBTc
	 9IUegCRJIPo5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] HID: intel-thc-hid: intel-quickspi: reset touch IC
 on system resume
Reply-To: sashiko-reviews@lists.linux.dev
To: d3z <d3z.the.dev@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260601211828.112626-1-d3z.the.dev@gmail.com>
References: <20260601211828.112626-1-d3z.the.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 21:31:53 +0000
Message-Id: <20260601213154.37AA01F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Missing cleanup on error paths in `quickspi_resume()` leaves hardw=
are interrupts enabled.

Pre-existing issues:
- [High] Potential Use-After-Free in the IRQ handler during device removal.
- [High] Concurrent execution of hardware initialization (`reset_tic`) betw=
een PM callbacks and the IRQ thread.
--

commit 4380dc624b155997446c58c62fab2b9cced12a58
Author: Danny D <d3z.the.dev@gmail.com>

HID: intel-thc-hid: intel-quickspi: reset touch IC on system resume

This commit updates quickspi_resume() to handle s2idle suspend by restoring
the THC context and resetting the touch IC when the device is not a wake
source. It reconfigures the THC SPI/LTR settings and runs reset_tic() to
re-enumerate the device.

Closes: https://github.com/linux-surface/linux-surface/issues/1799

> diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c b/dr=
ivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> index f669235f18839..4ae2e1718b30c 100644
> --- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> +++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> @@ -784,20 +784,72 @@ static int quickspi_resume(struct device *device)
[ ... ]
> +	thc_interrupt_config(qsdev->thc_hw);
> =20
> +	thc_interrupt_enable(qsdev->thc_hw, true);
> =20
> -	ret =3D thc_dma_configure(qsdev->thc_hw);
> +	/* The touch IC may have lost power, reset it to recover */
> +	ret =3D reset_tic(qsdev);
> +	if (ret)
> +		return ret;

[Severity: High]
If reset_tic() or the subsequent thc_dma_configure() fails, does this
function return without disabling the hardware interrupts?

It appears thc_interrupt_enable() is called before reset_tic(), but
the error paths directly return without undoing the interrupt enable
or quiescing the hardware. Could this leave the device in an active
state capable of generating unhandled interrupts?

[Severity: High]
This is a pre-existing issue, but the patch newly introduces this
pattern into the resume path. Is it safe to call reset_tic() here
while hardware interrupts are actively enabled?

If a fatal error interrupt occurs during the reset window, the
threaded IRQ handler could catch it and invoke try_recover():

drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c:try_recover() {
    ...
    ret =3D reset_tic(qsdev);
    ...
}

Since there doesn't appear to be mutual exclusion protecting the
device state recovery path, could both the PM callback and the IRQ
thread execute acpi_tic_reset() concurrently and corrupt the hardware
state?

> +
> +	ret =3D thc_dma_configure(qsdev->thc_hw);
> +	if (ret)
> +		return ret;

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but does the device
removal process have a use-after-free window in the IRQ handler?

In quickspi_remove(), the DMA buffers are freed before hardware
interrupts are disabled:

drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c:quickspi_remove() {
    ...
    quickspi_dma_deinit(qsdev);

    pm_runtime_get_noresume(qsdev->dev);

    quickspi_dev_deinit(qsdev);
    ...
}

Because the IRQ is managed by devm_request_threaded_irq(), it isn't
freed until after quickspi_remove() returns. If an interrupt fires
during this window, could the threaded handler access freed memory?

drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c:read_dma_buffer() {
    ...
    prd_tbl =3D &read_config->prd_tbls[prd_table_index];
    mes_len =3D calc_message_len(prd_tbl, &nent);
    ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601211828.1126=
26-1-d3z.the.dev@gmail.com?part=3D1
