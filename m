From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH 5/7] input: alps: Fix name, product and version of dev2 input device
Date: Fri, 14 Nov 2014 20:38:24 +0100
Message-ID: <1415993906-13307-6-git-send-email-pali.rohar@gmail.com>
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

This patch fix name, product and version of dev2 input device based on =
format
used in function psmouse_switch_protocol() in file psmouse-base.c.

Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
---
 drivers/input/mouse/alps.c |   18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 0176425..2b7b74d 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -2407,14 +2407,24 @@ int alps_init(struct psmouse *psmouse)
 		dev1->keybit[BIT_WORD(BTN_MIDDLE)] |=3D BIT_MASK(BTN_MIDDLE);
 	}
=20
+	if (priv->flags & ALPS_DUALPOINT) {
+		/*
+		 * format of input device name is: "protocol vendor name"
+		 * see function psmouse_switch_protocol() in psmouse-base.c
+		 */
+		dev2->name =3D "AlpsPS/2 ALPS DualPoint Stick";
+		dev2->id.product =3D PSMOUSE_ALPS;
+		dev2->id.version =3D priv->proto_version;
+	} else {
+		dev2->name =3D "PS/2 ALPS Mouse";
+		dev2->id.product =3D PSMOUSE_PS2;
+		dev2->id.version =3D 0x0000;
+	}
+
 	snprintf(priv->phys, sizeof(priv->phys), "%s/input1", psmouse->ps2dev=
=2Eserio->phys);
 	dev2->phys =3D priv->phys;
-	dev2->name =3D (priv->flags & ALPS_DUALPOINT) ?
-		     "DualPoint Stick" : "ALPS PS/2 Device";
 	dev2->id.bustype =3D BUS_I8042;
 	dev2->id.vendor  =3D 0x0002;
-	dev2->id.product =3D PSMOUSE_ALPS;
-	dev2->id.version =3D 0x0000;
 	dev2->dev.parent =3D &psmouse->ps2dev.serio->dev;
=20
 	dev2->evbit[0] =3D BIT_MASK(EV_KEY) | BIT_MASK(EV_REL);
--=20
1.7.9.5
