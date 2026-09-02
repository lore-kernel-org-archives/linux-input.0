Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D073A873A;
	Wed,  2 Sep 2026 20:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788379227; cv=none; b=YNnb0AggfQtC3lyOv6dyPvD4mNo6dsi2cP/8lB5FV02SV07yQ0m9VjT/Z3t6vfOTHsL6xxpbnixgxBXb7sMVYk4HAfWkoZyiLlhX4+ciURliXqb2ynC9ZXRdSOJPoPFgW1f2tkBncoE/ROQnGW3nFr023k2xIB6ygdylrHlhKMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788379227; c=relaxed/simple;
	bh=+WsjFyG4xbz5qUnMOxJWk6BGjda9sQ1UMov/ss83kY4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kivehlxVEFWy54tszMoiIy+wo5gUDuerr6p8g8LTMx6u8QhIXmSIwb8tbaygb99ofTnSQmWTsE4wTJ9wI6WYF9ujg5DlKropCSP05k9wcEGs4tiY1p2BTgmwdYH34/3GAFuDETe3D3wg9GMOcuKxAvYfzvC/yE3QzjfvcOyfa/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XtSE18FH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XtSE18FH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F6F31F00A3A;
	Wed,  2 Sep 2026 20:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788379226;
	bh=LcIQQ7Vn6pd5lx1e0tMgtuH8Ro/ZPtEPRs2Ge3tRKww=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XtSE18FH3VlkWTFp6QgQTLcaEgfkVHLBGNQ+l9OThIidBi5zgcGL+G+YIZVSftPrg
	 vsjspy/IjTlVV5Vb/ESjoqtSHy/nd//TkH6+1sQGQUY02UU3teoyVboxI4Cw4XZgJI
	 6ONV3N9hnj51hoG7TCaDahF2LZx0T/LjJ5o3FX5IUHhWkyHe0ywpdKBMwivJ0xJkVS
	 BSL0slQqz6+F2XpXeigwltb2TXy8rlxbvZlCF0MDRhr9thonYM81MgguhYSt2M5Seq
	 PAIHWntjZIbgQrdWxufBI1exCB/0P+KRRdnHZleGcJTexlEuGNVKD6+2jesrQG5j90
	 a4iOStcAL+Chg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 3/9] regulator: dt-bindings: Add MediaTek MT6392
 PMIC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luca Leonardo Scorcia" <l.scorcia@gmail.com>
Cc: robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, lee@kernel.org, mfd@lists.linux.dev, devicetree@vger.kernel.org
In-Reply-To: <20260902193351.185771-4-l.scorcia@gmail.com>
References: <20260902193351.185771-1-l.scorcia@gmail.com>
 <20260902193351.185771-4-l.scorcia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 20:00:25 +0000
Message-Id: <20260902200025.8F6F31F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Exposing an internal PMIC supply as a device tree property viola=
tes DT principles.
--

commit b0d91909b47203a1dab498d4bf7631441c6bb74f
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
Since this documentation confirms the supply is an internal connection deri=
ved
from vsys, should it be exposed as a devicetree property?

Exposing a hardwired internal chip connection forces developers to write
redundant boilerplate in every board DTS.

Could this internal supply routing be handled directly in the driver code
instead of the device tree bindings?

> +  ldo1-supply:
> +    description: Supply for LDOs group 1 (vaud28, vxo22, vaud22, vadc18,=
 vcama, vrtc)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902193351.1857=
71-1-l.scorcia@gmail.com?part=3D3
