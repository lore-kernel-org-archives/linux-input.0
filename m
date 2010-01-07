From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH] input/misc: adxl34x: add support for ADXL346 orientation sensing
Date: Thu,  7 Jan 2010 02:05:35 -0500
Message-ID: <1262847935-21106-1-git-send-email-vapier@gentoo.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:54777 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750849Ab0AGHFn (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 7 Jan 2010 02:05:43 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, Michael Hennerich <michael.hennerich@analog.com>

From: Michael Hennerich <michael.hennerich@analog.com>

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 drivers/input/misc/adxl34x.c  |   58 +++++++++++++++++++++++++++++++++++++++-
 include/linux/input/adxl34x.h |   56 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 112 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/adxl34x.c b/drivers/input/misc/adxl34x.c
index c67bb17..2864080 100644
--- a/drivers/input/misc/adxl34x.c
+++ b/drivers/input/misc/adxl34x.c
@@ -201,6 +201,8 @@ struct adxl34x {
 	struct axis_triple hwcal;
 	struct axis_triple saved;
 	char phys[32];
+	unsigned orient2d_saved;
+	unsigned orient3d_saved;
 	unsigned disabled:1;	/* P: mutex */
 	unsigned opened:1;	/* P: mutex */
 	unsigned fifo_delay:1;
@@ -303,7 +305,7 @@ static void adxl34x_work(struct work_struct *work)
 {
 	struct adxl34x *ac = container_of(work, struct adxl34x, work);
 	struct adxl34x_platform_data *pdata = &ac->pdata;
-	int int_stat, tap_stat, samples;
+	int int_stat, tap_stat, samples, orient, orient_code;
 
 	/*
 	 * ACT_TAP_STATUS should be read before clearing the interrupt
@@ -339,6 +341,36 @@ static void adxl34x_work(struct work_struct *work)
 					 pdata->ev_code_act_inactivity, 0);
 	}
 
+	/*
+	 * ORIENTATION SENSING ADXL346 only
+	 */
+	if (pdata->orientation_enable) {
+		orient = AC_READ(ac, ORIENT);
+		if ((pdata->orientation_enable & ADXL_EN_ORIENTATION_2D) &&
+			 (orient & ADXL346_2D_VALID)) {
+
+			orient_code = ADXL346_2D_ORIENT(orient);
+			/* Report orientation only when it changes */
+			if (ac->orient2d_saved != orient_code) {
+				ac->orient2d_saved = orient_code;
+				adxl34x_report_key_single(ac->input,
+					pdata->ev_codes_orient_2d[orient_code]);
+			}
+		}
+
+		if ((pdata->orientation_enable & ADXL_EN_ORIENTATION_3D) &&
+			 (orient & ADXL346_3D_VALID)) {
+
+			orient_code = ADXL346_3D_ORIENT(orient) - 1;
+			/* Report orientation only when it changes */
+			if (ac->orient3d_saved != orient_code) {
+				ac->orient3d_saved = orient_code;
+				adxl34x_report_key_single(ac->input,
+					pdata->ev_codes_orient_3d[orient_code]);
+			}
+		}
+	}
+
 	if (int_stat & (DATA_READY | WATERMARK)) {
 
 		if (pdata->fifo_mode)
@@ -657,7 +689,7 @@ int adxl34x_probe(struct adxl34x **pac, struct device *dev, int irq,
 	struct adxl34x *ac;
 	struct input_dev *input_dev;
 	struct adxl34x_platform_data *pdata;
-	int err, range;
+	int err, range, i;
 	unsigned char revid;
 
 	if (!irq) {
@@ -820,6 +852,28 @@ int adxl34x_probe(struct adxl34x **pac, struct device *dev, int irq,
 		/* Map all INTs to INT1 */
 		AC_WRITE(ac, INT_MAP, 0);
 
+	if ((ac->model == 346) && ac->pdata.orientation_enable) {
+		AC_WRITE(ac, ORIENT_CONF,
+			ORIENT_DEADZONE(ac->pdata.deadzone_angle) |
+			ORIENT_DIVISOR(ac->pdata.divisor_length));
+
+		ac->orient2d_saved = 1234;
+		ac->orient3d_saved = 1234;
+
+	if (pdata->orientation_enable & ADXL_EN_ORIENTATION_3D)
+		for (i = 0; i < ARRAY_SIZE(pdata->ev_codes_orient_3d); i++)
+			__set_bit(pdata->ev_codes_orient_3d[i],
+				 input_dev->keybit);
+
+	if (pdata->orientation_enable & ADXL_EN_ORIENTATION_2D)
+		for (i = 0; i < ARRAY_SIZE(pdata->ev_codes_orient_2d); i++)
+			__set_bit(pdata->ev_codes_orient_2d[i],
+				input_dev->keybit);
+
+	} else {
+		ac->pdata.orientation_enable = 0;
+	}
+
 	AC_WRITE(ac, INT_ENABLE, ac->int_mask | OVERRUN);
 
 	pdata->power_mode &= (PCTL_AUTO_SLEEP | PCTL_LINK);
diff --git a/include/linux/input/adxl34x.h b/include/linux/input/adxl34x.h
index 7121182..9da36f2 100644
--- a/include/linux/input/adxl34x.h
+++ b/include/linux/input/adxl34x.h
@@ -288,6 +288,62 @@ struct adxl34x_platform_data {
 	u32 ev_code_ff;	/* EV_KEY */
 	u32 ev_code_act_inactivity;	/* EV_KEY */
 
+	/*
+	 * Use ADXL34x INT2 instead of INT1
+	 */
 	u8 use_int2;
+
+	/*
+	 * ADXL346 only ORIENTATION SENSING feature
+	 * The orientation function of the ADXL346 reports both 2-D and
+	 * 3-D orientation concurrently.
+	 */
+
+#define ADXL_EN_ORIENTATION_2D		1
+#define ADXL_EN_ORIENTATION_3D		2
+#define ADXL_EN_ORIENTATION_2D_3D	3
+
+	/*
+	 * The width of the deadzone region between two or more
+	 * orientation positions is determined by setting the Deadzone
+	 * value. The deadzone region size can be specified with a
+	 * resolution of 3.6deg. The deadzone angle represents the total
+	 * angle where the orientation is considered invalid.
+	 */
+
+	u8 orientation_enable;
+
+#define ADXL_DEADZONE_ANGLE_0p0	0	/* !!!0.0 [deg] */
+#define ADXL_DEADZONE_ANGLE_3p6	1	/* 3.6 [deg] */
+#define ADXL_DEADZONE_ANGLE_7p2	2	/* 7.2 [deg] */
+#define ADXL_DEADZONE_ANGLE_10p8	3	/* 10.8 [deg] */
+#define ADXL_DEADZONE_ANGLE_14p4	4	/* 14.4 [deg] */
+#define ADXL_DEADZONE_ANGLE_18p0	5	/* 18.0 [deg] */
+#define ADXL_DEADZONE_ANGLE_21p6	6	/* 21.6 [deg] */
+#define ADXL_DEADZONE_ANGLE_25p2	7	/* 25.2 [deg] */
+
+	u8 deadzone_angle;
+
+	/*
+	 * To eliminate most human motion such as walking or shaking,
+	 * a Divisor value should be selected to effectively limit the
+	 * orientation bandwidth. Set the depth of the filter used to
+	 * low-pass filter the measured acceleration for stable
+	 * orientation sensing
+	 */
+
+#define ADXL_LP_FILTER_DIVISOR_2	0
+#define ADXL_LP_FILTER_DIVISOR_4	1
+#define ADXL_LP_FILTER_DIVISOR_8	2
+#define ADXL_LP_FILTER_DIVISOR_16	3
+#define ADXL_LP_FILTER_DIVISOR_32	4
+#define ADXL_LP_FILTER_DIVISOR_64	5
+#define ADXL_LP_FILTER_DIVISOR_128	6
+#define ADXL_LP_FILTER_DIVISOR_256	7
+
+	u8 divisor_length;
+
+	u32 ev_codes_orient_2d[4];	/* EV_KEY {+X, -X, +Y, -Y} */
+	u32 ev_codes_orient_3d[6];	/* EV_KEY {+Z, +Y, +X, -X, -Y, -Z} */
 };
 #endif
-- 
1.6.6

