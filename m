From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 03/10] regulator: max77693: Use core code for charger's
 is_enabled
Date: Wed, 29 Apr 2015 12:03:07 +0100
Message-ID: <20150429110307.GG22845@sirena.org.uk>
References: <1430305114-23598-1-git-send-email-k.kozlowski.k@gmail.com>
 <1430305114-23598-4-git-send-email-k.kozlowski.k@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gGb9UerBzIviP/BQ"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1430305114-23598-4-git-send-email-k.kozlowski.k@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--gGb9UerBzIviP/BQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 29, 2015 at 07:58:28PM +0900, Krzysztof Kozlowski wrote:
> The custom implementation of 'regulator_ops.is_enabled' callback for
> charger regulator is exactly the same as regulator_is_enabled_regmap()
> with 'enable_val' set.

Applied, thanks.

--gGb9UerBzIviP/BQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVQLpqAAoJECTWi3JdVIfQoykH/3PDJ4MET0WorNjPZkn102xg
UvnE+FrKYxrpPDZYBap+Nb8uVJxoBkjlJKFZgjcGt0cEwRQhCenSBm2/nBF1M0He
9UeX057wWjel2ITIZHnCJY1oFy4CEm40tPPRZwAwZWf56/k93OjSZSA3BrM+5hQl
Xu4SJFMclfuvyYEkPisJ9hHENaY7hhVIeMdgcsR2SyV6mrySaFpWa0tTyLLy/pJH
jIXITBLJTOVUJc/S1pJOugoBF/xGX9d8FQGJRdiJxXGRf3rU3Yqgblljk/8fJK6C
kWjjCIUSMXZms75byA32AyOszYfEKHSFwm9z8UOg6MgLWB5sv2Fp6XOwP7solno=
=IsQt
-----END PGP SIGNATURE-----

--gGb9UerBzIviP/BQ--
