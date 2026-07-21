Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8833DB64B;
	Tue, 21 Jul 2026 10:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784628928; cv=none; b=oQP+R9NK7ANhdUMhiVC7GIT08VvuLrAKIfw/vwqUTOwpZtuaumbhsKzkujacrDd0l4nsKlY/ggDaI51B3LNA3LQ8MGeM4YXHViejVwX5lNMq5jTIpZT+ybgxQSxyZDW1oYgNjgpDUxxslWKJrxzDSVcVNM3kHBR41P9J+t4BPeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784628928; c=relaxed/simple;
	bh=VcxtAUHxNdBbgZdA0jG6Cw4bzoGSA/cuxKBpvU0kt04=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IYnRYY1XZMFvuKSkFFCAKHv7jGswkbUhR4xFiyc7eRqkr2w0eYflYI+YqtbZWy1o+HyA0gL170r5a70CJXTzdfiltqjc2FzsnuisuT6qLwuVgMx1f6GnF8WMqOd2GyA8u61QN6Wtel0HuLMcKgLDj4b1Rt6689j+107VsVB1Af0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9M4oW0C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9M4oW0C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2C5C1F000E9;
	Tue, 21 Jul 2026 10:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784628927;
	bh=Ozlre7lFK+XdiHcz8ARIiALsGWVozgG1epJC3exQsmU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h9M4oW0CPK2da9f7MHEjkBY5BWelwPVKDJrecwb1hlpzDw8qfjjYRtYDS8tt62dKr
	 l5U4P6GhrP+5mYhKCg/MtghAtH3PLZPuv6CWy9t90kw8wJ67eS8qT2f0aXRR4XY8Kx
	 XaNZEQFlxkXpA02tG7UDIZhKOCKRktYF3KsjZPeAAISMyT8lo/XlcI0fdu5QJnFptG
	 XaBbB0Lo/gowLbqLHGadF74cJbq+0BjxtdXz8s+DWbYnUBQ/JUFndCvEZo308E4dx2
	 4xXROzU/SptCuiNuqufUMFChapd1BapMiULl3+azt6ySBFgMvaXjMAQOwHn8k+ojWV
	 NoqnEfghCASEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/6] dt-bindings: mfd: motorola-cpcap: convert to DT
 schema
Reply-To: sashiko-reviews@lists.linux.dev
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: linux-input@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-leds@vger.kernel.org, dmitry.torokhov@gmail.com, lee@kernel.org
In-Reply-To: <20260721095654.429346-4-clamor95@gmail.com>
References: <20260721095654.429346-1-clamor95@gmail.com>
 <20260721095654.429346-4-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 10:15:26 +0000
Message-Id: <20260721101526.D2C5C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Medium] YAML schema omits `#address-cells` and `#size-cells` properties =
for the root node, causing validation failures for existing device trees.
- [Medium] Schema strictly expects the power button node to be named `key-p=
ower`, breaking validation for the legacy `button` node.
- [Medium] The `audio-codec` schema expects a `ports` wrapper, breaking val=
idation for legacy direct `port@0` definitions.
- [Low] The `spi-cs-high` property was dropped from the schema's `required`=
 list.
- [Low] Commit message description is not capitalized, violating MFD subsys=
tem guidelines.
--

--- Patch [3]: [PATCH v7 3/6] dt-bindings: mfd: motorola-cpcap: convert to =
DT schema ---
commit 4de37a9bd5e5179740a9f015e1900ab235da93ae
Author: Svyatoslav Ryhel <clamor95@gmail.com>

dt-bindings: mfd: motorola-cpcap: convert to DT schema
   =20
Convert devicetree bindings for the Motorola CPCAP MFD from TXT to YAML.

> dt-bindings: mfd: motorola-cpcap: convert to DT schema

[Severity: Low]
This isn't a bug, but the MFD subsystem guidelines require the description
after the subsystem prefix to be capitalized. Should "convert" be "Convert"?

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
Does omitting #address-cells and #size-cells from the properties block
break validation for existing device trees?

Because this schema sets additionalProperties: false, running make dtbs_che=
ck
against existing in-tree device trees (like
arch/arm/boot/dts/ti/omap/motorola-cpcap-mapphone.dtsi, which uses
#address-cells =3D <1> and #size-cells =3D <0> on the pmic@0 node) will fal=
sely
report validation errors.

[ ... ]

> +  audio-codec:
> +    type: object
> +    additionalProperties: false
> +
> +    properties:
> +      interrupts:
> +        items:
> +          - description: headset detect interrupt
> +          - description: microphone bias 2 detect interrupt
> +
> +      interrupt-names:
> +        items:
> +          - const: hs
> +          - const: mb2
> +
> +      "#sound-dai-cells":
> +        const: 1
> +
> +      VAUDIO-supply:
> +        description:
> +          Codec power supply, usually VAUDIO regulator of CPCAP.
> +
> +      ports:

[Severity: Medium]
Will this strict ports wrapper requirement cause validation failures for
legacy device trees?

Existing device trees place port@0 directly inside the audio-codec node:

arch/arm/boot/dts/ti/omap/motorola-cpcap-mapphone.dtsi:
    cpcap_audio: audio-codec {
        ...
        port@0 {
            cpcap_audio_codec0: endpoint { ... };
        };
    };

With additionalProperties: false set on the audio-codec node, dtbs_check
will flag these direct ports as illegal properties.

[ ... ]

> +  charger:
> +    $ref: /schemas/power/supply/cpcap-charger.yaml#
> +
> +  key-power:
> +    $ref: /schemas/input/motorola,cpcap-pwrbutton.yaml#

[Severity: Medium]
Does hardcoding the node name as key-power break validation for the legacy
button node?

Existing device trees use the button node name:

arch/arm/boot/dts/ti/omap/motorola-cpcap-mapphone.dtsi:
    power_button: button {
        compatible =3D "motorola,cpcap-pwrbutton";
        ...
    };

Since this schema enforces the exact name key-power, make dtbs_check
will flag the existing button node as an invalid property.

[ ... ]

> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-controller
> +  - "#interrupt-cells"
> +  - spi-max-frequency

[Severity: Low]
Is it intentional to drop spi-cs-high from this list?

The legacy text binding explicitly documented spi-cs-high as a required
property, which reflects the hardware's active-high chip select requirement.
Omitting it here relaxes the constraint and might allow inaccurate device t=
rees
to pass validation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721095654.4293=
46-1-clamor95@gmail.com?part=3D3
