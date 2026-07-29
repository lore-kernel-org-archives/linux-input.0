Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AB431E82E
	for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 05:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785302281; cv=none; b=Q65WwMEAaC/Xv/KcwCblrAsyAe9IoZ70hh06XgNLK6U0nJJPWlMkx/nQOREvedimOAJzfZBUb16DQHph3b05KdCahAAfEJo1N9qGc6hHesuO9P5H50Pmto8oWXw1nR6zP9g45IcD/goZy0ayyzilkxfeiMx14ofBmivgI4EgnHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785302281; c=relaxed/simple;
	bh=9WIe0VzXXo5QevSEt0lYA/E0ZZYoZoSNasWjajJ9SRA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lbPqxHLNZG362CdNH28/qS5vGz8bOjATsLs6kKr5BQ82izWvzXcQ1p0s7Mq+Uzu8J5YEXWPVPzSZp53JdrRBPX7RzCeRFdWiDP/WBKYPLuWMmQsMBAyrpUP0MSmBfI6HS98a8H5/wpVl9Vwzh7K9uJ8n2d71QMynRVD4wzgx4P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ye+VY8tC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ye+VY8tC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEC6D1F000E9;
	Wed, 29 Jul 2026 05:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785302280;
	bh=BEnM4MLNQVYrkPvhXphyu3ft2T/lcRaI6DDRP2+yZQY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ye+VY8tC9/k/PLgBMZQpPTTJkdO5i9Xru5FS5DP1AVaDJ27pfQoyFgaen05TPOIp8
	 +iQeAKXmY1diyPSeCTF3joizWa62z2syuGQUwjt6lthSUo2QRa+/7GnV0UBGNgJmrb
	 XsqtZkS7V487K2gGgX2EVxl9klpj6k49ewrGMw2u57S/30Btucf0e8gVrfp5/k2L/k
	 By/lvM1mY5iBrWHCHx7Ejz3W3iNHJmCA7OOllAyeOLeuCVbIVRo5O6c2bChd32ay16
	 3XeULWyClC37aG6OJRBh+BaijFVM3X5Y5r7rf9EPwCLL+nWcZ7kxvAgnMJmywXwUIC
	 bR6JNsE2fJvFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/3] HID: Intel-thc-hid: Intel-quicki2c: Refine
 recover callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Even Xu" <even.xu@intel.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260729050145.2272597-3-even.xu@intel.com>
References: <20260729050145.2272597-1-even.xu@intel.com>
 <20260729050145.2272597-3-even.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 05:17:59 +0000
Message-Id: <20260729051759.BEC6D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Use-After-Free and race condition during device teardown due to im=
proper workqueue cancellation.
- [Medium] Failed suspend operation leaves the device recovery mechanism pe=
rmanently disabled.

Pre-existing issues:
- [High] Missing cleanup of IRQ vectors on error paths and device removal, =
leading to an IRQ resource leak.
- [High] Unsafe MMIO register access in hard IRQ handler without PM runtime=
 verification.
- [High] Use-After-Free on the HID device structure during removal.
--

--- Patch [2]: [PATCH v5 2/3] HID: Intel-thc-hid: Intel-quicki2c: Refine re=
cover callback ---
commit f51d43428a895d224d1667aba97de68a9108ddc3
Author: Even Xu <even.xu@intel.com>

HID: Intel-thc-hid: Intel-quicki2c: Refine recover callback

This commit introduces a workqueue for the recovery flow in the quicki2c
driver instead of processing it in the IRQ handler. It also simplifies
recovery using the thc_rxdma_reset() API and disables interrupts during
the whole recover flow to prevent storms on failure.

> diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c b/dr=
ivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> index 46d3e9a019995..539da002aa4fd 100644
> --- a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> +++ b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> @@ -245,28 +245,33 @@ static irqreturn_t quicki2c_irq_quick_handler(int i=
rq, void *dev_id)
>  }

[Severity: High]
This is a pre-existing issue, but could this cause an unsafe MMIO access?

Looking at quicki2c_irq_quick_handler():

static irqreturn_t quicki2c_irq_quick_handler(int irq, void *dev_id)
{
    ...
    /* Disable THC interrupt before current interrupt be handled */
    thc_interrupt_enable(qcdev->thc_hw, false);
    ...
}

The probe function allows fallback to shared legacy INTx interrupts via
pci_alloc_irq_vectors(). If the device is in D3hot (runtime suspended) and
a shared interrupt triggers on the same line, could this handler access the
thc_interrupt_enable MMIO register on powered-down hardware?

PM subsystem guidelines suggest checking pm_runtime_get_if_active() before
register access in shared IRQ handlers.

[ ... ]

> @@ -439,6 +445,9 @@ static struct quicki2c_device *quicki2c_dev_init(stru=
ct pci_dev *pdev, void __io
>   */
>  static void quicki2c_dev_deinit(struct quicki2c_device *qcdev)
>  {
> +	WRITE_ONCE(qcdev->recovery_disabled, true);
> +	cancel_work_sync(&qcdev->recover_work);
> +
>  	thc_interrupt_quiesce(qcdev->thc_hw, true);
>  	thc_interrupt_enable(qcdev->thc_hw, false);

[Severity: High]
Is there a race condition here that could lead to a use-after-free?

Because cancel_work_sync() is called before the hardware interrupt source
is disabled with thc_interrupt_enable(), could a concurrent or preempted
threaded IRQ handler call schedule_work() immediately after
cancel_work_sync() returns?

If the work is placed back on the queue and the qcdev structure is
subsequently freed during removal, would the workqueue eventually execute
try_recover() on freed memory?

[ ... ]

> @@ -772,12 +781,13 @@ static void quicki2c_remove(struct pci_dev *pdev)
>  		return;
> =20
>  	quicki2c_hid_remove(qcdev);
> +
> +	quicki2c_dev_deinit(qcdev);

[Severity: High]
This is a pre-existing issue, but does destroying the HID device before
disabling hardware interrupts create a race window?

If an RX interrupt arrives after quicki2c_hid_remove() completes but before
quicki2c_dev_deinit() disables interrupts, could the threaded IRQ handler
execute handle_input_report() and invoke quicki2c_hid_send_report(),
leading to a dereference of the freed qcdev->hid_dev pointer?

[Severity: High]
This is also a pre-existing issue, but are the IRQ vectors leaked
during removal?

The probe function allocates vectors via pci_alloc_irq_vectors() with
PCI_IRQ_ALL_TYPES, but there does not appear to be a corresponding
pci_free_irq_vectors() in quicki2c_remove() or the probe error paths.

Does this result in a permanent leak of system IRQ resources?

>  	quicki2c_dma_deinit(qcdev);
> =20
>  	pm_runtime_get_noresume(qcdev->dev);
> =20
> -	quicki2c_dev_deinit(qcdev);
> -
>  	pci_clear_master(pdev);
>  }

[ ... ]

> @@ -826,6 +836,9 @@ static int quicki2c_suspend(struct device *device)
>  	if (ret)
>  		return ret;
> =20
> +	WRITE_ONCE(qcdev->recovery_disabled, true);
> +	cancel_work_sync(&qcdev->recover_work);
> +
>  	ret =3D thc_interrupt_quiesce(qcdev->thc_hw, true);
>  	if (ret)
>  		return ret;

[Severity: Medium]
If thc_interrupt_quiesce() fails and returns an error here, is
qcdev->recovery_disabled left permanently set to true?

Since a failed suspend aborts the transition and won't trigger a subsequent
resume callback to reset the flag, would this leave the driver in a state
where try_recover() silently aborts on all future errors?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729050145.2272=
597-1-even.xu@intel.com?part=3D2
