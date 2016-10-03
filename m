From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] hid-led.c: remove unneccessary underscores
Date: Mon, 3 Oct 2016 11:45:03 +0200
Message-ID: <20161003094503.GC9131@amd>
References: <20161003081626.GA18553@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Sr1nOIr3CvdE5hEN"
Return-path: <linux-leds-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161003081626.GA18553@amd>
Sender: linux-leds-owner@vger.kernel.org
To: j.anaszewski@samsung.com, linux-leds@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>, jikos@kernel.org, benjamin.tissoires@redhat.com, linux-input@vger.kernel.org
Cc: trivial@kernel.org
List-Id: linux-input@vger.kernel.org


--Sr1nOIr3CvdE5hEN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2016-10-03 10:16:26, Pavel Machek wrote:
>=20
> u8 (and friends) can be used directly in kernel sources (not kernel
> headers).
>=20
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

Zero day bot warned me that this is not quiet correct.

This would be needed on top. Is there interest in fixed patch?

diff --git a/drivers/hid/hid-led.c b/drivers/hid/hid-led.c
index cd208ca..be659ca 100644
--- a/drivers/hid/hid-led.c
+++ b/drivers/hid/hid-led.c
@@ -57,8 +57,8 @@ union delcom_packet {
 		u8 cmd;
 	} rx;
 	struct {
-		le16 family_code;
-		le16 security_code;
+		__le16 family_code;
+		__le16 security_code;
 		u8 fw_version;
 	} fw;
 };



--Sr1nOIr3CvdE5hEN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlfyKJ8ACgkQMOfwapXb+vKpIACfYaRWLDJrnTYr5bpEdHFTySE8
NNMAn03JtO9x5wjE4M+qhW0D0tuwFeQv
=Sn4o
-----END PGP SIGNATURE-----

--Sr1nOIr3CvdE5hEN--
