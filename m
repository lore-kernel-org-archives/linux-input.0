Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682792F693B
	for <linux-input@vger.kernel.org>; Mon, 13 Jul 2026 03:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783912611; cv=none; b=MFQ6kElUW8jLv5opGlYFRAnKncAx5xztz3zsKBm12xsBrpvJiNLwqXmi4yQI8rsDtj8Bg06vxWi1VI80lniCKSAA4aDRxmMRKl4u/++ldgGGaHZDcrcDcBOUc/WZ+Qm5hjzkW1yAyoqGnCWFJDKeha2M7h//+kyM/aSgzQv7vrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783912611; c=relaxed/simple;
	bh=dlpVZpkGhHtym5ASn6jkccX0vIIIg1fmo48B8GC4LmY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N/JeDMLQ2pcO+bX/5Yliq/0xRQNUUOVab005+YORTXbBAGZzhrI0HzRKO9FkCHz9mmCw7kPy/aS7cIsKRZxaKWbG+HN3adxISPrbuuQFmmxJP0+usWkBylwqgdXJ+4ay07BXWR4kZeMLtALOr+70bP3MOfGQt7oczppENAT9l10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8WQd0ea; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8WQd0ea"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D16F91F000E9;
	Mon, 13 Jul 2026 03:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783912607;
	bh=J+X2ZPqOlSzD982MG7IUBh05qBvaFNlbCvWk1GgE+LI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V8WQd0eaXf+XrmHotjZB8hlMKJ9ug5zsf5+huySPCS567RKK7tyIbY+WHkwC4IOoz
	 3HD0solGukjEVZSrI3AGOxdCz4UDJzapj3idRtYQfxbb0Fgn3M+y5/gnuVc0KkGshe
	 +PubUjjv6D2hXJDdhZ2DHIEW542rQAqjRu4oQxcEyNS7DiujtlqAHlQk2chFzy7imH
	 Ws0tvRSrDDLYtW9GRxphxvJPmgnHQow7ttLx9jKyI+Cu9AWfWapyThKDwaCfi48/Na
	 ofStwhTEixK/thzWAKf011DcnPbIMSLuEb7T8rFD53K7uo+8Hb2i2ei997orc3u7TH
	 75JndA1FzXfSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] HID: Intel-thc-hid: Intel-quicki2c: Refine
 recover callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Even Xu" <even.xu@intel.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260713030412.2531933-3-even.xu@intel.com>
References: <20260713030412.2531933-1-even.xu@intel.com>
 <20260713030412.2531933-3-even.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 03:16:46 +0000
Message-Id: <20260713031646.D16F91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The recovery workqueue can be scheduled by the threaded IRQ handle=
r after `cancel_work_sync()` returns, leading to a Use-After-Free during de=
vice removal or shutdown.
- [High] Missing cancellation of `recover_work` in the probe error path lea=
ds to a Use-After-Free if initialization fails.
- [High] Missing cancellation of `recover_work` during system suspend leave=
s the hardware in a corrupted state.
--

--- Patch [2]: [PATCH v3 2/3] HID: Intel-thc-hid: Intel-quicki2c: Refine re=
cover callback ---
commit 81b9a7d4f94249cad95844adc988f68429457956
Author: Even Xu <even.xu@intel.com>

HID: Intel-thc-hid: Intel-quicki2c: Refine recover callback

This commit modifies the recovery flow for Intel-quicki2c by using a
workqueue to process device resets instead of handling them directly
within the IRQ handler. It introduces the recover_work work_struct and
manages hardware interrupt states during the recovery process.

> diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c b/dr=
ivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> --- a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> +++ b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
[ ... ]
> @@ -386,6 +385,7 @@ static struct quicki2c_device *quicki2c_dev_init(stru=
ct pci_dev *pdev, void __io
>  	qcdev->ddata =3D ddata;
> =20
>  	init_waitqueue_head(&qcdev->reset_ack_wq);
> +	INIT_WORK(&qcdev->recover_work, try_recover);
> =20
>  	/* THC hardware init */

[Severity: High]
Does this work need to be cancelled during the probe error paths and
system suspend transitions?

If a failure occurs during quicki2c_probe() after the hardware interrupts a=
re
enabled, the devres framework will free qcdev. If an interrupt fires and
schedules this work before the error handler returns, could the background
workqueue dereference the freed qcdev?

Similarly, quicki2c_suspend() and quicki2c_freeze() do not appear to cancel
this work. If an interrupt schedules recover_work just before the system
suspends, could try_recover() run concurrently and re-enable hardware
interrupts, overriding the suspended hardware state?

[ ... ]
> @@ -772,6 +772,12 @@ static void quicki2c_remove(struct pci_dev *pdev)
>  		return;
> =20
>  	quicki2c_hid_remove(qcdev);
> +
> +	thc_interrupt_quiesce(qcdev->thc_hw, true);
> +	thc_interrupt_enable(qcdev->thc_hw, false);
> +
> +	cancel_work_sync(&qcdev->recover_work);
> +
>  	quicki2c_dma_deinit(qcdev);

[Severity: High]
Can the threaded IRQ handler race with this removal and re-queue the work?

The IRQ handler is managed by devm_request_threaded_irq() and remains active
until devres cleanup occurs after quicki2c_remove() returns.

If an interrupt fires right as cancel_work_sync() completes, couldn't the
IRQ thread call schedule_work() again?

If try_recover() then executes concurrently, it overrides the hardware
teardown by calling thc_interrupt_enable(..., true). When devres subsequent=
ly
frees the IRQ and qcdev, will this result in a use-after-free when the
re-queued work executes?

[ ... ]
> @@ -796,6 +802,11 @@ static void quicki2c_shutdown(struct pci_dev *pdev)
>  	if (!qcdev)
>  		return;
> =20
> +	thc_interrupt_quiesce(qcdev->thc_hw, true);
> +	thc_interrupt_enable(qcdev->thc_hw, false);
> +
> +	cancel_work_sync(&qcdev->recover_work);
> +
>  	/* Must stop DMA before reboot to avoid DMA entering into unknown state=
 */

[Severity: High]
Does this cancellation share the same race condition with the threaded IRQ
handler as quicki2c_remove()?

Without disabling the Linux IRQ line before cancelling the work, could a
concurrent hardware interrupt allow quicki2c_irq_thread_handler() to
re-queue recover_work during system shutdown?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713030412.2531=
933-1-even.xu@intel.com?part=3D2
