From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH] Input: ALPS - Report v3 pinnacle trackstick device only if is present
Date: Sun, 22 Mar 2015 14:47:47 +0100
Message-ID: <1427032068-13066-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-input@vger.kernel.org

This patch move v3 pinnacle code for trackstick detection from alps_hw_=
init_v3()
to alps_set_protocol() so ALPS_DUALPOINT flag can be cleared before reg=
istering
trackstick input device in kernel.

Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
---
 drivers/input/mouse/alps.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index c9cd27a..d24e98d 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -1877,15 +1877,12 @@ error:
=20
 static int alps_hw_init_v3(struct psmouse *psmouse)
 {
+	struct alps_data *priv =3D psmouse->private;
 	struct ps2dev *ps2dev =3D &psmouse->ps2dev;
 	int reg_val;
 	unsigned char param[4];
=20
-	reg_val =3D alps_probe_trackstick_v3_v7(psmouse, ALPS_REG_BASE_PINNAC=
LE);
-	if (reg_val =3D=3D -EIO)
-		goto error;
-
-	if (reg_val =3D=3D 0 &&
+	if ((priv->flags & ALPS_DUALPOINT) &&
 	    alps_setup_trackstick_v3(psmouse, ALPS_REG_BASE_PINNACLE) =3D=3D =
-EIO)
 		goto error;
=20
@@ -2249,6 +2246,11 @@ static int alps_set_protocol(struct psmouse *psm=
ouse,
 		priv->decode_fields =3D alps_decode_pinnacle;
 		priv->nibble_commands =3D alps_v3_nibble_commands;
 		priv->addr_command =3D PSMOUSE_CMD_RESET_WRAP;
+
+		if (alps_probe_trackstick_v3_v7(psmouse,
+						ALPS_REG_BASE_PINNACLE) < 0)
+			priv->flags &=3D ~ALPS_DUALPOINT;
+
 		break;
=20
 	case ALPS_PROTO_V3_RUSHMORE:
--=20
1.7.9.5
