From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] don't invert mightymouse hwheel
Date: Fri, 13 Apr 2007 11:30:16 +0200
Message-ID: <1176456617.7052.100.camel@johannes.berg>
References: <200704130021.l3D0LvVM008180@adara.cs.pdx.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-OH5b4928rF7iBHmfoBHu"
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200704130021.l3D0LvVM008180@adara.cs.pdx.edu>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Barton C Massey <bart@cs.pdx.edu>
Cc: linux-input <linux-input@atrey.karlin.mff.cuni.cz>, "Antonio-M. Corbi Bellot" <antonio.corbi@ua.es>, Jiri Kosina <jkosina@suse.cz>
List-Id: linux-input@vger.kernel.org


--=-OH5b4928rF7iBHmfoBHu
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-04-12 at 17:21 -0700, Barton C Massey wrote:

>   1) Moving the scroll ball to the right sends positive
>      deltas (to /dev/input/event*), and moving it to the
>      left sends negative deltas.  This is the same as the
>      mouse itself, of course.

My regular mouse sends positive deltas on "move finger up". That means
with positive right too we'd have a coordinate system rooted at the
lower left of the screen which makes sense. I better fix my X config
then :)

johannes

--=-OH5b4928rF7iBHmfoBHu
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGH02o/ETPhpq3jKURAnCRAJ4mQMN6nbSQ6BoRqw2YFBxhXkosmQCfYO3I
xMDLXm3R74MgbTAsmhLSX7A=
=hvXr
-----END PGP SIGNATURE-----

--=-OH5b4928rF7iBHmfoBHu--
