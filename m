Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D86542803;
	Wed,  9 Sep 2026 13:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788960437; cv=none; b=Q2P5kNQV4iAbyNUuWNE5aPIdR8HH7uzTryam1v7AXnNPgRnMJCptr/nQmr9TPjmY6ffk2YIeNkrHXmbcZmGkqI101GYITstTR3a4EprJLqdPl5bhvZt4AkMyXU0FMdB7excazDvmW894k/uFP2HCn/sEQb8vtIz88MSXr8EIRHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788960437; c=relaxed/simple;
	bh=DyJDRtyrOiFKO4N22eNPlSOSoe7akPPD8qIhnTft0HE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQDa0nZ34W105AJZyb9nC38XQIiVtg2oSOSsUOzV3rM6TKwPwR8V3vLkkQydg+LIVRy9urmv9RLmiKAlo6GU5uy3c8Kubza3yK9KFNurMvAhVQN4jBb7UxQGo/vYXg80nDEVRy38GJ5Kv708JaOWaosNGnm6Czw3xLFR9YpURhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3V76u8H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3V76u8H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46EEA1F00A3D;
	Wed,  9 Sep 2026 13:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788960426;
	bh=DyJDRtyrOiFKO4N22eNPlSOSoe7akPPD8qIhnTft0HE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=d3V76u8HnL5Z9pp4wy3RQNKchXYH8Otyy77S95DJ9zdGw4fkY3ln7i9VyqIQNPugH
	 67vnvr1VdyHiYUE16sqA1edVX0+5p1B+4leYRShc4bGimTF16H6SwlccQVeQ9P1GaV
	 79EujtWYDBCd57UQY4UJO3hFLhuOu829nBfyeDhoNfF00lIbpzQsToP5DhNQk/Jl2f
	 e9rRo2eqj7UX/Uo4GA8Ug5R43G7wtrinEnnQS89I6mVMsoASHk07UlMMBfRq+INx0E
	 OV/UNTkewM0lYvKt1pPC5ua5XkuZk5vuX+YrEydfVZXlcoT+fZ98HTlxzyhVI0RNwe
	 +DGHfUWQ6orHQ==
Date: Wed, 9 Sep 2026 14:26:56 +0100
From: Mark Brown <broonie@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Lee Jones <lee@kernel.org>, mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Arnd Bergmann <arnd@arndb.de>, Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Support Opensource <support.opensource@diasemi.com>,
	Sebastian Reichel <sre@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org, linux-media@vger.kernel.org,
	devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
	patches@opensource.cirrus.com, linux-watchdog@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
	linux-fbdev@vger.kernel.org, linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, llvm@lists.linux.dev
Subject: Re: [PATCH 11/14] mfd: remove unused wm8350 driver
Message-ID: <64ddded6-e140-4bdd-9a66-ebaed56e000a@sirena.org.uk>
References: <20260909132153.1596191-1-arnd@kernel.org>
 <20260909132153.1596191-12-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OTZg4QPdZD4DW1fD"
Content-Disposition: inline
In-Reply-To: <20260909132153.1596191-12-arnd@kernel.org>
X-Cookie: Postage will be paid by addressee.


--OTZg4QPdZD4DW1fD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 09, 2026 at 03:21:48PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> This driver was used on the i.MX31 ADS reference board from Freescale
> and the smdk6410 reference board from Samsung. Both used platform_data
> based driver probing and are now gone from the kernel.
>=20
> Since probing with devicetree has never been supported by wm8350,
> it is clear that nothing can use the driver on an upstream kernel,
> and it is unlikely that anyone is still interested in a devicetree
> conversion, so remove it.

Acked-by: Mark Brown <broonie@kernel.org>

--OTZg4QPdZD4DW1fD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqhXp8ACgkQJNaLcl1U
h9A07Af+LjyYi8M0LVR+2guh7aV8ps1LJA/pBB1O0OjpYy1QtH9cEK6q9ImsQnRT
0OPXYfJXJnrnuoai+hsB2yjzWOVjtPoJx6g9H4vKQTyS2Od6ZegQLMuRIVgMXBiq
7Q9Wi/uOmPQmoVG3JpsWWCbl1HIHHaT/bzPDUIRW+DfdETAzm41UjqD7/+q+M/oW
sZ01BjqHwsbUixQGGxH5ZHxohPrcBx/q87mgegdQ3LOXXFdIblVJEBC7bYcolvyo
h/HDLlK7wy4//jPZ0Q40odTi4mfgG994PZSxCT/8HJQgcyCHVjOV0F+12N+zKyTd
Im9GhJ9X2G4I9k7BipiAnpgrzM3Ohg==
=v3Pm
-----END PGP SIGNATURE-----

--OTZg4QPdZD4DW1fD--
