From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCH 0/4 incremental 1/2] Generalize controller handling to
 support different devices
Date: Fri, 19 Aug 2011 21:14:49 +0200
Message-ID: <20110819211449.b17b35611f11979f9d59a8ab@studenti.unina.it>
References: <20110818161357.8084ab94bff57391e7ec3284@studenti.unina.it>
	<1313677340-4441-1-git-send-email-ospite@studenti.unina.it>
	<4E4D2F2E.20105@signal11.us>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__19_Aug_2011_21_14_49_+0200_RrzSZr=tYYH_g_LN"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp209.alice.it ([82.57.200.105]:40211 "EHLO smtp209.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755491Ab1HSTPC (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Aug 2011 15:15:02 -0400
In-Reply-To: <4E4D2F2E.20105@signal11.us>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Ott <alan@signal11.us>
Cc: linux-bluetooth@vger.kernel.org, Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org, Jim Paris <jim@jtan.com>, Ranulf Doswell <ralf@ranulf.net>, "Pascal A . Brisset" <pascal44973@pabr.org>, Marcin Tolysz <tolysz@gmail.com>, Christian Birchinger <joker@netswarm.net>, Filipe Lopes <falktx@gmail.com>, Mikko Virkkila <virkkila@kapsi.fi>, Simon Wood <simon@mungewell.org>, Arc Riley <arcriley@gmail.com>

--Signature=_Fri__19_Aug_2011_21_14_49_+0200_RrzSZr=tYYH_g_LN
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 18 Aug 2011 11:26:38 -0400
Alan Ott <alan@signal11.us> wrote:

> On 08/18/2011 10:22 AM, Antonio Ospite wrote:
> > Remove hardcoded #defines and put the values in a struct so we can hand=
le=20
> > different device types.
> >
> > From the USB dumps I've seen[1], different devices have just different =
ways to=20
> > get and set the bdaddrs, the pairing algorithm is the same.
> >
> > [1] http://ps3.jim.sh/sixaxis/dumps/=20
> >
> > ---
> >  plugins/sixaxis.c |   80 ++++++++++++++++++++++++++++++++++-----------=
-------
> >  1 files changed, 52 insertions(+), 28 deletions(-)
> >
> > diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
> > index e08222c..608474f 100644
> > --- a/plugins/sixaxis.c
> > +++ b/plugins/sixaxis.c
> > @@ -70,12 +70,38 @@
> > =20
[...]
> > +static struct sony_controller controllers[] =3D {
> > +	{
> > +		.vendor_id =3D 0x054c,
> > +		.product_id =3D 0x0268,
> > +		.name =3D "PLAYSTATION(R)3 Controller",
> > +		.pnp_record =3D "3601920900000A000100000900013503191124090004350D350=
61901000900113503190011090006350909656E09006A090100090009350835061911240901=
0009000D350F350D350619010009001335031900110901002513576972656C65737320436F6=
E74726F6C6C65720901012513576972656C65737320436F6E74726F6C6C6572090102251B53=
6F6E7920436F6D707574657220456E7465727461696E6D656E7409020009010009020109010=
00902020800090203082109020428010902052801090206359A35980822259405010904A101=
A102850175089501150026FF008103750195131500250135004501050919012913810275019=
50D0600FF8103150026FF0005010901A10075089504350046FF0009300931093209358102C0=
050175089527090181027508953009019102750895300901B102C0A1028502750895300901B=
102C0A10285EE750895300901B102C0A10285EF750895300901B102C0C00902073508350609=
04090901000902082800090209280109020A280109020B09010009020C093E8009020D28000=
9020E2800",
> > +		.hid_uuid =3D "00001124-0000-1000-8000-00805f9b34fb",
>=20
> Where do the pnp_record and hid_uuid come from? It seems a bit odd to
> have a giant hard-coded identifier string (pnp), but I'm not an expert
> on this stuff, and I'm mostly just curious about it.
>

Bastien provided those, AFAIR PNP_RECORD is an identifier shown in the
association request when the plugin is not enabled, and it could depend
on the device.

WRT HID_UUID, maybe this is not device specific, it might just tell
"this is a HID device", I need confirmation about that so I can move the
field out of the structure.

Thanks,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Fri__19_Aug_2011_21_14_49_+0200_RrzSZr=tYYH_g_LN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk5OtikACgkQ5xr2akVTsAHvkACgqwPbXeW6m/eIhJbwTODHIRRE
lgEAoK31YU6ChXTWT6bbzTBIGAAc7sZI
=CD9F
-----END PGP SIGNATURE-----

--Signature=_Fri__19_Aug_2011_21_14_49_+0200_RrzSZr=tYYH_g_LN--
