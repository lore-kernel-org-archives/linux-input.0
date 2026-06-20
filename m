Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0E1233722;
	Sat, 20 Jun 2026 20:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781986522; cv=none; b=mtXk0Z5SZi6tYVgUBvAsHfIcZDmdxAdcb1YGewZZdENoBHvsV60OGIUC2DbemajZfIj7ceRP9BGnnC9fo3CKbXMcksahNp7mYVsxf8nYN8M/+/xCW2MpAhsCDTwVWX4ZitzE0gXB8PQBEJAM33mwQ7xaiVo/PMCs4YB7I6czRV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781986522; c=relaxed/simple;
	bh=/pil+m7j4sVay4PdNm2ozLO0rl3WL20yGxLmIoF3+hA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BoxuwsCtXJfpRpomtKQMHY7dcbWtqA6imG7057qzn29/5BQVrw2o7Elzn8BHWZQB1W5uiBmQicJNPrk9TbuoAr+NqDcCMQbP8ZkREQOrQUAfEuSmlu7JUMQGAHMy6Bf9lXXG1S0XWoAjoOaIF1SZaw1LX+jtvA7g/TrYzAmJ8IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3fuwx4S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3fuwx4S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01B531F000E9;
	Sat, 20 Jun 2026 20:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781986521;
	bh=1SypZ2M3P53VWCWSd9RYA3KcLGNIXBQUShma5dU9VZQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F3fuwx4Sqh7AoJGgqFJK98SLeFPccnCDtNsdaA6TFHd0VxmFo9lA4DhBJew1dAdhs
	 SDRQ7giCwSd/U7hE2G5K7cvYc+A6Jss1rTCl5WfDqTnyD56Xqou8SpJJjYK2MrF9Nb
	 8g94U/6vp+Z4mF8Ti0mXwnT646fTP7VmcPmLcU1vWb1+H8EnJ8nzsTe0lUqDWt72sX
	 XU+oDnlmpZB57YNIStmLtZpFLZ7ZQSduNgXUQ8ChzJAYqXH1zZOIdfrrTLUpWjyWqX
	 SLVPLpQn40fort8QIoj9ooun6WE/z+NGPA8xf2bXo5ADWuA++VS7ACybUuylp/KinU
	 ZK8iO0XIn9VIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/9] regulator: dt-bindings: Add MediaTek MT6392 PMIC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luca Leonardo Scorcia" <l.scorcia@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260620200032.334192-4-l.scorcia@gmail.com>
References: <20260620200032.334192-1-l.scorcia@gmail.com>
 <20260620200032.334192-4-l.scorcia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 20:15:20 +0000
Message-Id: <20260620201521.01B531F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Invalid use of array validation keywords (`items`, `maxItems`) o=
n the scalar `regulator-initial-mode` property, allowing any integer value =
to bypass the intended enum constraints.
- [Low] The dt-binding YAML file is completely missing an `examples:` secti=
on.
- [Low] Exposing an internal, hardwired connection (`avddldo-supply`) as an=
 external device tree property.
--

commit 17d808769b24018a674d4068d9bab99043b30c55
Author: Luca Leonardo Scorcia <l.scorcia@gmail.com>

regulator: dt-bindings: Add MediaTek MT6392 PMIC

Add bindings for the regulators found in the MediaTek MT6392 PMIC,
usually found in board designs using the MediaTek MT8516/MT8167 SoCs.

> diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6392-=
regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt639=
2-regulator.yaml
> new file mode 100644
> index 0000000000000..f3d5a3498d184
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6392-regulat=
or.yaml
> @@ -0,0 +1,118 @@

[ ... ]

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

[Severity: Low]
Should this internal supply be exposed as an external device tree property?

Since the description notes this is an internal supply derived from vsys,
exposing it here requires board device trees to describe internal IC routing
instead of external hardware wiring.

[ ... ]

> +patternProperties:
> +  "^v(core|proc|sys)$":
> +    description: Buck regulators
> +    type: object
> +    $ref: regulator.yaml#
> +    unevaluatedProperties: false
> +    properties:
> +      regulator-allowed-modes:
> +        description:
> +          BUCK regulators can set regulator-allowed-modes to values spec=
ified in
> +          dt-bindings/regulator/mediatek,mt6392-regulator.h
> +        items:
> +          enum: [0, 1]
> +        minItems: 1
> +        maxItems: 2
> +      regulator-initial-mode:
> +        description:
> +          BUCK regulators can set regulator-initial-mode to values speci=
fied in
> +          dt-bindings/regulator/mediatek,mt6392-regulator.h
> +        items:
> +          enum: [0, 1]
> +        maxItems: 1

[Severity: Medium]
Is it correct to use array validation keywords like items and maxItems for
regulator-initial-mode?

Since regulator-initial-mode is defined as a scalar uint32 in regulator.yam=
l,
applying array constraints to it causes the schema validation to ignore the=
m.
This allows any arbitrary integer value to bypass the enum constraints.

[ ... ]

> +  "^v(adc18|camio|cn18|io18|xo22|m25|aud28|io28|rtc|usb)$":
> +    description: LDOs with fixed output and mode setting
> +    type: object
> +    $ref: regulator.yaml#
> +    unevaluatedProperties: false
> +    properties:
> +      regulator-allowed-modes:

[ ... ]

> +      regulator-initial-mode:
> +        description:
> +          LDO regulators can set regulator-initial-mode to values specif=
ied in
> +          dt-bindings/regulator/mediatek,mt6392-regulator.h
> +        items:
> +          enum: [0, 2]
> +        maxItems: 1

[Severity: Medium]
Does this have the same issue with array validation keywords being applied =
to
a scalar property?

[ ... ]

> +  "^v(aud22|camaf|camd|cn35|efuse|emc3v3|gp1|gp2|m|mc|mch)$":
> +    description: LDOs with adjustable output and mode setting
> +    type: object
> +    $ref: regulator.yaml#
> +    unevaluatedProperties: false
> +    properties:
> +      regulator-allowed-modes:

[ ... ]

> +      regulator-initial-mode:
> +        description:
> +          LDO regulators can set regulator-initial-mode to values specif=
ied in
> +          dt-bindings/regulator/mediatek,mt6392-regulator.h
> +        items:
> +          enum: [0, 2]
> +        maxItems: 1

[Severity: Medium]
This regulator-initial-mode property also appears to be using array validat=
ion
keywords for a scalar value.

> +
> +required:
> +  - compatible
> +
> +additionalProperties: false

[Severity: Low]
Is there an examples section missing from this file?

Device tree binding guidelines require every standalone schema file to incl=
ude
an examples section to provide a validated example of the device node and to
pass dt_binding_check validation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620200032.3341=
92-1-l.scorcia@gmail.com?part=3D3
