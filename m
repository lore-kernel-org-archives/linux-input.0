Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA2B4D5996;
	Fri,  9 Oct 2026 12:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791548892; cv=none; b=kPzUr9UFKZ5/ThgPf36hbVFLv2CmT6kxg5b1kmDMUUlJ+7Y8gvJrxl2QKJUOfqIkj+Cyp2QAZsuHEFUzkFQPg5vKWQrmUkJwONUOMi9UWMwO3Me5k6zRiNeVVnRpt+ombkJQYEtwLUJpS6fqhYeHNFvIw8B+3+wwBnOQaSRUdoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791548892; c=relaxed/simple;
	bh=hjwXXpOMExko6xXBKlvUnfSuhZMmUeuuhDqWLxlAdOI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=TViKzEy4BdP82uc4R+CcBbXdsUhbtjwkbsDCb6xjzpmcB9c5ZqpTIlo2D41ysD2rCgjZf2ACrZEtxCJBQ+0HUmDT0MvafoF3uxOrY9VEzXSCSvR7sz6Oa3Vr5E4HuU/FxVe4w8uFklQLl10iDcphhH53QEKlk/Gpq8/kUJzx+nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XU/YvpHR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XU/YvpHR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8428A1F000FF;
	Fri,  9 Oct 2026 12:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791548882;
	bh=PaW1OvZ84qgdvcvBA9H+RqK4pWOYnRKR2F3s9zTOidg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XU/YvpHRI4mpjfS792njIHF5Vs5pz83bCjew9yBMr1at/KtGNPd+0AkoMFstGNq0Y
	 g2qPA1qxMsqtt0eSD8B1CWnlPHOLRuet8VIHmmvyZS8iz54OAKaEUfEw2OjEbTv5lq
	 rJORag/ORZCOYJj1u6AU/WeOvRG2nKT0Cu5zy0WrmWpiKoYv5LH15vvPYtNpA30Vdr
	 niqgLmeI5fyupXHpFQkZXasDYScayLEVre1EafQTRaC47gR8nt5ZdmCP2waQNkpMJ1
	 wp6v/uYWQ/qix1SrVz1Orh2CIwCujlWqPfXzvej3nfL5p5LudFCxZiJ27vLk+iGZJE
	 WEIbv1D7DHWhA==
Message-ID: <sashiko-outbox-165539@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: input: add OnePlus pogo-pin keyboard
 binding
Reply-To: sashiko-reviews@lists.linux.dev
To: wyibo6109@gmail.com
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20261009122046.551915-2-wyibo6109@gmail.com>
References: <20261009122046.551915-1-wyibo6109@gmail.com>
 <20261009122046.551915-2-wyibo6109@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 12:28:01 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Low] dt-bindings: missing vendor prefix and reuse of standard touchscree=
n properties
- [Low] dt-bindings: custom array properties missing type $ref
- [Low] dt-bindings: additionalProperties: false incorrectly used with allO=
f $ref
- [Low] dt-bindings: unnecessary #address-cells and #size-cells in example
- [Low] MAINTAINERS: alphabetical ordering violation
--

commit ef349c1a2a4dec7c790c73c2c1a20cb2d95556c8
Author: Yibo Wang <wyibo6109@gmail.com>

dt-bindings: input: add OnePlus pogo-pin keyboard binding

Binding for the Tinno keyboard MCU used by the OnePlus Pad 3 Pro /
Pad 4 and OPPO Pad 5 Pro smart keyboards, attached to a tablet UART.

> diff --git a/Documentation/devicetree/bindings/input/oneplus,pogo-keyboar=
d.yaml b/Documentation/devicetree/bindings/input/oneplus,pogo-keyboard.yaml
> new file mode 100644
> index 0000000000000..3086a2c4e2895
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/oneplus,pogo-keyboard.yaml
> @@ -0,0 +1,81 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)

[ ... ]

> +allOf:
> +  - $ref: /schemas/serial/serial-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    const: oneplus,pogo-keyboard

[ ... ]

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

[Severity: Low]
Does this bypass the standard touchscreen properties? The binding could reu=
se
properties from touchscreen.yaml, such as touchscreen-size-x,
touchscreen-size-y, touchscreen-x-mm, and touchscreen-y-mm, rather than
introducing custom variations.=20

If custom properties are strictly necessary here, should they include a
vendor prefix like oneplus,touchpad-xy-max?

Additionally, since these custom properties define an items array, do they
also need an explicit type reference (such as
$ref: /schemas/types.yaml#/definitions/uint32-array)? Without a standard
suffix, device tree schema tools might fail meta-schema validation because
they cannot automatically infer the type.

> +
> +required:
> +  - compatible
> +  - power-gpios
> +  - tx-enable-gpios
> +  - wake-gpios
> +
> +additionalProperties: false

[Severity: Low]
Does this strict constraint incorrectly override the referenced schema?

Because the schema imports serial-peripheral-props.yaml via the allOf block,
JSON schema evaluation will not account for those imported properties under
additionalProperties. Does this cause valid serial properties (like
max-speed) to be incorrectly rejected?

Could this be resolved by using unevaluatedProperties: false instead?

> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    serial {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        keyboard {

[Severity: Low]
Since the child keyboard node omits a reg property because it is a simple
point-to-point UART peripheral, are #address-cells and #size-cells needed on
the parent node?=20

Could this trigger the avoid_unnecessary_addr_size dtc warning during make
dt_binding_check?

> +            compatible =3D "oneplus,pogo-keyboard";
> +            power-gpios =3D <&pmic_gpios 12 GPIO_ACTIVE_HIGH>;
> +            tx-enable-gpios =3D <&pmic2_gpios 6 GPIO_ACTIVE_HIGH>;
> +            wake-gpios =3D <&tlmm 151 GPIO_ACTIVE_LOW>;
> +            touchpad-xy-max =3D <2560 1440>;
> +            touchpad-xy-resolution =3D <24 25>;
> +        };
> +    };
> +...

> diff --git a/MAINTAINERS b/MAINTAINERS
> index b8c4e1080af94..d0adba45c8f0b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20147,6 +20147,13 @@ S:	Maintained
>  T:	git git://linuxtv.org/media.git
>  F:	drivers/media/i2c/ov9734.c
> =20
> +ONEPLUS POGO-PIN KEYBOARD DRIVER
> +M:	Yibo Wang <wyibo6109@gmail.com>
> +L:	linux-input@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/input/oneplus,pogo-keyboard.yaml
> +F:	drivers/input/keyboard/oneplus-pogo-kbd.c
> +
>  ONBOARD USB HUB DRIVER

[Severity: Low]
Should ONEPLUS POGO-PIN KEYBOARD DRIVER be placed after ONBOARD USB HUB
DRIVER?=20

Alphabetically, ONEPLUS comes after ONBOARD, so inserting it here appears to
break the alphabetical ordering requested by the MAINTAINERS file.

>  M:	Matthias Kaehlcke <mka@chromium.org>
>  L:	linux-usb@vger.kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009122046.5519=
15-1-wyibo6109@gmail.com?part=3D1
