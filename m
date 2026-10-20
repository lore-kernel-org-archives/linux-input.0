Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792518540;
	b=UsD/37+PCkxV2lJ6QFSCLcN3itTffIbIKUlYKJaJS2Q/tw+FzWJML+ijQXb1wFq5CRXH
	 7H5tcYa7HhdrIco0zQY3sYgLnvdvwOAJmv5Ga2JNTZrMWpi1+xjuOirJp8h/Sf7kxVXvK
	 LmULP7NMYltDT5P7o7y38DgZdDqMLsVrfe1AO5GRiyxOkaggESGpx9AVFBK8GUtLAzY9P
	 UeoKOjSfV9MgF2SovPr/QaklW87SoIFQwZwzQzAHhz1+7OOcSQGu8ZIyw/WgAI3xupEXk
	 wABadRhkL/MJua58ML5FjPTvupHAGudee0Qiy+BHEAi2kgPyvIJ0Uw4HsgvqkokBq5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792518540;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=M5rEvmXrfBoBjTv0yUsniidEuInq+pNnzfLGGWa+i24=;
	b=AHWQijTNFY5N4cHL5cD9e9AtDFiSUBEYvmrH3nKt0G8cmTZFMy70qTFaxRLrFhr4WMK1
	 0PcDuwmpXbd6pWpUpqNzpNXbouPWW6DDIKMxR6ByvoOFV+0Ot3rmRbrW/svfevDNI/Uzz
	 kPGm3057+vzm8+HniUY6ahmNKr9Camqh+EkWoO6kjPdwEKRdv94Qo7YdhgQK0NSzGyhIt
	 E7HzKzuhsF4dc3yKZnl+onkw/0PVJ19/+Ydpq2LliCwRfK+ixsgjikl3WsgDabmnvMsyv
	 zjhiQ72JKg2w1nxrJ6vO+M30mRoL3cadKrnuYqzDhOF/vlAnlP/d1X6wja6eSxTUSGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=chjXc4qA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861D4606A319;
	Tue, 20 Oct 2026 17:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=chjXc4qA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6AB1F000C9;
	Tue, 20 Oct 2026 17:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792518540;
	bh=M5rEvmXrfBoBjTv0yUsniidEuInq+pNnzfLGGWa+i24=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=chjXc4qAETnD4VJQELmcQKY/u6qH974D2R065xAxVyPkDopxayIqEbdJpC52GSQaL
	 8pydFBJ/Ql0G6dbM9fn7enoI3zLEJeACf5PjyPB7V+vKgefgI0bHe4OjUlPMHkrWhv
	 fmqFGFYSP4OGEyGu6i2YSBsKVZE8/TqIOuekFombtkfCPcyHUYG0LFnacs4dPKJaSu
	 D8tggGUYGUsCc4hqQbyn2b2X087hOPET98XAjrfokCr2+tRSK3A7JPhn5LT9puCkI5
	 07cwehTD7fYj6h4Fmy8AS7GvSt+7rhX1hKyuM5je5yhRcQv4+/IojcU3b68xu6hbY3
	 CTQQkzkVgwhFw==
Message-ID: <sashiko-outbox-179446@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v10 8/9] regulator: Add MediaTek MT6392 regulator
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luca Leonardo Scorcia" <l.scorcia@gmail.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, mfd@lists.linux.dev, linux-gpio@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com, lee@kernel.org
In-Reply-To: <20261020173556.632798-9-l.scorcia@gmail.com>
References: <20261020173556.632798-1-l.scorcia@gmail.com>
 <20261020173556.632798-9-l.scorcia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 17:48:58 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] regulator: mt6392: OF node reference leak in mt6392_regulator_pr=
obe()
--

commit 04b22037bb949a80f26c6f5651752d61ee106b28
Author: Fabien Parent <parent.f@gmail.com>

regulator: Add MediaTek MT6392 regulator

This commit adds a regulator driver for the MediaTek MT6392 PMIC.

> diff --git a/drivers/regulator/mt6392-regulator.c b/drivers/regulator/mt6=
392-regulator.c
> new file mode 100644
> index 0000000000000..3db52268363e0
> --- /dev/null
> +++ b/drivers/regulator/mt6392-regulator.c
> @@ -0,0 +1,764 @@

[ ... ]

> +static int mt6392_regulator_probe(struct platform_device *pdev)
> +{
> +	struct mt6397_chip *mt6392 =3D dev_get_drvdata(pdev->dev.parent);
> +	struct regulator_config config =3D {};
> +	struct regulator_dev *rdev;
> +	int i;
> +
> +	device_set_of_node_from_dev(&pdev->dev, pdev->dev.parent);
> +
> +	// Initialize the bucks' vsel_reg and vsel_mask according to current HW=
 state
> +	if (mt6392_set_buck_vsel_reg(pdev))
> +		return -EIO;
> +
> +	config.dev =3D mt6392->dev;
> +	config.regmap =3D mt6392->regmap;

[Severity: Medium]
Does calling device_set_of_node_from_dev() here leak a reference on
pdev->dev.parent->of_node when the platform device is released?

In drivers/mfd/mt6397-core.c, the mt6392-regulator cell is defined without =
an
of_compatible string, so mfd_add_device() allocates the child device via
platform_device_alloc() with pdev->dev.of_node and pdev->dev.fwnode set to
NULL.

Calling device_set_of_node_from_dev() in mt6392_regulator_probe() increments
the reference count on pdev->dev.parent->of_node and assigns it to
pdev->dev.of_node, without setting pdev->dev.fwnode:

drivers/base/core.c:device_set_of_node_from_dev() {
	of_node_put(dev->of_node);
	dev->of_node =3D of_node_get(dev2->of_node);
	dev_set_of_node_reused(dev);
}

When the platform device is later torn down, platform_device_release() only
puts pa->pdev.dev.fwnode:

drivers/base/platform.c:platform_device_release() {
	...
	if (!is_software_node(dev_fwnode(dev)))
		fwnode_handle_put(pa->pdev.dev.fwnode);
	...
}

Since pdev->dev.fwnode remains NULL, fwnode_handle_put() is a no-op and the
reference on pdev->dev.of_node is never dropped.

Also, since config.dev is already set to mt6392->dev (the parent device),
which the regulator core uses for DT node and supply lookups, could the
device_set_of_node_from_dev() call simply be dropped (or replaced with
platform_device_set_of_node_from_dev() if needed)?

[ ... ]

> +	return 0;
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020173556.6327=
98-1-l.scorcia@gmail.com?part=3D8
