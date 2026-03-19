Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C823C30E0F2;
	Thu, 19 Mar 2026 17:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773940203; cv=none; b=IS4O8eV3TebAvz91IfgHBnLUWUinvUwvNhEmSC8zpM3gvkukTLVaxjLbnNG2zXf7GmvkmSg/rRdoQsOKL8cCxaEOS26IqIEFssApFnNsWuRnpmdDPccCNmrmNQ53neJ+Lusq3BLX2QBhmWe1/VPFoReIizTkFjr3HxIvA42IWrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773940203; c=relaxed/simple;
	bh=ZWZOUB5qHhf+MSOL+JHwQZDSSAiLl4lmG0hYikT7Ib0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WhT2HKl6ij69XmQmAH6onow60V4rr+XUDkEF6p000MhfwUObw9/G1s1bIFrfiiqLer5dZdihNBz43n74ub/S9U4eMtLgEenebklKlHmevkFa3GXIUVbCJgq5OJS0Q160MFuh9XyvGod95CqVDuXj6wqfUQJHIaOLl42NWbeZwaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTfgig03; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTfgig03"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E6E1C19425;
	Thu, 19 Mar 2026 17:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773940203;
	bh=ZWZOUB5qHhf+MSOL+JHwQZDSSAiLl4lmG0hYikT7Ib0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VTfgig03pIG2YT4ZMShFatlL28g0InjshTPbK0BPyf/otVGT5mgH974x+qvUxzRmv
	 jp50GqEiIgi6XHrT0XicM57gk4SKGNUcmTA/Iy5O6ReaKN9Ic0Ph/BtMTIYEiasw0G
	 tFtAhypYXj9blEAp4cTxRtZl2M2ZWW4/t+2DLCe4PtUh0SFXmQdYRmfnX1fK7OQZX6
	 KJ5J1ypJg+M9HwGEqkABLTkN130r82Fye1mPqLvBHIAyZRLxxbVXjnqxdUX2lVj+Ct
	 Tu5pUFHffSDLFdGiYCg4w8LLmTWnSnodGVFyZDot93TCejTIS99Vi2wLZCH4RFNeIx
	 vs+Ji7uViZVpw==
Date: Thu, 19 Mar 2026 17:09:59 +0000
From: Conor Dooley <conor@kernel.org>
To: Hendrik Noack <hendrik-noack@gmx.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ferass El Hafidi <funderscore@postmarketos.org>,
	linux-input@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: Input: Add Wacom W9000-series
 penabled touchscreens
Message-ID: <20260319-swampland-unearned-aa64771c0141@spud>
References: <20260319095303.19927-1-hendrik-noack@gmx.de>
 <20260319095303.19927-2-hendrik-noack@gmx.de>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="I4IDUA0hGiFU8QE0"
Content-Disposition: inline
In-Reply-To: <20260319095303.19927-2-hendrik-noack@gmx.de>


--I4IDUA0hGiFU8QE0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 10:53:02AM +0100, Hendrik Noack wrote:
> Add bindings for Wacom W9002 and two Wacom W9007 variants which can be
> found in tablets.
>=20
> Co-developed-by: Ferass El Hafidi <funderscore@postmarketos.org>
> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
> Signed-off-by: Hendrik Noack <hendrik-noack@gmx.de>
> ---
>  .../input/touchscreen/wacom,w9007a-lt03.yaml  | 73 +++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/w=
acom,w9007a-lt03.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/wacom,w9=
007a-lt03.yaml b/Documentation/devicetree/bindings/input/touchscreen/wacom,=
w9007a-lt03.yaml
> new file mode 100644
> index 000000000000..6d1da6a435d3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/wacom,w9007a-lt=
03.yaml
> @@ -0,0 +1,73 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/touchscreen/wacom,w9007a-lt03.y=
aml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Wacom W9000-series penabled I2C touchscreen
> +
> +maintainers:
> +  - Hendrik Noack <hendrik-noack@gmx.de>
> +
> +description: |
> +  The W9000-series are penabled touchscreen controllers by Wacom.
> +
> +  The firmware of controllers in different devices may differ. This can =
also
> +  affect the controller's behavior.
> +
> +allOf:
> +  - $ref: touchscreen.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - wacom,w9002
> +      - wacom,w9007a-lt03
> +      - wacom,w9007a-v1

Please provide information in your commit message as to why these
devices are not compatible with one another.
With that,
Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: changes-requested

Cheers,
Conor.


> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  vdd-supply: true
> +
> +  flash-mode-gpios:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        digitizer@56 {
> +            compatible =3D "wacom,w9007a-lt03";
> +            reg =3D <0x56>;
> +            interrupt-parent =3D <&gpd1>;
> +            interrupts =3D <1 IRQ_TYPE_EDGE_RISING>;
> +
> +            vdd-supply =3D <&stylus_reg>;
> +
> +            flash-mode-gpios =3D <&gpd1 3 GPIO_ACTIVE_HIGH>;
> +            reset-gpios =3D <&gpx0 1 GPIO_ACTIVE_LOW>;
> +
> +            touchscreen-x-mm =3D <216>;
> +            touchscreen-y-mm =3D <135>;
> +            touchscreen-inverted-x;
> +        };
> +    };
> --=20
> 2.43.0
>=20

--I4IDUA0hGiFU8QE0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCabwt5wAKCRB4tDGHoIJi
0nFGAQDsaY34PFG6oB2Drc+0zzerFjYEJyJXVQNcDSUuIhCSsQEAncq2f9kz6aPj
WXiOy4dlKnZAAisGlgx3S3sbKEFyNwM=
=lbPf
-----END PGP SIGNATURE-----

--I4IDUA0hGiFU8QE0--
