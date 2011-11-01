From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: Sony DualShock3 - Detected but no events
Date: Tue, 1 Nov 2011 09:06:45 +0100
Message-ID: <20111101090645.0d3abeac5909f87dae8bec58@studenti.unina.it>
References: <CAOazyz0GNJKFWNsaFiwheMjhBVJrcP-p8QBcsSvS3V97iuZFtQ@mail.gmail.com>
	<20111101011854.5e0e87b561f6b18dcc09a988@studenti.unina.it>
	<CAOazyz1EfHdg4gExfeVaQ_8mMV=1Tu-aYBTEo_j4MjLnNC4kHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__1_Nov_2011_09_06_45_+0100_YmL_ZzTsCZWH2DOy"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp209.alice.it ([82.57.200.105]:42995 "EHLO smtp209.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751940Ab1KAIG7 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 1 Nov 2011 04:06:59 -0400
In-Reply-To: <CAOazyz1EfHdg4gExfeVaQ_8mMV=1Tu-aYBTEo_j4MjLnNC4kHA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alon Bar-Lev <alon.barlev@gmail.com>
Cc: linux-input@vger.kernel.org

--Signature=_Tue__1_Nov_2011_09_06_45_+0100_YmL_ZzTsCZWH2DOy
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 1 Nov 2011 02:31:54 +0200
Alon Bar-Lev <alon.barlev@gmail.com> wrote:

> Hello Antonio,
>

Please try to avoid top-posting.

> Thank you so much for your reply!
> Unfortunately within the mbox there are no attachments, so I cannot
> proceed and patch my bluez.
>

But there are links to patches and instructions on how to get them and
apply them.

> In the mean while I would like first to see it work with plain USB,
> which should be much simpler, no?
> If you connect the device to the USB port, does it work? Do yo see
> activity when you do cat /dev/input/js0?
>

You need to press the PS button to make the device start sending input
events. To see events you can use 'jstest' on the jsX device node or
'evtest' on the eventX device node.

If this does not work either we can investigate further.

> At Windows the following[1] drivers are working correctly in USB and
> bluetooth....
>=20
> Thanks!
> Alon.
>=20
> [1] http://www.motioninjoy.com/download
>=20

Regards,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Tue__1_Nov_2011_09_06_45_+0100_YmL_ZzTsCZWH2DOy
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk6vqJUACgkQ5xr2akVTsAFxyQCeOAwFUdogNeQCPaghtR2j72fL
GG8An3SSASvi3CvKJKOHPXzwfxWKdoVx
=9ohu
-----END PGP SIGNATURE-----

--Signature=_Tue__1_Nov_2011_09_06_45_+0100_YmL_ZzTsCZWH2DOy--
