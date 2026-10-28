Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793210316;
	b=r4XqMFScPwy6WuSlC7hbfSZnC8BKq1Xpze0i2TKMAOwtMSQwVq1iFbnyiRi0Qoc9Sm6B
	 1gHGatexLLo/DgamH+fAF8hpfGnacLAb3wdS0PcYn3whRMlZvFZ5DD2JLHPjTInBZNYsq
	 reWCyhhbNUzOo9q/YRspc9fdnrTi391W2f9MlYyC79pitkeqfliWAa90JXPdM5Pd0aOAW
	 MCBnSC3sVlGaVnS8IXPMM8Piuz43qb4nZNiRPgov/Ihd+pl78u2AKbiAdQGUtDtZwDnrK
	 0qwJAkya/4/tq3lLpN/hnN7ztYiAC3JVRpl9VACePMKln6Hc8Ce3joa0vh+kTb05cYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793210316;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=aTi7FDhFISZO7kWpmimT2aO+ec4D8z/GbW3BUuiE/d0=;
	b=g6E5G78AX0bmnINznLOxJcXoLaPUAXksvwaWDIESgQNhAZ9AHpx3UWbqsW/pwE4TdEWX
	 3Q+IZ6D3219NkvQMfQVe4RQPuTfH253HnurzqUqXLIXqe6y6Hnybal644HtaFV1TUctYi
	 UiTstS5iUFAJ6h702nF5McJ+959C2ZwWiRiHQEfQe1+Ovq9SW5QprmMZ7uxNYaQUsrsk/
	 FUOwUG93c5Nh+JDJbR3B94euCfInWSym8dzkwfuNMyJ1i57kz6w+VHevs7X6J7Ou32m9P
	 pUCUrw2Qd5yFlvV2txssH3Ig+ANhVF7l8ruUQgYQ/BlWS6i6Kxsnm0xP82q4BdtN20A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PKAxA7FP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE70606A321;
	Wed, 28 Oct 2026 17:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PKAxA7FP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF3BE1F01828;
	Wed, 28 Oct 2026 17:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793210315;
	bh=aTi7FDhFISZO7kWpmimT2aO+ec4D8z/GbW3BUuiE/d0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PKAxA7FP/bS9zHJa7Nuo3TsAvflHkO0kcRDdTUa08+ni+bekxF2nqRW42OAE1ui/l
	 uGmJ6p5+tGIrVNkDjg4AKy165bpFXEg+nRW249Ay3w1e6NmS3wHqoemXmAFbFco2jH
	 KhAwFYUa7yhuGAPA+wBQmSfUmkCOCmyInDEL7vaU4dEtaFsJfezypQ79JJck/paM0c
	 H9t46lptF3NUA3ZTsaMjo7kvshK3oX6KcYcjA5sLFt4LHKRgVKUSRSfgG06MMF5+Pa
	 XX/IecWnMpshy3zMs1Z79uMFye+c+eeXb5VZnT4ceN6ug4KZeB20hSbXIqUoBIK2Zw
	 18GfyGUuukSZw==
Date: Wed, 28 Oct 2026 17:58:30 +0000
From: Conor Dooley <conor@kernel.org>
To: Jizhou Tong <fqwqf@fqwqf.xyz>
Cc: Jingyuan Liang <jingyliang@chromium.org>, jikos@kernel.org,
	bentiss@kernel.org, dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	daleyo@gmail.com, broonie@kernel.org, u.kleine-koenig@baylibre.com,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [RFC PATCH v2 4/6] dt-bindings: input: describe the Romulus13
 QSPI touchpad
Message-ID: <20261028-punctured-flagpole-c7ec4cfc4609@spud>
References: <010601a1334094a9-1f793e14-c414-4780-98ff-f5acdac353a2-000000@ap-northeast-1.amazonses.com>
 <010601a1334e2298-73816c42-ca83-40fe-9c7a-e771c466a4e6-000000@ap-northeast-1.amazonses.com>
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
	protocol="application/pgp-signature"; boundary="cgu1zTNp/hBa/EJJ"
Content-Disposition: inline
In-Reply-To: <010601a1334e2298-73816c42-ca83-40fe-9c7a-e771c466a4e6-000000@ap-northeast-1.amazonses.com>

--cgu1zTNp/hBa/EJJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 03:28:41AM +0000, Jizhou Tong wrote:
> Describe the fixed-address HID-over-SPI touchpad on Surface Laptop 7
> 13.8-inch, with quad address/data transfers, an active-low reset and a 5
> V supply.
>=20
> Signed-off-by: Jizhou Tong <fqwqf@fqwqf.xyz>

With the changes to the hid-over-spi series that this is based on, can
this device now go into hid-over-spi.yaml?

> ---
>  .../input/microsoft,romulus13-touchpad.yaml   | 86 +++++++++++++++++++
>  1 file changed, 86 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/microsoft,rom=
ulus13-touchpad.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/input/microsoft,romulus13-=
touchpad.yaml b/Documentation/devicetree/bindings/input/microsoft,romulus13=
-touchpad.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..88e4664c56e7fb1c3f9f5949a=
3ded2f9d7070604
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/microsoft,romulus13-touchpa=
d.yaml
> @@ -0,0 +1,86 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/microsoft,romulus13-touchpad.ya=
ml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microsoft Surface Laptop 7 13.8-inch QSPI touchpad
> +
> +maintainers:
> +  - Jizhou Tong <fqwqf@fqwqf.xyz>
> +
> +description:
> +  The touchpad on the 13.8-inch Surface Laptop 7 uses the HID SPI v3
> +  protocol over a quad SPI connection. Its supply and board reset states
> +  must be controlled during initialization and recovery.
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    const: microsoft,romulus13-touchpad
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: Touchpad 5 V supply.
> +
> +  spi-max-frequency:
> +    maximum: 20000000
> +
> +  spi-rx-bus-width:
> +    items:
> +      - const: 4
> +
> +  spi-tx-bus-width:
> +    items:
> +      - const: 4
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description: Active-low touchpad reset.
> +

> +  pinctrl-0: true
> +
> +  pinctrl-names:
> +    items:
> +      - const: default

Are these even something that needs to be added? I am pretty sure pinctrl
stuff is allowed in all nodes without being cited explicitly.

Looks okay to me other than these two things.

pw-bot: changes-requested

Thanks,
Conor.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - vdd-supply
> +  - spi-rx-bus-width
> +  - spi-tx-bus-width
> +  - reset-gpios
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        touchpad@0 {
> +            compatible =3D "microsoft,romulus13-touchpad";
> +            reg =3D <0>;
> +            spi-max-frequency =3D <20000000>;
> +            spi-rx-bus-width =3D <4>;
> +            spi-tx-bus-width =3D <4>;
> +            interrupts-extended =3D <&tlmm 3 IRQ_TYPE_LEVEL_LOW>;
> +            vdd-supply =3D <&vreg_ts_5p0>;
> +            reset-gpios =3D <&tlmm 120 GPIO_ACTIVE_LOW>;
> +            pinctrl-0 =3D <&touchpad_reset>;
> +            pinctrl-names =3D "default";
> +        };
> +    };
> --=20
> 2.53.0
>=20

--cgu1zTNp/hBa/EJJ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCauI3xgAKCRB4tDGHoIJi
0htEAQCI6Uy3blZKIhslyzl+1gFTR66W5gqqsXBEaG9nFxFuyQD/a4SHdavDd6H7
W/++p34eqViyZ+CmO4dV2R3tbHOxOgs=
=cS+N
-----END PGP SIGNATURE-----

--cgu1zTNp/hBa/EJJ--
