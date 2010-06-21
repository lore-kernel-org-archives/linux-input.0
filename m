From: =?UTF-8?B?w4lyaWMgUGllbA==?= <E.A.B.Piel@tudelft.nl>
Subject: [PATCH 5/7] elantech: report position also with 3 fingers
Date: Mon, 21 Jun 2010 23:07:24 +0200
Message-ID: <4C1FD48C.3040506@tudelft.nl>
References: <4C1FD2B0.1080504@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:37103 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758574Ab0FUVIH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Jun 2010 17:08:07 -0400
In-Reply-To: <4C1FD2B0.1080504@tudelft.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: Florian Ragwitz <rafl@debian.org>


The 6-byte protocol supports reporting the position when three fingers
are pressed, exactly like when one finger is pressed. Report this.

In addition, it is also distinguishes between 3 and 4 fingers pressed.

Signed-off-by: =C3=89ric Piel <eric.piel@tremplin-utc.net>
---
 drivers/input/mouse/elantech.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elant=
ech.c
index b09b458..633f100 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -257,6 +257,14 @@ static void elantech_report_absolute_v2(struct psm=
ouse *psmouse)
 	input_report_key(dev, BTN_TOUCH, fingers !=3D 0);
  	switch (fingers) {
+	case 3:
+		/*
+		 * Same as one finger, except report of more than 3 fingers:
+		 * byte 3:  n4  .   w1  w0   .   .   .   .
+		 */
+		if (packet[3] & 0x80)
+			fingers =3D 4;
+		/* pass through... */
 	case 1:
 		/*
 		 * byte 1:  .   .   .   .   .  x10 x9  x8
@@ -309,6 +317,7 @@ static void elantech_report_absolute_v2(struct psmo=
use *psmouse)
 	input_report_key(dev, BTN_TOOL_FINGER, fingers =3D=3D 1);
 	input_report_key(dev, BTN_TOOL_DOUBLETAP, fingers =3D=3D 2);
 	input_report_key(dev, BTN_TOOL_TRIPLETAP, fingers =3D=3D 3);
+	input_report_key(dev, BTN_TOOL_QUADTAP, fingers =3D=3D 4);
 	input_report_key(dev, BTN_LEFT, packet[0] & 0x01);
 	input_report_key(dev, BTN_RIGHT, packet[0] & 0x02);
 @@ -519,6 +528,7 @@ static void elantech_set_input_params(struct psmou=
se *psmouse)
 		break;
  	case 2:
+		__set_bit(BTN_TOOL_QUADTAP, dev->keybit);
 		input_set_abs_params(dev, ABS_X, ETP_XMIN_V2, ETP_XMAX_V2, 0, 0);
 		input_set_abs_params(dev, ABS_Y, ETP_YMIN_V2, ETP_YMAX_V2, 0, 0);
 		input_set_abs_params(dev, ABS_HAT0X, ETP_2FT_XMIN, ETP_2FT_XMAX, 0, =
0);
--=20
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
