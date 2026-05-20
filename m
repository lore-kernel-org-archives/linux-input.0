Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55D3369D7E;
	Wed, 20 May 2026 18:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779303141; cv=none; b=s7yGzq/KRWy+RkNrqlWkaSl8X1kElxUWBYdBbAL0sz5m01cuRDgKfA2b5EnDnyQr2hQSpq11fPgDxJuC42oLa3BAL5Tb/vc2Fh+hzRemTCiFo9jWx8buMKSe6Gg3B/FC2WoInaVLTaC3OLIftqCuxZW0kfRHh5poOYM8NXz/iMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779303141; c=relaxed/simple;
	bh=D/jNgV65/ZG1ywKmbykoHTxm9c1hUZOHb7Bzk82fy0A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cATZcMwphgIE4t3y4c2+guq8hltLEZr3Lqo6CaaRAy2JuWdOLLu9TnRKrc9oU6/xZGQjTJ1HPnaMpZYYLPo0t3zm4oGEeIwvSpTAx87mYpuGTiym/p7lGSE2S2iujADvdJndTrBIWqPTmR2/KxZkiCFPHqtHfKKjnqCEoG4DoYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mi+HonTY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mi+HonTY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 576501F000E9;
	Wed, 20 May 2026 18:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779303139;
	bh=0zV36OtqY2PEdcKfdB9mqH/ugGrhGsG66wuRqtE44nw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mi+HonTYTLhry+jqCa+eu+4NB5xGxyei0K+UANQjYjzQYcw9Iy4Udcks4tJmaKzgb
	 SVJLHuGOJSNqOYA0wCSzArm9DDRARM2QnJjqXoDx1WIzDY01J/+uTSKp5s39qTVdbq
	 isXr7sNpu8xFW8beCC50q6eg4L/hGDSTsmlwP9XYoLR9Pu9SIOUey7pS5cK1yntPGN
	 IrZwiyZDjESjloI0D9nd8Fe9lMohKT6xWKCBtDrq7MMjl33OxFjjgUTzl77C1uFXnh
	 gPb+qky4woEdP0GDmqJ5DKyhrelvwaV9fqapf+9QsOJDMq6TlYTYDDkdCBGDnn36KB
	 DSAD3yhNyjD6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/6] dt-bindings: mfd: motorola-cpcap: convert to DT
 schema
Reply-To: sashiko-reviews@lists.linux.dev
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: devicetree@vger.kernel.org, linux-input@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260520182124.117863-4-clamor95@gmail.com>
References: <20260520182124.117863-4-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 18:52:18 +0000
Message-Id: <20260520185219.576501F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] The YAML conversion introduces structural differences and omits pr=
eviously required properties, causing schema validation to fail for existin=
g in-tree device trees.
- [Medium] Incorrect use of 'additionalProperties: false' in conjunction wi=
th inherited schemas via 'allOf: - $ref', blocking standard SPI properties.
- [Medium] The `spi-cs-high` property was required in the original TXT bind=
ing but is missing from the YAML `required` list.
- [Medium] The YAML binding strictly requires exactly two compatible string=
s, contradicting the original TXT binding which allowed 'One or both'.
--

commit a23d8229dfec6cdc65afe36d12b859535df8cfc9
Author: Svyatoslav Ryhel <clamor95@gmail.com>

dt-bindings: mfd: motorola-cpcap: convert to DT schema
   =20
Convert devicetree bindings for the Motorola CPCAP MFD from TXT to YAML.

> diff --git a/Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml b/=
Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
> new file mode 100644
> index 0000000000000..76705ea56805a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
> @@ -0,0 +1,403 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/motorola,cpcap.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Motorola CPCAP PMIC MFD
> +
> +maintainers:
> +  - Svyatoslav Ryhel <clamor95@gmail.com>
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: motorola,cpcap
> +      - const: st,6556002

[Severity: Medium]
Does this strict array configuration restrict compatible strings too much?
The original txt binding indicated that "One or both" strings were
acceptable, but this yaml structure enforces exactly both strings in this
specific order. Could this cause a regression for hardware implementations
that only use a single compatible string, which the driver supports?

> +
> +  reg:
> +    maxItems: 1

[Severity: High]
Are #address-cells and #size-cells missing from this top-level node?
The original txt binding explicitly required these, and existing in-tree
device trees (like arch/arm/boot/dts/ti/omap/motorola-cpcap-mapphone.dtsi)
use them. With additionalProperties: false set, will this cause a regression
where existing valid dts files fail validation?

[ ... ]

> +  audio-codec:
> +    type: object
> +    additionalProperties: false
> +
> +    properties:
[ ... ]
> +      ports:
> +        $ref: /schemas/graph.yaml#/properties/ports
> +
> +        properties:
> +          port@0:
> +            $ref: /schemas/graph.yaml#/properties/port
> +            description: port connected to the Stereo HiFi DAC
> +
> +          port@1:
> +            $ref: /schemas/graph.yaml#/properties/port
> +            description: port connected to the Voice DAC
> +
> +        required:
> +          - port@0
> +          - port@1

[Severity: High]
Does this structurally conflict with existing in-tree device trees?
The new schema requires a ports container for the audio codec, but existing
in-tree device trees define port@0 and port@1 directly under the audio-codec
node without a wrapper. Since no patch in this series updates the
corresponding dtsi files, won't this cause a regression where existing devi=
ce
trees are incorrectly rejected?

[ ... ]

> +  key-power:
> +    $ref: /schemas/input/motorola,cpcap-pwrbutton.yaml#

[Severity: High]
Will this correctly match the existing device tree nodes?
The schema expects the subnode to be named key-power, but existing in-tree
device trees use the name button (e.g., power_button: button { ... }).
This mismatch will likely cause a regression for the subnode validation.

[ ... ]

> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-controller
> +  - "#interrupt-cells"
> +  - spi-max-frequency

[Severity: Medium]
Should spi-cs-high be included in this required list?
The original txt binding explicitly listed spi-cs-high as a required proper=
ty,
and the pmic physically requires an active-high spi chip select to function.
If it is omitted from this list, could a device tree missing this hardware
constraint incorrectly pass schema validation?

> +
> +additionalProperties: false

[Severity: Medium]
Should this use unevaluatedProperties: false instead of
additionalProperties: false?

When inheriting from another schema like spi-peripheral-props.yaml via an
allOf reference, additionalProperties: false will reject the inherited
properties unless they are manually redefined in this file. Using
unevaluatedProperties would properly handle the inherited spi properties
and remove the need to manually declare spi-cs-high, spi-cpol, and
spi-cpha above.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520182124.1178=
63-1-clamor95@gmail.com?part=3D3
