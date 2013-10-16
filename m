From: =?UTF-8?B?S2FpIFdhc3NlcmLDpGNo?= <kai@dev.carbon-project.org>
Subject: Logitech G710+ unusable without quirk/driver
Date: Wed, 16 Oct 2013 16:50:04 +0200
Message-ID: <525EA79C.7070802@dev.carbon-project.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="cfjJJGLMXmlvj2DKIXmSNw6c1cJ7UtHKm"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from blackmesa.kw-serverwartung.de ([78.46.90.79]:58987 "EHLO
	blackmesa.kw-serverwartung.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752234Ab3JPO5Z (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Oct 2013 10:57:25 -0400
Received: from localhost (localhost [127.0.0.1])
	by blackmesa.kw-serverwartung.de (Postfix) with ESMTP id 9F9367B8082
	for <linux-input@vger.kernel.org>; Wed, 16 Oct 2013 14:50:16 +0000 (UTC)
Received: from blackmesa.kw-serverwartung.de ([127.0.0.1])
	by localhost (blackmesa.kw-serverwartung.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id smkczHgi8-Wg for <linux-input@vger.kernel.org>;
	Wed, 16 Oct 2013 14:50:14 +0000 (UTC)
Received: from [192.168.178.20] (p4FDF5059.dip0.t-ipconnect.de [79.223.80.89])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by blackmesa.kw-serverwartung.de (Postfix) with ESMTPSA id 5D2717B8081
	for <linux-input@vger.kernel.org>; Wed, 16 Oct 2013 14:50:14 +0000 (UTC)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cfjJJGLMXmlvj2DKIXmSNw6c1cJ7UtHKm
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

[Please CC me on all replys, I'm not subscribed to this list.]

Dear Kernel Devs,
I recently tried to use a Logitech G710+ (because of the nice mechanical =
keys)
with Linux, which is, outside of X (evdev seems to filter this), not poss=
ible.
The keyboard spams =E2=80=9E6=E2=80=9C to the console. Some searching yie=
lded, that this is a
known problem and based on that information it seems like the problem is,=
 that
the device sends some key down events during initilisation but no key up =
event.

This means I can't use the device during boot, as I'm unable to enter the=

passphrase for my encrypted filesystem. Or later, the non-graphical inter=
face.

There is an out-of-tree driver
(<https://github.com/Wattos/logitech-g710-linux-driver>) which works for =
the
non-graphical interface; I haven't managed to convince my initrd to prope=
rly
load the driver, even though it is included. The author tried to get feed=
back
from this list, but didn't receive an answer
<http://article.gmane.org/gmane.linux.kernel.input/30258>, but maybe that=
's a
starting point for getting something working into the kernel.

Is there some kind of quirk flag that can be set during boot, that would =
make
the keyboard at least usable (obviously without the macro keys, but those=
 aren't
that important to me, so that'd be fine)?

Thank you in advance for fixing this issue!

Kind regards,
Kai Wasserb=C3=A4ch


--cfjJJGLMXmlvj2DKIXmSNw6c1cJ7UtHKm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQGcBAEBCgAGBQJSXqehAAoJEKMJ12zh3lnSzTUL/jt3/bFYuC6xJE9lFwVmCNPV
+hh7NBJQkQVeGr5DzH98rbeufKTZpynE/dwR4rA2iYDHxlzO8szl14P+Jz8aSgGb
WTUcnkUmuoe/72QQZ7CBtIPlnYil7aBvwMU7cea4M9WzDR3SphPxtvktYGUHDcqd
qWCPtEW6YLXosEXuInUgrGgelji2TqcMVjai23FRoQUYGV120iVRm3pKcrwNpKCq
pR1djmCNzLMM07UETcsrNcDvbZhHYukXtJXD70I2++wxTEMIAuDOYJ000RzzGRl+
gC3MFspvqKwdT1gyWiNPTGffP1IJfGTbRW2m2zH2dlX0upTvi+gl+2L3JNO7pvLQ
FE40ZE6Urxwz7FRfH6hx0zB0eDJuMjVhWYJN4GZsx1WSaCOKeV9yGVq6x5ZcuVVU
4E0vNuXtRpQcmWuVUBx2DjcJ+GZgVCR0IR+3jjoBms6ALIHYBVkGX0IFLt6p7hEy
J2G1RrqUm3GESGH3v8/WKGW0pjQB91S4SU2geeZKiw==
=cjtq
-----END PGP SIGNATURE-----

--cfjJJGLMXmlvj2DKIXmSNw6c1cJ7UtHKm--
