Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD1B358360;
	Sat, 20 Jun 2026 20:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781986608; cv=none; b=G1rGI+o+Fe8EtbsElu+awUv0TEXJK72KwFEWQ3IOFvUCHXD8hYY3fC87MNz2FKCIf5aJgHanYuZY1QIMtqS0S+cYEDaWz34nNemFxqlRtgSYn66pPphDgn/zRZii4fyJx8quPPLjnIxPlCnhX+s5JFHc9n46wcumgKZUyf0SrW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781986608; c=relaxed/simple;
	bh=vj3ImRMWodpY9FllxyNiZV6Cym2RgZm91uhXi3J+NuQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kzmiwAGE6kORohtxj9ZZSKJ//frFCHFUUR0iSk1nr+qYnpw+zufnHDpLWXuNMCY5rBcnZKgrS7ZL1DfgKaVPod6H/J0PY+/q0wLVTlCqsRZ/xvbaj1Nlc7f/c3mLlU67MIJnptKQoF//jhW4yfSYFFMZgLjuxpRfPYj0dXNtIe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTE2Ku2Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTE2Ku2Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB5751F000E9;
	Sat, 20 Jun 2026 20:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781986607;
	bh=8QUyYWD/qhFEMT7av/3V09I/iqH+Z806MnS05K8thAk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QTE2Ku2YsVJ7JYCqmbsZeASVr33eUtslf0VB4HxPOgDXf0IWsuQj2FyWdHnLIP3U3
	 j8qBUCLs8mCxv8AcSxlagOpxBN944AgBYBehp7b7KnLggEjmYE4k7b6nLeDgOdNRva
	 oa11mm+7JwTTsvi+MQEPOKQcKQbWhV+qOtMDqkncqd81Nqmn08JIAGF2eZnG+ILykC
	 lzigSurfsKfS5d3hPQEu7HrRMpsFobmNbZkXQdsnGMtFOIOXXtJFtR9TfKaUJSLs2P
	 XDm3x/UoVtdL1uvKLn4IX6/cVVMnj5WF5xGWWQfYBwjixweydf+NMmmsR7j8q8j/dh
	 9CN1rQmOcaXzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 7/9] pinctrl: mediatek: mt6397: Add MediaTek MT6392
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luca Leonardo Scorcia" <l.scorcia@gmail.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260620200032.334192-8-l.scorcia@gmail.com>
References: <20260620200032.334192-1-l.scorcia@gmail.com>
 <20260620200032.334192-8-l.scorcia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 20:16:46 +0000
Message-Id: <20260620201646.EB5751F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] NULL pointer dereference triggered on `gpio_to_irq()` for MT6397 p=
ins.
- [High] Use-After-Free in gpiolib due to missing devres registration and `=
.remove` callback.
- [High] Use-After-Free in IRQ handler from non-devres chained handler regi=
stration.
--

commit b7ca497bf50208e7b29acdf520d006f2e9f79e4b
Author: Luca Leonardo Scorcia <l.scorcia@gmail.com>

pinctrl: mediatek: mt6397: Add MediaTek MT6392
   =20
Add support for the MT6392 pinctrl device, which is very similar to
MT6397 with a handful of different property values and its own pins
definition.
   =20
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

[Severity: High]
This is a pre-existing issue, but does mtk_pctrl_init() leave pctl->eint
uninitialized for these devices, leading to a NULL pointer dereference?

Because neither mt6392_pinctrl_data nor mt6397_pinctrl_data initialize
the eint_hw field, mtk_pctrl_init() skips mtk_eint_init().

If gpio_to_irq() is later invoked on these pins, it calls down through:

mtk_gpio_to_irq()
   mtk_eint_find_irq(pctl->eint, eint_n)
      irq_find_mapping(eint->domain, eint_n)

Will this dereference the NULL pctl->eint pointer directly?

[Severity: High]
This isn't a bug introduced by this patch, but does the driver lack proper
devres cleanup for the gpiochip?

In mtk_pctrl_init(), pctl->chip is allocated using devm_kzalloc() and
then registered globally:

mtk_pctrl_init()
   pctl->chip =3D devm_kzalloc(...)
   gpiochip_add_data(pctl->chip, pctl)

Since gpiochip_add_data() does not use devres tracking, and the driver
lacks a .remove callback or suppress_bind_attrs, unbinding the driver
via sysfs will immediately free pctl->chip. Can this leave a dangling
pointer in gpiolib, leading to a use-after-free?

[Severity: High]
This is also a pre-existing issue, but does the IRQ handler registration
capture a devm-allocated pointer without devres tracked cleanup?

For MediaTek pinctrl devices that do initialize EINT, mtk_eint_do_init()
registers the chained handler:

mtk_eint_do_init()
   irq_set_chained_handler_and_data(eint->irq, mtk_eint_irq_handler, eint)

If the driver is unbound, the devm allocated eint structure will be freed.
Does the lack of a cleanup function mean the subsystem could later trigger
mtk_eint_irq_handler() with the freed eint pointer?

>  }
> =20
>  static const struct of_device_id mt6397_pctrl_match[] =3D {
> -	{ .compatible =3D "mediatek,mt6397-pinctrl", },
> +	{
> +		.compatible =3D "mediatek,mt6392-pinctrl",
> +		.data =3D &mt6392_pinctrl_data
> +	}, {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620200032.3341=
92-1-l.scorcia@gmail.com?part=3D7
