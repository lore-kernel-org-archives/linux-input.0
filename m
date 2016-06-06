From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH 5/5] Input: alps - cleanup ALPS_PROTO_V2 detection
Date: Mon,  6 Jun 2016 13:24:01 +0200
Message-ID: <1465212241-14702-6-git-send-email-pali.rohar@gmail.com>
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

Table alps_model_data is now used only for ALPS_PROTO_V2, so add "v2"
indentifier to all relevant functions/variables/structures. Sort all
devices by signature and remove command_mode_resp which is not used
anymore.

Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
---
 drivers/input/mouse/alps.c |   66 ++++++++++++++++++++----------------=
--------
 drivers/input/mouse/alps.h |    9 ++----
 2 files changed, 32 insertions(+), 43 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 3618320..7dc49c1e 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -104,37 +104,35 @@ static const struct alps_nibble_commands alps_v6_=
nibble_commands[] =3D {
 #define ALPS_STICK_BITS		0x100	/* separate stick button bits */
 #define ALPS_BUTTONPAD		0x200	/* device is a clickpad */
=20
-static const struct alps_model_info alps_model_data[] =3D {
-	{ { 0x32, 0x02, 0x14 }, 0x00, { ALPS_PROTO_V2, 0xf8, 0xf8, ALPS_PASS =
| ALPS_DUALPOINT } },	/* Toshiba Salellite Pro M10 */
-	{ { 0x53, 0x02, 0x0a }, 0x00, { ALPS_PROTO_V2, 0xf8, 0xf8, 0 } },
-	{ { 0x53, 0x02, 0x14 }, 0x00, { ALPS_PROTO_V2, 0xf8, 0xf8, 0 } },
-	{ { 0x60, 0x03, 0xc8 }, 0x00, { ALPS_PROTO_V2, 0xf8, 0xf8, 0 } },				=
/* HP ze1115 */
-	{ { 0x63, 0x02, 0x0a }, 0x00, { ALPS_PROTO_V2, 0xf8, 0xf8, 0 } },
-	{ { 0x63, 0x02, 0x14 }, 0x00, { ALPS_PROTO_V2, 0xf8, 0xf8, 0 } },
-	{ { 0x63, 0x02, 0x28 }, 0x00, { ALPS_PROTO_V2, 0xf8, 0xf8, ALPS_FW_BK=
_2 } },		/* Fujitsu Siemens S6010 */
-	{ { 0x63, 0x02, 0x3c }, 0x00, { ALPS_PROTO_V2, 0x8f, 0x8f, ALPS_WHEEL=
 } },		/* Toshiba Satellite S2400-103 */
-	{ { 0x63, 0x02, 0x50 }, 0x00, { ALPS_PROTO_V2, 0xef, 0xef, ALPS_FW_BK=
_1 } },		/* NEC Versa L320 */
-	{ { 0x63, 0x02, 0x64 }, 0x00, { ALPS_PROTO_V2, 0xf8, 0xf8, 0 } },
-	{ { 0x63, 0x03, 0xc8 }, 0x00, { ALPS_PROTO_V2, 0xf8, 0xf8, ALPS_PASS =
| ALPS_DUALPOINT } },	/* Dell Latitude D800 */
-	{ { 0x73, 0x00, 0x0a }, 0x00, { ALPS_PROTO_V2, 0xf8, 0xf8, ALPS_DUALP=
OINT } },		/* ThinkPad R61 8918-5QG */
-	{ { 0x73, 0x02, 0x0a }, 0x00, { ALPS_PROTO_V2, 0xf8, 0xf8, 0 } },
-	{ { 0x73, 0x02, 0x14 }, 0x00, { ALPS_PROTO_V2, 0xf8, 0xf8, ALPS_FW_BK=
_2 } },		/* Ahtec Laptop */
-
+static const struct alps_v2_model_info alps_v2_model_data[] =3D {
 	/*
 	 * XXX This entry is suspicious. First byte has zero lower nibble,
 	 * which is what a normal mouse would report. Also, the value 0x0e
 	 * isn't valid per PS/2 spec.
 	 */
-	{ { 0x20, 0x02, 0x0e }, 0x00, { ALPS_PROTO_V2, 0xf8, 0xf8, ALPS_PASS =
| ALPS_DUALPOINT } },
-
-	{ { 0x22, 0x02, 0x0a }, 0x00, { ALPS_PROTO_V2, 0xf8, 0xf8, ALPS_PASS =
| ALPS_DUALPOINT } },
-	{ { 0x22, 0x02, 0x14 }, 0x00, { ALPS_PROTO_V2, 0xff, 0xff, ALPS_PASS =
| ALPS_DUALPOINT } },	/* Dell Latitude D600 */
-	/* Dell Latitude E5500, E6400, E6500, Precision M4400 */
-	{ { 0x62, 0x02, 0x14 }, 0x00, { ALPS_PROTO_V2, 0xcf, 0xcf,
-		ALPS_PASS | ALPS_DUALPOINT | ALPS_PS2_INTERLEAVED } },
-	{ { 0x73, 0x02, 0x50 }, 0x00, { ALPS_PROTO_V2, 0xcf, 0xcf, ALPS_FOUR_=
BUTTONS } },	/* Dell Vostro 1400 */
-	{ { 0x52, 0x01, 0x14 }, 0x00, { ALPS_PROTO_V2, 0xff, 0xff,
+	{ { 0x20, 0x02, 0x0e }, { ALPS_PROTO_V2, 0xf8, 0xf8, ALPS_PASS | ALPS=
_DUALPOINT } },
+
+	{ { 0x22, 0x02, 0x0a }, { ALPS_PROTO_V2, 0xf8, 0xf8, ALPS_PASS | ALPS=
_DUALPOINT } },
+	{ { 0x22, 0x02, 0x14 }, { ALPS_PROTO_V2, 0xff, 0xff, ALPS_PASS | ALPS=
_DUALPOINT } },	/* Dell Latitude D600 */
+	{ { 0x32, 0x02, 0x14 }, { ALPS_PROTO_V2, 0xf8, 0xf8, ALPS_PASS | ALPS=
_DUALPOINT } },	/* Toshiba Salellite Pro M10 */
+	{ { 0x52, 0x01, 0x14 }, { ALPS_PROTO_V2, 0xff, 0xff,
 		ALPS_PASS | ALPS_DUALPOINT | ALPS_PS2_INTERLEAVED } },				/* Toshiba=
 Tecra A11-11L */
+	{ { 0x53, 0x02, 0x0a }, { ALPS_PROTO_V2, 0xf8, 0xf8, 0 } },
+	{ { 0x53, 0x02, 0x14 }, { ALPS_PROTO_V2, 0xf8, 0xf8, 0 } },
+	{ { 0x60, 0x03, 0xc8 }, { ALPS_PROTO_V2, 0xf8, 0xf8, 0 } },				/* HP =
ze1115 */
+	{ { 0x62, 0x02, 0x14 }, { ALPS_PROTO_V2, 0xcf, 0xcf,
+		ALPS_PASS | ALPS_DUALPOINT | ALPS_PS2_INTERLEAVED } },				/* Dell La=
titude E5500, E6400, E6500, Precision M4400 */
+	{ { 0x63, 0x02, 0x0a }, { ALPS_PROTO_V2, 0xf8, 0xf8, 0 } },
+	{ { 0x63, 0x02, 0x14 }, { ALPS_PROTO_V2, 0xf8, 0xf8, 0 } },
+	{ { 0x63, 0x02, 0x28 }, { ALPS_PROTO_V2, 0xf8, 0xf8, ALPS_FW_BK_2 } }=
,			/* Fujitsu Siemens S6010 */
+	{ { 0x63, 0x02, 0x3c }, { ALPS_PROTO_V2, 0x8f, 0x8f, ALPS_WHEEL } },	=
		/* Toshiba Satellite S2400-103 */
+	{ { 0x63, 0x02, 0x50 }, { ALPS_PROTO_V2, 0xef, 0xef, ALPS_FW_BK_1 } }=
,			/* NEC Versa L320 */
+	{ { 0x63, 0x02, 0x64 }, { ALPS_PROTO_V2, 0xf8, 0xf8, 0 } },
+	{ { 0x63, 0x03, 0xc8 }, { ALPS_PROTO_V2, 0xf8, 0xf8, ALPS_PASS | ALPS=
_DUALPOINT } },	/* Dell Latitude D800 */
+	{ { 0x73, 0x00, 0x0a }, { ALPS_PROTO_V2, 0xf8, 0xf8, ALPS_DUALPOINT }=
 },		/* ThinkPad R61 8918-5QG */
+	{ { 0x73, 0x02, 0x0a }, { ALPS_PROTO_V2, 0xf8, 0xf8, 0 } },
+	{ { 0x73, 0x02, 0x14 }, { ALPS_PROTO_V2, 0xf8, 0xf8, ALPS_FW_BK_2 } }=
,			/* Ahtec Laptop */
+	{ { 0x73, 0x02, 0x50 }, { ALPS_PROTO_V2, 0xcf, 0xcf, ALPS_FOUR_BUTTON=
S } },		/* Dell Vostro 1400 */
 };
=20
 static const struct alps_protocol_info alps_v1_protocol_data =3D {
@@ -2714,21 +2712,17 @@ static int alps_set_protocol(struct psmouse *ps=
mouse,
 	return 0;
 }
=20
-static const struct alps_protocol_info *alps_match_table(unsigned char=
 *e7,
-							 unsigned char *ec)
+static const struct alps_protocol_info *alps_v2_match_table(unsigned c=
har *e7,
+							    unsigned char *ec)
 {
-	const struct alps_model_info *model;
+	const struct alps_v2_model_info *model;
 	int i;
=20
-	for (i =3D 0; i < ARRAY_SIZE(alps_model_data); i++) {
-		model =3D &alps_model_data[i];
-
-		if (!memcmp(e7, model->signature, sizeof(model->signature)) &&
-		    (!model->command_mode_resp ||
-		     model->command_mode_resp =3D=3D ec[2])) {
+	for (i =3D 0; i < ARRAY_SIZE(alps_v2_model_data); i++) {
+		model =3D &alps_v2_model_data[i];
=20
+		if (!memcmp(e7, model->signature, sizeof(model->signature)))
 			return &model->protocol_info;
-		}
 	}
=20
 	return NULL;
@@ -2764,7 +2758,7 @@ static int alps_identify(struct psmouse *psmouse,=
 struct alps_data *priv)
 	    alps_exit_command_mode(psmouse))
 		return -EIO;
=20
-	protocol =3D alps_match_table(e7, ec);
+	protocol =3D alps_v2_match_table(e7, ec);
 	if (!protocol) {
 		if (e7[0] =3D=3D 0x33 && e7[1] =3D=3D 0x02 && e7[2] =3D=3D 0x0a) {
 			protocol =3D &alps_v1_protocol_data;
diff --git a/drivers/input/mouse/alps.h b/drivers/input/mouse/alps.h
index fd0a359..8b56169 100644
--- a/drivers/input/mouse/alps.h
+++ b/drivers/input/mouse/alps.h
@@ -139,21 +139,16 @@ struct alps_protocol_info {
 };
=20
 /**
- * struct alps_model_info - touchpad ID table
+ * struct alps_v2_model_info - touchpad ID table
  * @signature: E7 response string to match.
- * @command_mode_resp: For V3/V4 touchpads, the final byte of the EC r=
esponse
- *   (aka command mode response) identifies the firmware minor version=
=2E  This
- *   can be used to distinguish different hardware models which are no=
t
- *   uniquely identifiable through their E7 responses.
  * @protocol_info: information about protcol used by the device.
  *
  * Many (but not all) ALPS touchpads can be identified by looking at t=
he
  * values returned in the "E7 report" and/or the "EC report."  This ta=
ble
  * lists a number of such touchpads.
  */
-struct alps_model_info {
+struct alps_v2_model_info {
 	u8 signature[3];
-	u8 command_mode_resp;
 	struct alps_protocol_info protocol_info;
 };
=20
--=20
1.7.9.5
