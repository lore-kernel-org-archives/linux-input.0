Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5EC2BE051;
	Fri, 12 Jun 2026 20:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781296656; cv=none; b=N9nczAb9zQWy061AR/1VNw7fjUdFmmx2wSXki7slSOWAkTG/c2+Vbx40TOEFa1JqW4tfNxxfcxCyUPLpV/MTaf5gUvmS5wAkvIQ7TbvRnQ5OtiFpliCT8B0cSFKhf0i3uf+SRdeliw8zGgvW6s6GDOKJV28V8FsgIbxCIsmRsXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781296656; c=relaxed/simple;
	bh=5xMU7jYPjEpgMvv2At42ASj8xs+7FtNbVL+1MBxmtwg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gDoxTmXQudC5TVxrK5oJFFf43lz3LTfK5uXiei+QVrKfzOpsZlFdL4KU/qOrxF3zScILuGJkOGcvzwdFHnQLNzSUnHKcQCZMVjyzVCfiyA0zQKTqlWJvrGsuQJAbyGZuiFPDSyMq1giwemArBzjTE3/njI7P701e3HQMNPNUnA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CK9my/HF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CK9my/HF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C43DC1F00A3A;
	Fri, 12 Jun 2026 20:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781296655;
	bh=ll6oLUGeBbDzLHebdObHEFeG7v9OBSZ5q9PnL4B1E1g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CK9my/HFAKL8pIdwGWNEDYRYRtks02YI6s2mseGwQl3l+GdioVfsJ5NyVi0P13vb2
	 HAOjf7jT0mEBGwo81zQ08n8A7VZJyajoLdwXf+kr5RO4HZGpJ94IhwyHJLdbtzM8YT
	 gu079TcnV5Wai6unX5rUIlZ9PK7fIJ73JWNxYEY2G6vS+QWmLbtxAA+XcXBfxM2gP7
	 3h/rpq3HrKvZqFfTaC956eJnoczviJ+FLQ8Z34B532xx+NjwnVe/ulCQ8x+hyD3eOW
	 Xk1Fr8yXjks8BXRMdt6gBoFRxlDm5caFrKAW8cm/TMEA+z2doQSOEYRs0h9P/NI6MR
	 zy0N4EC0D5r+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/7] dt-bindings: mfd: mt6397: Add MT6392 PMIC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luca Leonardo Scorcia" <l.scorcia@gmail.com>
Cc: devicetree@vger.kernel.org, linux-input@vger.kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com, robh@kernel.org
In-Reply-To: <20260612200717.361018-2-l.scorcia@gmail.com>
References: <20260612200717.361018-2-l.scorcia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 20:37:34 +0000
Message-Id: <20260612203734.C43DC1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The dt-bindings schema for the MT6392 PMIC omits the 'mediatek,m=
t6392-regulator' compatible string for the 'regulators' child node. Since t=
he 'regulators' node is unconditionally marked as required in the schema, a=
ny complete device tree correctly describing the MT6392 hardware must inclu=
de it. Omitting the MT6392-specific regulator compatible string from the sc=
hema forces DT authors to either write incomplete DTs (which fail validatio=
n because the node is required) or use incorrect/generic compatible strings=
, causing schema validation failures when they attempt to properly describe=
 the hardware with 'mediatek,mt6392-regulator'.
--

commit a20444c8e4c98a81558d6d5c619b650c00235e18
Author: Fabien Parent <parent.f@gmail.com>

dt-bindings: mfd: mt6397: Add MT6392 PMIC

Add the initial bindings for the MT6392 PMIC and its RTC device.

> diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b=
/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
> index 3cbc0dc12c319..e39e81aa99249 100644
> --- a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
> +++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml

[ ... ]

> @@ -72,6 +76,10 @@ properties:
>                - mediatek,mt6331-rtc
>                - mediatek,mt6358-rtc
>                - mediatek,mt6397-rtc
> +          - items:
> +              - enum:
> +                  - mediatek,mt6392-rtc
> +              - const: mediatek,mt6323-rtc

[Severity: Medium]
Should the mediatek,mt6392-regulator compatible string be added to the
regulators child node as well?

Since the regulators node is unconditionally marked as required in the sche=
ma,
any complete device tree describing the MT6392 hardware must include it.

Does this missing string cause a regression where DT authors are forced to
either write incomplete DTs (which fail validation) or use incorrect compat=
ible
strings?

This causes schema validation failures when authors attempt to properly des=
cribe
the hardware with mediatek,mt6392-regulator:

Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml:
  regulators:
    ...
    properties:
      compatible:
        oneOf:
          - enum:
              - mediatek,mt6323-regulator
              - mediatek,mt6328-regulator
              ...

>            - items:
>                - enum:
>                    - mediatek,mt6359-rtc

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612200717.3610=
18-1-l.scorcia@gmail.com?part=3D1
