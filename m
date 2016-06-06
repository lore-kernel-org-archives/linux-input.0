From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH 3/5] Input: alps - move ALPS_PROTO_V1 out of alps_model_data table
Date: Mon,  6 Jun 2016 13:23:59 +0200
Message-ID: <1465212241-14702-4-git-send-email-pali.rohar@gmail.com>
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

Like for other protocols create alps_v1_protocol_data and use it in
alps_identify() function.

Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
---
 drivers/input/mouse/alps.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 087fbe5..4e6d76e 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -106,7 +106,6 @@ static const struct alps_nibble_commands alps_v6_ni=
bble_commands[] =3D {
=20
 static const struct alps_model_info alps_model_data[] =3D {
 	{ { 0x32, 0x02, 0x14 }, 0x00, { ALPS_PROTO_V2, 0xf8, 0xf8, ALPS_PASS =
| ALPS_DUALPOINT } },	/* Toshiba Salellite Pro M10 */
-	{ { 0x33, 0x02, 0x0a }, 0x00, { ALPS_PROTO_V1, 0x88, 0xf8, 0 } },				=
/* UMAX-530T */
 	{ { 0x53, 0x02, 0x0a }, 0x00, { ALPS_PROTO_V2, 0xf8, 0xf8, 0 } },
 	{ { 0x53, 0x02, 0x14 }, 0x00, { ALPS_PROTO_V2, 0xf8, 0xf8, 0 } },
 	{ { 0x60, 0x03, 0xc8 }, 0x00, { ALPS_PROTO_V2, 0xf8, 0xf8, 0 } },				=
/* HP ze1115 */
@@ -138,6 +137,10 @@ static const struct alps_model_info alps_model_dat=
a[] =3D {
 		ALPS_PASS | ALPS_DUALPOINT | ALPS_PS2_INTERLEAVED } },				/* Toshiba=
 Tecra A11-11L */
 };
=20
+static const struct alps_protocol_info alps_v1_protocol_data =3D {
+	ALPS_PROTO_V1, 0x88, 0xf8, 0
+};
+
 static const struct alps_protocol_info alps_v3_protocol_data =3D {
 	ALPS_PROTO_V3, 0x8f, 0x8f, ALPS_DUALPOINT
 };
@@ -2759,7 +2762,9 @@ static int alps_identify(struct psmouse *psmouse,=
 struct alps_data *priv)
=20
 	protocol =3D alps_match_table(e7, ec);
 	if (!protocol) {
-		if (e7[0] =3D=3D 0x73 && e7[1] =3D=3D 0x02 && e7[2] =3D=3D 0x64 &&
+		if (e7[0] =3D=3D 0x33 && e7[1] =3D=3D 0x02 && e7[2] =3D=3D 0x0a) {
+			protocol =3D &alps_v1_protocol_data;
+		} else if (e7[0] =3D=3D 0x73 && e7[1] =3D=3D 0x02 && e7[2] =3D=3D 0x=
64 &&
 			   ec[2] =3D=3D 0x8a) {
 			protocol =3D &alps_v4_protocol_data;
 		} else if (e7[0] =3D=3D 0x73 && e7[1] =3D=3D 0x03 && e7[2] =3D=3D 0x=
50 &&
--=20
1.7.9.5
