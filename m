Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3C5344DB0;
	Tue,  9 Jun 2026 14:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015511; cv=none; b=kVK/yUV7UWG2QYIK+zXJYOnOjgq1O33/DQKi35Yzxcc1dCy8UvUPJq/4URIYs5suAbclfpGBZtk7xGU2sNMm633NlzLUNuDX3DEUBCeUQRDj70Hfxxdk1OMMycldVqlWjTYOdVpOMyR0sWPgisqY0cPHaXOTaf7owOzzqKEeyg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015511; c=relaxed/simple;
	bh=pdqcsNBtepv+2jcW+mA5WaQvPbX5QAb9X+FohsEz8fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eYvvyCF0R+nhi8XLKfHp73f5OAvjqBoAHmFEXUThT1t6snH4us8TGeNrXdHsebRIb/IgmgqJ1mZmF2SFPKU1KxcizWwNWKJSiZaed8lWCIuZMQ0wsxnQPHirijJ0NvzE6Nuqi7Q24tZCKT7OTcOx0nPolzdBa2vR9Odx5gGFsZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJp8F4JY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJp8F4JY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D0E1F00893;
	Tue,  9 Jun 2026 14:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781015510;
	bh=YYr2fDcT/qLUNiiWKZH/9Di3yNy9ktWhaFeytqhbFu0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bJp8F4JY2vcS6oz+xEfQI7kfR+Bt7Ng+KjsMawRuL6JaVThfxkVcv5eUDLlvhLIia
	 og+5WpeqYX54rWKcmNE6A0W/G74Bv8jdGiPs+GNItgRR6uxEXK3/NG/HMBFMN2/8fR
	 54S8KNny6XXnO7u1jf8/miENK3hnsELnKnvJQ303H4KzB+T9X73vPDnkb7PK+fe3HA
	 qfnGWWlYlZfLUmkm5L58Vh/v7y8mgX2YOmqpSPruVRq3thM+Sc1EZBhFI7mu6kgYqJ
	 tsewXTgDc94Kga/FhmkkbBZO+BsLHP4RxHcVjNNWprBNcnc2GABGdKWb8c3JxjcmPo
	 6rxJ1j4rPr+zw==
Date: Tue, 9 Jun 2026 15:31:46 +0100
From: Conor Dooley <conor@kernel.org>
To: Jun Yan <jerrysteve1101@gmail.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org,
	dmitry.torokhov@gmail.com, krzk+dt@kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	robh@kernel.org
Subject: Re: [PATCH 7/8] dt-bindings: input: microchip,cap11xx: Add CAP1114
 support
Message-ID: <20260609-ebook-tantrum-4846384c02d5@spud>
References: <20260608-broadly-reunion-09fc8eca5e87@spud>
 <20260609140827.850117-1-jerrysteve1101@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Y+5vcRnMIXFuL3t4"
Content-Disposition: inline
In-Reply-To: <20260609140827.850117-1-jerrysteve1101@gmail.com>


--Y+5vcRnMIXFuL3t4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 09, 2026 at 10:08:27PM +0800, Jun Yan wrote:
> > On Sat, Jun 06, 2026 at 11:04:00PM +0800, Jun Yan wrote:
> > > CAP1114 is a 14-channel capacitive touch sensor with 11 LED outputs
> > > and hardware reset support.
> > >=3D20
> > > Add the compatible string for CAP1114, include its datasheet URL,
> > > and update the maximum count of LED channels and linux,keycodes entri=
es.
> > >=3D20
> > > Add description for microchip,input-threshold: CAP1114 only provides =
eight
> > > threshold entries, which does not match its total channel count.
> > >=3D20
> > > Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
> > > ---
> > >  .../bindings/input/microchip,cap11xx.yaml     | 21 +++++++++++++++++=
--
> > >  1 file changed, 19 insertions(+), 2 deletions(-)
> > >=3D20
> > > diff --git a/Documentation/devicetree/bindings/input/microchip,cap11x=
x.ya=3D
> > ml b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
> > > index e307628350c2..08233386a433 100644
> > > --- a/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
> > > +++ b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
> > > @@ -12,6 +12,7 @@ description: |
> > > =3D20
> > >    For more product information please see the links below:
> > >      CAP1106: https://ww1.microchip.com/downloads/en/DeviceDoc/000016=
24B.=3D
> > pdf
> > > +    CAP1114: https://ww1.microchip.com/downloads/en/DeviceDoc/000024=
44A.=3D
> > pdf
> > >      CAP1126: https://ww1.microchip.com/downloads/en/DeviceDoc/000016=
23B.=3D
> > pdf
> > >      CAP1188: https://ww1.microchip.com/downloads/en/DeviceDoc/000016=
20C.=3D
> > pdf
> > >      CAP1203: https://ww1.microchip.com/downloads/en/DeviceDoc/000015=
72B.=3D
> > pdf
> > > @@ -26,6 +27,7 @@ properties:
> > >    compatible:
> > >      enum:
> > >        - microchip,cap1106
> > > +      - microchip,cap1114
> > >        - microchip,cap1126
> > >        - microchip,cap1188
> > >        - microchip,cap1203
> > > @@ -62,7 +64,7 @@ properties:
> > > =3D20
> > >    linux,keycodes:
> > >      minItems: 3
> > > -    maxItems: 8
> > > +    maxItems: 14
> > >      description: |
> > >        Specifies an array of numeric keycode values to
> > >        be used for the channels. If this property is
> > > @@ -122,6 +124,8 @@ properties:
> > >        is required for a touch to be registered, making the touch sen=
sor =3D
> > less
> > >        sensitive.
> > >        The number of entries must correspond to the number of channel=
s.
> > > +      CAP1114 is an exception where channels 8~14 reuse the eighth e=
ntry=3D
> > 's
> > > +      threshold, so counts differ.
> > > =3D20
> > >    microchip,calib-sensitivity:
> > >      $ref: /schemas/types.yaml#/definitions/uint32-array
> > > @@ -149,7 +153,7 @@ patternProperties:
> > >        reg:
> > >          description: LED channel number
> > >          minimum: 0
> > > -        maximum: 7
> > > +        maximum: 10
> > > =3D20
> > >      required:
> > >        - reg
> > > @@ -199,6 +203,19 @@ allOf:
> > >              reg:
> > >                maximum: 1
> > > =3D20
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            enum:
> > > +              - microchip,cap1188
> >=20
> > I don't understand this restriction, shouldn't this be
> > if: properties: compatible: not: contains: microchip,cap1114
> > so that the constraints before your change are retained?
> >=20
>=20
> Previously, the LED reg property had a default maximum of 7 for CAP1188.=
=20
> With the addition of CAP1114, the default maximum is now 11.=20
> An if-then constraint is added to limit the LED count for CAP1188.

Ah, is this because cap1188 is the only existing device in the binding
that actually has LEDs?

--Y+5vcRnMIXFuL3t4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaigjzgAKCRB4tDGHoIJi
0jSNAQDvJ1goshSggJqk7VT7ODGZ1pGMI3GyC+meq8voSIcnLgD/Rha/49m/DH3F
WYWhivwg1lUOqhCjYbvY1B4InQg/pQY=
=zcuJ
-----END PGP SIGNATURE-----

--Y+5vcRnMIXFuL3t4--
