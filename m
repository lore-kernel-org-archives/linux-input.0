From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH 1/5] Input: alps - move ALPS_PROTO_V6 out of alps_model_data table
Date: Mon,  6 Jun 2016 13:23:57 +0200
Message-ID: <1465212241-14702-2-git-send-email-pali.rohar@gmail.com>
References: <1465212241-14702-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465212241-14702-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Ben Gamari <ben@smart-cactus.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-input@vger.kernel.org

Like for other protocols create alps_v6_protocol_data and use it in
alps_identify() function.

Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
---
 drivers/input/mouse/alps.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 936f07a..eb0c57b 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -133,7 +133,6 @@ static const struct alps_model_info alps_model_data=
[] =3D {
 	/* Dell Latitude E5500, E6400, E6500, Precision M4400 */
 	{ { 0x62, 0x02, 0x14 }, 0x00, { ALPS_PROTO_V2, 0xcf, 0xcf,
 		ALPS_PASS | ALPS_DUALPOINT | ALPS_PS2_INTERLEAVED } },
-	{ { 0x73, 0x00, 0x14 }, 0x00, { ALPS_PROTO_V6, 0xff, 0xff, ALPS_DUALP=
OINT } },		/* Dell XT2 */
 	{ { 0x73, 0x02, 0x50 }, 0x00, { ALPS_PROTO_V2, 0xcf, 0xcf, ALPS_FOUR_=
BUTTONS } },	/* Dell Vostro 1400 */
 	{ { 0x52, 0x01, 0x14 }, 0x00, { ALPS_PROTO_V2, 0xff, 0xff,
 		ALPS_PASS | ALPS_DUALPOINT | ALPS_PS2_INTERLEAVED } },				/* Toshiba=
 Tecra A11-11L */
@@ -152,6 +151,10 @@ static const struct alps_protocol_info alps_v5_pro=
tocol_data =3D {
 	ALPS_PROTO_V5, 0xc8, 0xd8, 0
 };
=20
+static const struct alps_protocol_info alps_v6_protocol_data =3D {
+	ALPS_PROTO_V6, 0xff, 0xff, ALPS_DUALPOINT
+};
+
 static const struct alps_protocol_info alps_v7_protocol_data =3D {
 	ALPS_PROTO_V7, 0x48, 0x48, ALPS_DUALPOINT
 };
@@ -2756,6 +2759,8 @@ static int alps_identify(struct psmouse *psmouse,=
 struct alps_data *priv)
 		if (e7[0] =3D=3D 0x73 && e7[1] =3D=3D 0x03 && e7[2] =3D=3D 0x50 &&
 			   ec[0] =3D=3D 0x73 && (ec[1] =3D=3D 0x01 || ec[1] =3D=3D 0x02)) {
 			protocol =3D &alps_v5_protocol_data;
+		} else if (e7[0] =3D=3D 0x73 && e7[1] =3D=3D 0x00 && e7[2] =3D=3D 0x=
14) {
+			protocol =3D &alps_v6_protocol_data;
 		} else if (ec[0] =3D=3D 0x88 &&
 			   ((ec[1] & 0xf0) =3D=3D 0xb0 || (ec[1] & 0xf0) =3D=3D 0xc0)) {
 			protocol =3D &alps_v7_protocol_data;
--=20
1.7.9.5
