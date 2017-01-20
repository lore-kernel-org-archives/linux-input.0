From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 2/2] Input: tca8418 - switch to using generic device
 properties
Date: Fri, 20 Jan 2017 08:09:28 +0100
Message-ID: <20170120070928.7ciuuw7jwhxorqlb@lukather>
References: <20170119224803.10713-1-dmitry.torokhov@gmail.com>
 <20170119224803.10713-2-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nsgwz7cnlxqucl52"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170119224803.10713-2-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Vladimir Zapolskiy <vz@mleia.com>, Sylvain Lemieux <slemieux.tyco@gmail.com>
List-Id: linux-input@vger.kernel.org


--nsgwz7cnlxqucl52
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 19, 2017 at 02:48:03PM -0800, Dmitry Torokhov wrote:
> Let's drop legacy platform data support (there are no users in mainline)
> and switch to using generic device properties, which will make the driver
> simpler (non-OF boards can use property sets to describe hardware).
>=20
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--nsgwz7cnlxqucl52
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYgbekAAoJEBx+YmzsjxAgZeIP/i0wpW71tVCI0YwjlDx9iN01
BOYAkN/ux9yxd6Dk9rTVytxi1gBCDDySI46ZxJQ8ctHxXhrif8GHO5h3WMlfYtBp
2chtpQZKw9p5FRI5a2p3xNg1/VW5PEr06aXyJNQRN/IHGQh0JFiNCCmiuEOBoK/F
hSLAWNAQhJSlO+MRqfOGB38Y8MPPYB9Rs3ukw19Ssm/V+yHwD6/zxtW8rxM3I2sQ
XeAzffyLr98AJn3YjHjYRYykGSb0htdmzUY3ndtqm80/IvfVPRhdjacybLbjVcan
j/5UQToaTInurm8rq6ZCBVeJIxJfQKYdATfHI90YGJ9z0DL3/qBaEbsO/tZu2AA9
QBQ8WN5bdvcgnQfghxqCpffpVqK1o8uNyT4Ysr53rPNS2aZWQ8nstx4ZaYqv2StV
/+4WIZQN7f9DXmBjOBibV9vUA7rJ+EnaC7WsJGqIWInqpMNTwSVy9MASzVswbbZc
Rxpr+QVIMMgeqEbwoI48QZ9azJdRqy30LL0L+jGtKo84gslWUGGCcSkTc2FRscyK
MV8yvp6dYQv0ubwHgsa/9gbLATrNZ60maUpKe1LaJIa8lbE66+PnoWukaznRWrhv
iN3iZNgEMGTvA+ggki8xyD1J5hGB4ea6CsLfZGcRkc3vz0d/szqOSrW2jY4TRRJ8
YA/Gr0Sd3tWTZOtSyoDC
=8Lve
-----END PGP SIGNATURE-----

--nsgwz7cnlxqucl52--
