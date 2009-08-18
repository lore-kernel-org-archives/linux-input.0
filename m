From: Eugeniy Meshcheryakov <eugen@debian.org>
Subject: Re: [PATCH] input: i8042 - add Acer Aspire 5536 to the noloop list
Date: Tue, 18 Aug 2009 18:53:26 +0200
Message-ID: <20090818165326.GA3844@localhost.localdomain>
References: <1250471002-20780-1-git-send-email-eugen@debian.org>
 <20090818055542.CB3F6526EA5@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp2.tu-cottbus.de ([141.43.99.248]:40970 "EHLO
	smtp2.tu-cottbus.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759438AbZHRQxe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Aug 2009 12:53:34 -0400
Content-Disposition: inline
In-Reply-To: <20090818055542.CB3F6526EA5@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I tried your patch and it does not fix the problem. I still need to add
i8042.noloop=3D1 to the kernel command line to be able to reenable the
touchpad. Also at this laptop touchpad is detected correctly, it only
stops working after disabling and reenabling (also once or twice it
stopped working even without pressing the disable button, this can be
related).

17 =D1=81=D0=B5=D1=80=D0=BF=D0=BD=D1=8F 2009 =D0=BE 22:24 -0700 Dmitry Toro=
khov =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=B2(-=D0=BB=D0=B0):
> On Mon, Aug 17, 2009 at 03:03:22AM +0200, Eugeniy Meshcheryakov wrote:
> > Without this patch it is not possible to reenable touchpad
> > after disabling it using disable button.
>=20
> Applied, thank you Eugeniy.
>=20
> However for 2.6.32 I am looking for more generic solution,
> could you please try the patch below (without yours applied)?
>=20
> Thanks!
>=20
> --=20
> Dmitry
>=20
> Input: i8042 - bypass AUX IRQ delivery test on laptops
>=20
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>=20
> It seems that many laptops do not fully implement AUX LOOP command
> in their keyboard controllers, causing issues with touchpad detection.
> Hovewer we know that almost every laptop/portable uses PS/2 pointing
> device and even if user disables it in favor of external mouse the
> system will not use IRQ 12 for anything else. Therefore we may bypass
> AUX IRQ delivery test when running on a laptop and assume that it is
> routed properly.
>=20
> Just to be safe we require the box to have good PNP data in order to
> bypass the test.

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkqK3IYACgkQKaC6+zmozOIEKgCfRnZBHxSlVX5Ocp2nYd1ShHsb
GtUAn26ntOEx6iAoWKqi5NodxXU/FZYv
=VpOy
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
