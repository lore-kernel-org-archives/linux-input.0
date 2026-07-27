Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000093EC2EA
	for <linux-input@vger.kernel.org>; Mon, 27 Jul 2026 10:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785147619; cv=none; b=oaBfjKzT7dxwnB3dYCE1TlAIHC1K8tWKLzfleGDu3SFou+AZXbHq6sAsXB8AHlVyxlDCI3uo9lTNkKdC6YCqC/R0wE5kIqrGKaB+ayfVt76FgqqdiTiBf+R5LSe3ibfuXxqDuSBofoIvZ/0aXWztbAgbeR1rdV/aSG4Dc8otTkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785147619; c=relaxed/simple;
	bh=8dLZi4uPb0WEIVGQrTIWHeyErY6GOKuQx4FTOVlEI3s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dCJYrSFmD4A9AhS2ECI4CaSfZ7xANNM20hIZde6x2PA3zYXrS+2/HPGWTpyiXP5YC0p5R7edUyHeIUjgCS17H1mzR4vw5uFeFGXGhAtByXouNb4CmA/qtl8POJkxljMy1wZ3DdouhP44lYK7DUHnn5y+jLyxvrMklkUoSe0GCLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mOvjFm3Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mOvjFm3Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE231F00A3A;
	Mon, 27 Jul 2026 10:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785147617;
	bh=WXGxGRkmZS9dvwBmyE5IZKeBplVkwsTPYZZxhH3iERM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mOvjFm3Qlo3+ZLNEwXslKYlI5b596RX9rxkPgeeFNTZRtdcOMkaTjsV4ylqHj4qzr
	 ZOOcdaCa52lTELXHNKpPJhftQ5jMBV/CzymvqkfnUYXsDCFujIPnbuvXvtXoWvv4zs
	 dEECZZJdNjriZao5oN3QuaWoThCRZeBga3RwyvrlziKCR4li3CGkhRbE/vM53/6+GB
	 kqu+/Lf6gR7AsuSNCqMGSq2wqMrAQV/wrvEDcZp4VAWlj88MdwlMWEZuVRc+hSwPUi
	 DxXE6Rh5t6kc+c9YDlx7bD9OymOC9OlcnYO0HV/reoW2vZkHPSI62gdHg9yagEHquQ
	 IQiBsPUx9CI/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] Input: st-keyscan: Improve probe error handling
Reply-To: sashiko-reviews@lists.linux.dev
To: phucduc.bui@gmail.com
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260727101125.28291-2-phucduc.bui@gmail.com>
References: <20260727101125.28291-1-phucduc.bui@gmail.com>
 <20260727101125.28291-2-phucduc.bui@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 10:20:16 +0000
Message-Id: <20260727102017.4AE231F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Hardware access with disabled clock in ISR causes bus faults (spur=
ious or pending interrupts)
--

--- Patch [2]: [PATCH v2 2/2] Input: st-keyscan: Improve probe error handli=
ng ---
commit 006b58b79139d033aaee4496bf01651147f36cad
Author: bui duc phuc <phucduc.bui@gmail.com>

Input: st-keyscan: Improve probe error handling

This commit updates probe error handling by using dev_err_probe() for
devm_clk_get(), dropping a redundant error message after devm_request_irq(),
and returning the original error code from platform_get_irq().

> diff --git a/drivers/input/keyboard/st-keyscan.c b/drivers/input/keyboard=
/st-keyscan.c
> --- a/drivers/input/keyboard/st-keyscan.c
> +++ b/drivers/input/keyboard/st-keyscan.c

[ ... ]

> @@ -188,14 +187,12 @@ static int keyscan_probe(struct platform_device *pd=
ev)
> =20
>  	keypad_data->irq =3D platform_get_irq(pdev, 0);
>  	if (keypad_data->irq < 0)
> -		return -EINVAL;
> +		return keypad_data->irq;
> =20
>  	error =3D devm_request_irq(&pdev->dev, keypad_data->irq, keyscan_isr, 0,
>  				 pdev->name, keypad_data);
> -	if (error) {
> -		dev_err(&pdev->dev, "failed to request IRQ\n");
> +	if (error)
>  		return error;

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a pre-existing iss=
ue
with how the interrupt is registered here.

Since keyscan_stop() is called just before this in keyscan_probe(), the IP
block's clock is already gated. By requesting the interrupt without
IRQF_NO_AUTOEN, the interrupt is immediately unmasked at the interrupt
controller.

If a pending or spurious interrupt fires before the device is opened, could
the ISR attempt to access hardware registers while the clock is disabled?

drivers/input/keyboard/st-keyscan.c:keyscan_isr() {
    ...
    state =3D readl(keypad->base + KEYSCAN_MATRIX_STATE_OFF) & 0xffff;
    ...
}

Does this sequence risk a synchronous external abort (bus fault) causing a
kernel panic on this platform?=20

Would it be safer to request the IRQ with IRQF_NO_AUTOEN so it remains mask=
ed
until keyscan_open() explicitly enables the clock? I noticed this same wind=
ow
might exist in keyscan_close(), which disables the clock via keyscan_stop()
but leaves the IRQ unmasked.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727101125.2829=
1-1-phucduc.bui@gmail.com?part=3D2
