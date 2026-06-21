Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C25B126C03;
	Sun, 21 Jun 2026 08:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782030655; cv=none; b=Llb0eh8SJCVkzL4uPFDQw8+AxACrDoCCPsGZDTRwve3VyVkr3bl8NlX9hua4+W3KyIsdXvW5AcpAUucUlsR9cAJColF9r0RglVEleaCpWZ5+2Th95PAn5IPlOTy0HUFQpwIBIN0+jtGi3FwDkYKCwmGDbs16yUgj/B9ShqzyUpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782030655; c=relaxed/simple;
	bh=WkUaf/DUYitxbfioGYcmXObhK1l654e1wRE3pjeujHk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=owcgz2t4++yDeeHuBpnB/h3WvyOAlSfetql4kmNZakSqTuwa7SIq7qUSFeeVfuz0K96R6vW42jWpZOGeu9Ht+tyygN/Kik0hARf58XeFSspaS+oXkuXnOvPJU05if0Rozae3NyKugw6HTRfuEwqNW4/W/kwOy/SS8z6YmcF8bXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gT/1rGl9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gT/1rGl9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B641F000E9;
	Sun, 21 Jun 2026 08:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782030654;
	bh=1be+4TJkEnCpxbINnR5zSWewOF1aPiS8bgEzGs4/Pmc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gT/1rGl9cckXiBYhURY7dQkatbSqTt0wcO9cqdJVNMOEO4LT/ZWgQozZ32TGq2uqT
	 iyM9QkYf1yviAX7KNignKhPRUg3cpfzn767xecwa7kB/p44QNR38YfzVIZ09DlLZZR
	 qtQz92rkm8RN3/Mr2P1jmyhO3kVk16RQObDHM+k6FPCIVmDt2cWmI/RrMThB7b3ByP
	 HJlgpqPcucg+2Gx+fs+DG/NJIxHnJO5SUUhVT1TvjEsxDtheCMxhkxICeTDn/32LIm
	 dGhq5mmkKW156Spep8vQ9+6F0TlUxekG63SqJUPhd+K/pKO/HAdtkqpPxKJC2/iIJq
	 UHE1Vz1GGwgSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 7/9] pinctrl: mediatek: mt6397: Add MediaTek MT6392
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luca Leonardo Scorcia" <l.scorcia@gmail.com>
Cc: linux-input@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, dmitry.torokhov@gmail.com, devicetree@vger.kernel.org
In-Reply-To: <20260621081634.467858-8-l.scorcia@gmail.com>
References: <20260621081634.467858-1-l.scorcia@gmail.com>
 <20260621081634.467858-8-l.scorcia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 21 Jun 2026 08:30:53 +0000
Message-Id: <20260621083053.A3B641F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-After-Free due to missing `.remove` callback while using unman=
aged registration with devm-allocated memory.
--

commit 120aff926d5691bb4a5ec3b6058e13323e67c325
Author: Luca Leonardo Scorcia <l.scorcia@gmail.com>

pinctrl: mediatek: mt6397: Add MediaTek MT6392
   =20
Add support for the MT6392 pinctrl device, which is very similar to
MT6397 with a handful of different property values and its own pins
definition.

Update the MT6397 driver to retrieve device data from the match table and
use it for driver init.

> diff --git a/drivers/pinctrl/mediatek/pinctrl-mt6397.c b/drivers/pinctrl/=
mediatek/pinctrl-mt6397.c
> index 03d0f65d7bcc1..8ba02e70595ce 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mt6397.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mt6397.c
[ ... ]
> @@ -40,13 +62,24 @@ static const struct mtk_pinctrl_devdata mt6397_pinctr=
l_data =3D {
>  static int mt6397_pinctrl_probe(struct platform_device *pdev)
>  {
>  	struct mt6397_chip *mt6397;
> +	const struct mtk_pinctrl_devdata *data;
> +
> +	data =3D device_get_match_data(&pdev->dev);
> +	if (!data)
> +		return -ENOENT;
> =20
>  	mt6397 =3D dev_get_drvdata(pdev->dev.parent);
> -	return mtk_pctrl_init(pdev, &mt6397_pinctrl_data, mt6397->regmap);
> +	return mtk_pctrl_init(pdev, data, mt6397->regmap);
>  }
> =20
>  static const struct of_device_id mt6397_pctrl_match[] =3D {
> -	{ .compatible =3D "mediatek,mt6397-pinctrl", },
> +	{
> +		.compatible =3D "mediatek,mt6392-pinctrl",
> +		.data =3D &mt6392_pinctrl_data
> +	}, {
> +		.compatible =3D "mediatek,mt6397-pinctrl",
> +		.data =3D &mt6397_pinctrl_data
> +	},
>  	{ }
>  };

[Severity: High]
This is a pre-existing issue, but does mtk_pinctrl_driver in
drivers/pinctrl/mediatek/pinctrl-mt6397.c need a .remove callback or
suppress_bind_attrs set to true to prevent unbinding?

In drivers/pinctrl/mediatek/pinctrl-mtk-common.c:mtk_pctrl_init(), the driv=
er
allocates the pctl and pctl->chip structures using devm_kzalloc() but
registers the GPIO chip using the unmanaged gpiochip_add_data() API:

mtk_pctrl_init() {
    ...
    pctl->chip =3D devm_kzalloc(&pdev->dev, sizeof(*pctl->chip), GFP_KERNEL=
);
    ...
    ret =3D gpiochip_add_data(pctl->chip, pctl);
    ...
}

If the driver is unbound via sysfs, the devm_ subsystem will free the memory
backing the GPIO chip while it remains registered with the core subsystem.
Could this lead to a use-after-free if the GPIOs are accessed after the
driver is unbound?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260621081634.4678=
58-1-l.scorcia@gmail.com?part=3D7
