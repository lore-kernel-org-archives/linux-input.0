From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH 4/7] input: alps: Use NULL instead dummy argument for alps_identify
Date: Fri, 14 Nov 2014 20:38:23 +0100
Message-ID: <1415993906-13307-5-git-send-email-pali.rohar@gmail.com>
References: <1415993906-13307-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1415993906-13307-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>
Cc: Yunkang Tang <yunkang.tang@cn.alps.com>, Vadim Klishko <vadim@cirque.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-input@vger.kernel.org

This patch change alps_identify() function code so it can be called als=
o without
priv parameter which is useful for alps_detect(). Instead passing dummy=
 value
now alps_identify() accept also NULL value and skip filling priv data. =
It is
useless for alps_detect() and it will speed up detection of alps device=
s.

Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
---
 drivers/input/mouse/alps.c |  114 +++++++++++++++++++++++++++---------=
--------
 1 file changed, 71 insertions(+), 43 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 5603870..0176425 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -2162,8 +2162,7 @@ static void alps_set_defaults(struct alps_data *p=
riv)
 	}
 }
=20
-static int alps_match_table(struct psmouse *psmouse, struct alps_data =
*priv,
-			    unsigned char *e7, unsigned char *ec)
+static const struct alps_model_info *alps_match_table(unsigned char *e=
7, unsigned char *ec)
 {
 	const struct alps_model_info *model;
 	int i;
@@ -2174,24 +2173,49 @@ static int alps_match_table(struct psmouse *psm=
ouse, struct alps_data *priv,
 		if (!memcmp(e7, model->signature, sizeof(model->signature)) &&
 		    (!model->command_mode_resp ||
 		     model->command_mode_resp =3D=3D ec[2])) {
+			return model;
+		}
+	}
=20
-			priv->proto_version =3D model->proto_version;
-			alps_set_defaults(priv);
+	return NULL;
+}
=20
-			priv->flags =3D model->flags;
-			priv->byte0 =3D model->byte0;
-			priv->mask0 =3D model->mask0;
+static inline bool alps_match_v5(unsigned char *e7, unsigned char *ec)
+{
+	return (e7[0] =3D=3D 0x73 && e7[1] =3D=3D 0x03 && e7[2] =3D=3D 0x50 &=
&
+		ec[0] =3D=3D 0x73 && (ec[1] =3D=3D 0x01 || ec[1] =3D=3D 0x02));
+}
=20
-			return 0;
-		}
-	}
+static inline bool alps_match_v7(unsigned char *e7, unsigned char *ec)
+{
+	return (ec[0] =3D=3D 0x88 &&
+		((ec[1] & 0xf0) =3D=3D 0xb0 || (ec[1] & 0xf0) =3D=3D 0xc0));
+}
=20
-	return -EINVAL;
+static inline bool alps_match_rushmore_v3(unsigned char *e7, unsigned =
char *ec)
+{
+	return (ec[0] =3D=3D 0x88 && ec[1] =3D=3D 0x08);
+}
+
+static inline bool alps_match_v3(unsigned char *e7, unsigned char *ec)
+{
+	return (ec[0] =3D=3D 0x88 && ec[1] =3D=3D 0x07 &&
+		ec[2] >=3D 0x90 && ec[2] <=3D 0x9d);
+}
+
+static inline bool alps_match_any(unsigned char *e7, unsigned char *ec=
)
+{
+	return (alps_match_table(e7, ec) ||
+		alps_match_v5(e7, ec) ||
+		alps_match_v7(e7, ec) ||
+		alps_match_rushmore_v3(e7, ec) ||
+		alps_match_v3(e7, ec));
 }
=20
 static int alps_identify(struct psmouse *psmouse, struct alps_data *pr=
iv)
 {
 	unsigned char e6[4], e7[4], ec[4];
+	const struct alps_model_info *model;
=20
 	/*
 	 * First try "E6 report".
@@ -2217,40 +2241,46 @@ static int alps_identify(struct psmouse *psmous=
e, struct alps_data *priv)
 	    alps_exit_command_mode(psmouse))
 		return -EIO;
=20
-	/* Save the Firmware version */
-	memcpy(priv->fw_ver, ec, 3);
+	if (priv) {
=20
-	if (alps_match_table(psmouse, priv, e7, ec) =3D=3D 0) {
-		return 0;
-	} else if (e7[0] =3D=3D 0x73 && e7[1] =3D=3D 0x03 && e7[2] =3D=3D 0x5=
0 &&
-		   ec[0] =3D=3D 0x73 && (ec[1] =3D=3D 0x01 || ec[1] =3D=3D 0x02)) {
-		priv->proto_version =3D ALPS_PROTO_V5;
-		alps_set_defaults(priv);
+		/* Save the Firmware version */
+		memcpy(priv->fw_ver, ec, 3);
=20
-		return 0;
-	} else if (ec[0] =3D=3D 0x88 &&
-		   ((ec[1] & 0xf0) =3D=3D 0xb0 || (ec[1] & 0xf0) =3D=3D 0xc0)) {
-		priv->proto_version =3D ALPS_PROTO_V7;
-		alps_set_defaults(priv);
-
-		return 0;
-	} else if (ec[0] =3D=3D 0x88 && ec[1] =3D=3D 0x08) {
-		priv->proto_version =3D ALPS_PROTO_V3;
-		alps_set_defaults(priv);
+		if ((model =3D alps_match_table(e7, ec))) {
+			priv->proto_version =3D model->proto_version;
+			alps_set_defaults(priv);
+			priv->flags =3D model->flags;
+			priv->byte0 =3D model->byte0;
+			priv->mask0 =3D model->mask0;
+			return 0;
+		} else if (alps_match_v5(e7, ec)) {
+			priv->proto_version =3D ALPS_PROTO_V5;
+			alps_set_defaults(priv);
+			return 0;
+		} else if (alps_match_v7(e7, ec)) {
+			priv->proto_version =3D ALPS_PROTO_V7;
+			alps_set_defaults(priv);
+			return 0;
+		} else if (alps_match_rushmore_v3(e7, ec)) {
+			priv->proto_version =3D ALPS_PROTO_V3;
+			alps_set_defaults(priv);
+			priv->hw_init =3D alps_hw_init_rushmore_v3;
+			priv->decode_fields =3D alps_decode_rushmore;
+			priv->x_bits =3D 16;
+			priv->y_bits =3D 12;
+			priv->flags |=3D ALPS_IS_RUSHMORE;
+			return 0;
+		} else if (alps_match_v3(e7, ec)) {
+			priv->proto_version =3D ALPS_PROTO_V3;
+			alps_set_defaults(priv);
+			return 0;
+		}
=20
-		priv->hw_init =3D alps_hw_init_rushmore_v3;
-		priv->decode_fields =3D alps_decode_rushmore;
-		priv->x_bits =3D 16;
-		priv->y_bits =3D 12;
-		priv->flags |=3D ALPS_IS_RUSHMORE;
+	} else {
=20
-		return 0;
-	} else if (ec[0] =3D=3D 0x88 && ec[1] =3D=3D 0x07 &&
-		   ec[2] >=3D 0x90 && ec[2] <=3D 0x9d) {
-		priv->proto_version =3D ALPS_PROTO_V3;
-		alps_set_defaults(priv);
+		if (alps_match_any(e7, ec))
+			return 0;
=20
-		return 0;
 	}
=20
 	psmouse_dbg(psmouse,
@@ -2427,9 +2457,7 @@ init_fail:
=20
 int alps_detect(struct psmouse *psmouse, bool set_properties)
 {
-	struct alps_data dummy;
-
-	if (alps_identify(psmouse, &dummy) < 0)
+	if (alps_identify(psmouse, NULL) < 0)
 		return -1;
=20
 	if (set_properties) {
--=20
1.7.9.5
