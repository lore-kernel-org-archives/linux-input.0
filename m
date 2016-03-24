From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH v2] Input: rotary_encoder - support binary encoding of states
Date: Thu, 24 Mar 2016 08:57:12 +0100
Message-ID: <1458806232-22403-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:42304 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751454AbcCXH5Y (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Mar 2016 03:57:24 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, devicetree@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>
Cc: Rojhalat Ibrahim <imr@rtschenk.de>, Sylvain Rochet <sylvain.rochet@finsecur.com>, Johan Hovold <johan@kernel.org>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, kernel@pengutronix.de, Daniel Mack <daniel@zonque.org>

It's not advisable to use this encoding, but to support existing device=
s
add support for this to the driver.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---

Notes:
    Changes since (implicit) v1, sent with
    Message-Id: 1458680914-4533-1-git-send-email-u.kleine-koenig@pengut=
ronix.de
   =20
     - switch format of dt properties to use strings

 .../devicetree/bindings/input/rotary-encoder.txt   |  4 ++++
 drivers/input/misc/rotary_encoder.c                | 22 ++++++++++++++=
+++++---
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/rotary-encoder.txt=
 b/Documentation/devicetree/bindings/input/rotary-encoder.txt
index 6c9f0c8a846c..e85ce3dea480 100644
--- a/Documentation/devicetree/bindings/input/rotary-encoder.txt
+++ b/Documentation/devicetree/bindings/input/rotary-encoder.txt
@@ -20,6 +20,8 @@ Optional properties:
   2: Half-period mode
   4: Quarter-period mode
 - wakeup-source: Boolean, rotary encoder can wake up the system.
+- rotary-encoder,encoding: String, the method used to encode steps.
+  Supported are "gray" (the default and more common) and "binary".
=20
 Deprecated properties:
 - rotary-encoder,half-period: Makes the driver work on half-period mod=
e.
@@ -34,6 +36,7 @@ Example:
 			compatible =3D "rotary-encoder";
 			gpios =3D <&gpio 19 1>, <&gpio 20 0>; /* GPIO19 is inverted */
 			linux,axis =3D <0>; /* REL_X */
+			rotary-encoder,encoding =3D "gray";
 			rotary-encoder,relative-axis;
 		};
=20
@@ -42,5 +45,6 @@ Example:
 			gpios =3D <&gpio 21 0>, <&gpio 22 0>;
 			linux,axis =3D <1>; /* ABS_Y */
 			rotary-encoder,steps =3D <24>;
+			rotary-encoder,encoding =3D "binary";
 			rotary-encoder,rollover;
 		};
diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/r=
otary_encoder.c
index 96c486de49e0..d226d69a174a 100644
--- a/drivers/input/misc/rotary_encoder.c
+++ b/drivers/input/misc/rotary_encoder.c
@@ -28,6 +28,11 @@
=20
 #define DRV_NAME "rotary-encoder"
=20
+enum rotary_encoder_encoding {
+	ROTENC_GRAY,
+	ROTENC_BINARY,
+};
+
 struct rotary_encoder {
 	struct input_dev *input;
=20
@@ -37,6 +42,7 @@ struct rotary_encoder {
 	u32 axis;
 	bool relative_axis;
 	bool rollover;
+	enum rotary_encoder_encoding encoding;
=20
 	unsigned int pos;
=20
@@ -57,9 +63,11 @@ static unsigned rotary_encoder_get_state(struct rota=
ry_encoder *encoder)
=20
 	for (i =3D 0; i < encoder->gpios->ndescs; ++i) {
 		int val =3D gpiod_get_value_cansleep(encoder->gpios->desc[i]);
-		/* convert from gray encoding to normal */
-		if (ret & 1)
-			val =3D !val;
+
+		if (encoder->encoding =3D=3D ROTENC_GRAY)
+			/* convert from gray encoding to binary */
+			if (ret & 1)
+				val =3D !val;
=20
 		ret =3D ret << 1 | val;
 	}
@@ -183,6 +191,7 @@ static int rotary_encoder_probe(struct platform_dev=
ice *pdev)
 	struct device *dev =3D &pdev->dev;
 	struct rotary_encoder *encoder;
 	struct input_dev *input;
+	const char *encoding;
 	irq_handler_t handler;
 	u32 steps_per_period;
 	unsigned int i;
@@ -213,6 +222,13 @@ static int rotary_encoder_probe(struct platform_de=
vice *pdev)
 	encoder->rollover =3D
 		device_property_read_bool(dev, "rotary-encoder,rollover");
=20
+	err =3D device_property_read_string(dev, "rotary-encoder,encoding",
+					  &encoding);
+	if (!err && encoding[0] =3D=3D 'b')
+		encoder->encoding =3D ROTENC_BINARY;
+	else
+		encoder->encoding =3D ROTENC_GRAY;
+
 	device_property_read_u32(dev, "linux,axis", &encoder->axis);
 	encoder->relative_axis =3D
 		device_property_read_bool(dev, "rotary-encoder,relative-axis");
--=20
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
