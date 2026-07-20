Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA322E92BA
	for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 09:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784539024; cv=none; b=sK8EkngibntUktZpoKeICM3vhqLSNUXgEuWCUDCO28N9r/57NlwZ9sO5smKpFBPnKJARKURV58KCxojilHHHni8zXJDFgAXIxSc/XjlA2SfH4PGJAQhuvvW7LfwNTB7lCWEp1Sy91DvG+Ox4JDO5V6nDlzNoG80Csu/PTSfMO9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784539024; c=relaxed/simple;
	bh=IuQ0trpZkZcE4xhssXKNoz+9FGnFL4E/4jKPzkrwItM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HiZLbD0qFKMwrev9gJHc/cAzZ7VwxlsTRdFRqlSXgPqbG9i1yWySJ/uEmAO0iJyaZCnQLiLDWhFpaG65ggOnpJcpigFkZMZHHuV5J5dec3NdronbhhishTnesMlbO+mymUlRvG6iMrzhwOgkpf95752J0FK+HhtjQel2Ydao6z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZFCCIPXc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFCCIPXc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA781F000E9;
	Mon, 20 Jul 2026 09:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784539022;
	bh=1kbKVV3SfzicYFiACYHnHIbjFi9zDxD00y9w0NBjuA4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZFCCIPXc50u9BvgI6YgoWFxL+jhKALsftzorv00NJEHhGjPck7a0BYf/PQEwSpuEU
	 qBO4bDAeW0d+VOxFyaJh/Z+KtC9absFkoyRxNfEaL/Q8RciTGkhpbu3gCprhHTaA1g
	 h24HQ2/hb5pXZyQoH9ffDjQVkJZePMwcRPGTvOkFWDHLlveDZhnNX5tPnMuzqC9r3F
	 oaekm16R941SQ9iPm1VRjO6xZtAZ7jKykAOWgbwdgz0MNEdvDdsEsIkd8VA9JRawpp
	 T8cn0wR4igtiMFoo8vKfvCAk4KQHgksqU33PJ189g2j4dg7iUcI14C1F5SLgphxcey
	 E6JQRo3XT1+uQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] Input: st-keyscan: Improve probe error handling
Reply-To: sashiko-reviews@lists.linux.dev
To: phucduc.bui@gmail.com
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260720090851.230244-2-phucduc.bui@gmail.com>
References: <20260720090851.230244-1-phucduc.bui@gmail.com>
 <20260720090851.230244-2-phucduc.bui@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 09:17:01 +0000
Message-Id: <20260720091702.7FA781F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The driver requests and leaves the interrupt enabled while the har=
dware clock is explicitly disabled, leading to a potential crash (synchrono=
us external abort) upon a spurious or pending interrupt.
--

--- Patch [2]: [PATCH v2 2/2] Input: st-keyscan: Improve probe error handli=
ng ---
commit 036864a311a2de2b62ec154e1ff242ede73fb89b
Author: bui duc phuc <phucduc.bui@gmail.com>

Input: st-keyscan: Improve probe error handling

This commit improves error handling in the probe function by using
dev_err_probe() for clock fetching, removing redundant error logs for
devm_request_irq(), and returning the original error code from
platform_get_irq().

> diff --git a/drivers/input/keyboard/st-keyscan.c b/drivers/input/keyboard=
/st-keyscan.c
> index e53ef4c670e4b..8e9bac339dc47 100644
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

[Severity: High]
This is a pre-existing issue, but does requesting the IRQ here while the
hardware clock is explicitly disabled risk a bus fault?

Earlier in keyscan_probe(), keyscan_stop() is called to disable the clock.
When devm_request_irq() is called here, it unmasks and enables the interrupt
while the clock remains gated.

If a spurious interrupt or a bootloader-pending interrupt occurs at this
point, keyscan_isr() will execute and attempt to read the hardware register:

drivers/input/keyboard/st-keyscan.c:keyscan_isr() {
    ...
    state =3D readl(keypad->base + KEYSCAN_MATRIX_STATE_OFF) & 0xffff;
    ...
}

Accessing the memory-mapped register while the IP block's clock is disabled
can trigger a synchronous external abort. The same condition appears to hap=
pen
during keyscan_close(), which disables the clock while the IRQ remains acti=
ve.

Would it be safer to request the interrupt with IRQF_NO_AUTOEN or delay
requesting it until the device is actually opened and clocked?

> -	if (error) {
> -		dev_err(&pdev->dev, "failed to request IRQ\n");
> +	if (error)
>  		return error;
> -	}
> =20
>  	error =3D input_register_device(input_dev);
>  	if (error) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720090851.2302=
44-1-phucduc.bui@gmail.com?part=3D2
