From: =?ISO-8859-1?Q?Richard_R=F6jfors?=
	<richard.rojfors@mocean-labs.com>
Subject: [PATCH] tsc2007: ignore IRQ:s provoked when reading values
Date: Tue, 22 Sep 2009 15:45:49 +0200
Message-ID: <4AB8D50D.5040204@mocean-labs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from av12-2-sn2.hy.skanova.net ([81.228.8.186]:50985 "EHLO
	av12-2-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756666AbZIVOMD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Sep 2009 10:12:03 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, kwangwoo.lee@gmail.com, Thierry Reding <thierry.reding@avionic-design.de>, Trilok Soni <soni.trilok@gmail.com>

This patch ignores IRQ:s provoked when reading values from the controll=
er,
when the get_pendown_state callback is not implement. If this interrupt
is not ignored the driver ends up polling the device, since
the driver provokes new interrupts while reading values.

Signed-off-by: Richard R=F6jfors <richard.rojfors@mocean-labs.com>
---
diff --git a/drivers/input/touchscreen/tsc2007.c b/drivers/input/touchs=
creen/tsc2007.c
index 4c51cb4..e594479 100644
--- a/drivers/input/touchscreen/tsc2007.c
+++ b/drivers/input/touchscreen/tsc2007.c
@@ -77,6 +77,7 @@ struct tsc2007 {
 	u16			x_plate_ohms;

 	bool			pendown;
+	bool			ignore_next_irq;
 	int			irq;

 	int			(*get_pendown_state)(void);
@@ -228,14 +229,35 @@ static void tsc2007_work(struct work_struct *work=
)
 	if (ts->pendown)
 		schedule_delayed_work(&ts->work,
 				      msecs_to_jiffies(TS_POLL_PERIOD));
-	else
+	else {
+		/* if we don't have the get pen down state callback we
+		 * ignore the next IRQ because it is provoked when we checked
+		 * the touch pressure.
+		 * If the user really touches the screen we will get a new
+		 * interrupt anyway so it is safe to ignore it
+		 *
+		 * This is basically implementing this part of the manual:
+		 * "In both cases previously listed, it is recommended that
+		 *  whenever the host writes to the TSC2007, the master
+		 *  processor masks the interrupt associated to PENIRQ.
+		 *  This masking prevents false triggering of interrupts when
+		 *  the PENIRQ line is disabled in the cases previously listed."
+		 */
+		if (!ts->get_pendown_state)
+			ts->ignore_next_irq =3D true;
 		enable_irq(ts->irq);
+	}
 }

 static irqreturn_t tsc2007_irq(int irq, void *handle)
 {
 	struct tsc2007 *ts =3D handle;

+	if (ts->ignore_next_irq) {
+		ts->ignore_next_irq =3D false;
+		return IRQ_HANDLED;
+	}
+
 	if (!ts->get_pendown_state || likely(ts->get_pendown_state())) {
 		disable_irq_nosync(ts->irq);
 		schedule_delayed_work(&ts->work,
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
