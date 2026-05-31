Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9142D5932;
	Sun, 31 May 2026 11:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780227338; cv=none; b=ggbfilkRQnF1qUXolMR5gwvSE1YWBDuFEohlii1ANBd8KVQMWTVijeUAYTq8fzl6S0rhg1qvzVEg3uGuullAev8cA2ASuDFwGByoU2nmGkFOItODTdSklQ2FJ3OUEco2B62+tzHBibxBX9+zv1cEQ4l4Gsc6HFYJN3YzZBewiCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780227338; c=relaxed/simple;
	bh=YEZer5V6vJ4HnAEqjqnsDrP4jU0rBZc5t9dsEcPlB00=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ImOzFKe9/weQFNc1EbtzO84dBfJJUTVjdkVUKzmY2ufF7iZ89/wRBLTUbVpjPqSLzvDw0aKM0xAt+mNG2RWQE0XdPjXxqM3gM32BoIFEyjwcpzqt2dqT12REXaj1vPA9vAZCoKeikbFfuPJXRKQMsB6QxWCpb7dj2pfMlJtZCR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gc6nXkQ2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gc6nXkQ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B90DB1F00893;
	Sun, 31 May 2026 11:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780227337;
	bh=O3avWq1lbvwq1pBcFDjiQSRQE6y+pfEhNounT8iGo7A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gc6nXkQ2CEr/TvpZnbMQJg1GlMNe1KUZHG9Ef0zb2fViq7F9L7ajpmnrDEc9K+Xsy
	 x0N45cioPTMtJybgBtBSPdV9UVH+n0dV3SSOSJJ1D+EEOIgSR25uuEIxkBDl7aE/bI
	 2tQq3zMppKxpRR55R5Z60Gle/UOFdg9MixVVDh3+w+8bD0vMHqa/jfw5fgncvl/2Rj
	 b888tL1qP/hcYyjIYgEmfRwNtR9kY7IwokqiCz6wLRH95c66H77/rZRfSBo3pfy0AS
	 m6NHXi1CcRN9IdeD7zR/BnDP5cJm809QABoQBvPtDVB8yGpup8Pcy700Jj+WwKVykN
	 SpXUQHULG9hsA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] regulator: Add driver for MediaTek MT6328 PMIC
 regulators
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yassine Oudjana via B4 Relay" <devnull+y.oudjana.protonmail.com@kernel.org>
Cc: devicetree@vger.kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260531-mt6735-pwrap-mt6328-pmic-v2-3-dac37bf92894@protonmail.com>
References: <20260531-mt6735-pwrap-mt6328-pmic-v2-3-dac37bf92894@protonmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 31 May 2026 11:35:36 +0000
Message-Id: <20260531113536.B90DB1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] Undefined behavior (negative bitwise shift) in LDO mode accessors =
for fixed regulators.
- [High] Hardware logic error: `buck_vproc` is incorrectly assigned the vol=
tage selection register for `VPA`.
- [High] Mismatch between voltage table size and hardware mask for `ldo_vrf=
18_1` leads to silent undervolting.
- [Medium] The driver destructively mutates the global static `mt6328_regul=
ators` array during device probe.
- [Low] The `MT6328_LDO_RANGE` macro assigns mode registers but uses an ops=
 struct lacking mode accessors.
- [Low] Duplicate definition of `ldo_vcamio` regulator in initialization ar=
ray.
- [Low] Unused static voltage tables `ldo_volt_table7` and `ldo_volt_table8=
`.
--

commit 1a95db9b71950cc46e1f082052c7c441b06a008e
Author: Yassine Oudjana <y.oudjana@protonmail.com>

regulator: Add driver for MediaTek MT6328 PMIC regulators

This commit adds a new driver for the regulators found on the MT6328 PMIC.
It supports various bucks and LDOs using the regulator framework.

> diff --git a/drivers/regulator/mt6328-regulator.c b/drivers/regulator/mt6=
328-regulator.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/regulator/mt6328-regulator.c

[ ... ]

> +static const unsigned int ldo_volt_table6[] =3D {
> +	2900000, 3000000, 3300000
> +};
> +
> +static const unsigned int ldo_volt_table7[] =3D {
> +	2500000, 2900000, 3000000, 3300000
> +};
> +
> +static const unsigned int ldo_volt_table8[] =3D {
> +	1300000, 1800000, 2900000, 3300000
> +};

[Severity: Low]
Are these static voltage tables used anywhere in the driver? It looks like
ldo_volt_table7 and ldo_volt_table8 are defined here but are never
referenced in the mt6328_regulators array.

[ ... ]

> +static int mt6328_ldo_table_set_mode(struct regulator_dev *rdev, unsigne=
d int mode)
> +{
> +	int ret, val =3D 0;
> +	struct mt6328_regulator_info *info =3D rdev_get_drvdata(rdev);
> +
> +	switch (mode) {
> +	case REGULATOR_MODE_STANDBY:
> +		val =3D MT6328_LDO_TABLE_MODE_LP;
> +		break;
> +	case REGULATOR_MODE_NORMAL:
> +		val =3D MT6328_LDO_TABLE_MODE_NORMAL;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	val <<=3D ffs(info->modeset_mask) - 1;
> +
> +	ret =3D regmap_update_bits(rdev->regmap, info->modeset_reg,
> +				  info->modeset_mask, val);

[Severity: High]
Could this bitwise shift result in undefined behavior? If modeset_mask is 0,
ffs(0) evaluates to 0, resulting in a shift by -1.

I noticed ldo_vtref is initialized with a modeset_mask of 0 down in the
mt6328_regulators array, but it uses mt6328_volt_fixed_ops which exposes
both the set_mode and get_mode callbacks.

[ ... ]

> +static const struct regulator_ops mt6328_volt_range_ops =3D {
> +	.list_voltage =3D regulator_list_voltage_linear_range,
> +	.map_voltage =3D regulator_map_voltage_linear_range,
> +	.set_voltage_sel =3D regulator_set_voltage_sel_regmap,
> +	.get_voltage_sel =3D regulator_get_voltage_sel_regmap,
> +	.set_voltage_time_sel =3D regulator_set_voltage_time_sel,
> +	.enable =3D regulator_enable_regmap,
> +	.disable =3D regulator_disable_regmap,
> +	.is_enabled =3D regulator_is_enabled_regmap,
> +	.get_status =3D mt6328_get_status,
> +};

[Severity: Low]
Should this operations structure include the .set_mode and .get_mode callba=
cks?

Down below, ldo_vsram is initialized using the MT6328_LDO_RANGE macro which
sets up modeset_reg and modeset_mask, but since it is mapped to
mt6328_volt_range_ops, the mode data will be silently ignored by the
regulator core.

[ ... ]

> +/* The array is indexed by id(MT6328_ID_XXX) */
> +static struct mt6328_regulator_info mt6328_regulators[] =3D {
> +	MT6328_BUCK("buck_vpa", VPA, 500000, 3650000, 50000, buck_volt_range1, =
MT6328_VPA_CON9,
> +		    MT6328_VPA_CON11, 0x3f, MT6328_VPA_CON12, MT6328_VPA_CON7),
> +	MT6328_BUCK("buck_vproc", VPROC, 600000, 1393750, 6250, buck_volt_range=
2, MT6328_VPROC_CON9,
> +		    MT6328_VPA_CON11, 0x7f, MT6328_VPROC_CON12, MT6328_VPROC_CON7),

[Severity: High]
Does buck_vproc use the wrong voltage selection register here?

It looks like MT6328_VPA_CON11 was accidentally copied from buck_vpa. This
would cause voltage scaling for the processor to write to the VPA's voltage
selection register instead, breaking voltage scaling for both regulators.

[ ... ]

> +	MT6328_REG_FIXED("ldo_vrf18_0", VRF18_0, MT6328_VRF18_0_CON0, 1, 182500=
0,
> +			 MT6328_VRF18_0_CON0, BIT(0)),
> +	MT6328_LDO_TABLE("ldo_vrf18_1", VRF18_1, ldo_volt_table12, MT6328_VRF18=
_1_CON0, 1,
> +			 MT6328_SLDO_ANA_CON4, 0x30, MT6328_VRF18_1_CON0, BIT(0)),

[Severity: High]
Does this 2-bit mask (0x30) conflict with the size of ldo_volt_table12?

That voltage table contains 5 entries, which requires at least a 3-bit mask.
If the core requests the highest voltage (1.825V, index 4), it will be mask=
ed
to 0 when updated, which could silently undervolt the regulator to 1.2V ins=
tead.

[ ... ]

> +	MT6328_REG_FIXED("ldo_vcn18", VCN18, MT6328_VCN18_CON0, 1, 1800000, MT6=
328_VCN18_CON0,
> +			 BIT(0)),
> +	MT6328_LDO_TABLE("ldo_vcamio", VCAMIO, ldo_volt_table13, MT6328_VCAMIO_=
CON0, 1,
> +			 MT6328_SLDO_ANA_CON7, 0x30, MT6328_VCAMIO_CON0, BIT(0)),
> +	MT6328_LDO_TABLE("ldo_vcamio", VCAMIO, ldo_volt_table13, MT6328_VCAMIO_=
CON0, 1,
> +			 MT6328_SLDO_ANA_CON7, 0x30, MT6328_VCAMIO_CON0, BIT(0)),

[Severity: Low]
Is this duplicate definition of ldo_vcamio intentional? It appears this
entry was accidentally listed twice.

[ ... ]

> +static int mt6328_set_buck_vosel_reg(struct platform_device *pdev)
> +{
> +	struct mt6397_chip *mt6328 =3D dev_get_drvdata(pdev->dev.parent);
> +	int i;
> +	u32 regval;
> +
> +	for (i =3D 0; i < MT6328_MAX_REGULATOR; i++) {
> +		if (mt6328_regulators[i].vselctrl_reg) {
> +			if (regmap_read(mt6328->regmap,
> +				mt6328_regulators[i].vselctrl_reg,
> +				&regval) < 0) {
> +				dev_err(&pdev->dev,
> +					"Failed to read buck ctrl\n");
> +				return -EIO;
> +			}
> +
> +			if (regval & mt6328_regulators[i].vselctrl_mask) {
> +				mt6328_regulators[i].desc.vsel_reg =3D
> +				mt6328_regulators[i].vselon_reg;
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}

[Severity: Medium]
Does modifying mt6328_regulators[i].desc.vsel_reg permanently alter the
global static array?

If the driver is unbound and rebound later, and the hardware condition is no
longer met, the driver will incorrectly retain the mutated vsel_reg value
since there is no restore path for the original value.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260531-mt6735-pwr=
ap-mt6328-pmic-v2-0-dac37bf92894@protonmail.com?part=3D3
