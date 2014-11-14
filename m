From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH 2/7] input: alps: Move trackstick detection to alps_hw_init_*
Date: Fri, 14 Nov 2014 20:38:21 +0100
Message-ID: <1415993906-13307-3-git-send-email-pali.rohar@gmail.com>
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

Now when alps_identify() does not need do trackstick detection it is sa=
fe to
move code init hw_init functions.

This patch also fix trackstick detection in function alps_hw_init_v3() =
which
remove ALPS_DUALPOINT flag when trackstick is not detected.

Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
---
 drivers/input/mouse/alps.c |   30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 9ffa98d..cbfdcfc 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -1732,6 +1732,7 @@ error:
=20
 static int alps_hw_init_v3(struct psmouse *psmouse)
 {
+	struct alps_data *priv =3D psmouse->private;
 	struct ps2dev *ps2dev =3D &psmouse->ps2dev;
 	int reg_val;
 	unsigned char param[4];
@@ -1740,9 +1741,15 @@ static int alps_hw_init_v3(struct psmouse *psmou=
se)
 	if (reg_val =3D=3D -EIO)
 		goto error;
=20
-	if (reg_val =3D=3D 0 &&
-	    alps_setup_trackstick_v3(psmouse, ALPS_REG_BASE_PINNACLE) =3D=3D =
-EIO)
-		goto error;
+	if (reg_val =3D=3D 0) {
+		reg_val =3D alps_setup_trackstick_v3(psmouse,
+						   ALPS_REG_BASE_PINNACLE);
+		if (reg_val =3D=3D -EIO)
+			goto error;
+	}
+
+	if (reg_val =3D=3D -ENODEV)
+		priv->flags &=3D ~ALPS_DUALPOINT;
=20
 	if (alps_enter_command_mode(psmouse) ||
 	    alps_absolute_mode_v3(psmouse)) {
@@ -1849,15 +1856,20 @@ static int alps_hw_init_rushmore_v3(struct psmo=
use *psmouse)
 	struct ps2dev *ps2dev =3D &psmouse->ps2dev;
 	int reg_val, ret =3D -1;
=20
-	if (priv->flags & ALPS_DUALPOINT) {
+	reg_val =3D alps_probe_trackstick_v3(psmouse, ALPS_REG_BASE_RUSHMORE)=
;
+	if (reg_val =3D=3D -EIO)
+		goto error;
+
+	if (reg_val =3D=3D 0) {
 		reg_val =3D alps_setup_trackstick_v3(psmouse,
 						   ALPS_REG_BASE_RUSHMORE);
 		if (reg_val =3D=3D -EIO)
 			goto error;
-		if (reg_val =3D=3D -ENODEV)
-			priv->flags &=3D ~ALPS_DUALPOINT;
 	}
=20
+	if (reg_val =3D=3D -ENODEV)
+		priv->flags &=3D ~ALPS_DUALPOINT;
+
 	if (alps_enter_command_mode(psmouse) ||
 	    alps_command_mode_read_reg(psmouse, 0xc2d9) =3D=3D -1 ||
 	    alps_command_mode_write_reg(psmouse, 0xc2cb, 0x00))
@@ -2231,12 +2243,6 @@ static int alps_identify(struct psmouse *psmouse=
, struct alps_data *priv)
 		priv->y_bits =3D 12;
 		priv->flags |=3D ALPS_IS_RUSHMORE;
=20
-		/* hack to make addr_command, nibble_command available */
-		psmouse->private =3D priv;
-
-		if (alps_probe_trackstick_v3(psmouse, ALPS_REG_BASE_RUSHMORE))
-			priv->flags &=3D ~ALPS_DUALPOINT;
-
 		return 0;
 	} else if (ec[0] =3D=3D 0x88 && ec[1] =3D=3D 0x07 &&
 		   ec[2] >=3D 0x90 && ec[2] <=3D 0x9d) {
--=20
1.7.9.5
