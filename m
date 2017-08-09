From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v9 03/12] regulator: rk808: Add regulator driver for RK805
Date: Wed, 9 Aug 2017 12:42:38 +0100
Message-ID: <20170809114238.3vy47z3acztggrq7@sirena.org.uk>
References: <1502273060-12201-1-git-send-email-chenjh@rock-chips.com>
 <1502273060-12201-4-git-send-email-chenjh@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gzkhzlwjlirtvidg"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1502273060-12201-4-git-send-email-chenjh@rock-chips.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Joseph Chen <chenjh@rock-chips.com>
Cc: gnurou@gmail.com, linus.walleij@linaro.org, dmitry.torokhov@gmail.com, huangtao@rock-chips.com, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, zhangqing@rock-chips.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, lgirdwood@gmail.com, linux-rockchip@lists.infradead.org, wdc@rock-chips.com, tony.xie@rock-chips.com, linux-input@vger.kernel.org, mark.rutland@arm.com, w.egorov@phytec.de
List-Id: linux-input@vger.kernel.org


--gzkhzlwjlirtvidg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 09, 2017 at 06:04:11PM +0800, Joseph Chen wrote:
> From: Elaine Zhang <zhangqing@rock-chips.com>
>=20
> Add support for the rk805 regulator. The regulator module consists
> of 4 DCDCs, 3 LDOs.
>=20
> The output voltages are configurable and are meant to supply power
> to the main processor and other components.
>=20
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> Signed-off-by: Joseph Chen <chenjh@rock-chips.com>
> Acked-by: Mark Brown <broonie@kernel.org>

Can we please at least get the first couple of patches merged so
anything else that needs the new defines like this can get merged?  If
there's later bits of the series that need this many revisions they
shouldn't be holding up the earlier bits that have been fine for ages.

--gzkhzlwjlirtvidg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmK9S4ACgkQJNaLcl1U
h9B8Swf/YDUfGLkEhHNlHD8c6DCFKplu7o85jgVJ9CsHXjrKf86aEDpTB+dZlz89
1Os2lxXaA2f74C2w57TphWiD8zKQajfLpH9BiTL9DFg4RdiU+2GWlMO1sF7vXwMp
oZ7a1+smYvt8+qyNSTSe564cbPso75Q2xVviaFz86osxBilGVE3aY+btgcus0znQ
dTWdk8I8syjhSs74pK617uwqr9+83MxVmQ/W7T6fqQTGU16nt+P9fK1zVh3wRvG2
d5tweLF8CxeIzd3sIZ1RoYFRSsC1O7ggn6XQ3c/KiYoBSDpOkGfeS5IIhCSMv0W6
F0jehN3jSRhaHRybzzvBFC1f1GbXPw==
=+N7x
-----END PGP SIGNATURE-----

--gzkhzlwjlirtvidg--
