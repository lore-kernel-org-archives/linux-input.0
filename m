Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C583B6BE5;
	Thu, 20 Aug 2026 12:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787230732; cv=none; b=iC7pnyJK0mHCXVu1hnZYxNGGYVG8uv6Zi9CHEc6IkAsq8m8Z4VzGAK0lRZqkBvINb31kKqkc0syW1tf3vop8Ep72BRadZo42BIaHyz9toRxOwVT0zUeKBchYAp+Hj8mrOIfXSYh3KiV1pSzPCAxhj9CB+80Y495DH9uIGKqs3cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787230732; c=relaxed/simple;
	bh=KVIwEUvDX5aADJeU4WokaUFB7MzfcTBq9Yz7J7m7Y9I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iaUkUnRsdqKoRDuHUb5A1mdde6XhVR3fY/qdbIMzklZLZv/tJP2uqRT1HVnLoYv9B9Z03VZs1VCg6K0JHSo3fqy0baA3Upvf9TYPiqWum8uMFosku2AeCwm6FyoFoeAzuhhjQ2xfT1V8/KVL/Kufn4vZzsZUwQJszCbSr+i1BA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jYzRo4DQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYzRo4DQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B34D1F000E9;
	Thu, 20 Aug 2026 12:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787230730;
	bh=kEGaqNW1SCrah/gNuaRHobfiAob4noluQCSQD3ehn+E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jYzRo4DQpfmCzrvh8BcS/jelxazxP8/gCwXzIR8PcXODhtxBRHJ0/ds+8hc/rR7Zy
	 fcAGXZgPJQVj7eWu7zKKog3pZ2M9QPWw2mM0bP836UIRvvzr9ankp7f3Qwq0lg0FH6
	 YfaileXQN2QvH0FkNMQsE5dwFUVGNBQtJct3iyBgItbbT2AOOQVjcXqSpjTxn1yAPQ
	 PH5R79nJezRB8OQXbbY6I/szZAAZ47TwmSWx/lJyotc/tXN1bZLFiywgIaHq0w2e8f
	 y0JV6niMFn2M3Kw3gKVLkJSFUu9pQaa7KiR27aEuMy40ZWJfXkSS8xz4B8OAu0s0jz
	 Qx7W8kCJ0H4aw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 9/9] arm64: dts: mediatek: Add MediaTek MT6392 PMIC
 dtsi
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luca Leonardo Scorcia" <l.scorcia@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, mfd@lists.linux.dev, lee@kernel.org, conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260820122242.120039-10-l.scorcia@gmail.com>
References: <20260820122242.120039-1-l.scorcia@gmail.com>
 <20260820122242.120039-10-l.scorcia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 12:58:49 +0000
Message-Id: <20260820125850.3B34D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Incorrect fallback compatible string 'mediatek,mt6323' on the PMIC=
 node breaks older kernels.
--

--- Patch [9]: [PATCH v9 9/9] arm64: dts: mediatek: Add MediaTek MT6392 PMI=
C dtsi ---
commit 8aa00d786a3380122f097a78ee0ea676d704615c
Author: Val Packett <val@packett.cool>

arm64: dts: mediatek: Add MediaTek MT6392 PMIC dtsi

This patch adds the device tree include file for the MT6392 PMIC, which
provides support for regulators, keys, pinctrl, and RTC. It also includes
this new file in the shared device tree for Pumpkin boards.

> diff --git a/arch/arm64/boot/dts/mediatek/mt6392.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt6392.dtsi
> new file mode 100644
> index 0000000000000..69d63c153d9e5
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt6392.dtsi
> @@ -0,0 +1,145 @@
[ ... ]
> +&pwrap {
> +	pmic: pmic {
> +		compatible =3D "mediatek,mt6392", "mediatek,mt6323";

[Severity: High]
Does providing the "mediatek,mt6323" fallback compatible string break older
kernels booting with this device tree?

The MFD core in older kernels will match the "mediatek,mt6323" string and
attempt to spawn the MT6323 sub-devices. However, the child nodes in this
device tree are not compatible with the MT6323 drivers, causing the regulat=
ors
to fail probing.

> +		interrupt-controller;
> +		#interrupt-cells =3D <2>;
[ ... ]
> +		mt6392regulators: regulators {
> +			compatible =3D "mediatek,mt6392-regulator";
> +
> +			/* Fixed supply defined in the data sheet */
> +			avddldo-supply =3D <&mt6392_vsys_reg>;
> +
> +			mt6392_vcore_reg: vcore {

[Severity: High]
Since the top-level PMIC node claims compatibility with MT6323, wouldn't the
MT6323 regulator driver expect this child node to have the
"mediatek,mt6323-regulator" compatible string and specific sub-node names
like "buck_vcore" and "buck_vproc"?

Because this node uses "mediatek,mt6392-regulator" and names like "vcore" a=
nd
"vproc", the MT6323 MFD driver fails to associate the regulators with the
device tree. If the MT6323 drivers cannot parse this structure, should the
fallback compatible string be removed from the PMIC node to avoid tricking
older kernels?

> +				regulator-allowed-modes =3D <MT6392_REGULATOR_MODE_NORMAL
> +							   MT6392_BUCK_MODE_FORCE_PWM>;
> +			};
> +			mt6392_vproc_reg: vproc {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820122242.1200=
39-1-l.scorcia@gmail.com?part=3D9
