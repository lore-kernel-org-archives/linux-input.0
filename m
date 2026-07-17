Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104072F5491
	for <linux-input@vger.kernel.org>; Fri, 17 Jul 2026 04:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784261214; cv=none; b=MTTD7Xj10WMSsa3NETDm9Hpxg9x/1eRVzGEtfIfDyyuIPNTy38TEsiqsYsMojfqZnHiQhvAA3JLeqv/FvzYEMiGwee2E+7xg0BXARShBCnLJES/2nzl8PCfAIHs75SnGDJMlduRSaHPc7KnBytx/Y6yBJsDDL8KFSDSVi3gzn+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784261214; c=relaxed/simple;
	bh=hWooUaRY9wnkXiXqYlOqH6W113SnQroxLQa5qOckfBk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IHmO4bffU+rz4F9uq89VS0mJlULb9K3tmQPOu2SbLFKJXvPUt15/8KozvVW/WqaraZaq5MYW3lXGWUR77YcbG4VYryw19vJoxij2qak7LLS6v84U6pnUD8xtSfkINnPFC0m9C7L/tIOoO2IfFIDFuk/546d9GKNAbmQvwUeX/Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAkMW+bS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAkMW+bS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 826F51F000E9;
	Fri, 17 Jul 2026 04:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784261212;
	bh=iLXMjjJw16woIMPKxhqU1CrsnsGYi5nU2D+ZHmLC+2w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NAkMW+bS449iWmgdr3hJWuv02RvXOTZ8T5kilU7TY20B9cREzwkzllFdj0cQRkZvJ
	 iFwwFi1kKbBd98xLOy4fIh7H6aft+J7sRFzksDvmrBsT8U1AgWTyo+SwWM4rITEXG7
	 W974z+SQbEZhktid/kJlOMD6RtsvewTYfK+kcyLF89Xl5eavJlj0LWo0wWJ1Kwbo6p
	 n4o78b1GbPfQtr6SsrQO8eMtSrB8aSyBosgoZyMjIFctMdaZhgeoPgXk/jmRIqipxK
	 Z28Twf2tBDBvkBwMJMl0V6cInjsmoSFk/58QxzgtL9QjZ6x82J8dKJd9ixJ7r+DGQy
	 zk3lp+rbQLHSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/3] HID: Intel-thc-hid: Intel-quicki2c: Refine
 recover callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Even Xu" <even.xu@intel.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260717035609.3874015-3-even.xu@intel.com>
References: <20260717035609.3874015-1-even.xu@intel.com>
 <20260717035609.3874015-3-even.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 04:06:52 +0000
Message-Id: <20260717040652.826F51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [High] Race condition during device teardown leading to a Use-After-Free =
of `qcdev`.
- [Medium] Race condition in resume/thaw paths permanently disables device =
interrupts.
- [Medium] Premature interrupt unmasking causes an interrupt storm for shar=
ed IRQs.
- [Low] Redundant hardware teardown in `quicki2c_poweroff()` triggers kerne=
l warnings.

Pre-existing issues:
- [High] Hardirq handler accesses memory-mapped hardware registers without =
verifying runtime PM state.
- [High] Unvalidated length field from hardware allows out-of-bounds read i=
n the HID core.
--

--- Patch [2]: [PATCH v4 2/3] HID: Intel-thc-hid: Intel-quicki2c: Refine re=
cover callback ---
commit 8f342c689f3a83c1f792680893d01fe944f899d6
Author: Even Xu <even.xu@intel.com>
Subject: HID: Intel-thc-hid: Intel-quicki2c: Refine recover callback

This commit refines the recover flow by offloading it to a workqueue instead
of processing it in the IRQ handler. It simplifies the operation using the
thc_rxdma_reset() API and ensures interrupts are disabled during the entire
recovery flow.

> diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c b/dr=
ivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> index 46d3e9a019995..3ccbddfe8e5e8 100644
> --- a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> +++ b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> @@ -245,28 +245,31 @@ static irqreturn_t quicki2c_irq_quick_handler(int i=
rq, void *dev_id)
>  }

[Severity: High]
This is a pre-existing issue, but does quicki2c_irq_quick_handler() risk
accessing memory-mapped hardware registers while the device is in a
runtime-suspended state?

The driver allows fallback to shared INTx interrupts, so the hardirq
handler could be invoked by another device on the same IRQ line while this
device is suspended. Calling thc_interrupt_enable() unconditionally could
access powered-off registers and cause Unsupported Requests (UR).

> =20
>  /**
> - * try_recover - Try to recovery THC and Device
> - * @qcdev: Pointer to quicki2c_device structure
> + * try_recover - Recover callback to recover THC
> + * @work: pointer to work_struct
>   *
>   * This function is an error handler, called when fatal error happens.
> - * It try to reset touch device and re-configure THC to recovery
> - * communication between touch device and THC.
> - *
> - * Return: 0 if successful or error code on failure
> + * It try to reset Touch Device and re-configure THC to recover
> + * transferring between Device and THC.
>   */
> -static int try_recover(struct quicki2c_device *qcdev)
> +static void try_recover(struct work_struct *work)
>  {
> -	int ret;
> +	struct quicki2c_device *qcdev =3D container_of(work, struct quicki2c_de=
vice, recover_work);
> =20
> -	thc_dma_unconfigure(qcdev->thc_hw);
> +	if (READ_ONCE(qcdev->recovery_disabled))
> +		return;
> =20
> -	ret =3D thc_dma_configure(qcdev->thc_hw);
> -	if (ret) {
> -		dev_err(qcdev->dev, "Reconfig DMA failed\n");
> -		return ret;
> -	}
> +	if (pm_runtime_resume_and_get(qcdev->dev))
> +		return;
> =20
> -	return 0;
> +	thc_interrupt_enable(qcdev->thc_hw, false);
> +
> +	if (thc_rxdma_reset(qcdev->thc_hw))
> +		qcdev->state =3D QUICKI2C_DISABLED;
> +	else
> +		thc_interrupt_enable(qcdev->thc_hw, true);
> +
> +	pm_runtime_put_autosuspend(qcdev->dev);
>  }
> =20
>  static int handle_input_report(struct quicki2c_device *qcdev)

[Severity: High]
This is a pre-existing issue, but does handle_input_report() trust the
length field from the hardware without validating it?

If a buggy or malicious device sends a packet with pkt->len equal to 1,
HIDI2C_DATA_LEN could underflow to SIZE_MAX when passed to the HID core:

quicki2c_hid_send_report(qcdev, pkt->data,
                         HIDI2C_DATA_LEN(le16_to_cpu(pkt->len)));

Could this unvalidated length cause an out-of-bounds read in the HID core?

[ ... ]

> @@ -343,11 +346,10 @@ static irqreturn_t quicki2c_irq_thread_handler(int =
irq, void *dev_id)
>  	}
> =20
>  exit:
> -	thc_interrupt_enable(qcdev->thc_hw, true);
> -
>  	if (err_recover)
> -		if (try_recover(qcdev))
> -			qcdev->state =3D QUICKI2C_DISABLED;
> +		schedule_work(&qcdev->recover_work);
> +	else
> +		thc_interrupt_enable(qcdev->thc_hw, true);

[Severity: Medium]
Could this unconditionally re-enable the hardware interrupt while a recovery
is already pending?

If err_recover is 0 (for instance, if another shared interrupt fires), the
else branch unmasks the broken device's interrupt prematurely.

Does this cause an interrupt storm before try_recover() has a chance to run?

[ ... ]

> @@ -439,6 +443,9 @@ static struct quicki2c_device *quicki2c_dev_init(stru=
ct pci_dev *pdev, void __io
>   */
>  static void quicki2c_dev_deinit(struct quicki2c_device *qcdev)
>  {
> +	WRITE_ONCE(qcdev->recovery_disabled, true);
> +	cancel_work_sync(&qcdev->recover_work);
> +
>  	thc_interrupt_quiesce(qcdev->thc_hw, true);
>  	thc_interrupt_enable(qcdev->thc_hw, false);
>  	thc_ltr_unconfig(qcdev->thc_hw);

[Severity: High]
Is there a race condition here that could lead to a use-after-free of qcdev?

cancel_work_sync() is called before the hardware interrupts are quiesced
and disabled. If the threaded IRQ handler is preempted right before calling
schedule_work(), it could queue recover_work after cancel_work_sync()
completes:

CPU1                                   CPU2
quicki2c_irq_thread_handler()          quicki2c_dev_deinit()
   err_recover =3D 1;
   // preempted
                                       cancel_work_sync();
                                       thc_interrupt_quiesce();
                                       // device removed, qcdev freed
   schedule_work(&qcdev->recover_work);

When try_recover() eventually runs, will it dereference the freed qcdev
pointer?

[ ... ]

> @@ -867,6 +878,8 @@ static int quicki2c_resume(struct device *device)
>  	if (ret)
>  		return ret;
> =20
> +	WRITE_ONCE(qcdev->recovery_disabled, false);
> +

[Severity: Medium]
Does unmasking the interrupt before setting recovery_disabled to false
create a window where the device can become permanently disabled?

If the hardware asserts an interrupt after thc_interrupt_quiesce() enables
it, but before WRITE_ONCE(qcdev->recovery_disabled, false) runs, the IRQ
handler will queue the recovery work.

The work will execute try_recover(), read recovery_disabled as true, and
return immediately without re-enabling interrupts. Will this leave the
device permanently unresponsive?

>  	if (!device_may_wakeup(qcdev->dev))
>  		return quicki2c_set_power(qcdev, HIDI2C_ON);

[ ... ]

> @@ -938,6 +956,8 @@ static int quicki2c_poweroff(struct device *device)
> =20
>  	thc_ltr_unconfig(qcdev->thc_hw);
> =20
> +	quicki2c_dev_deinit(qcdev);
> +
>  	quicki2c_dma_deinit(qcdev);
> =20
>  	return 0;

[Severity: Low]
Does adding quicki2c_dev_deinit() here result in redundant hardware teardown
steps?

quicki2c_poweroff() manually calls thc_interrupt_quiesce() and
thc_ltr_unconfig() just before this line. Since quicki2c_dev_deinit() also
calls those functions, it looks like they are executed twice, which might
trigger kernel warnings from the underlying hardware functions.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717035609.3874=
015-1-even.xu@intel.com?part=3D2
