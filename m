From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] Input: atkbd: Fix release quirk for Dell models
Date: Thu, 9 Apr 2015 19:00:50 +0200
Message-ID: <201504091900.50338@pali>
References: <1427639779-27377-1-git-send-email-pali.rohar@gmail.com> <201504082254.20875@pali> <20150409165719.GC35815@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1878527.aAYYB5jQWL";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150409165719.GC35815@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

--nextPart1878527.aAYYB5jQWL
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thursday 09 April 2015 18:57:19 Dmitry Torokhov wrote:
> On Wed, Apr 08, 2015 at 10:54:20PM +0200, Pali Roh=C3=A1r wrote:
> > On Monday 06 April 2015 18:20:56 Dmitry Torokhov wrote:
> > > On Mon, Apr 06, 2015 at 10:06:10AM +0200, Pali Roh=C3=A1r wrote:
> > >=20
> > >
> > > Ah, indeed. Sorry, at this time I completely forgot that
> > > we are controlling this from userspace nowadays.
> > >
> > >=20
> > >
> > >=20
> > >
> > > No, this is not a kernel regression because it would mean
> > > that your laptop worked properly with then current kernel
> > > and then stopped working. Given that the change went in
> > > in 2008 and your laptop is a bit newer than that you
> > > can't claim kernel regression here; as far as I can see
> > > the change was reasonable for the lineage we had back
> > > then, or at least noone notified us for about 6 years.
> > >
> > >=20
> > >
> > > So please do adjust udev rules, there are quite a bit for
> > > tweaks for Dell and other manufacturer's laptop keyboards
> > > there).
> > >
> > >=20
> > >
> > > Thanks.
> >
> >=20
> >
> > Ok, thanks for information. Maybe you can add some comment
> > to  source code or documentation, that this part of code is
> > now handled by userspace. So other people send patches to
> > correct place/projects in future.
>=20
> Fair enough. How about below?
>=20
> Thanks.
>=20
> --=20
> Dmitry
>=20
> Input: atkbd - document "no new force-release quirks" policy
>=20
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>=20
> To save people some time let's document that we do not want
> new quirks for "force-release" keys in the kernel and that
> they should patch userspace (udev) instead.
>=20
> Suggested-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---

Looks good for me.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1878527.aAYYB5jQWL
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlUmsEIACgkQi/DJPQPkQ1Jj4ACgxPS16Mhw/SECAUK3o8R9t7fV
sZYAoI+hTVPZa8ESLh/E2NUnZNkokeK6
=3+W5
-----END PGP SIGNATURE-----

--nextPart1878527.aAYYB5jQWL--
