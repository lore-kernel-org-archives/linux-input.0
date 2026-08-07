Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C0F43F087;
	Fri,  7 Aug 2026 06:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786084169; cv=none; b=t/rEjBeQ5ZaFBrGXlUsy1tabnxXJJAeVXrjvT4yhiQDvnUCYv82CbOcaozopvzpN1RET68lV7utEDgEzIWDmrwi57mx5VUKJMMsLxG4dQRNcY86436PX/DSWQx9PXFjjV2kr3ZqYA5itqjDDVyYZklllWU+kVL8o0fMO+src99c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786084169; c=relaxed/simple;
	bh=mZqAyjmhbfofTHKjgmgwBmiqgOo5Nz/HBLfrg0NyZN4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fGc4NT8roEfpz5LQkwuO/QIY8v8fVGMZ+/2RK5VcGyIy9GOBkJMdnF9xDPC+dFgibXOCV8HwFtRo9vfC/OuVwmW9zOMzZwWaVtP9/4Y3xaO3ib0lUiva6+ieaatmGvj9eCZkjEwvVnhximFepBoX7xEKmgyVIc2fMBzxeLP9S6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9/q7l7Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9/q7l7Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 548EF1F000E9;
	Fri,  7 Aug 2026 06:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786084167;
	bh=J8EpiUfU8k5snsbHZgtmtySwD2+8YeXJSk0uFIQZ7/A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H9/q7l7YsszMCF0qGK9zOmtrYueby5QBY1ZvOMGcNu66YFFzxfxeLw3ZD9u10w52s
	 nmENnfGcBuN8mCvvYWql94vgPp4VAVpiC1/qVU6LPgcTwzY9s21SUSjV5glLqh0jax
	 4CYYYv2hWZH+jmySWyX+GbOlCVRVl2Rftx+G3bo1pGolveRMvN/e59P33Gjk33+3C7
	 OmVIJ0OjW6+qA2cG1F5QP6amqTX8+UXHLu5FWrxj3xrckmtNGeXIaMcJWebk1hYfy2
	 EOGOVoEfRi3ePVdhsgCScoplFbN07iUsnHQqsN954tDLgl4A4m5gbm/zqZeWFitNd9
	 uWVy6tZYFdN7Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: input: Add Qualcomm SPMI PMIC
 haptics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fenglin Wu" <fenglin.wu@oss.qualcomm.com>
Cc: dmitry.torokhov@gmail.com, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org
In-Reply-To: <20260806-qcom-spmi-haptics-v6-1-19fcecd5204f@oss.qualcomm.com>
References: <20260806-qcom-spmi-haptics-v6-0-19fcecd5204f@oss.qualcomm.com>
 <20260806-qcom-spmi-haptics-v6-1-19fcecd5204f@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 06:29:26 +0000
Message-Id: <20260807062927.548EF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing update to the parent PMIC schema `qcom,spmi-pmic.yaml` to a=
llow the new `qcom,spmi-haptics` child node.
--

--- Patch [1]: [PATCH v6 1/2] dt-bindings: input: Add Qualcomm SPMI PMIC ha=
ptics ---
commit eb446753c24c30e9b557074281da814e0e94aa51
Author: Fenglin Wu <fenglin.wu@oss.qualcomm.com>

dt-bindings: input: Add Qualcomm SPMI PMIC haptics

Adds a device tree binding document for the haptics module inside the
Qualcomm PMIC PMIH0108, which drives a Linear Resonant Actuator (LRA) and
supports multiple play modes.

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

[Severity: Low]
Does the parent PMIC schema (mfd/qcom,spmi-pmic.yaml) need to be updated to
allow the new qcom,spmi-haptics child node shown in this example?

The parent PMIC schema has additionalProperties: false and explicitly lists
allowed child node patterns in patternProperties. Since it does not include
a pattern for ^haptics@[0-9a-f]+$, will device trees instantiating this
haptics node fail dtbs_check validation?

> +            reg-names =3D "cfg", "ptn";
> +            interrupts =3D <0x7 0xf0 0x1 IRQ_TYPE_EDGE_RISING>;
> +            interrupt-names =3D "fifo-empty";
> +
> +            qcom,vmax-microvolt =3D <1300000>;
> +            qcom,lra-period-us =3D <5880>;
> +        };
> +    };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806-qcom-spmi-=
haptics-v6-0-19fcecd5204f@oss.qualcomm.com?part=3D1
