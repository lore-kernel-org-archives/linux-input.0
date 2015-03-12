From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v3 0/4] input: ft5x06: Fix userspace reported maximum
 value
Date: Thu, 12 Mar 2015 15:30:31 +0100
Message-ID: <20150312143031.GA13382@pengutronix.de>
References: <1425390646-31196-1-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35408 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753897AbbCLOak (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 12 Mar 2015 10:30:40 -0400
Content-Disposition: inline
In-Reply-To: <1425390646-31196-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Lothar =?utf-8?Q?Wa=C3=9Fmann?= <LW@KARO-electronics.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Maxime,

On Tue, Mar 03, 2015 at 02:50:42PM +0100, Maxime Ripard wrote:
> Hi,
>=20
> The current ft5x06 reports to the user-space that its maximum
> coordinates are, on both X and Y, way higher than what could be
> actually usable on the screen (in my case, 5759x1151 instead of
> 480x800).
>=20
> This causes trouble on some userspace stacks that then try to re-scale
> these coordinates back to the framebuffer resolution, like QT does.
>=20
> Use the of_touchscreen code to find the real touchscreen limits in the
> DT case, and report that to the userspace.

Thanks for sending it again. This series works for me on imx6q with an
edt-ft5x06 touchscreen.

Tested-by: Markus Pargmann <mpa@pengutronix.de>

Best Regards,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVAaMHAAoJEEpcgKtcEGQQheYP+gJsVCeiRJt7zo5Dscy3FkuP
XdmdbvTWwo4J83orhYtpKd2XG2Un8q7fGxE1G+xBn3Hnhg15ST0AyjrR/lAet1mI
FihZK75xkm0bVH2fenP+QPOt0SLuh0Kfl6wpsW5yCRdps2N/3YT6r3XBsGiWMIIA
wde/PsJDUiEswGwhhDrmKpLBrFMwXlNvTP+aXVbuZ+LGPWKE+6U+xo21k3B/dupE
BQ2/cF5wWnPQp4C5y1oT5IU5pZClnvoKQWhvDYysy7egyOLxHtR/bChKL9g8x46K
1UrvyS4ffq4viYFo12ysqO4pZnTDS5bapIq6uZDyzrqkBchelmeasOLSFNfOftrt
JKOeSlQUKtoNUaf1RAuEtMzu2au3jnhXHJI/1gPg9rCSR72r7Gy0GlnINhV8pVnL
dGKgpR+eC3qMGvlh7ZkUFvTGKC0HnNWE7lMjfonKuOVr16YJY6lJ4ebwXczxznE/
kE197mEnPBYQmjlXsCNqkVtFJsbnKzmwKrPhO/9WthagOT4tbE+8GVNRL5Jc8jWu
72S4PTJgxO70vgkN5G75/tfpa7JeiufNFJ3NP5sfxmOTV7uiUmkxYQH0w5rgSSUW
DNVluCN19UQOyERd+eIWvJouJP18iUdEr/Fk+oSfkGKzZom5xK0k9x1njjl4vpwn
CJTsuAsSiJ8V/hPNg18E
=eM3z
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
