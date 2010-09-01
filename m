From: Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>
Subject: Re: [PATCH 1/2] hid/hid-sony: Apply sixaxis quirks only to sixaxis
Date: Wed, 1 Sep 2010 19:20:55 +0200
Message-ID: <20100901192055.2f23c8c7.ospite@studenti.unina.it>
References: <1272917756-31098-1-git-send-email-ospite@studenti.unina.it>
	<1272917756-31098-2-git-send-email-ospite@studenti.unina.it>
	<1283357615.2361.20.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__1_Sep_2010_19_20_55_+0200_B_mn9w14EG+luYY1"
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1283357615.2361.20.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cbe-oss-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

--Signature=_Wed__1_Sep_2010_19_20_55_+0200_B_mn9w14EG+luYY1
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 01 Sep 2010 17:13:35 +0100
Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org> wrote:

> On Mon, 2010-05-03 at 22:15 +0200, Antonio Ospite wrote:
> > Be more explicit and avoid calling sony_set_operational_usb() when we
> > have USB_DEVICE_ID_SONY_VAIO_VGX_MOUSE.
> >=20
> > While at it, rename the sony_set_operational routines to
> > sixaxis_set_operational as they are sixaxis specific.
> >=20
> > This is also in preparation for the sysfs interface to set and get bdad=
dr
> > over usb and for some other Sixaxis report fixup.
> >=20
> > Signed-off-by: Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>
>=20
> Signed-off-by: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
>

Thanks Bastien for bringing this up again, I was going to repost
this patch sometime this month.

Added Jiri to CC as I forgot to do that back then.

Regards,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Wed__1_Sep_2010_19_20_55_+0200_B_mn9w14EG+luYY1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkx+i3cACgkQ5xr2akVTsAE/BwCfdLlY2xkdMT24QSSYItBAKAsQ
rxEAnjSZcLIghNd/uyf/Q8hVYEXMTqW+
=Fn8R
-----END PGP SIGNATURE-----

--Signature=_Wed__1_Sep_2010_19_20_55_+0200_B_mn9w14EG+luYY1--
