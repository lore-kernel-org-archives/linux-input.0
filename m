Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794335783;
	b=4QHq0WC1PUbj+UoiLYPd+83TkLd2D6rC+lkuYmR0wL3Un/t85YD/wPHDU19eKyRnZ/o7
	 5embu99AX5ZctVeL+/bxG0WWFYnU5nlL9infCnYqumQCgJXqM5l1rFmWFAUBS1lpqCJe9
	 kRtFgZd0h7MFqlgSqDpsaYfuWum6vpt98HQjhUQ5PrT1jRAbg3bXTN7ha1+n9pTccngyx
	 OkZLVOEL1wvdJaCnL7XETVJ2s4nyd2eo+AswRkC7Wy2qtyXhTx2V0Gn14+cgHea3auOAQ
	 xfOz6OE+7BD3Ayip/Iz7HqWgBIA3WExDCe1lDBssnRrb5VVye1vI9Bg9u+v8ZEs3rNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794335783;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=o/9JOxpI2/7CQXqdlvWs/lcxk0emk3kCWaaIB+hKwgY=;
	b=A+7CdYM+DKROLpIXwTbhTp+8c9dMTIM+t8rhZ8F44f6g2K5nFCimQI8XrMEekqdb3BPk
	 SiyzsFLKgyy+FomozC9A4VUFPK8rVkvYTxQ3GSidg0rDKrh1KLg0TJYfjgFtp4ezdv09R
	 4QD+hwI10i885QR9/3+kXOZr/UXq1Xx/cJUK7R+BEuOLde8jYCOOAR/vrvQaNtBJbVlSU
	 r2tAvK0sV+2HIIZqo/DupT7KGuLKe9fJloeyeuCifjF0PtNnUPgaMsUM07c68ff4HMERN
	 pCdzE6n+XueFDnmdy/g6CrFVic2OQlW+XUDHGUPnutITcMbtX+DlYTbXJfwctmbmYUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="RwJ5nb/u";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C083606A32E;
	Tue, 10 Nov 2026 18:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RwJ5nb/u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DED9E1F008A3;
	Tue, 10 Nov 2026 18:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794335783;
	bh=o/9JOxpI2/7CQXqdlvWs/lcxk0emk3kCWaaIB+hKwgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RwJ5nb/uG5KNkgG2SOgAhOM5Cvz+Z40dsqL0z7aySCK4t1I8/oq9I3B1RPqCKZOU6
	 cMMPUmvqF94sGROh03MSpfPaDpBnq04YIcBGljeCiD/1rrPB1rh5WlEyh45GVVO4cq
	 usn8DX7xSRI4/RkFgS4WTXBbYr62/dfTdSIxO64s2Z9K8r2/R0TUzy2XdgvPenLXGr
	 eVkBb8ybN/luKqoz0dL9cSAPVmL2xszKLpaqoxvcbpxmdierlQrXrpobm6H66IbOPd
	 LlJBc6HWf8y5hOn/6IzKeL8EIX0+zV7FaJwFY81KP81TL6CsEOa4Ps6C01NiQijS10
	 CiOQF1FVa5P9Q==
Date: Tue, 10 Nov 2026 18:36:18 +0000
From: Conor Dooley <conor@kernel.org>
To: Feng-Yi Hsueh <fyhsueh4linux@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: input: Add Nuvoton MA35D1 keypad
 controller
Message-ID: <20261110-dingy-unaligned-377ac75bb5bc@spud>
References: <20261110111419.89535-1-fyhsueh4linux@gmail.com>
 <20261110111419.89535-2-fyhsueh4linux@gmail.com>
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
	protocol="application/pgp-signature"; boundary="Qv4BxQDfbEUAvEjd"
Content-Disposition: inline
In-Reply-To: <20261110111419.89535-2-fyhsueh4linux@gmail.com>

--Qv4BxQDfbEUAvEjd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 07:14:18PM +0800, Feng-Yi Hsueh wrote:
> Document the Nuvoton MA35D1 hardware matrix keypad controller.
>=20
> The controller supports up to eight rows and eight columns
> and generates interrupts for key press and release events.
>=20
> Signed-off-by: Feng-Yi Hsueh <fyhsueh4linux@gmail.com>

Most of what the bot says seems valid to implement,
pw-bot: changes-requested

Thanks,
Conor.

> ---
>  .../bindings/input/nuvoton,ma35d1-keypad.yaml | 73 +++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/nuvoton,ma35d=
1-keypad.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/input/nuvoton,ma35d1-keypa=
d.yaml b/Documentation/devicetree/bindings/input/nuvoton,ma35d1-keypad.yaml
> new file mode 100644
> index 000000000000..be678d0b38b9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/nuvoton,ma35d1-keypad.yaml
> @@ -0,0 +1,73 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/nuvoton,ma35d1-keypad.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton MA35D1 Matrix Keypad Controller
> +
> +maintainers:
> +  - Feng-Yi Hsueh <fyhsueh4linux@gmail.com>
> +
> +description: |
> +  The Nuvoton MA35D1 keypad controller scans a matrix of up to eight rows
> +  and eight columns and reports key press and release interrupts.
> +
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
> --=20
> 2.43.0
>=20

--Qv4BxQDfbEUAvEjd
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCavNkIgAKCRB4tDGHoIJi
0hSzAQCKMBN2QbVi/h1KHYGGkzgqlIPuWmK2ry8I+T84uCGD1QD+J47KIlwrgiRj
27vxsEA9CS9u2nAtNbd+piMnxqSdUAg=
=vTqZ
-----END PGP SIGNATURE-----

--Qv4BxQDfbEUAvEjd--
