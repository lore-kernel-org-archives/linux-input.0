Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E463BBFB2;
	Mon, 15 Jun 2026 07:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781509165; cv=none; b=SGdV1pyBJzVKEPnEKdJuayY7WDizbRXMslTrWuPRjd6yalh0UV+FF8e2LDPGU3cx4DmIE/il9PNcjDXKtIrLOwMGL6hq06xB/S+8VZc7iKzvnnQWiEgdRgV0mbmtt9TsuMLonECU+mNp0eguP/Z8wunyYPyjEr+NKpkFhEB3P1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781509165; c=relaxed/simple;
	bh=vLAqeS6GnCpVFF68qF+U3zzI36eQxuymf+b+lcmuutI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QLyGFy1ftFrgJEEEB8KdeylxVSJqFMTOV7wJ0waFczAj3xIRfwlWPe3wNGqjwKLHlo3M2G8r8RShb7j3sAcZNpTgJRU07uzqX2LkNeyCQDGE5eGBGScg4Pf/H5gMYGrRoUEqBbJ1KrudmgD8QwxHM9C6sUuFQ3qoXeWXBQFD7eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exVyqlGl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exVyqlGl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 863751F000E9;
	Mon, 15 Jun 2026 07:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781509164;
	bh=T2zyCSl7BFOuGJsz/aHGzSdvR6M81lquHWQatFXE7PI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=exVyqlGl871iNEj0iStoVJiw4UOeAigm5ke8f6QMByZxTiv6K1T9IQzo6Ej5tCH5O
	 tn3C5rIHthEkxxnmutje91AU2PeD9CZsH6xIPO9dfpwmfy44HvCOPgxjl13OaJVQ8I
	 uPekIKWzRWij7WAhfYTRML1Np+jFRoLkj2s7z/mSwE2veBd03g6FDZn2GPMtHvgZEg
	 TBZgElPZl0xD8WvPLyoTV9dc3ah/81smPYVbXHka8Ibyon7cYLvBg2sw2MtCgHCZ0Q
	 e0WQiKDwESD/Agiaea14JkwCaZur7lQppWn0uhCFQ/YWGQqXXK+phjCWHTP861GsIV
	 ZiUgsK5CP96Aw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 8/9] regulator: Add MediaTek MT6392 regulator
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luca Leonardo Scorcia" <l.scorcia@gmail.com>
Cc: robh@kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com, conor+dt@kernel.org
In-Reply-To: <20260615071836.362883-9-l.scorcia@gmail.com>
References: <20260615071836.362883-9-l.scorcia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 07:39:23 +0000
Message-Id: <20260615073923.863751F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Data race and state corruption due to mutation of the shared globa=
l `mt6392_regulators` array.
- [High] Logic error in `mt6392_ldo_get_mode()` reads the wrong register to=
 determine mode.
- [Medium] Missing `.of_map_mode` callback breaks `regulator-initial-mode` =
parsing.
- [Medium] Poor error handling and unnecessary kernel log spamming in `mt63=
92_buck_set_mode`.
--

commit cf9cb32e08ea85698033220fad437d4b27bf421d
Author: Fabien Parent <parent.f@gmail.com>

regulator: Add MediaTek MT6392 regulator
   =20
The MT6392 is a regulator found on boards based on the MediaTek
MT8167, MT8516, and probably other SoCs. It is a so called PMIC and
connects as a slave to a SoC using SPI, wrapped inside PWRAP.

> diff --git a/drivers/regulator/mt6392-regulator.c b/drivers/regulator/mt6=
392-regulator.c
> new file mode 100644
> index 0000000000000..1f91aac3917ab
> --- /dev/null
> +++ b/drivers/regulator/mt6392-regulator.c

[ ... ]

> +static int mt6392_buck_set_mode(struct regulator_dev *rdev, unsigned int=
 mode)
> +{

[ ... ]

> +	ret =3D regmap_update_bits(rdev->regmap, info->pwm_modeset_reg,
> +				 info->pwm_modeset_mask, val);
> +
> +	if (regmap_read(rdev->regmap, info->pwm_modeset_reg, &reg_value) < 0) {
> +		dev_err(&rdev->dev, "Failed to read register value\n");
> +		return -EIO;
> +	}
> +
> +	dev_info(&rdev->dev, "%s: info->pwm_modeset_reg 0x%x =3D 0x%x\n",
> +		 info->desc.name, info->pwm_modeset_reg, reg_value);
> +
> +	return ret;
> +}

[Severity: Medium]
Does this error handling correctly propagate failures?

If regmap_update_bits() fails, 'ret' contains the error code, but the
subsequent regmap_read() might succeed, masking the original error.

Also, since set_mode can be a hot path called frequently by power managemen=
t,
could this dev_info() spam the kernel ring buffer? Would dev_dbg() be more
appropriate here?

[ ... ]

> +static unsigned int mt6392_ldo_get_mode(struct regulator_dev *rdev)
> +{

[ ... ]

> +	ret =3D regmap_read(rdev->regmap, info->lp_modeset_reg, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	val &=3D info->lp_modeset_mask;
> +	val >>=3D ffs(info->lp_modeset_mask) - 1;

[Severity: High]
Should this read from info->lp_modeget_reg instead?

By reading from lp_modeset_reg, it seems this retrieves the requested mode
rather than the actual hardware state, leaving the lp_modeget fields unused.

[ ... ]

> +static const struct regulator_ops mt6392_volt_range_ops =3D {
> +	.list_voltage =3D regulator_list_voltage_linear_range,
> +	.map_voltage =3D regulator_map_voltage_linear_range,
> +	.set_voltage_sel =3D regulator_set_voltage_sel_regmap,

[Severity: Medium]
Is this missing the .of_map_mode callback?

The driver defines custom device tree mode constants (e.g.,
MT6392_BUCK_MODE_AUTO), but without .of_map_mode, the regulator framework
will ignore the regulator-initial-mode DT property and log a warning.

[ ... ]

> +static int mt6392_set_buck_vsel_reg(struct platform_device *pdev)
> +{

[ ... ]

> +			if (regval & mt6392_regulators[i].vselctrl_mask) {
> +				// Regulator in Normal mode
> +				mt6392_regulators[i].desc.vsel_reg =3D
> +					mt6392_regulators[i].vsel_normal_mode_reg;
> +				mt6392_regulators[i].desc.vsel_mask =3D
> +					mt6392_regulators[i].vsel_normal_mode_mask;

[Severity: High]
Can this cause a data race or state corruption?

mt6392_regulators is a shared global static array, and the driver modifies =
it
during probe based on the current hardware state.

Since the driver requests PROBE_PREFER_ASYNCHRONOUS later on:

> +static struct platform_driver mt6392_regulator_driver =3D {
> +	.driver =3D {
> +		.name =3D "mt6392-regulator",
> +		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> +	},

Could probing multiple MT6392 instances concurrently overwrite the desc
fields for the other instances? Does the driver need to allocate per-device
copies of the regulator_desc?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615071836.3628=
83-1-l.scorcia@gmail.com?part=3D8
