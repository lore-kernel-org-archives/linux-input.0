Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A6E126C03;
	Sun, 21 Jun 2026 08:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782030781; cv=none; b=EyiIb2ypW8ELNe5rzLLjFuB6sNEF776wtwCulJ3wKedwAQ1gEFEddb5YHc2+wwOnl1FHooTx0uDJzCehX1yWAbkcTFRnNMWpoHYpGAPxcpzHe/DqFrv9Q4/hRyQ+yGXpU8yUXY/jnIOIwl5WoNv40hZdeWCO/fiyxKT7MLbLtdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782030781; c=relaxed/simple;
	bh=GsyAk229epwydEczcQfxV9WUcE3uEaj3DSmLh17kPwA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KMBuiwi2rj9BOZE4EI0IXlruwkL2LgPstSPi8H2J6iXeo9UJsP+LZCuWNSyZ1ki5XiKm6gg7ah9HW6Y11Hf7o61j+8swM9ADaUZ4R5gVGQCtbVV4p1sgB1CVvlgAtQrI+mposOrYPZfLzmd6J2hc6/wAXX8y0m7ocRbprD+H7/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MckkBvAz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MckkBvAz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D1341F000E9;
	Sun, 21 Jun 2026 08:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782030780;
	bh=nwzGPB5zlAVlOkzZgKftxKtPElNz3U5tOd3O0wWwmDY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MckkBvAzsFMuxd8nvMdgeqY3CcpIFUh7FfJIdRZy9Y48g0XuSt10TIlQapDNXRuTJ
	 BxZiOo6kHDrPRthc3t1qyO2Rox5trG5blgbhD6oLIctJvPneUMd5ob9R9NkUHzUgbN
	 sJVQ+JeacM3rNtHsea6fT2VLWQCfq328gCdBfsqELBdBiYmsMP9bgP5myh4W5Tz3pu
	 CNSZ7peQ9qh18yAanuac2ajBo/wVPP/T9SSwmUaJMHsk6EyyFstakkeuOzwesIxjLq
	 1LHBctNGmCuksezsBpr59TIKnoOVxtrxx5UoGktr1Ol1xiCVn7Hdbv7ypa0pxrnskF
	 vkh1+V0dxFOzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 5/9] mfd: mt6397: Add support for MT6392 PMIC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luca Leonardo Scorcia" <l.scorcia@gmail.com>
Cc: conor+dt@kernel.org, dmitry.torokhov@gmail.com, devicetree@vger.kernel.org, linux-input@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260621081634.467858-6-l.scorcia@gmail.com>
References: <20260621081634.467858-1-l.scorcia@gmail.com>
 <20260621081634.467858-6-l.scorcia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 21 Jun 2026 08:32:59 +0000
Message-Id: <20260621083300.3D1341F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Resource leaks and Use-After-Free due to missing PM notifier teard=
own
- [High] Race condition in PM notifier causing lost IRQ hardware state
--

commit 4936b4ce67a0024573fa33154f81b91a5d2261b2
Author: Fabien Parent <parent.f@gmail.com>

mfd: mt6397: Add support for MT6392 PMIC

Align the MT6397 PMIC driver to other MFD drivers by passing only an
identifier through mt6397_of_match[*].data and add support for the MT6392
PMIC and its regulator, RTC, keys and pinctrl devices.

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
This isn't a bug introduced by this patch, but does the global PM notifier
leak if probe fails?

The PM notifier is registered globally at the end of mt6397_irq_init() with=
out
using a devm_action wrapper:

	register_pm_notifier(&chip->pm_nb);
	return 0;

If probe fails after IRQ initialization (for example, if
devm_mfd_add_devices() fails in mt6397_probe()), or if the driver is unbound
via sysfs, devres frees the pmic structure while the PM notifier remains
active in the global kernel chain.

Could the next system suspend/resume cycle then call the notifier callback
on freed memory, leading to a crash?

Additionally, does the irq domain leak on unbind since mt6397_driver lacks a
.remove callback entirely?

[Severity: High]
This is a pre-existing issue, but can the PM notifier corrupt hardware stat=
e?

The PM notifier callback (mt6397_irq_pm_notifier) writes to the int_con
hardware registers using cached masks without acquiring chip->irqlock:

	case PM_SUSPEND_PREPARE:
		regmap_write(chip->regmap,
			     chip->int_con[0], chip->wake_mask[0]);

However, core IRQ functions like mt6397_irq_sync_unlock() modify the exact
same int_con registers safely under the protection of irqlock:

	regmap_write(mt6397->regmap, mt6397->int_con[0],
		     mt6397->irq_masks_cur[0]);

Since user tasks are still running during PM_SUSPEND_PREPARE and are already
thawed prior to PM_POST_SUSPEND, concurrent calls to enable_irq(),
disable_irq(), or irq_set_wake() can interleave register reads and writes.

Could this cause the hardware to be programmed with stale interrupt masks or
overwrite the suspend wake mask, leading to dropped device interrupts or a
failure to wake the system?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260621081634.4678=
58-1-l.scorcia@gmail.com?part=3D5
