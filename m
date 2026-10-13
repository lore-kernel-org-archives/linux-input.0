Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7F2511E67;
	Tue, 13 Oct 2026 16:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791908793; cv=none; b=QFF6dyR+alGJVHdif5SPTYolhVzcsFufBnPjvtsOtUu6zumrm07VsPPT26KDHmHBNBtMm3dr2hNocxreoLMpusF0RESpzpTVq/1jDYaFnW7Pv0pHr0GPYe1Qo4XjYodHk7obNlK0KlmGza17td22u+Um6aBwp3XcEoquOOYBf1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791908793; c=relaxed/simple;
	bh=3qyTP8+WZ6AyOs7nJ6TTAsG5HdMwZF+kpLSnqe1i/cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eHmmeo3JTXvRxqdWpsfrWnI3QFRksYbfJtN85pfWCEFtga+BMYYNVL8xTi+FcEKposnM3Q97he0MiH0MIQ3S5Z24B1+3AI020yvW0zUY0CaHAaddy/IknO1XtMC4yZ2yuoKO+IDFYkzUzwKLjWyhStvrX93DuCoGX/0fu6sh8uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IbiwJMfs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IbiwJMfs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4896A1F000FF;
	Tue, 13 Oct 2026 16:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791908792;
	bh=fcUaSh6THj74YfYrkHmr8E7G02HrqAcNir1RnFpgXlM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IbiwJMfsruKB75RUAAUvY6QcrxK5Lf6MTy5vu1W/MaVbIVT7eXAgd/6Fk94knQ++h
	 98pfuWPtOO2UIoOmWHD7hNnvp1ysjtqxZaefjai3EhnGBx5albxjX5hpB21CQqUfod
	 61/ZTGZWBhbqpfTy2skVhasm/pfsLbdIfrbC3htuLJhWRi6ZeI+bXzhBOVtxQhbbXp
	 CVNw0MeV3Vn4KHPuXzpjSAIBMyP6IsEw6z9pHOYiXrtivaRGTknhYU8mCb8dwiwxbC
	 ZGNhAvLoy+7Xf0UWlpYV6gus8IWQYSw+WSOPCtnlTsIgvzol+eLLNVsAnrk7jWTZH8
	 f/HP50zgodNVQ==
Date: Tue, 13 Oct 2026 17:26:28 +0100
From: Conor Dooley <conor@kernel.org>
To: founder@crepuse.com
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, icenowy@aosc.io,
	linux-kernel@vger.kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/3] dt-bindings: input: touchscreen: add Nsiway NS2009
Message-ID: <20261013-spider-sporty-1a41a930d375@spud>
References: <20261013-review-self-ns2009-v4-20261013-v4-0-98bb21712282@crepuse.com>
 <20261013-review-self-ns2009-v4-20261013-v4-2-98bb21712282@crepuse.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9tz+fWFhurRDfH+v"
Content-Disposition: inline
In-Reply-To: <20261013-review-self-ns2009-v4-20261013-v4-2-98bb21712282@crepuse.com>

--9tz+fWFhurRDfH+v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 11:04:21PM +0800, Mizuno Miotsuki via B4 Relay wrot=
e:
> From: Mizuno Miotsuki <founder@crepuse.com>
>=20
> Describe the Nsiway NS2009 four-wire resistive touchscreen controller,
> including its pen interrupt, main supply and external reference supply.

> Require vdd-supply as requested by Conor Dooley. Keep vref-supply optiona=
l:
> differential touch measurements reference the driven panel terminals, and
> the 10-pin package does not expose a separate VREF pin.

Drop the sentence referring to my review feedback please.
The second sentence about why the vref supply is optional is good and
should stay.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: changes-requested

Thanks,
Conor.

>=20
> Allow the common coordinate and touch resistance properties, and describe
> the raw Z1 contact threshold separately from calibrated pressure.
>=20
> Signed-off-by: Mizuno Miotsuki <founder@crepuse.com>
> ---
>  .../bindings/input/touchscreen/nsiway,ns2009.yaml  | 79 ++++++++++++++++=
++++++
>  MAINTAINERS                                        |  6 ++
>  2 files changed, 85 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/nsiway,n=
s2009.yaml b/Documentation/devicetree/bindings/input/touchscreen/nsiway,ns2=
009.yaml
> new file mode 100644
> index 000000000000..8ee7ff7156ca
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/nsiway,ns2009.y=
aml
> @@ -0,0 +1,79 @@
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
> +  - vdd-supply
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
>=20
> --=20
> 2.56.0
>=20
>=20

--9tz+fWFhurRDfH+v
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCas5btAAKCRB4tDGHoIJi
0um7AQCCsOMtZKFETGmKe1GrJ0lIhQ3bRGIsvHRoHCmkppJhywD9EV9Glg8k+vcA
pgzKMFKuLL79jYJo4FXygLepgAfeFAA=
=fgjo
-----END PGP SIGNATURE-----

--9tz+fWFhurRDfH+v--
