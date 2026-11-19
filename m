Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795080248;
	b=hUoknR1S7eDIlPenreVlFzcS1Y00PlwSMevmtz3Z4XNSHX/oybvq4ZONa0bUwQup9ztP
	 8snZbDd1+WbijALTcVsHRcbs7PULX9UI/6z5JueqJtnxZnKDHswLIeIW3oYsdPb7lOTGm
	 q1IjdfFjlPd8zn96SKIj8S1wd5AnskC2u9Mq2Q0E10DhZcwgaUemoB/D2l8Ng8wmh+h/O
	 hl5n+LCeFFmXkRulVxfp6dmAxN/f/WnTt+C4/gdg2H5UCxip/lJ9hCguK/TPXoundMm09
	 JrqKO8K/VmloEqjJynsTBbivCXa0urlwO8hn6Cq54+kGqo+q4JQjAAtQw5YJrSZobeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795080248;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=p5S4ff3U7Iih3zTb8MFxt7AU60ZPX6K5IBrl1VeulkU=;
	b=ioMEXkAutjtLxS3YdYyBrFwV3Kftu7pB6M4MzGqQTRosG8cRQv/wujOlA1wNdMr5no5n
	 KK7a8SCqtyCzfmQBPyQih4i5T4V1PY4P4k3VGwza+M/ud3/eO7EDG0Y7WDuCNuXXFCO8H
	 RWBJ1daZ5nEFsJUDOihsJQSaYBFBtmqMyL+dnCGlRu4CkXHJhMGQPtdMj3OQTtHMrlFDh
	 r3S3AeTefVpIA5ZnnoiKNUQYBhL9mNCEdKmoXQLKPdL7G757l3dQVtlYAp/v3q2C8wLSJ
	 o2ZeqRCYptuvI7STn5uMegyGeEBRZCHhu2mptTqCi2OALNwhcYvFzU2AtI6u7WkYhKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kCbc1cVZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918C6606A324
	for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 09:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kCbc1cVZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C91511F000C5;
	Thu, 19 Nov 2026 09:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795080248;
	bh=p5S4ff3U7Iih3zTb8MFxt7AU60ZPX6K5IBrl1VeulkU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kCbc1cVZ1QjSHtSX6cQWDYaKZp9o5n5yEKrJChyCm/c9/VwNI703vED9x2U0iDYkq
	 P2blUlYP3FbkjGBd3DLW24vqAQFfRsp26iQCnQzzxmtD/YadEl/nkiDI7TFYUzi/q4
	 quVfuTSSRrZ+OowpU3Hq1+evyi/GDEaQmGSonpWrYi0JZg5m/V+kOL4Du+TJLxZPru
	 YZEw8z1xyORH8Rq5iuULYIA4hlmaTiJApwiS/Qi4oGmIpIMRS7jXI3JP4as7BNC7sp
	 CmKThgElKb99kg4PwY4uXJmIWK63Aj8/E5bk2V64mboLjg3Islwjj8/qkJ1LQrUG0/
	 B4Tgy3zGbMzcw==
Message-ID: <sashiko-outbox-222824@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 4/5] HID: intel-thc-hid: intel-ipts: handle system
 sleep
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emfox Zhou" <emfox@debian.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261119091152.470384-5-emfox@debian.org>
References: <20261119091152.470384-1-emfox@debian.org>
 <20261119091152.470384-5-emfox@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 09:24:07 +0000
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
- [Medium] HID: intel-thc-hid: intel-ipts: late IRQ mask in
  thc_ipts_resume()
--

commit cb9fd08378f4c4d0b714f43fe49b9631edab5ac4
Author: Emfox Zhou <emfox@debian.org>

HID: intel-thc-hid: intel-ipts: handle system sleep

This commit adds system sleep and hibernation power management callbacks for
the Intel THC IPTS PCI driver, stopping the port on suspend and restarting =
it
on resume.

> diff --git a/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c b/drivers/hi=
d/intel-thc-hid/intel-ipts/pci-ipts.c
> index 5aa0ad6fb19cb..4bf64e5359755 100644
> --- a/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c
> +++ b/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c
> @@ -143,6 +143,38 @@ static void thc_ipts_remove(struct pci_dev *pci)
>  	pci_clear_master(pci);
>  }
> =20
> +static int thc_ipts_suspend(struct device *dev)
> +{
> +	struct thc_ipts *idev =3D dev_get_drvdata(dev);
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
> +	/*
> +	 * A restore can bring the global enable back with it, as firmware
> +	 * leaves it at probe. The line is shared and level triggered, and the
> +	 * handler has nothing to mask it with until the engines are up, so
> +	 * mask it here as probe does.
> +	 */
> +	thc_interrupt_enable(idev->thc, false);
> +
> +	ret =3D thc_ipts_port_start(idev);
> +	if (ret)
> +		thc_ipts_port_stop(idev);
> +
> +	return ret;
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(thc_ipts_pm_ops, thc_ipts_suspend,
> +				thc_ipts_resume);

[Severity: Medium]
Does masking THC_M_PRT_INT_EN_GBL_INT_EN in thc_ipts_resume() happen too
late to prevent an unhandled interrupt storm on the shared line?

DEFINE_SIMPLE_DEV_PM_OPS() wires thc_ipts_resume() to .resume and .restore,
leaving .resume_noirq and .restore_noirq unset.  During resume or restore,
dpm_resume_noirq() puts the PCI device back into D0, restores PCI_COMMAND,
and calls resume_device_irqs() before .resume or .restore runs.

At that point idev->dma_ready is still false from thc_ipts_suspend() ->
thc_ipts_port_stop() -> thc_ipts_dma_stop(), so thc_ipts_hardirq() returns
without masking the controller:

drivers/hid/intel-thc-hid/intel-ipts/ipts.c:thc_ipts_hardirq() {
	if (!READ_ONCE(idev->dma_ready))
		return IRQ_NONE;

	/* Level triggered and shared: mask first, or it stays asserted. */
	thc_interrupt_enable(idev->thc, false);
    ...
}

If firmware leaves the global interrupt enable set with a pending level
interrupt across restore, the IRQ fires as soon as resume_device_irqs()
unmasks the line and repeatedly returns IRQ_NONE until the IRQ core
disables the shared line before thc_ipts_resume() is reached.  Should
thc_interrupt_enable(idev->thc, false) run in a noirq resume/restore
callback before resume_device_irqs()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119091152.4703=
84-1-emfox@debian.org?part=3D4
