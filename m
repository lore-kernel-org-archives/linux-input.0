Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948831D0DEE
	for <linux-input@vger.kernel.org>; Tue,  9 Jun 2026 21:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781041472; cv=none; b=bBv6Voe/5hF1zuXMxpylgJE4QUyHQ5YkFXpESlSne+oeMctuCFgh2j12YdKoKDSPKJpRl65yx4IHY9m18mVEU1g/9ajGqZhJo5zXIA9WoAPp/eyrvtbM44k1Q53tk3w5ZY0eJf4AL7Ymez24TIwhIdhrBFzYVAzW8+XxasX12DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781041472; c=relaxed/simple;
	bh=I8FDlNe+CNkj+2y9+ttg8DhJI1cIyAJvKcGpeGAD4FE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bwXNk9K97MGbRGBbsUS24AfqgmLB96IroAHYQStrJlUGZblVORJcOsp/6FukoByjupZzoFd42FCEmVZp1xn6z1SvmmfOjVfS+ofNm/n4ggHImUhEWwPxo8Y0W/L3GmXopiQ5cuBu/UDw2mQccvE5d/Ok5p0X3ZbeSaDJsPBpuOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJDfVjah; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJDfVjah"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9689A1F00893;
	Tue,  9 Jun 2026 21:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781041471;
	bh=+r8HnC2HLzDp3+1KEWhcNHQbm/K6bp5m1XrC5P5Ah4s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FJDfVjah54SAripPsZgukklgbSYo0v7FCD0bbJ7M0EnFTO+f3Zmr7O98uANBMxRXw
	 uZ7lFE/lkOt2sy0kXzyxJ0j7sepvGj0SLMOZLmgke5dTRmYkrhSHnlKCbfToShuQLb
	 ViL3LOO7ZL6ZSB29bFGCxQrpPTVCpZsVml7fOdmYFnlBqFNlSlrbLK4XNb8dgAi3ni
	 pTmh4hgMm8sq57kt0ol86JVGkT23JoeUeXY1115AvVtj1sbcmDQSo/tSHKzSJ2JlfM
	 85qD5C4/+wO4ctYw2ykV6kvEYFKebjiEAFBVpH4mI0zPgRKSZxhaBFWx0Fvw/xvYHy
	 iiq/rlkNHec6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2] input: ipaq-micro-keys: simplify allocation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260609213532.25181-1-rosenp@gmail.com>
References: <20260609213532.25181-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 21:44:30 +0000
Message-Id: <20260609214430.9689A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Potential deadlock in `micro_key_start()` and `micro_key_stop()` d=
ue to taking a spinlock without disabling interrupts, which is also taken i=
n a hardirq handler.
--

commit 59a420f5a26f394b8f84d4e056f388e517d6f808
Author: Rosen Penev <rosenp@gmail.com>

input: ipaq-micro-keys: simplify allocation

This commit simplifies the keycode array allocation in the ipaq-micro-keys
driver. By embedding the array directly into the device structure, it remov=
es
the need for a separate devm_kmemdup_array() call during probe.

> diff --git a/drivers/input/keyboard/ipaq-micro-keys.c b/drivers/input/key=
board/ipaq-micro-keys.c
> index ca7ec054b1cef..695ef3c2081a4 100644
> --- a/drivers/input/keyboard/ipaq-micro-keys.c
> +++ b/drivers/input/keyboard/ipaq-micro-keys.c

[ ... ]

> @@ -102,10 +102,7 @@ static int micro_key_probe(struct platform_device *p=
dev)
> =20
>  	keys->input->keycodesize =3D sizeof(micro_keycodes[0]);
>  	keys->input->keycodemax =3D ARRAY_SIZE(micro_keycodes);
> -	keys->codes =3D devm_kmemdup_array(&pdev->dev, micro_keycodes, keys->in=
put->keycodemax,
> -					 keys->input->keycodesize, GFP_KERNEL);
> -	if (!keys->codes)
> -		return -ENOMEM;
> +	memcpy(keys->codes, micro_keycodes, sizeof(keys->codes));
> =20
>  	keys->input->keycode =3D keys->codes;

[Severity: High]
This isn't a bug introduced by this patch, but could the lock usage in
micro_key_start() and micro_key_stop() cause a deadlock if an interrupt
fires?

Looking at drivers/input/keyboard/ipaq-micro-keys.c, the micro->lock is
acquired in process context without disabling interrupts:

micro_key_start() {
    guard(spinlock)(&keys->micro->lock);
    ...
}

If a serial interrupt fires on the same CPU while the process context holds
the lock, the interrupt handler micro_serial_isr() runs, processes the
character, and calls micro_rx_msg().

micro_rx_msg() in drivers/mfd/ipaq-micro.c then attempts to acquire the same
lock in hardirq context:

    spin_lock(&micro->lock);

Does this sequence lead to a lock inversion deadlock? Should the process
context functions use guard(spinlock_irqsave) or guard(spinlock_irq)
instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609213532.2518=
1-1-rosenp@gmail.com?part=3D1
