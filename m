From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/4] Input: pmic8xxx-keypad - use regmap_field for
 register access
Date: Wed, 8 Oct 2014 21:04:26 +0100
Message-ID: <20141008200426.GJ4609@sirena.org.uk>
References: <1412675448-11990-1-git-send-email-iivanov@mm-sol.com>
 <1412675448-11990-3-git-send-email-iivanov@mm-sol.com>
 <20141007172606.GG16469@dtor-ws>
 <1412759584.13569.0.camel@iivanov-dev>
 <1412760633.13569.4.camel@iivanov-dev>
 <54357BA7.3010609@codeaurora.org>
 <20141008181314.GC14423@dtor-ws>
 <5435808A.7070203@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CGHixilj3wKyHuKx"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5435808A.7070203@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, "Ivan T. Ivanov" <iivanov@mm-sol.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--CGHixilj3wKyHuKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 08, 2014 at 11:20:58AM -0700, Stephen Boyd wrote:
> On 10/08/2014 11:13 AM, Dmitry Torokhov wrote:

> >>>Oops. struct regmap_field is opaque. It seems that the allocation
> >>>is the only way that I could have instance of it.

> >>Maybe we can add an API to allocate an array of fields?

> >Maybe we could make the structure public instead? I do not see any
> >reason for allocating something separately that has exactly the same
> >lifetime as owning structure.

The lifetime may be different to that of the register map it references,
consider MFD function devices for example. =20

> Srini/Mark, any reason why the regmap_field structure is opaque?

So you can't peer into it and rely on the contents.  I can see it being
useful to add a bulk allocator.

--CGHixilj3wKyHuKx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUNZjKAAoJECTWi3JdVIfQklAIAIWndulU7qAJcLIM/bVSsrr7
h+zA4I/YFmLd4EaFInElYVYB7pLLX0r9gPJRx9i3bitTxjMqGlqdhIQSt8fFvFvg
0+XKb2q81IIE1IHyVsxzw9zET24jOihlrAKIWx8cM6UbSTUCrlfGmCl3wdY0QsJR
4Vm1hN6li8/h0TimhrZSUwUjDrhJCK1qe/eWpBksLDHBMlef9FpFPBnPhdA8lzK5
Db3KuCwF9GHXMSlqQ+FJTyHCVMrdY/SnKXhVubTLOCLi3UYEPRm5x/VysM2s9kAo
5ruNuHOAs2RKt3uyYy421oFknE9043OY0/jNve1CM7/CU2d82Y7kB1kCIMzQM8M=
=8C/E
-----END PGP SIGNATURE-----

--CGHixilj3wKyHuKx--
