Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759A137DE9E;
	Mon, 11 May 2026 21:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778534371; cv=none; b=dWR0IYvVZEnyKtwXgZeefjEBmDmc7xJRA6b22myk0Q2vxJhNnCebQMQEJp18qNNK0d7tLHELAiIHTJoifu4uXywMcfUvhNQLQVceBQpLiBWcvE0qNPnpHhSSrc9WuJsi4pFt0vBUh9VNCav9rFzZNX2kLFuVG8YMpYTDQNTml64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778534371; c=relaxed/simple;
	bh=LXBf47To4tnnDhxhX4YEmxV8WIrotm8e5nYJ3ROVLZU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TeZs8iAMYJIdbkmLlAeOCo5+KP0aQQwhGHbPISqQesOV7bQPguQtAlLVPDqqbWKhWn17HvgdsPMSCC+crQguaUfs17JPgeqhGX5BAginh0/9jMk2R3z8LmGhtLbSQkQvIRB7yL8FXYoxh2vnRjrknmPA+CuXZFS7ZfZ/Lm1Qq94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=teTCDRYN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="teTCDRYN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93014C2BCB0;
	Mon, 11 May 2026 21:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778534371;
	bh=LXBf47To4tnnDhxhX4YEmxV8WIrotm8e5nYJ3ROVLZU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=teTCDRYNxnLrGzTHwPC5EZ5OP9++K5zhfHPiQGTQ5CBLFoVa/B+Hw5DSdTblbEjLa
	 RVDz0OAZuTTdQ0eeAiQeBtFZTre2rSxCELgteAwF5gV8t+3OovmEzYw8BLUQq0YgGY
	 Sfv043oX0GqaMCZ8v9g3Yx7Xb5oYWkgLwdxvn0BhoPVHxb8iljamyntzWItyTcefz2
	 jfzNzey21u5Q15cOyacQv754ty+AG3tQwqUMwR33hfcuAZzWeXjBNSGiOoe0jSdzY+
	 lN0ArvYEcYbLvWMmTf9+UFP9fYZcBRk8knkyUuTC9D/zzlZ075+odRff4XVBt7ilrJ
	 hWchlqrb4JrYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/6] dt-bindings: mfd: motorola-cpcap: convert to DT
 schema
Reply-To: sashiko@lists.linux.dev
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: conor+dt@kernel.org, linux-input@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260510110804.33045-4-clamor95@gmail.com>
References: <20260510110804.33045-4-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 11 May 2026 21:19:29 +0000
Message-Id: <20260511211930.93014C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] The YAML schema enforces a `ports` wrapper node for `audio-codec=
`, breaking validation for existing device trees.
- [Medium] The power button subnode name `key-power` conflicts with existin=
g device trees, causing validation failures.
- [Medium] The `spi-cs-high` property was dropped from the `required` list =
during YAML conversion.
- [Low] The schema uses `additionalProperties: false` alongside a `$ref` in=
 `allOf`, which is a dt-schema anti-pattern.
--

commit f0e021d94a5e3dc2af4a93b58f8cc3b052099a76
Author: Svyatoslav Ryhel <clamor95@gmail.com>

dt-bindings: mfd: motorola-cpcap: convert to DT schema

Convert devicetree bindings for the Motorola CPCAP MFD from TXT to YAML.

> diff --git a/Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml b/=
Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
> new file mode 100644
> index 0000000000000..7f257f3a1a5a2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
> @@ -0,0 +1,414 @@
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

Will this cause validation failures for existing device trees?

The new YAML schema defines additionalProperties: false on the
audio-codec node and expects OF graph ports to be nested strictly
inside a ports child node. The original TXT binding example and existing
device trees place port@0 directly under the audio-codec node without
a ports wrapper.

[ ... ]

> +  battery:
> +    $ref: /schemas/power/supply/cpcap-battery.yaml#
> +
> +  charger:
> +    $ref: /schemas/power/supply/cpcap-charger.yaml#
> +
> +  key-power:
> +    $ref: /schemas/input/motorola,cpcap-pwrbutton.yaml#

Is this node name conflict expected?

The schema strictly defines the power button child node as key-power,
but existing upstream device trees name this node button. Since button
is not explicitly defined in the YAML properties, will it be rejected by
dtbs_check?

[ ... ]

> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-controller
> +  - "#interrupt-cells"
> +  - spi-max-frequency
> +  - "#address-cells"
> +  - "#size-cells"

Was spi-cs-high intentionally omitted from the required list?

The original TXT binding explicitly listed it under required properties,
and the hardware requires an active-high SPI chip select to function
correctly.

> +
> +additionalProperties: false

Should this be unevaluatedProperties: false instead?

In JSON schema, additionalProperties: false ignores properties inherited
from $ref inclusions inside allOf. This rejects standard SPI properties
unless they are manually duplicated in the local properties block.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260510110804.3304=
5-1-clamor95@gmail.com?part=3D3
