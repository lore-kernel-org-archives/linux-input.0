From: Jan Kiszka <jan.kiszka@web.de>
Subject: Re: Sensitivity of Synaptics pointing stick
Date: Sat, 16 Feb 2008 10:29:49 +0100
Message-ID: <47B6AD0D.5060109@web.de>
References: <47B486B5.8070202@web.de> <fp4tbt$6km$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig750CAD25A121E052F693E1F5"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fmmailgate02.web.de ([217.72.192.227]:34640 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752426AbYBPJaU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 16 Feb 2008 04:30:20 -0500
In-Reply-To: <fp4tbt$6km$1@ger.gmane.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Baryshkov <dbaryshkov@gmail.com>
Cc: linux-input@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig750CAD25A121E052F693E1F5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Dmitry Baryshkov wrote:
> Hi, Jan,
>=20
> Jan Kiszka wrote:
>=20
>> Hi,
>>
>> it looks like I have a Synaptics pointing stick on my Lifebook E8110,
>> connected as PS/2 pass-through device via a Synaptics touchpad. It
>> works, but it is horribly insensitive, making me crack my fingers
>> regularly. Is anyone aware of a way to tune the sensitivity of this
>> device (like one can do with Thinkpad trackpoints)?
>>
>=20
> It's strange, because I have the same laptop and both touch pad and tou=
ch
> stick are working very well. Try setting MinSpeed, MaxSpeed, AccelFacto=
r
> and TrackstickSpeed parameters.

It doesn't like me: I do not see any impact. Could you send me your
XF11Config to crosscheck?

TIA,
Jan


--------------enig750CAD25A121E052F693E1F5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHtq0qniDOoMHTA+kRAi0AAKCBLJSFHGNYHxXc2rXpzalkMoGpMgCfcEDX
sQAFvuxzfO5UJus+BTRi1kE=
=pNEw
-----END PGP SIGNATURE-----

--------------enig750CAD25A121E052F693E1F5--
