Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559A7445ACD;
	Thu, 20 Aug 2026 12:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787230172; cv=none; b=nq89w5mZqcSK6b5aHlFnxtU7lOLiaWtH2vRxeSiQ1Vq0Ge3xYLuCxLb7Jmv7mnehsJf6FQsEQXeWHZNCeSndLmum4foJVSkYtqgfsUoNU/Gbi3OPoYKJ7TnKQGm1CROGOPDZmek2tMeLdBB6dcdh6R6ehylNlllmgWnfCWm1AWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787230172; c=relaxed/simple;
	bh=xE0p8m++YDXS3YmOmgja7/ReG9oPfXfX/0QnZybqu4Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QgLw2lZ2LH2q1sMdTk0wr9bAuSPFBPoqAcE0lpLTVnI2oyIOyAwCJyxhSmB12bA9NXR2E631ssVWzEKqaoMPCy6VZdCyQQuKihIdIsx3vWUQWCvRidV0RrzTb3CIotXVR2NGQwEaX35057FMtA+6pLoc/Gv5DpEcbG81HWWpOUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dq2FRhbe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dq2FRhbe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F0C1F00A3D;
	Thu, 20 Aug 2026 12:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787230169;
	bh=xdx7D143mLod2cAuh4bgbq09JTWMkluu/t4/ZJdPYYY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Dq2FRhbeoGDmpjodvuPBAud5WdkSnEpF/XoEpTEMkPKxHGabim+2IeLKJ8ER8xwYs
	 EpiPNs4m/VL+z9LX+fh4qdlRd8tHWipyfyY4gh1ZiVUDjj5XbKv3uBCzAnFTTqr61n
	 fJ3anqSOrpZy6slFxldRKBmKE/Aw39vehV1b+shTS5WfMcHsOhtROFMxFRNFWE74oN
	 N1xCP9VCoNh38s7PbzXh/ihZa13u+XR7nivc0uAU2H/VeDIpFxMKrf8x9UvQrwjvy/
	 DlCa5f8hHSrlU0Z3aNM4jWfTAZ1f/Fi9iU30VzKtD1bNR6q/FzovdBjkGPmvSAAt+2
	 4wvJ3kToSzTPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 5/9] mfd: mt6397: Add support for MT6392 PMIC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luca Leonardo Scorcia" <l.scorcia@gmail.com>
Cc: conor+dt@kernel.org, dmitry.torokhov@gmail.com, mfd@lists.linux.dev, lee@kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260820122242.120039-6-l.scorcia@gmail.com>
References: <20260820122242.120039-1-l.scorcia@gmail.com>
 <20260820122242.120039-6-l.scorcia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 12:49:29 +0000
Message-Id: <20260820124929.78F0C1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [Low] Driver-specific header files for MT6392 are placed in the global `i=
nclude/linux/mfd/` directory.

Pre-existing issues:
- [High] Missing resource teardown for the PM notifier and IRQ domain on de=
vice unbind and probe error paths, leading to memory leaks and a Use-After-=
Free crash.
- [High] The IRQ domain is created with a hardcoded maximum size of 32, tru=
ncating the IRQ space for chips like MT6328 that require up to 47 IRQs.
- [High] Race condition on probe failure between irq_domain removal and act=
ive threaded IRQ handler.
- [High] The PM notifier modifies hardware IRQ registers without holding th=
e irqlock mutex, potentially breaking system wakeup functionality.
--

--- Patch [5]: [PATCH v9 5/9] mfd: mt6397: Add support for MT6392 PMIC ---
commit b2217cbb3b951021ff7eb4a8b7e1f3c678b7c4bc
Author: Fabien Parent <parent.f@gmail.com>

mfd: mt6397: Add support for MT6392 PMIC

This commit modifies the MT6397 driver to use identifier matching instead
of passing core structures in the data field. It also introduces support
for the MT6392 PMIC, including its regulators, RTC, keys, and pinctrl.

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

[Severity: High]
This is a pre-existing issue, but is there a use-after-free race on the
probe error path?

If devm_mfd_add_devices() fails further down in mt6397_probe(), the error
path calls irq_domain_remove(pmic->irq_domain) to explicitly free the
domain memory. However, the devm-managed threaded IRQ handler remains fully
active until the probe function returns. If an interrupt triggers during th=
is
window, could mt6397_irq_thread() call irq_find_mapping() and dereference
the freed irq_domain pointer?

[Severity: High]
This is another pre-existing issue, but does the device unbind path leak
resources and cause a crash?

If devm_mfd_add_devices() fails, or if the driver is unbound, the PM
notifier registered in mt6397_irq_init() via register_pm_notifier() is
never explicitly unregistered because mt6397_driver lacks a .remove callbac=
k.
Since devres frees the mt6397_chip structure, would a subsequent suspend or
resume event traverse the global notifier list and dereference this freed
pointer?

> diff --git a/drivers/mfd/mt6397-irq.c b/drivers/mfd/mt6397-irq.c
> index 5d2e5459f7444..80ea5b92d232f 100644
> --- a/drivers/mfd/mt6397-irq.c
> +++ b/drivers/mfd/mt6397-irq.c
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
This is a pre-existing issue, but does the hardcoded domain size cause
interrupts to be dropped?

Further down in mt6397_irq_init(), the IRQ domain is created unconditionally
with MT6397_IRQ_NR (which is 32):

    chip->irq_domain =3D irq_domain_create_linear(dev_fwnode(chip->dev),
                                                MT6397_IRQ_NR,
                                                &mt6397_irq_domain_ops,
                                                chip);

Since the MT6328 chip requires up to 47 IRQs, could mt6397_irq_thread()
fail when calling irq_find_mapping() for interrupts exceeding the allocated
linear domain size of 32?

[Severity: High]
This is also a pre-existing issue, but does the PM notifier overwrite
wake masks without synchronization?

The mt6397_irq_pm_notifier() writes to the hardware interrupt control
registers to set wake masks during PM_SUSPEND_PREPARE without acquiring
chip->irqlock:

    case PM_SUSPEND_PREPARE:
        regmap_write(chip->regmap, chip->int_con[0], chip->wake_mask[0]);

If a child device driver alters an IRQ state during its own suspend phase,
could the bus unlock callback mt6397_irq_sync_unlock() concurrently write
chip->irq_masks_cur to the same registers and overwrite the configured
wake masks?

> diff --git a/include/linux/mfd/mt6392/core.h b/include/linux/mfd/mt6392/c=
ore.h
> new file mode 100644
> index 0000000000000..8777b3abf9292
> --- /dev/null
> +++ b/include/linux/mfd/mt6392/core.h
> @@ -0,0 +1,43 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2020 MediaTek Inc.
> + * Copyright (c) 2026 Luca Leonardo Scorcia <l.scorcia@gmail.com>
> + * Author: Chen Zhong <chen.zhong@mediatek.com>
> + */
> +
> +#ifndef __MFD_MT6392_CORE_H__
> +#define __MFD_MT6392_CORE_H__

[Severity: Low]
Are these driver-specific header files placed correctly? The MFD subsystem
guidelines state that driver-specific headers should not be placed in the
global include/linux/mfd/ directory if they are only used by the parent
and immediate children. Should these instead be kept local to drivers/mfd/?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820122242.1200=
39-1-l.scorcia@gmail.com?part=3D5
