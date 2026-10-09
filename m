Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292BA3F54BD;
	Fri,  9 Oct 2026 12:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791548371; cv=none; b=TvwqlOMWO2u+qLlBylF5XDHL2kXP8eWk+AmBlz86ycLp+h32yfU0hD5qTw6RkxAIZZsX30bEDOPNBj3UCF9vq6ASjy/SZEbsKCPz4Mz3Yoz5H5ZbA3pyTwE90jPPrgcPyIXxbLl5t+7dMQbSsHND5yjjsfdQK5r55Z3v2l8wMLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791548371; c=relaxed/simple;
	bh=sdWtTQgIHKiNefzEPfn0lDmHP+2mMTZz8RVexsIh8eU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=AkL8pmm7Lm91MHuqp7iV9cIgqHWeCVcr5ovmyy9IBtWNf8UTVxlVzio3K2EN8DrFrO3RVwAD9hl9gf6IyeXdokBfSZ859WbeTgPDAr4JNNyAvGH9bEInBHNmkdPl/HN20SEE1x1LtwfkhO98wapIB/67miiMql6yJCBhcqW5xqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZIzTWFk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZIzTWFk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F2851F000FF;
	Fri,  9 Oct 2026 12:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791548363;
	bh=CcfwOShsx0laJwIhvuEtut8EDI2FI8xZxgJUimEifFo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AZIzTWFkOqSxuQ5StNKSBGiLrVBV2y3+7rnSvA6UddMM34N3SQPVDy/mMPeuslXHt
	 hBmz/ZGATOblb5s2hy0Bj3N8h71LY53/M70SW+XBXXYFvyLaoTy7J+C0qdSbIgoDxe
	 tY4YnVeQgNX9eoGmuzgRXVTKBL/x7klHkV/LDKhK6eUPHeukCjhxffM7/6OkxAo6W+
	 q0uBRRndSEyBvVJ2PcQ6gZgNzQwPhNVhUlwZ2ptHW6KbFRFz0T+55ueNvQRhSaltxo
	 LolccVDZCrqhSM1YgHBRK++Q3aD5CGPZJX5ZskKykm8get/jIdZlIgQ2/mjwfjnsw1
	 NocYke2ODEnbg==
Message-ID: <sashiko-outbox-165517@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: input: add OnePlus pogo-pin keyboard
 binding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yibo Wang" <wyibo6109@gmail.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261009121143.550498-2-2024312277@stu.hit.edu.cn>
References: <20261009121143.550498-1-2024312277@stu.hit.edu.cn>
 <20261009121143.550498-2-2024312277@stu.hit.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 12:19:22 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] dt-bindings: incorrect use of additionalProperties: false with a=
llOf $ref
- [Medium] dt-bindings: custom properties lack vendor prefix and explicit t=
ype reference
- [Low] dt-bindings: unnecessary #address-cells and #size-cells in example =
serial node
--

commit 9e61ffe1ac817966b2b3b703148b7060c7724704
Author: Yibo Wang <wyibo6109@gmail.com>

dt-bindings: input: add OnePlus pogo-pin keyboard binding

Adds device tree bindings for the Tinno keyboard MCU used by OnePlus and
OPPO tablets over a serial bus.

> diff --git a/Documentation/devicetree/bindings/input/oneplus,pogo-keyboar=
d.yaml b/Documentation/devicetree/bindings/input/oneplus,pogo-keyboard.yaml
> new file mode 100644
> index 0000000000000..3086a2c4e2895
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/oneplus,pogo-keyboard.yaml
[ ... ]
> +allOf:
> +  - $ref: /schemas/serial/serial-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    const: oneplus,pogo-keyboard
[ ... ]
> +  wake-gpios:
> +    description: GPIO signalling attach/detach, also used as the wake li=
ne.
> +    maxItems: 1
> +
> +  touchpad-xy-max:
> +    description: Touchpad maximum X and Y coordinates in units.
> +    items:
> +      - description: maximum X
> +      - description: maximum Y
> +    minItems: 2
> +    maxItems: 2
> +
> +  touchpad-xy-resolution:
> +    description: Touchpad X and Y resolution in units per millimetre.
> +    items:
> +      - description: X resolution
> +      - description: Y resolution
> +    minItems: 2
> +    maxItems: 2

[Severity: Medium]
Do these custom properties need a vendor prefix and an explicit type
definition?

Device tree guidelines mandate that non-standard, device-specific properties
must include a vendor prefix to avoid namespace collisions. These should
probably be oneplus,touchpad-xy-max and oneplus,touchpad-xy-resolution.

Also, because they do not end in a standard recognized suffix, dt-schema
validation cannot infer their types. Should they include an explicit type
reference to /schemas/types.yaml#/definitions/uint32-array to prevent
dt_binding_check from emitting a missing type definition warning?

> +
> +required:
> +  - compatible
> +  - power-gpios
> +  - tx-enable-gpios
> +  - wake-gpios
> +
> +additionalProperties: false

[Severity: Medium]
Will this block properties inherited from the serial-peripheral-props.yaml
reference?

Since the schema references the serial properties via an allOf block earlie=
r,
using additionalProperties: false strictly limits allowed properties to only
those defined in this file's properties block.

Should this be changed to unevaluatedProperties: false to allow standard
serial properties like max-speed?

> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    serial {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;

[Severity: Low]
Are these address size properties necessary for this example?

The child keyboard node does not contain a reg property, nor does its name
include a unit-address. Declaring address cells without any addressable
children triggers an avoid_unnecessary_addr_size warning from dtc when
evaluating the example.

> +
> +        keyboard {
> +            compatible =3D "oneplus,pogo-keyboard";
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009121143.5504=
98-1-2024312277@stu.hit.edu.cn?part=3D1
