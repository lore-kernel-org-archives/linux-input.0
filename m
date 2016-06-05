From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v7 3/4] i2c: i801: add support of Host Notify
Date: Sun, 5 Jun 2016 09:25:41 +0200
Message-ID: <20160605072541.GE2722@katana>
References: <1464688985-19102-1-git-send-email-benjamin.tissoires@redhat.com>
 <1464688985-19102-4-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mR8QP4gmHujQHb1c"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1464688985-19102-4-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-doc-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Corey Minyard <minyard@acm.org>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--mR8QP4gmHujQHb1c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 31, 2016 at 12:03:04PM +0200, Benjamin Tissoires wrote:
> The i801 chip can handle the Host Notify feature since ICH 3 as mentioned
> in http://www.intel.com/content/dam/doc/datasheet/82801ca-io-controller-h=
ub-3-datasheet.pdf
>=20
> Enable the functionality unconditionally and propagate the alert
> on each notification.
>=20
> With a T440s and a Synaptics touchpad that implements Host Notify, the
> payload data is always 0x0000, so I am not sure if the device actually
> sends the payload or if there is a problem regarding the implementation.
>=20
> Tested-by: Andrew Duggan <aduggan@synaptics.com>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Did some high level review. Did not dig into datasheets.

Acked-by: Wolfram Sang <wsa@the-dreams.de>


--mR8QP4gmHujQHb1c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXU9P1AAoJEBQN5MwUoCm2FG8P/j5/QC808vRUQUEm0Jv5oFpy
w3E1Fr2keaZTtt9KY275ZS1WXUUJOHZKgMg/R4VJ/7aPbGIGjsKfZLKZ1aoANkKF
3t95+cAaU7Goxjmpb9TjghXeqRT0XXqAMl615dCqnBsHOxrQai5LIGfVHmrbYw35
4k2bj8qFeO+sLdxE1GVPCQpwAUSCpiMWVPETmdEfOaz/T2EXERZ38903wZ653sQ/
mSgiunrhduG2RAGifsXLWmQDRb8Dxg5FpScMyOMpgdWmBZgs/1//VCE+1mIWBGRb
4vTlO5mU+ljajUjFGX+4ZZ/ZxLJGjGrlm8TXPA8WNAbT9eF/WihMF9K2/fOoVBIw
Lt2ev/0TRqsqaSoWyOE/lvpUvlI4Vj3o7B2SQVOewtdM7w7yXJfy8WdPcujG7Nf4
cJbLpv1TqgLQ7rc2/XG9uHhX95NetNMpGzls6MwJN6cLPTQ+iJmh6QQGyTrjL824
EKA/63eb+0J6+odGxIXPA/DL8JfM0pGMJ65q4kyKeijsrTAYuOnOhGx5yUjT5qzg
IXZvd2/BbHRrpTRydQQiAag6jdKhLyYim2/viRa8aZ6CHuwmSbxplDQGl2SpF0IG
9c2Khfq93d7LMx6HgxrVFTg75wtTMvp2HDUYZ7m+E4FGy0mm4/P18KNASEwe9Bpp
HAK//XXdvejRuy6e0AVd
=Gy1u
-----END PGP SIGNATURE-----

--mR8QP4gmHujQHb1c--
