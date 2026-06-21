Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690F61DDC2B;
	Sun, 21 Jun 2026 08:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782030624; cv=none; b=vBy3yY71PsSR3SjMm2/g+3RuNOU1YDD/YvYjrEMXjk3AMCh6EYylxxFKdBeIIYgb5juhK531MqvfoQS8xw1dZ0ZflFeVOOOYrvO6+kpOn6Pn4KlOyUTEEoEwFGA4R99JgZjuINbxZjSIOgamXzZtj8jaBnUS47brg7kWsHRg4Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782030624; c=relaxed/simple;
	bh=TVakF7dIKSqGvZ0D4DRPx89Kz7GgSvdJeG7lP5Emazo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VMB8VSE/LO8UbxmJxkpetHMb1agRvxG+kauyHarp7I//bkf2Gl2p8g51CtghykW2Zpce+jSx+lljsCIezHDFG+ZiJ51HpjWndKuk8x6uTBl4X8VeZ4ETloZvsX/FfWzkk9+8PGaDtgv7JeYCygxHIGOkmruhAUi7vuDfyRgYbPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9JMcYZx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9JMcYZx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C2971F000E9;
	Sun, 21 Jun 2026 08:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782030623;
	bh=gV1xBwb2GR0VrOH12O1sCDlniY06Xjv6o2E18bp5Kh8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N9JMcYZx2o9DpgB4K2D+4eUhBs7FvteSUtSKIfQzyKAuGnCoLbZV3fpCLnNvNKCBX
	 f91SQLl0JuHHLrjkc+vSlvP5T8Z/ZywLz4jVdSTjeRHCyWNBRMTlFem7NhXfuQgU+j
	 AREo6u+2tzQhbIBAwtvPFw+jH5xvFatS5RT8sYNn5hJdB8KLMxn0lpyVIwzzbfiW7+
	 iop9eCJFQyWo2Zodt92DYauJhNQYP/Veaye4Zuh+4ov3ykKZynJGzKk0iW2jNvwdUX
	 JfmmQHRSi1MkbiUvUC17L3LI3UwJ65lpA4Q0RYtmvVP/rVo+Vke1DBso7VqgK8ke9T
	 C+LOFPPxfey2g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 8/9] regulator: Add MediaTek MT6392 regulator
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luca Leonardo Scorcia" <l.scorcia@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260621081634.467858-9-l.scorcia@gmail.com>
References: <20260621081634.467858-1-l.scorcia@gmail.com>
 <20260621081634.467858-9-l.scorcia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 21 Jun 2026 08:30:22 +0000
Message-Id: <20260621083022.9C2971F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Data race and global state corruption due to dynamic mutation of s=
tatic global `regulator_desc` array during asynchronous probe.
--

commit 986be7d1279b96c61669e064178dad0c9c317fcd
Author: Fabien Parent <parent.f@gmail.com>

regulator: Add MediaTek MT6392 regulator

This commit introduces the regulator driver for the MediaTek MT6392 PMIC.
The PMIC is used on boards based on MT8167, MT8516, and other SoCs,
connecting via SPI wrapped inside PWRAP.

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

[Severity: High]
Does this code safely handle concurrent probes or multiple device instances?

The mt6392_regulators array is a static global variable. Modifying
desc.vsel_reg and desc.vsel_mask directly during probe alters shared global
state.

The regulator core API expects regulator_desc to be a constant immutable
structure, as devm_regulator_register() takes a const pointer. Mutating
this static structure can corrupt the active configuration of previously
registered instances, or persist corrupted state across unbind/rebind cycle=
s.

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

[Severity: High]
Could this asynchronous probe type lead to a data race?

Since multiple device instances could be probed concurrently, they would
race to modify the shared static mt6392_regulators array during
mt6392_set_buck_vsel_reg().

> +	},
> +	.probe =3D mt6392_regulator_probe,
> +	.id_table =3D mt6392_platform_ids,
> +};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260621081634.4678=
58-1-l.scorcia@gmail.com?part=3D8
