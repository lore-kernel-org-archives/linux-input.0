From: Nikola Ciprich <nikola.ciprich@linuxbox.cz>
Subject: 4.10 regression: d79e141c1c6ea7cb70c169971d522b88c8d5b419 breaks
 PS/2 barcode readers
Date: Sat, 10 Feb 2018 19:04:11 +0100
Message-ID: <20180210180411.GC16967@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="f0KYrhQ4vYSV2aJu"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gwu.lbox.cz ([62.245.111.132]:51414 "EHLO gwu.lbox.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751087AbeBJSEP (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 10 Feb 2018 13:04:15 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: nikola.ciprich@linuxbox.cz, dmitry.torokhov@gmail.com


--f0KYrhQ4vYSV2aJu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

after switching to 4.14 from 4.4 we noticed LS2208 PS/2 barcode stopped
working for us (on Lenovo desktops equipped with USB keyboards). If I plug
PS/2 keyboard, reader works.. (it's cable works as PS/2 splitter).

Digging deeper into this, I noticed kernel stopped probing PS/2 ports direc=
tly,
which seems to be caused by d79e141c1c6ea7cb70c169971d522b88c8d5b419,
reverting=20

+               if (x86_platform.legacy.i8042 !=3D
+                               X86_LEGACY_I8042_EXPECTED_PRESENT)
+                       return -ENODEV;

part makes reader working again (without PS/2 keyboard plugged), as well
as using i8042.nopnp.

My question is, what might best solution for that be? Could this be
solved by some quirk? I haven't found any similar to get some idea..

If I could provide some more details, please let me know..

BR

nik

--=20
-------------------------------------
Ing. Nikola CIPRICH
LinuxBox.cz, s.r.o.
28. rijna 168, 709 00 Ostrava

tel.:   +420 591 166 214
fax:    +420 596 621 273
mobil:  +420 777 093 799

www.linuxbox.cz

mobil servis: +420 737 238 656
email servis: servis@linuxbox.cz
-------------------------------------

--f0KYrhQ4vYSV2aJu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlp/NBsACgkQ3xdJJrLygV6pngCdEkhZ9reMW81R0arfMS/XcnLB
LUIAoNEZzbmqa9zph3yMghdIDbfxgl16
=WFt8
-----END PGP SIGNATURE-----

--f0KYrhQ4vYSV2aJu--
