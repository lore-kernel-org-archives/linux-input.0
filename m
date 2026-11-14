Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794677733;
	b=i0PKvmVRqpCVLGK9XX+bn++Jj42bI9Tno+nofr6ppQZ+CY+E+Dz01ki4AunhwQqVwLDx
	 Mo4lxnx0ijkOfV4SRIa5cQRe3LM0JOmnAbYJ2T2vjIVVbCmkmWzdsa9S0N/CoPGKUD32s
	 BcERCMwzNNCkLiqjHT0Q7REwWrl4T6ZbDRZKhna5kiIo69EkMjGNMyYif8TDKJNQ4dmV9
	 m2hlJGJ4PupzldBCfOi7B5UL5BmfvKdby4JzhKa4f1yN+yYjhvXgeKDmN4DLBoq2d9CnA
	 /gZNto2HO/xysL/fMymo8NMnNOGshaA5XANvdlqnTU9etjhRYiW3g12KDFEYq+tiWAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794677733;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HyPTryu5Bxb667UM5P5E2Ffi3pH40tIrxET+XZySsrU=;
	b=e/VTutZGONifgBySbyXiysYMsUyN5As+3ZJOOvhx2/wZ5jgYGewudG4gjzvMIDWwvI65
	 xz/DZj3lWSh/6ec2T4Tf2Tzh7dosmSkjGNlQEpkP/ZRm2Ces3RRC8GP+PFowkEO6NC+34
	 j9X8Eh0j9H7R+Wn/6BPiCeuo7vR/60uaPmKHGk/gmWr20bMox7vYlNnnv16cX+lbV+U68
	 EKKAqhrmjSR+HQ8wdTgDSgkMHStPByJBXT5jd7BoVBHo5+9fEsTAU1mF7omNp1PCziguv
	 S5T78KoxUF4X/R7cJSpQl8FzICRNTM5RmH+s2UrH+KdrwGLuqqtjQ7GVQF4h+0JZmlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cORZR8VL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5401B606A323
	for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 17:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cORZR8VL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C370B1F000C4;
	Sat, 14 Nov 2026 17:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794677733;
	bh=HyPTryu5Bxb667UM5P5E2Ffi3pH40tIrxET+XZySsrU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cORZR8VL2OiTYBLJ0/bL8a29Rt+GPOa6sE1b13NiyxpqWk5l2wWqLavzkkdH+jOqb
	 DL1QpDlXIGulset9uZ3iCx2A+DwiMex/HQvOSiPgxC5xMzapiVi76t8lF9cJEbBQrQ
	 pRJGLQ+K1CPQwVnklj161KYLAclzQGVhr3v4WrezovRKnG9ucUCF86EUQLL/WZbHX4
	 fAZvkyz81mQtoe+bZVSIE5SdiSdzo6AKpPdEE7yC7PQkLPgcCQ9nQJyaHMPkfGnsz2
	 4Y2phDLeq/i5GsTm0c9T5rxYHgC5pjF0qj2HgT0+A+VtVYYDOb/sxZlmcFatc+ToAq
	 1wilpilT+SNvA==
Message-ID: <sashiko-outbox-214845@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/5] HID: intel-thc-hid: intel-ipts: receive reports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emfox Zhou" <emfox@debian.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261114170740.2068179-3-emfox@debian.org>
References: <20261114170740.2068179-1-emfox@debian.org>
 <20261114170740.2068179-3-emfox@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 17:35:32 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] HID: intel-thc-hid: intel-ipts: shared IRQ race with
  thc_ipts_recover()
- [High] HID: intel-thc-hid: intel-ipts: IRQF_ONESHOT mismatch on shared
  INTx in thc_ipts_probe()
- [Medium] HID: intel-thc-hid: intel-ipts: unconditional IRQ_HANDLED on
  shared IRQ
- [Medium] HID: intel-thc-hid: intel-ipts: short IRQ cause drain in
  thc_ipts_thread()
--

commit 880aa0baaa53bf1b19d3aa4aff42c7d2c9c5a798
Author: Emfox Zhou <emfox@debian.org>

HID: intel-thc-hid: intel-ipts: receive reports

This commit configures the Rx and Tx DMA engines for Intel IPTS ports,
registers a shared threaded interrupt handler to receive frames, and adds a
work item to reset the receive engine after transfer errors.

> diff --git a/drivers/hid/intel-thc-hid/intel-ipts/ipts.c b/drivers/hid/in=
tel-thc-hid/intel-ipts/ipts.c
> index f139b8f9443d0..790c3eaae15f2 100644
> --- a/drivers/hid/intel-thc-hid/intel-ipts/ipts.c
> +++ b/drivers/hid/intel-thc-hid/intel-ipts/ipts.c
> @@ -20,6 +25,12 @@
>  /* Time the controller needs after reset before it answers on the bus. */
>  #define THC_IPTS_BOOT_MS		100
> =20
> +/*
> + * The core returns after the first cause it finds, so one interrupt can=
 need
> + * up to four reads: non-DMA, transaction error, overrun, then the data =
path.
> + */
> +#define THC_IPTS_IRQ_CAUSES		4

[Severity: Medium]
Is THC_IPTS_IRQ_CAUSES off by one for draining thc_interrupt_handler()?

drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c:thc_interrupt_handler()
has four separate early returns before it reaches the DMA completion checks:
non-DMA, transaction error, buffer overrun/stall, and fatal error, followed
by the data path on a fifth call.  In addition, thc_ipts_read_frames() runs
inside the loop while the port is masked, so new status bits can arrive
before the fourth pass finishes and remain unread when the handler unmasks
the port, leaving a concurrent thc_dma_write() to time out under
thc_bus_lock.

> @@ -127,6 +138,193 @@ static int thc_ipts_touch_set(struct thc_ipts *idev=
, bool enable)

[ ... ]

> +irqreturn_t thc_ipts_hardirq(int irq, void *data)
> +{
> +	struct thc_ipts *idev =3D data;
> +
> +	/*
> +	 * The pin is shared and this may be another function's interrupt; the
> +	 * cause can only be read in the thread, so claim it. Mask first, or a
> +	 * level triggered line stays asserted on the way out.
> +	 */
> +	if (READ_ONCE(idev->stopping) || !READ_ONCE(idev->dma_ready)) {
> +		thc_interrupt_enable(idev->thc, false);
> +		return IRQ_HANDLED;
> +	}
> +
> +	thc_interrupt_enable(idev->thc, false);
> +
> +	return IRQ_WAKE_THREAD;
> +}

[ ... ]

> +void thc_ipts_recover(struct work_struct *work)
> +{
> +	struct thc_ipts *idev =3D container_of(work, struct thc_ipts,
> +					     recover_work);
> +
> +	if (thc_rxdma_reset(idev->thc)) {
> +		/* Nothing left: keep the port masked until it restarts. */
> +		dev_err(idev->dev, "cannot reset the receive engine\n");
> +		return;
> +	}
> +
> +	if (!READ_ONCE(idev->stopping))
> +		thc_interrupt_enable(idev->thc, true);
> +}
> +
> +irqreturn_t thc_ipts_thread(int irq, void *data)
> +{
> +	struct thc_ipts *idev =3D data;
> +	bool recovering =3D false;
> +	int pass;
> +
> +	/*
> +	 * The port stays masked until the end of this handler, so a cause that
> +	 * arrives in between leaves only its status bit: keep reading until
> +	 * the core reports none.
> +	 */
> +	for (pass =3D 0; pass < THC_IPTS_IRQ_CAUSES; pass++) {
> +		int mask =3D thc_interrupt_handler(idev->thc);
> +
> +		/* The core reports this one when no cause is pending. */
> +		if (mask =3D=3D BIT(THC_UNKNOWN_INT))
> +			break;
> +
> +		if (mask & (BIT(THC_FATAL_ERR_INT) | BIT(THC_TXN_ERR_INT))) {
> +			dev_err(idev->dev,
> +				"transfer error, resetting the engine\n");
> +			recovering =3D true;
> +			/*
> +			 * Keep reading: the core stops at the first cause, so
> +			 * a Tx completion queued behind the error would wait
> +			 * out its timeout under the bus lock.
> +			 */
> +			continue;
> +		}
> +
> +		if (recovering)
> +			continue;
> +
> +		/*
> +		 * A non-DMA cause needs no action: the core acknowledges it,
> +		 * and this port moves report data through the DMA engines.
> +		 */
> +		if (mask & BIT(THC_RXDMA2_INT) && thc_ipts_read_frames(idev))
> +			recovering =3D true;
> +	}
> +
> +	/*
> +	 * The work item resets the engine and unmasks the port again; reading
> +	 * frames while it rewrites the ring would corrupt the descriptors.
> +	 */
> +	if (recovering) {
> +		schedule_work(&idev->recover_work);
> +		return IRQ_HANDLED;
> +	}
> +
> +	if (!READ_ONCE(idev->stopping))
> +		thc_interrupt_enable(idev->thc, true);
> +
> +	return IRQ_HANDLED;
> +}

[Severity: High]
Can a shared interrupt from another PCH function wake thc_ipts_thread() whi=
le
thc_ipts_recover() is resetting the DMA engine?

Because recovering is only a local variable in thc_ipts_thread(), idev->sto=
pping
remains false and idev->dma_ready remains true after recover_work is
scheduled.  When another device on the shared INTx line fires an interrupt:

irq/idev->irq                     kworker
thc_ipts_thread()
  recovering =3D true
  schedule_work(&recover_work)
  return IRQ_HANDLED
                                  thc_ipts_recover()
                                    thc_rxdma_reset(idev->thc)
                                      thc_dma_unconfigure()
<shared INTx from another device>
thc_ipts_hardirq()
  return IRQ_WAKE_THREAD
thc_ipts_thread()
  thc_ipts_read_frames()
    thc_rxdma_read()              <-- races with thc_rxdma_reset()
  thc_interrupt_enable(..., true) <-- unmasks port mid-reset

If no THC cause is pending during that foreign interrupt, thc_ipts_thread()
sees BIT(THC_UNKNOWN_INT) with recovering =3D=3D false and calls
thc_interrupt_enable(idev->thc, true), unmasking the port while
thc_rxdma_reset() is reconfiguring the PRD tables or after thc_rxdma_reset()
has failed.

[Severity: Medium]
Should thc_ipts_hardirq() and thc_ipts_thread() return IRQ_NONE when no
interrupt came from this controller?

In thc_ipts_hardirq(), returning IRQ_HANDLED while idev->stopping is true or
idev->dma_ready is false (such as during the 100 ms boot delay in
thc_ipts_port_start() after the IRQ is requested) claims every shared
interrupt on the line.  Likewise, when a foreign device triggers the shared
INTx line during normal operation and thc_ipts_thread() breaks out on
pass =3D=3D 0 with BIT(THC_UNKNOWN_INT), returning IRQ_HANDLED increments
desc->threads_handled and prevents note_interrupt() in kernel/irq/spurious.c
from detecting a screaming unhandled interrupt on the shared line.

> diff --git a/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c b/drivers/hi=
d/intel-thc-hid/intel-ipts/pci-ipts.c
> index 48046cd1212a6..5342cf25224fb 100644
> --- a/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c
> +++ b/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c
> @@ -77,10 +78,38 @@ static int thc_ipts_probe(struct pci_dev *pci, const =
struct pci_device_id *id)
>  	if (IS_ERR(idev->thc))
>  		return PTR_ERR(idev->thc);
> =20
> +	/*
> +	 * Interrupt remapping rejects the MSI requests these ports send, so
> +	 * take the legacy pin (shared with other functions on the PCH, hence
> +	 * IRQF_SHARED); MSI is only for a platform that routes no pin.
> +	 */
> +	ret =3D pci_alloc_irq_vectors(pci, 1, 1, PCI_IRQ_INTX);
> +	if (ret < 0) {
> +		dev_warn(idev->dev, "no interrupt pin, falling back to MSI\n");
> +		ret =3D pci_alloc_irq_vectors(pci, 1, 1,
> +					    PCI_IRQ_MSI | PCI_IRQ_MSIX);
> +	}
> +	if (ret < 0) {
> +		dev_err(idev->dev, "no interrupt vector, error %d\n", ret);
> +		return ret;
> +	}
> +
> +	idev->irq =3D pci_irq_vector(pci, 0);
> +
> +	ret =3D devm_request_threaded_irq(idev->dev, idev->irq, thc_ipts_hardir=
q,
> +					thc_ipts_thread,
> +					IRQF_ONESHOT | IRQF_SHARED,
> +					KBUILD_MODNAME, idev);

[Severity: High]
Does requesting the shared INTx line with IRQF_ONESHOT | IRQF_SHARED fail w=
ith
-EBUSY when another PCH driver shares the pin?

__setup_irq() requires all actions on a shared IRQ line to agree on
IRQF_ONESHOT:

kernel/irq/manage.c:__setup_irq() {
    ...
		if ((old->flags & IRQF_ONESHOT) &&
		    (new->flags & IRQF_COND_ONESHOT))
			new->flags |=3D IRQF_ONESHOT;

		if (!((old->flags & new->flags) & IRQF_SHARED) ||
		    ((old->flags ^ new->flags) & IRQF_TRIGGER_MASK) ||
		    ((old->flags ^ new->flags) & IRQF_ONESHOT))
			goto mismatch;
    ...
}

Other PCH drivers that share legacy INTx pins (such as intel-lpss, i2c-i801,
intel-ish-hid, or mei_me) register without IRQF_ONESHOT, so
devm_request_threaded_irq() returns -EBUSY if any of them probed first (or
causes a later threaded-IRQ driver like mei_me to fail with -EBUSY if
intel-ipts probed first).  Since thc_ipts_hardirq() already masks the port
interrupt in hardware via thc_interrupt_enable(idev->thc, false), IRQF_ONES=
HOT
can be dropped (or replaced with IRQF_COND_ONESHOT).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114170740.2068=
179-1-emfox@debian.org?part=3D2
