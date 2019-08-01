From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH v2] HID: input: fix a4tech horizontal wheel custom usage
Date: Thu, 01 Aug 2019 12:56:51 +0200
Message-ID: <cd69abeb3883ff7c7e2ff8dbe4db722f4e981875.camel@suse.de>
References: <20190611121320.30267-1-nsaenzjulienne@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-UfwihCv2OFuftwo/Kw1F"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190611121320.30267-1-nsaenzjulienne@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: dmitry.torokhov@gmail.com, wbauer@tmo.at, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--=-UfwihCv2OFuftwo/Kw1F
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-06-11 at 14:13 +0200, Nicolas Saenz Julienne wrote:
> Some a4tech mice use the 'GenericDesktop.00b8' usage to inform whether
> the previous wheel report was horizontal or vertical. Before
> c01908a14bf73 ("HID: input: add mapping for "Toggle Display" key") this
> usage was being mapped to 'Relative.Misc'. After the patch it's simply
> ignored (usage->type =3D=3D 0 & usage->code =3D=3D 0). Which ultimately m=
akes
> hid-a4tech ignore the WHEEL/HWHEEL selection event, as it has no
> usage->type.
>=20
> We shouldn't rely on a mapping for that usage as it's nonstandard and
> doesn't really map to an input event. So we bypass the mapping and make
> sure the custom event handling properly handles both reports.
>=20
> Fixes: c01908a14bf73 ("HID: input: add mapping for "Toggle Display" key")
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---

It would be nice for this patch not to get lost. It fixes issues both repot=
ed
on opensuse and fedora.

I can resubmit it if needed.

Regards,
Nicolas


--=-UfwihCv2OFuftwo/Kw1F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl1CxXMACgkQlfZmHno8
x/5dTQf/fVEdcSkvGY8ltv5SMW+Rvg6bs5uwo/3S0Z1XQ8irP/Agxrykvnur8qPh
CkVbsTRUFZQnTDI1nKojAyzHHIkKqGaDAi9+PO/vAuPrcBmuNeAgTQRtCJj+PSxe
UfkdqjPyHSLkLrlPLCX4MCvWku4Oy8Bs+JnOvYSYoZkSmKT2x+wGNFmDaUCYj7bG
o3n/DJHejomEvPHnVAp1TRhCOaQ8bcMD25wR/YftW1Mu6niCrrveXg5tNFPWEswo
5XylfZ0KblcuZQTvtvp22MJiat1BGdNzYbJs8cGMzGtjWtocP/NCU48RlGkxFWN5
9Emby6PRbBBji460QnxUpt5RD8HDPQ==
=xtev
-----END PGP SIGNATURE-----

--=-UfwihCv2OFuftwo/Kw1F--
