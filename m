From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] don't invert mightymouse hwheel
Date: Fri, 13 Apr 2007 08:45:33 +0200
Message-ID: <1176446733.7052.61.camel@johannes.berg>
References: <200704130021.l3D0LvVM008180@adara.cs.pdx.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-BoSjnRUChLWteJcS4P5V"
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


--=-BoSjnRUChLWteJcS4P5V
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-04-12 at 17:21 -0700, Barton C Massey wrote:

> After checking further I've found that my memory is correct.
> With the patch as I originally submitted it (including the
> INVERT_HWHEEL quirk):
>=20
>   1) Moving the scroll ball to the right sends positive
>      deltas (to /dev/input/event*), and moving it to the
>      left sends negative deltas.  This is the same as the
>      mouse itself, of course.
>=20
>   2) You can use an xorg.conf entry as simple as
>=20
> 	Section "InputDevice"
> 	  Identifier  "MouseMightyMouse0"
> 	  Driver      "mouse"
> 	  Option      "Device" "/dev/input/mouse1"
> 	  Option      "Dev Name" "Mitsumi Electric Apple Optical USB Mouse"
> 	EndSection
> 			=09
>   3) X SW (other than Iceweasel, which has the misfeature
>      described earlier) just works properly.
>=20
> Please don't remove the axis flip on the MM; it seems like
> something most folks, including me, are quite happy with.

Alright, I'll talk to the X folks about including an axis flip in the
evdev manpage or something. Or maybe GTK is inverting my axis... Thanks
for investigating.

johannes

--=-BoSjnRUChLWteJcS4P5V
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGHycN/ETPhpq3jKURApXcAKCrBugd0owz2GpTmZ+EDHhoHONvHACeOAzJ
NBIaco3Cd2iP2V9SBOZIn4M=
=0q7U
-----END PGP SIGNATURE-----

--=-BoSjnRUChLWteJcS4P5V--
