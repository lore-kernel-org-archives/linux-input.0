Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A508F33D51A;
	Tue, 14 Jul 2026 05:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784007079; cv=none; b=YuSPIuR5lPqBxGKSxOvRnvvU3CO8VyFpYFCY41unk1SBwhG3T3KjeYXWIw5vFgnTelQhlVlYzodLHsDReXiAfl5O5B8rjb34XGMlyd4x5HC3WPLABDK87DzGv/yvzglmJ2sx3owezSNa7AZkHes4IPrTF+Awf46o2DQZOKxXM2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784007079; c=relaxed/simple;
	bh=8c5kkbtb1A5hUevNPH6KURWlyhaDE9Xwvp7HZRlxfYM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R26LoJIjkRKM6ws3KbQqDhOq377uivXFA2xJXiqdy945dtEKQJs4nRI/TUawid5iEWyp1ol10ZXlkLdj6G+OvbECrwfAP3aincvgba+O7kWytAckhigHv5TPpZOMxBIWHHUZF+0l0pMotRzVh4FcvwlvVT5dG0oIzwocUmbR3Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOBZA41e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOBZA41e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFBF51F000E9;
	Tue, 14 Jul 2026 05:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784007078;
	bh=z0WoaekG5L6uE/gR9fyqUo+Xz8a/4cvDv/ZupLXFssg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nOBZA41eLLxHcOUZyjXSC2UH8qoAUZkEr7WzvstK68KqHLptRFHv+QahcjqJpz2O4
	 Wfnk2HgvthWgXjBjoC0mJh5QBpnyF0pR0MiR4zcWcfNXbt0ANo46fIjpI7kryJYz0a
	 JUfVG54RUb1hEGXDdP8AhwKbAB6SlMTD9Sjc3URoL/HmwdJLygJIoMYKiymOM/BDBB
	 vU5dSIOQkKrZhtB50tznFpc4bYKF1benQiYQleFhpbm8pC42pmKQVkadkD7KYdQLWl
	 M2r9VBtWit7/rg8C/hc6M2lqg9MZ5zIBzNNogAP3eBcK3PJCP7QbSD0lzyimpzzsR8
	 6pSwmQEW5FAbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: input: Add Qualcomm SPMI PMIC
 haptics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fenglin Wu" <fenglin.wu@oss.qualcomm.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260713-qcom-spmi-haptics-v3-1-c931bb7cb94f@oss.qualcomm.com>
References: <20260713-qcom-spmi-haptics-v3-0-c931bb7cb94f@oss.qualcomm.com>
 <20260713-qcom-spmi-haptics-v3-1-c931bb7cb94f@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 05:31:17 +0000
Message-Id: <20260714053117.DFBF51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing Parent MFD Schema Update for qcom,spmi-haptics
--

--- Patch [1]: [PATCH v3 1/3] dt-bindings: input: Add Qualcomm SPMI PMIC ha=
ptics ---
commit f137781e6c2b5a0d469e1be3c8ce374d67796f68
Author: Fenglin Wu <fenglin.wu@oss.qualcomm.com>

dt-bindings: input: Add Qualcomm SPMI PMIC haptics

This patch adds a new device tree binding document for the haptics module
integrated into Qualcomm PMICs. It covers hardware variants like the
HAP530_HV module in the PMIH0108 PMIC.

> diff --git a/Documentation/devicetree/bindings/input/qcom,spmi-haptics.ya=
ml b/Documentation/devicetree/bindings/input/qcom,spmi-haptics.yaml
> new file mode 100644
> index 0000000000000..b1a69e9886ee6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/qcom,spmi-haptics.yaml

[ ... ]

> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    pmic {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        haptics@f000 {
> +            compatible =3D "qcom,pmih0108-haptics", "qcom,spmi-haptics";
> +            reg =3D <0xf000>, <0xf100>;

[Severity: Medium]
Will this new haptics node cause validation failures in the parent PMIC nod=
e?

The parent MFD binding (Documentation/devicetree/bindings/mfd/qcom,spmi-pmi=
c.yaml)
enforces strict child node validation using additionalProperties: false.
Because this patch introduces a new sub-device schema without adding a
corresponding pattern (like ^haptics@[0-9a-f]+$) to the parent schema's
patternProperties, it seems any actual device tree utilizing this haptics
node will fail dtbs_check with an 'Unevaluated properties are not allowed'
error.

Does the parent schema need to be updated in the same series to permit this
node?

> +            reg-names =3D "cfg", "ptn";
> +            interrupts =3D <0x7 0xf0 0x1 IRQ_TYPE_EDGE_RISING>;
> +            interrupt-names =3D "fifo-empty";
> +
> +            qcom,vmax-microvolt =3D <1300000>;
> +            qcom,lra-period-us =3D <5880>;
> +        };
> +    };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713-qcom-spmi-=
haptics-v3-0-c931bb7cb94f@oss.qualcomm.com?part=3D1
