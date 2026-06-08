Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE760367283;
	Mon,  8 Jun 2026 17:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780940676; cv=none; b=XUmeYPIG4/nb3BHXv56EQh6hnHE2T0MvD1HqGBDS2jl8uUlHF4fZc2vmewVK3n1PCGrhEpA6idnQg3hZoGrzlxFopvRyiXl+A4FdqMVb/aCIgDsTBvuAmoo/ycUMWzwxcYVaIydT8m+ubqJoJ9A4ORfrqPNZgCFo1EU5CeC9ejU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780940676; c=relaxed/simple;
	bh=cz+t8mxL5RTdXBCBHZET/cvZn5nIgElLwPKDnobY/9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VCY5juGj6BmdmrEEW40+k9QIjfYhCXOJ/h/UlAOcxV6CdLjG7C32uS2jyw9RNqwNIvxhicTJ3WC1m2v5msY5baVHyYggtc55gED1EkKbgH3CmSbGLU0XmPCxd6kf/tre783aHE5CG/cv/7zvtpdsxKSmCoqx5s2BhTsaywk/2Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OyKuXEuS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OyKuXEuS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C83CC1F00893;
	Mon,  8 Jun 2026 17:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780940675;
	bh=7SaRN7U7GMi8V3oHDtbxeOXRXpOaj8e5lsLDARvt1jk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OyKuXEuSjiftV6kXwuf+BBASZZjkbg7BI0JkE+zKNfJVeHn7yXl7tweu1Ch1Roxmj
	 Iy3wwj0OhxXT/cRajrHUMX/3EALUm33JSt6DvUw+78G4lnpNyodgb7PmfUnvr4DcOD
	 dLf7Bb1Fibw00ryh2dRasbDHXkKte3rE/qoKPuWZ+6eC5HwGBwAKpwIRaUOdpy5qHf
	 W3gLf/ZNAhIgljs7OinG4/b0KbdURAd3jChzONszWj0FqlW+Esr+JV6hVSWpGWidt8
	 D5BfkC/hv7V8tjJhB4rp8W8yumlYSlNs7EUm1R0fR7yHI/LGz0vmnwzL3VH2Pbs9AL
	 8dcGmzEhBWbyg==
Date: Mon, 8 Jun 2026 18:44:31 +0100
From: Conor Dooley <conor@kernel.org>
To: Jun Yan <jerrysteve1101@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] dt-bindings: input: microchip,cap11xx: Cleanup and
 refine LED constraints
Message-ID: <20260608-mooned-ambiguous-02493b8d383e@spud>
References: <20260606150458.250606-1-jerrysteve1101@gmail.com>
 <20260606150458.250606-4-jerrysteve1101@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rH4ypI988offermW"
Content-Disposition: inline
In-Reply-To: <20260606150458.250606-4-jerrysteve1101@gmail.com>


--rH4ypI988offermW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 06, 2026 at 11:03:56PM +0800, Jun Yan wrote:
> Add detailed datasheet links for all supported CAP11xx devices.
>=20
> Unify LED node pattern to support all chip variants in preparation
> for CAP1114 support.
>=20
> Remove redundant LED properties inherited from common.yaml
>=20
> Apply per-chip LED channel limits:
> - CAP1126: max 2 channels (0-1)
> - CAP1188: max 8 channels (0-7)
> - CAP1106, CAP12xx: no LED support
>=20
> Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
> ---
>  .../bindings/input/microchip,cap11xx.yaml     | 51 ++++++++++++++-----
>  1 file changed, 37 insertions(+), 14 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/input/microchip,cap11xx.ya=
ml b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
> index 7ade03f1b32b..99d00f572a2d 100644
> --- a/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
> +++ b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
> @@ -10,6 +10,15 @@ description: |
>    The Microchip CAP1xxx Family of RightTouchTM multiple-channel capaciti=
ve
>    touch controllers and LED drivers. The device communication via I2C on=
ly.
> =20
> +  For more product information please see the links below:
> +    CAP1106: https://ww1.microchip.com/downloads/en/DeviceDoc/00001624B.=
pdf
> +    CAP1126: https://ww1.microchip.com/downloads/en/DeviceDoc/00001623B.=
pdf
> +    CAP1188: https://ww1.microchip.com/downloads/en/DeviceDoc/00001620C.=
pdf
> +    CAP1203: https://ww1.microchip.com/downloads/en/DeviceDoc/00001572B.=
pdf
> +    CAP1206: https://ww1.microchip.com/downloads/en/DeviceDoc/00001567B.=
pdf
> +    CAP1293: https://ww1.microchip.com/downloads/en/DeviceDoc/00001566B.=
pdf
> +    CAP1298: https://ww1.microchip.com/downloads/en/DeviceDoc/00001571B.=
pdf
> +
>  maintainers:
>    - Rob Herring <robh@kernel.org>
> =20
> @@ -124,25 +133,21 @@ properties:
>        The number of entries must correspond to the number of channels.
> =20
>  patternProperties:
> -  "^led@[0-7]$":
> +  "^led@[0-9a-f]$":
>      type: object
>      description: CAP11xx LEDs
>      $ref: /schemas/leds/common.yaml#
> =20
>      properties:
>        reg:
> -        enum: [0, 1, 2, 3, 4, 5, 6, 7]
> -
> -      label: true
> -
> -      linux,default-trigger: true
> -
> -      default-state: true
> +        description: LED channel number
> +        minimum: 0
> +        maximum: 7
> =20
>      required:
>        - reg
> =20
> -    additionalProperties: false
> +    unevaluatedProperties: false

> Remove redundant LED properties inherited from common.yaml

But the pattern here suggests they aren't redundant, this is how you say
"these properties are the only common ones allowed". You need to explain
why other ones are valid to change this.

pw-bot: changes-requested
(a commit message change is required at least)

> =20
>  allOf:
>    - $ref: input.yaml
> @@ -158,7 +163,20 @@ allOf:
>                - microchip,cap1298
>      then:
>        patternProperties:
> -        "^led@[0-7]$": false
> +        "^led@": false
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - microchip,cap1126
> +    then:
> +      patternProperties:
> +        "^led@":
> +          properties:
> +            reg:
> +              maximum: 1

I think these changes to permitted properties should be a standalone
patch.

Thanks,
Conor.

> =20
>    - if:
>        properties:
> @@ -183,6 +201,9 @@ additionalProperties: false
> =20
>  examples:
>    - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/leds/common.h>
> +
>      i2c {
>        #address-cells =3D <1>;
>        #size-cells =3D <0>;
> @@ -208,19 +229,21 @@ examples:
>          #size-cells =3D <0>;
> =20
>          led@0 {
> -                label =3D "cap11xx:green:usr0";
>                  reg =3D <0>;
> +                function =3D LED_FUNCTION_INDICATOR;
> +                color =3D <LED_COLOR_ID_GREEN>;
>          };
> =20
>          led@1 {
> -                label =3D "cap11xx:green:usr1";
>                  reg =3D <1>;
> +                function =3D LED_FUNCTION_INDICATOR;
> +                color =3D <LED_COLOR_ID_GREEN>;
>          };
> =20
>          led@2 {
> -                label =3D "cap11xx:green:alive";
>                  reg =3D <2>;
> -                linux,default-trigger =3D "heartbeat";
> +                function =3D LED_FUNCTION_INDICATOR;
> +                color =3D <LED_COLOR_ID_GREEN>;
>          };
>        };
>      };
> --=20
> 2.54.0
>=20

--rH4ypI988offermW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaib/fwAKCRB4tDGHoIJi
0uEkAQCFdIGRxKR1psSYBhzw+94NVbFeG8Or/aBRUrF8kaPsEwD+K+a3JYsJUO6n
TWdWp2duFOAFk9YRYm/I/6hVaGER6Ak=
=ZXU4
-----END PGP SIGNATURE-----

--rH4ypI988offermW--
