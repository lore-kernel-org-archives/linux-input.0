From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCH BlueZ 3/4] Link to udev only when needed
Date: Fri, 19 Aug 2011 10:58:02 +0200
Message-ID: <20110819105802.b7f5eda46e58b32677fdb804@studenti.unina.it>
References: <1312553358-26280-1-git-send-email-ospite@studenti.unina.it>
	<1312553358-26280-4-git-send-email-ospite@studenti.unina.it>
	<20110818124438.40e3e125c8de872e1320f511@studenti.unina.it>
	<1313709545.3373.196.camel@aeonflux>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__19_Aug_2011_10_58_02_+0200__PfNetaCeFmqi8_a"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp209.alice.it ([82.57.200.105]:43237 "EHLO smtp209.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752528Ab1HSI6Q (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Aug 2011 04:58:16 -0400
In-Reply-To: <1313709545.3373.196.camel@aeonflux>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org, Jim Paris <jim@jtan.com>, Ranulf Doswell <ralf@ranulf.net>, "Pascal A . Brisset" <pascal44973@pabr.org>, Marcin Tolysz <tolysz@gmail.com>, Christian Birchinger <joker@netswarm.net>, Filipe Lopes <falktx@gmail.com>, Alan Ott <alan@signal11.us>, Mikko Virkkila <virkkila@kapsi.fi>, Simon Wood <simon@mungewell.org>, Arc Riley <arcriley@gmail.com>

--Signature=_Fri__19_Aug_2011_10_58_02_+0200__PfNetaCeFmqi8_a
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 18 Aug 2011 16:18:57 -0700
Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Antonio,
>=20
> >=20
> > > Don't link bluetoothd to udev unconditionally, but only when it is
> > > needed. For now bluetoothd needs to be linked to udev only when the
> > > sixaxis plugin is enabled.
> >=20
> > Any comment on this change? If it looks OK I'll fold it in v5.
> >=20
> > Thanks,
> >    Antonio
> >=20
> > > ---
> > >  Makefile.am |    6 +++++-
> > >  1 files changed, 5 insertions(+), 1 deletions(-)
> > >=20
> > > diff --git a/Makefile.am b/Makefile.am
> > > index dbe0170..219ca0f 100644
> > > --- a/Makefile.am
> > > +++ b/Makefile.am
> > > @@ -288,7 +288,11 @@ src_bluetoothd_SOURCES =3D $(gdbus_sources) $(bu=
iltin_sources) \
> > >  			src/event.h src/event.c \
> > >  			src/oob.h src/oob.c src/eir.h src/eir.c
> > >  src_bluetoothd_LDADD =3D lib/libbluetooth.la @GLIB_LIBS@ @DBUS_LIBS@=
 \
> > > -							@CAPNG_LIBS@ @UDEV_LIBS@ -ldl -lrt
> > > +							@CAPNG_LIBS@ -ldl -lrt
> > > +if SIXAXISPLUGIN
> > > +src_bluetoothd_LDADD +=3D @UDEV_LIBS@
> > > +endif
> > > +
> > >  src_bluetoothd_LDFLAGS =3D -Wl,--export-dynamic \
> > >  				-Wl,--version-script=3D$(srcdir)/src/bluetooth.ver
>=20
> I rather have the Sixaxis plugin being an external plugin only then. So
> you are not allowed to make this builtin.
>=20

Marcel, I guess that an _external_ plugin in BlueZ context is one which
is not embedded in the bluetoothd binary but rather distributed as a
shared object, isn't it? Are there examples of such a plugin in bluez
tree I can copy from?

Or do you mean a standalone daemon interacting with bluetoothd via
dbus? AFAIR we discarded this option in the past.

Thanks,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Fri__19_Aug_2011_10_58_02_+0200__PfNetaCeFmqi8_a
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk5OJZoACgkQ5xr2akVTsAGXjQCbBt3KsQpwTzQ2tySfdOqxO141
JnsAn18Du5IwPrw7LJRNC5NAzbxB1t1z
=SAue
-----END PGP SIGNATURE-----

--Signature=_Fri__19_Aug_2011_10_58_02_+0200__PfNetaCeFmqi8_a--
