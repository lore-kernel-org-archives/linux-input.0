Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA3F3BED37;
	Mon, 15 Jun 2026 07:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781508626; cv=none; b=dyb0jGpYI6zKvOcYNlvXHAL2zpQgLt/gE8NL0AmM2Rub+LgOregAhuudPkuI5sf+yIo4y5U4fcLIt4cMStyaDFgqTH/S3+0EflInWHsNc6mxXfWxJlMZdRvhn9aA76eC0CpAH0tJyXbRmH9FGfdlkUHb3DOiawXk8VTlVYuybSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781508626; c=relaxed/simple;
	bh=y6UwJ5MOw0dq+rfBKs4kyJcLVPSToP194oXR4GkQvn8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kfk7YpI21/kJaqKAJyDU5DYDFAQlxw6ycd3QpLhmc/3wKhPLhUlKtAZTlzdWYYUEv63k5oCnOdjnL2sm1+3nsfm4S3HbTwqPLX48BF0vkp6xdm+AmBRm2gAbFsW1I+JtnHBqxs+viFhEi7KOO1bIesMvOEv2YAPTcDpBQpbEKIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIoC8QyH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIoC8QyH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA6FD1F000E9;
	Mon, 15 Jun 2026 07:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781508625;
	bh=yGMGe+zkwAGx9B/5a+xnZRYO8XIsZ/bQ2Bn+QFAHPEY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EIoC8QyHGfye0EJzPl6zSEAQjbOesvGKl0Jy2kYH0doAOz6IbtyOBVjOzLZPmofPf
	 FA8LNbbOGAMewcHItb+h0f/LExss+luYE8rQKSpvGBzXDMJg0RrnqmTLR44lsGBnnG
	 /VBJ0w9Dq1Py4Emfy0kPI2WwFhiDoLQLLwReUExfu/iWrzYao1IcIiAIKSDAVTt6Os
	 ZQlfB+knWWonkxXwhu7JmzarKA3qw1Xe27smxomdoDJdkLoQiR+gF8RH1Au7c9qj2Y
	 KquYIpiYHK6Yci9vkbq3P+f653mYf664fXugvKyymNIt5TW+1LS8aXCyKrlzrZU7Yp
	 10y2R73pZ/ITw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/9] regulator: dt-bindings: Add MediaTek MT6392 PMIC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luca Leonardo Scorcia" <l.scorcia@gmail.com>
Cc: dmitry.torokhov@gmail.com, robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, linux-input@vger.kernel.org
In-Reply-To: <20260615071836.362883-4-l.scorcia@gmail.com>
References: <20260615071836.362883-4-l.scorcia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 07:30:24 +0000
Message-Id: <20260615073024.AA6FD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Incomplete schema constraints for `regulator-initial-mode` and `=
regulator-allowed-modes`.
- [Low] The Device Tree example includes an unrelated header and fails to d=
emonstrate new binding properties.
--

commit 7a57eb124bc9a8ab53b73fb4508d2222b254ee23
Author: Luca Leonardo Scorcia <l.scorcia@gmail.com>

regulator: dt-bindings: Add MediaTek MT6392 PMIC

This commit adds device tree bindings for the regulators found in the
MediaTek MT6392 PMIC. It provides schemas for three buck converters and
several LDOs, including constraints for allowed mode settings.

> diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6392-=
regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt639=
2-regulator.yaml
> new file mode 100644
> index 0000000000000..197041df4ba1a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6392-regulat=
or.yaml

[ ... ]

> +patternProperties:
> +  "^v(core|proc|sys)$":
> +    description: Buck regulators
> +    type: object
> +    $ref: regulator.yaml#
> +    properties:
> +      regulator-allowed-modes:
> +        description: |
> +          BUCK regulators can set regulator-initial-mode and regulator-a=
llowed-modes to
> +          values specified in dt-bindings/regulator/mediatek,mt6392-regu=
lator.h
> +        items:
> +          enum: [0, 1]

[Severity: Medium]
The description here mentions both regulator-initial-mode and
regulator-allowed-modes, but only regulator-allowed-modes is constrained.
Since regulator-initial-mode is not explicitly defined in these properties,
does it fall back to the unconstrained uint32 definition from regulator.yam=
l#?
Should regulator-initial-mode be added here to restrict it to [0, 1] as wel=
l?

> +    unevaluatedProperties: false

[ ... ]

> +  "^v(cama|dig18)$":
> +    description: LDOs with fixed output without mode setting
> +    type: object
> +    $ref: regulator.yaml#
> +    unevaluatedProperties: false

[Severity: Medium]
The description states these LDOs are "without mode setting", but the schema
does not explicitly forbid the mode properties. Because of the reference to
regulator.yaml#, doesn't this implicitly allow both regulator-initial-mode =
and
regulator-allowed-modes to pass validation?

> +
> +  "^v(aud22|camaf|camd|cn35|efuse|emc3v3|gp1|gp2|m|mc|mch)$":
> +    description: LDOs with adjustable output
> +    type: object
> +    $ref: regulator.yaml#
> +    properties:
> +      regulator-allowed-modes: false

[Severity: Medium]
This explicitly forbids regulator-allowed-modes. Should regulator-initial-m=
ode
also be set to false here to fully prevent mode settings on these adjustable
LDOs?

> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>

[Severity: Low]
Is the arm-gic.h header needed here? There do not seem to be any interrupt
definitions in the example block.

Also, would it make sense to include the newly added
dt-bindings/regulator/mediatek,mt6392-regulator.h header instead, and add at
least one example usage of regulator-initial-mode or regulator-allowed-mode=
s?
This would ensure the new properties and custom constraints are actively
exercised by the schema validator.

> +
> +    regulators {
> +      compatible =3D "mediatek,mt6392-regulator";

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615071836.3628=
83-1-l.scorcia@gmail.com?part=3D3
