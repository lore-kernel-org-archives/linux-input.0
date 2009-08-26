From: Yves-Alexis Perez <corsac@debian.org>
Subject: Re: [PATCH] thinkpad-acpi: use correct key names for sleep states
 in driver
Date: Wed, 26 Aug 2009 19:52:41 +0200
Message-ID: <1251309161.10837.6.camel@hidalgo>
References: <1235992429.3858.58.camel@hughsie-work.lan>
	 <20090302112400.GA2356@khazad-dum.debian.net>
	 <1236164049.3936.17.camel@hughsie-work.lan>
	 <20090304120439.GA31850@khazad-dum.debian.net>
	 <1250625730.2257.11.camel@hidalgo> <20090818201002.GA32638@srcf.ucam.org>
	 <1251286574.32399.3.camel@miria>  <20090826134349.GA12404@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-fWeHaQVpcbSTTYw5xQ3w"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from molly.corsac.net ([81.57.48.219]:58300 "EHLO molly.corsac.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752447AbZHZRwj (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 26 Aug 2009 13:52:39 -0400
In-Reply-To: <20090826134349.GA12404@srcf.ucam.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Richard Hughes <hughsient@gmail.com>, linux-acpi <linux-acpi@vger.kernel.org>, Peter Hutterer <peter.hutterer@redhat.com>, linux-input <linux-input@vger.kernel.org>, Matthias Clasen <mclasen@redhat.com>, aliov@xfce.org


--=-fWeHaQVpcbSTTYw5xQ3w
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On mer, 2009-08-26 at 14:43 +0100, Matthew Garrett wrote:
> On Wed, Aug 26, 2009 at 01:36:14PM +0200, Yves-Alexis Perez wrote:
>=20
> > #define XF86XK_Suspend    0x1008FFA7   /* Sleep to RAM                *=
/       =20
> > #define XF86XK_Hibernate  0x1008FFA8   /* Sleep to disk               *=
/
> >=20
> > So (some) userspace seems to have switched already?
>=20
> Adding those keysyms was, with hindsight, an error.

Ok, so every userland app which began the transition should step back
until a correct migration plan is set up?

Are X people aware of that and will they step back? What should we do so
it works on most system? Now that things have started to move wouldn't
it make sense to keep going?

Sorry, I'm a bit lost and I think xfce4-power-manager upstream is too=E2=80=
=A6

Cheers,
--=20
Yves-Alexis

--=-fWeHaQVpcbSTTYw5xQ3w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkqVdmUACgkQTUTAIMXAW66towCfV00tqK1O8HEEpcnV/agZdNSO
HbIAn2Y3A3XcoX413OJtxT1dR5felNxu
=W5vm
-----END PGP SIGNATURE-----

--=-fWeHaQVpcbSTTYw5xQ3w--
