From: =?UTF-8?B?w4lyaWMgUGllbA==?= <E.A.B.Piel@tudelft.nl>
Subject: [NEEDS TEST][PATCH] elantech: discard the first 2 positions reports
 for some firmwares
Date: Sun, 30 May 2010 20:42:21 +0200
Message-ID: <4C02B18D.3050003@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:34885 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752174Ab0E3RhX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 30 May 2010 13:37:23 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Florian Ragwitz <rafl@debian.org>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hello,

Here is a patch to implement a better workaround for the "jumpy cursor"
behaviour. Unfortunately, as I don't have such hardware, this is totall=
y
untested (will, it compiles ;-) ). Hopefully, someone around has access
to such hardware and can test it. Or maybe Florian, or Dmitry, you know
such people?

Cheers,
Eric

8<-------------------------------------------------------
According to the Dell/Ubuntu driver, what was previously observed as "j=
umpy cursor"
corresponds to the hardware sending incorrect data for the first two re=
ports of a=20
one touch finger. So let's use the same workaround as in the other driv=
er. Also,
detect another firmware version with the same behaviour, as in the othe=
r driver.

Signed-off-by: =C3=89ric Piel <eric.piel@tremplin-utc.net>
---
 drivers/input/mouse/elantech.c |   23 +++++++++++------------
 1 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elant=
ech.c
index b18862b..1c1d065 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -185,7 +185,7 @@ static void elantech_report_absolute_v1(struct psmo=
use *psmouse)
 	struct elantech_data *etd =3D psmouse->private;
 	unsigned char *packet =3D psmouse->packet;
 	int fingers;
-	static int old_fingers;
+	static int one_finger_reports;
=20
 	if (etd->fw_version < 0x020000) {
 		/*
@@ -203,11 +203,13 @@ static void elantech_report_absolute_v1(struct ps=
mouse *psmouse)
 	}
=20
 	if (etd->jumpy_cursor) {
-		/* Discard packets that are likely to have bogus coordinates */
-		if (fingers > old_fingers) {
+		if ((fingers =3D=3D 1) && (one_finger_reports < 2)) {
+			/* Discard first 2 reports of one finger, bogus */
+			one_finger_reports++;
 			elantech_debug("discarding packet\n");
-			goto discard_packet_v1;
-		}
+			return;
+		} else if (fingers !=3D 1)
+			one_finger_reports =3D 0;
 	}
=20
 	input_report_key(dev, BTN_TOUCH, fingers !=3D 0);
@@ -238,9 +240,6 @@ static void elantech_report_absolute_v1(struct psmo=
use *psmouse)
 	}
=20
 	input_sync(dev);
-
- discard_packet_v1:
-	old_fingers =3D fingers;
 }
=20
 /*
@@ -733,12 +732,12 @@ int elantech_init(struct psmouse *psmouse)
 	etd->capabilities =3D param[0];
=20
 	/*
-	 * This firmware seems to suffer from misreporting coordinates when
+	 * This firmware suffers from misreporting coordinates when
 	 * a touch action starts causing the mouse cursor or scrolled page
 	 * to jump. Enable a workaround.
 	 */
-	if (etd->fw_version =3D=3D 0x020022) {
-		pr_info("firmware version 2.0.34 detected, enabling jumpy cursor wor=
karound\n");
+	if ((etd->fw_version =3D=3D 0x020022) || (etd->fw_version =3D=3D 0x02=
0600)) {
+		pr_info("firmware version 2.0.34/2.6.0 detected, enabling jumpy curs=
or workaround\n");
 		etd->jumpy_cursor =3D 1;
 	}
=20
--=20
1.7.1


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
