From: Filipe =?ISO-8859-1?Q?La=EDns?= <lains@archlinux.org>
Subject: Re: [PATCH 0/2] Fix support of a few Logitech devices broken in 5.3
Date: Tue, 13 Aug 2019 15:21:28 +0100
Message-ID: <d558b953e88558b8d7955e591fefbe898edeb3ae.camel@archlinux.org>
References: <20190813133807.12384-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-C0SorkiN9smqF35MFDat"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190813133807.12384-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--=-C0SorkiN9smqF35MFDat
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-08-13 at 15:38 +0200, Benjamin Tissoires wrote:
> Hi Jiri,
>=20
> another set of patches to send to Linus ASAP.
> It turns out that we have been breaking devices, so this should
> be sent before 5.3 final.
>=20
> Cheers,
> Benjamin
>=20
> Benjamin Tissoires (2):
>   Revert "HID: logitech-hidpp: add USB PID for a few more supported
>     mice"
>   HID: logitech-hidpp: remove support for the G700 over USB
>=20
>  drivers/hid/hid-logitech-hidpp.c | 22 ----------------------
>  1 file changed, 22 deletions(-)
>=20

Reviewed-by: Filipe La=C3=ADns <lains@archlinux.org>

Thanks,
Filipe La=C3=ADns

--=-C0SorkiN9smqF35MFDat
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0jW0leqs33gyftiw+JPGdIFqqV0FAl1Sx18ACgkQ+JPGdIFq
qV0PSBAAtHhcycfda272Ii5CyvMWH8Xh965T8lnde3yUPyiBb6Yr913OAx13DCqa
WWj4m+HTXVyrHR6ykuVwZhGX8M5WwCq5UnkIygup7+tHSzaPHtPmvOoJYqkjtsgp
IMeH7swN9o7nHpjHcyUyM5mimbBhn/qX4mhJ6GTpF1vMtlJcbBvlj6H/Kl1XbxGA
S2dc//wfJUOyxh6lp1Wxb4f/l87cZghX8meuWS3amzVkZm2LHcIIkzefs77Fj8P1
bnaBsn1eh7vFFs4H154RBHxUM4qDW/i6WWGEUXAuEAE51XbzQoZIrVofipky553U
/4We0roMJiOt423VG8tm90WuXFeDrPjW5CT/ud9x9Zc8NxXIP68tlrfDJsCZLaiI
YQsOopy2k7fDrNBFSXQ8Ak5D6N7WPuJ7DXCPOK2+zEaPb3R7iEL5eBTaFFLq/oEj
2GemuiWsHcXWo5SxhyeuMNlbVA9oZLtvLieG6tod8PI9r6c4H497N8+jfFQZohxO
f/3lAmHen3LILBmcZXmfgma2avGHRq1PChoEMAyn0+Ef6xBgwlipGFKTveZ8nc8S
7f1Sqp3H14oo/oS09NybkLgXHPaqTrmFTPDNR7qwuJxOA4ZwnE1l9r1sYYws9VTp
Ug36Lp+Mj7vDQraqrwi7kYrxIHf8AqZRbx/diGRKdWtaPSmB3VA=
=UHMC
-----END PGP SIGNATURE-----

--=-C0SorkiN9smqF35MFDat--
