Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116426;
	b=zAIGB38fTMmeKn5mQTmCjstH7bSz+msJfb9Fz7Ku2rWajn9Ht2Ml5c295TC5ypnH4Jhb
	 Fi9fwY39pwwQPVF0jr0Pgpv1221AMX7g09DQW4BaiGzlj3Y+ngd9K4sFVD2JoRJK6ITCQ
	 DFlJ4wLmLMTOiNCf3PHOMlXlYJyFJpBYStV/yp/iRR5cnBQAi+f+Zz5kZUydFmdVC5H3j
	 tttuNjF+IkycVleyye5bSGmuKKrJgtVZNYenpigOSUARsymN35Lpf3xv66mWEvkd5XSsC
	 u0s6kMOYT2HWTeQBDBxmkmAP5YX7YUfHHqbW7jbTtKkvyglQWmFcrieufEGmbKBMOtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116426;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-AI-Review-Draft;
	bh=qHLkF6tVlZ+i0QFCbA67HWU+g83dxZTEV5zaNmKwHJw=;
	b=LgY7pxH7Kx09FTyuntsqirgKOWOFx3IGNr3bSkPSyGFbPJb5QHPF3VBy+tlvDmFu6wN4
	 8hHPms5WC0i7c8uVJkGtx90VZgI7VZqv/uLdBwtsotBOtbbA6KDBzdDcfOIBKU+kl4Yz0
	 58ekjM+EGPHIODScrlLvL0KL+slPhs5P6j01lJrwsHGRLKQsS5u3qcDA+9K65z1i5IoA7
	 bzz+RSMU79ubUhYkkgr7a3oiVGhAyTI5Wout2MRbKRnhUOvLD4YuPvUlkfrqtAJwVJOby
	 FpCbe5rIsfgXYpOaEoWRPsrHNIVxFDSeyDtb+aFT3Od/7O2vu/sB9YlMLdPBStzuvdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="AwmWQL/v";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCD6606A32C;
	Thu, 19 Nov 2026 19:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AwmWQL/v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC1071F000C8;
	Thu, 19 Nov 2026 19:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795116425;
	bh=qHLkF6tVlZ+i0QFCbA67HWU+g83dxZTEV5zaNmKwHJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AwmWQL/v/ILoQCm/U7h+szaU1lXZ97cfrHmUU/UJY4ndFIy3jRXc1LnA6fqPFTvCm
	 ke2KBzPrsmNVGkAgIWvoGYMmU7USgqhecOiyiV72n/3XZG9dKGAKT3/GUUa9R1DYUZ
	 4ATP93XyuGRLJGK80xRLfrKBNZzyYswx15FmcgsaQLKUJOU7m5ObEOa9egP9mrcwQ5
	 f7f3xN5weFYaRmraMcSM5QS06LtBY9BreGaz+MLrVZhi8OfAIFhDI5Jg2d7yUY0frl
	 ma2GHg5sBYzHkllBEiNfhAjpX3nzOEcuXbmo6lyX6bG42UVAAdgjtqBWX+MeyJXhEV
	 0icLKCkVOT3aA==
Date: Thu, 19 Nov 2026 19:27:00 +0000
From: Lee Jones <lee@kernel.org>
To: Jakob Unterwurzacher <jakobunt@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Joseph Chen <chenjh@rock-chips.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, mfd@lists.linux.dev,
	devicetree@vger.kernel.org,
	Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
Subject: Re: [PATCH 2/4] mfd: rk8xx-core: keep the PMIC interrupt disabled
  during system suspend
Message-ID: <179510313469.63755.466425546513135743@kernel.org>
References: <20261029-dev-tiger-v7-4-pre-20261028-tiger-suspend-b4-v1-0-cb12621c1fb4@cherry.de>
 <20261029-dev-tiger-v7-4-pre-20261028-tiger-suspend-b4-v1-2-cb12621c1fb4@cherry.de>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029-dev-tiger-v7-4-pre-20261028-tiger-suspend-b4-v1-2-cb12621c1fb4@cherry.de>
X-AI-Review-Draft: <20261029-dev-tiger-v7-4-pre-20261028-tiger-suspend-b4-v1-2-cb12621c1fb4@cherry.de>

> From: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
>
> When the system is woken up by the PMIC (e.g. by the power key), the
> PMIC interrupt is handled as soon as interrupts are re-enabled on
> resume. At that point, the bus to the PMIC may not have resumed yet, so
> reading and acking the interrupt status fails. On RK3588 with an RK806
> on SPI:
>
>   spi_master spi2: noqueue transfer failed
>   rk8xx-spi spi2.0: Failed to ack 0x79: -13
>
> Disable the interrupt at the end of rk8xx_suspend() and re-enable it at
> the start of rk8xx_resume(). Both run in the regular suspend/resume
> phase, while the parent bus controller is active. If the interrupt is a
> wakeup source, it stays armed while disabled, and the pending event is
> replayed by enable_irq() on resume.
>
> Store the interrupt number in struct rk808 for this.

SoB?

> ---
>  drivers/mfd/rk8xx-core.c  | 19 ++++++++++++++++++-
>  include/linux/mfd/rk808.h |  1 +
>  2 files changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mfd/rk8xx-core.c b/drivers/mfd/rk8xx-core.c
> index 21182df45d1b6..2ae9107fc5161 100644
> --- a/drivers/mfd/rk8xx-core.c
> +++ b/drivers/mfd/rk8xx-core.c
> @@ -851,6 +851,8 @@ int rk8xx_probe(struct device *dev, int variant, unsigned int irq, struct regmap
>  	if (!irq)
>  		return dev_err_probe(dev, -EINVAL, "No interrupt support, no core IRQ\n");
>
> +	rk808->irq = irq;
> +
>  	ret = devm_regmap_add_irq_chip(dev, rk808->regmap, irq,
>  				       IRQF_ONESHOT | dual_support, -1,
>  				       rk808->regmap_irq_chip, &rk808->irq_data);
> @@ -929,7 +931,20 @@ int rk8xx_suspend(struct device *dev)
>  		break;
>  	}
>
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
> +
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(rk8xx_suspend);
>
> @@ -938,6 +953,8 @@ int rk8xx_resume(struct device *dev)
>  	struct rk808 *rk808 = dev_get_drvdata(dev);
>  	int ret = 0;
>
> +	enable_irq(rk808->irq);

This is early - are you sure you want to do this right away?

> +
>  	switch (rk808->variant) {
>  	case RK809_ID:
>  	case RK817_ID:
> diff --git a/include/linux/mfd/rk808.h b/include/linux/mfd/rk808.h
> index 7ffc904c864c9..1255de484ab51 100644
> --- a/include/linux/mfd/rk808.h
> +++ b/include/linux/mfd/rk808.h
> @@ -1461,6 +1461,7 @@ enum {
>
>  struct rk808 {
>  	struct device			*dev;
> +	unsigned int			irq;
>  	struct regmap_irq_chip_data	*irq_data;
>  	struct regmap			*regmap;
>  	long				variant;
>
> -- 
> 2.47.3
>

-- 
Lee Jones
