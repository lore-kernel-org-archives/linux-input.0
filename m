From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2] HID: cp2112: fix I2C_SMBUS_BYTE write
Date: Tue, 14 Jul 2015 13:49:17 +0200
Message-ID: <20150714114917.GG1517@katana>
References: <1436826234-2447-1-git-send-email-ellen@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KIzF6Cje4W/osXrF"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1436826234-2447-1-git-send-email-ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ellen Wang <ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
Cc: borneo.antonio-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dbarksdale-2SNLKkHU5xRBDgjK7y7TUQ@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org


--KIzF6Cje4W/osXrF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2015 at 03:23:54PM -0700, Ellen Wang wrote:
> When doing an I2C_SMBUS_BYTE write (one byte write, no address),
> the data to be written is in "command" not "data->byte".
>=20
> Signed-off-by: Ellen Wang <ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>

Acked-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

Wow, that driver seems to be largely untested. Thanks for cleaning it
up! Sidenote: i2c drivers should really be in drivers/i2c ;)


--KIzF6Cje4W/osXrF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVpPc9AAoJEBQN5MwUoCm2MS0P/23XpeiglbCESU/H1Z/K8JtA
ZREJT1Sm15teGzhd6GVwtHO/819RkLDm8egcBadbD87cScoPIGdR+f1kwcLBQUDZ
Ug+aP287Bbsgq78P8sD7IFmjcNeqKCN0Dj9h6EptCfMqPoQHFg6Im2tJMfN02fPR
qTS5Z6MfXuWmMOnrXKyi+VNXIJVtFHgCNNEEVNnJytLYTX+SojX+He7s5cEfRgtb
dF+tiBhSUX8Ac1TPt1Q9XLoj1XnMHuP7CHxvL6IgK2c7yTqp/R9J3oOwBuJ1pKos
uNba5BqyGNJTkIEt0KqxyEDJNGZtu6u00WFq7IPPBmu6VsH1cd9bt9gyn/7I6jjq
NOSvxUz9g/RDPTrMXfEVMjHYQBywBNVaVV2imTJY5KTtsFs0ayRJkkrnVOAZFDUi
LwuQIaDeEte+ToAY79ia/cC6DZBtZhi0nO5txZ2p8StUf0bqLW66gQXs1bRz6z+S
V/YDeBuQgyC4Xsdu3kUXcrVLCvbJPdyI8zjYep1baUhxvYP0XbSXSzVtvKwgseZx
M5EWCOf9WoIojagPQNvh1o3fIaMwatjybyqJpqCQ98bAvxCopgDtrYh1ITL6X/e2
uGIkhlbf3nrMpy0gxdypj+w27HEZHxvMQyjYpTViHnSCAB+rQGyKX6XM7rlFzY0O
sPnL1W4lg3nIPXSEk4L+
=GcDo
-----END PGP SIGNATURE-----

--KIzF6Cje4W/osXrF--
