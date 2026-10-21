Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792581535;
	b=YqllCyz+BWw8C88TDKZiPza1dJkGk4nntSF3ixFjINq+9m5boZxY32AXE/r5TdOKuNiZ
	 jbSJO26y20JilKwoqclzY/k2w9mFr2JHrUoiYL9TTOcGFjdoQ39rS0T21cipbLD+ekpi3
	 SAwzphQ9AputjIPP7FwNi9IMpV1Ik7riZElMEh55HUBGijGwNKCX0OE++2rydSGQc4T/J
	 hyl9sd40dTj4njmg8Ic3seEp/tLO2KcG5C9DgJN18BrQOyDC4mQH5eN8Itl8VaOcpLJff
	 530Ac2/Kz3vJnD1L/0oQ9o0+033Dm0v+3s4Ej5mWm4Iv6Db77eHjwUIl+C4KGd2JZrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792581535;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qiAtdamYvI0HTH3dxZ+yRCmF/UDrorWDWFan4mp6p1Y=;
	b=bjvgKs9eJad9dPuOkU5a6m0tqhjGr76mNqZKR3oTCjXB4IEETDPLMQ3arDGy3wULB/mY
	 e6Q3uabU+GEYqRhRFGad0ukjgqcEBmNxi43ESYWRiaMSxaylhesUti4HB9P6JckibRDcA
	 mvMBiyhS5T8xDx/PcnxUBnKiQ3mOkc3sGhEsCy++qTZ6VWvRQQMxdBPEEf1py38zQJSyr
	 fLZdqQIVThUX5AjudQUkCZfZ8aVbN6ZSTtLEwcNAqXKNCPIuHO9D5jsuT9xS++rAtEPgg
	 Z2chmjI8yrDcDYnhqImFzYVvtj2YTbhnv16avZkaBgLy6bNMESDArG1qA+rDb3jITMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c+LzK6D2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312D4606A321;
	Wed, 21 Oct 2026 11:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c+LzK6D2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32DC31F000C9;
	Wed, 21 Oct 2026 11:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792581534;
	bh=qiAtdamYvI0HTH3dxZ+yRCmF/UDrorWDWFan4mp6p1Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c+LzK6D2woPgYC+5TkT286YzOfx7JvDVrToCL1aiFiHlpzAtPqtmwrl0ojaHPPURm
	 NzVJMKhXJ/rVDRRMH7TVxa+4p3xmODsS4bGV7aL8KG4gqqJJJHcNVkIKVBnXKkZIWS
	 HeWadSJjd36r2ObqVlYeLDEyHDAOufrr5BtsI1FC8OwR17sTXWK58DNUfnVcayD1QO
	 o9YGuGEqRo9j5T4Uz/hkY/4TY3BeKHGPlZoVMP2HWSEV2khxm6iK7HsiNYiSKJPJ3G
	 at/5unYc08Tzl66bO2OkZuqZE7gFFU+VA2CbqeNOQjv5IViq/N+Uu+RaHipvImz89b
	 4z4CZCpVHm6xw==
Message-ID: <sashiko-outbox-180161@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 9/9] arm64: dts: mediatek: Add MediaTek MT6392 PMIC
 dtsi
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luca Leonardo Scorcia" <l.scorcia@gmail.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, mfd@lists.linux.dev, linux-gpio@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com, lee@kernel.org
In-Reply-To: <20261021105109.199886-10-l.scorcia@gmail.com>
References: <20261021105109.199886-1-l.scorcia@gmail.com>
 <20261021105109.199886-10-l.scorcia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 11:18:53 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] arm64: dts: mediatek: pwrap_probe() fails due to unindexed mediate=
k,mt6392
- [High] arm64: dts: mediatek: mt6392: unconstrained rails disabled by regu=
lator_late_cleanup()
--

commit d14bb1584df5376f55003a68da2a5898709dcb49
Author: Val Packett <val@packett.cool>

arm64: dts: mediatek: Add MediaTek MT6392 PMIC dtsi

This commit adds the device tree include file for the MediaTek mt6392 pmic,
defining nodes for its keys, pinctrl, regulators, and rtc subdevices. It al=
so
includes the new file in pumpkin-common.dtsi for the Pumpkin boards.

> diff --git a/arch/arm64/boot/dts/mediatek/mt6392.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt6392.dtsi
> new file mode 100644
> index 0000000000000..cc4770d70246c
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt6392.dtsi
> @@ -0,0 +1,145 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019 MediaTek Inc.
> + * Copyright (c) 2024 Val Packett <val@packett.cool>
> + * Copyright (c) 2026 Luca Leonardo Scorcia <l.scorcia@gmail.com>
> + */
> +
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/regulator/mediatek,mt6392-regulator.h>
> +
> +&pwrap {
> +	pmic: pmic {
> +		compatible =3D "mediatek,mt6392";

[Severity: High]
When pwrap_probe() in drivers/soc/mediatek/mtk-pmic-wrap.c probes the pwrap
node on boards including this file, it matches np->child against
of_slave_match_tbl[]:

drivers/soc/mediatek/mtk-pmic-wrap.c:pwrap_probe() {
	...
	if (np->child)
		of_slave_id =3D of_match_node(of_slave_match_tbl, np->child);

	if (!of_slave_id) {
		dev_dbg(&pdev->dev, "slave pmic should be defined in dts\n");
		return -EINVAL;
	}
	...
}

However, of_slave_match_tbl[] in drivers/soc/mediatek/mtk-pmic-wrap.c only
lists mediatek,mt6323, mediatek,mt6331, mediatek,mt6351, mediatek,mt6357,
mediatek,mt6358, mediatek,mt6359, mediatek,mt6380-regulator, and
mediatek,mt6397, and does not have an entry for mediatek,mt6392:

static const struct of_device_id of_slave_match_tbl[] =3D {
	{ .compatible =3D "mediatek,mt6323", .data =3D &pmic_mt6323 },
	{ .compatible =3D "mediatek,mt6331", .data =3D &pmic_mt6331 },
	{ .compatible =3D "mediatek,mt6351", .data =3D &pmic_mt6351 },
	{ .compatible =3D "mediatek,mt6357", .data =3D &pmic_mt6357 },
	{ .compatible =3D "mediatek,mt6358", .data =3D &pmic_mt6358 },
	{ .compatible =3D "mediatek,mt6359", .data =3D &pmic_mt6359 },

	/* The MT6380 PMIC only implements a regulator, so we bind it
	 * directly instead of using a MFD.
	 */
	{ .compatible =3D "mediatek,mt6380-regulator", .data =3D &pmic_mt6380 },
	{ .compatible =3D "mediatek,mt6397", .data =3D &pmic_mt6397 },
	{ /* sentinel */ }
};

Will pwrap_probe() fail with -EINVAL before initializing wrp->regmap or
calling of_platform_populate(), preventing the mt6392 pmic device and all of
its subdevices from probing?

> +		interrupt-controller;
> +		#interrupt-cells =3D <2>;
> +
> +		mt6392keys: keys {
> +			compatible =3D "mediatek,mt6392-keys";
> +
> +			key-power {
> +				linux,keycodes =3D <KEY_POWER>;
> +				wakeup-source;
> +			};
> +
> +			key-home {
> +				linux,keycodes =3D <KEY_HOME>;
> +				wakeup-source;
> +			};
> +		};
> +
> +		mt6392pio: pinctrl {
> +			compatible =3D "mediatek,mt6392-pinctrl";
> +
> +			gpio-controller;
> +			#gpio-cells =3D <2>;
> +		};
> +
> +		mt6392regulators: regulators {
> +			compatible =3D "mediatek,mt6392-regulator";
> +
> +			/* Fixed supply defined in the data sheet */
> +			avddldo-supply =3D <&mt6392_vsys_reg>;
> +
> +			mt6392_vcore_reg: vcore {
> +				regulator-allowed-modes =3D <MT6392_REGULATOR_MODE_NORMAL
> +							   MT6392_BUCK_MODE_FORCE_PWM>;
> +			};
> +			mt6392_vproc_reg: vproc {
> +				regulator-allowed-modes =3D <MT6392_REGULATOR_MODE_NORMAL
> +							   MT6392_BUCK_MODE_FORCE_PWM>;
> +			};
> +			mt6392_vsys_reg: vsys {
> +				regulator-allowed-modes =3D <MT6392_REGULATOR_MODE_NORMAL
> +							   MT6392_BUCK_MODE_FORCE_PWM>;
> +			};

[Severity: High]
All 26 regulator child nodes under mt6392regulators are defined without
regulator-always-on, and arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
includes mt6392.dtsi without marking the core system rails as
regulator-always-on or attaching consumers.

When mt6392_regulator_probe() in drivers/regulator/mt6392-regulator.c
registers each regulator through devm_regulator_register() ->
regulator_register() -> regulator_of_get_init_data() ->
of_get_regulation_constraints(), any matched node without regulator-always-=
on
allows status changes:

drivers/regulator/of_regulator.c:of_get_regulation_constraints() {
	...
	constraints->always_on =3D of_property_read_bool(np, "regulator-always-on"=
);
	if (!constraints->always_on) /* status change should be possible. */
		constraints->valid_ops_mask |=3D REGULATOR_CHANGE_STATUS;
	...
}

Because the switchable regulators in mt6392_regulators[] provide
regulator_is_enabled_regmap and regulator_disable_regmap operations and have
rdev->use_count =3D=3D 0 when no consumers are attached,
regulator_init_complete_work_function() -> regulator_late_cleanup() in
drivers/regulator/core.c will turn off every enabled rail:

drivers/regulator/core.c:regulator_late_cleanup() {
	...
	if (c && c->always_on)
		return 0;

	if (!regulator_ops_is_valid(rdev, REGULATOR_CHANGE_STATUS))
		return 0;

	regulator_lock(rdev);

	if (rdev->use_count)
		goto unlock;

	/* If reading the status failed, assume that it's off. */
	if (_regulator_is_enabled(rdev) <=3D 0)
		goto unlock;

	if (have_full_constraints()) {
		/* We log since this may kill the system if it goes
		 * wrong.
		 */
		rdev_info(rdev, "disabling\n");
		ret =3D _regulator_do_disable(rdev);
	...
}

Without regulator-always-on or consumer supplies on core system rails in
mt6392.dtsi or pumpkin-common.dtsi, won't regulator_late_cleanup() disable
active system supplies such as vproc, vcore, vsys, vm, vxo22, vio18, and
vio28 after late init and power off or hang the Pumpkin boards?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021105109.1998=
86-1-l.scorcia@gmail.com?part=3D9
