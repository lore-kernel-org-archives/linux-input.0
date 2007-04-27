From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: bug in evdev_disconnect
Date: Fri, 27 Apr 2007 21:58:10 +0200
Message-ID: <1177703890.3565.49.camel@johannes.berg>
References: <1177683991.3565.8.camel@johannes.berg>
	 <d120d5000704271207t3b86d32fu88f438fe3efbc612@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-laRZnb3AVWW0ng1Zi7Qi"
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <d120d5000704271207t3b86d32fu88f438fe3efbc612@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input <linux-input@atrey.karlin.mff.cuni.cz>
List-Id: linux-input@vger.kernel.org


--=-laRZnb3AVWW0ng1Zi7Qi
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

> Please try -mm, it should be fixed there. As a temporary work wround
> you can also swap list_for_each() and wake_up_interruptible() in
> evdev_disconnect().

Alright, thanks!

johannes

--=-laRZnb3AVWW0ng1Zi7Qi
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGMlXS/ETPhpq3jKURAru+AJ0VBih8nlSpA0wCONgYOfNp7E+tnQCgi2YR
gfdmYtB9tOd0lSQUTn/8+yY=
=Y6Ed
-----END PGP SIGNATURE-----

--=-laRZnb3AVWW0ng1Zi7Qi--
