From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH 4/5] Input: alps - warn about unsupported ALPS V9 touchpad
Date: Mon,  6 Jun 2016 13:24:00 +0200
Message-ID: <1465212241-14702-5-git-send-email-pali.rohar@gmail.com>
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

Support for devices with ALPS_PROTO_V9 is not implemented yet but we ca=
n
detect these alps touchpads and warn users about it.

Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
---
 drivers/input/mouse/alps.c |    9 +++++++++
 drivers/input/mouse/alps.h |    1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 4e6d76e..3618320 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -169,6 +169,10 @@ static const struct alps_protocol_info alps_v8_pro=
tocol_data =3D {
 	ALPS_PROTO_V8, 0x18, 0x18, 0
 };
=20
+static const struct alps_protocol_info alps_v9_protocol_data =3D {
+	ALPS_PROTO_V9, 0xc8, 0xc8, 0
+};
+
 /*
  * Some v2 models report the stick buttons in separate bits
  */
@@ -2783,6 +2787,11 @@ static int alps_identify(struct psmouse *psmouse=
, struct alps_data *priv)
 		} else if (e7[0] =3D=3D 0x73 && e7[1] =3D=3D 0x03 &&
 			   e7[2] =3D=3D 0x14 && ec[1] =3D=3D 0x02) {
 			protocol =3D &alps_v8_protocol_data;
+		} else if (e7[0] =3D=3D 0x73 && e7[1] =3D=3D 0x03 && e7[2] =3D=3D 0x=
c8) {
+			protocol =3D &alps_v9_protocol_data;
+			psmouse_warn(psmouse,
+				     "Unsupported ALPS V9 touchpad: E7=3D%3ph, EC=3D%3ph\n", e7, e=
c);
+			return -EINVAL;
 		} else {
 			psmouse_dbg(psmouse,
 				    "Likely not an ALPS touchpad: E7=3D%3ph, EC=3D%3ph\n", e7, ec)=
;
diff --git a/drivers/input/mouse/alps.h b/drivers/input/mouse/alps.h
index d37f814..fd0a359 100644
--- a/drivers/input/mouse/alps.h
+++ b/drivers/input/mouse/alps.h
@@ -23,6 +23,7 @@
 #define ALPS_PROTO_V6		0x600
 #define ALPS_PROTO_V7		0x700	/* t3btl t4s */
 #define ALPS_PROTO_V8		0x800	/* SS4btl SS4s */
+#define ALPS_PROTO_V9		0x900	/* ss3btl */
=20
 #define MAX_TOUCHES	4
=20
--=20
1.7.9.5
