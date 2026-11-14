Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794682965;
	b=NEXcxt6zIdTl6a8xcEeoE3+itnjW+c/9Xfy1XvJtLp80BYPF0pReyFHKqEf+qokEnvZ+
	 j/j+CIogHrxwHKbaM8GJ5YpJeslZ84TPaQ+YPDhJiLMBU/ILstP89nhlTQKguz5IfMAv6
	 IMa5F5G9L793rMHb9Dp7epqs0s3KWNxvMZ+j08TMyaCn3fKd4IfhjUWfqn6oCN5kij/Sc
	 5OrbKmmTNeTh7JToHL9wfjdlVGIWCX0KsOP2xebgoKL74aFq/fcpB3wW0UvPgdNIRwr5B
	 aG50klOVaW9HaovhFdF5usEFxsqdBxWnRnVNpIpi1NQ4q0zHOe67XYK7zmvMXGQZDTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794682965;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8mokk7B0FtBvm+9nXFmabLsg9pog0CvKvgyVs8xGT+8=;
	b=B0OitO51VOFbyAe8gDehan832BXeC6an4bvsa4Aejs6IsF5akysFiHALRGtWNa0wHxlW
	 ntD4cPBZ1iksH36Uvav9sGMeVIZ1Z+INiCVxiEpWGUUzPce2VuPFYMjXYH2rhVVbqEW4o
	 u4kTl8Za5YIArYe3MUrdagkbcknUEtZEg7FzMu1D+dQFtc7HwCigpDA/WjcdX3zok1gZD
	 R8Hkb17w/Lj5Kq+61qUkICZbMrUUaRIxdDPPRVzHu3ZpFHqUKPBJSYu3fy4G1fsadIf2t
	 d0qvkA4MJodM/BUNYLYQYleuPcTD8jrNz3l2626ANZ8M70Qcd7MHktyFYqHN/Ioo4Rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hc+j16cC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4024606A339
	for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 19:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hc+j16cC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6449D1F000C5;
	Sat, 14 Nov 2026 19:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794682964;
	bh=8mokk7B0FtBvm+9nXFmabLsg9pog0CvKvgyVs8xGT+8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hc+j16cCqgbJqDpd7/VlVVCHIsdL8VFquE7eLNrx/LcxXXjvZEPoRWsuQnjFziS75
	 dgSnUPcWttGbfw9kwuQQGhgJdWbKhSiJfIAq7BpizUn74SszhH/BPkZXZ70PAunXIm
	 2Mi11wiI/+xX3RpkLCZGqMkPkDj2Y/PrI1gOUODIhX2bCQszp2xUItv50daPEuUHlH
	 a21uB/je90sVKJ9AwDCtyjqAWixR1FsxregpBFBWEGNcTD7LOqUAbZh04ay+EauwTS
	 bEW1uvLQLaXXpcKHVIF12EG26c4T5/GO2E7jj9i/HyVNPFrpWatyIQjW1cjal73ZKz
	 BqhbJQCOZfJfA==
Message-ID: <sashiko-outbox-214937@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/5] HID: intel-thc-hid: intel-ipts: handle system
 sleep
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emfox Zhou" <emfox@debian.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261114183624.2379573-5-emfox@debian.org>
References: <20261114183624.2379573-1-emfox@debian.org>
 <20261114183624.2379573-5-emfox@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 19:02:43 +0000
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
- [Medium] HID: intel-thc-hid: intel-ipts: race in thc_ipts_port_stop()
  re-enables IRQ
--

commit c33cb8e49648df90b4589c66ad8cc8769f40b6b6
Author: Emfox Zhou <emfox@debian.org>

HID: intel-thc-hid: intel-ipts: handle system sleep

This commit adds system sleep and resume callbacks to the intel-ipts PCI
driver by stopping and restarting the port across suspend and resume.

> diff --git a/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c b/drivers/hi=
d/intel-thc-hid/intel-ipts/pci-ipts.c
> index 8f8db21df8250..81a46149be2e9 100644
> --- a/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c
> +++ b/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c
> @@ -142,6 +142,41 @@ static void thc_ipts_remove(struct pci_dev *pci)
>  	pci_clear_master(pci);
>  }
> =20
> +/*
> + * The controller forgets the streaming mode and hidraw cannot ask user =
space
> + * to repeat itself, so the port is taken down and rebuilt: the HID devi=
ce
> + * comes back and the daemon restarts with it.
> + */
> +static int thc_ipts_suspend(struct device *dev)
> +{
> +	struct thc_ipts *idev =3D dev_get_drvdata(dev);
> +
> +	if (!idev)
> +		return -ENODEV;
> +
> +	thc_ipts_port_stop(idev);

[Severity: Medium]
Can thc_ipts_port_stop() race with thc_ipts_thread() or thc_ipts_recover()
and leave THC interrupts enabled across suspend and resume?

CPU0                                     CPU1
thc_ipts_suspend()
  thc_ipts_port_stop()
                                         thc_ipts_thread()
                                           if (!READ_ONCE(idev->stopping))
    WRITE_ONCE(idev->stopping, true);
    thc_interrupt_enable(idev->thc, false);
                                             thc_interrupt_enable(idev->thc=
, true);
    synchronize_irq(idev->irq);
    cancel_work_sync(&idev->recover_work);

thc_ipts_port_stop() masks interrupts before synchronize_irq() and
cancel_work_sync(), and does not mask them again after those calls finish.
If the IRQ remains registered across suspend and resume and the controller
raises an interrupt during thc_ipts_touch_set() or during
thc_ipts_resume() -> thc_ipts_port_start() before idev->dma_ready is set,
thc_ipts_hardirq() sees idev->stopping or !idev->dma_ready and returns
IRQ_NONE without clearing the hardware status bits:

drivers/hid/intel-thc-hid/intel-ipts/ipts.c:thc_ipts_hardirq() {
	struct thc_ipts *idev =3D data;

	if (READ_ONCE(idev->stopping) || !READ_ONCE(idev->dma_ready))
		return IRQ_NONE;
    ...
}

Calling thc_interrupt_enable(idev->thc, false) again after
synchronize_irq() and cancel_work_sync() in thc_ipts_port_stop() would
ensure interrupts stay masked once both contexts have exited.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114183624.2379=
573-1-emfox@debian.org?part=3D4
