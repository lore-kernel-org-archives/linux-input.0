From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: =?UTF-8?q?=5BPATCH=202/5=5D=20input/ti=5Fam335x=5Fadc=3A=20use=20only=20FIFO0=20and=20clean=20up=20a=20little?=
Date: Wed, 29 May 2013 19:09:53 +0200
Message-ID: <1369847397-27451-3-git-send-email-bigeasy@linutronix.de>
References: <1369847397-27451-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1369847397-27451-1-git-send-email-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

The driver programs a threshold of "steps-to-configure" say 5. The
REG_FIFO0THR registers says it should it be programmed to "threshold
minus one". The driver does not expect just 5 coordinates but 5 * 2 + 2=
=2E
Multiplied by two because 5 for X and 5 for Y. Plus 2 because we have
two Z.
The whole thing works because It reads the 5 coordinates for X and Y an=
d
split over FIFO0 and FIFO1 and the last element in each FIFO is ignored
within the loop and read later.
Nothing guaranties that FIFO1 is ready by the time it is read. In fact =
I
could see that that FIFO1 reaturns for Y channels 8,9, 10, 12, 6 and fo=
r
Y channel 7 for Z. The problem is that channel 7 and channel 12 got
somehow mixed up. The variance filter here maybe tries to get rid of th=
e
wrong Y values, dunno.
The other Problem is that FIFO1 is also used by the IIO part leading to
not wrong results if both (tsc & adc) are used.

The patch tries to clean up the whole thing a little:
- Name it "coordiante-readouts" and not "steps-to-configure" and
  document it properly. Point out that it the hardware does a total of
  "5 * 2 + 2" reads / steps and not just what is configured.

- Remove the +1 and -1 in REG_STEPCONFIG, REG_STEPDELAY and its counter
  part in the for loop. This is just confusing.

- Use only FIFO0 in TSC. The fifo has space for 64 entries so should be
  fine.

- Read the whole FIFO in one function and check the channel.

- in case we dawdle around, make sure we only read a multiple of our
  coordinate set. On the second interrupt we will cleanup the remaining
  enties.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
---
 .../bindings/input/touchscreen/ti-tsc-adc.txt      |   15 ++--
 arch/arm/boot/dts/am335x-evm.dts                   |    2 +-
 drivers/iio/adc/ti_am335x_adc.c                    |    2 +-
 drivers/input/touchscreen/ti_am335x_tsc.c          |   87 ++++++++++--=
--------
 include/linux/mfd/ti_am335x_tscadc.h               |    4 +-
 5 files changed, 58 insertions(+), 52 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/ti-tsc=
-adc.txt b/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-a=
dc.txt
index e533e9d..80e04e3 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.tx=
t
+++ b/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.tx=
t
@@ -6,10 +6,15 @@
 	ti,wires: Wires refer to application modes i.e. 4/5/8 wire touchscree=
n
 		  support on the platform.
 	ti,x-plate-resistance: X plate resistance
-	ti,steps-to-configure: The sequencer supports a total of 16
-			       programmable steps. A step configured to read a
-			       single co-ordinate value. Can be applied more
-			       number of times for better results.
+	ti,coordiante-readouts: The sequencer supports a total of 16
+				programmable steps each step is used to
+				read a single coordinate. A single
+                                readout is enough but multiple reads c=
an
+				increase the quality.
+				A value of 5 means, 5 reads for X, 5 for
+				Y and 2 for Z (always). This utilises 12
+				of the 16 software steps available. The
+				remaining 4 can be used by the ADC.
 	ti,wire-config: Different boards could have a different order for
 			connecting wires on touchscreen. We need to provide an
 			8 bit number where in the 1st four bits represent the
@@ -28,7 +33,7 @@
 		tsc {
 			ti,wires =3D <4>;
 			ti,x-plate-resistance =3D <200>;
-			ti,steps-to-configure =3D <5>;
+			ti,coordiante-readouts =3D <5>;
 			ti,wire-config =3D <0x00 0x11 0x22 0x33>;
 		};
=20
diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335=
x-evm.dts
index be6a5b2..26fea97 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -250,7 +250,7 @@
 	tsc {
 		ti,wires =3D <4>;
 		ti,x-plate-resistance =3D <200>;
-		ti,steps-to-configure =3D <5>;
+		ti,coordiante-readouts =3D <5>;
 		ti,wire-config =3D <0x00 0x11 0x22 0x33>;
 	};
=20
diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335=
x_adc.c
index b2f27de..2988840 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -72,7 +72,7 @@ static void tiadc_step_config(struct tiadc_device *ad=
c_dev)
=20
 	stepconfig =3D STEPCONFIG_AVG_16 | STEPCONFIG_FIFO1;
=20
-	for (i =3D (steps + 1); i <=3D TOTAL_STEPS; i++) {
+	for (i =3D steps; i < TOTAL_STEPS; i++) {
 		tiadc_writel(adc_dev, REG_STEPCONFIG(i),
 				stepconfig | STEPCONFIG_INP(channels));
 		tiadc_writel(adc_dev, REG_STEPDELAY(i),
diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/=
touchscreen/ti_am335x_tsc.c
index 2921163..7c97fc7 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -58,7 +58,7 @@ struct titsc {
 	unsigned int		bckup_x;
 	unsigned int		bckup_y;
 	bool			pen_down;
-	int			steps_to_configure;
+	int			coordiante_readouts;
 	u32			config_inp[4];
 	int			bit_xp, bit_xn, bit_yp, bit_yn;
 	int			inp_xp, inp_xn, inp_yp, inp_yn;
@@ -168,11 +168,8 @@ static int titsc_config_wires(struct titsc *ts_dev=
)
 static void titsc_step_config(struct titsc *ts_dev)
 {
 	unsigned int	config;
-	unsigned int	stepenable =3D 0;
-	int i, total_steps;
-
-	/* Configure the Step registers */
-	total_steps =3D 2 * ts_dev->steps_to_configure;
+	int i;
+	int end_step;
=20
 	config =3D STEPCONFIG_MODE_HWSYNC |
 			STEPCONFIG_AVG_16 | ts_dev->bit_xp;
@@ -190,7 +187,9 @@ static void titsc_step_config(struct titsc *ts_dev)
 		break;
 	}
=20
-	for (i =3D 1; i <=3D ts_dev->steps_to_configure; i++) {
+	/* 1 =E2=80=A6 coordiante_readouts is for X */
+	end_step =3D ts_dev->coordiante_readouts;
+	for (i =3D 0; i < end_step; i++) {
 		titsc_writel(ts_dev, REG_STEPCONFIG(i), config);
 		titsc_writel(ts_dev, REG_STEPDELAY(i), STEPCONFIG_OPENDLY);
 	}
@@ -198,7 +197,7 @@ static void titsc_step_config(struct titsc *ts_dev)
 	config =3D 0;
 	config =3D STEPCONFIG_MODE_HWSYNC |
 			STEPCONFIG_AVG_16 | ts_dev->bit_yn |
-			STEPCONFIG_INM_ADCREFM | STEPCONFIG_FIFO1;
+			STEPCONFIG_INM_ADCREFM;
 	switch (ts_dev->wires) {
 	case 4:
 		config |=3D ts_dev->bit_yp | STEPCONFIG_INP(ts_dev->inp_xp);
@@ -212,12 +211,13 @@ static void titsc_step_config(struct titsc *ts_de=
v)
 		break;
 	}
=20
-	for (i =3D (ts_dev->steps_to_configure + 1); i <=3D total_steps; i++)=
 {
+	/* coordiante_readouts =E2=80=A6 coordiante_readouts * 2 is for Y */
+	end_step =3D ts_dev->coordiante_readouts * 2;
+	for (i =3D ts_dev->coordiante_readouts; i < end_step; i++) {
 		titsc_writel(ts_dev, REG_STEPCONFIG(i), config);
 		titsc_writel(ts_dev, REG_STEPDELAY(i), STEPCONFIG_OPENDLY);
 	}
=20
-	config =3D 0;
 	/* Charge step configuration */
 	config =3D ts_dev->bit_xp | ts_dev->bit_yn |
 			STEPCHARGE_RFP_XPUL | STEPCHARGE_RFM_XNUR |
@@ -226,37 +226,40 @@ static void titsc_step_config(struct titsc *ts_de=
v)
 	titsc_writel(ts_dev, REG_CHARGECONFIG, config);
 	titsc_writel(ts_dev, REG_CHARGEDELAY, CHARGEDLY_OPENDLY);
=20
-	config =3D 0;
-	/* Configure to calculate pressure */
+	/* coordiante_readouts * 2 =E2=80=A6 coordiante_readouts * 2 + 2 is f=
or Z */
 	config =3D STEPCONFIG_MODE_HWSYNC |
 			STEPCONFIG_AVG_16 | ts_dev->bit_yp |
 			ts_dev->bit_xn | STEPCONFIG_INM_ADCREFM |
 			STEPCONFIG_INP(ts_dev->inp_xp);
-	titsc_writel(ts_dev, REG_STEPCONFIG(total_steps + 1), config);
-	titsc_writel(ts_dev, REG_STEPDELAY(total_steps + 1),
+	titsc_writel(ts_dev, REG_STEPCONFIG(end_step), config);
+	titsc_writel(ts_dev, REG_STEPDELAY(end_step),
 			STEPCONFIG_OPENDLY);
=20
-	config |=3D STEPCONFIG_INP(ts_dev->inp_yn) | STEPCONFIG_FIFO1;
-	titsc_writel(ts_dev, REG_STEPCONFIG(total_steps + 2), config);
-	titsc_writel(ts_dev, REG_STEPDELAY(total_steps + 2),
+	end_step++;
+	config |=3D STEPCONFIG_INP(ts_dev->inp_yn);
+	titsc_writel(ts_dev, REG_STEPCONFIG(end_step), config);
+	titsc_writel(ts_dev, REG_STEPDELAY(end_step),
 			STEPCONFIG_OPENDLY);
=20
-	for (i =3D 0; i <=3D (total_steps + 2); i++)
-		stepenable |=3D 1 << i;
-	ts_dev->enable_bits =3D stepenable;
+	/* The steps1 =E2=80=A6 end and bit 0 for TS_Charge */
+	ts_dev->enable_bits =3D (1 << (end_step + 2)) - 1;
=20
 	titsc_writel(ts_dev, REG_SE, ts_dev->enable_bits);
 }
=20
 static void titsc_read_coordinates(struct titsc *ts_dev,
-				    unsigned int *x, unsigned int *y)
+		u32 *x, u32 *y, u32 *z1, u32 *z2)
 {
 	unsigned int fifocount =3D titsc_readl(ts_dev, REG_FIFO0CNT);
 	unsigned int prev_val_x =3D ~0, prev_val_y =3D ~0;
 	unsigned int prev_diff_x =3D ~0, prev_diff_y =3D ~0;
 	unsigned int read, diff;
 	unsigned int i, channel;
+	unsigned int creads =3D ts_dev->coordiante_readouts;
=20
+	*z1 =3D *z2 =3D 0;
+	if (fifocount % (creads * 2 + 2))
+		fifocount -=3D fifocount % (creads * 2 + 2);
 	/*
 	 * Delta filter is used to remove large variations in sampled
 	 * values from ADC. The filter tries to predict where the next
@@ -265,32 +268,31 @@ static void titsc_read_coordinates(struct titsc *=
ts_dev,
 	 * algorithm compares the difference with that of a present value,
 	 * if true the value is reported to the sub system.
 	 */
-	for (i =3D 0; i < fifocount - 1; i++) {
+	for (i =3D 0; i < fifocount; i++) {
 		read =3D titsc_readl(ts_dev, REG_FIFO0);
-		channel =3D read & 0xf0000;
-		channel =3D channel >> 0x10;
-		if ((channel >=3D 0) && (channel < ts_dev->steps_to_configure)) {
-			read &=3D 0xfff;
+		channel =3D (read & 0xf0000) >> 16;
+		read &=3D 0xfff;
+		if (channel < creads) {
 			diff =3D abs(read - prev_val_x);
 			if (diff < prev_diff_x) {
 				prev_diff_x =3D diff;
 				*x =3D read;
 			}
 			prev_val_x =3D read;
-		}
=20
-		read =3D titsc_readl(ts_dev, REG_FIFO1);
-		channel =3D read & 0xf0000;
-		channel =3D channel >> 0x10;
-		if ((channel >=3D ts_dev->steps_to_configure) &&
-			(channel < (2 * ts_dev->steps_to_configure - 1))) {
-			read &=3D 0xfff;
+		} else if (channel < creads * 2) {
 			diff =3D abs(read - prev_val_y);
 			if (diff < prev_diff_y) {
 				prev_diff_y =3D diff;
 				*y =3D read;
 			}
 			prev_val_y =3D read;
+
+		} else if (channel < creads * 2 + 1) {
+			*z1 =3D read;
+
+		} else if (channel < creads * 2 + 2) {
+			*z2 =3D read;
 		}
 	}
 }
@@ -307,26 +309,24 @@ static irqreturn_t titsc_irq(int irq, void *dev)
=20
 	status =3D titsc_readl(ts_dev, REG_IRQSTATUS);
 	if (status & IRQENB_FIFO0THRES) {
-		titsc_read_coordinates(ts_dev, &x, &y);
+
+		titsc_read_coordinates(ts_dev, &x, &y, &z1, &z2);
=20
 		diffx =3D abs(x - (ts_dev->bckup_x));
 		diffy =3D abs(y - (ts_dev->bckup_y));
 		ts_dev->bckup_x =3D x;
 		ts_dev->bckup_y =3D y;
=20
-		z1 =3D titsc_readl(ts_dev, REG_FIFO0) & 0xfff;
-		z2 =3D titsc_readl(ts_dev, REG_FIFO1) & 0xfff;
-
 		if (ts_dev->pen_down && z1 !=3D 0 && z2 !=3D 0) {
 			/*
 			 * Calculate pressure using formula
 			 * Resistance(touch) =3D x plate resistance *
 			 * x postion/4096 * ((z2 / z1) - 1)
 			 */
-			z =3D z2 - z1;
+			z =3D z1 - z2;
 			z *=3D x;
 			z *=3D ts_dev->x_plate_resistance;
-			z /=3D z1;
+			z /=3D z2;
 			z =3D (z + 2047) >> 12;
=20
 			if ((diffx < TSCADC_DELTA_X) &&
@@ -399,8 +399,8 @@ static int titsc_parse_dt(struct ti_tscadc_dev *tsc=
adc_dev,
 	if (err < 0)
 		return err;
=20
-	err =3D of_property_read_u32(node, "ti,steps-to-configure",
-			&ts_dev->steps_to_configure);
+	err =3D of_property_read_u32(node, "ti,coordiante-readouts",
+			&ts_dev->coordiante_readouts);
 	if (err < 0)
 		return err;
=20
@@ -454,7 +454,8 @@ static int titsc_probe(struct platform_device *pdev=
)
 		goto err_free_irq;
 	}
 	titsc_step_config(ts_dev);
-	titsc_writel(ts_dev, REG_FIFO0THR, ts_dev->steps_to_configure);
+	titsc_writel(ts_dev, REG_FIFO0THR,
+			ts_dev->coordiante_readouts * 2 + 2 - 1);
=20
 	input_dev->name =3D "ti-tsc";
 	input_dev->dev.parent =3D &pdev->dev;
@@ -526,7 +527,7 @@ static int titsc_resume(struct device *dev)
 	}
 	titsc_step_config(ts_dev);
 	titsc_writel(ts_dev, REG_FIFO0THR,
-			ts_dev->steps_to_configure);
+			ts_dev->coordiante_readouts * 2 + 2 - 1);
 	return 0;
 }
=20
diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/t=
i_am335x_tscadc.h
index c985262..4ec52b0 100644
--- a/include/linux/mfd/ti_am335x_tscadc.h
+++ b/include/linux/mfd/ti_am335x_tscadc.h
@@ -30,8 +30,8 @@
 #define REG_IDLECONFIG		0x058
 #define REG_CHARGECONFIG	0x05C
 #define REG_CHARGEDELAY		0x060
-#define REG_STEPCONFIG(n)	(0x64 + ((n - 1) * 8))
-#define REG_STEPDELAY(n)	(0x68 + ((n - 1) * 8))
+#define REG_STEPCONFIG(n)	(0x64 + ((n) * 8))
+#define REG_STEPDELAY(n)	(0x68 + ((n) * 8))
 #define REG_FIFO0CNT		0xE4
 #define REG_FIFO0THR		0xE8
 #define REG_FIFO1CNT		0xF0
--=20
1.7.10.4
