Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BB81BBBFC;
	Sat, 20 Jun 2026 20:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781986796; cv=none; b=SA1kkNSTwbWiCbjgKlnfIO4vxL8uXsx+R53WZMgXykLmd6Fe4W2CYjqRmSeXnKo8+h3qsLtZRLTjNwmz9yG44rJWCV88yO1JJMZ0sOnS4Og9tHXGKbFqwOEUJcxMtHzV6axhlV/6ukaiQEECT9wt+ebjGcoreEa4NVu+VlB7oV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781986796; c=relaxed/simple;
	bh=D1CFJOrcwXV2AmvM2K0piG4AjMiEMSCH29rT+nO6b6Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CklnHdyUpvkw+4YrG29UatcxT4GGCWqvECX6WPXFUgU0nRLzJ+HyaAIcNqAtGfMMk7OjdkW6E3hZlHgnWJnKFDBmFvs92TfSdrr05d1pItf06bYfYMPk4NEwD8ZCvRbrD7eI8Be/oNlWusqMgxmQ3dtnRXTzvR04snULNSCYChY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8bOkRQg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8bOkRQg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AEE31F000E9;
	Sat, 20 Jun 2026 20:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781986795;
	bh=gH79IVJ58dT+uQPGbHNh07HeeJgnOJWn+1E281m0nJA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n8bOkRQgUen5CcCxezNR7c6ACWlv9QeadismdErVOfZA2AGYOEW9R0vtXu0td9q50
	 L1spiGXBP/jAZy4/4d7LZVRXhaBQYNtYwSVrKAHyc7JbTbAz/WBTMH7+0oGwIomj3a
	 hyh63QZehRDEjtLyjTpgpwimunRgRk1xFueBILNHaJckeEvOCRDzSnegqwVYK6bx0J
	 TSp0dex+IqwEFN8MSQJbWcfOPsA4mW2mrOWIQXL+mHM437BM8UrfX+Kz3zsWgZGtOV
	 PQli2UTOS+U6IfkCDCBAjA8oblmCpLna/AeLjYArLzcZEm+npaj5YbDvNZNIRCbgKi
	 Mk8XTe8CxRaHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 9/9] arm64: dts: mediatek: Add MediaTek MT6392 PMIC
 dtsi
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luca Leonardo Scorcia" <l.scorcia@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260620200032.334192-10-l.scorcia@gmail.com>
References: <20260620200032.334192-1-l.scorcia@gmail.com>
 <20260620200032.334192-10-l.scorcia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 20:19:54 +0000
Message-Id: <20260620201955.1AEE31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The `pmic` node lacks an upstream `interrupts` or `interrupts-exte=
nded` property, causing the MT6397/MT6392 PMIC driver to fail probing.
--

commit fc85085e7df96d6b701cb80ab653d3bbb4392af1
Author: Val Packett <val@packett.cool>

arm64: dts: mediatek: Add MediaTek MT6392 PMIC dtsi

Add the dtsi to be included by all boards using the MT6392 PMIC,
providing support for regulator, keys, pinctrl and RTC. Import the new
file in the shared device tree for the Pumpkin boards.

> diff --git a/arch/arm64/boot/dts/mediatek/mt6392.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt6392.dtsi
> new file mode 100644
> index 0000000000000..19321ae010bba
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt6392.dtsi
> @@ -0,0 +1,148 @@
[ ... ]
> +&pwrap {
> +	pmic: pmic {
> +		compatible =3D "mediatek,mt6392", "mediatek,mt6323";
> +		interrupt-controller;
> +		#interrupt-cells =3D <2>;

[ ... ]

> diff --git a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi b/arch/arm6=
4/boot/dts/mediatek/pumpkin-common.dtsi
> index 805fb82138a80..6bc80924cb6cf 100644
> --- a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
> @@ -6,6 +6,8 @@
> =20
>  #include <dt-bindings/gpio/gpio.h>
> =20
> +#include "mt6392.dtsi"
> +

[Severity: High]
Does this inclusion miss the board-specific interrupts definition for the P=
MIC?

The new mt6392.dtsi defines the pmic node but omits the interrupts property,
as expected for a generic include. However, pumpkin-common.dtsi doesn't app=
ear
to override the &pmic node to provide the board-specific interrupt routing.

Since the MT6397 PMIC core driver aborts probing completely if it cannot fi=
nd
an interrupt via platform_get_irq(pdev, 0), will this cause the PMIC driver=
 to
fail probing, leaving all PMIC sub-devices unavailable?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620200032.3341=
92-1-l.scorcia@gmail.com?part=3D9
