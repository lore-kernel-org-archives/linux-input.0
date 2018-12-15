From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [rfd] saving old mice -- button glitching/debouncing
Date: Sat, 15 Dec 2018 10:47:22 +0100
Message-ID: <20181215094722.GA5804@amd>
References: <20181214232437.GA8310@amd>
 <20181215085510.GB12930@suse.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181215085510.GB12930@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, jikos@suse.cz, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
List-Id: linux-input@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Patch is obviously not ready; but:
> >=20
> > a) would it be useful to people
>=20
> Probably not.
>=20
> Mice already do internal software/hardware debouncing on switches. If you
> see duplicate clicks making it all the way to the kernel driver, something
> is very wrong with the switch, to the point where it'll soon fail
> completely.

It seems mice normally survive 2 years under my use. This one has left
button repaired and middle button failing... If debouncing gives it
one more year, it will be success...

> > b) would it be acceptable if done properly? (cmd line option to
> > enable, avoiding duplicate/wrong events?)
>=20
> Well, for one, you shouldn't be using a timer, all the debouncing can be
> done by math on the event timestamps.

Not... really, right? You need to send an release some time after
button indicates release if bounce did not happen. It is similar to
autorepeat needing a timer.

Let me gain some experience with the patch. I don't think hardware
does as heavy debouncing as you describe.

Best regards,
								=09
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwUzaoACgkQMOfwapXb+vKp9wCgwJowBaO003wnM519XYW0uBW0
4h0An1zQelskdUkoRGIrsQXR1Qg06TwI
=4Co/
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
