From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2 1/2] DT: i2c: Deprecate adi,adxl34x compatible string
Date: Mon, 26 Jan 2015 13:12:51 +0100
Message-ID: <20150126121250.GD1052@katana>
References: <1421333655-31029-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1421333655-31029-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8w3uRX/HFJGApMzv"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1421333655-31029-2-git-send-email-laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org


--8w3uRX/HFJGApMzv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2015 at 04:54:14PM +0200, Laurent Pinchart wrote:
> DT nodes should use the more specific adi,adxl345 and adi,adxl346
> compatible values instead. As the ADXL346 is backward-compatible with
> the ADXL345, ADXL346 nodes must list both adi,adxl346 and adi,adxl345,
> in that order.
>=20
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnhk3lzF8UVTdg@public.gmane.org=
m>

On the other hand, I'll just ack this patch, so Dmitry can take both of
them. D'accord?

Acked-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>


--8w3uRX/HFJGApMzv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUxi9CAAoJEBQN5MwUoCm2NhMQAJ4V5fb+1Wr++RVlyYo9ZdFR
ZYjk3vfs/MBanMpraCbNwM9nTDRsibQay8UhpzoVRl0RUnQaFg2lDdwutujnFKgE
vCRBO91rTM0q10D2Y3+8iQ8FErD9XA3RJn4MttJYlq/Gx1+IizHKUsvK1w5kAWds
CZpUKzcpS+lvYRYGcj81hjGyn4jc4fHuT2exLAGsLmsa+DIUWUlU9001EuvbHn81
EuTkC8serHNifKuD4LOdsHULllwkBK4945XK+M4NbqjnqcWooSrtshFgshvNyphv
xXW4laTi3lyB2Td9D5ReGvLONo3uqpJPcyBKE6HJBSmQtjPrQOWKnDrHz9WG97kf
mmJ3tu04+95dX+GiGOGuzetU4t6XeEUL5QOeb4Lki+EZitul4nMPMbq2SqhdpOmB
io0ohCj2rYUZu1e4h0MBN7SlrKcmj5cStFkX1M4vCKum+xDRViz5G/AKngAdzmVf
AbD3rUCOHmTTceJmozsSi2TNEuBjKa64DvRqUZrYJs53ZnUHTrwnZbplojcbN3j2
Rmly92+OItQw9HBYNile12uyhXMIih3kZCz8uawBIwLauZgFMfSir8O9roJDxk5M
tQM0bB15NZo3pATVELa1G0uifIrDrcDwPvZfWKkot4wz5KKBmEDjNe8REvGbjfrp
7XdtqL0P9k+wWcLdQVOy
=HvY7
-----END PGP SIGNATURE-----

--8w3uRX/HFJGApMzv--
