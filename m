From: =?ISO-8859-1?Q?Richard_R=F6jfors?=
	<richard.rojfors.ext@mocean-labs.com>
Subject: [PATCH 2/2] tsc2007: reduced number of I2C transfers
Date: Fri, 24 Jul 2009 18:14:37 +0200
Message-ID: <4A69DDED.50402@mocean-labs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from av8-2-sn3.vrr.skanova.net ([81.228.9.184]:41944 "EHLO
	av8-2-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751847AbZGXQOi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Jul 2009 12:14:38 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, kwangwoo.lee@gmail.com, Thierry Reding <thierry.reding@avionic-design.de>, Trilok Soni <soni.trilok@gmail.com>

Decreases the number of I2C transactions transferred by the driver.
During probe we don't need to ask for the coordinates from the controll=
er.
When polling the controller we don't need to power down and enable IRQ=20
if we are going to poll again.

Signed-off-by: Richard R=F6jfors <richard.rojfors.ext@mocean-labs.com>
---
Index: linux-2.6.31-rc2/drivers/input/touchscreen/tsc2007.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.31-rc2/drivers/input/touchscreen/tsc2007.c	(revision 1040=
)
+++ linux-2.6.31-rc2/drivers/input/touchscreen/tsc2007.c	(revision 1053=
)
@@ -178,6 +178,12 @@
  		ts->penstate =3D PEN_STATE_UP;
  }

+static void tsc2007_power_down(struct tsc2007 *tsc)
+{
+	/* power down */
+	tsc2007_xfer(tsc, PWRDOWN);
+}
+
  static int tsc2007_read_values(struct tsc2007 *tsc)
  {
  	/* y- still on; turn on only y+ (and ADC) */
@@ -188,11 +194,8 @@

  	/* turn y+ off, x- on; we'll use formula #1 */
  	tsc->tc.z1 =3D tsc2007_xfer(tsc, READ_Z1);
-	tsc->tc.z2 =3D tsc2007_xfer(tsc, READ_Z2);
+	tsc->tc.z2 =3D tsc2007_xfer(tsc, READ_Z2 | TSC2007_POWER_OFF_IRQ_EN);

-	/* power down */
-	tsc2007_xfer(tsc, PWRDOWN);
-
  	return 0;
  }

@@ -217,6 +220,7 @@
  		input_sync(input);

  		ts->penstate =3D PEN_STATE_UP;
+		tsc2007_power_down(ts);
  		enable_irq(ts->irq);
  	} else {
  		/* pen is still down, continue with the measurement */
@@ -305,7 +309,7 @@
  	input_set_abs_params(input_dev, ABS_Y, 0, MAX_12BIT, 0, 0);
  	input_set_abs_params(input_dev, ABS_PRESSURE, 0, MAX_12BIT, 0, 0);

-	tsc2007_read_values(ts);
+	tsc2007_power_down(ts);

  	ts->irq =3D client->irq;
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
