From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH] Input: ALPS - Detect trackstick presence for v7 protocol
Date: Sun, 22 Mar 2015 14:46:11 +0100
Message-ID: <1427031971-13018-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:35865 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731AbbCVNqd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 22 Mar 2015 09:46:33 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Santiago Gala <sgala@apache.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>

This patch adds detection of trackstick for v7 protocol devices. Code i=
n this
patch is used in official Dell touchpad linux drivers for Dell models:
Dell Latitude E5250/5250, E5450/5450, E5550/5550

Detection code and base reg for alps v3 rushmore and v7 devices is exac=
ly same.

Also user in bug https://bugzilla.kernel.org/show_bug.cgi?id=3D94801 re=
ported
that Toshiba Sattellite Z30-A-1DG has only alps v7 touchpad device with=
out
trackstick and kernel reports to userspace also redundant trackstick de=
vice.

Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
---
 drivers/input/mouse/alps.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 33198b9..c9cd27a 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -30,6 +30,7 @@
 #define ALPS_CMD_NIBBLE_10	0x01f2
=20
 #define ALPS_REG_BASE_RUSHMORE	0xc2c0
+#define ALPS_REG_BASE_V7	0xc2c0
 #define ALPS_REG_BASE_PINNACLE	0x0000
=20
 static const struct alps_nibble_commands alps_v3_nibble_commands[] =3D=
 {
@@ -1795,7 +1796,7 @@ static int alps_absolute_mode_v3(struct psmouse *=
psmouse)
 	return 0;
 }
=20
-static int alps_probe_trackstick_v3(struct psmouse *psmouse, int reg_b=
ase)
+static int alps_probe_trackstick_v3_v7(struct psmouse *psmouse, int re=
g_base)
 {
 	int ret =3D -EIO, reg_val;
=20
@@ -1880,7 +1881,7 @@ static int alps_hw_init_v3(struct psmouse *psmous=
e)
 	int reg_val;
 	unsigned char param[4];
=20
-	reg_val =3D alps_probe_trackstick_v3(psmouse, ALPS_REG_BASE_PINNACLE)=
;
+	reg_val =3D alps_probe_trackstick_v3_v7(psmouse, ALPS_REG_BASE_PINNAC=
LE);
 	if (reg_val =3D=3D -EIO)
 		goto error;
=20
@@ -2260,8 +2261,8 @@ static int alps_set_protocol(struct psmouse *psmo=
use,
 		priv->x_bits =3D 16;
 		priv->y_bits =3D 12;
=20
-		if (alps_probe_trackstick_v3(psmouse,
-					     ALPS_REG_BASE_RUSHMORE) < 0)
+		if (alps_probe_trackstick_v3_v7(psmouse,
+						ALPS_REG_BASE_RUSHMORE) < 0)
 			priv->flags &=3D ~ALPS_DUALPOINT;
=20
 		break;
@@ -2311,6 +2312,9 @@ static int alps_set_protocol(struct psmouse *psmo=
use,
 		if (priv->fw_ver[1] !=3D 0xba)
 			priv->flags |=3D ALPS_BUTTONPAD;
=20
+		if (alps_probe_trackstick_v3_v7(psmouse, ALPS_REG_BASE_V7) < 0)
+			priv->flags &=3D ~ALPS_DUALPOINT;
+
 		break;
 	}
=20
--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
