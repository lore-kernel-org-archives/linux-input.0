Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7AA1BBBFC;
	Sat, 20 Jun 2026 20:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781986828; cv=none; b=R3m9m1l/gETILHVuVKr72TBcO7oZoiwmENpQEKSghcwyhZbdoyKto1DbVGa9/rGyB9ARyV5+XhTvZmJibJLJMcct+Z2r1iKq0CPcRPXaJqlX4tlCqNmx7CpgX+gkjlf5JeTv6afm8xzz9kEZgwZAfEyxixQbfil9E2pLibvx2Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781986828; c=relaxed/simple;
	bh=nqYqjOk4j+oE7aCDJPEoB/JCtbtNCbBIPOo07TX9kRA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mpEQSnd2VGSn7mcgRDMtYbSZKb6Q5xvsmFwdcrP9sH1L05jwWIA3AEb4VnfhZP1xK057e7fSidkA9qL+4urzrWWIgbvFmBvrLcnfpmQJYeF9nL0sw9vbX/lq0Qpfl/eYyd0O40L3UBQl/ggY0IaQ6fGssix01jSAyRqxDXSAaKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CdvK8dLA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CdvK8dLA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60DA61F000E9;
	Sat, 20 Jun 2026 20:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781986827;
	bh=ewSJ83lhVOKCYpslreUMagMR8vYWz99qTIX7kbQlz1g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CdvK8dLAHTloAw3rZ+jslaBlJaUjHI46eWn/3UCnldjhqCuirv5fpcaKPcPa8oLqS
	 wdzA2s3kkSuMQI3jpuAjSTAfku9AhIfaJUdAlMO01h2FN7w10270X3wlFQYwVI1ovn
	 jF+XIR/ARLjE9nhzp88byLhQ0vwQ/EqxhfjcGRJBzQtCHdC970bGqZxkWa0G8ZOTtt
	 x0nwi8sOAOY4VLCgBv+sB2IqqBOg5BDTB+0vzU8INRvVgbiJ8aoUjP3sRvLYZAf0af
	 faA2P6/Gje9mh0VnQmn0PkmFAHc6lWkgUcRBs7VQjQQnp5QYIhlQjbl0JU9wZaVM20
	 dN3HZWaSJmtQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 5/9] mfd: mt6397: Add support for MT6392 PMIC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luca Leonardo Scorcia" <l.scorcia@gmail.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, robh@kernel.org
In-Reply-To: <20260620200032.334192-6-l.scorcia@gmail.com>
References: <20260620200032.334192-1-l.scorcia@gmail.com>
 <20260620200032.334192-6-l.scorcia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 20:20:27 +0000
Message-Id: <20260620202027.60DA61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing unregister_pm_notifier() causes Use-After-Free of PM notif=
ier block on probe error and driver unbind.
- [High] The IRQ domain is created with a hardcoded size of MT6397_IRQ_NR (=
32), which breaks PMICs like MT6328 that use a third interrupt register (hw=
irqs 32-47).
- [High] `mt6397_irq_pm_notifier` modifies IRQ mask registers concurrently =
with running tasks, causing race conditions.
--

commit 15d5fe2891c82970874377c126d0244fd87f5699
Author: Fabien Parent <parent.f@gmail.com>

mfd: mt6397: Add support for MT6392 PMIC

Align the MT6397 PMIC driver to other MFD drivers by passing only an
identifier through mt6397_of_match[*].data and add support for the MT6392
PMIC and its regulator, RTC, keys and pinctrl devices.

> diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
> index ccd97d66d7f1c..f683e878543e1 100644
> --- a/drivers/mfd/mt6397-core.c
> +++ b/drivers/mfd/mt6397-core.c
[ ... ]
> @@ -278,6 +311,7 @@ static int mt6397_probe(struct platform_device *pdev)
>  	unsigned int id =3D 0;
>  	struct mt6397_chip *pmic;
>  	const struct chip_data *pmic_core;
> +	int chip_variant;
> =20
>  	pmic =3D devm_kzalloc(&pdev->dev, sizeof(*pmic), GFP_KERNEL);
>  	if (!pmic)
> @@ -293,9 +327,36 @@ static int mt6397_probe(struct platform_device *pdev)
>  	if (!pmic->regmap)
>  		return -ENODEV;
> =20
> -	pmic_core =3D of_device_get_match_data(&pdev->dev);
> -	if (!pmic_core)
> +	chip_variant =3D (unsigned int)(uintptr_t)device_get_match_data(&pdev->=
dev);
> +	switch (chip_variant) {
[ ... ]
> +	case MT6392_CHIP_ID:
> +		pmic_core =3D &mt6392_core;
> +		break;
[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but looking at the error path of
mt6397_probe() in drivers/mfd/mt6397-core.c:

	ret =3D pmic_core->irq_init(pmic);
	if (ret)
		return ret;

	ret =3D devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE,
				   pmic_core->cells, pmic_core->cell_size,
				   NULL, 0, pmic->irq_domain);
	if (ret) {
		irq_domain_remove(pmic->irq_domain);
		dev_err(&pdev->dev, "failed to add child devices: %d\n", ret);
	}

	return ret;

Since mt6397_irq_init() registers a PM notifier with register_pm_notifier(),
if devm_mfd_add_devices() fails (or when the driver is unbound), the devres
cleanup will automatically free the pmic structure containing the pm_nb
notifier block.

Because unregister_pm_notifier() is never called in this error path or in a
remove callback, will this leave a dangling pointer in the PM subsystem that
causes a Use-After-Free during the next suspend/resume cycle?


> diff --git a/drivers/mfd/mt6397-irq.c b/drivers/mfd/mt6397-irq.c
> index 5d2e5459f7444..80ea5b92d232f 100644
> --- a/drivers/mfd/mt6397-irq.c
> +++ b/drivers/mfd/mt6397-irq.c
[ ... ]
> @@ -203,6 +205,12 @@ int mt6397_irq_init(struct mt6397_chip *chip)
>  		chip->int_status[0] =3D MT6397_INT_STATUS0;
>  		chip->int_status[1] =3D MT6397_INT_STATUS1;
>  		break;
> +	case MT6392_CHIP_ID:
> +		chip->int_con[0] =3D MT6392_INT_CON0;
> +		chip->int_con[1] =3D MT6392_INT_CON1;
> +		chip->int_status[0] =3D MT6392_INT_STATUS0;
> +		chip->int_status[1] =3D MT6392_INT_STATUS1;
> +		break;
> =20
>  	default:
>  		dev_err(chip->dev, "unsupported chip: 0x%x\n", chip->chip_id);

[Severity: High]
This is a pre-existing issue, but further down in mt6397_irq_init() in
drivers/mfd/mt6397-irq.c, the linear IRQ domain is allocated with a hardcod=
ed
size:

	chip->irq_domain =3D irq_domain_create_linear(dev_fwnode(chip->dev), MT639=
7_IRQ_NR,
						    &mt6397_irq_domain_ops, chip);

Since MT6397_IRQ_NR is 32, but PMICs like MT6328 use a third interrupt
status register for hardware IRQs 32-47:

	if (mt6397->int_status[2])
		mt6397_irq_handle_reg(mt6397, mt6397->int_status[2], 32);

Won't irq_find_mapping() silently fail to find a mapping for any interrupts
at index 32 or higher, breaking functionality for those higher-numbered
interrupts?


[Severity: High]
This is also a pre-existing issue, but mt6397_irq_pm_notifier() in
drivers/mfd/mt6397-irq.c writes directly to the PMIC's interrupt control
registers without locking:

	case PM_SUSPEND_PREPARE:
		regmap_write(chip->regmap,
			     chip->int_con[0], chip->wake_mask[0]);

Because PM_SUSPEND_PREPARE runs before user tasks are frozen, running tasks
can concurrently request or enable an IRQ. When this happens,
mt6397_irq_sync_unlock() will acquire irqlock and write irq_masks_cur
to the same registers:

	regmap_write(mt6397->regmap, mt6397->int_con[0],
		     mt6397->irq_masks_cur[0]);

Could this concurrent modification overwrite the suspend configuration
established by the notifier, leading to lost wakeup sources or spurious
interrupts?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620200032.3341=
92-1-l.scorcia@gmail.com?part=3D5
