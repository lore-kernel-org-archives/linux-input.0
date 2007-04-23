From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] don't invert mightymouse hwheel
Date: Mon, 23 Apr 2007 15:43:38 +0200
Message-ID: <1177335818.3528.8.camel@johannes.berg>
References: <Pine.LNX.4.64.0704130940190.19492@jikos.suse.cz>
	 <200704130021.l3D0LvVM008180@adara.cs.pdx.edu>
	 <200704231027.l3NAR5tA019325@murzim.cs.pdx.edu>
	 <Pine.LNX.4.64.0704231508490.5138@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-PNnV+2znOnbH/H4+3aer"
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.64.0704231508490.5138@jikos.suse.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Jiri Kosina <jkosina@suse.cz>
Cc: Barton C Massey <bart@cs.pdx.edu>, linux-input <linux-input@atrey.karlin.mff.cuni.cz>, "Antonio-M. Corbi Bellot" <antonio.corbi@ua.es>
List-Id: linux-input@vger.kernel.org


--=-PNnV+2znOnbH/H4+3aer
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-04-23 at 15:13 +0200, Jiri Kosina wrote:

> This is strange, I have a bugreport in our bugzilla which states that BT=20
> version of the mightymouse needs the very same quirk as USB version.=20
> Recent kernels contain a duplication of the USB quirk for Bluetooth=20
> version of the mouse, in order to make the scrollwheel work. But=20
> 2.6.20.4+bluez patches don't provide this quirk yet.

Same problem I had maybe with X or GTK or something flipping the axis?

johannes

--=-PNnV+2znOnbH/H4+3aer
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGLLgK/ETPhpq3jKURApzpAJ9pde5tdyepkNaD65/+1T2qZVhFvgCeMfdk
gUvfG9QHZuQwUGvdSKSz5fg=
=kuWm
-----END PGP SIGNATURE-----

--=-PNnV+2znOnbH/H4+3aer--
