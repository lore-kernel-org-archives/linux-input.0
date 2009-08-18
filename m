From: Yves-Alexis Perez <corsac@debian.org>
Subject: Re: [PATCH] thinkpad-acpi: use correct key names for sleep states
 in driver
Date: Tue, 18 Aug 2009 22:27:10 +0200
Message-ID: <1250627230.2257.15.camel@hidalgo>
References: <1235992429.3858.58.camel@hughsie-work.lan>
	 <20090302112400.GA2356@khazad-dum.debian.net>
	 <1236164049.3936.17.camel@hughsie-work.lan>
	 <20090304120439.GA31850@khazad-dum.debian.net>
	 <1250625730.2257.11.camel@hidalgo>  <20090818201002.GA32638@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-2qAQ/Hq3HsmsMjMK2u0E"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20090818201002.GA32638@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>, Ali Abdallah <aliov@xfce.org>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Richard Hughes <hughsient@gmail.com>, Peter Hutterer <peter.hutterer@redhat.com>, linux-acpi <linux-acpi@vger.kernel.org>, Matthias Clasen <mclasen@redhat.com>, linux-input <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org


--=-2qAQ/Hq3HsmsMjMK2u0E
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On mar, 2009-08-18 at 21:10 +0100, Matthew Garrett wrote:
>=20
> > It seems that this patch is still not in master?
>=20
> Correct. We can't change the existing semantics without breaking=20
> existing userspace applications.

Hmh ok, but is it planned?
>=20
> > Currently (on debian unstable), input-events reports on my T61:
> >=20
> > KEY_SLEEP for Fn+F4
> > KEY_SUSPEND for Fn+F12
> >
> > which kind-of breaks xfce4-power-manager, where SLEEP and SUSPEND
> both
> > suspend to ram, so I don't have any way to hibernate. Changing xfpm
> > doesn't seem like a good idea if the way to go is to use SUSPEND for
> > STR, HIBERNATE for STD and SLEEP for either.
> >=20
> > So what's the status for this?
>=20
> KEY_SLEEP is suspend to RAM, KEY_SUSPEND is suspend to disk. xfpm should=20
> be changed to match.
>=20
Ok, I'm CC:ing the developer to let him know.

Cheers,

--=20
Yves-Alexis

--=-2qAQ/Hq3HsmsMjMK2u0E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkqLDp4ACgkQTUTAIMXAW66llwCgmIFUySrCTxPxPe6ui5T4lh3m
tAEAnRzzTJc2nYpQpe4ZhDWQ0BFKLZbd
=ZHQy
-----END PGP SIGNATURE-----

--=-2qAQ/Hq3HsmsMjMK2u0E--
