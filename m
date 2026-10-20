Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792518464;
	b=5Y1NmuIeMhsEfWtVaN11nKQeM6+Azp7YnR73yJk4A4bguyjUMmEdYmXLtqlriwpsCy9V
	 v97Z4FacBm0HtXZlJXwf627Ro+4FTvOmK5oYbLkhMbI91DkWVnexk6WmFezJoPaKZ+osN
	 71qetCT1KWPTCrpbM4eMlmOgfDhtrBovS/4xE2ZNItWllKswEfxMJvhlxSv5rR+ULw/Oa
	 YPg9l7a6fIrW0wbaLD9qzQjR4BODjXFMx9qr+mSyim3Wf6LtTie4wgEVryKXjSwvoSIuS
	 Ml+0S6Q2/kD6cM07SYin/sy5JNYVV+Y6b0D6mUQ/ZTvrFdaPX6zoHgU7zkYUKuXdtrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792518464;
	h=Received:Message-ID:From:Subject:Reply-To:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+5ys7ARzjmOCxX0rrtJ2Ld2VIM5+EHLx/QluMRFXSUY=;
	b=fO/Sn7VgoTdbrHQZBP66tbivIplQ/FIz52+Cr+JL0bH4UIfg/xzn35OrRQW50kvdKVzp
	 B+Eq3Eqee9xXfdkrpL41a34cH4isLObcxkjymVeD+SWCeRN58EGkaMyAeZPZgmcRvG/A5
	 iAppRraF0npN2VHFTps6IAUkkH3Roh3HWFDsL+PxOsKLRRNuEp+qnAFwWU5UEOVZYODF/
	 EQgWD6m/jtSGbhmvXZuC8RBDJ05fW3X1y3m1G+Y80UIplBQkNPllAzq7C88MAXSStYGTv
	 eNQhNe/ZGEVorq3hFqqFqzoKp65duMI7XNpGDTJ6gJvRQzfVp13GpD2s1oo4OKKP4oA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A13606A330;
	Tue, 20 Oct 2026 17:47:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F15D1F000C9;
	Tue, 20 Oct 2026 17:47:43 +0000 (UTC)
Message-ID: <sashiko-outbox-179444@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v10 9/9] arm64: dts: mediatek: Add MediaTek
 MT6392 PMIC dtsi
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luca Leonardo Scorcia" <l.scorcia@gmail.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, mfd@lists.linux.dev, linux-gpio@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com, lee@kernel.org
In-Reply-To: <20261020173556.632798-10-l.scorcia@gmail.com>
References: <20261020173556.632798-1-l.scorcia@gmail.com>
 <20261020173556.632798-10-l.scorcia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 17:47:40 +0000
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
- [High] arm64: dts: mediatek: mt6392 pmic fails pwrap_probe() due to missi=
ng ID
--

commit 36e8cdb3fad1df2fc1833ecbab6f1f641807e610
Author: Val Packett <val@packett.cool>

arm64: dts: mediatek: Add MediaTek MT6392 PMIC dtsi

This commit adds the mt6392.dtsi device tree include file for the MediaTek
MT6392 PMIC (providing regulator, keys, pinctrl, and RTC nodes) and includes
it in pumpkin-common.dtsi.

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
> +		interrupt-controller;
> +		#interrupt-cells =3D <2>;

[Severity: High]
Will pwrap_probe() fail with -EINVAL on boards that include mt6392.dtsi?

In drivers/soc/mediatek/mtk-pmic-wrap.c, pwrap_probe() matches the child PM=
IC
node of pwrap against of_slave_match_tbl:

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

However, of_slave_match_tbl in drivers/soc/mediatek/mtk-pmic-wrap.c only
lists:

	static const struct of_device_id of_slave_match_tbl[] =3D {
		{ .compatible =3D "mediatek,mt6323", .data =3D &pmic_mt6323 },
		{ .compatible =3D "mediatek,mt6331", .data =3D &pmic_mt6331 },
		{ .compatible =3D "mediatek,mt6351", .data =3D &pmic_mt6351 },
		{ .compatible =3D "mediatek,mt6357", .data =3D &pmic_mt6357 },
		{ .compatible =3D "mediatek,mt6358", .data =3D &pmic_mt6358 },
		{ .compatible =3D "mediatek,mt6359", .data =3D &pmic_mt6359 },
		{ .compatible =3D "mediatek,mt6380-regulator", .data =3D &pmic_mt6380 },
		{ .compatible =3D "mediatek,mt6397", .data =3D &pmic_mt6397 },
		{ /* sentinel */ }
	};

Because there is no "mediatek,mt6392" entry in of_slave_match_tbl (and the
pmic node has no fallback compatible string), of_slave_id is NULL and
pwrap_probe() aborts before initializing the regmap or calling
of_platform_populate() for the PMIC and its subdevices.

[ ... ]

> diff --git a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi b/arch/arm6=
4/boot/dts/mediatek/pumpkin-common.dtsi
> index 805fb82138a80..b19d5792bd896 100644
> --- a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
> @@ -6,6 +6,8 @@
> =20
>  #include <dt-bindings/gpio/gpio.h>
> =20
> +#include "mt6392.dtsi"
> +
>  / {

[ ... ]

> @@ -160,6 +162,11 @@ &i2c2 {
>  	status =3D "okay";
>  };
> =20
> +&pmic {
> +	interrupt-parent =3D <&pio>;
> +	interrupts =3D <28 IRQ_TYPE_LEVEL_HIGH>;
> +};
> +
>  &uart0 {
>  	status =3D "okay";
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020173556.6327=
98-1-l.scorcia@gmail.com?part=3D9
