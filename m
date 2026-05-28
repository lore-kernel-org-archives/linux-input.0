Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3FB3FBB5E;
	Thu, 28 May 2026 17:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779988258; cv=none; b=LQxxeSR5WFgUg+9nYqd9++Epg+t3ARhoK36t6yrfIKBtT76YqGYfxD85XkvMkfjCR7WPZeo2NReGIAfpACkChXTa2Q4DBoJ69knmUumse6zzNXSt4OVzJS+Zz7IlBpL4Hb1B2mY8am5gzA4fedn/RlckQQ63z0pSk6gMFebnja8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779988258; c=relaxed/simple;
	bh=n2wcEO8s+12BK1f4VZTLjS4luMFSh0CYw+5s5vBvACM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oW34bEfijQ+xBPg9iRcr9I6YM06USGj1mfU6ysmk1hDm47kvPd7kF3Hz3DK9jUI70Ss464wBac2oMSdX3zbF8YgU/GDgKM06o5i5n8VThz6LdCX2DLGaqPhKrvfjZrkDO3sNt/kvGPw+GS/lC7duW8zHSK0KGS5rqdXHo600Yjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBgmaJ3W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBgmaJ3W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC6AF1F000E9;
	Thu, 28 May 2026 17:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779988255;
	bh=gyVo4423o0iPXgoRjXkG1h68nIJ2qeXNY9VfLrcU0ls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oBgmaJ3WgDBMaEu2rb6NR+1bCPe1YrPufqq8iH0Bcn3+pIYQD5Sinje/WOy4IOM6I
	 MJGAV5lbPUPxDAFhE96LgVUc0zesYKoiiIB7Gtq1KTfuE9+5KGAzS0SZOuJNAqcjAM
	 uk3W2kYGE77vl9fSMBZLfzwEeuql86L+KP6MKEI/aJVkcTObcawNfsUwhvAe7KwVdo
	 qR/YebVpmCN/Y/LIXu539a4O9iHnlQZXh41tGHSEGtNW7XbD7gm3rueQXSztA1Gw2m
	 K0FUT5VoCM29v15wz8uiid4kKxep92z3KE1IaBGDnKoeAGd7s+UXnTmaR2vgkqnsOi
	 StjdDy+kMyEsw==
Date: Thu, 28 May 2026 18:10:51 +0100
From: Conor Dooley <conor@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Hendrik Noack <hendrik-noack@gmx.de>, robh@kernel.org,
	dmitry.torokhov@gmail.com, conor+dt@kernel.org,
	devicetree@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v8 1/2] dt-bindings: Input: Add Wacom W9000-series
 penabled touchscreens
Message-ID: <20260528-dislodge-richly-38e28466f494@spud>
References: <20260528074818.12151-2-hendrik-noack@gmx.de>
 <20260528083225.3A5101F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uZvB6Cc0nt5hAy5K"
Content-Disposition: inline
In-Reply-To: <20260528083225.3A5101F00A3A@smtp.kernel.org>


--uZvB6Cc0nt5hAy5K
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 08:32:24AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
> - [Low] Vendor-specific property 'flash-mode-gpios' is missing the vendor=
 prefix.
> - [Low] Node name 'digitizer@56' in the example should be a standard gene=
ric name such as 'touchscreen@56'.
> - [Low] The binding file is named after a specific variant ('wacom,w9007a=
-lt03.yaml') rather than the first compatible string ('wacom,w9002.yaml').
> --
>=20
> commit d38ecd0efb12cc8efc9000f9c78e8a14387d40c6
> Author: Hendrik Noack <hendrik-noack@gmx.de>
> Subject: dt-bindings: Input: Add Wacom W9000-series penabled touchscreens
>=20
> This commit adds bindings for the Wacom W9002, W9007A LT03, and W9007A V1
> touchscreen controllers. These controllers differ slightly in their return
> message formats.
>=20
> > diff --git a/Documentation/devicetree/bindings/input/touchscreen/wacom,=
w9007a-lt03.yaml b/Documentation/devicetree/bindings/input/touchscreen/waco=
m,w9007a-lt03.yaml
> > new file mode 100644
> > index 0000000000000..6d1da6a435d39
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/touchscreen/wacom,w9007a-=
lt03.yaml
>=20
> [Severity: Low]
> Should this file be named wacom,w9002.yaml after the first compatible str=
ing,
> rather than being named after a specific variant?

This doesn't matter, w9002 is as much of a "variant" as the others.

>=20
> > @@ -0,0 +1,73 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
>=20
> [ ... ]
>=20
> > +  vdd-supply: true
> > +
> > +  flash-mode-gpios:
> > +    maxItems: 1
>=20
> [Severity: Low]
> Does this property need a vendor prefix (wacom,flash-mode-gpios) since it=
 is
> hardware-specific?

No, cos it is a gpios property. Just like how supplies don't have
prefixes.

>=20
> [ ... ]
>=20
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        digitizer@56 {
>=20
> [Severity: Low]
> Should this node name be changed to a generic class name such as
> touchscreen@56?

"digitiser" is generic enough for this not to matter IMO.

>=20
> > +            compatible =3D "wacom,w9007a-lt03";
> > +            reg =3D <0x56>;
>=20
> --=20
> Sashiko AI review =B7 https://sashiko.dev/#/patchset/20260528074818.12151=
-1-hendrik-noack@gmx.de?part=3D1

--uZvB6Cc0nt5hAy5K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCahh3GwAKCRB4tDGHoIJi
0oQlAQDODchRV9feUSQp8Ot9KfEQ2LZZqLgihLmcEh8k89nlqgD+OX+/F6QEnTc/
z4mPkYvezV1g7ukf7QqIWFzN/8PXvwc=
=fheY
-----END PGP SIGNATURE-----

--uZvB6Cc0nt5hAy5K--
