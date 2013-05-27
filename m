From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: [PATCH 15/19] input/ti_am335x_tsc: tiny cleanup
Date: Mon, 27 May 2013 21:12:02 +0200
Message-ID: <1369681926-22185-16-git-send-email-bigeasy@linutronix.de>
References: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1369681926-22185-1-git-send-email-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Things that can be done to done without using make up:
- reduce config_inp from 20 elements to 4
  The loop goes 0=E2=80=A63 so elements 4=E2=80=A619 remain unused.
- put the shift for analog_line into one line, since config_inp is u32 =
we
  don't need to worry about sign extension,
- check if he DT values are 0=E2=80=A63 as expected
- replace "err =3D -EINVAL; goto err" with "return -EINVAL;" as there i=
s no
  cleanup and this is less code
- pull out "config[analog_line[i]][0=E2=80=A63];" from the switch case =
and use
  magic to the 0=E2=80=A63 correct.
- since we removed so much lines, spent a few to get
  "config[an_line][wi_order];" done.
- get rid of "val32, wires_conf" and assign the values directly. This i=
s
  just init code but we can still save a few cycles.
- remove titsc_config_wires() from resume path. ->bit_yn & friends are =
only
  written once and not changed so as long as we assume that our DDR wil=
l
  have no biflips we can skip that.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
---
 drivers/input/touchscreen/ti_am335x_tsc.c |  124 ++++++++++++---------=
--------
 1 file changed, 51 insertions(+), 73 deletions(-)

diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/=
touchscreen/ti_am335x_tsc.c
index 0dbf3df..96accaa 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -59,7 +59,7 @@ struct titsc {
 	unsigned int		bckup_y;
 	bool			pen_down;
 	int			steps_to_configure;
-	int			config_inp[20];
+	u32			config_inp[4];
 	int			bit_xp, bit_xn, bit_yp, bit_yn;
 	int			inp_xp, inp_xn, inp_yp, inp_yn;
 };
@@ -115,69 +115,54 @@ static int regbit_map(int val)
=20
 static int titsc_config_wires(struct titsc *ts_dev)
 {
-	int		analog_line[10], wire_order[10];
-	int		i, temp_bits, err;
+	u32 analog_line[4];
+	u32 wire_order[4];
+	int i, temp_bits;
=20
 	for (i =3D 0; i < 4; i++) {
 		/*
 		 * Get the order in which TSC wires are attached
 		 * w.r.t. each of the analog input lines on the EVM.
 		 */
-		analog_line[i] =3D ts_dev->config_inp[i] & 0xF0;
-		analog_line[i] =3D analog_line[i] >> 4;
-
+		analog_line[i] =3D (ts_dev->config_inp[i] & 0xF0) >> 4;
 		wire_order[i] =3D ts_dev->config_inp[i] & 0x0F;
+		if (WARN_ON(analog_line[i] > 4))
+				return -EINVAL;
+		if (WARN_ON(wire_order[i] > 4))
+				return -EINVAL;
 	}
=20
 	for (i =3D 0; i < 4; i++) {
+		int an_line;
+		int wi_order;
+
+		an_line =3D analog_line[i];
+		wi_order =3D wire_order[i];
+		temp_bits =3D config[an_line][wi_order];
+		if (temp_bits =3D=3D 0)
+			return -EINVAL;
 		switch (wire_order[i]) {
 		case 0:
-			temp_bits =3D config[analog_line[i]][0];
-			if (temp_bits =3D=3D 0) {
-				err =3D -EINVAL;
-				goto ret;
-			} else {
-				ts_dev->bit_xp =3D regbit_map(temp_bits);
-				ts_dev->inp_xp =3D analog_line[i];
-				break;
-			}
+			ts_dev->bit_xp =3D regbit_map(temp_bits);
+			ts_dev->inp_xp =3D analog_line[i];
+			break;
+
 		case 1:
-			temp_bits =3D config[analog_line[i]][1];
-			if (temp_bits =3D=3D 0) {
-				err =3D -EINVAL;
-				goto ret;
-			} else {
-				ts_dev->bit_xn =3D regbit_map(temp_bits);
-				ts_dev->inp_xn =3D analog_line[i];
-				break;
-			}
+			ts_dev->bit_xn =3D regbit_map(temp_bits);
+			ts_dev->inp_xn =3D analog_line[i];
+			break;
+
 		case 2:
-			temp_bits =3D config[analog_line[i]][2];
-			if (temp_bits =3D=3D 0) {
-				err =3D -EINVAL;
-				goto ret;
-			} else {
-				ts_dev->bit_yp =3D regbit_map(temp_bits);
-				ts_dev->inp_yp =3D analog_line[i];
-				break;
-			}
+			ts_dev->bit_yp =3D regbit_map(temp_bits);
+			ts_dev->inp_yp =3D analog_line[i];
+			break;
 		case 3:
-			temp_bits =3D config[analog_line[i]][3];
-			if (temp_bits =3D=3D 0) {
-				err =3D -EINVAL;
-				goto ret;
-			} else {
-				ts_dev->bit_yn =3D regbit_map(temp_bits);
-				ts_dev->inp_yn =3D analog_line[i];
-				break;
-			}
+			ts_dev->bit_yn =3D regbit_map(temp_bits);
+			ts_dev->inp_yn =3D analog_line[i];
+			break;
 		}
 	}
-
 	return 0;
-
-ret:
-	return err;
 }
=20
 static void titsc_step_config(struct titsc *ts_dev)
@@ -319,7 +304,6 @@ static irqreturn_t titsc_irq(int irq, void *dev)
 	unsigned int z1, z2, z;
 	unsigned int fsm;
 	unsigned int diffx =3D 0, diffy =3D 0;
-	int i;
=20
 	status =3D titsc_readl(ts_dev, REG_IRQSTATUS);
 	if (status & IRQENB_FIFO0THRES) {
@@ -387,11 +371,10 @@ static irqreturn_t titsc_irq(int irq, void *dev)
 }
=20
 static int titsc_parse_dt(struct ti_tscadc_dev *tscadc_dev,
-					struct titsc *ts_dev)
+		struct titsc *ts_dev)
 {
 	struct device_node *node =3D tscadc_dev->dev->of_node;
-	int err, i;
-	u32 val32, wires_conf[4];
+	int err;
=20
 	if (!node)
 		return -EINVAL;
@@ -399,34 +382,30 @@ static int titsc_parse_dt(struct ti_tscadc_dev *t=
scadc_dev,
 	node =3D of_get_child_by_name(node, "tsc");
 	if (!node)
 		return -EINVAL;
-	err =3D of_property_read_u32(node, "ti,wires", &val32);
+	err =3D of_property_read_u32(node, "ti,wires", &ts_dev->wires);
 	if (err < 0)
-		goto error_ret;
-	ts_dev->wires =3D val32;
-
-	err =3D of_property_read_u32(node,
-			"ti,x-plate-resistance", &val32);
-	if (err < 0)
-		goto error_ret;
-	ts_dev->x_plate_resistance =3D val32;
+		return err;
+	switch (ts_dev->wires) {
+	case 4:
+	case 5:
+	case 8:
+		break;
+	default:
+		return -EINVAL;
+	}
=20
-	err =3D of_property_read_u32(node,
-			"ti,steps-to-configure", &val32);
+	err =3D of_property_read_u32(node, "ti,x-plate-resistance",
+			&ts_dev->x_plate_resistance);
 	if (err < 0)
-		goto error_ret;
-	ts_dev->steps_to_configure =3D val32;
+		return err;
=20
-	err =3D of_property_read_u32_array(node, "ti,wire-config",
-			wires_conf, ARRAY_SIZE(wires_conf));
+	err =3D of_property_read_u32(node, "ti,steps-to-configure",
+			&ts_dev->steps_to_configure);
 	if (err < 0)
-		goto error_ret;
+		return err;
=20
-	for (i =3D 0; i < ARRAY_SIZE(wires_conf); i++)
-		ts_dev->config_inp[i] =3D wires_conf[i];
-	return 0;
-
-error_ret:
-	return err;
+	return of_property_read_u32_array(node, "ti,wire-config",
+			ts_dev->config_inp, ARRAY_SIZE(ts_dev->config_inp));
 }
=20
 /*
@@ -545,7 +524,6 @@ static int titsc_resume(struct device *dev)
 				0x00);
 		titsc_writel(ts_dev, REG_IRQCLR, IRQENB_HW_PEN);
 	}
-	titsc_config_wires(ts_dev);
 	titsc_step_config(ts_dev);
 	titsc_writel(ts_dev, REG_FIFO0THR,
 			ts_dev->steps_to_configure);
--=20
1.7.10.4
