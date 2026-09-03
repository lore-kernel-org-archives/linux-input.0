Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C28501F3D
	for <linux-input@vger.kernel.org>; Thu,  3 Sep 2026 19:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788464485; cv=none; b=jYnTMiPSwKL8iCcKte98J4WT1oiHGDJCP/gbpWj8yY377rXYKXAG9rynzYI7BZF0SCVZ6gfERyQSDxx2eY8joXmQ3QGOxabmbZrHZh5QmW+oCdfhP0GUO4oYxtbBOJc8By8GuRieskJ6dvIEmalmqojZNQ6f4rfikgcFqXsqnBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788464485; c=relaxed/simple;
	bh=D2f0J6Keh5FCL40pXweemMmM9RzRT49Wg6z92fF/O6E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KdOHk7bBhlI4g2J26sGQueLHgEnEqNSTG8KJC/+HKaAr5ANXAL3sHk4Zc/NA2o/ulEWkkrADto6i7egdERVLMIPXZBUFVufKv2t5aRSr20WSl65Hg6huH2/NV1sEHuR9M4khRL72WiQc4J39hl5Ugc1VRZcXiTeDWhFNnrWG/ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fu7Ivh7c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fu7Ivh7c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D04281F000E9;
	Thu,  3 Sep 2026 19:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788464475;
	bh=8Cxqnk0OZTfgBlO1lGwluj/FXjZxSl1F0kr18ocGvs8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fu7Ivh7c7JwCwl9cRI57w4PJPkCkzzgPTqNSxrBd1ydvI/HsTafZdxN8cdSApl/Gp
	 LnvOZsED+POPzl6fPABux9fep1jid3gmnrr5Qzgg/QAxIT8LRoCf5ik4OBkSXIw1Vj
	 WY5TFgP4duiu6ycU5nZY3beYz0Jro9X2GVkbqmNGXxkUyvVLkRCsc7hmHYBaW39IUy
	 T1CRmwBAnHmnn0LW/Zh4Xxc/9paLOmm9JpbArx3F8wR+QUbaUL/4bZdQ2Y8rqPU5R1
	 zHuKNcw5P1eAeXoABBlZu4ROyXvMhsIIiyOZSzr+/M3e86nRAL8qJu2nHg8UOtM6/h
	 6323qnnrU1pkQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] Input: tca8418_keypad - fix race condition in
 interrupt handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhian Liang" <liangzhan5dev@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260903192942.21906-2-liangzhan5dev@gmail.com>
References: <20260903192942.21906-1-liangzhan5dev@gmail.com>
 <20260903192942.21906-2-liangzhan5dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 19:41:14 +0000
Message-Id: <20260903194114.D04281F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The patch fails to resolve the lost-interrupt race condition and i=
ntroduces a 16-iteration busy loop due to misunderstanding the Write-1-to-C=
lear (W1C) interrupt status register.
- [High] Returning IRQ_HANDLED on I2C read failure bypasses clearing the in=
terrupt, which could lead to an IRQ storm.
- [Medium] The outer loop and its 16-iteration limit are redundant and base=
d on a flawed assumption about the FIFO reading logic.
--

commit b07bd14b2796c804f03cf9efdf000891fe041cc5
Author: Zhian Liang <liangzhan5dev@gmail.com>

Input: tca8418_keypad - fix race condition in interrupt handler

This patch modifies the tca8418 interrupt handler to re-read the
interrupt status register and loop if the interrupt bit is still set.
This is intended to prevent lost key events when new data arrives
after the FIFO is drained but before the interrupt status is cleared.

> diff --git a/drivers/input/keyboard/tca8418_keypad.c b/drivers/input/keyb=
oard/tca8418_keypad.c
> index d917de848a213..be700137b0fb7 100644
> --- a/drivers/input/keyboard/tca8418_keypad.c
> +++ b/drivers/input/keyboard/tca8418_keypad.c

[ ... ]

> @@ -214,9 +215,19 @@ static irqreturn_t tca8418_irq_handler(int irq, void=
 *dev_id)
> =20
>  	if (reg & INT_STAT_OVR_FLOW_INT)
>  		dev_warn(&keypad_data->client->dev, "overflow occurred\n");
> +	do {
> +		if (reg & INT_STAT_K_INT)
> +			tca8418_read_keypad(keypad_data);
> +
> +		/* Re-read interrupt status to check for new events */
> +		error =3D tca8418_read_byte(keypad_data, REG_INT_STAT, &reg);
> +		if (error) {
> +			dev_err(&keypad_data->client->dev,
> +				"unable to re-read REG_INT_STAT\n");
> +			return IRQ_HANDLED;

[Severity: High]
If the I2C read fails inside the new loop, returning IRQ_HANDLED bypasses t=
he
interrupt clear step at the end of the function. Could this leave the inter=
rupt
line asserted in hardware? If the interrupt is level-triggered or shared,
might this cause an IRQ storm because the kernel is told the interrupt was
handled while it remains asserted?

> +		}
> =20
> -	if (reg & INT_STAT_K_INT)
> -		tca8418_read_keypad(keypad_data);
> +	} while ((reg & INT_STAT_K_INT) && --max_loops);

[Severity: High]
The REG_INT_STAT register is Write-1-to-Clear. Because reading it does not
clear the interrupt bit by itself, wouldn't reg & INT_STAT_K_INT evaluate to
true on every iteration, causing the handler to always spin for the full
16-iteration limit on every valid interrupt?

[Severity: Medium]
Is the max_loops limit of 16 necessary to drain the 10-event FIFO? Looking =
at
tca8418_read_keypad(), it has its own do/while loop that continuously reads
until the FIFO reports empty. It seems a single call fully drains the FIFO,
making the outer loop based on FIFO depth redundant.

> =20
>  	/* Clear all interrupts, even IRQs we didn't check (GPI, CAD, LCK) */
>  	reg =3D 0xff;
>  	error =3D tca8418_write_byte(keypad_data, REG_INT_STAT, reg);

[Severity: High]
Does this unconditional write of 0xff clear any new interrupts that trigger=
ed
just after the loop finished? If a new event sets the interrupt flag between
the end of the loop and this write, it looks like it will be cleared without
reading the corresponding event. Could this permanently drop events and
preserve the race condition this patch aims to fix?

>  	if (error)
>  		dev_err(&keypad_data->client->dev,
>  			"unable to clear REG_INT_STAT\n");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903192942.2190=
6-1-liangzhan5dev@gmail.com?part=3D2
