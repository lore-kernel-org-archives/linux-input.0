Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A6D305693;
	Mon, 15 Jun 2026 07:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781510252; cv=none; b=XpFpo5mHM+Z5QFABNSSGsFRzK5A+EsGLXzQLPkWgIkiydIQzYnwZal4iPhWnEPMsv63qoub5YVOEWef2Ex7NzsZQscW6kK7wKZY4OIWC9ZibKpTUQ68Kymgj35yuW3wmV17pzUh0CGoZ4LgEIjbFW8e7/eWPG/lKZHoOf5cxX/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781510252; c=relaxed/simple;
	bh=UemH3LJApTAUXqcR2eqFzxbnLTh959iX1fwPpPGBRXQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hpP6Fimnf+U6Hzztqrjf+qbX46XKP7KCcMEZMRZvADtBD1AdYN2b4dfdtVZnI0yNaperJ/RCnFMCmMgvgUzuWsK5NuAh6/YYP2lDkabQNHKp1niHM43DlhsktkR4yg3sqf4psrw1KEuPVdIEdnxZAKyab0q40k7WIqSy/MazODQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmO9MsJY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmO9MsJY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B179B1F000E9;
	Mon, 15 Jun 2026 07:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781510251;
	bh=UYZrTqus0M5Asp6l7FbWKJkDjw+Dbfati5ZPdmzeGrI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PmO9MsJYvV+Jlg1DgAPKlSRJjgJZul0y3RXviXs0wXD6dDNN2OdCvzK45haOAOTlo
	 4HA99SouRQ73cEXbIWq4TKrJSrijgJTYRSjkRR0WI+7kq9Worc4nCijg9X6FxwJ9De
	 /BLof+V5xDX39kTNLjReH1F3uXzXNT9dWChBigIljuDQh+X3qIQO6MAtD5Zv6HZAZ2
	 l0eUz+75JLFX0Ue4iVSWvnIwTBmkC8TIIjzMYXvDbSdA48HH1mX9ywIX/80OGV3BJd
	 NbuHgSu9bL1rTSsgFkXW4p7OWu0JtonxRSLzb86rFmr0j0QnDOLRMIyDK+aCjAWdWO
	 YD/B+gJfF7xGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] Input: snvs_pwrkey - use local device pointer to
 simple code
Reply-To: sashiko-reviews@lists.linux.dev
To: joy.zou@oss.nxp.com
Cc: linux-input@vger.kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev, dmitry.torokhov@gmail.com
In-Reply-To: <20260615-b4-pwrkey-v3-3-9510b1173f6e@oss.nxp.com>
References: <20260615-b4-pwrkey-v3-3-9510b1173f6e@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 07:57:30 +0000
Message-Id: <20260615075730.B179B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The driver calls `dev_pm_set_wake_irq()` but does not use the `dev=
m_` variant or provide a `.remove` function, leading to a resource leak and=
 potentially broken system suspend on driver unbind.
--

commit d7d5ed812213c739d1459c472b4e230aac0a6e8d
Author: Joy Zou <joy.zou@nxp.com>

Input: snvs_pwrkey - use local device pointer to simple code

This commit introduces a local struct device pointer in the probe function
to reduce boilerplate code when referencing the platform device. It is
intended to be a non-functional change.

> diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboar=
d/snvs_pwrkey.c
> --- a/drivers/input/keyboard/snvs_pwrkey.c
> +++ b/drivers/input/keyboard/snvs_pwrkey.c
[ ... ]
> @@ -193,27 +194,27 @@ static int imx_snvs_pwrkey_probe(struct platform_de=
vice *pdev)
[ ... ]
> -	device_init_wakeup(&pdev->dev, pdata->wakeup);
> -	error =3D dev_pm_set_wake_irq(&pdev->dev, pdata->irq);
> +	device_init_wakeup(dev, pdata->wakeup);
> +	error =3D dev_pm_set_wake_irq(dev, pdata->irq);

[Severity: High]
This is a pre-existing issue, but does this leak the wake IRQ on driver=20
unbind?

Looking at imx_snvs_pwrkey_probe() in drivers/input/keyboard/snvs_pwrkey.c,
the driver configures the wake IRQ using dev_pm_set_wake_irq() but it does
not use the devm_ variant, nor does it provide a .remove callback to call
dev_pm_clear_wake_irq().

When the driver unbinds, devres automatically frees the IRQ, but the memory
for the wake IRQ structure remains allocated and attached to
dev->power.wakeirq.=20

Will a subsequent system suspend then attempt to call enable_irq_wake() on a
freed IRQ number? Also, if the driver is later re-bound, would it trigger a
warning in dev_pm_attach_wake_irq() because dev->power.wakeirq is already
initialized?

Should this be updated to use devm_pm_set_wake_irq() instead?

>  	if (error)
> -		dev_err(&pdev->dev, "irq wake enable failed.\n");
> +		dev_err(dev, "irq wake enable failed.\n");
> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615-b4-pwrkey-=
v3-0-9510b1173f6e@oss.nxp.com?part=3D3
