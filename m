Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69D736C581;
	Tue, 17 Feb 2026 15:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771343460; cv=none; b=AprBNymwSdDQ9qTeldNRF4bKuV931ZROgI5hZ2+ddC/2F5mYdcgsQCryw7RrW/3D74gnrZMpIjCVkX1kJ6DBOrKn2en6Fm/GCLE6qAyfVkPqnKwTEhH6P9iwt+IOSI8MSRndgEog+C9cfwobJkpx/wzzlUQOFWBtdjDEo3ONJRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771343460; c=relaxed/simple;
	bh=F3tr3dTMqJx3SD92fKDrGHKnROwGZ6bJ78jeAepD7a4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ejh9EoALS2prHLwkHifzDq0Q5GNqY5OXTAYrhQbZgQB6zrR42gmwii/IP0AVNj3eKIhbdmz2e0klMFNaq683dmutODDv93BX9urwjimZb0PMiWsFCphtfRXK4TmTDsLumgNgnNLkAO4f4pbW/W1wbpH0LPiGESPZGbdyVuz3OOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNw6hdMT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNw6hdMT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84071C4CEF7;
	Tue, 17 Feb 2026 15:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771343460;
	bh=F3tr3dTMqJx3SD92fKDrGHKnROwGZ6bJ78jeAepD7a4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MNw6hdMTPCx7nqnz+wvSOwxVvNZ0I/reKjeODpt36xYllBHz1Rh+MlQhUAz0HzUtA
	 m5rSpqP1FNE1yBLk3SRm1RhvmDF3wHln9KJO3y4YxVgajtf72Ogl+dHANCqKy0VU3R
	 O2h42mALLS/iDwxKS6KYIIt+OncvDeRY0IyK2Lz7ODueiYx6NvsSEoi49UkYo5xggX
	 94Sm+1a79cVVqV+5bRpVdgbfQU6bO0n0b7Jd7YV9vRPLcQTvbKQ0R7xozwS1UsLO4l
	 h0PTRTUhuos5CSJqQVm7MW+lJqvedInn/xifPZAo1qyOjlDpHPZ/sMQ6sbkGxHefpp
	 bmq+P0cIoNCxQ==
Date: Tue, 17 Feb 2026 15:50:55 +0000
From: Conor Dooley <conor@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Ion Agorria <ion@agorria.com>,
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 1/7] dt-bindings: embedded-controller: document ASUS
 Transformer EC
Message-ID: <20260217-tableful-arbitrate-169030e4fb11@spud>
References: <20260216-sprung-scallop-de7b64bf528c@spud>
 <CAPVz0n06+uLCSfY_bYS9v7KJ-hXotye7ej-rze6-Q8_JAF7XVA@mail.gmail.com>
 <20260216-plunder-defense-de11cf56dd3d@spud>
 <CAPVz0n0-LbTUZBCaO=oN3PpPLpwAqzNo29r687pKY8NbEE9giA@mail.gmail.com>
 <20260217-vowed-botany-b1c47c7e40b8@spud>
 <55C30023-4175-48F2-BCB0-12EC23C48F01@gmail.com>
 <1519143e-4fc3-490d-ab8d-e65edd2c4eec@kernel.org>
 <81844CC9-5355-4B1D-AEBD-6DD67FB8C81B@gmail.com>
 <20260217-dig-husked-8a59b6a19aee@spud>
 <CAPVz0n0u7uhL8_FQFiuB7DrnL++ecbaEKEoV7N2PgTVRBVECkw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CFX4Gs6NaZQ9iQTz"
Content-Disposition: inline
In-Reply-To: <CAPVz0n0u7uhL8_FQFiuB7DrnL++ecbaEKEoV7N2PgTVRBVECkw@mail.gmail.com>


--CFX4Gs6NaZQ9iQTz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2026 at 04:29:59PM +0200, Svyatoslav Ryhel wrote:
> =D0=B2=D1=82, 17 =D0=BB=D1=8E=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 16:03 Co=
nor Dooley <conor@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > On Tue, Feb 17, 2026 at 01:34:01PM +0200, Svyatoslav Ryhel wrote:
> > > 17 =D0=BB=D1=8E=D1=82=D0=BE=D0=B3=D0=BE 2026=E2=80=AF=D1=80. 13:32:26=
 GMT+02:00, Krzysztof Kozlowski <krzk@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:

> > > >> properties:
> > > >>   compatible:
> > > >>       - items:
> > > >>           - enum:
> > > >>               - asus,p1801-t-ec-pad
> > > >>               - asus,sl101-ec-dock
> > > >>               - asus,tf101-ec-dock
> > > >>               - asus,tf101g-ec-dock
> > > >>               - asus,tf201-ec-dock
> > > >>               - asus,tf201-ec-pad
> > > >>               - asus,tf300t-ec-dock
> > > >>               - asus,tf300t-ec-pad
> > > >>               - asus,tf300tg-ec-dock
> > > >>               - asus,tf300tg-ec-pad
> > > >>               - asus,tf300tl-ec-dock
> > > >>               - asus,tf300tl-ec-pad
> > > >>               - asus,tf700t-ec-dock
> > > >>               - asus,tf700t-ec-pad
> > > >>               - asus,tf600t-ec-pad
> > > >>               - asus,tf701t-ec-pad
> > > >>           - const: asus,transformer-ec
> > > >>
> > > >> And them schema name will match the genetic compatible.
> > > >
> > > >Then what does the generic compatible express?
> > > >
> > >
> > > Then enum it is
> >
> >
> > Why would you do that, instead of what I posted earlier in the thread?
> > If you send a flat enum with all devices listed, I'm gonna just be there
> > telling you to consolidate into one device-specific fallback compatible
> > per programming model.
>=20
> There is no one device-specific fallback compatible! Schema describes
> HARDWARE not drivers no? I will not use random device compatible from
> the list as a fallback compatible for a different random unrelated
> device, that is plain wrong.

Which is why I am not mentioning drivers at all, and instead talking about
programming models. Fallback compatibles represent similarities in
programming model, even if the laptop that these devices are contained
in are different, so whatever device compatible you pick might be random
(but going chronologically is usually my recommendation) but it won't be
unrelated.

> Discuss this with Krzysztof and come up with something meaningful please.

If you don't consider my reviews to be meaningful, you're welcome to
carry a Nacked-by: Conor Dooley <conor.dooley@microchip.com> with a link
to this discussion instead.

Thanks,
Conor.

--CFX4Gs6NaZQ9iQTz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaZSOXwAKCRB4tDGHoIJi
0lKEAQCMn1RQWiz2XuWSwPyIQrFeNcdgS1xJdgNETKYUnIvdvAD/a48ii+2SjLok
p8k8vgDRIULg8VXMLV8Zc8SI2pGg9QA=
=w/4u
-----END PGP SIGNATURE-----

--CFX4Gs6NaZQ9iQTz--
