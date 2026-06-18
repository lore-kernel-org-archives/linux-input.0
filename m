Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFEB1A9FBC;
	Thu, 18 Jun 2026 07:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781768282; cv=none; b=Exy7pgXc73yas7nWNMv43nhPU3LWR/5Ot694Q3PxQUEEB2GYob+AQuiyQ4NnZikXQLZ4CfQJ/FGfNZllcPMRmmllMXKXEbIxn8sIwzoyTgFMShrZGD70fCu55oL3iuKCf9jExN8sjdDFxtYMV4vAXekScPCAYp5ZPfl1HmkYjHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781768282; c=relaxed/simple;
	bh=JMdaw/G4Q1+VU6qQA1FwxuREBLP3S5XBkINl7ZDbQtE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UFtEZ5vVA4FApycr+g0vFgCskAb+EUDeDzXxZB/iCjC2bEktRjyutMhIPDCceQO99bgCMiy+VwDiXS1NXaYhdmk69A11UbALfO0bDGMNwmJ7tTxX8SzbFc8GkPO9cq3ezJh3LpXaQMid81bCxfmJ6/EHmOKaXenCuHkdcM2uFeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRYpjvw+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRYpjvw+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D70B51F00A3D;
	Thu, 18 Jun 2026 07:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781768281;
	bh=IApOWGB4DLbYSNU3AHQaaE5y10+hN8X5742hSB9GaVY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aRYpjvw+Wn6fmfEogd1hedPRVGXmULK7O85jaH2CAZsnnqT1DULIOLa6MGuxNgQLB
	 w9Li6U2WvRdfxRaZmvgGykJ9DVdmRJM8KA9ko816ZjgProBuh7FyAviNu3SHzwC/h1
	 88SlUR00dwXUqwaXe6iBlMenahyDS+Pd2pCgMzMH0f/RDdZ5+JVe90WVgkcme9+hA9
	 /4H0msgSdFX/OAZERbgM432Cqr/NcBhg8giVaCH1f9e3SJ/KDDSzdSYrcFPJ8nklYA
	 UZv0Vmt26ahllyg6BR42uOl74QWw4Xys7tbizqFdD1D/rZaN9vKVq1VV2JnOWzb1wW
	 OdXLCpUjl6tLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/4] Input: snvs_pwrkey - make use of dev_err_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: joy.zou@oss.nxp.com
Cc: linux-input@vger.kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev, dmitry.torokhov@gmail.com
In-Reply-To: <20260618-b4-pwrkey-v4-1-4bfda105bdf3@oss.nxp.com>
References: <20260618-b4-pwrkey-v4-0-4bfda105bdf3@oss.nxp.com>
 <20260618-b4-pwrkey-v4-1-4bfda105bdf3@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 07:38:00 +0000
Message-Id: <20260618073800.D70B51F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Memory leak of struct wake_irq on device unbind
--

commit 469e290fcf154d6638767e1e60cb2427638bea98
Author: Joy Zou <joy.zou@nxp.com>

Input: snvs_pwrkey - make use of dev_err_probe()

This commit updates the probe function of the snvs_pwrkey driver to
use dev_err_probe() for error handling. This simplifies the code and
improves logging for deferred probes.

> diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboar=
d/snvs_pwrkey.c
> index 954055aaf6e29..8cc6863d26ed8 100644
> --- a/drivers/input/keyboard/snvs_pwrkey.c
> +++ b/drivers/input/keyboard/snvs_pwrkey.c
[ ... ]
> @@ -209,16 +201,12 @@ static int imx_snvs_pwrkey_probe(struct platform_de=
vice *pdev)
>  	error =3D devm_request_irq(&pdev->dev, pdata->irq,
>  			       imx_snvs_pwrkey_interrupt,
>  			       0, pdev->name, pdev);
> -	if (error) {
> -		dev_err(&pdev->dev, "interrupt not available.\n");
> -		return error;
> -	}
> +	if (error)
> +		return dev_err_probe(&pdev->dev, error, "interrupt not available.\n");
> =20
>  	error =3D input_register_device(input);
> -	if (error < 0) {
> -		dev_err(&pdev->dev, "failed to register input device\n");
> -		return error;
> -	}
> +	if (error < 0)
> +		return dev_err_probe(&pdev->dev, error, "failed to register input devi=
ce\n");
> =20
>  	device_init_wakeup(&pdev->dev, pdata->wakeup);
>  	error =3D dev_pm_set_wake_irq(&pdev->dev, pdata->irq);

[Severity: Medium]
This is a pre-existing issue, but does this dev_pm_set_wake_irq() allocation
leak when the driver is unbound?

Because this driver relies entirely on devres for resource management and
does not implement a .remove callback, there is no explicit call to
dev_pm_clear_wake_irq() upon driver unbind.

The device core does not automatically free dev->power.wakeirq during
device_pm_remove(), so this allocated wake_irq structure appears to leak
every time the driver is unbound.

Could this be fixed by switching to the managed variant,
devm_pm_set_wake_irq()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-b4-pwrkey-=
v4-0-4bfda105bdf3@oss.nxp.com?part=3D1
