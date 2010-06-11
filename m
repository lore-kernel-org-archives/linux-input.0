From: Richard =?ISO-8859-1?Q?R=F6jfors?=
	<richard.rojfors@pelagicore.com>
Subject: [PATCH] tsc2007: Add z1 lower threshold
Date: Fri, 11 Jun 2010 14:36:56 +0200
Message-ID: <1276259816.12874.5.camel@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-gw11.han.skanova.net ([81.236.55.20]:40762 "EHLO
	smtp-gw11.han.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754326Ab0FKMmr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Jun 2010 08:42:47 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, kwangwoo.lee@gmail.com, thierry.reding@avionic-design.de, soni.trilok@gmail.com

There are hardware where the z1 value never reaches 0 even of the film
is not touch. This patch introduces a lower threshold which is useful
in these situations.

I also kernel doc:ed the platform data.

Signed-off-by: Richard R=C3=B6jfors <richard.rojfors@pelagicore.com>
---
diff --git a/drivers/input/touchscreen/tsc2007.c b/drivers/input/touchs=
creen/tsc2007.c
index be23780..fffa448 100644
--- a/drivers/input/touchscreen/tsc2007.c
+++ b/drivers/input/touchscreen/tsc2007.c
@@ -75,6 +75,7 @@ struct tsc2007 {
=20
 	u16			model;
 	u16			x_plate_ohms;
+	u16			z1_low_threshold;
=20
 	bool			pendown;
 	int			irq;
@@ -129,7 +130,7 @@ static u32 tsc2007_calculate_pressure(struct tsc200=
7 *tsc, struct ts_event *tc)
 	if (tc->x =3D=3D MAX_12BIT)
 		tc->x =3D 0;
=20
-	if (likely(tc->x && tc->z1)) {
+	if (likely(tc->x && (tc->z1 > tsc->z1_low_threshold))) {
 		/* compute touch pressure resistance using equation #1 */
 		rt =3D tc->z2 - tc->z1;
 		rt *=3D tc->x;
@@ -292,6 +293,7 @@ static int __devinit tsc2007_probe(struct i2c_clien=
t *client,
=20
 	ts->model             =3D pdata->model;
 	ts->x_plate_ohms      =3D pdata->x_plate_ohms;
+	ts->z1_low_threshold  =3D pdata->z1_low_threshold;
 	ts->get_pendown_state =3D pdata->get_pendown_state;
 	ts->clear_penirq      =3D pdata->clear_penirq;
=20
diff --git a/include/linux/i2c/tsc2007.h b/include/linux/i2c/tsc2007.h
index c6361fb..75b75fb 100644
--- a/include/linux/i2c/tsc2007.h
+++ b/include/linux/i2c/tsc2007.h
@@ -3,13 +3,27 @@
=20
 /* linux/i2c/tsc2007.h */
=20
+/**
+ * struct tsc2007_platform_data - Platform data of the TSC2007 driver
+ *
+ * @model:		Touch controller model, currently 2003 or 2007.
+ * @x_plate_ohms:	X-Plate resistance.
+ * @z1_low_threshold:	All measured Z1 values below or equal to the thr=
eshold
+ *			are regarded as 0.
+ * @get_pendown_state:	Optional callback used to check if the film is =
touched.
+ *			Can be useful since the pressure value can fluctuate for
+ *			quite a while after lifting the pen.
+ * @clear_penirq:	Optional callback clear 2nd level interrupt source.
+ * @init_platform_hw:	Optional callback to initialise the hardware.
+ * @exit_platform_hw:	Optional callback to de-initialise the hardware.
+ */
 struct tsc2007_platform_data {
-	u16	model;				/* 2007. */
+	u16	model;
 	u16	x_plate_ohms;
+	u16	z1_low_threshold;
=20
 	int	(*get_pendown_state)(void);
-	void	(*clear_penirq)(void);		/* If needed, clear 2nd level
-						   interrupt source */
+	void	(*clear_penirq)(void);
 	int	(*init_platform_hw)(void);
 	void	(*exit_platform_hw)(void);
 };

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
