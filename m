From: Paul Donohue <linux-kernel@PaulSD.com>
Subject: [PATCH v6 3/3] Input: ALPS - Clean up code for SS5 hardware
Date: Thu, 24 Nov 2016 09:25:53 -0500
Message-ID: <1479997553-25877-4-git-send-email-linux-kernel@PaulSD.com>
References: <201611111459.12642@pali>
 <1479997553-25877-1-git-send-email-linux-kernel@PaulSD.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from Lepton.TopQuark.net ([168.235.66.66]:40447 "EHLO
        Mail2.TopQuark.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965482AbcKXO0b (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 24 Nov 2016 09:26:31 -0500
In-Reply-To: <1479997553-25877-1-git-send-email-linux-kernel@PaulSD.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Ben Gamari <ben@smart-cactus.org>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Michal Hocko <mhocko@suse.com>, Paul Donohue <linux-kernel@PaulSD.com>

The return value of alps_get_pkt_id_ss4_v2() should really be
"enum SS4_PACKET_ID", not "unsigned char".  Correct this.

Also, most of the Alps SS5 (SS4 v2) packet byte parsing code is
implemented using macros, but there are a few places where bytes are
directly manipulated in alps.c.  For consistency, migrate the rest of
these to macros.

Reviewed-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
Signed-off-by: Paul Donohue <linux-kernel@PaulSD.com>
---
 drivers/input/mouse/alps.c | 24 ++++++++----------------
 drivers/input/mouse/alps.h | 22 +++++++++++++++++++++-
 2 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 61d61cc..c984b8c 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -1153,15 +1153,13 @@ static void alps_process_packet_v7(struct psmouse=
 *psmouse)
 		alps_process_touchpad_packet_v7(psmouse);
 }
=20
-static unsigned char alps_get_pkt_id_ss4_v2(unsigned char *byte)
+static enum SS4_PACKET_ID alps_get_pkt_id_ss4_v2(unsigned char *byte)
 {
-	unsigned char pkt_id =3D SS4_PACKET_ID_IDLE;
+	enum SS4_PACKET_ID pkt_id =3D SS4_PACKET_ID_IDLE;
=20
 	switch (byte[3] & 0x30) {
 	case 0x00:
-		if (byte[0] =3D=3D 0x18 && byte[1] =3D=3D 0x10 && byte[2] =3D=3D 0x00 =
&&
-		    (byte[3] & 0x88) =3D=3D 0x08 && byte[4] =3D=3D 0x10 &&
-		    byte[5] =3D=3D 0x00) {
+		if (SS4_IS_IDLE_V2(byte)) {
 			pkt_id =3D SS4_PACKET_ID_IDLE;
 		} else {
 			pkt_id =3D SS4_PACKET_ID_ONE;
@@ -1188,7 +1186,7 @@ static int alps_decode_ss4_v2(struct alps_fields *f=
,
 			      unsigned char *p, struct psmouse *psmouse)
 {
 	struct alps_data *priv =3D psmouse->private;
-	unsigned char pkt_id;
+	enum SS4_PACKET_ID pkt_id;
 	unsigned int no_data_x, no_data_y;
=20
 	pkt_id =3D alps_get_pkt_id_ss4_v2(p);
@@ -1306,7 +1304,6 @@ static void alps_process_packet_ss4_v2(struct psmou=
se *psmouse)
 	struct input_dev *dev =3D psmouse->dev;
 	struct input_dev *dev2 =3D priv->dev2;
 	struct alps_fields *f =3D &priv->f;
-	int x, y, pressure;
=20
 	memset(f, 0, sizeof(struct alps_fields));
 	priv->decode_fields(f, packet, psmouse);
@@ -1349,13 +1346,9 @@ static void alps_process_packet_ss4_v2(struct psmo=
use *psmouse)
 			return;
 		}
=20
-		x =3D (s8)(((packet[0] & 1) << 7) | (packet[1] & 0x7f));
-		y =3D (s8)(((packet[3] & 1) << 7) | (packet[2] & 0x7f));
-		pressure =3D (s8)(packet[4] & 0x7f);
-
-		input_report_rel(dev2, REL_X, x);
-		input_report_rel(dev2, REL_Y, -y);
-		input_report_abs(dev2, ABS_PRESSURE, pressure);
+		input_report_rel(dev2, REL_X, SS4_TS_X_V2(packet));
+		input_report_rel(dev2, REL_Y, SS4_TS_Y_V2(packet));
+		input_report_abs(dev2, ABS_PRESSURE, SS4_TS_Z_V2(packet));
=20
 		input_report_key(dev2, BTN_LEFT, f->ts_left);
 		input_report_key(dev2, BTN_RIGHT, f->ts_right);
@@ -1367,14 +1360,13 @@ static void alps_process_packet_ss4_v2(struct psm=
ouse *psmouse)
=20
 	/* Report touchpad */
 	alps_report_mt_data(psmouse, (f->fingers <=3D 4) ? f->fingers : 4);
-
 	input_mt_report_finger_count(dev, f->fingers);
+	input_report_abs(dev, ABS_PRESSURE, f->pressure);
=20
 	input_report_key(dev, BTN_LEFT, f->left);
 	input_report_key(dev, BTN_RIGHT, f->right);
 	input_report_key(dev, BTN_MIDDLE, f->middle);
=20
-	input_report_abs(dev, ABS_PRESSURE, f->pressure);
 	input_sync(dev);
 }
=20
diff --git a/drivers/input/mouse/alps.h b/drivers/input/mouse/alps.h
index b9417e2..96e1d1d 100644
--- a/drivers/input/mouse/alps.h
+++ b/drivers/input/mouse/alps.h
@@ -54,7 +54,15 @@ enum SS4_PACKET_ID {
=20
 #define SS4_MASK_NORMAL_BUTTONS		0x07
=20
-#define SS4_1F_X_V2(_b)		((_b[0] & 0x0007) |		\
+#define SS4_IS_IDLE_V2(_b)	(((_b[0]) =3D=3D 0x18) &&		\
+				 ((_b[1]) =3D=3D 0x10) &&		\
+				 ((_b[2]) =3D=3D 0x00) &&		\
+				 ((_b[3] & 0x88) =3D=3D 0x08) &&	\
+				 ((_b[4]) =3D=3D 0x10) &&		\
+				 ((_b[5]) =3D=3D 0x00)		\
+				)
+
+#define SS4_1F_X_V2(_b)		(((_b[0]) & 0x0007) |		\
 				 ((_b[1] << 3) & 0x0078) |	\
 				 ((_b[1] << 2) & 0x0380) |	\
 				 ((_b[2] << 5) & 0x1C00)	\
@@ -101,6 +109,18 @@ enum SS4_PACKET_ID {
 #define SS4_IS_MF_CONTINUE(_b)	((_b[2] & 0x10) =3D=3D 0x10)
 #define SS4_IS_5F_DETECTED(_b)	((_b[2] & 0x10) =3D=3D 0x10)
=20
+#define SS4_TS_X_V2(_b)		(s8)(				\
+				 ((_b[0] & 0x01) << 7) |	\
+				 ((_b[1]) & 0x7F)		\
+				)
+
+#define SS4_TS_Y_V2(_b)		-(s8)(				\
+				 ((_b[3] & 0x01) << 7) |	\
+				 ((_b[2]) & 0x7F)		\
+				)
+
+#define SS4_TS_Z_V2(_b)		(s8)(_b[4] & 0x7F)
+
=20
 #define SS4_MFPACKET_NO_AX	8160	/* X-Coordinate value */
 #define SS4_MFPACKET_NO_AY	4080	/* Y-Coordinate value */
--=20
2.7.4

