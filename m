Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488BE3EB0F0;
	Wed,  2 Sep 2026 20:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788382717; cv=none; b=UEj6U9wqQe1aSVGJ6TYZrVCDZTsZjFkfmhLEfkOZp9Az5GE63UxLz2QuVRb0S9CxwCuYa+prPFtF3b1WJ244zE1i3lZtK163ChmaC/AzzKfbAF4j9j+yzZeQqCSRM/GTe4Cx4+Vz/B7mIhGgYwwD3Pq23TxqElSqfK6Pmnannww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788382717; c=relaxed/simple;
	bh=7vRutV9vCxGwHh9/UDKxWqdqihRkF+VkbJD8UJBT6mE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=njRaGtOPrJytKVvB7FKrBHydZeGPduMWMih3wTJm310YeeNOoRVUgRRYDEhR4yUUyCfCl4jiPhB96ULC6ldXD9tZ0+UxfpfI5MrO2AizUAXKRiP1k77PakAS6zlTy0l/SfOdrWR90aRyKtMP/mCew4yoOPCM9pH/xmlAiy0JxiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CpxqH7ua; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CpxqH7ua"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 090891F000E9;
	Wed,  2 Sep 2026 20:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788382710;
	bh=NWx4tUgAIbI0Mfq4HlTUynAboGNfe5rIiZMQq1a+1/s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CpxqH7uacU+F9ZvmRiUoKvLfY5wQjfVRdGDOe0GuBfWXRJpFGCAg3GFgqm/lqNp/k
	 02bbxTnvC5f3/VSi5h5hiCORfivDlBmVzqDEfB0PRsA9DJZDkuQu+NHByrid442jsm
	 C3/D3llZYkHoF5VgW3QiBH0QX2WJgGMrLhLpqBP7AKJtcZac3BRoF96TibztDlMfVo
	 cRaboC0oCl6kmukE9WI1CaZHtks0+k8TuiKlUZFtErhYR7zxoNT7Sm8ENPjcGn6jlZ
	 tZ604L8bADwEBv+/rFfqETikg0KOpE83NPHMgiqGCbvWimOcXFEeBq/vK5RDbhVPu1
	 dQTD1zvoZO57g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 8/9] regulator: Add MediaTek MT6392 regulator
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luca Leonardo Scorcia" <l.scorcia@gmail.com>
Cc: mfd@lists.linux.dev, dmitry.torokhov@gmail.com, conor+dt@kernel.org, lee@kernel.org, robh@kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org
In-Reply-To: <20260902193351.185771-9-l.scorcia@gmail.com>
References: <20260902193351.185771-1-l.scorcia@gmail.com>
 <20260902193351.185771-9-l.scorcia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 20:58:29 +0000
Message-Id: <20260902205830.090891F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The driver mutates the statically defined global array `mt6392_reg=
ulators` during probe, causing state corruption and race conditions for mul=
ti-instance deployments or re-probing.
--

commit b458a23ed7fdbe7db2ebc29e150ed87ba4a12dbe
Author: Fabien Parent <parent.f@gmail.com>

regulator: Add MediaTek MT6392 regulator

This commit introduces support for the MediaTek MT6392 PMIC regulator.
The PMIC connects as a SPI slave wrapped inside PWRAP and is found on
MT8167 and MT8516 SoC based boards.

> diff --git a/drivers/regulator/mt6392-regulator.c b/drivers/regulator/mt6=
392-regulator.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/regulator/mt6392-regulator.c

[ ... ]

> +// Buck regulators can be in Register mode or Normal mode.
> +// Each mode uses a different register to set the desired voltage.
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

[Severity: High]
Does this code mutate the shared global mt6392_regulators array based on
per-instance hardware state? If multiple instances of this PMIC are present,
or during unbind/re-bind cycles, won't this corrupt the state for other
instances since the regulator core expects regulator_desc to be static and
independent across deployments?

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
> +
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
> +	for (i =3D 0; i < MT6392_MAX_REGULATOR; i++) {
> +		config.driver_data =3D &mt6392_regulators[i];
> +
> +		rdev =3D devm_regulator_register(&pdev->dev,
> +					       &mt6392_regulators[i].desc,
> +					       &config);

[Severity: High]
Because the regulator core stores a pointer to the passed regulator_desc,
will passing the mutated shared descriptor here cause the first PMIC
instance to use the second PMIC's register offsets if a second instance
is probed? Could this result in writing to incorrect registers when changing
voltages?

> +		if (IS_ERR(rdev)) {
> +			dev_err(&pdev->dev, "failed to register %s\n",
> +				mt6392_regulators[i].desc.name);
> +			return PTR_ERR(rdev);
> +		}
> +	}
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902193351.1857=
71-1-l.scorcia@gmail.com?part=3D8
