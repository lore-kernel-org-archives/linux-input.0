From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] don't invert mightymouse hwheel
Date: Fri, 13 Apr 2007 08:40:18 +0200
Message-ID: <1176446418.7052.54.camel@johannes.berg>
References: <Pine.LNX.4.64.0704121800000.19492@jikos.suse.cz>
	 <1176330232.27324.7.camel@johannes.berg>
	 <200704122125.l3CLP9aQ005277@wezen.cs.pdx.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-KKCCsRAGeNjnKu1YlFhb"
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200704122125.l3CLP9aQ005277@wezen.cs.pdx.edu>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Barton C Massey <bart@cs.pdx.edu>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@atrey.karlin.mff.cuni.cz>, "Antonio-M. Corbi Bellot" <antonio.corbi@ua.es>
List-Id: linux-input@vger.kernel.org


--=-KKCCsRAGeNjnKu1YlFhb
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-04-12 at 14:25 -0700, Barton C Massey wrote:

> > I unfortunately don't have the hardware in question to test with. This =
X=20
> > configuration is of course perfectly valid.

I copied it straight out of the manpage so I'd hope so :>

> Give me a day or so to check all this out.  I don't think
> looking at the X behavior is too useful: too many place that
> the direction can be swapped.  Instead, look which way the
> bits coming directly out of evdev point.

I can do that (early next week), but I don't have any other devices to
test with. Can provide a dump.

> IIRC I set things
> up so that positive X was the same as on other evdev
> devices.  Is the supplied X config swapping the X axis with
> this line?
>=20
>   > >         Option      "evBits"            "+1-2"

No idea! I just copied it out of the manpage from evdev(4)

> One possible source of confusion is that Iceweasel scrolls
> backward by default (on all devices, not just MM).  You can
> fix this by changing a setting in the Iceweasel config.

I didn't use Iceweasel but GTK.

johannes

--=-KKCCsRAGeNjnKu1YlFhb
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGHyXS/ETPhpq3jKURAva/AJ9CBAUsLUFaSW2I9VF9PBJwOjzFxQCguqWO
hKrqzzc6mKJyeXCa85uPFQ8=
=Y3cC
-----END PGP SIGNATURE-----

--=-KKCCsRAGeNjnKu1YlFhb--
