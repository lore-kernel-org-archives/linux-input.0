Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909903B9D95;
	Thu, 20 Aug 2026 12:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787230294; cv=none; b=m88F7w18Rbn1w1fQsLWihIgGqvZSzsJJ2LrriS8sCg6ysrZvSCmybJFXcEhBi6GTPt27x3Hm0yWe4Usm3oVf4qhjrS7CPuHbomOemGTeuPUMwNmbJXjIu7qBpz/NdYyupOZc8jgwQlaDjrpaGqcUYlXm0Ww6+8iUZwm9POa3tCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787230294; c=relaxed/simple;
	bh=UEFv4ubkzDDyVMEhHdp8Lzmf6vORnx9nUz7O8vn5tkw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pcJjw+1DFaBG7Pm3MnaxQp7rNetv+BBUdXfcWPdfTMzV0Gl9i254JSTg+DEpMFdG5rm3+yb+Q9axqicAtYbPbhqz4GWGJzO6BrXAjH0u/ebT9B93RMww7zcH7ght4Um+Y64CoZh9wNqD/tJlZQSsOS9wuoJ5EVAPUJEcMH/f/vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rnf99V00; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rnf99V00"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A39F21F00A3F;
	Thu, 20 Aug 2026 12:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787230291;
	bh=Pzjl1UYb/W+1/Deq4qM5a7bfuySZtGdlOKcNfGH5BVk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rnf99V004Ay9UkWAy3kvJePPzSdIlr0m26qGHvbmedH36pCa7sZDzzD4YXmD8DluL
	 bXAp7kSPnETnLKz/uLDNQq//4EOUop/Rpah7ryf/AAwKd7E1I+BSmgrPw8sK/ZN/1R
	 CSqUNZhWvgRawoe3GmnNdAkjKX/cNldGoe/q+NrhCLRHH/V/YGzphSRbPySnR9vkMZ
	 NeR9oO9cQaN9dgiMoNYRDIbBZ7pIrvLKsSDu2nf/4n/+17aJLugIIYvjDoYUeCIqG5
	 2MhWJqYJ8rLatvYfOc6n3XRyXYz9QAdgN2XicI7neaW5fwQJjMD0ssKFEbUlnN6UdM
	 fVKY5xrxHrREw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 7/9] pinctrl: mediatek: mt6397: Add MediaTek MT6392
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luca Leonardo Scorcia" <l.scorcia@gmail.com>
Cc: robh@kernel.org, mfd@lists.linux.dev, devicetree@vger.kernel.org, lee@kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, conor+dt@kernel.org
In-Reply-To: <20260820122242.120039-8-l.scorcia@gmail.com>
References: <20260820122242.120039-1-l.scorcia@gmail.com>
 <20260820122242.120039-8-l.scorcia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 12:51:30 +0000
Message-Id: <20260820125130.A39F21F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unbinding the pinctrl driver leads to a Use-After-Free of the gpio=
chip structure because it is never unregistered.
--

--- Patch [7]: [PATCH v9 7/9] pinctrl: mediatek: mt6397: Add MediaTek MT639=
2 ---
commit 8de420548b885f3f527c1ef77d05dce6a4500878
Author: Luca Leonardo Scorcia <l.scorcia@gmail.com>

pinctrl: mediatek: mt6397: Add MediaTek MT6392
   =20
This commit adds support for the MT6392 pinctrl device by introducing its p=
ins
definition and updating the MT6397 driver to retrieve device data from the
match table.

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

[Severity: High]
This is a pre-existing issue, but does unbinding this driver lead to a
use-after-free of the gpiochip structure?

Looking at mtk_pctrl_init() in drivers/pinctrl/mediatek/pinctrl-mtk-common.=
c,
the pctl->chip memory is allocated using devm_kzalloc() but registered using
the unmanaged gpiochip_add_data() function:

drivers/pinctrl/mediatek/pinctrl-mtk-common.c:mtk_pctrl_init() {
    ...
    pctl->chip =3D devm_kzalloc(&pdev->dev, sizeof(*pctl->chip), GFP_KERNEL=
);
    ...
    ret =3D gpiochip_add_data(pctl->chip, pctl);
    ...
}

Since the MT6397 platform driver lacks a .remove callback to explicitly call
gpiochip_remove(), unbinding the driver via sysfs causes devres to free
pctl->chip while it remains registered in the global gpiolib lists.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820122242.1200=
39-1-l.scorcia@gmail.com?part=3D7
