Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3707C1DB356;
	Wed, 10 Jun 2026 16:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781109268; cv=none; b=i7TxHRhyDcpvkxxx6/tf03gtYmjd1f5xjve684JvZ2zR5TyO6TqxQZKO2Or6pUP/kQRUOuzK9BvbugNNl9eOIQJ0trhY7KYG1jMb1fRLUJVy5pqhpAG28+7KBJirI91UeRYFOgH5tQKb1mPes9aZilcggbc8xuyouSInH09efWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781109268; c=relaxed/simple;
	bh=zcb0dtZHCHiBgHkSvFJuQubeYv+nc7A88NajAAY88/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WTLHj8i5clydouljOmM2ynlCFjUZceU+RjKJoKUB9H2TggPc0rB35xxMoJP1+f0g4qqS+fhMxQsZF7SntfaC8K4vIyCmblr8pDvwIbhxWpap79r9YIqTHFTEzEvZKBsuFrz8FFR3y94ak5mWJZ7BaqQlAz71vmqOw+WATujtdbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fl9xV8YP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fl9xV8YP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 568561F00893;
	Wed, 10 Jun 2026 16:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781109266;
	bh=gjO31DRuVicXMLpjIb0ytHqC9/QtWlWYgv3Gax2rQCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Fl9xV8YPKnzwjRwjWApXWMag+kQ6znrq0IvV2EThA/UjfW1WmotnjPmgLLV8zabhz
	 goQOyxSKF2wyUmnK+olLJfTFdMn4uvK5l36ygRHvTkUI5XUkNjpztXGwWvcXRh3g6P
	 gfrpnZyLhQjURBoSSHPmT/AB10ytiGanfdCcCZt6Lou3iRxlRbCOfQafHS9+7ZviPC
	 iVqXqczmnIssCU1KOmkhMmrqMRHxXoCB5QKg4QhaH0lYDPPuTaPRqLShyGBc8Eobgf
	 vchgpSLMocJBIVsfduRD+yXE6O9gfrhFYoqmiOZXMWgYL+Rg04MpH0P0AQ/4KMT2VP
	 6FvaeGSlrpTzw==
Date: Wed, 10 Jun 2026 17:34:20 +0100
From: Conor Dooley <conor@kernel.org>
To: Jun Yan <jerrysteve1101@gmail.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org,
	dmitry.torokhov@gmail.com, krzk+dt@kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	robh@kernel.org
Subject: Re: [PATCH 7/8] dt-bindings: input: microchip,cap11xx: Add CAP1114
 support
Message-ID: <20260610-generous-strength-4acced86f3c6@spud>
References: <20260609-ebook-tantrum-4846384c02d5@spud>
 <20260610133458.970174-1-jerrysteve1101@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+tTubhEK9EHpfl3N"
Content-Disposition: inline
In-Reply-To: <20260610133458.970174-1-jerrysteve1101@gmail.com>


--+tTubhEK9EHpfl3N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 09:34:58PM +0800, Jun Yan wrote:
> > > > > +      threshold, so counts differ.
> > > > > =3D3D20
> > > > >    microchip,calib-sensitivity:
> > > > >      $ref: /schemas/types.yaml#/definitions/uint32-array
> > > > > @@ -149,7 +153,7 @@ patternProperties:
> > > > >        reg:
> > > > >          description: LED channel number
> > > > >          minimum: 0
> > > > > -        maximum: 7
> > > > > +        maximum: 10
> > > > > =3D3D20
> > > > >      required:
> > > > >        - reg
> > > > > @@ -199,6 +203,19 @@ allOf:
> > > > >              reg:
> > > > >                maximum: 1
> > > > > =3D3D20
> > > > > +  - if:
> > > > > +      properties:
> > > > > +        compatible:
> > > > > +          contains:
> > > > > +            enum:
> > > > > +              - microchip,cap1188
> > > >=3D20
> > > > I don't understand this restriction, shouldn't this be
> > > > if: properties: compatible: not: contains: microchip,cap1114
> > > > so that the constraints before your change are retained?
> > > >=3D20
> > >=3D20
> > > Previously, the LED reg property had a default maximum of 7 for CAP11=
88.=3D
> > =3D20
> > > With the addition of CAP1114, the default maximum is now 11.=3D20
> > > An if-then constraint is added to limit the LED count for CAP1188.
> >=20
> > Ah, is this because cap1188 is the only existing device in the binding
> > that actually has LEDs?
>=20
> - CAP1126: max 2 LED channels (0-1)
> - CAP1188: max 8 LED channels (0-7)
> - CAP1106, CAP12xx: no LED support
>=20
> The LED reg property constraints for CAP1126 were added in Patch 3 [1].
>=20
> [1] https://lore.kernel.org/linux-input/20260606150458.250606-4-jerrystev=
e1101@gmail.com/

Okay, that makes more sense now. Thanks.

--+tTubhEK9EHpfl3N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaimSDAAKCRB4tDGHoIJi
0gFaAP9trN8osyavF69mIX7MVoz0YmJAQutYJoggCDkyExIWOwD+PMC5Q7rJOkrw
z4POsbKMvLC5wZbE1lmpk3CICqcrdwE=
=xFIY
-----END PGP SIGNATURE-----

--+tTubhEK9EHpfl3N--
