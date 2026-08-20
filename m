Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B6242A7BC;
	Thu, 20 Aug 2026 12:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787229573; cv=none; b=MuhrioNQ59twZ2eGJgdTE9imy952r1vZnSYB1LuN7Ad1IWON/JhOPn+XybxplnULqyDOj+7zNM6Q0rzLj39iAb+JbAYgt0CyHvHQ3KqImkqdWNBagNxajp7WUClgUGMOkilCUPxRcObEx6ldvOetNV8pTg9HVCv8oSxN2lmJKFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787229573; c=relaxed/simple;
	bh=auDiTeQHvgzfT07gyZdnTg9MlbGo2vyGBE6fJgAwl5o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y/niQ8nhzjNGrDzYqwkha95ek1rp5bvdm3fhyykbEPfcn5hblYEhIjisWhTBwEodd3F73IqzYMVbPKznFFLcTpwBPPbmdAX3icTXctu2gzDDyD45jS+EW0ulm+XpE0g4viqkVme+S6XsLkv4gkX4oVyBmuhhN0XTr9YQtI88zfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3DQ1j63; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3DQ1j63"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BA531F00A3A;
	Thu, 20 Aug 2026 12:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787229572;
	bh=oH2/UWnboOddIp9VH/7/lUZ7BYqX4Ii/BThWTvDD87g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F3DQ1j63TvPlknW80+YJmjE+1XsVxFiHIaubYCpVCmtlWRYAXjH1pDGi6S02rFIOu
	 MDA84SWjT2a02NYS79mm3jpQifdoHxG1sAkroY3kafqdJgOZ8nW98JQnSKLJj02mPW
	 4jpBovrgdzQptXmFOT/0cqTe2IvtqXW+fk0KS3fvkFO3kaii5ISD8kiQfpsC2Shd1Z
	 NS94g8PVHMQPokaKtl9qihruaLu0ei38Iukndjg0MnntJD/JIlAc/nN0yyTQ8A0S9n
	 iUVbVifc99FZMZGr6NxnRA0G2f9Y0dSL8wV2g+4gmsH3eZAZw7SoPTPlvtsgbztKBR
	 CnGF6Q4X2ZWag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 3/9] regulator: dt-bindings: Add MediaTek MT6392 PMIC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luca Leonardo Scorcia" <l.scorcia@gmail.com>
Cc: devicetree@vger.kernel.org, mfd@lists.linux.dev, robh@kernel.org, dmitry.torokhov@gmail.com, conor+dt@kernel.org, linux-input@vger.kernel.org, lee@kernel.org
In-Reply-To: <20260820122242.120039-4-l.scorcia@gmail.com>
References: <20260820122242.120039-1-l.scorcia@gmail.com>
 <20260820122242.120039-4-l.scorcia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 12:39:31 +0000
Message-Id: <20260820123931.9BA531F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The devicetree binding exposes `avddldo-supply` as a configurable p=
roperty, but the description explicitly notes it is an 'internal supply der=
ived from vsys'. Devicetree is intended to describe board-level hardware co=
nfigurations (like external pin connections or PCB routing). Hardwired inte=
rnal IC routing is a static property of the chip and should be modeled inte=
rnally within the driver, rather than exposed as a configurable devicetree =
property.
--

--- Patch [3]: [PATCH v9 3/9] regulator: dt-bindings: Add MediaTek MT6392 P=
MIC ---
commit 2d8836e1efcb0c65952c3a56b41f16c4a50e3f1e
Author: Luca Leonardo Scorcia <l.scorcia@gmail.com>

regulator: dt-bindings: Add MediaTek MT6392 PMIC

This commit adds devicetree bindings for the voltage regulators found in
the MediaTek MT6392 PMIC. It describes the buck converters, LDOs, and their
allowed modes for board designs using MT8516/MT8167 SoCs.

> diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6392-=
regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt639=
2-regulator.yaml
> new file mode 100644
> index 0000000000000..d74721d8f2ffc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6392-regulat=
or.yaml

[ ... ]

> @@ -21,12 +21,15 @@ properties:
>    vproc-supply:
>      description: Supply for buck regulator vproc
>    vcore-supply:
>      description: Supply for buck regulator vcore
>    vsys-supply:
>      description: Supply for buck regulator vsys
>    avddldo-supply:
>      description:
>        Supply for AVDD LDOs (vm, vio18, vcn18, vcamd, vcamio). According =
to the data sheet
>        this is an internal supply derived from vsys.

[Severity: Low]
Since this is an internal supply derived from vsys, should it be exposed
as a configurable devicetree property?

Devicetree is typically intended to describe board-level hardware
configurations like external pin connections. Since the hardwired internal
IC routing is a static property of the chip, would it be better to model
this internally within the driver rather than exposing it as a configurable
devicetree property?

>    ldo1-supply:
>      description: Supply for LDOs group 1 (vaud28, vxo22, vaud22, vadc18,=
 vcama, vrtc)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820122242.1200=
39-1-l.scorcia@gmail.com?part=3D3
