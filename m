From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [rfd] saving old mice -- button glitching/debouncing
Date: Sat, 15 Dec 2018 11:29:02 +0100
Message-ID: <20181215102902.GA8022@amd>
References: <20181214232437.GA8310@amd>
 <20181215085510.GB12930@suse.com>
 <20181215094722.GA5804@amd>
 <20181215101221.GA23879@suse.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181215101221.GA23879@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, jikos@suse.cz, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
List-Id: linux-input@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat 2018-12-15 11:12:21, Vojtech Pavlik wrote:
> On Sat, Dec 15, 2018 at 10:47:22AM +0100, Pavel Machek wrote:
>=20
> > > > b) would it be acceptable if done properly? (cmd line option to
> > > > enable, avoiding duplicate/wrong events?)
> > >=20
> > > Well, for one, you shouldn't be using a timer, all the debouncing can=
 be
> > > done by math on the event timestamps.
> >=20
> > Not... really, right? You need to send an release some time after
> > button indicates release if bounce did not happen. It is similar to
> > autorepeat needing a timer.
>=20
> You can send the first release and ignore all presses and releases in a
> time window after that.

I could, and it would work for glitches on release, but that would do
very bad things if switch glitched on press, right?

"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XX           " ->
"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX              " ... ok

"XX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX..." ->
"XX                                  ..." ... bad idea. [Maybe could be
detected with "XX " being unusually short?]

But I believe I see=20

"XXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXX" on X220 device, too.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwU124ACgkQMOfwapXb+vKR/wCfcFxBeIlqKrMEK9h9TYHkH4ZF
ZbkAn0Eksq6l5ksxYC9/ryTMmsG8X9MF
=8YL4
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
