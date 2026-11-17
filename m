Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794902779;
	b=3gplH3cfmjf3k1w7vb8eIS3xOmJV70jCbrXpF95pIcoTbgoDaBOMXnl91If/Mt2UYooQ
	 1lC/+PN2sM9J8Hrnd+OYlFAJNdvY3qwjEQ5J+lHQVZgWw9Nm40zB6j1kR9yD59rbFZmdE
	 kfZiPIK4apKOFh2njvb27ROPoVZKHxpEOFMS0O5Rqy2PJQswTDVOluMIzxBjcrqqUHSr+
	 jzN0lESW/qVZlGIthNandx/TlUR+pK9SnSWdwvI9tU0JUR6qwA4u2uyjHZBAHtCLsd1bm
	 vJSNhnUuJVOZ27y2Vd6Ak9ISfmrr2ShHIBUa1RCJBL8zKwm/p5FFpCLx9yePr8ISViA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794902779;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TDUoOQsBhtBXfSTQH+McKnL7M016wxTfnNqDjnap6O8=;
	b=a82uRFC9NPzr36uBad9M3ej/WbgoFEB4NX5ZnbdDGPeWxtaGbQkXoiQoxviSBchOz7c4
	 3nRWZwb+vE1y5QRlPV7AQ4jV0G5CV95aQ5VsQcqafJB0pufb+QqC16j4FSyMVXcR6o5hS
	 w1sLh2dAIeQ5mxaABz3T0kqbXasnIG3y5B3UYZjZNWTzA9h8GraE+RejBSbrGQRAKNSRo
	 4LXBV0yDOTn17fwWYHYI0hoIa0qW5fMgZ9+WVBhK+pKsJt+QnrXJqdYvvA/onKjoSRCwu
	 G+wGKw8CtRTbyW3WwWWxeMYNV0dsfDxBMwcsnNAJW6dZHVrIKRmiqDG94O+7KqhNtWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fgYaEVYN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C228606A329
	for <linux-input@vger.kernel.org>; Tue, 17 Nov 2026 08:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fgYaEVYN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7FB41F000C5;
	Tue, 17 Nov 2026 08:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794902779;
	bh=TDUoOQsBhtBXfSTQH+McKnL7M016wxTfnNqDjnap6O8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fgYaEVYNnwPsILdAR0SqZ65p0GWkY2eabQkF7p3yFvmBf1msG3RukJGTbRk8PxE0w
	 /qrMkQ2CNDxop6NhFy+L3xAJ+W8/VNOPwWv2L4q7isykb11/VshMOFET+T6UdPNcse
	 jT6phpOCjw0yUtzFlcpp4gaBU2SZWN7N5FzeScaD6t4QAoOnNgk+zguRyqufftebpb
	 RpXt57QIyNbDgF9jWcr9UkhjMvt6iAXSLmuW6b3jyKZkz1jZ1xsjEa10QlnsJK6kB5
	 eb07In8ObQti/VkwLdEgnYiF9Q/bUjWKrjf2n7wgmSr4FPZkpcNARsh9srSWkS5zS2
	 S/4+t0UbNn0Eg==
Message-ID: <sashiko-outbox-218395@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/5] HID: intel-thc-hid: intel-ipts: handle system
 sleep
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emfox Zhou" <emfox@debian.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261117073554.11557-5-emfox@debian.org>
References: <20261117073554.11557-1-emfox@debian.org>
 <20261117073554.11557-5-emfox@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 08:06:18 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] HID: intel-ipts: premature synchronize_irq() in
  thc_ipts_port_stop()
--

commit ecbcb8810dc8ab842baead9bb9c79da3060e7ca1
Author: Emfox Zhou <emfox@debian.org>

HID: intel-thc-hid: intel-ipts: handle system sleep

This commit adds system sleep PM callbacks that stop the IPTS port and
remove its HID device on suspend, then restart the port and recreate the
HID device on resume.

> diff --git a/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c b/drivers/hi=
d/intel-thc-hid/intel-ipts/pci-ipts.c
> index 46934ac79bbc8..1426e52e831c4 100644
> --- a/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c
> +++ b/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c
> @@ -134,6 +134,40 @@ static void thc_ipts_remove(struct pci_dev *pci)
>  	pci_clear_master(pci);
>  }
> =20
> +/*
> + * The controller forgets the streaming mode, so the port is torn down a=
nd
> + * rebuilt: the HID device comes back and the daemon restarts with it.
> + */
> +static int thc_ipts_suspend(struct device *dev)
> +{
> +	struct thc_ipts *idev =3D dev_get_drvdata(dev);
> +
> +	if (!idev)
> +		return -ENODEV;
> +
> +	thc_ipts_port_stop(idev);
> +
> +	return 0;
> +}
> +
> +static int thc_ipts_resume(struct device *dev)
> +{
> +	struct thc_ipts *idev =3D dev_get_drvdata(dev);
> +	int ret;
> +
> +	if (!idev)
> +		return -ENODEV;
> +
> +	ret =3D thc_ipts_port_start(idev);

[Severity: Medium]
Can a threaded IRQ handler woken during thc_ipts_port_stop() still be
pending when thc_ipts_resume() calls thc_ipts_port_start()?

Unlike thc_ipts_remove(), which calls devm_free_irq() right after
thc_ipts_port_stop(), suspend and resume keep the shared IRQ registered.
In thc_ipts_port_stop(), synchronize_irq() runs while idev->dma_ready is
still true, and idev->dma_ready is only cleared later inside
thc_ipts_dma_stop() with no synchronize_irq() after it.

If a shared interrupt fires in that window and suspend aborts before
dpm_suspend_noirq() (so suspend_device_irqs() never drains the line),
thc_ipts_thread() can run after thc_ipts_port_start() clears
idev->stopping:

CPU0                              CPU1
thc_ipts_suspend()
  thc_ipts_port_stop()
    WRITE_ONCE(idev->stopping, true)
    thc_interrupt_enable(..., false)
    synchronize_irq(idev->irq)
    ...
    thc_ipts_touch_set(..., false)
                                  <hardirq>
                                  thc_ipts_hardirq()
                                    READ_ONCE(idev->dma_ready) =3D=3D true
                                    return IRQ_WAKE_THREAD
    thc_ipts_dma_stop()
      WRITE_ONCE(idev->dma_ready, false)
      thc_dma_release()
...
thc_ipts_resume()
  thc_ipts_port_start()
    WRITE_ONCE(idev->stopping, false)
    msleep(THC_IPTS_BOOT_MS)
                                  thc_ipts_thread()
                                    READ_ONCE(idev->stopping) =3D=3D false
                                    thc_ipts_read_frames() /
                                    thc_interrupt_enable(..., true)
                                      <-- runs before DMA is set up

The lingering thread can then unmask THC interrupts early or attempt DMA
reads or recovery while DMA buffers are unallocated.  Clearing
idev->dma_ready before synchronize_irq() (or calling synchronize_irq()
again after clearing idev->dma_ready) would ensure no threaded handler
remains queued after thc_ipts_port_stop().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117073554.1155=
7-1-emfox@debian.org?part=3D4
