Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E89B3B8BD4;
	Mon, 12 Oct 2026 18:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791831413; cv=none; b=glYltg8ByU7mBVEoO3cee1sqcy4/vINLr39+yfZHM0IGJvkBQrTCLsKZ92VLntK4i54P4+wsmSkohJ7lxlDIAm1/2VKfFsO9IjncmjIPLr/lTmeIQXPc8HO1j6iEKA84AdPpN1hTCduIZ3tdJ4HWvqT59764o9KScdYaxBoz9sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791831413; c=relaxed/simple;
	bh=cP4m7tYUJGz7T+N2YB75rWYlD0xq6AuaulpHWzJtu2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OfFGot8mlqjMz2EApqqmUnx6MtHxrSxBZy84k1xMZzrAN1ArakBBc6z49VvtLAs9Y+18rIA4YrSjrAe4VdjA0Nj0R7IXIRvMBkaFOZTHRiOWImxtpLAjiKMX33w69b6eN9rBvTcE4ctNqj8ARYCerjiGc+XBc/9EtlQ3LlAMadM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JwDMB301; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JwDMB301"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D191F008A2;
	Mon, 12 Oct 2026 18:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791831412;
	bh=VvJtHEQg+Olru8UVxHeYJRqkxKYX96RVY45lcytm5BQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JwDMB301VW+Qep64esjyHLU+079ApVGCrC+3/EkRVhX/xacJEZJeKafoAYbbrvV/3
	 GwGijpSHNdUoPAghOTM/GMaB1mQEuQbvYr7pPi7VD2fMMQe3kxJSrYy5Vcd7YC+Lwy
	 xLYAfLzG115c5Q/fIPXv0HgklytUFKLzGOOzCTD3BZ0+hPHPjYxsHnp3/CtGkBKTN8
	 +lpHGXTbkgTevUJqXIiv95KHFqwxGDJyUtOltZbxBG2Wp11nlOtTL3M5ozari7WT0G
	 7jIi+8N81Ojpt3Yo8xqFX+Gwj6SF36utFmRyVxFJ3pQ2Dc5p/xreZU3bMJ7rqHAYDd
	 uDTJIQviHpVvg==
Date: Mon, 12 Oct 2026 19:56:48 +0100
From: Conor Dooley <conor@kernel.org>
To: Miotsuki Mizuno <founder@crepuse.com>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"icenowy@aosc.io" <icenowy@aosc.io>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"robh@kernel.org" <robh@kernel.org>
Subject: Re: [PATCH v3 2/3] dt-bindings: input: touchscreen: add Nsiway NS2009
Message-ID: <20261012-overeager-drained-2a62b68c65cb@spud>
References: <20261012121705.53396-1-founder@crepuse.com>
 <20261012121705.53396-3-founder@crepuse.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wh4MMhUTedsE4X2+"
Content-Disposition: inline
In-Reply-To: <20261012121705.53396-3-founder@crepuse.com>

--wh4MMhUTedsE4X2+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 12:17:08PM +0000, Miotsuki Mizuno wrote:
> From: Mizuno Miotsuki <founder@crepuse.com>
>=20
> Describe the Nsiway NS2009 four-wire resistive touchscreen controller
> with optional pen interrupt, power and reference supplies, and touch
> resistance measurement properties. Include one complete example.
>=20
> Signed-off-by: Mizuno Miotsuki <founder@crepuse.com>
> ---
>  .../input/touchscreen/nsiway,ns2009.yaml      | 78 +++++++++++++++++++
>  MAINTAINERS                                   |  6 ++
>  2 files changed, 84 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/n=
siway,ns2009.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/nsiway,n=
s2009.yaml b/Documentation/devicetree/bindings/input/touchscreen/nsiway,ns2=
009.yaml
> new file mode 100644
> index 000000000000..caea15b5c5a3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/nsiway,ns2009.y=
aml
> @@ -0,0 +1,78 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/touchscreen/nsiway,ns2009.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nsiway NS2009 resistive touchscreen controller
> +
> +maintainers:
> +  - Mizuno Miotsuki <founder@crepuse.com>
> +
> +description:
> +  Nsiway NS2009 is an I2C four-wire resistive touchscreen controller with
> +  a 12-bit ADC, an active-low pen interrupt and touch resistance measure=
ment.
> +
> +allOf:
> +  - $ref: touchscreen.yaml#
> +
> +properties:
> +  compatible:
> +    const: nsiway,ns2009
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +    description:
> +      Active-low pen interrupt output. Optional when the signal is not
> +      connected.
> +
> +  wakeup-source:
> +    type: boolean
> +
> +  vdd-supply:
> +    description: Main power supply.
> +
> +  vref-supply:
> +    description: External ADC reference voltage supply.
> +
> +  touchscreen-min-pressure:
> +    minimum: 1
> +    maximum: 4095
> +    default: 80
> +    description:
> +      Minimum raw Z1 reading considered a touch. This is a contact detec=
tion
> +      threshold, not a calibrated pressure value. Boards may require a h=
igher
> +      empirically determined threshold than the historical driver defaul=
t.
> +
> +required:
> +  - compatible
> +  - reg

Sounds like vdd-supply should also be required. I assume vref-supply is
optional?

Looks okay otherwise.
pw-bot: changes-requested

Thanks,
Conor.

> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        touchscreen@48 {
> +            compatible =3D "nsiway,ns2009";
> +            reg =3D <0x48>;
> +            interrupt-parent =3D <&gpio1>;
> +            interrupts =3D <7 IRQ_TYPE_LEVEL_LOW>;
> +            wakeup-source;
> +            vdd-supply =3D <&vdd>;
> +            vref-supply =3D <&vref>;
> +            touchscreen-x-plate-ohms =3D <400>;
> +            touchscreen-min-pressure =3D <150>;
> +            touchscreen-max-pressure =3D <4095>;
> +            touchscreen-fuzz-pressure =3D <16>;
> +            touchscreen-inverted-y;
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f53047aa8d3c..696f2badc49c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19467,6 +19467,12 @@ S:	Maintained
>  F:	Documentation/core-api/symbol-namespaces.rst
>  F:	scripts/nsdeps
> =20
> +NSIWAY NS2009 TOUCHSCREEN CONTROLLER
> +M:	Mizuno Miotsuki <founder@crepuse.com>
> +L:	linux-input@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/input/touchscreen/nsiway,ns2009.yaml
> +
>  NTB AMD DRIVER
>  M:	Basavaraj Natikar <Basavaraj.Natikar@amd.com>
>  M:	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> --=20
> 2.56.0
>=20

--wh4MMhUTedsE4X2+
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCas0tcAAKCRB4tDGHoIJi
0tceAP9AVZikGKYM4a1Y3wgZ1tavM/Ebq+XIURMaKppeke3NKwEA1PvnfGCrQZOz
NI/wwngcCJizbHafqif3fa1yhzpcwwI=
=IDdC
-----END PGP SIGNATURE-----

--wh4MMhUTedsE4X2+--
