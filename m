From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Input: tegra-kbc: fix inverted reset logic
Date: Tue, 16 Aug 2016 12:26:02 +0200
Message-ID: <20160816102602.GA4564@ulmo.ba.sec>
References: <1471316363-19378-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1471316363-19378-1-git-send-email-yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Rakesh Iyer <riyer-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 16, 2016 at 11:59:23AM +0900, Masahiro Yamada wrote:
> Commit fe6b0dfaba68 ("Input: tegra-kbc - use reset framework")
> accidentally converted _deassert to _assert, so there is no code
> to wake up this hardware.
>=20
> Fixes: fe6b0dfaba68 ("Input: tegra-kbc - use reset framework")
> Signed-off-by: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
> ---
>=20
>  drivers/input/keyboard/tegra-kbc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Nice catch!

Acked-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXsuo2AAoJEN0jrNd/PrOhOH4QAMMOMjvcIwUDopQfWayJMMkg
7T7hSl8e30q4NokUG6ROSbZ9onV1thnATFJp25MqXhdWZTz1h7bLEs6o09wKwpoR
pphJ230O8+hIWGdI6XfIimD8T0NfloGl3KUUYjboXmM1kWzEQZpDY5CHDbjlvZkx
U/musA2Q2Edp7HilvgyJU7qgL2YsAbUURVxtX1ikPDg75lXatOHVAXck8ESH+8h/
NbZP2GIXH3mWX+8Uqnavpp0/JC92u0VbsHoYdQdswj5GDgvPot2eP2pHk1hETKuq
ZsB9cSCOJfdjFkBMi+bGyYhSqKsEfEQejAFn9EKe1Iai3ufH94baXWRWGGVVYFy4
XvYhgbzwc4/5yasiKfaZJ4BBMivvfK0lMLWm3XqhYJilFyRf76Uor47gF5/q6ckm
0Z5bASopfWspNQIM/uDNCjUomoq1YimQHTVNeimQ7pKuphtHaKnsL7Snf8h2BrAx
b/HtSei4qb+KS5BEG6id9EwwbZYNr5NweAB1Ke5FvgYeH10bd9QMDXMOhubEIbiW
do3awF0xTfW5a/alcJEngZTf4ROro92b4qwdh4irmW+YYKRHoMzF94TtsOGvXMp0
NimYaC5NJ3OJw6VKfVGFsP9DZNmcKu1PWMhc6G4B2m99dPOo0bLlBWr1hPBaNUIt
F7CVyoMoKsTgBRz8rgYQ
=fz1E
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
