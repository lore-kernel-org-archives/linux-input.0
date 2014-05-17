From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 1/2] Input: Add keycodes for some missing Fn key combinations
Date: Sat, 17 May 2014 22:38:30 +0200
Message-ID: <201405172238.30089@pali>
References: <201405171639.45722@pali> <1400337817-14473-2-git-send-email-pali.rohar@gmail.com> <20140517203054.GA19657@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2287472.MCrLzuzKjs";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-hotplug-owner@vger.kernel.org>
In-Reply-To: <20140517203054.GA19657@core.coreip.homeip.net>
Sender: linux-hotplug-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-hotplug@vger.kernel.org, Matthew Garrett <mjg@redhat.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

--nextPart2287472.MCrLzuzKjs
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Saturday 17 May 2014 22:30:54 Dmitry Torokhov wrote:
> Hi Pali,
>=20
> On Sat, May 17, 2014 at 04:43:36PM +0200, Pali Roh=C3=A1r wrote:
> > There are already defined some Fn key combinations, but not
> > all. This patch adds missing combinations for support in
> > dell-wmi driver.
> >=20
> > Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> > ---
> >=20
> >  include/uapi/linux/input.h |    6 ++++++
> >  1 file changed, 6 insertions(+)
> >=20
> > diff --git a/include/uapi/linux/input.h
> > b/include/uapi/linux/input.h index f484952..3a32799 100644
> > --- a/include/uapi/linux/input.h
> > +++ b/include/uapi/linux/input.h
> > @@ -672,6 +672,12 @@ struct input_keymap_entry {
> >=20
> >  #define KEY_FN_F		0x1e2
> >  #define KEY_FN_S		0x1e3
> >  #define KEY_FN_B		0x1e4
> >=20
> > +#define KEY_FN_Q		0x1e5
> > +#define KEY_FN_W		0x1e6
> > +#define KEY_FN_R		0x1e7
> > +#define KEY_FN_T		0x1e8
> > +#define KEY_FN_A		0x1e9
> > +#define KEY_FN_G		0x1ea
>=20
> What do they actually do?
>=20
> Thanks.

All 10 combinations Fn+Q ... Fn+T, Fn+A ... Fn+G are reported by=20
WMI and I need to assign some keycodes for them in dell-wmi=20
driver. And because More FN_* constants are already defined in=20
input.h I added those which are missing.

With this patch series I'm able to use above Fn combinations for=20
my own keyboard shortcuts. Before this patch all Fn combinations=20
were one same keycode - which was useless.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2287472.MCrLzuzKjs
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlN3yMYACgkQi/DJPQPkQ1JZSgCeJKH1qJRRRcgXv9AgHm5KQYSj
JqsAn3PagCQ5GKraIOG8u4uO+zo07jzC
=SH+l
-----END PGP SIGNATURE-----

--nextPart2287472.MCrLzuzKjs--
