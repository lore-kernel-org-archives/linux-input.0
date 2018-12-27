From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v5] Input: i8042 add i8042_is_mr_coffee() helper to avoid
 refconut leak
Date: Thu, 27 Dec 2018 23:43:44 +0100
Message-ID: <20181227224344.GA14925@amd>
References: <20181215090846.28009-1-tiny.windzz@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181215090846.28009-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yangtao Li <tiny.windzz@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat 2018-12-15 04:08:46, Yangtao Li wrote:
> of_find_node_by_path() acquires a reference to the node returned by
> it and that reference needs to be dropped by its caller. Add
> i8042_is_mr_coffee() helper to avoid refconut leak.

refconut->refcount, here and in subject.
									Pavel
								=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwlVaAACgkQMOfwapXb+vJW6ACglv83GBoZjn75uotdQD6f3hnl
5BYAoJLsyWJzzj1seB/gV5vIYKvKW+gC
=fzg6
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
