From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] Input: tegra-kbc - Fix possible NULL derefrence.
Date: Fri, 27 Jan 2017 11:54:25 +0100
Message-ID: <20170127105425.GA15295@ulmo.ba.sec>
References: <CGME20170127104250epcas1p4cf918f7e98f557ae65136f027f7556f1@epcas1p4.samsung.com>
 <1485513756-1854-1-git-send-email-shailendra.v@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1485513756-1854-1-git-send-email-shailendra.v@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shailendra Verma <shailendra.v@samsung.com>
Cc: Rakesh Iyer <riyer@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, linux-input@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, p.shailesh@samsung.com, ashish.kalra@samsung.com, Shailendra Verma <shailendra.capricorn@gmail.com>, vidushi.koul@samsung.com
List-Id: linux-input@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 27, 2017 at 04:12:36PM +0530, Shailendra Verma wrote:
> of_match_device could return NULL, and so cause a NULL pointer
> dereference later.
>=20
> Signed-off-by: Shailendra Verma <shailendra.v@samsung.com>
> ---
>  drivers/input/keyboard/tegra-kbc.c |    5 +++++
>  1 file changed, 5 insertions(+)

I think that's rather pointless. The driver is OF-only, so the only way
it will bind to a device is if the device's compatible matches one of
the entries in the tegra_kbc_of_match table, in which case match will
never be NULL.

Thierry

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAliLJt8ACgkQ3SOs138+
s6HaCRAAsaBVQOlSSCr5GLPvlE5tVHaX4bjwdpd5lCaLfAzdgpSByyfXNAxFfb3K
bxBPODWBwkLa0pNeI/mY1aUeKCf92O/LJJcKLdKd7Dvt4aLXkOCdWHwzWLNMGNn5
aDz+W55KdBRsGhQdETBSnt+YYfeA/bZpc1kvnaPRcrU+qTpKX7LTOkEsxZKxT8pF
qf2fHz1N4RPTPFdwAv7w4P/j5ZDsA5tJFe//ND6iJcDGKFg4Y44cUB07jIN2zstX
yPNyoGSvcWbrzj052nmyqjWzor9k+YMfrbQPhjsHbaQVOpJnkFQ3jcJXOXnIoRHX
zKAk3pJIZQxo+Qzt0T3pHiJyXjkTJIVVuZY6UhYs0THWIZ6/f74dO54HCpJ89irz
mflxzAYkNM+E/ujnQb7dQSjWmfnn9YOnI+V1bmEL11Tzzjhbx1XgeUWZcRiLgdPi
ZslsLx8BYarbMzPizgCxEH9U/PK7xH8lqjY7P9jL1bS2tzqfUsEpFOWgqag0FzZp
phvCZPDgYvOLU9ZL57CP9zecxF9hyenaPeoCCLeeu3swNRjeS/tI7gxmg74N+F7T
7y212gNNrtq3wyOFGD0qFKo4f5M/8AP69JYlKuPPCuJDwQRDpyuRJvur0SQP0WVm
fj5q+8VAmXNopUSJBtkEKcnlEsmqGjgj1wTEcP343BEokgpIuqw=
=UKTl
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
