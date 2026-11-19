Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795110670;
	b=Js07HppaHz2kR4kiMepvq09ImmR4Kxxy+Mopyc8hXPMX4FvaKaZEN0Vdx/6wq6IpVGKN
	 oPCSAxoR1mngcjpKZtYvx6g/6NogPQDWkVOrSXGZN0evVKclTBtIm9SOxQkJ2V0WGrqR4
	 clRFVbSh3qhaOJUdFeX0Gbm+jMzScCo1a05xXmaCliKJHJ4+JtbZwf5ZY+n7A4v+9bAw2
	 O0AmUuDidsuzrUzAhgFlVZZkd6YTaWogn9TwLq+kUCQaY5oaUoYHUDxVm0ZSeDg59xRoE
	 LuUsgFOtZvLugT/Fl8zFaH/DAVvY8tVhYWIX7JBHpYOJFLJEa4K+5BDDgDalhBAj8sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795110670;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=91cixVM9xkYFwo/rM+qZds/LEL2+Y7pV6WbTYF8SOsc=;
	b=1LeI+3zM60xiNf00P7dfdRSKKrfVMVpaCZ8Ula9uvrmwzj6trBXlJAjFNJ3aDVavPc9o
	 rilFXCV0N02ve1Yu1zzhdSQOFcJKGwVIr/RzPp+KF/gkbNcGmSoMVKq8SSImIjsbhbiHH
	 9rrp3h4dYkHXN7NyDViUsIr2yjA3O0HCUmFGPi2c7vuctmnj/OnuFFaBmjYo2gHuVSvUB
	 BUMUyOt60+hFdcDB/J91DY4XRvaqoAbUOHB8W5Z72i0fKmrfy6dDy+Q8Kx3JjssPU1L19
	 twpeOYe2//a6L0deme/JUGZ+ebIuYU3NkhrIwEekitr9pN2PkANFmZ8lsTqpY3mC8Cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gOXr4FIX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C0F606A320;
	Thu, 19 Nov 2026 17:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gOXr4FIX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A5B1F000CA;
	Thu, 19 Nov 2026 17:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795110670;
	bh=91cixVM9xkYFwo/rM+qZds/LEL2+Y7pV6WbTYF8SOsc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gOXr4FIX+yvyM0UlExwGlCV50m2VGD8kM4tJPrAugMHZwWfyy1u6l0UvOoW/TvN37
	 dS2BowK0I22uP/crYXPhVI0AAARfSc4vbmYGagFJgF8nRTR5jTOaBXenOey2WY5v9H
	 TL2UZ7JQqnyOePlZnAFljZDTihnnS1YKznFxsz5Mufb+uN6CTPJYUF0NnvNKZ0IGs1
	 BqBPt3dar7IPC4vwLU8MUU8PRrsTpIU3MSeTVFiFibrWmXZQs/Cya7i3oo+matFEfh
	 oLO4FgLUh6VYOai/dyOslD3cYAdAg4Y0v0/hpznBkgikf8PdilzwWhobL6SkkOTmXC
	 9En+XwPh4vqVg==
Date: Thu, 19 Nov 2026 17:51:07 +0000
From: Conor Dooley <conor@kernel.org>
To: Hefei <3066883572@qq.com>
Cc: dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] dt-bindings: backlight: add VIEWE I2C backlight
 binding
Message-ID: <20261119-gravity-unlighted-54fc29aa3dd8@spud>
References: <tencent_093E92ACAABFAB09F39EC07F4350A5C7BD09@qq.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="B+xvd9frcwCJyrJG"
Content-Disposition: inline
In-Reply-To: <tencent_093E92ACAABFAB09F39EC07F4350A5C7BD09@qq.com>

--B+xvd9frcwCJyrJG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 10:48:05AM +0800, Hefei wrote:
> Add the binding for the VIEWE panel backlight MCU on I2C.
>=20
> Signed-off-by: Hefei <3066883572@qq.com>
> ---
>  .../leds/backlight/viewe,i2c-backlight.yaml   | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/backlight/view=
e,i2c-backlight.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/leds/backlight/viewe,i2c-b=
acklight.yaml b/Documentation/devicetree/bindings/leds/backlight/viewe,i2c-=
backlight.yaml
> new file mode 100644
> index 0000000..ab60c2c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/backlight/viewe,i2c-backligh=
t.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/backlight/viewe,i2c-backlight.ya=
ml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: VIEWE I2C panel backlight
> +
> +maintainers:
> +  - Hefei <3066883572@qq.com>
> +
> +description: |
> +  Simple I2C backlight used on VIEWE DSI modules. Default protocol is de=
vice
> +  address 0x45, register 0x86, brightness 0..255.
> +
> +allOf:
> +  - $ref: common.yaml#
> +
> +properties:
> +  compatible:
> +    const: viewe,i2c-backlight

This seems far too generic.
Do we not have access to a part number or something to better identify
this device?

> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        backlight@45 {
> +            compatible =3D "viewe,i2c-backlight";
> +            reg =3D <0x45>;
> +            default-brightness =3D <200>;
> +        };
> +    };
> +...
> --=20
> 2.55.0.windows.5
>=20
>=20

--B+xvd9frcwCJyrJG
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCav83CwAKCRB4tDGHoIJi
0psXAP99GO4RrsJ86JAlIZszQIbzJlsts5XXMquezkiU8jY4PQEAjGfcqVeXvoN9
kz5bj2BWP15kOH9+6UryflGXNgsQFwI=
=QNSA
-----END PGP SIGNATURE-----

--B+xvd9frcwCJyrJG--
