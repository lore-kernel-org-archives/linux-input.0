From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCH BlueZ 3/4] Link to udev only when needed
Date: Fri, 26 Aug 2011 14:49:25 +0200
Message-ID: <20110826144925.7a769734ad9eda41b1206357@studenti.unina.it>
References: <1312553358-26280-1-git-send-email-ospite@studenti.unina.it>
	<1312553358-26280-4-git-send-email-ospite@studenti.unina.it>
	<20110818124438.40e3e125c8de872e1320f511@studenti.unina.it>
	<1313709545.3373.196.camel@aeonflux>
	<20110819105802.b7f5eda46e58b32677fdb804@studenti.unina.it>
	<20110819210854.81dff694ad455da3ed0e6e96@studenti.unina.it>
	<20110825161454.45a0b27998f577a737a2e579@studenti.unina.it>
	<20110825170621.GB27645@samus.indt.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__26_Aug_2011_14_49_25_+0200_sKQi.xG7Vm0wXGqp"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp205.alice.it ([82.57.200.101]:38758 "EHLO smtp205.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752796Ab1HZMtk (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 26 Aug 2011 08:49:40 -0400
In-Reply-To: <20110825170621.GB27645@samus.indt.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org, Jim Paris <jim@jtan.com>, Ranulf Doswell <ralf@ranulf.net>, "Pascal A . Brisset" <pascal44973@pabr.org>, Marcin Tolysz <tolysz@gmail.com>, Christian Birchinger <joker@netswarm.net>, Filipe Lopes <falktx@gmail.com>, Alan Ott <alan@signal11.us>, Mikko Virkkila <virkkila@kapsi.fi>, Simon Wood <simon@mungewell.org>, Arc Riley <arcriley@gmail.com>

--Signature=_Fri__26_Aug_2011_14_49_25_+0200_sKQi.xG7Vm0wXGqp
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 25 Aug 2011 14:06:21 -0300
Vinicius Costa Gomes <vinicius.gomes@openbossa.org> wrote:

[...]
> > > diff --git a/Makefile.am b/Makefile.am
> > > index 4bcff4d..ff33bf0 100644
> > > --- a/Makefile.am
> > > +++ b/Makefile.am
> > > @@ -230,8 +230,10 @@ builtin_sources +=3D thermometer/main.c \
> > >  endif
> > > =20
> > >  if SIXAXISPLUGIN
> > > -builtin_modules +=3D sixaxis
> > > -builtin_sources +=3D plugins/sixaxis.c
> > > +plugin_LTLIBRARIES +=3D plugins/sixaxis.la
> > > +plugins_sixaxis_la_SOURCES =3D plugins/sixaxis.c
> > > +plugins_sixaxis_la_LDFLAGS =3D -module -avoid-version -no-undefined =
@UDEV_LIBS@
> > > +plugins_sixaxis_la_CFLAGS =3D -fvisibility=3Dhidden @DBUS_CFLAGS@ @G=
LIB_CFLAGS@ @UDEV_CFLAGS@
> > >  endif
> > >=20
> >=20
> > This is not enough, the external plugin can be compiled but I can be us=
ed
> > at runtime because it is using functions from src/storage.c and others,
> > which seem to be embedded inside bluetoothd only, so I get:
> >=20
> > bluetoothd[23459]: Can't load plugin \
> >   /home/ao2/Proj/PS3/PS3_sixaxis/bluez/plugins/.libs/playstation-periph=
eral.so: \
> >   /home/ao2/Proj/PS3/PS3_sixaxis/bluez/plugins/.libs/playstation-periph=
eral.so: \
> >   undefined symbol: write_device_name
> >=20
> > I could link the needed object files like storage.o and company into the
> > plugin binary, but definitely this doesn't look OK. Should a shared lib=
rary
> > provide those "utility" functions to bluetoothd _and_ external plugins?
> >=20
> > This plugin is the first non-trivial external plugin I can see in the t=
ree,
> > so maybe this problem has never showed up before.
>=20
> The problem is the visibility of the symbols, src/bluetooth.ver defines
> which symbols should[1] be visible to plugins. Every plugin should only
> depend on those methods from the "core".
>

Indeed, adding the needed symbols to the linker script makes the plugin
work:

diff --git a/src/bluetooth.ver b/src/bluetooth.ver
index b71c70d..11fcd33 100644
--- a/src/bluetooth.ver
+++ b/src/bluetooth.ver
@@ -5,6 +5,19 @@
                info;
                error;
                debug;
+               manager_get_default_adapter;
+               adapter_get_address;
+               write_device_name;
+               record_from_string;
+               store_record;
+               sdp_record_free;
+               store_device_id;
+               write_trust;
+               dbus_bus_get;
+               adapter_get_device;
+               device_set_temporary;
+               device_set_name;
+               dbus_connection_unref;
        local:
                *;
 };


> If we want to keep the sixaxis plugin external we need to make the
> symbols it need visible, but I wonder if that is right solution.
>

If there was a public API for plugins to use with well defined prefixes,
the linking scripts could use those, I am thinking to something like:
	sdp_*;
	storage_*;
	device_*;
	dbus_*;

But you bluez people have to tell me if this is the way to go and if
you are willing to do that, of if I'd better have the plugin builtin for
now.

> [1] Seems that with builtin plugins that visibility enforcement doesn't
> work, right?
>

This seems to be the case indeed, a bluiltin plugin can use any (non
static?) symbol linked in the bluetoothd binary.

Thanks,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Fri__26_Aug_2011_14_49_25_+0200_sKQi.xG7Vm0wXGqp
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk5XllUACgkQ5xr2akVTsAG+jACfWBh1MId8LmzR22i2JDwdPLlL
kCYAoI0cUHVR/wxh+FmiN8WB9AdYTmHD
=wVDc
-----END PGP SIGNATURE-----

--Signature=_Fri__26_Aug_2011_14_49_25_+0200_sKQi.xG7Vm0wXGqp--
