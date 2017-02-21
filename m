From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 3/3] Input: tsc2007 - add a property
 "ti,report-resistance" to restore the old pressure reporting state if
 needed.
Date: Tue, 21 Feb 2017 18:19:49 +0100
Message-ID: <20170221171949.5nexrvezlybjbrcs@earth>
References: <cover.1487609795.git.hns@goldelico.com>
 <991a09fb874c07b03c21a5b38ebade187134539d.1487609795.git.hns@goldelico.com>
 <20170221110708.GA5021@amd>
 <FE6FEEC7-65B8-4C20-9C15-C641A8A8E4CA@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mnfd3tca7b2lomog"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753907AbdBURTy (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 21 Feb 2017 12:19:54 -0500
Content-Disposition: inline
In-Reply-To: <FE6FEEC7-65B8-4C20-9C15-C641A8A8E4CA@goldelico.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Pavel Machek <pavel@ucw.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan Cameron <jic23@kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org


--mnfd3tca7b2lomog
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 21, 2017 at 12:43:28PM +0100, H. Nikolaus Schaller wrote:
> > Am 21.02.2017 um 12:07 schrieb Pavel Machek <pavel@ucw.cz>:
> > On Mon 2017-02-20 17:56:36, H. Nikolaus Schaller wrote:
> >> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> >=20
> > No. device tree is for hardware description, not kernel configuration.
>=20
> Yes, I agree. A new Kernel CONFIG would be better in this case.
> I just did copy&paste from the old patch set without thinking that far.
>=20
> Would
>=20
> CONFIG_TSC2007_REPORT_RAW_RESISTANCE_AS_PRESSURE
>=20
> be ok?

I guess either a CONFIG or a module parameter may be used to provide
the previous (broken) behaviour. I suggest to ignore the problem
until its reported, though. There is a high chance, that nobody will
notice the change at all / nobody needs the compat layer.

-- Sebastian

--mnfd3tca7b2lomog
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlisdrUACgkQ2O7X88g7
+pphjw//VOdUBtYjrn8pF2MlVoaTmOSnM+ab0ImKyTkE2Jp5Y5+rBQl4gi7K+5wh
QMV0rhXLGPIP2xK0KUI39dJPhgrCfTTkv08KeOiFoNtMjzkoQ14Y3pNYoW7TEVxP
06OK+EmhmP/JS0kdLthdqMT/7xOIS2N5hbNiF5b96K6VbhtFIAtl3eKtcN/Z08OE
dZbA5gwDHygTxYAyMgBAhqiLwimOY/1Ys4epCDdDSbM+lVqNDEbHCfnB+ooWMWxh
aHbrbd82yY/JPjofo9h+znNK+v/fbTX/EuH8/rANuU78JtT7Yfvw4Xdm973+svwk
b1Qb8Sz1m58cfj4usuOqzFudnoZv98Rvfx5VE76wagE1smYfuJAQqSy62JKgKln/
92ApwuwQ6WW3Ldjn1Y0miVtmk4QOhdZe/y5L+8ZgrqovSs6oSxT2fHoSREnxTc1M
0PzbwlmPha5Xv9RWXgqiGgaNOKsMNmt3uAdwKD4UfDzN3gRd6E0Y2We7nvdP2vPa
K0zRS3C2YTD3P5B9HU3Yy7dcXz6C84ouTsDLpu4vsNjoVw/Fpx3rJvRURluPZg4/
d1MFYWHVcWJL88ukrwkQfnjWXXUA1i+WZN/OToXVIRsF+JRLzTxb9trV7SR4tL+v
czstLmbj9Px3BAVV6mFZd+dRZWDGZqFrjo2FkRmts7wpZyWt5Jg=
=A27J
-----END PGP SIGNATURE-----

--mnfd3tca7b2lomog--
