Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74A630149F
	for <linux-input@vger.kernel.org>; Mon, 13 Jul 2026 03:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783912673; cv=none; b=TyR7AwQQv6LH/DkrdEe5wGvdyb1yI4HtLfjWytC+Aya9/AWzFUapl6QzVuzksT1VTZfza4FUhJlsRB+XTfIHSkOfIugai5+MlO5qdL2nsJHVFyGQJr22Em0Btd18kluoKMr44YkptZaFng9QS0CGvSveX8t8to/nzE3+sxHEUjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783912673; c=relaxed/simple;
	bh=hHmEuqKaOK/bWSaVDX1OqlQja/1ZoWidmFH2o0Jc9JA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MDpW5gjh7GVh0IBBZ91pj0L1zxcDaSCaPg4l9c6e8avXm88Y1osZU77jpy6DZzvOwDVQJa3fo7VCLMVkLg/62ipP1z1m9I9DZr3vAVXkgMmoizy2mYKzW14p+XQHuXIaVKj8iZ/Ptm/sP5RkCrxJ5BFUZYSX/m1eVZ0vuew28Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYH6MtYG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYH6MtYG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E52311F00A3A;
	Mon, 13 Jul 2026 03:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783912670;
	bh=ju6vrbnhGnWwIyMHbkcxs6zpwKzlMmTZNB98cB2dxpY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bYH6MtYGF96ptiIIAm6Evir0lTsoARrrELtIwZ6wBetbZNbJwfDCHw2zJ3y56bmWp
	 MJNPLwO08b/KJnc3kaNS4lg2n08RL9UFTCnxTAUXZ+6r7gImNXzsw96GWUn7csFiKD
	 DsWfh5CDhXqZpA/DK+iMvItU3OLIJp+/RcDsMoo4CR83tBLCdu1EVuvlzo5aehGLzs
	 hQqbS/V3qMRKjIMR9rSwBsKOsiYaCjcMGyH5oAxCBvyjZVLr5BsvRhr0YYoWpSSKFW
	 QEvujAr7fMWtWdrIUNcayD1HoQT45yRY99hiUAejUHMzX9OSRiiFxFoor4OUaWUGf0
	 HPiS8NfHeIMww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] HID: Intel-thc-hid: Intel-quickspi: Refine
 recover callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Even Xu" <even.xu@intel.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260713030412.2531933-4-even.xu@intel.com>
References: <20260713030412.2531933-1-even.xu@intel.com>
 <20260713030412.2531933-4-even.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 03:17:49 +0000
Message-Id: <20260713031749.E52311F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Teardown race in `quickspi_remove()` and `quickspi_shutdown()` aga=
inst `try_recover()` allows hardware interrupts to be incorrectly re-enable=
d or work to be scheduled after cancellation, leading to Use-After-Free.
- [High] Missing `cancel_work_sync` in the probe error path leads to a Use-=
After-Free if recovery work is scheduled during a failed probe.
- [High] The recovery work is not cancelled during system suspend, potentia=
lly corrupting hardware state.
--

--- Patch [3]: [PATCH v3 3/3] HID: Intel-thc-hid: Intel-quickspi: Refine re=
cover callback ---
commit 944320624d1a0211e0b09ee8578713e28378329b
Author: Even Xu <even.xu@intel.com>

HID: Intel-thc-hid: Intel-quickspi: Refine recover callback

This commit refines the quickspi device recovery flow. It moves the
recovery process from the IRQ handler to a workqueue, uses the
thc_rxdma_reset() API to simplify operations, and manages interrupt
states throughout the recovery sequence.

> diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c b/dr=
ivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> index 4ae2e1718b30c..83ed5516b8097 100644
> --- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> +++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c

[ ... ]

> @@ -385,6 +378,7 @@ static struct quickspi_device *quickspi_dev_init(stru=
ct pci_dev *pdev, void __io
>  	init_waitqueue_head(&qsdev->report_desc_got_wq);
>  	init_waitqueue_head(&qsdev->get_report_cmpl_wq);
>  	init_waitqueue_head(&qsdev->set_report_cmpl_wq);
> +	INIT_WORK(&qsdev->recover_work, try_recover);

[Severity: High]
Since recover_work is being initialized here, what happens if
quickspi_probe() fails after the IRQ is registered?

If a hardware error interrupt occurs and schedules recover_work, and a
subsequent step in the probe process fails, the error path jumps to
the dev_deinit label which cleans up the device but never calls
cancel_work_sync().

Could this result in the devres framework freeing the IRQ and qsdev
while the recovery work is still pending, leading to a use-after-free
crash when the work runs?

[ ... ]

> @@ -711,6 +705,12 @@ static void quickspi_remove(struct pci_dev *pdev)
>  		return;
> =20
>  	quickspi_hid_remove(qsdev);
> +
> +	thc_interrupt_quiesce(qsdev->thc_hw, true);
> +	thc_interrupt_enable(qsdev->thc_hw, false);
> +
> +	cancel_work_sync(&qsdev->recover_work);
> +

[Severity: High]
Is there a race condition here against the threaded IRQ handler during
device teardown?

Since qsdev->state is not set to QUICKSPI_DISABLED and the OS-level
IRQ is not disabled before cancel_work_sync() is called, could a
concurrent execution of quickspi_irq_thread_handler() schedule the
work again immediately after cancel_work_sync() returns?

Also, if try_recover() is running concurrently during this teardown, it
unconditionally calls thc_interrupt_enable(qsdev->thc_hw, true) on exit,
which could re-enable hardware interrupts after they were just disabled
here. Could this lead to a use-after-free when the devres framework
later frees the qsdev structure?

[Severity: High]
Does the quickspi_suspend() callback need to cancel this work as well?

Currently, quickspi_suspend() transitions the device to a suspended
state but lacks a call to cancel_work_sync(&qsdev->recover_work).
Because schedule_work() queues onto the non-freezable system_wq, the
try_recover() work could execute concurrently with or after the
suspend process.

Since try_recover() calls pm_runtime_resume_and_get(), resets the
RxDMA, and re-enables hardware interrupts, could this leave the device
in an inconsistent active state across system suspend, potentially
causing resume failures or power leaks?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713030412.2531=
933-1-even.xu@intel.com?part=3D3
