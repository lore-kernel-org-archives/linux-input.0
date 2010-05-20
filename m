From: Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>
Subject: Re: [PATCH 0/2] Groundwork for Sixaxis paring into bluez.
Date: Thu, 20 May 2010 11:05:00 +0200
Message-ID: <20100520110500.2432e545.ospite@studenti.unina.it>
References: <1272917756-31098-1-git-send-email-ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__20_May_2010_11_05_00_+0200_5icr4hPI0MFodN44"
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1272917756-31098-1-git-send-email-ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>, Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cbe-oss-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-input@vger.kernel.org

--Signature=_Thu__20_May_2010_11_05_00_+0200_5icr4hPI0MFodN44
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon,  3 May 2010 22:15:54 +0200
Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org> wrote:

> Hi,
>

Ping.

> These changes are in preparation of seamless integration of the Sixaxis
> pairing procedure into bluez. It was about time :)
>=20
> The first one cleans up the quirks handling.
>

Even if the second patch in this series is not OK and extending hidraw
is the way, I still think that the first one can be accepted. Anyone?

> The second one adds a sysfs interface to set and get the device and master
> bdaddr, this is needed in order to setup the host for pairing. This kernel
> interface is a mere workaround for the lack of features of hidraw[1], if
> someone wants to add the missing features to hidraw I will be happy to dr=
op
> this one, otherwise consider queuing these for 2.6.35 if it's too late for
> 2.6.34.
>=20
> Thanks,
>    Antonio
>=20
> [1] http://www.spinics.net/lists/linux-input/msg08311.html
>=20
>=20
> Antonio Ospite (2):
>   hid/hid-sony: Apply sixaxis quirks only to sixaxis
>   hid/hid-sony: get and set Sixaxis bdaddr via sysfs
>=20
>  drivers/hid/hid-sony.c |  170 ++++++++++++++++++++++++++++++++++++++++++=
+----
>  1 files changed, 155 insertions(+), 15 deletions(-)
>=20

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

--Signature=_Thu__20_May_2010_11_05_00_+0200_5icr4hPI0MFodN44
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkv0+zwACgkQ5xr2akVTsAH/SgCfbCjng/H5hT03SnUg8u9DrEJh
DW0AoJb+QsK4sTcPOuIbNbClYFQZIMlg
=4JvM
-----END PGP SIGNATURE-----

--Signature=_Thu__20_May_2010_11_05_00_+0200_5icr4hPI0MFodN44--
