From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 3/7] Input: pwm-beeper - use input_set_capability()
Date: Fri, 20 Jan 2017 11:12:32 +0100
Message-ID: <20170120101232.GC3824@ulmo.ba.sec>
References: <20170119224057.9995-1-dmitry.torokhov@gmail.com>
 <20170119224057.9995-3-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5QAgd0e35j3NYeGe"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170119224057.9995-3-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, David Lechner <david@lechnology.com>, Frieder Schrempf <frieder.schrempf@exceet.de>
List-Id: linux-input@vger.kernel.org


--5QAgd0e35j3NYeGe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 19, 2017 at 02:40:53PM -0800, Dmitry Torokhov wrote:
> Instead of manipulating capability bits directly, let's use
> input_set_capability() API.
>=20
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/misc/pwm-beeper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Thierry Reding <thierry.reding@gmail.com>

--5QAgd0e35j3NYeGe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAliB4pAACgkQ3SOs138+
s6GByg/+PJ1PknpT4oXUPL9OvkQJOkWMTPOgYw9xNAOHzSG0EQUbhcpYlnttGylZ
3oPB+ZDErdxGAoVn9HH/9Nj2ZmLc5CFFNoa2IhdOApo2ZKkkfUBNuvr3OdP3U0k9
WvCyoFEfraVQhUBgxToNrqdVWg4zoZx70CoZnzlXS1Py+CZJtSZrwUm3LzNaTQDJ
vbEJ6Xk5PoEwTOG1IzkBUo4j91Rq2308Bhpp827LtRHGmHD6jiXWA2UeBoP9OA1R
ATZ8dJtTShuwZ9CAtd+vuxP4qvYDewjbkdaRkX3M4WNPRCAgMwiR8nl+Zr5aOvD1
9OPo3VjSkyzfgDI0N+Yx896Zmxqtusrp3xsqygxby2gv1hV9ynnZ+DEKeADVpz97
9dUDnMSHMU+/WPU8UQkgToHwYuZ2yZFPpT1hjWpCr5ZfGAq7qyNbXICms2pP18Tl
SemBCRXef5koInmA20Bp6Byd5tIVt1xgGvDPtm+MqcBmSr1n4ed4/ob26ubLcdk8
4Y7O1J+tFxy/Z2mQ8IeXiM5T14Zfk0JXFNszmD9qEUQUm+ZBygatdOLDDFTbOxRr
Md4fRK/MKCxphe4v9MvpbtZhuEq4vj1mNtBhxCwzxwoi1XG9MVfbS0Gt9A5F+dao
YN8npAo0QvD1gOJBrkxolTEjQ573J/YgU9AeaDFMdIEA+dRiITo=
=1hJ4
-----END PGP SIGNATURE-----

--5QAgd0e35j3NYeGe--
