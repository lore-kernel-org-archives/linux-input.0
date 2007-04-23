From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] don't invert mightymouse hwheel
Date: Mon, 23 Apr 2007 16:13:07 +0200
Message-ID: <1177337588.3528.12.camel@johannes.berg>
References: <Pine.LNX.4.64.0704130940190.19492@jikos.suse.cz>
	 <200704130021.l3D0LvVM008180@adara.cs.pdx.edu>
	 <200704231027.l3NAR5tA019325@murzim.cs.pdx.edu>
	 <Pine.LNX.4.64.0704231508490.5138@jikos.suse.cz>
	 <1177335818.3528.8.camel@johannes.berg>
	 <Pine.LNX.4.64.0704231555570.5138@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-iplk6wUj3IxKVkgOskr/"
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.64.0704231555570.5138@jikos.suse.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Jiri Kosina <jkosina@suse.cz>
Cc: Barton C Massey <bart@cs.pdx.edu>, linux-input <linux-input@atrey.karlin.mff.cuni.cz>, "Antonio-M. Corbi Bellot" <antonio.corbi@ua.es>
List-Id: linux-input@vger.kernel.org


--=-iplk6wUj3IxKVkgOskr/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-04-23 at 16:07 +0200, Jiri Kosina wrote:

> no, that's not the case, the bugreport states that scrolling the wheel=20
> produces no input events at all, i.e. mapping of HID_GD_Z to REL_HWHEEL=20
> (HID_QUIRK_MIGHTYMOUSE quirk) is needed.

Good point, strange. Well, that remapping doesn't hurt if it never
reports HID_GD_Z. Maybe OSX does it and they produced too version, I
could try to find out...

johannes

--=-iplk6wUj3IxKVkgOskr/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGLL7z/ETPhpq3jKURAiygAJ934wRewdkvBx0Pfh6GItWrQqrYHwCeJsIN
JHJGZm1GoKUXgck+ppsMQEI=
=JJbl
-----END PGP SIGNATURE-----

--=-iplk6wUj3IxKVkgOskr/--
