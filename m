From: Ondrej Zajicek <santiago@crfreenet.org>
Subject: BUG in sermouse driver
Date: Mon, 10 Mar 2008 10:30:39 +0100
Message-ID: <20080310093039.GA26118@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.kolej.mff.cuni.cz ([78.128.192.10]:54542 "EHLO
	smtp1.kolej.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404AbYCJKN6 (ORCPT
	<RFC822;linux-input@vger.kernel.org>);
	Mon, 10 Mar 2008 06:13:58 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello

There is a bug in sermouse driver that inputattach program terminates
during suspend (or resume) to ram hence mouse does not work afer
resume. When i execute inputattach after resume, the mouse is
working.


strace from inputattach:

> ...
> select(4, [3], NULL, NULL, {0, 100000}) =3D 1 (in [3], left {0, 93000})
> read(3, "\t", 1)                        =3D 1
> select(4, [3], NULL, NULL, {0, 100000}) =3D 0 (Timeout)
> ioctl(3, TIOCSETD, [2])                 =3D 0
> ioctl(3, SPIOCSTYPE or VTXIOCGETINFO, 0xbfb28c84) =3D 0
> read(3, NULL, 0)                        =3D 0
> ^^^^^^ here it is blocked before i start STR
>=20
> ioctl(3, TIOCSETD, [0])                 =3D 0
> close(3)                                =3D 0
> exit_group(0)                           =3D ?


inputattach is just sleeping on last read(), which is not supposed
to return, but it returns during STR.


--=20
Elen sila lumenn' omentielvo

Ondrej 'SanTiago' Zajicek (email: santiago@crfreenet.org, jabber: santiago@=
njs.netlab.cz)
OpenPGP encrypted e-mails preferred (KeyID 0x11DEADC3, wwwkeys.pgp.net)
"To err is human -- to blame it on a computer is even more so."

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iEYEARECAAYFAkfU/78ACgkQw1GB2RHercNnyACfTh+jahBQlbyU1IiQnBTb3/q6
uj0An05e15l5xIRBHsqf7/RsJ3XU3XHG
=d2TN
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
