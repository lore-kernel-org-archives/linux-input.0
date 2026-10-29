Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793269283;
	b=GFFlUG8fPcWF5zeoIHsmBu059yIIOuLuE0Y4BVPxqXNc11d5XHcSQJRRE3Hf/B4WgCT5
	 ojhrPrrU3trB1g1EgHuy2WgZkX3A4olHB1N1z0mjJw4V+5WrQouzvFisviJ6i8Minh13V
	 wo/4hS+ei65bU4t0gee3z6+AbY9dTDN2g+tanxPPX4a8YrZs3gKjm/d9Ei7PH+UNJhmHB
	 JPp7lzkdQ7luTc+lNbbV9eYag9B7izXspY+z/SqGpzhtwB9aOT0Ml7RwqSDyNXOPWyoRe
	 S7bD/a8zYIpC/LXLLcx6qjxsdcnPMsxct6hIU1+jyIeafxta+GSbe4BuRsc/ZMvoQqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793269283;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5YOfeKqsJ6UIlUZa8Twb8YE/HvF3w/5fU5ttJFp47WM=;
	b=L24BrlBsZo0mXAG+tMKmx/vM3bBkevH2BeQb24BK96V1dNkD4gc/26HDvqLNoke6tTXN
	 0ivQVHBgrIFuClyTe7pk3AuTfHhb6wVD4xoDGPuKAljd/DBGZnETKncfr/5l4DHmuOX03
	 SgdffqOypP+5wXNMHD+/E/77BWv7vDI4IoTpsh01psgAobYOG4sV6TwB9pcSc8mBpURie
	 eEXh6cRvX1WBPNJ7AXkGDQS1r7sVXpe6NEA+eP7kyFVwFnQ2I8pU4BplpsSOTqgAkyg4D
	 efA9V2rsxiqroHg5HJCWcn2w/78g/Hw3Hf+rXJMG3GAcTIHrbUaBpWnog59EKvQbg5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n0u4s8L1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D38606A31D;
	Thu, 29 Oct 2026 10:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n0u4s8L1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905161F031E1;
	Thu, 29 Oct 2026 10:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793269282;
	bh=5YOfeKqsJ6UIlUZa8Twb8YE/HvF3w/5fU5ttJFp47WM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n0u4s8L16SC1PjNUFpJnMxDjH+6Sh39L1ogHY5kH350k35lmuJstRncWI/ZmveCnJ
	 EbrcjaSnC0hFZODjmHTtNEPaXVN8LOrOlCTUkS2JOoXdXzHTe16/5cA8MsFFBleVJq
	 bUQVMpU9x7AzUxseOsaCeSSehpT5RsS+XFAhAgRI0pv2Mhr0zSIc1BcV6P/ooWo23Z
	 lrYtDR7kmAXV8NR//c8mw3JIPV2azRP0MaRTRFXm6VIsL5j9AY1Xl7IteIwinzvc6v
	 5Pjrhei3bwedCY1Sq27V+r+rRM9BgDZwSGigIMZnfDyU6GkReoJgHOvZpm1q+buI4B
	 ZvZMWQ6RVYU8g==
Message-ID: <sashiko-outbox-189114@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] mfd: rk8xx-core: keep the PMIC interrupt disabled
 during system suspend
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jakob Unterwurzacher" <jakobunt@gmail.com>
Cc: linux-input@vger.kernel.org, mfd@lists.linux.dev, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com, lee@kernel.org
In-Reply-To: <20261029-dev-tiger-v7-4-pre-20261028-tiger-suspend-b4-v1-2-cb12621c1fb4@cherry.de>
References: <20261029-dev-tiger-v7-4-pre-20261028-tiger-suspend-b4-v1-0-cb12621c1fb4@cherry.de>
 <20261029-dev-tiger-v7-4-pre-20261028-tiger-suspend-b4-v1-2-cb12621c1fb4@cherry.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 10:21:22 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] mfd: rk8xx-core: disable_irq() in rk8xx_suspend() breaks s2idle wa=
keup
--

commit 1642fdff105aee2817fbf318588a972d4d3d49a4
Author: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>

mfd: rk8xx-core: keep the PMIC interrupt disabled during system suspend

This commit disables the PMIC interrupt at the end of rk8xx_suspend() and
re-enables it at the start of rk8xx_resume() so that wakeup interrupts are
not handled before the parent bus controller has resumed.

> diff --git a/drivers/mfd/rk8xx-core.c b/drivers/mfd/rk8xx-core.c
> index 3dcf6abfda74f..3a68a7974ed06 100644
> --- a/drivers/mfd/rk8xx-core.c
> +++ b/drivers/mfd/rk8xx-core.c

[ ... ]

> @@ -929,7 +931,20 @@ int rk8xx_suspend(struct device *dev)
>  		break;
>  	}
> =20
> -	return ret;
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Keep the interrupt disabled while the bus to the PMIC may be
> +	 * suspended: otherwise a wakeup event (e.g. the power key) is handled
> +	 * as soon as interrupts are re-enabled on resume, before the bus has
> +	 * resumed, and reading/acking the interrupt status fails. If the
> +	 * interrupt is a wakeup source, it stays armed, and the pending event
> +	 * is replayed by enable_irq() on resume.
> +	 */
> +	disable_irq(rk808->irq);

[Severity: High]
Does calling disable_irq(rk808->irq) in rk8xx_suspend() break wakeup from
suspend-to-idle (s2idle) on Rockchip platforms?

On Rockchip SoCs, the PMIC interrupt parent is the Rockchip GPIO irqchip in
drivers/gpio/gpio-rockchip.c, which implements rockchip_irq_disable() to ma=
sk
the pin in hardware and does not set the irqchip wakeup-on-suspend flag:

drivers/gpio/gpio-rockchip.c:rockchip_irq_disable() {
	irq_gc_mask_set_bit(d);
}

When disable_irq(rk808->irq) runs during dpm_suspend() -> rk8xx_suspend(),
it invokes __disable_irq() -> irq_disable() -> __irq_disable() ->
rockchip_irq_disable(), masking the interrupt line in the GPIO int_mask
register and marking the descriptor disabled.

Later in dpm_suspend_noirq() -> suspend_device_irqs(),
kernel/irq/pm.c:suspend_device_irq() only re-enables a disabled wakeup
interrupt in the irqchip if that flag is set on the chip:

kernel/irq/pm.c:suspend_device_irq() {
	if (irqd_is_wakeup_set(irqd)) {
		irqd_set(irqd, IRQD_WAKEUP_ARMED);

		if ((chipflags & IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND) &&
		     irqd_irq_disabled(irqd)) {
			__enable_irq(desc);
			irqd_set(irqd, IRQD_IRQ_ENABLED_ON_SUSPEND);
		}
}

During suspend-to-RAM, syscore_suspend() subsequently runs irq_gc_suspend()=
 ->
rockchip_irq_suspend(), which writes ~gc->wake_active to int_mask:

drivers/gpio/gpio-rockchip.c:rockchip_irq_suspend() {
	struct irq_chip_generic *gc =3D irq_data_get_irq_chip_data(d);
	struct rockchip_pin_bank *bank =3D gc->private;

	bank->saved_masks =3D irq_reg_readl(gc, bank->gpio_regs->int_mask);
	irq_reg_writel(gc, ~gc->wake_active, bank->gpio_regs->int_mask);
}

However, during suspend-to-idle, kernel/power/suspend.c:suspend_enter() ent=
ers
s2idle_loop() and jumps to Platform_wake without calling syscore_suspend():

kernel/power/suspend.c:suspend_enter() {
	if (state =3D=3D PM_SUSPEND_TO_IDLE) {
		s2idle_loop();
		goto Platform_wake;
	}
}

Wouldn't that leave rk808->irq masked in the GPIO hardware throughout
s2idle_loop(), preventing the PMIC power key or RTC alarm from waking the
system from s2idle?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-dev-tiger-=
v7-4-pre-20261028-tiger-suspend-b4-v1-0-cb12621c1fb4@cherry.de?part=3D2
