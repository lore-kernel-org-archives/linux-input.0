From: Hanno =?UTF-8?B?QsO2Y2s=?= <hanno@hboeck.de>
Subject: Unknown ALPS device
Date: Thu, 27 Feb 2014 16:46:25 +0100
Message-ID: <20140227164625.5e8da800@hboeck.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512; protocol="application/pgp-signature"; boundary="=_zucker.schokokeks.org-10559-1393516011-0001-2"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from zucker.schokokeks.org ([178.63.68.96]:37171 "EHLO
	zucker.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753617AbaB0Pvx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 27 Feb 2014 10:51:53 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_zucker.schokokeks.org-10559-1393516011-0001-2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

I have an IBM Thinkpad T61 laptop and dmesg shows me this:
psmouse serio2: alps: Unknown ALPS touchpad: E7=3D10 00 64, EC=3D10 00 64

Now the touchpad works, but this message sounds like it'd make sense to
add it to the table in alps.c (?).

I'd gladly assist if this would improve anything.

cu,
--=20
Hanno B=C3=B6ck
http://hboeck.de/

mail/jabber: hanno@hboeck.de
GPG: BBB51E42

--=_zucker.schokokeks.org-10559-1393516011-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJTD13RAAoJEKWIAHK7tR5Cd6cQAMK7OFKwjuzeLT2VHWLW88mA
N/2yOL6nsxi2vxCQIflCmychJYaocJXUyruy7AL8OqpcZ7Cjrta0MYLExAZ6MgNE
QWyGbwr2lNEQZ7VNs6JleO0fbG1hCVdmUvD8D5WP4LMhtAcl6zJUuL+ntkbYOJyM
/Yfj1y6Kzvdc1gPRGzkCUWTEEWAD3MeE+tpsPriesmGVYwf/XuyfL3kQHbPCYOr9
snuZNmRyTGfi/d/ricjcwiRI0+cNnAfSgqAzRKexMaEX1iHVTudW33yqBmIEz2oB
+pcJGmcB+4kMBkhcOStRHkEQwe+B+zeE+jDGbiBw34sPNqAZI1CvGHUEV9j4KcEA
EcsZjMbBr2D1HqLa+Jd+iqYQuioJ2RBrpA0a+9eSzVuWorznjKMeP0ISjeHOZgsM
A1xR4mgwYlqHcJx9dG97bOHklfDqw5nDT+im+Gi0zi07+byT5ZIP0kQegxJIlwx2
sgArx9cQJih2i0u3Fhi5qaRq94CQdqG3Hcx8odGEfFi3oweffC3FZR923GYFORt1
CCvDs8QswFssXvTen1Fj6P8/cM0xir0LmB61S+bunUIipHW3ojPfRojlZZIhsoYv
78U9D2pz0CTbG5s3EyyUU5NXdLlPssLxOsGJzLjxl7VaiX/6oO+3ccwT6s6mJV/3
3sToWrLtFLw5Ip1Xq5Yu
=4eO3
-----END PGP SIGNATURE-----

--=_zucker.schokokeks.org-10559-1393516011-0001-2--
