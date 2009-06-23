From: =?ISO-8859-15?Q?Richard_R=F6jfors?=
	<richard.rojfors.ext@mocean-labs.com>
Subject: [PATCH 2/2] tsc2007: make platform callbacks optional
Date: Tue, 23 Jun 2009 13:54:54 +0200
Message-ID: <4A40C28E.1070109@mocean-labs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759276AbZFWLzV@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kwangwoo.lee@gmail.com, Thierry Reding <thierry.reding@avionic-design.de>, Trilok Soni <soni.trilok@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-input@vger.kernel.org

The platform callbacks are only called if supplied. Makes the driver
to fallback on only pressure calculation to decide when the pen is up.

Signed-off-by: Richard R=F6jfors <richard.rojfors.ext@mocean-labs.com>
---
Index: linux-2.6.30/drivers/input/touchscreen/tsc2007.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.30/drivers/input/touchscreen/tsc2007.c	(revision 943)
+++ linux-2.6.30/drivers/input/touchscreen/tsc2007.c	(revision 945)
@@ -59,6 +59,10 @@
 #define READ_X		(ADC_ON_12BIT | TSC2007_MEASURE_X)
 #define PWRDOWN		(TSC2007_12BIT | TSC2007_POWER_OFF_IRQ_EN)

+#define PEN_STATE_UP	0x00
+#define PEN_STATE_DOWN	0x01
+#define PEN_STATE_IRQ	0x01
+
 struct ts_event {
 	u16	x;
 	u16	y;
@@ -76,7 +80,7 @@
 	u16			model;
 	u16			x_plate_ohms;

-	unsigned		pendown;
+	unsigned		penstate;
 	int			irq;

 	int			(*get_pendown_state)(void);
@@ -149,15 +153,18 @@
 	 *
 	 * The only safe way to check for the pen up condition is in the
 	 * work function by reading the pen signal state (it's a GPIO and IRQ=
).
+	 *
+	 * But sadly we don't always have the possibility to use such callbac=
k
+	 * in that case rely on the pressure anyway
 	 */
 	if (rt) {
 		struct input_dev *input =3D ts->input;

-		if (!ts->pendown) {
+		if (ts->penstate !=3D PEN_STATE_DOWN) {
 			dev_dbg(&ts->client->dev, "DOWN\n");

 			input_report_key(input, BTN_TOUCH, 1);
-			ts->pendown =3D 1;
+			ts->penstate =3D PEN_STATE_DOWN;
 		}

 		input_report_abs(input, ABS_X, x);
@@ -168,7 +175,9 @@

 		dev_dbg(&ts->client->dev, "point(%4d,%4d), pressure (%4u)\n",
 			x, y, rt);
-	}
+	} else if (!ts->get_pendown_state)
+		/* no callback to check pendown state, use pressure */
+		ts->penstate =3D PEN_STATE_UP;

 	schedule_delayed_work(&ts->work, TS_POLL_PERIOD);
 }
@@ -195,7 +204,14 @@
 {
 	struct tsc2007 *ts =3D
 		container_of(to_delayed_work(work), struct tsc2007, work);
-	if (unlikely(!ts->get_pendown_state() && ts->pendown)) {
+
+	/* either we have the pendown callback, and use it, otherwise
+	 * we look at the pendown variable
+	 */
+	if ((ts->get_pendown_state && unlikely(!ts->get_pendown_state()) &&
+		ts->penstate !=3D PEN_STATE_UP) ||
+		(!ts->get_pendown_state &&
+		unlikely(ts->penstate =3D=3D PEN_STATE_UP))) {
 		struct input_dev *input =3D ts->input;

 		dev_dbg(&ts->client->dev, "UP\n");
@@ -204,7 +220,7 @@
 		input_report_abs(input, ABS_PRESSURE, 0);
 		input_sync(input);

-		ts->pendown =3D 0;
+		ts->penstate =3D PEN_STATE_UP;
 		enable_irq(ts->irq);
 	} else {
 		/* pen is still down, continue with the measurement */
@@ -219,8 +235,9 @@
 {
 	struct tsc2007 *ts =3D handle;

-	if (likely(ts->get_pendown_state())) {
+	if (!ts->get_pendown_state || likely(ts->get_pendown_state())) {
 		disable_irq_nosync(ts->irq);
+		ts->penstate =3D PEN_STATE_IRQ;
 		schedule_delayed_work(&ts->work, 0);
 	}

@@ -264,7 +281,8 @@
 	ts->get_pendown_state =3D pdata->get_pendown_state;
 	ts->clear_penirq      =3D pdata->clear_penirq;

-	pdata->init_platform_hw();
+	if (pdata->init_platform_hw)
+		pdata->init_platform_hw();

 	snprintf(ts->phys, sizeof(ts->phys),
 		 "%s/input0", dev_name(&client->dev));
