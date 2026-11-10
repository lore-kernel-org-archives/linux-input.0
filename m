Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794309928;
	b=S/RrNMagGqsqignpvg9cb8/pBm8oVFJfQhkf2Wn9Tp6C969Du5LSZTfIqHeg3ZWItMZ7
	 NrN58794wh92SoNQP5s9SuxrzUxm4K1iHPAzMwABFoUuXiL9MDoOCGpHPAysN/WHxDFJ3
	 CWq9cmVyCFvvL+WYGuW1tuL6dmP/tZb4hDqYptpwEum+LyuHSsbuflQ6k7ICUV2c5barl
	 AP4gJZmaOEHMs+Nd4zKsuz5ndFZgg/2Xa4xS/tgx5csa5C6o6vvleKbmjx1WRbonzNSCd
	 PQ+In9fvyMpaetU4lc8rMsfVwTXD7+FBHYNhaC3s6KM+RLDX/ug4z9HjP+qVZqw7NxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794309928;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BeXxj1zXzSE9HOLXh5LlGJ+ewK4lJQOb8VjGVO/mANg=;
	b=imPweYXDLs/7L6RtclRSsUprUyZ1GtfoBJ3HJOPYFklQGUjrtXxcgAUDVO7ORXz0KKFX
	 rMzSK2NrAhofhyieO2rKjQkv3thxKrEkeLaNMsq4VRy8bVTx9uAC0tmOVfUKLaWT+ThlK
	 PpxUHTKuoWra4E26l+5vbgCmTTbBmsddSBML5fB+RDuJz030UcbtYpkgXZOQfmqtyuhsN
	 g8hVARuL+9RzYUqZe8gHMUtkMbrRqU4v5oTqa83Yr0TrWWRal11XAtv5W+nkD4zZ4mPDw
	 oBuISww17I2gt/LW/Rtxod61HqjOe/DaHB1zX2wowedn6HygvPRCNdKSie3ZQxdRrBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N0syFmh9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E39606A31C;
	Tue, 10 Nov 2026 11:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N0syFmh9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9343A1F008A2;
	Tue, 10 Nov 2026 11:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794309927;
	bh=BeXxj1zXzSE9HOLXh5LlGJ+ewK4lJQOb8VjGVO/mANg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N0syFmh9+Ycfw+iSuG1WSqrWbSRlP3ra5p3+lEzLqjgN7CSU0WvHoGb4d8UAbaHeX
	 bsPfNz30xm2ShQmRkXalaDxGY+B1Wnp1tam7VWhumxzMbYwc1TcQlF+cnRvoRAcB+j
	 RNdrPyyzdFLoWYpqjTk8B4e4wVIt38DUfw9k9ACf6i8WM4TExGFyAYjL2PidYAFevR
	 oSoiNU39eU1CSep1pHyusP/uZJ+I/jimgQgKphCN4M0TkKmZLeXFn6astcXdFicZZq
	 Qoe+c1ErP28eXHVw4O2tfCoNCenDR/5EPRFo1EdEVyYokI8TSKxkRoyomMzgr23he/
	 3I8Ovus7R7ung==
Message-ID: <sashiko-outbox-206935@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: input: Add Nuvoton MA35D1 keypad
 controller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Feng-Yi Hsueh" <fyhsueh4linux@gmail.com>, linux-input@vger.kernel.org
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261110111419.89535-2-fyhsueh4linux@gmail.com>
References: <20261110111419.89535-1-fyhsueh4linux@gmail.com>
 <20261110111419.89535-2-fyhsueh4linux@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 11:25:27 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Low] dt-bindings: input: ma35d1-keypad: redefine autorepeat instead
  of input.yaml#
- [Low] dt-bindings: input: ma35d1-keypad: omit resets property for
  MA35D1_RESET_KPI
- [Low] dt-bindings: input: ma35d1-keypad: bad clock/IRQ cells and align
  in example
--

commit 6eade3d3eb06d707c8d9f0ddfa65827ec7270074
Author: Feng-Yi Hsueh <fyhsueh4linux@gmail.com>

dt-bindings: input: Add Nuvoton MA35D1 keypad controller

This commit adds the Device Tree binding schema for the Nuvoton MA35D1
matrix keypad controller.

> diff --git a/Documentation/devicetree/bindings/input/nuvoton,ma35d1-keypa=
d.yaml b/Documentation/devicetree/bindings/input/nuvoton,ma35d1-keypad.yaml
> new file mode 100644
> index 0000000000000..be678d0b38b98
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/nuvoton,ma35d1-keypad.yaml
> @@ -0,0 +1,73 @@
[ ... ]
> +allOf:
> +  - $ref: /schemas/input/matrix-keymap.yaml#
> +
> +properties:
> +  compatible:
> +    const: nuvoton,ma35d1-keypad
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1

[Severity: Low]
Should properties also document resets (with maxItems: 1)?

include/dt-bindings/reset/nuvoton,ma35d1-reset.h defines MA35D1_RESET_KPI f=
or
this controller, and drivers/reset/reset-ma35d1.c implements it in
ma35d1_reset_map.  Because this schema sets unevaluatedProperties: false, a=
ny
board or SoC devicetree node specifying resets =3D <&sys MA35D1_RESET_KPI> =
will
fail dtbs_check validation.

> +
> +  keypad,num-rows:
> +    minimum: 2
> +    maximum: 8
> +
> +  keypad,num-columns:
> +    minimum: 1
> +    maximum: 8
> +
> +  autorepeat:
> +    type: boolean
> +    description: Enable key autorepeat events.

[Severity: Low]
Should this schema reference input.yaml# in allOf instead of redefining
autorepeat locally?

Documentation/devicetree/bindings/input/input.yaml already defines autorepe=
at
with its type and description, so referencing input.yaml# in allOf (and at
most listing autorepeat: true here) avoids duplicating the common property
definition.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - keypad,num-rows
> +  - keypad,num-columns
> +  - linux,keymap
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/input/input.h>
> +
> +    keypad@404a0000 {
> +        compatible =3D "nuvoton,ma35d1-keypad";
> +        reg =3D <0x404a0000 0x10000>;
> +        interrupts =3D <79>;
> +        clocks =3D <&clk>;
> +
> +        keypad,num-rows =3D <4>;
> +        keypad,num-columns =3D <1>;
> +        linux,keymap =3D <
> +            MATRIX_KEY(0, 0, KEY_1)
> +            MATRIX_KEY(1, 0, KEY_2)
> +            MATRIX_KEY(2, 0, KEY_3)
> +            MATRIX_KEY(3, 0, KEY_4)
> +        >;
> +    };

[Severity: Low]
Should the example include the GIC interrupt specifier and the KPI_GATE clo=
ck
cell, and align the linux,keymap entries?

On MA35D1, the interrupt controller uses three GIC cells (such as
<GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>) and &clk takes a clock specifier cell
(<&clk KPI_GATE> from dt-bindings/clock/nuvoton,ma35d1-clk.h).  Also, the
multi-line linux,keymap entries are indented by four extra spaces rather th=
an
aligned with the opening bracket, which triggers continuation-alignment
warnings from scripts/dtc/dt-check-style --mode=3Dstrict.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110111419.8953=
5-1-fyhsueh4linux@gmail.com?part=3D1
