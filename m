From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v3 0/4] input: ft5x06: Fix userspace reported maximum
 value
Date: Mon, 23 Mar 2015 17:10:02 -0700
Message-ID: <20150324001002.GJ15676@lukather>
References: <1425390646-31196-1-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NgG1H2o5aFKkgPy/"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1425390646-31196-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>
Cc: linux-input@vger.kernel.org, Markus Pargmann <mpa@pengutronix.de>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--NgG1H2o5aFKkgPy/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Lothar, Dmitry,

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

Do you have any comments on that?

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--NgG1H2o5aFKkgPy/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVEKtaAAoJEBx+YmzsjxAgjBkP/jqgi0tfcWCS0MVrJHH65t41
vhi0nZ9zVqoA0ubEd8wht7QQFNB8BKxq2W1mpraOuhfO18DTS+QlGda8ql2m6KoH
BUFOxOsB35+qT3oMFLmW2kCnObQPlUoFWCo5h5yGXvrluKeBCYhmmpUQ/1wbKSs9
UvtGFZDGV4X8JUPhnZLsIIKyZ21s7usNZjne89h1spQRKz0TZZnkvWTmSmF75yXn
4DOQp4sWJOULnYjHv4JDL9xqGczi1Phc/kWjLN0fihkXhCKNLyGjAuA9dJyM7q/Q
RX2QHSgETcRVU7B6iHsTBtJpjLugwc66UbeGn7df60gzQ9y/9jAYe9X6s4SSbY/F
2PpZ2eGZBeKK8CmtSq9mhywno83qcWnZGgiupYLMBJ6SRzBSwok+IqmsKaer0BDn
EpzVZSMPFCFSQJgUpdgSDK7SaFpxSmTJk/pC3VWbkctsQc+iw6s9Yk0S7a/iGc9l
0EvZEOMiHSk3F38o+nyt9nBZwhseraIgYHARNKl+LlKJ/8dzLUs9gi9vTJ3SIS7b
0Y6Cbf7O+xDX6DLKY8IwB7PH5UvRvGdDpxkzJ0u3mzyxKLds0DW1jNm7ay09Vyjc
0qzmcyGsdweWEVLJnMQHa/mGxDyfVLEMx436dxd+aBn7e+D38eGyXDZNNz3RmWCF
+xwqi9THm4qCekqqS2EH
=6dn2
-----END PGP SIGNATURE-----

--NgG1H2o5aFKkgPy/--
