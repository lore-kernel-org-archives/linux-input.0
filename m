From: Guus Sliepen <guus@sliepen.org>
Subject: Re: [RFC v2] Another approach to IR
Date: Thu, 3 Dec 2009 20:47:36 +0100
Message-ID: <20091203194736.GM2970@sliepen.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="e1+sTVyxRliB/aPL"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 234-166.surfsnel.dsl.internl.net ([145.99.166.234]:26803 "EHLO
	sliepen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751412AbZLCT6A (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 3 Dec 2009 14:58:00 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: linux-input@vger.kernel.org


--e1+sTVyxRliB/aPL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

Some years ago I wrote a tool called "inputlirc" that translates evdev even=
ts
into LIRC events, to allow remotes that then already used the input system =
to
work with LIRC.  At the time, lircd itself could do this, but you had to
"train" it to "decode" evdev bitstreams. Instead, inputlirc uses a fixed
mapping between evdev names and LIRC key names, so you don't need to train =
or
configure anything.

It seems that if you want to merge LIRC into the kernel, and have it genera=
te
standard events, then inputlirc can be used to provide backwards compatibil=
ity
to those applications that only work with LIRC, or that rely on LIRC specif=
ic
behaviour (such as mode switching).

Debian package:  http://packages.debian.org/inputlirc
Git repository:  http://git.sliepen.org/inputlirc/

--=20
Met vriendelijke groet / with kind regards,
      Guus Sliepen <guus@sliepen.org>

--e1+sTVyxRliB/aPL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAksYFdgACgkQAxLow12M2nvPYwCgkU1VnQ8N7op1ASEWD3u/rzmY
/HQAnjkYCiC1VQGr8S6eYf6L1EF3Opuc
=sVAy
-----END PGP SIGNATURE-----

--e1+sTVyxRliB/aPL--
