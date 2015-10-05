From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 03/17] input: tegra-kbc: drop use of IRQF_NO_SUSPEND flag
Date: Mon, 5 Oct 2015 07:44:37 +0200
Message-ID: <20151005054437.GA30219@ulmo>
References: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
 <1442850433-5903-4-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1442850433-5903-4-git-send-email-sudeep.holla@arm.com>
Sender: linux-pm-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Laxman Dewangan <ldewangan@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, linux-input@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2015 at 04:46:59PM +0100, Sudeep Holla wrote:
> The driver handles wakeup irq correctly using device_init_wakeup and
> enable_irq_wake. There's no need to use IRQF_NO_SUSPEND while registering
> the interrupt.
>=20
> This patch removes the use of IRQF_NO_SUSPEND flag.
>=20
> Cc: Laxman Dewangan <ldewangan@nvidia.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: linux-input@vger.kernel.org
> Cc: linux-tegra@vger.kernel.org
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/input/keyboard/tegra-kbc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWEg5CAAoJEN0jrNd/PrOhm+oP/1Rz10pjJd96H5ykorFq+JNi
dU6QymIjSEVuuox09KycGn+AQswuOlZyOPADlMKhFyDosD5XfxlHSy8U7xXdd0CF
H6qXH7MZbnGCH/Aed0SxfI6lsYQSyRfdBI0soKIIqIDJTlIdEgecH6q2GQRF0d//
PPhiJdUkEwQZVem2+igAVMHbU29ZfqAsiK7i3BWOlyI21Rh0EJz5GBOcLxBnCYvI
d5Og4I2YasrzpCwa+vWos38n47X2iFc4yZBKIXHKWUI6LizIEtszNs9tPqmVt1n7
zwQvacqyxpVQF2ytkd5JigEIaiqpjDN/xw7pSoPA9TlMjU9dUM0L59aH3N2Wcspq
sXBtIEVu87Cz+uGnnLw1o7SnyP2VhFf+kmXJ0jbBIkSNhHjAkQB5ZH9a7/9AUmkM
PC+dcIanX0ROs7PjpsnZiEm1F4Y0pUQOhMUL1NhBnBeCJPc++Ex9ohYeMtPu/BEE
b1fi91GiJo4nQZ3pdN7EG8t2UfZdyxLlqXGzWe+eOKkTJ7zne3lFMXUIXq1GcIxO
1A/TyYoSKqSANQQt3C9fWHMZzFm+guwHXIupajT0R94w0W+pNmhtNYE/zM0AvAVy
jChCxFct1zQN2NGTM1Ba+2pZ9NJGNFaL9nY8Jrb1C5HSlDUTyUOE72qyHerkpL46
2eGvht14ppSY4Rbq0i1j
=VScf
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
