From: =?UTF-8?q?Jean-Fran=C3=A7ois=20Dagenais?= <jeff.dagenais@gmail.com>
Subject: [PATCH 1/2] input: ad714x - fix divide by 0 error in wheel cal_abs_pos
Date: Thu, 26 Apr 2012 13:17:18 -0400
Message-ID: <1335460639-1362-1-git-send-email-jeff.dagenais@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:42579 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752944Ab2DZRRi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Apr 2012 13:17:38 -0400
Received: by qadc11 with SMTP id c11so1585341qad.19
        for <linux-input@vger.kernel.org>; Thu, 26 Apr 2012 10:17:38 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: michael.hennerich@analog.com
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org, =?UTF-8?q?Jean-Fran=C3=A7ois=20Dagenais?= <jeff.dagenais@gmail.com>, =?UTF-8?q?Jean-Fran=C3=A7ois=20Dagenais?= <dagenaisj@sonatest.com>

V2: added comment, removed "BUG_ON" check and fixed >80 col line

As discussed with Michael Hennerich <michael.hennerich@analog.com>,
another divide by 0 happens when the user is lifting the finger
when all the sensors are back below ambient but we are in case
"ACTIVE".

Signed-off-by: Jean-Fran=C3=A7ois Dagenais <dagenaisj@sonatest.com>
Signed-off-by: Jean-Fran=C3=A7ois Dagenais <jeff.dagenais@gmail.com>
---
 drivers/input/misc/ad714x.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/input/misc/ad714x.c b/drivers/input/misc/ad714x.c
index ca42c7d..2cf26e5 100644
--- a/drivers/input/misc/ad714x.c
+++ b/drivers/input/misc/ad714x.c
@@ -418,10 +418,15 @@ static void ad714x_wheel_cal_highest_stage(struct=
 ad714x_chip *ad714x, int idx)
 		sw->highest_stage);
 }
=20
-static void ad714x_wheel_cal_sensor_val(struct ad714x_chip *ad714x, in=
t idx)
+/**
+ * Calculates the sensor value for each stages of the given wheel idx.
+ * Returns true if a sensor detects being touched, false otherwise.
+ */
+static bool ad714x_wheel_cal_sensor_val(struct ad714x_chip *ad714x, in=
t idx)
 {
 	struct ad714x_wheel_plat *hw =3D &ad714x->hw->wheel[idx];
 	int i;
+	bool touched =3D false;
=20
 	ad714x->read(ad714x, CDC_RESULT_S0 + hw->start_stage,
 			&ad714x->adc_reg[hw->start_stage],
@@ -430,12 +435,15 @@ static void ad714x_wheel_cal_sensor_val(struct ad=
714x_chip *ad714x, int idx)
 	for (i =3D hw->start_stage; i <=3D hw->end_stage; i++) {
 		ad714x->read(ad714x, STAGE0_AMBIENT + i * PER_STAGE_REG_NUM,
 				&ad714x->amb_reg[i], 1);
-		if (ad714x->adc_reg[i] > ad714x->amb_reg[i])
+		if (ad714x->adc_reg[i] > ad714x->amb_reg[i]) {
 			ad714x->sensor_val[i] =3D
 				ad714x->adc_reg[i] - ad714x->amb_reg[i];
+			touched =3D true;
+		}
 		else
 			ad714x->sensor_val[i] =3D 0;
 	}
+	return touched;
 }
=20
 /*
@@ -544,8 +552,8 @@ static void ad714x_wheel_state_machine(struct ad714=
x_chip *ad714x, int idx)
=20
 	case ACTIVE:
 		if (c_state =3D=3D mask) {
-			if (h_state) {
-				ad714x_wheel_cal_sensor_val(ad714x, idx);
+			if (h_state &&
+			    ad714x_wheel_cal_sensor_val(ad714x, idx)) {
 				ad714x_wheel_cal_highest_stage(ad714x, idx);
 				ad714x_wheel_cal_abs_pos(ad714x, idx);
 				ad714x_wheel_cal_flt_pos(ad714x, idx);
--=20
1.7.9

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
