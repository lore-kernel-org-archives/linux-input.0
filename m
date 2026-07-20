Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259CF3ACA7A
	for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 08:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784537813; cv=none; b=H9wnd5uNCM2rmPwGPXlHYuC4WP8PH5glnQ9JGsJSXuZHwcF3qWrd7movewGPD7An3fjBj73l8XF37Nuj3gFDYun8ECDP4MgZzehJ/GMPYpD/LtWPIWpFBulDCIGPJS43ILY/isG985rLMI3d8v04h69jHJJ3Iw51Nn733HY1FSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784537813; c=relaxed/simple;
	bh=h5/EtuiTok7Yo4le3fYh8rvHdf4Owc5QCjdTFBiV8AA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jnXt6MvNPI++iNEDBDpIsooHQT4kRUJDiP6ksySjBlwF0Cl23qeChLaxZQA/df4IFn2aYJiqTquWhU/Of2j97OP6JHjbFpBbML8/Z0jqCuJupJdfpwoJrBkrmUQmZeaING76wYP4kiSSkMLoseD9zXLStCMeQJjbzNX3t2b+cOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+IukMt7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+IukMt7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3812F1F00A3A;
	Mon, 20 Jul 2026 08:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784537811;
	bh=wZ0OQ4MY54qdmhVHYSuqYFcQEblYblElg4/YTJqbcJc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g+IukMt7ekkN/dxFy12Ee39MlRKwMLiwLbxdMpv35uiAql9JB8RaXMwvRefrs421l
	 3YOCIm1bIyqrZl9EeDzPAoKTDWPyqLBLIAkNOtNTQ1qpRF66KzBNaya6rV5ifJ+Kh6
	 vOuRdd+9tEpbjvtrnDVw4LcIBd14m0f1AvX73XUkK3Ztvn+a494qkNzTzqDuv1W+yL
	 axcVBjX89lbzJh5CWnAmzP831R2ErlV2+2DJJ+eJncjDrCgKkvP6f868YZa9EgG/3K
	 gK9YQpSodlOVdgpsCnUKExDMu1ablofcICGHHElxxW/qvVZSn4Urnv/904RQK3ZT1W
	 vUYozKLutgvQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] Input: st-keyscan: Improve probe error handling
Reply-To: sashiko-reviews@lists.linux.dev
To: phucduc.bui@gmail.com
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260720085041.224896-2-phucduc.bui@gmail.com>
References: <20260720085041.224896-1-phucduc.bui@gmail.com>
 <20260720085041.224896-2-phucduc.bui@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 08:56:50 +0000
Message-Id: <20260720085651.3812F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Deferred probe errors from `platform_get_irq()` are incorrectly ma=
sked and converted to `-EINVAL`.
- [High] The interrupt handler is registered and unmasked while the hardwar=
e clock is disabled, which could lead to a crash on an unhandled or pending=
 interrupt.
--

--- Patch [2]: [PATCH 2/2] Input: st-keyscan: Improve probe error handling =
---
commit c25a1a7eacb3523c173790ed6cd29726473a8fa7
Author: bui duc phuc <phucduc.bui@gmail.com>

Input: st-keyscan: Improve probe error handling

Use dev_err_probe() for devm_clk_get() so deferred probe errors are
handled correctly.
Drop the redundant error message after devm_request_irq(), since the
helper already reports request failures internally.

> diff --git a/drivers/input/keyboard/st-keyscan.c b/drivers/input/keyboard=
/st-keyscan.c
> index e53ef4c670e4b..d86f6f16ae1b2 100644
> --- a/drivers/input/keyboard/st-keyscan.c
> +++ b/drivers/input/keyboard/st-keyscan.c

[ ... ]

> @@ -192,10 +191,8 @@ static int keyscan_probe(struct platform_device *pde=
v)
> =20
>  	error =3D devm_request_irq(&pdev->dev, keypad_data->irq, keyscan_isr, 0,
>  				 pdev->name, keypad_data);

[Severity: High]
This is a pre-existing issue, but since you are improving error handling in=
=20
keyscan_probe(), could we also fix the error return for platform_get_irq()=
=20
just prior to this?

Currently the code does this:

	keypad_data->irq =3D platform_get_irq(pdev, 0);
	if (keypad_data->irq < 0)
		return -EINVAL;

Does overwriting the real error code from platform_get_irq() with -EINVAL
break deferred probe if the interrupt controller is not yet ready?

[Severity: High]
This isn't a bug introduced by this patch, but I also noticed a potential=20
issue here related to the IRQ registration.

Just before calling devm_request_irq(), keyscan_probe() calls=20
keyscan_stop() which disables the clock.

If the IRQ line is asserted (e.g. from a pending bootloader state or
spurious event), keyscan_isr() will fire immediately once devm_request_irq()
is called.

The ISR then accesses peripheral registers:

drivers/input/keyboard/st-keyscan.c:keyscan_isr() {
	...
	state =3D readl(keypad->base + KEYSCAN_MATRIX_STATE_OFF) & 0xffff;
	...
}

Can accessing peripheral registers while the corresponding clock is disable=
d=20
cause a synchronous bus fault or kernel panic on these systems? Should the=
=20
devm_request_irq() call be moved after the clock is re-enabled?

> -	if (error) {
> -		dev_err(&pdev->dev, "failed to request IRQ\n");
> +	if (error)
>  		return error;
> -	}
> =20
>  	error =3D input_register_device(input_dev);
>  	if (error) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720085041.2248=
96-1-phucduc.bui@gmail.com?part=3D2
