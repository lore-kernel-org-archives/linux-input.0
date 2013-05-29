From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 3/5] input/ti_am335x_tsc: fold regbit_map() and simplfy
Date: Wed, 29 May 2013 19:09:54 +0200
Message-ID: <1369847397-27451-4-git-send-email-bigeasy@linutronix.de>
References: <1369847397-27451-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:57936 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759706Ab3E2RKF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 May 2013 13:10:05 -0400
In-Reply-To: <1369847397-27451-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Cc: sameo@linux.intel.com, jic23@cam.ac.uk, dmitry.torokhov@gmail.com, balbi@ti.com, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

If we put the values which are looked up by regbit_map() directly in th=
e
config array then we can remove the function.
And now when I look at it I don't understand why the array has to have
two dimensions. One does it, too. And while at it, the description says
that AIN0 =E2=80=A6 AIN7 can be used so allow this.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/input/touchscreen/ti_am335x_tsc.c |   76 ++++++++-------------=
--------
 1 file changed, 19 insertions(+), 57 deletions(-)

diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/=
touchscreen/ti_am335x_tsc.c
index 7c97fc7..63cee57 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -37,15 +37,11 @@
 #define TSCADC_DELTA_X		15
 #define TSCADC_DELTA_Y		15
=20
-/*
- * Refer to function regbit_map() to
- * map the values in the matrix.
- */
-static int config[4][4] =3D {
-		{1,	0,	1,	0},
-		{2,	3,	2,	3},
-		{4,	5,	4,	5},
-		{0,	6,	0,	6}
+static const int config_pins[] =3D {
+		XPP,
+		XNN,
+		YPP,
+		YNN,
 };
=20
 struct titsc {
@@ -79,45 +75,11 @@ static void titsc_writel(struct titsc *tsc, unsigne=
d int reg,
 	regmap_write(tsc->mfd_tscadc->regmap_tscadc, reg, val);
 }
=20
-/*
- * Each of the analog lines are mapped
- * with one or two register bits,
- * which can be either pulled high/low
- * depending on the value to be read.
- */
-static int regbit_map(int val)
-{
-	int map_bits =3D 0;
-
-	switch (val) {
-	case 1:
-		map_bits =3D XPP;
-		break;
-	case 2:
-		map_bits =3D XNP;
-		break;
-	case 3:
-		map_bits =3D XNN;
-		break;
-	case 4:
-		map_bits =3D YPP;
-		break;
-	case 5:
-		map_bits =3D YPN;
-		break;
-	case 6:
-		map_bits =3D YNN;
-		break;
-	}
-
-	return map_bits;
-}
-
 static int titsc_config_wires(struct titsc *ts_dev)
 {
 	u32 analog_line[4];
 	u32 wire_order[4];
-	int i, temp_bits;
+	int i, bit_cfg;
=20
 	for (i =3D 0; i < 4; i++) {
 		/*
@@ -126,9 +88,9 @@ static int titsc_config_wires(struct titsc *ts_dev)
 		 */
 		analog_line[i] =3D (ts_dev->config_inp[i] & 0xF0) >> 4;
 		wire_order[i] =3D ts_dev->config_inp[i] & 0x0F;
-		if (WARN_ON(analog_line[i] > 4))
+		if (WARN_ON(analog_line[i] > 7))
 				return -EINVAL;
-		if (WARN_ON(wire_order[i] > 4))
+		if (WARN_ON(wire_order[i] > ARRAY_SIZE(config_pins)))
 				return -EINVAL;
 	}
=20
@@ -138,27 +100,27 @@ static int titsc_config_wires(struct titsc *ts_de=
v)
=20
 		an_line =3D analog_line[i];
 		wi_order =3D wire_order[i];
-		temp_bits =3D config[an_line][wi_order];
-		if (temp_bits =3D=3D 0)
+		bit_cfg =3D config_pins[wi_order];
+		if (bit_cfg =3D=3D 0)
 			return -EINVAL;
-		switch (wire_order[i]) {
+		switch (wi_order) {
 		case 0:
-			ts_dev->bit_xp =3D regbit_map(temp_bits);
-			ts_dev->inp_xp =3D analog_line[i];
+			ts_dev->bit_xp =3D bit_cfg;
+			ts_dev->inp_xp =3D an_line;
 			break;
=20
 		case 1:
-			ts_dev->bit_xn =3D regbit_map(temp_bits);
-			ts_dev->inp_xn =3D analog_line[i];
+			ts_dev->bit_xn =3D bit_cfg;
+			ts_dev->inp_xn =3D an_line;
 			break;
=20
 		case 2:
-			ts_dev->bit_yp =3D regbit_map(temp_bits);
-			ts_dev->inp_yp =3D analog_line[i];
+			ts_dev->bit_yp =3D bit_cfg;
+			ts_dev->inp_yp =3D an_line;
 			break;
 		case 3:
-			ts_dev->bit_yn =3D regbit_map(temp_bits);
-			ts_dev->inp_yn =3D analog_line[i];
+			ts_dev->bit_yn =3D bit_cfg;
+			ts_dev->inp_yn =3D an_line;
 			break;
 		}
 	}
--=20
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
