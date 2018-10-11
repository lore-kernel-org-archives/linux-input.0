From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] Input: elants_i2c - Use DMA safe i2c when possible
Date: Thu, 11 Oct 2018 09:29:53 +0200
Message-ID: <20181011072953.ddkemhnntjisli3q@katana>
References: <20181010200017.255874-1-swboyd@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zwog3fv4rce4k2cs"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181010200017.255874-1-swboyd@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <swboyd@chromium.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--zwog3fv4rce4k2cs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 10, 2018 at 01:00:17PM -0700, Stephen Boyd wrote:
> This irq handler is always reading bytes from the device into a
> kmalloced buffer, so it's safe to mark this transaction as DMA safe.
> This avoids bouncing the buffer when an i2c controller decides to use
> DMA for a transaction.
>=20
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

For the record:

Acked-by: Wolfram Sang <wsa@the-dreams.de>


--zwog3fv4rce4k2cs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlu+++0ACgkQFA3kzBSg
Kba4NRAAofDHd5TAtWWErJsTokqVF22brVt3tiWWsFsvaUUUoY+sWFFxW+DUp6xz
VAHE9zRD01KC0V3M4ywoi/noKZFKA3Zt4eIPzqZ0h6Jpw/X+5sFP/74jtFxjYXR3
WBOQathe6ybSo89EOTBgH4xlJexE23md9gSHFACs09HvBdE7ZPexdnvwd8sEg5V9
BiEe7cqdipdhLWMNIa2jNiqAXEXib6FpwswZ6jSzNABDOG7kyt5B7aGDpFwzGufs
rvFD1iS6y3p2EDrEvkVoG1XK0m8H6aN9dlP2FvrLlfyMbwR/J2HzdUeLCSHd1pZS
KGLYCSZNIWs7aCEE4qQt3fJCv9+ovrn/2hrYi9GwLeZg/gogOmedPaWdBd+m8dHY
03lEbEmwZL4PggTXU0S0hHi7ILwRvkP3SI5cdD6T3YLOFO1/wJerNmIr0J5EFw5f
xvax0BTFz2DwBXPGZhuj0LuVE6seSWI/qd7T+OZRhhYoWxzXZpi9qVyHS7FaJ9Y8
Dn4MXH+uleTdzrCv/s1NEHRdm7kIbuUEGzE02VgH4cgS8a3eyi2ilPBeJWHWvKte
Ylj5BWZb9rYkdCB8Y2hSL9LnCCAbC152Cy6pneHzZI/BzMfFEnqfO0Rf42Cd3kj8
JsgYig65UkDljCbWM7+hN7WGNeveZ2fGaL2NfJkDMbe5U0p+WEY=
=rC5V
-----END PGP SIGNATURE-----

--zwog3fv4rce4k2cs--
