Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E45427A06;
	Tue, 16 Jun 2026 10:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781605036; cv=none; b=deUzITuheL83Z7T2JGBceMIm4ifxmHCLD+j6EIa5M4E6p5or0iaEZ4BvLRCHxkkSP7XIH5HfR0029pHxcLS9zEhIBawQ3ODQ26r3yjS4+VRHZsc/wJY1ZBKn5sSwPOszdx/JzZW1LGcacuhsyTu1qJYEU7ffHAzYeOQqlJ8NBsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781605036; c=relaxed/simple;
	bh=Sd7yodx4UjxiO1kYmuXLn/zWxJQG/zJVsR3dXRgOmFw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Iu0TI4gbcshBP59zmK0syK93Dre40x7fnONaiQUWPzhacwzL2weCNeQBxUrC39UR+9pZotYTK01N0Tpq3/uLKZYH3armUl+n7hcWlFQjSNkccoiXBwdz9IscOYifW1fPorjJkEtKMIqMBgcN7tJkwqQRJcFeeQQUNoJ+TsIrwMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebFMlZ41; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebFMlZ41"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E5B1F000E9;
	Tue, 16 Jun 2026 10:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781605035;
	bh=XPvA0lxmzSRezVHw61eAohFfU/8m3+vlMPaNgVMQSvI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ebFMlZ41LV7Vhzf4J2SGywFBLSq9bRfRA+RFbLk9kiNs7vIZc0pe9A9p1poh9dXRk
	 5b3/3+Q9UQE8cKiPMhXx+BgoTwVJhdXQwxeAqcPaK7BEP+9/4HD4SGjL10OFHqs/Jp
	 SoY63oZJaqoqUgu7tVYospg6+G7q24cmSw2elDSOTrbLtw3VII+ON6pXaVUwaz4kKV
	 KoM0Z38972jXn0aw0isnDlM7j4z9c8kWutfE7HfFWxZjZwS5hUx/lUB+1jg0CM3SgP
	 g/+o/3Itf2xo7+Lfn1wyqIAmhNxHspFIxMeNxfCBf+QIHNCaT8azDnrH9Yzp4uZm80
	 A6WKTcdfeqLHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: mfd: qcom,spmi-pmic: Document haptics
 device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fenglin Wu" <fenglin.wu@oss.qualcomm.com>
Cc: conor+dt@kernel.org, robh@kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, devicetree@vger.kernel.org
In-Reply-To: <20260616-qcom-spmi-haptics-v1-2-d24e422de6b4@oss.qualcomm.com>
References: <20260616-qcom-spmi-haptics-v1-2-d24e422de6b4@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 10:17:14 +0000
Message-Id: <20260616101715.01E5B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Use of a wildcard ('x') in the compatible string.
--

commit 24bf9f2257f4052d27a53163621c8f5173fe1da8
Author: Fenglin Wu <fenglin.wu@oss.qualcomm.com>

dt-bindings: input: Add binding for Qualcomm SPMI PMIC haptics

Add binding document for the haptics module inside Qualcomm PMIH010X.

> diff --git a/Documentation/devicetree/bindings/input/qcom,spmi-haptics.ya=
ml b/Documentation/devicetree/bindings/input/qcom,spmi-haptics.yaml
> new file mode 100644
> index 0000000000000..0e26d68563dcd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/qcom,spmi-haptics.yaml
> @@ -0,0 +1,119 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---

[ ... ]

> +properties:
> +  compatible:
> +    const: qcom,pmih010x-haptics

[Severity: Low]
Does this introduce a regression by using a wildcard character ('x') in the
compatible string?

Device tree specifications generally forbid wildcards in compatible strings.
Should the specific model name of the first chip in the family
(e.g., "qcom,pmih0108-haptics") be used instead of a wildcard?

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
> +            compatible =3D "qcom,pmih010x-haptics";

[Severity: Low]
Does this example share the same regression with the wildcard compatible
string?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616-qcom-spmi-=
haptics-v1-0-d24e422de6b4@oss.qualcomm.com?part=3D2
