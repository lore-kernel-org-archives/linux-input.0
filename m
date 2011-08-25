From: Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>
Subject: Re: [PATCH BlueZ 3/4] Link to udev only when needed
Date: Thu, 25 Aug 2011 16:14:54 +0200
Message-ID: <20110825161454.45a0b27998f577a737a2e579@studenti.unina.it>
References: <1312553358-26280-1-git-send-email-ospite@studenti.unina.it>
	<1312553358-26280-4-git-send-email-ospite@studenti.unina.it>
	<20110818124438.40e3e125c8de872e1320f511@studenti.unina.it>
	<1313709545.3373.196.camel@aeonflux>
	<20110819105802.b7f5eda46e58b32677fdb804@studenti.unina.it>
	<20110819210854.81dff694ad455da3ed0e6e96@studenti.unina.it>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__25_Aug_2011_16_14_54_+0200_tYNhAjt0O+GWTce5"
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110819210854.81dff694ad455da3ed0e6e96-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Cc: linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jim Paris <jim-XrPbb/hENzg@public.gmane.org>, Ranulf Doswell <ralf-fD3LYpizeBGsTnJN9+BGXg@public.gmane.org>, "Pascal A . Brisset" <pascal44973-dXI0m6hRz7k@public.gmane.org>, Marcin Tolysz <tolysz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Christian Birchinger <joker-vQrvfurPyUjk1uMJSBkQmQ@public.gmane.org>, Filipe Lopes <falktx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alan Ott <alan-yzvJWuRpmD1zbRFIqnYvSA@public.gmane.org>, Mikko Virkkila <virkkila-/1wQRMveznE@public.gmane.org>, Simon Wood <simon-wM4F9T/ekXmXDw4h08c5KA@public.gmane.org>, Arc Riley <arcriley-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

--Signature=_Thu__25_Aug_2011_16_14_54_+0200_tYNhAjt0O+GWTce5
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 19 Aug 2011 21:08:54 +0200
Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org> wrote:

> On Fri, 19 Aug 2011 10:58:02 +0200
> Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org> wrote:
>=20
> > On Thu, 18 Aug 2011 16:18:57 -0700
> > Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org> wrote:
> >=20
> [...]
> > >=20
> > > I rather have the Sixaxis plugin being an external plugin only then. =
So
> > > you are not allowed to make this builtin.
> > >=20
> >=20
> > Marcel, I guess that an _external_ plugin in BlueZ context is one which
> > is not embedded in the bluetoothd binary but rather distributed as a
> > shared object, isn't it? Are there examples of such a plugin in bluez
> > tree I can copy from?
> >
>=20
> OK, I think I've got it, it is external-dummy, this is how I did it:
>=20
> ---
>  Makefile.am |   10 ++++++----
>  1 files changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/Makefile.am b/Makefile.am
> index 4bcff4d..ff33bf0 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -230,8 +230,10 @@ builtin_sources +=3D thermometer/main.c \
>  endif
> =20
>  if SIXAXISPLUGIN
> -builtin_modules +=3D sixaxis
> -builtin_sources +=3D plugins/sixaxis.c
> +plugin_LTLIBRARIES +=3D plugins/sixaxis.la
> +plugins_sixaxis_la_SOURCES =3D plugins/sixaxis.c
> +plugins_sixaxis_la_LDFLAGS =3D -module -avoid-version -no-undefined @UDE=
V_LIBS@
> +plugins_sixaxis_la_CFLAGS =3D -fvisibility=3Dhidden @DBUS_CFLAGS@ @GLIB_=
CFLAGS@ @UDEV_CFLAGS@
>  endif
>=20

This is not enough, the external plugin can be compiled but I can be used
at runtime because it is using functions from src/storage.c and others,
which seem to be embedded inside bluetoothd only, so I get:

bluetoothd[23459]: Can't load plugin \
  /home/ao2/Proj/PS3/PS3_sixaxis/bluez/plugins/.libs/playstation-peripheral=
.so: \
  /home/ao2/Proj/PS3/PS3_sixaxis/bluez/plugins/.libs/playstation-peripheral=
.so: \
  undefined symbol: write_device_name

I could link the needed object files like storage.o and company into the
plugin binary, but definitely this doesn't look OK. Should a shared library
provide those "utility" functions to bluetoothd _and_ external plugins?

This plugin is the first non-trivial external plugin I can see in the tree,
so maybe this problem has never showed up before.

Thanks,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Thu__25_Aug_2011_16_14_54_+0200_tYNhAjt0O+GWTce5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk5WWN4ACgkQ5xr2akVTsAFBGwCfSwqoL5SYeRnQuqHJlWxAWGpz
OHEAnRcRn3xA2llOyVWcc/EJhN5qp4uw
=A5R/
-----END PGP SIGNATURE-----

--Signature=_Thu__25_Aug_2011_16_14_54_+0200_tYNhAjt0O+GWTce5--
