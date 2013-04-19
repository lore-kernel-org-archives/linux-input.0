From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 3.9-rc7
Date: Fri, 19 Apr 2013 08:56:03 -0700
Message-ID: <20130419155603.GA23436@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:56678 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752146Ab3DSP4I (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Apr 2013 11:56:08 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
or
	master.kernel.org:/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive 2 more small fixups to the wacom driver.

Changelog:
---------

Ping Cheng (2):
      Input: wacom - DTH2242 Grip Pen id was off by one bit
      Input: wacom - fix "can not retrieve extra class descriptor" for DTH2=
242


Diffstat:
--------

 drivers/input/tablet/wacom_wac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--=20
Dmitry


--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)

iQIcBAEBAgAGBQJRcWkTAAoJEH70+W8r6ZYqezkP/jK4+S134n3iLgrPF8JzYIaV
e8PSRet8EMpz4Ystoufezj7ITNaI70N55Rf8KpfHRwtMrf5n8bJxf71saZjAFaMv
30fX1jUfktgOw0PspIhX4vjV+XL+PH/SXlcelVZEWHLzduFs0VBUZKN3Ng3jDOOc
W9i3ZUyLdTxmW3gKteamIbQ2LScXSslsavpg6MYUGmPFIlw15Lu+orB5pxvOGKCY
vf1wx3UK7zkVc6BZuRyHnEuItXUkF8mTynwOsuQsJFysB16m0m47+vadw3KLtbwa
bj+VqYTYpdzcU+TwT/hUPzQqMJ5fvns1JUNQ4h06825HHHnLmVLROnroeOcLe3Fl
oGChLNKk2urPZHeAiFbyPHTKFbHHt56ipmjT9e0UFAqpR/GcwASR/9vSkmwotXpF
bV7uGtjE8mqtLPENzxN+VeYmywt8MAe7jupDVFGwImD0PKseO534othZ3NbRlxT6
jnrxK5gfnk7Ll1L3Zw+pBCEjgIOwyAMbe0ru+R+KcpjT0os+d8fNKy/QoIivB6QK
zGIzYSmQyObdJnmGpQhwa4pvkM704Hu2Axqr4JHYHJ74euVUOpDYBDDZiTjf6GVl
J922ispmLi5kkJewg3PPKLSbgKTpAk+tD4dKOph0/KSf1pTOEl28eWEIcB78usLM
5nlYlJSgXkkYG+9S88OI
=bFwq
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
