From: Pavel Machek <pavel@ucw.cz>
Subject: [PATCH] hid-led.c: remove unneccessary underscores
Date: Mon, 3 Oct 2016 10:16:26 +0200
Message-ID: <20161003081626.GA18553@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:48864 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751554AbcJCIQb (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 3 Oct 2016 04:16:31 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: j.anaszewski@samsung.com, linux-leds@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>, jikos@kernel.org, benjamin.tissoires@redhat.com, linux-input@vger.kernel.org
Cc: trivial@kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


u8 (and friends) can be used directly in kernel sources (not kernel
headers).

Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/drivers/hid/hid-led.c b/drivers/hid/hid-led.c
index d8d55f3..cd208ca 100644
--- a/drivers/hid/hid-led.c
+++ b/drivers/hid/hid-led.c
@@ -46,20 +46,20 @@ static unsigned const char riso_kagaku_tbl[] =3D {
 #define RISO_KAGAKU_IX(r, g, b) riso_kagaku_tbl[((r)?1:0)+((g)?2:0)+((b)?4=
:0)]
=20
 union delcom_packet {
-	__u8 data[8];
+	u8 data[8];
 	struct {
-		__u8 major_cmd;
-		__u8 minor_cmd;
-		__u8 data_lsb;
-		__u8 data_msb;
+		u8 major_cmd;
+		u8 minor_cmd;
+		u8 data_lsb;
+		u8 data_msb;
 	} tx;
 	struct {
-		__u8 cmd;
+		u8 cmd;
 	} rx;
 	struct {
-		__le16 family_code;
-		__le16 security_code;
-		__u8 fw_version;
+		le16 family_code;
+		le16 security_code;
+		u8 fw_version;
 	} fw;
 };
=20
@@ -112,7 +112,7 @@ module_param(riso_kagaku_switch_green_blue, bool, S_IRU=
GO | S_IWUSR);
 MODULE_PARM_DESC(riso_kagaku_switch_green_blue,
 	"switch green and blue RGB component for Riso Kagaku devices");
=20
-static int hidled_send(struct hidled_device *ldev, __u8 *buf)
+static int hidled_send(struct hidled_device *ldev, u8 *buf)
 {
 	int ret;
=20
@@ -138,7 +138,7 @@ static int hidled_send(struct hidled_device *ldev, __u8=
 *buf)
 }
=20
 /* reading data is supported for report type RAW_REQUEST only */
-static int hidled_recv(struct hidled_device *ldev, __u8 *buf)
+static int hidled_recv(struct hidled_device *ldev, u8 *buf)
 {
 	int ret;
=20
@@ -182,7 +182,7 @@ static int riso_kagaku_write(struct led_classdev *cdev,=
 enum led_brightness br)
 {
 	struct hidled_led *led =3D to_hidled_led(cdev);
 	struct hidled_rgb *rgb =3D led->rgb;
-	__u8 buf[MAX_REPORT_SIZE] =3D {};
+	u8 buf[MAX_REPORT_SIZE] =3D {};
=20
 	buf[1] =3D riso_kagaku_index(rgb);
=20
@@ -193,7 +193,7 @@ static int dream_cheeky_write(struct led_classdev *cdev=
, enum led_brightness br)
 {
 	struct hidled_led *led =3D to_hidled_led(cdev);
 	struct hidled_rgb *rgb =3D led->rgb;
-	__u8 buf[MAX_REPORT_SIZE] =3D {};
+	u8 buf[MAX_REPORT_SIZE] =3D {};
=20
 	buf[1] =3D rgb->red.cdev.brightness;
 	buf[2] =3D rgb->green.cdev.brightness;
@@ -206,7 +206,7 @@ static int dream_cheeky_write(struct led_classdev *cdev=
, enum led_brightness br)
=20
 static int dream_cheeky_init(struct hidled_device *ldev)
 {
-	__u8 buf[MAX_REPORT_SIZE] =3D {};
+	u8 buf[MAX_REPORT_SIZE] =3D {};
=20
 	/* Dream Cheeky magic */
 	buf[1] =3D 0x1f;
@@ -222,7 +222,7 @@ static int _thingm_write(struct led_classdev *cdev, enu=
m led_brightness br,
 			 u8 offset)
 {
 	struct hidled_led *led =3D to_hidled_led(cdev);
-	__u8 buf[MAX_REPORT_SIZE] =3D { 1, 'c' };
+	u8 buf[MAX_REPORT_SIZE] =3D { 1, 'c' };
=20
 	buf[2] =3D led->rgb->red.cdev.brightness;
 	buf[3] =3D led->rgb->green.cdev.brightness;
@@ -254,7 +254,7 @@ static const struct hidled_config hidled_config_thingm_=
v1 =3D {
=20
 static int thingm_init(struct hidled_device *ldev)
 {
-	__u8 buf[MAX_REPORT_SIZE] =3D { 1, 'v' };
+	u8 buf[MAX_REPORT_SIZE] =3D { 1, 'v' };
 	int ret;
=20
 	ret =3D hidled_recv(ldev, buf);
@@ -333,7 +333,7 @@ static int delcom_init(struct hidled_device *ldev)
 static int luxafor_write(struct led_classdev *cdev, enum led_brightness br)
 {
 	struct hidled_led *led =3D to_hidled_led(cdev);
-	__u8 buf[MAX_REPORT_SIZE] =3D { [1] =3D 1 };
+	u8 buf[MAX_REPORT_SIZE] =3D { [1] =3D 1 };
=20
 	buf[2] =3D led->rgb->num + 1;
 	buf[3] =3D led->rgb->red.cdev.brightness;

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlfyE9oACgkQMOfwapXb+vIs3ACgjJB6HPoWRPdm/CYJSMGjZJEb
+64An2+cWdmHgpOwBGJVtQzrDUiVIh71
=nMcm
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
