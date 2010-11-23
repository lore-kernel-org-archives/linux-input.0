From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [RESEND] - HID: add support for force feedback in
 'Thrustmaster  F430 Force Feedback' steering wheel
Date: Tue, 23 Nov 2010 22:01:05 +0100
Message-ID: <20101123220105.92db4832.ospite@studenti.unina.it>
References: <ece69dfce015de7cc10b9c0257af3627.squirrel@host171.canaca.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__23_Nov_2010_22_01_05_+0100_9UA1mtSOC66WYXTO"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp204.alice.it ([82.57.200.100]:59186 "EHLO smtp204.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750787Ab0KWVBU (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Nov 2010 16:01:20 -0500
In-Reply-To: <ece69dfce015de7cc10b9c0257af3627.squirrel@host171.canaca.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org
Cc: linux-input@vger.kernel.org, Antonio Orefice <aorefice77@gmail.com>

--Signature=_Tue__23_Nov_2010_22_01_05_+0100_9UA1mtSOC66WYXTO
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Nov 2010 15:21:05 -0500
simon@mungewell.org wrote:

> Doesn't look like this was picked up by anybody... at least there was no
> 'ack'.
>=20

missing [PATCH] prefix (maybe [PATCH v2] ot v3 for the next round?), and
it was sent as attachment, while this list prefers patches in
the email body, with out-of-patch comments after the '---' separator.

> On behalf of Antonio, please find attached a git-ized version of the patc=
h.
>

The commit short description is too long, limit it to 72 chars, and if
needed add a longer description in the commit message body.

Also the Signed-off-by line is missing, if you are the author, then it
would need your sign off Simon, if Antonio Orefice is the author, then
use his, with no need of the Reported-by.

The procedure may look tedious but the collaboration is based all on
that, and on the other hand if you have interest to have the
patch submitted, you have the motivation to conform to it; check out
Documentation/SubmittingPatches in the kernel dir.

> This just add the USB ID's. Builds OK against Linus' git tree, but I don't
> have the wheel to test.
>=20
> Cheers,
> Simon Wood.
> http://www.speed-dreams.org

Regards,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Tue__23_Nov_2010_22_01_05_+0100_9UA1mtSOC66WYXTO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkzsK5EACgkQ5xr2akVTsAGz5QCeIXKwAsr6N4w7jJKYUVqpHGzX
3woAoINcYaiI6k+RaVyH20QGAhLAmIWg
=7tEJ
-----END PGP SIGNATURE-----

--Signature=_Tue__23_Nov_2010_22_01_05_+0100_9UA1mtSOC66WYXTO--
