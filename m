Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3DE3F1075;
	Fri, 28 Aug 2026 09:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787911174; cv=none; b=czDTUyjGo19cMjI7HaSE6po5+kjAEW8yKqitRtUHWn4M2OnrhVf5FA0enCe/zdiykft+Ln2zxWM5jmOPv7UdWIIbtG5HtEp3PuE03Akt1hYXN3vhOfe2R6IJ9ZSCA44vuIww8iAStA3colM9azwWJmFIlW+0T4raLeg714R3DoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787911174; c=relaxed/simple;
	bh=q+OqUY9U7dAIurBx97+xmYwmAEUVAcyK1ky6iCedwA8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RxNt73ZvS5iAW2GHN0VITrGB7fEFJl4n5NMGL5DjoGu0ctmEMLCH5NMCLEyWoQSrMINUCfrOMbu+Ri/suU0X7T1u2mtu9i1iMk0aiwz2qAP5aRVCHjiTeYac5HdMhesBvxJh504NifMt4sfmSd01nsV8p1QQe8okL4Iq0HinoPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1LblrIR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1LblrIR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF7541F000E9;
	Fri, 28 Aug 2026 09:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787911173;
	bh=4XSVL4EAvhWFKOoWDe6/AiQQA/jQL8MeC70q6Ta6vWA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G1LblrIR8mXxBmWYhjwynQOd7z3G0wSbj0UNR5Uu42CxTMFf2kTbORF4EYMa+Rub4
	 1637JYDtKp4WJTsw2VP1z9P+eUzpfzOgZy7HfQARfvLEZkr7K35CBbtVTrPb7PzLXy
	 EpFoZlR/yhBBWjS+eO5CojZ6kiVxvNS3qQEqD7Tb0zNGul9FJFdO2/awvJ8ajP5ygu
	 QSZdrc+BD72ocKEBdmmJxo/9Du89OykYCbcWjQKV5DATchUoHYjTRBnWG6P2/l1bbY
	 WYbbYGv1gAkNUzj5ViAqRtCc7vDogEMcKsk+uMujIOqaDfOgdIJfGySLxylgQayxPa
	 2I0svF4PjeXAQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/2] dt-bindings: input: Add Qualcomm SPMI PMIC
 haptics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fenglin Wu" <fenglin.wu@oss.qualcomm.com>
Cc: dmitry.torokhov@gmail.com, devicetree@vger.kernel.org, conor+dt@kernel.org, linux-input@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260828-qcom-spmi-haptics-v7-1-0367b3ac2e1e@oss.qualcomm.com>
References: <20260828-qcom-spmi-haptics-v7-0-0367b3ac2e1e@oss.qualcomm.com>
 <20260828-qcom-spmi-haptics-v7-1-0367b3ac2e1e@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 09:59:32 +0000
Message-Id: <20260828095932.EF7541F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The new `haptics` device tree node will cause validation failures b=
ecause it is not permitted by its parent MFD schema.
--

commit 69b46ca6dd857a336fadfc81c3a26d260c9c10ea
Author: Fenglin Wu <fenglin.wu@oss.qualcomm.com>

dt-bindings: input: Add Qualcomm SPMI PMIC haptics

Add binding document for the haptics module inside Qualcomm PMIC PMIH0108.

> diff --git a/Documentation/devicetree/bindings/input/qcom,spmi-haptics.ya=
ml b/Documentation/devicetree/bindings/input/qcom,spmi-haptics.yaml
> new file mode 100644
> index 0000000000000..ce2c9e893a0d7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/qcom,spmi-haptics.yaml

[ ... ]

> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/spmi/spmi.h>
> +
> +    pmic@7 {
> +        compatible =3D "qcom,pmih0108", "qcom,spmi-pmic";
> +        reg =3D <0x7 SPMI_USID>;
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        haptics@f000 {
> +            compatible =3D "qcom,pmih0108-haptics", "qcom,spmi-haptics";

[Severity: Low]
Will the haptics child node cause device tree validation failures against t=
he
parent MFD schema?

The parent schema for qcom,spmi-pmic enforces additionalProperties: false,
but it does not define a patternProperties regular expression that permits
a haptics node. Running dt_binding_check or dtbs_check on this example, or
any actual device tree using this node under the SPMI PMIC, will fail
validation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828-qcom-spmi-=
haptics-v7-0-0367b3ac2e1e@oss.qualcomm.com?part=3D1
