Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8084DBD70;
	Mon, 12 Oct 2026 19:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791832581; cv=none; b=R1w3fCYyR9xjcR7S/8u+ERqCXAxh9z4zoqsv1mpj1U8Unn6HA8KfzE4newzEhvNUPCDhvY1M1fP5y3R3tgayQ/FpSgl90ELoof3+VZ82E0rwt8WDvUxDauVpcWtsPgOuZlesG2XPCtURRgPz0RCOG7HegH9hEEKnUcKzvL+sdOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791832581; c=relaxed/simple;
	bh=jfm7V/lN2juYXLscNqZLMKlFPte1DBkKgWz0rkvstq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aqaq45v61Y/0zvyoTR+qygJB0dTj4s2lz/lBr+G1hq/ZjI1NeinLeTIs9Xgvfd4BJNEIo425f86Htu9zKTW0y4qz5wveJLorgrVXTKREo2NU6M7Jnw9JptDDqU+//DzDRmM7V6Civ/+2dX7U0MeAjbo5OyTJ4V2MrO/yCC8rDhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHhqjUXk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHhqjUXk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 283BC1F0089B;
	Mon, 12 Oct 2026 19:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791832575;
	bh=nJS4Pop097HfYJvZyN52MddIk+X13UjE+RZ+4JN0C+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kHhqjUXkPc/hchWSgCP6jgo1i6Qu4/0x7uJq6NGgJOT6xTNGCceeTR9jemUhb+Vu7
	 NCrylSUtYMzunfLRMUHCVtrJ+BC0PHlP7TungRgwNuGHVLENOkrjYkJY9wSDP9zveX
	 n6iOXdFaah2L1GhMMssBznT5oyUuc5zJQWeAYm/ECwWQ9oncTMw2gyYrEClZKq6pl2
	 a4fnetCasOH01pJWm2FREAFNzmxFglybMSXB52TLnS6g1g+0V8YjN0C2M12ntRMaO7
	 swfAa01j/Pi36ID5gTH380udtGteVprtrtcthNAtAhXP4m03aPKlMi6lnZ2j10UMJT
	 xkvqLt4MJfTLg==
Date: Mon, 12 Oct 2026 20:16:10 +0100
From: Conor Dooley <conor@kernel.org>
To: =?utf-8?B?TWljaGHFgiBLb3BlxIc=?= <michal@nozomi.space>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	jikos@kernel.org, bentiss@kernel.org, dmitry.torokhov@gmail.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	allencl_lin@hotmail.com, tylor_yang@himax.corp-partner.google.com,
	felix@kaechele.ca, dianders@chromium.org
Subject: Re: [PATCH v6 1/3] dt-bindings: input: Add Himax HX83102J touchscreen
Message-ID: <20261012-material-disclose-4f0f8af60ffe@spud>
References: <20261011181633.1778969-1-michal@nozomi.space>
 <20261011181633.1778969-2-michal@nozomi.space>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/CLthKRV7cJy8A22"
Content-Disposition: inline
In-Reply-To: <20261011181633.1778969-2-michal@nozomi.space>

--/CLthKRV7cJy8A22
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 11, 2026 at 08:16:31PM +0200, Micha=C5=82 Kope=C4=87 wrote:
> Add the binding for the touch function of the Himax HX83102J, a touch
> and display driver integrated (TDDI) controller. The touch function is
> connected over SPI and shares the analog supplies and the reset of the
> display function, so it is powered and reset together with the panel
> and has to follow it.
>=20
> Co-developed-by: Allen Lin <allencl_lin@hotmail.com>
> Signed-off-by: Allen Lin <allencl_lin@hotmail.com>
> Signed-off-by: Micha=C5=82 Kope=C4=87 <michal@nozomi.space>
> ---
>  .../input/touchscreen/himax,hx83102j.yaml     | 98 +++++++++++++++++++
>  MAINTAINERS                                   |  6 ++
>  2 files changed, 104 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/h=
imax,hx83102j.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/himax,hx=
83102j.yaml b/Documentation/devicetree/bindings/input/touchscreen/himax,hx8=
3102j.yaml
> new file mode 100644
> index 0000000000000..f0aca7a6662c9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/himax,hx83102j.=
yaml
> @@ -0,0 +1,98 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/touchscreen/himax,hx83102j.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Himax hx83102j touchscreen
> +
> +maintainers:
> +  - Micha=C5=82 Kope=C4=87 <michal@nozomi.space>
> +
> +description:
> +  The Himax HX83102J is a touch and display driver integrated (TDDI)
> +  controller. Its touch function is connected over SPI and reports HID
> +  packets. The display and touch functions share the analog supplies and
> +  the display reset, so the touch function is powered and reset together
> +  with the panel it is part of.
> +
> +allOf:
> +  - $ref: /schemas/input/touchscreen/touchscreen.yaml#
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    const: himax,hx83102j
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description:
> +      Reset of the touch function. Unlike display-reset-gpios, it only
> +      resets the touch MCU and leaves the display function running, so t=
he
> +      touch function can be reset without disturbing the panel.
> +
> +  vccd-supply:
> +    description: Digital I/O supply of the touch function.
> +
> +  vsn-supply:
> +    description: Negative analog supply, shared with the display functio=
n.
> +
> +  vsp-supply:
> +    description: Positive analog supply, shared with the display functio=
n.
> +
> +  display-reset-gpios:
> +    maxItems: 1
> +    description:
> +      Reset of the display function, usually driven by the panel. Assert=
ing
> +      it also resets the touch function.
> +
> +  spi-cpha: true
> +
> +  spi-cpol: true

Just to be sure, these are optional on this device and it's not always
in this mode?

> +
> +  firmware-name:
> +    description: Specify the file name for firmware loading.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - reset-gpios
> +  - panel
> +  - vccd-supply
> +  - vsn-supply
> +  - vsp-supply
> +  - display-reset-gpios
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    spi {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +      ap_ts: touchscreen@0 {

Drop the label if you respin btw, since it is unused. Binding is mostly
fine looking to me.

> +        compatible =3D "himax,hx83102j";
> +        reg =3D <0>;
> +        pinctrl-names =3D "default";
> +        pinctrl-0 =3D <&touch_int0 &touch_reset>;
> +        reset-gpios =3D <&gpio1 8 GPIO_ACTIVE_LOW>;
> +        spi-cpha;
> +        spi-cpol;
> +        interrupt-parent =3D <&gpio1>;
> +        interrupts =3D <7 IRQ_TYPE_LEVEL_LOW>;
> +        panel =3D <&panel>;
> +        vccd-supply =3D <&regulator>;
> +        vsn-supply =3D <&regulator>;
> +        vsp-supply =3D <&regulator>;
> +        display-reset-gpios =3D <&gpio1 9 GPIO_ACTIVE_LOW>;
> +      };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 72294ddfa5b75..e209f0d44fa73 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11729,6 +11729,12 @@ W:	http://www.highpoint-tech.com
>  F:	Documentation/scsi/hptiop.rst
>  F:	drivers/scsi/hptiop.c
> =20
> +HIMAX HID TOUCHSCREEN

Sounds overly generic, since the hx83112B is probably also a touchscreen
HID device?

Thanks,
Conor.

pw-bot: changes-requested

> +M:	Micha=C5=82 Kope=C4=87 <michal@nozomi.space>
> +L:	linux-input@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/input/touchscreen/himax,hx83102j.ya=
ml
> +
>  HIMAX HX83112B TOUCHSCREEN SUPPORT
>  M:	Job Noorman <job@noorman.info>
>  L:	linux-input@vger.kernel.org
> --=20
> 2.56.0
>=20

--/CLthKRV7cJy8A22
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCas0x+gAKCRB4tDGHoIJi
0ucEAQCqGmUP3Sw5IhmjbZ6Zc9QHpdIzvn83kyYwYYm5jhim1gEAnIrDddbvguy7
da3uqtmF97eGpMyekSYrksUSQSLvSQE=
=81pe
-----END PGP SIGNATURE-----

--/CLthKRV7cJy8A22--
