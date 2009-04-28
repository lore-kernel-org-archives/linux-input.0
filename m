From: Niels de Vos <niels.devos@wincor-nixdorf.com>
Subject: Re: [PATCH] input: Document the bcm5974 driver
Date: Tue, 28 Apr 2009 13:49:40 +0200
Message-ID: <49F6ED54.7040200@wincor-nixdorf.com>
References: <1240916817-18995-1-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2EECE7D1B2EAF52641D020BF"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760507AbZD1LyQ@vger.kernel.org>
In-Reply-To: <1240916817-18995-1-git-send-email-rydberg@euromail.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2EECE7D1B2EAF52641D020BF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Henrik,

Henrik Rydberg wrote:
> This patch adds documentation for the bcm5974 to Documentation/input/.
>=20
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> ---
=2E..
> +Debug output
> +------------
> +
> +To ease the development for new hardware version, verbose packet outpu=
t can
> +be switched on with the debug kernel module parameter. The range [1-9]=

> +yields different levels of verbosity. Example (as root):
> +
> +rmmod bcm5974 && sudo modprobe bcm5974 debug=3D9
> +
> +tail -f /var/log/debug
> +
> +rmmod bcm5974 && sudo modprobe bcm5974 debug=3D0

What about skipping rmmod and modprobe by doing
	echo -n 9 > /sys/module/bcm5974/parameters/debug
and
	echo -n 0 > /sys/module/bcm5974/parameters/debug
?

Kind regards,
Niels



--------------enig2EECE7D1B2EAF52641D020BF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFJ9u1U5KAkGQPO/QoRAqnIAKCV/5dqEhWrqiVbIsgjA1H2WgbLqQCgvJwo
dwPVB1xUngT7fFAso9TBK0k=
=KxUs
-----END PGP SIGNATURE-----

--------------enig2EECE7D1B2EAF52641D020BF--
