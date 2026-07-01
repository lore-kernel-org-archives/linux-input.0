Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A842D4F5E0
	for <linux-input@vger.kernel.org>; Wed,  1 Jul 2026 02:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782872150; cv=none; b=HnEpmq9XRI3sZWps66jxzsnstLZRftsSlGI4lQQp8u+SBrDo8MaDQYpbkrw3RxDnMrXRZpfh3etpWNPp5+gZJX075eDHyH0QIJofz0pt6TNmOPHwsPikDuiJIHjZueCNZ+juy+rj8ItLKlDITVXFW4hp32ErWLXD8H1JhiBhX3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782872150; c=relaxed/simple;
	bh=LiMGu5teIV8yih+3jA8rzmA/s2qy8oeLU+ZKK/pqA/Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JoBUae9qc5K2ckDeS+DoqOXVqlU7qNi/xZIDvfhkLll4REHSs+9aRgAJqKkPk/T0jNUs1tI+ZpEZn38s7f/NvncY3f3BIm02bfJzSvANz1bSqMzmV8Mue+yxKCcW9fzmBP236r1INOFghPWVtVgW7tm7IayzhQWftYe/dos2RVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MotURgkq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MotURgkq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A2A1F000E9;
	Wed,  1 Jul 2026 02:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782872149;
	bh=P+/m3FUgMXphX6NZdw+wMROQhWjbWMu6Ev2mfGJYW9I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MotURgkqMVjutIQzkAGdOfbtwt7J7vPYHH1zQaukEsYW26cHbGOFQXllsacIXtn6R
	 JZKXT9uV3HoRoPSJukYv0/3CzydL5lXEpMV+QC8bFwoGoMZvNZ/MyKdwGRl787372a
	 wP65pPOUnZEfqN9dtFpk+uhZ+oJFml2xkGc93UJmKkn6DIVSaaZiPOku1KHdfxZszu
	 pdaowL08iteIwZmPbU4g4z4THzX6+jEt6o0W7ZCuXpvrH1gVNWMJrPm5rcKojxwN1E
	 3CQ2ILgZoCd9U8YY5tugdeTwplF2YrmMtZSf0WgPvMUvcYDqcLGy1o2T/+G04RZ3af
	 FaHWYm7Wn9D7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] HID: Intel-thc-hid: Intel-quicki2c: Refine recover
 callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Even Xu" <even.xu@intel.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260701020432.3774514-3-even.xu@intel.com>
References: <20260701020432.3774514-1-even.xu@intel.com>
 <20260701020432.3774514-3-even.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 02:15:48 +0000
Message-Id: <20260701021549.13A2A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Missing cancellation of the scheduled asynchronous recovery work d=
uring device removal and shutdown leads to a Use-After-Free.
- [High] Unconditionally re-enabling hardware interrupts before the asynchr=
onous recovery completes causes an immediate interrupt storm.
- [High] The deferred `try_recover` work function accesses hardware registe=
rs directly without acquiring a Runtime PM reference.
--

commit 8f5c7d640eb5d690c93bdf294d89a5d9087edae5
Author: Even Xu <even.xu@intel.com>

HID: Intel-thc-hid: Intel-quicki2c: Refine recover callback

This commit refines the recover flow by moving the hardware recovery operat=
ion
to an asynchronous workqueue. It replaces the inline recover operation with=
 a
call to schedule_work() and simplifies the recover callback using
thc_rxdma_reset().

> diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c b/dr=
ivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> index 46d3e9a019995..411d7a0ab90ef 100644
> --- a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> +++ b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
[ ... ]
> @@ -245,28 +245,23 @@ static irqreturn_t quicki2c_irq_quick_handler(int i=
rq, void *dev_id)
>  }
> =20
> -static int try_recover(struct quicki2c_device *qcdev)
> +static void try_recover(struct work_struct *work)
>  {
> +	struct quicki2c_device *qcdev =3D container_of(work, struct quicki2c_de=
vice, recover_work);
> =20
> +	thc_interrupt_enable(qcdev->thc_hw, false);
> =20

[Severity: High]
Is it safe to access the hardware registers in this work function without
holding a runtime PM reference?

Since the IRQ handler calls pm_runtime_put_autosuspend() right after
scheduling the work, could the device transition to a suspended state before
try_recover() executes, resulting in invalid MMIO accesses when trying to
manipulate the THC registers?

> -	thc_dma_unconfigure(qcdev->thc_hw);
> -
> -	ret =3D thc_dma_configure(qcdev->thc_hw);
> -	if (ret) {
> -		dev_err(qcdev->dev, "Reconfig DMA failed\n");
> -		return ret;
> -	}
> +	if (thc_rxdma_reset(qcdev->thc_hw))
> +		qcdev->state =3D QUICKI2C_DISABLED;
> +	else
> +		thc_interrupt_enable(qcdev->thc_hw, true);
>  }
[ ... ]
> @@ -346,8 +341,7 @@ static irqreturn_t quicki2c_irq_thread_handler(int ir=
q, void *dev_id)
>  	thc_interrupt_enable(qcdev->thc_hw, true);
> =20

[Severity: High]
Does re-enabling the interrupt here before the recovery work executes cause
an interrupt storm?

Because the actual hardware error state isn't cleared until thc_rxdma_reset=
()
runs asynchronously in the workqueue, unmasking the interrupt here might
cause the hardware to instantly re-assert the interrupt. Could this lead to
an infinite loop between the hard IRQ and threaded IRQ handlers, thereby
starving the system workqueue from ever executing try_recover()?

>  	if (err_recover)
> -		if (try_recover(qcdev))
> -			qcdev->state =3D QUICKI2C_DISABLED;
> +		schedule_work(&qcdev->recover_work);
> =20
>  	pm_runtime_put_autosuspend(qcdev->dev);
[ ... ]
> @@ -386,6 +380,7 @@ static struct quicki2c_device *quicki2c_dev_init(stru=
ct pci_dev *pdev, void __io
>  	qcdev->ddata =3D ddata;
> =20
>  	init_waitqueue_head(&qcdev->reset_ack_wq);
> +	INIT_WORK(&qcdev->recover_work, try_recover);
> =20

[Severity: High]
When the device is removed, could the scheduled work run after the device
context is freed?

Looking at quicki2c_remove(), there is no call to cancel_work_sync() before
tearing down the device. Since qcdev is allocated with devres, might
this lead to a use-after-free if the recovery work is still queued on the
system workqueue when the removal path finishes?

>  	/* THC hardware init */
>  	qcdev->thc_hw =3D thc_dev_init(qcdev->dev, qcdev->mem_addr);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701020432.3774=
514-1-even.xu@intel.com?part=3D2
