Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC384446E3;
	Thu, 20 Aug 2026 12:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787229611; cv=none; b=idga7i3KT8haoORJPjus+YiRRDUtKNOkR3SdZyrTiDFtsY6njH21Rzr9R323blWLsNIOt60wfr8PT28lXsS7R0VZjUzgpxKkpyVfG4hNBUtIOaXNp8cBXBIeCevzRCP6eeyGXBdpMPDnnFtYXvbgkvHTGq7VkIINj7xATYXzKyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787229611; c=relaxed/simple;
	bh=C5Xs7MOrc7CdqAGLgB/tHXehONSi+t5sOTRN61qVZME=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z/YMN8EPFegf0AiDjiCGz9/aH4PKl4sQt1+rMlf/kbojPa1/MWnNUPvCx0g6zSSN8UE3yIZ8cIBUNIULBy99kcfey5BETN1wwY2jef7Y8ZiKzBHoLG15RFeaIFO5Ou2JCDk+ZxsXApuguSXy86o0bN1w0FX/shu2hnSYLGLfELs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFW+y65V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFW+y65V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDB421F00A3A;
	Thu, 20 Aug 2026 12:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787229609;
	bh=PPhZV3UHjs/Va/GxbjzeUaeaMCqWy/OjFpKcKTvsqWQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UFW+y65VUEpuWkxVgVKnqy77BLVl58/Ok366dGOPjm9VfODdIFnCq74VXANfirw2i
	 aXGLdMObk9mOxItCjdo/i9rHUza/MAVh71w7dolgMayVEvvQpR9EshDdkRERx+rAgI
	 x13Bg8rnZBRFbKjKr/muqepXSEFh6iBpFF8FOZ2957kwehEoRhv+orPSDTtpbc7+BC
	 WKWCE97MrFUgm1EwE7L5u0n/0nJGopEjvNvOwTMkGQqz9jXoUZ1+lg2Q7j4vUHauJq
	 7zPnXVN03dWCWIWJCu3KOCLMSpaHxxd2EhFjzKy8l5MRe1VGeqJoIrGaqb5d4bZc+O
	 rxlSHpOR5eavA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 8/9] regulator: Add MediaTek MT6392 regulator
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luca Leonardo Scorcia" <l.scorcia@gmail.com>
Cc: mfd@lists.linux.dev, conor+dt@kernel.org, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, lee@kernel.org, robh@kernel.org
In-Reply-To: <20260820122242.120039-9-l.scorcia@gmail.com>
References: <20260820122242.120039-1-l.scorcia@gmail.com>
 <20260820122242.120039-9-l.scorcia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 12:40:08 +0000
Message-Id: <20260820124008.CDB421F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The driver mutates the statically allocated global array `mt6392=
_regulators` during probe, causing data races and breaking support for mult=
iple PMIC instances.
--

--- Patch [8]: [PATCH v9 8/9] regulator: Add MediaTek MT6392 regulator ---
commit 942bc64d63d9355df7d6368a340ca5b124e3e738
Author: Fabien Parent <parent.f@gmail.com>

regulator: Add MediaTek MT6392 regulator

This patch introduces a new regulator driver for the MediaTek MT6392 PMIC.
It provides support for various power rails, including buck and LDO
regulators, controlled via regmap.

> diff --git a/drivers/regulator/mt6392-regulator.c b/drivers/regulator/mt6=
392-regulator.c
> new file mode 100644
> index 0000000000000..93fe887709c3b
> --- /dev/null
> +++ b/drivers/regulator/mt6392-regulator.c

[ ... ]

> +static int mt6392_set_buck_vsel_reg(struct platform_device *pdev)
> +{
> +	struct mt6397_chip *mt6392 =3D dev_get_drvdata(pdev->dev.parent);
> +	int i;
> +	u32 regval;
> +
> +	for (i =3D 0; i < MT6392_MAX_REGULATOR; i++) {
> +		if (mt6392_regulators[i].vselctrl_reg) {
> +			// Read the vselctrl_reg register
> +			if (regmap_read(mt6392->regmap,
> +					mt6392_regulators[i].vselctrl_reg,
> +					&regval) < 0) {
> +				dev_err(&pdev->dev,
> +					"Failed to read buck ctrl\n");
> +				return -EIO;
> +			}
> +
> +			// vselctrl_reg[vselctrl_mask] defines the mode
> +			if (regval & mt6392_regulators[i].vselctrl_mask) {
> +				// Regulator in Normal mode
> +				mt6392_regulators[i].desc.vsel_reg =3D
> +					mt6392_regulators[i].vsel_normal_mode_reg;
> +				mt6392_regulators[i].desc.vsel_mask =3D
> +					mt6392_regulators[i].vsel_normal_mode_mask;

[Severity: Medium]
Will this corrupt the configuration for previously registered devices if
multiple MT6392 PMIC instances are present?

This modifies the statically allocated global array mt6392_regulators based=
 on
per-instance hardware state. Because the regulator core keeps a pointer to =
the
provided desc, mutating it here affects all instances of the PMIC in the
system.

> +			} else {
> +				// Regulator in Register mode
> +				mt6392_regulators[i].desc.vsel_reg =3D
> +					mt6392_regulators[i].vsel_reg_mode_reg;
> +				mt6392_regulators[i].desc.vsel_mask =3D
> +					mt6392_regulators[i].vsel_reg_mode_mask;
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}

[ ... ]

> +static struct platform_driver mt6392_regulator_driver =3D {
> +	.driver =3D {
> +		.name =3D "mt6392-regulator",
> +		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,

[Severity: Medium]
Does enabling asynchronous probing introduce a data race with the global ar=
ray
modifications above?

If multiple PMIC instances are probed concurrently, they will race to overw=
rite
the vsel_reg and vsel_mask fields of the shared global mt6392_regulators ar=
ray
in mt6392_set_buck_vsel_reg().

> +	},
> +	.probe =3D mt6392_regulator_probe,
> +	.id_table =3D mt6392_platform_ids,
> +};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820122242.1200=
39-1-l.scorcia@gmail.com?part=3D8
