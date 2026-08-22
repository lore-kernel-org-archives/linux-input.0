Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9DB38F24D
	for <linux-input@vger.kernel.org>; Sat, 22 Aug 2026 13:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787403927; cv=none; b=eM+3IW+vTFucVBPYD+Z9Vjp2ivtNVt/YWZOsNIfLBdiPR6oe8cm1E51woEszKKl7ljm7QRKwCmplSpO+o4QdmaXPp/F0QiblN9N01hUaRLLMzCmZNsfylIM5M7VMubW0yI020nZMYXm3i+zZrm7dW1ph0Vx2Pbfw+BL59q5PfmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787403927; c=relaxed/simple;
	bh=mUSjt77BOk6xRvS7Xib/KJIeSnZvqnG+aDXGuDgJP6M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FCuOLVxvT7HYs8YmVL4moPSRUjPbeQv5M1MOTLq/5yYMhzTXsNtkUSqyTcZ3UB8U2rlj+1tZSPLlTR8HA0Ld3cyf8gp4R+sQwGpKR2KXhdXzcW7OJw5AqJCNt6/EL4legAVDiT4/IwgAjZy9VtFwd8N4U1CHgjjPodmggch95SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4V8cfeS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4V8cfeS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C1551F000E9;
	Sat, 22 Aug 2026 13:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787403924;
	bh=gUg/8HmCHIbVK8ViWGSOPecRNqIQcLlj1Nwk+okNjjY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D4V8cfeSdKz9Ad0/RSon1OyfRgquHmFA4fFQAXtQmtAAHXaIFmzLwA6vSK/tt1MTH
	 iaCq+yCSjKf938z2OD14MQQIKrmLEAh5FenPeVXVGZA/DXgseddvhR7MaW6Fw5TfN/
	 fYzLvefSuID0y58W6ux/u6ha9zI2oCiEcqt377JAF4jF5FEvTZOiSSUgiPusE6MSKH
	 xCsOyhGhmfVouHHTuGWpy4guFy+Y5UMsSp3exQk6RvfAVqpCdvzlslD9ljrGhaCGcn
	 5Uyi1Az/sgw4cJX8wA2DXEfDhwyTz/D2RcPu3DEikpMft//dOLALSOh5KrznSZnJ5x
	 kNOSDuAUL34jA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: intel-thc-hid: intel-quicki2c: size the input
 buffer for the DMA
Reply-To: sashiko-reviews@lists.linux.dev
To: "HyeongJun An" <sammiee5311@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260822124531.644834-1-sammiee5311@gmail.com>
References: <20260822124531.644834-1-sammiee5311@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 13:05:23 +0000
Message-Id: <20260822130524.2C1551F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Information Leak / Stale Data Use via unverified DMA read length i=
n `quicki2c_get_report`.
- [High] Memory leak of DMA buffers on the `quicki2c_probe()` error path.
- [High] Use-After-Free of `hid_device` due to missing synchronization duri=
ng device unbind.
- [High] Use-After-Free of `qcdev` via `recover_work` workqueue during devi=
ce unbind.
- [High] Data corruption due to concurrent lockless accesses to the shared =
`input_buf`.
- [High] DMA buffer overrun vulnerability on `qsdev->input_buf` in sister d=
river `intel-quickspi`.
- [High] Out-of-Bounds Read in `handle_input_report` due to trusting hardwa=
re length field and unsafe HID API.
- [Medium] Data races due to unprotected state modifications of `qcdev->sta=
te`.
--

--- Patch [1]: [PATCH] HID: intel-thc-hid: intel-quicki2c: size the input b=
uffer for the DMA ---
commit bd435db6ebf25c331234086da4dfea64fbc2e7e3
Author: HyeongJun An <sammiee5311@gmail.com>

HID: intel-thc-hid: intel-quicki2c: size the input buffer for the DMA

This commit sizes the input buffer based on the SWDMA packet size while
keeping a 4K floor. This prevents DMA buffer overruns when devices declare a
larger report length than their max input length.

> diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c b/dr=
ivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> index 0d2ad7bc3648a..f6f9f95296d36 100644
> --- a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> +++ b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> @@ -602,9 +602,12 @@ static int quicki2c_alloc_report_buf(struct quicki2c=
_device *qcdev)
> =20
>  	/*
>  	 * Some HIDI2C devices don't declare input/output max length correctly,
> -	 * give default 4K buffer to avoid DMA buffer overrun.
> +	 * give default 4K buffer to avoid DMA buffer overrun.  Both RxDMA2 and
> +	 * SWDMA land here, so cover the larger SWDMA packet size.
>  	 */
> -	max_report_len =3D max(le16_to_cpu(qcdev->dev_desc.max_input_len), SZ_4=
K);
> +	max_report_len =3D max(le16_to_cpu(qcdev->dev_desc.max_input_len),
> +			     le16_to_cpu(qcdev->dev_desc.report_desc_len));
> +	max_report_len =3D max_t(size_t, ALIGN(max_report_len, SZ_4K), SZ_4K);
> =20
>  	qcdev->input_buf =3D devm_kzalloc(qcdev->dev, max_report_len, GFP_KERNE=
L);

[Severity: High]
This is a pre-existing issue, but does this same vulnerability still exist
in the sister driver intel-quickspi?

Looking at quickspi_alloc_report_buf() in pci-quickspi.c:

    max_input_len =3D max(le16_to_cpu(qsdev->dev_desc.rep_desc_len),
                        le16_to_cpu(qsdev->dev_desc.max_input_len));
    qsdev->input_buf =3D devm_kzalloc(qsdev->dev, max_input_len, GFP_KERNEL=
);

Since the DMA hardware is instructed elsewhere that it can safely write up =
to
a 4K-aligned size, could a device sending more data than declared overrun
this unaligned allocation, just like the quicki2c bug being fixed here?

[Severity: High]
This is a pre-existing issue, but does the shared input_buf suffer from
concurrent lockless accesses?

Process context uses it during SWDMA transfers in quicki2c_get_report():

    rpt =3D (struct hidi2c_report_packet *)qcdev->input_buf;
    ret =3D thc_swdma_read(qcdev->thc_hw, qcdev->report_buf, len, NULL, rpt=
, &read_len);

Meanwhile, the interrupt context unconditionally reads into it without locks
in handle_input_report():

    struct hidi2c_report_packet *pkt =3D (struct hidi2c_report_packet *)qcd=
ev->input_buf;
    ...
    ret =3D thc_rxdma_read(qcdev->thc_hw, THC_RXDMA2, (u8 *)pkt, &report_le=
n,

If a hardware input event arrives during a synchronous get_report ioctl,
could this corrupt the command response?

[Severity: High]
This is a pre-existing issue, but could this shared input buffer leak
uninitialized or stale data back to userspace?

In quicki2c_get_report(), the read_len populated by thc_swdma_read() seems
to be ignored:

    ret =3D thc_swdma_read(qcdev->thc_hw, qcdev->report_buf, len, NULL, rpt=
, &read_len);
    if (ret) {
    ...
    if (HIDI2C_DATA_LEN(le16_to_cpu(rpt->len)) !=3D buf_len || rpt->data[0]=
 !=3D reportnum) {
    ...
    memcpy(buf, rpt->data, buf_len);

If a short DMA read or 0-byte read succeeds, could the stale data remaining
in input_buf coincidentally match the expected lengths and report ID,
causing memcpy to copy stale kernel memory?

[Severity: High]
This is a pre-existing issue, but does the input report handling trust the
hardware length field without validating it against the actual DMA transfer
size?

In handle_input_report(), it passes the packet length directly:

    quicki2c_hid_send_report(qcdev, pkt->data,
                             HIDI2C_DATA_LEN(le16_to_cpu(pkt->len)));

Which then gets passed to the HID core in quicki2c_hid_send_report():

    ret =3D hid_input_report(qcdev->hid_dev, HID_INPUT_REPORT, data, data_l=
en, 1);

Since hid_input_report() lacks the buffer boundary checks of
hid_safe_input_report(), could malicious hardware providing a small DMA
transfer but a large forged pkt->len cause an out-of-bounds read?

[Severity: High]
This is a pre-existing issue, but does the device probe error path leak the
DMA buffers?

In quicki2c_probe():

    ret =3D thc_interrupt_quiesce(qcdev->thc_hw, false);
    if (ret)
        goto dev_deinit;
    ...
dma_deinit:
    quicki2c_dma_deinit(qcdev);
dev_deinit:
    quicki2c_dev_deinit(qcdev);

Does jumping directly to dev_deinit bypass the quicki2c_dma_deinit()
cleanup?

[Severity: High]
This is a pre-existing issue, but is there a missing synchronization step
during device unbind that could lead to a use-after-free?

In quicki2c_remove():

    quicki2c_hid_remove(qcdev);
    quicki2c_dev_deinit(qcdev);

If a hardware interrupt fires after the HID device is destroyed but before
quicki2c_dev_deinit() disables the hardware interrupts, could the IRQ thread
execute this in quicki2c_hid_send_report():

    ret =3D hid_input_report(qcdev->hid_dev, HID_INPUT_REPORT, data, data_l=
en, 1);

And dereference the freed qcdev->hid_dev pointer?

[Severity: High]
This is a pre-existing issue, but could the recovery workqueue cause a
use-after-free during device unbind?

In quicki2c_dev_deinit():

    WRITE_ONCE(qcdev->recovery_disabled, true);
    cancel_work_sync(&qcdev->recover_work);
    thc_interrupt_quiesce(qcdev->thc_hw, true);

Since thc_interrupt_quiesce() disables the hardware interrupts after the
work is canceled, could an interrupt fire in between and blindly schedule
the work again?

In quicki2c_irq_thread_handler():

exit:
    if (err_recover)
        schedule_work(&qcdev->recover_work);

Could this delayed work then execute on the freed qcdev memory after the
unbind completes?

[Severity: Medium]
This is a pre-existing issue, but are there data races when modifying the
device state?

The state is modified locklessly in a workqueue in try_recover():

    qcdev->state =3D QUICKI2C_DISABLED;

And read locklessly in the IRQ thread in handle_input_report():

    if (qcdev->state !=3D QUICKI2C_ENABLED)
        continue;

Could this lead to torn reads or inconsistent state logic due to compiler
reordering?

>  	if (!qcdev->input_buf)
>  		return -ENOMEM;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822124531.6448=
34-1-sammiee5311@gmail.com?part=3D1
