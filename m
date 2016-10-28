From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2 06/10] regulator: da9061: BUCK and LDO regulator driver
Date: Fri, 28 Oct 2016 18:59:18 +0100
Message-ID: <20161028175918.tb4ntnelofse7kjf@sirena.org.uk>
References: <cover.1477501000.git.stwiss.opensource@diasemi.com>
 <c8529abdbe8a07ac0d7b09ab24fad73ab56116be.1477501000.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7qsjzthrt7pfq7qy"
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <c8529abdbe8a07ac0d7b09ab24fad73ab56116be.1477501000.git.stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Cc: LINUX-KERNEL <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, DEVICETREE <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, LINUX-INPUT <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUX-PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUX-WATCHDOG <linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Support Opensource <support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org


--7qsjzthrt7pfq7qy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 26, 2016 at 05:56:38PM +0100, Steve Twiss wrote:
> From: Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
>=20
> Regulator support for the DA9061 is added into the DA9062 regulator drive=
r.
> =20
> The regulators for DA9061 differ from those of DA9062.
> A new DA9061 enumeration list for the LDOs and Bucks supported by this
> device is added. Regulator information added: the old regulator
> information for DA9062 is renamed from local_regulator_info[] to
> local_da9062_regulator_info[] and a new array is added to support
> local_da9061_regulator_info[].

Acked-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

--7qsjzthrt7pfq7qy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYE5H2AAoJECTWi3JdVIfQVxkH/jkLzUk7fRE29zqArap+RyWE
pjNSKx51EbFFtj84+HxyQAaVq8gEh9g2X6SGh/fBGb752qyYwdJPIGCS/+2eMVZO
OpIT3J2jF/Ur4WR7+zm8Uwfe0uXj+xLEI8Se0kZa23Bwmrz0ghLb57SODoGlLDma
rXqe7rNpQg9N5wovZGsg/Jc8j1M4bwzSyPmJRVAfDlQ4rt16+DshORLaZtfRE//Q
QHmxZzMOeC1CngeAZBqfI3CH1YOPvG2xn7ghu4LWDRiK48sZMVCT25c9SuPF5cow
UGXwTUGCRWOSNcJeW4/PDpVikEKo/Y91QY+6hCk4jLzhM+kniMh5IRk8nH72tBM=
=Ad0J
-----END PGP SIGNATURE-----

--7qsjzthrt7pfq7qy--
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
