From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH 2/5] Input: alps - move ALPS_PROTO_V4 out of alps_model_data table
Date: Mon,  6 Jun 2016 13:23:58 +0200
Message-ID: <1465212241-14702-3-git-send-email-pali.rohar@gmail.com>
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

Like for other protocols create alps_v4_protocol_data and use it in
alps_identify() function.

Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
---
 drivers/input/mouse/alps.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index eb0c57b..087fbe5 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -136,7 +136,6 @@ static const struct alps_model_info alps_model_data=
[] =3D {
 	{ { 0x73, 0x02, 0x50 }, 0x00, { ALPS_PROTO_V2, 0xcf, 0xcf, ALPS_FOUR_=
BUTTONS } },	/* Dell Vostro 1400 */
 	{ { 0x52, 0x01, 0x14 }, 0x00, { ALPS_PROTO_V2, 0xff, 0xff,
 		ALPS_PASS | ALPS_DUALPOINT | ALPS_PS2_INTERLEAVED } },				/* Toshiba=
 Tecra A11-11L */
-	{ { 0x73, 0x02, 0x64 }, 0x8a, { ALPS_PROTO_V4, 0x8f, 0x8f, 0 } },
 };
=20
 static const struct alps_protocol_info alps_v3_protocol_data =3D {
@@ -147,6 +146,10 @@ static const struct alps_protocol_info alps_v3_rus=
hmore_data =3D {
 	ALPS_PROTO_V3_RUSHMORE, 0x8f, 0x8f, ALPS_DUALPOINT
 };
=20
+static const struct alps_protocol_info alps_v4_protocol_data =3D {
+	ALPS_PROTO_V4, 0x8f, 0x8f, 0
+};
+
 static const struct alps_protocol_info alps_v5_protocol_data =3D {
 	ALPS_PROTO_V5, 0xc8, 0xd8, 0
 };
@@ -2756,7 +2759,10 @@ static int alps_identify(struct psmouse *psmouse=
, struct alps_data *priv)
=20
 	protocol =3D alps_match_table(e7, ec);
 	if (!protocol) {
-		if (e7[0] =3D=3D 0x73 && e7[1] =3D=3D 0x03 && e7[2] =3D=3D 0x50 &&
+		if (e7[0] =3D=3D 0x73 && e7[1] =3D=3D 0x02 && e7[2] =3D=3D 0x64 &&
+			   ec[2] =3D=3D 0x8a) {
+			protocol =3D &alps_v4_protocol_data;
+		} else if (e7[0] =3D=3D 0x73 && e7[1] =3D=3D 0x03 && e7[2] =3D=3D 0x=
50 &&
 			   ec[0] =3D=3D 0x73 && (ec[1] =3D=3D 0x01 || ec[1] =3D=3D 0x02)) {
 			protocol =3D &alps_v5_protocol_data;
 		} else if (e7[0] =3D=3D 0x73 && e7[1] =3D=3D 0x00 && e7[2] =3D=3D 0x=
14) {
--=20
1.7.9.5
