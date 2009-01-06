From: Niels de Vos <niels.devos@wincor-nixdorf.com>
Subject: Support special keys on laptop by default?
Date: Tue, 06 Jan 2009 14:14:51 +0100
Message-ID: <4963594B.9040705@wincor-nixdorf.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA22C93980D1008BADA243EA9"
Return-path: <linux-laptop-owner@vger.kernel.org>
Sender: linux-laptop-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-laptop@vger.kernel.org
List-Id: linux-input@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA22C93980D1008BADA243EA9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,

on my HP/Compaq nc6400 there are three keys (info, presentation and
battery) not directly recognized. If I press any of the keys, I get:

atkbd.c: Unknown key released (translated set 2, code 0xd9 on isa0060/ser=
io0).
atkbd.c: Use 'setkeycodes e059 <keycode>' to make it known.

I would like to have these keys mapped by default to the
corresponding defines in <linux/input.h>. Of course using the
command as suggested would function, but that does not help other
owners of this laptop. Moreover, other keys seem to be supported
without requiring extra manual configuration.

Where should I start looking for creating a patch for solving
problems of this kind? There seem to be quirks in atkbd.c, but
I think they are used for some other workarounds.

Thanks for any pointers,
Niels



--------------enigA22C93980D1008BADA243EA9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFJY1lL5KAkGQPO/QoRAouTAKCNomnOhoaSTOj5l6Ogo/qOF53fnwCglWYl
gWQkB7HrwSChGuyXqwPturo=
=Et4W
-----END PGP SIGNATURE-----

--------------enigA22C93980D1008BADA243EA9--
