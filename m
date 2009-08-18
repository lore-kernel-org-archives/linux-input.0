From: Yves-Alexis Perez <corsac@debian.org>
Subject: Re: [PATCH] thinkpad-acpi: use correct key names for sleep states
 in driver
Date: Tue, 18 Aug 2009 22:02:10 +0200
Message-ID: <1250625730.2257.11.camel@hidalgo>
References: <1235992429.3858.58.camel@hughsie-work.lan>
	 <20090302112400.GA2356@khazad-dum.debian.net>
	 <1236164049.3936.17.camel@hughsie-work.lan>
	 <20090304120439.GA31850@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-q/e1y43b7Ujj7GgUU+Qf"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20090304120439.GA31850@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Richard Hughes <hughsient@gmail.com>, linux-acpi <linux-acpi@vger.kernel.org>, Peter Hutterer <peter.hutterer@redhat.com>, mjg <mjg@redhat.com>, linux-input <linux-input@vger.kernel.org>, Matthias Clasen <mclasen@redhat.com>
List-Id: linux-input@vger.kernel.org


--=-q/e1y43b7Ujj7GgUU+Qf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On mer, 2009-03-04 at 09:04 -0300, Henrique de Moraes Holschuh wrote:
> On Wed, 04 Mar 2009, Richard Hughes wrote:
> > >From d3ce499f80ba7526e83e7b16f85124ccf77ac1f4 Mon Sep 17 00:00:00 2001
> > From: Richard Hughes <richard@hughsie.com>
> > Date: Wed, 4 Mar 2009 10:51:52 +0000
> > Subject: thinkpad-acpi: use correct key names for sleep keys in driver
> >=20
> > Use the new key KEY_HIBERNATE and correct the use of KEY_SUSPEND.
> >=20
> > KEY_HIBERNATE is used when the decal on the key indicates sleep to disk=
,
> > KEY_SUSPEND is used when the decal indicates sleep to memory, and
> > KEY_SLEEP is used when the sleep type is unknown or unspecified
> >=20
> > We've already converted Xorg, HAL, and most of userspace to use the sam=
e names.
> >=20
> > With this patch, the sleep keys can be labeled consistently all the way
> > through the stack. More patches to other device drivers are to follow.
> >=20
> > Signed-off-by: Richard Hughes <hughsient@gmail.com>
>=20
> Acked-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

It seems that this patch is still not in master?

Currently (on debian unstable), input-events reports on my T61:

KEY_SLEEP for Fn+F4
KEY_SUSPEND for Fn+F12

which kind-of breaks xfce4-power-manager, where SLEEP and SUSPEND both
suspend to ram, so I don't have any way to hibernate. Changing xfpm
doesn't seem like a good idea if the way to go is to use SUSPEND for
STR, HIBERNATE for STD and SLEEP for either.

So what's the status for this?

>=20
> > ---
> >  drivers/platform/x86/thinkpad_acpi.c |    8 ++++----
> >  1 files changed, 4 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x8=
6/thinkpad_acpi.c
> > index bcbc051..d89015d 100644
> > --- a/drivers/platform/x86/thinkpad_acpi.c
> > +++ b/drivers/platform/x86/thinkpad_acpi.c
> > @@ -2241,9 +2241,9 @@ static int __init hotkey_init(struct ibm_init_str=
uct *iibm)
> >  	 */
> >  	static u16 ibm_keycode_map[] __initdata =3D {
> >  		/* Scan Codes 0x00 to 0x0B: ACPI HKEY FN+F1..F12 */
> > -		KEY_FN_F1,	KEY_FN_F2,	KEY_COFFEE,	KEY_SLEEP,
> > +		KEY_FN_F1,	KEY_FN_F2,	KEY_COFFEE,	KEY_SUSPEND,
> >  		KEY_WLAN,	KEY_FN_F6, KEY_SWITCHVIDEOMODE, KEY_FN_F8,
> > -		KEY_FN_F9,	KEY_FN_F10,	KEY_FN_F11,	KEY_SUSPEND,
> > +		KEY_FN_F9,	KEY_FN_F10,	KEY_FN_F11,	KEY_HIBERNATE,
> > =20
> >  		/* Scan codes 0x0C to 0x1F: Other ACPI HKEY hot keys */
> >  		KEY_UNKNOWN,	/* 0x0C: FN+BACKSPACE */
> > @@ -2277,9 +2277,9 @@ static int __init hotkey_init(struct ibm_init_str=
uct *iibm)
> >  	};
> >  	static u16 lenovo_keycode_map[] __initdata =3D {
> >  		/* Scan Codes 0x00 to 0x0B: ACPI HKEY FN+F1..F12 */
> > -		KEY_FN_F1,	KEY_COFFEE,	KEY_BATTERY,	KEY_SLEEP,
> > +		KEY_FN_F1,	KEY_COFFEE,	KEY_BATTERY,	KEY_SUSPEND,
> >  		KEY_WLAN,	KEY_FN_F6, KEY_SWITCHVIDEOMODE, KEY_FN_F8,
> > -		KEY_FN_F9,	KEY_FN_F10,	KEY_FN_F11,	KEY_SUSPEND,
> > +		KEY_FN_F9,	KEY_FN_F10,	KEY_FN_F11,	KEY_HIBERNATE,
> > =20
> >  		/* Scan codes 0x0C to 0x1F: Other ACPI HKEY hot keys */
> >  		KEY_UNKNOWN,	/* 0x0C: FN+BACKSPACE */
>=20
>=20
Cheers,
--=20
Yves-Alexis

--=-q/e1y43b7Ujj7GgUU+Qf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkqLCLwACgkQTUTAIMXAW65GWQCfbF0KRqNiNog+FA5CWtZION4/
K7EAoJbgmOA+mDc5Aq7T26y+dBy/A1E6
=O2pv
-----END PGP SIGNATURE-----

--=-q/e1y43b7Ujj7GgUU+Qf--
