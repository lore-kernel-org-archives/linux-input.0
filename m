From: =?ISO-8859-15?Q?Thomas_B=E4chler?= <thomas@archlinux.org>
Subject: Re: [PATCH] input: alps: Add support for the touchpad of the Toshiba
 Tecra A11-11L
Date: Tue, 09 Mar 2010 20:30:22 +0100
Message-ID: <4B96A1CE.50706@archlinux.org>
References: <1268160967-21403-1-git-send-email-thomas@archlinux.org> <20100309190135.GB28000@core.coreip.homeip.net> <4B969EAE.3030903@archlinux.org> <20100309192634.GC28000@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------enigD70D87CEB2796C8D801B559A"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gerolde.archlinux.org ([66.211.214.132]:52897 "EHLO
	archlinux.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756092Ab0CITaZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Mar 2010 14:30:25 -0500
In-Reply-To: <20100309192634.GC28000@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD70D87CEB2796C8D801B559A
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Am 09.03.2010 20:26, schrieb Dmitry Torokhov:
>> The model I have here does have a trackpoint, thus I put ALPS_DUALPOIN=
T
>> in. Also, I had problems without ALPS_PS2_INTERLEAVED ([...] lost sync=

>> at byte 1). I did not try without ALPS_PASS though, only with.
>>
>=20
> No, ALPS_PASS is OK - you would notice right away if you didn't need it=

> - the device would not switch to absolute mode.
>=20
>> The device does not seem to have an external PS/2 port, but there is a=

>> connector for a docking station (which I don't own).
>>
>=20
> Ah, I see.
> =20
>> I am more concerned about the two 0xff values here, because they are
>> actually guesses.
>>
>=20
> If you do not see it loosing sync as you workign it then you selected
> proper byte0 and mask.

Good. In this case I guess you can apply the patch as it is. After
applying this, would you mind sending this to linux-stable as well?


--------------enigD70D87CEB2796C8D801B559A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEAREIAAYFAkuWoc4ACgkQEda5KzHP/VAmXgCguxApeUrzIi76ZJoyuWto4lv7
Ru8AoInHqI/EXqX/X/dX3uMvE1X0G2Fe
=6Z44
-----END PGP SIGNATURE-----

--------------enigD70D87CEB2796C8D801B559A--
