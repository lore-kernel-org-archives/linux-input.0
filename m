From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] Input: rotary_encoder - support binary encoding of states
Date: Tue, 22 Mar 2016 22:08:34 +0100
Message-ID: <1458680914-4533-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from arcturus.kleine-koenig.org ([78.47.169.190]:56269 "EHLO
	arcturus.kleine-koenig.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751286AbcCVVSj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Mar 2016 17:18:39 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, devicetree@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: kernel@pengutronix.de, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Sylvain Rochet <sylvain.rochet@finsecur.com>, Johan Hovold <johan@kernel.org>, Daniel Mack <daniel@zonque.org>, Rojhalat Ibrahim <imr@rtschenk.de>

A plain binary encoding has some downsides compared to the usual Gray
encoding, but that doesn't stop hardware engineers to eventually use it=
=2E
So implement support for this encoding in the rotary encoder driver.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
Hello,

an alternative to define this difference in the device tree is to use
something like:

	rotary-encoder,encoding =3D "binary";

or

	rotary-encoder,encoding =3D <ROTARY_ENCODER_ENCODING_BINARY>;

instead of a property

	rotary-encoder,encoding-binary;

=2E While the two first solutions make it obvious that there can only b=
e
one encoding, they IMHO look ugly, so I went for the property without
value. What do you think?

Best regards
Uwe

 .../devicetree/bindings/input/rotary-encoder.txt      |  2 ++
 drivers/input/misc/rotary_encoder.c                   | 19 +++++++++++=
+++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/rotary-encoder.txt=
 b/Documentation/devicetree/bindings/input/rotary-encoder.txt
index 6c9f0c8a846c..4a96e4a32503 100644
--- a/Documentation/devicetree/bindings/input/rotary-encoder.txt
+++ b/Documentation/devicetree/bindings/input/rotary-encoder.txt
@@ -20,6 +20,8 @@ Optional properties:
   2: Half-period mode
   4: Quarter-period mode
 - wakeup-source: Boolean, rotary encoder can wake up the system.
+- rotary-encoder,encoding-binary: The device uses binary states instea=
d of
+  gray encoding (which is the default).
=20
 Deprecated properties:
 - rotary-encoder,half-period: Makes the driver work on half-period mod=
e.
diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/r=
otary_encoder.c
index 96c486de49e0..ce43a59ca41a 100644
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
+			/* convert from gray encoding to normal */
+			if (ret & 1)
+				val =3D !val;
=20
 		ret =3D ret << 1 | val;
 	}
@@ -213,6 +221,11 @@ static int rotary_encoder_probe(struct platform_de=
vice *pdev)
 	encoder->rollover =3D
 		device_property_read_bool(dev, "rotary-encoder,rollover");
=20
+	if (device_property_read_bool(dev, "rotary-encoder,encoding-binary"))
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
