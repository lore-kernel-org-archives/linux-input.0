From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH 3/7] input: alps: Move alps_dolphin_get_device_area into alps_hw_init_dolphin_v1
Date: Fri, 14 Nov 2014 20:38:22 +0100
Message-ID: <1415993906-13307-4-git-send-email-pali.rohar@gmail.com>
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

This patch moves function call alps_dolphin_get_device_area() from func=
tion
alps_identify() to alps_hw_init_dolphin_v1() so alps_identify() will no=
t call
any other psmouse commands.

Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
---
 drivers/input/mouse/alps.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index cbfdcfc..5603870 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -1991,9 +1991,9 @@ error:
 	return -1;
 }
=20
-static int alps_dolphin_get_device_area(struct psmouse *psmouse,
-					struct alps_data *priv)
+static int alps_dolphin_get_device_area(struct psmouse *psmouse)
 {
+	struct alps_data *priv =3D psmouse->private;
 	struct ps2dev *ps2dev =3D &psmouse->ps2dev;
 	unsigned char param[4] =3D {0};
 	int num_x_electrode, num_y_electrode;
@@ -2042,6 +2042,9 @@ static int alps_hw_init_dolphin_v1(struct psmouse=
 *psmouse)
 	struct ps2dev *ps2dev =3D &psmouse->ps2dev;
 	unsigned char param[2];
=20
+	if (alps_dolphin_get_device_area(psmouse))
+		return -EIO;
+
 	/* This is dolphin "v1" as empirically defined by florin9doi */
 	param[0] =3D 0x64;
 	param[1] =3D 0x28;
@@ -2223,10 +2226,8 @@ static int alps_identify(struct psmouse *psmouse=
, struct alps_data *priv)
 		   ec[0] =3D=3D 0x73 && (ec[1] =3D=3D 0x01 || ec[1] =3D=3D 0x02)) {
 		priv->proto_version =3D ALPS_PROTO_V5;
 		alps_set_defaults(priv);
-		if (alps_dolphin_get_device_area(psmouse, priv))
-			return -EIO;
-		else
-			return 0;
+
+		return 0;
 	} else if (ec[0] =3D=3D 0x88 &&
 		   ((ec[1] & 0xf0) =3D=3D 0xb0 || (ec[1] & 0xf0) =3D=3D 0xc0)) {
 		priv->proto_version =3D ALPS_PROTO_V7;
--=20
1.7.9.5
