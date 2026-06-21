Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7085126C03;
	Sun, 21 Jun 2026 08:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782030607; cv=none; b=kv6+W2PI5pKmakVix4hhAYVwfMQEXDfuFlMwHCKLiLffwtvcxIGyo7F14DglaF9lTk3IdgIT16o8R3xQIGCLOMupyXARgJdHMADFU9CWZn53XhIUQb91Nj7hi2/3HZOTxMfKDryjmWXuJjYWwI9GFuoFBLj32h2ZZzhhRm2+8Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782030607; c=relaxed/simple;
	bh=dceVlqY/aSQPGBpvAyE7bVNLeeW7mBG9fyBvZjruGNE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GaczSYLdtVu1bhKddaqETmb9rSJwpknBcvyUuSao7u1gkkc/bGHJgEZxSfLx5F6xWRdUX7iJkr30LAiA9h1SMh+lW1U5G0vaeosFvy4P6x8g6hwIML1wczXAXCtd5wCXi/gQDvdO5ZS6Dj4wQSMlHoCx3A6Hc01QaOHq+/rHHgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2bMKjXH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2bMKjXH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 489341F000E9;
	Sun, 21 Jun 2026 08:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782030606;
	bh=p/FXKWzSj0tkTJ8Kx4wCHGUgcqstSZz9tPCPJC2/GhQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J2bMKjXH1a+bvLbPRxWE/Xe1huZnQrxSYJEQkTe814DBijefLFD+QmIhPsfBd179u
	 AMh4+3q8rg/Bd49uuC772SH3gdTt13JE1MfQQ3Bp4vDVpSKlX9lJlnE1g9GA/4e9lq
	 MIBD8BtqUARjQTOqAQrjExRze4aOYKe+y75q231mHkwAU1Q1xbodcXikJqqiUPsZ5/
	 R2ah2Z0vhH3zvIZ843IvPN2vmhLmKsEKe6uUcfA26Plr22clwTtHP6hi/PKAHvGvYb
	 yfdHcE8UC/MfLC+1IGQ96F0Q0tOv4FazV3Ydmj2eGbHtF4wL0NQ/B0jtkDAfgHFGJL
	 xSHC4lpXzbGqg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 3/9] regulator: dt-bindings: Add MediaTek MT6392 PMIC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luca Leonardo Scorcia" <l.scorcia@gmail.com>
Cc: dmitry.torokhov@gmail.com, robh@kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260621081634.467858-4-l.scorcia@gmail.com>
References: <20260621081634.467858-1-l.scorcia@gmail.com>
 <20260621081634.467858-4-l.scorcia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 21 Jun 2026 08:30:05 +0000
Message-Id: <20260621083006.489341F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Hardware Description Anti-Pattern (`avddldo-supply`)
- [Low] Missing DT Binding Examples
--

commit 0677db1e9f95451166ee6a30c2d046ffeee3f450
Author: Luca Leonardo Scorcia <l.scorcia@gmail.com>

regulator: dt-bindings: Add MediaTek MT6392 PMIC

Add bindings for the regulators found in the MediaTek MT6392 PMIC,
usually found in board designs using the MediaTek MT8516/MT8167 SoCs.

> diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6392-=
regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt639=
2-regulator.yaml
> new file mode 100644
> index 0000000000000..d74721d8f2ffc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6392-regulat=
or.yaml
> @@ -0,0 +1,112 @@

[ ... ]

> +properties:
> +  compatible:
> +    items:
> +      - const: mediatek,mt6392-regulator
> +
> +  vproc-supply:
> +    description: Supply for buck regulator vproc
> +  vcore-supply:
> +    description: Supply for buck regulator vcore
> +  vsys-supply:
> +    description: Supply for buck regulator vsys
> +  avddldo-supply:
> +    description:
> +      Supply for AVDD LDOs (vm, vio18, vcn18, vcamd, vcamio). According =
to the data sheet
> +      this is an internal supply derived from vsys.

[Severity: Medium]
Since this supply is an internal silicon connection derived from vsys, shou=
ld it
be exposed as a configurable board-level devicetree property?

Devicetree typically describes board-level wiring. Would it be better for t=
he
regulator driver to statically resolve this dependency internally to avoid
establishing an incorrect ABI?

> +  ldo1-supply:
> +    description: Supply for LDOs group 1 (vaud28, vxo22, vaud22, vadc18,=
 vcama, vrtc)

[ ... ]

> +required:
> +  - compatible
> +
> +additionalProperties: false

[Severity: Low]
Does this new binding schema miss an examples section?

According to devicetree binding guidelines, new schemas should include an
examples section at the end of the file. Without it, validation tools like
dt_binding_check might emit errors or skip full validation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260621081634.4678=
58-1-l.scorcia@gmail.com?part=3D3
