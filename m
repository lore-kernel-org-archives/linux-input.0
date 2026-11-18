Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794986222;
	b=WQUV0o/7mHQ7n9n/r3U4HB+uRbMqJzpU+1OcsNbW1mlSdQJ5ZZDsB6SM8+XOnpUfiG6a
	 ADzcObfXSHrJX8I66jvYlrsSF+3xBM+CfylGq7jP8eDwwpwTRH5auoeLtUzfEW7lOjhPX
	 OyKBzuxezzzTQdH6bbTUaecVWba74d4duJq+qp7+fgq4EK6JjgbB7y5+zzItUaP+ujKHc
	 oXA8yEAK1frAB88kcISAWx07V1gXfuaSLuBUXn4MOThImEBCtjIkxPrn8Qx7uELNunilc
	 P1ULWCAgvSrDd0BowFT6F4fT+E5AdZhrtHxwTSTfiN6FwsXjdVGMiRom59XFTeTxgFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794986222;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0Mk95UBh9zyfxPVpt62kCNaNOvOTdsjQH2Pxb1GaxQ0=;
	b=EC4y5vutW6q13BJRQkG0/Pmw5rHoQjRyseXBf3jljc528ql+UZuz8Ey10wAWrTMgKZqj
	 lbjBWinkqNB9sA7LI6ULxgSTX/KEk1jKVOhj2+lE692FwVyVv6UwbpqROkPFekwqU5ms3
	 nfvBxggo5MUT7cbUHzLngBnjv+rHNrfqHw/yIR2ebYEvFS5bvTwW9v8VDI0M3M/wQEuOT
	 Rgg5kTzV7hPHoMQkCRSj5amPImEiHV+Qpz7kt8EFoDpcWdOT3OkXVGPrv8yLK8KLiDjzG
	 HJecqYgpQy1FnXkmjCzeWre+CPU5awfKOjJZjUN1TKGBfzXhZy9glToNaOBMRwOk0yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VtdKmino;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FB4606A31C
	for <linux-input@vger.kernel.org>; Wed, 18 Nov 2026 07:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VtdKmino
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 207511F000C4;
	Wed, 18 Nov 2026 07:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794986222;
	bh=0Mk95UBh9zyfxPVpt62kCNaNOvOTdsjQH2Pxb1GaxQ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VtdKminoVzZSNOdw/1Rl3RiXr10I3jKg1cFGQKSKqWaKrctVON1cPl23maLgZ76rf
	 OPLnZASn3M+ML58D66SORC4DM5weJcRq5oZ3SlJB+GiNdhSWLJLLcGiHbvh2VlpW5F
	 Og7vAMqqJt5cjlXmf0JuX5tDD2FvagwM4/NXM9Uf3AzZx16OD+qcg0Jkc8p3M9Vm57
	 rXN2IVDs3hf5VFuacQAEUsHIZAA8V1QzzXgxwOD/RtzH50aT6xQ7eduoQTYG8396OB
	 OI5h8pMwRRCUyTPdSGAPZYvB2t6wiWw2LoiOkC6pMzm4hyIUSzZ/95cAkdsiVg6m/b
	 kGuJBXJ6muuvg==
Message-ID: <sashiko-outbox-220300@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 4/5] HID: intel-thc-hid: intel-ipts: handle system
 sleep
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emfox Zhou" <emfox@debian.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261118065725.673090-5-emfox@debian.org>
References: <20261118065725.673090-1-emfox@debian.org>
 <20261118065725.673090-5-emfox@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 07:17:01 +0000
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
- [Medium] HID: intel-thc-hid: intel-ipts: unmasked IRQ in
  thc_ipts_resume()
--

commit 94ab9ee55e7317c455856236882094712be26a95
Author: Emfox Zhou <emfox@debian.org>

HID: intel-thc-hid: intel-ipts: handle system sleep

This commit adds system sleep and hibernation power management callbacks for
the intel-ipts PCI driver by stopping the port on suspend and restarting it=
 on
resume.

> diff --git a/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c b/drivers/hi=
d/intel-thc-hid/intel-ipts/pci-ipts.c
> index 5aa0ad6fb19cb..b2d9be4eef248 100644
> --- a/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c
> +++ b/drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c
> @@ -143,6 +143,30 @@ static void thc_ipts_remove(struct pci_dev *pci)
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
> +	ret =3D thc_ipts_port_start(idev);
> +	if (ret)
> +		thc_ipts_port_stop(idev);
> +
> +	return ret;
> +}

[Severity: Medium]
Should thc_ipts_resume() mask interrupts with thc_interrupt_enable(idev->th=
c,
false) before calling thc_ipts_port_start(), just as thc_ipts_probe() does?

Across system sleep or hibernation restore, firmware can leave the global
interrupt enable set while idev->dma_ready is false (cleared during
thc_ipts_port_stop()).  During thc_ipts_port_start(), the controller is
released from reset, unquiesced, and has touch and DMA enabled before
thc_ipts_dma_start() sets idev->dma_ready to true:

drivers/hid/intel-thc-hid/intel-ipts/ipts.c:thc_ipts_hardirq() {
	/* Nothing of ours is pending: the cause belongs to a sharer. */
	if (!READ_ONCE(idev->dma_ready))
		return IRQ_NONE;

	/* Level triggered and shared: mask first, or it stays asserted. */
	thc_interrupt_enable(idev->thc, false);
}

If the port asserts the shared level-triggered interrupt before
idev->dma_ready becomes true, thc_ipts_hardirq() returns IRQ_NONE without
masking the line, causing an unhandled interrupt storm that disables the
shared IRQ vector.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118065725.6730=
90-1-emfox@debian.org?part=3D4
