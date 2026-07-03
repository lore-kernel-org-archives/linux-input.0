Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64E2371CEC
	for <linux-input@vger.kernel.org>; Fri,  3 Jul 2026 08:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783066256; cv=none; b=RnEbeMk4ZlyyL4L8SVd5s/1gBtyaau1L9GddojZjdbQF+bMKUyb2kt9wHdaNln/ywMsfxPoGrKaKG+H3UkYwe0AyPO7EaFTCZ/B9wAMLAioQpeN0FKNPmz8YiyA/BadIc4BDSv3u97fKEQmiDsYO8q6IRoOXo8FFQ+cTQybmkYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783066256; c=relaxed/simple;
	bh=EiaySOdbvkR+eiC8a3LpsVsRCDn+4X1et9XBURX/6Qg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UAClbG4dk+XYEZLnO14GaBqQk9s9O+xCbGkIOba0VSwAg4IDwejzgne292ye4rBko6olo1HwkxbocVXwf5XsUM6cxYqoZN/FfIK1O4QH8mWDyUVH1Elxo9yYXHM8WNcNqkHBzG7WMJ17+l14wrW5eFv2Zzb6OrsUn1/Xa4gXt0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5MADvEh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5MADvEh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101CA1F00A3A;
	Fri,  3 Jul 2026 08:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783066255;
	bh=G7TF+F9obUeGCbholn/gMjoCj+h4j9n1oc7UXjNuGNM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T5MADvEhH/h/2tx17ZQk2UBB7FmDmSvBzZUtqAqMT/Y3v6mCKn7zmqOrXzfOB93Hi
	 xdFjjB2wLIpB/dquDU70RQyTA425z3Ux9IiNRjHP44wl9P1qPtlxZmOh06M4EIQpNM
	 iJYmkvVbt5Pbe3V/LAP2OyDApdmn4q2J8OdsUcr9N2XJe3DdOkvYZiLg7t7jTV/faK
	 j9PyDu87A7L62IRoPwKGU3GCuBlXBoGV8b9sEuyRx9nUl1xpL7IzXleNwQ0HdlAZw9
	 IhGYuZ1fzRcAqa9LVLg/KMwGfbfa62BbCaKdDLZUcOwKzHJufJX9hWJ2nOS2KAeDEG
	 8YTKIDMZN+rqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] HID: Intel-thc-hid: Intel-quicki2c: Refine
 recover callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Even Xu" <even.xu@intel.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260703075858.2780398-3-even.xu@intel.com>
References: <20260703075858.2780398-1-even.xu@intel.com>
 <20260703075858.2780398-3-even.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 08:10:54 +0000
Message-Id: <20260703081055.101CA1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Use-After-Free due to premature `cancel_work_sync` during device r=
emoval and shutdown.

Pre-existing issues:
- [High] Missing `pci_free_irq_vectors()` in probe error paths and device r=
emoval leaks IRQ resources.
- [High] The hard IRQ handler accesses hardware registers unconditionally, =
violating PM subsystem guidelines.
--

commit e88da9d40562f5d0be755568ae60010a7ba925df
Author: Even Xu <even.xu@intel.com>

HID: Intel-thc-hid: Intel-quicki2c: Refine recover callback

This commit refines the recover flow by offloading it to a workqueue instead
of processing it within the IRQ handler. It simplifies the operation with a
reset API and ensures interrupts are disabled during the recovery process.

> diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c b/dr=
ivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> index 46d3e9a019995..11e0e129b44c3 100644
> --- a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> +++ b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> @@ -245,28 +245,28 @@ static irqreturn_t quicki2c_irq_quick_handler(int i=
rq, void *dev_id)
>  }

[Severity: High]
This is a pre-existing issue, but does quicki2c_irq_quick_handler() access
hardware registers unconditionally?

If this device shares an INTx interrupt line, a spurious interrupt from
another device could cause quicki2c_irq_quick_handler() to execute. It then
calls thc_interrupt_enable() which writes to memory-mapped registers. If the
device is in a low-power state, this hardware access can trigger a bus faul=
t.

Should pm_runtime_get_if_active() be used to check if the device is active
before touching the hardware registers?

[ ... ]

> @@ -771,6 +771,8 @@ static void quicki2c_remove(struct pci_dev *pdev)
>  	if (!qcdev)
>  		return;
> =20
> +	cancel_work_sync(&qcdev->recover_work);

[Severity: High]
Can this sequence lead to a use-after-free?

cancel_work_sync() is called here, but hardware interrupts are not yet
quiesced, and the state is still active. If an interrupt fires immediately
after cancel_work_sync(), quicki2c_irq_thread_handler() can execute and cal=
l:

    schedule_work(&qcdev->recover_work);

This re-enqueues the work item. After quicki2c_remove() returns, devres
frees the qcdev structure. When the scheduled work later executes, it will
dereference the freed qcdev pointer.

Should the work be cancelled after interrupts are disabled and the device
state is set to QUICKI2C_DISABLED?

>  	quicki2c_hid_remove(qcdev);
>  	quicki2c_dma_deinit(qcdev);
> =20
>  	pm_runtime_get_noresume(qcdev->dev);
> =20
>  	quicki2c_dev_deinit(qcdev);
> =20
>  	pci_clear_master(pdev);
>  }

[Severity: High]
This is a pre-existing issue, but does quicki2c_remove() leak IRQ resources?

The remove path unbinds the device but doesn't appear to call=20
pci_free_irq_vectors(). Similarly, if quicki2c_probe() fails after=20
pci_alloc_irq_vectors(), the error path (disable_pci_device) does not=20
free the vectors.

Repeated unbind/bind operations or probe deferrals will continually leak
these vectors, which can eventually exhaust system IRQ capacity.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703075858.2780=
398-1-even.xu@intel.com?part=3D2
