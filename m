From: Zubair Lutfullah <zubair.lutfullah@gmail.com>
Subject: =?UTF-8?q?=5BPATCH=201/4=5D=20input=3A=20ti=5Fam335x=5Ftsc=3A=20correct=20step=20mask=20update=20after=20IRQ?=
Date: Tue, 13 Aug 2013 17:48:16 +0100
Message-ID: <1376412499-21007-2-git-send-email-zubair.lutfullah@gmail.com>
References: <1376412499-21007-1-git-send-email-zubair.lutfullah@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1376412499-21007-1-git-send-email-zubair.lutfullah@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jic23@cam.ac.uk, dmitry.torokhov@gmail.com, sameo@linux.intel.com, lee.jones@linaro.org
Cc: linux-iio@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, bigeasy@linutronix.de, gregkh@linuxfoundation.org, Russ.Dill@ti.com
List-Id: linux-input@vger.kernel.org

TSC steps should be enabled again after IRQ routine.
This fix ensures they are updated correctly every time.

Signed-off-by: Zubair Lutfullah <zubair.lutfullah@gmail.com>
---
 drivers/input/touchscreen/ti_am335x_tsc.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/=
touchscreen/ti_am335x_tsc.c
index e1c5300..e165fcb 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -52,6 +52,7 @@ struct titsc {
 	u32			config_inp[4];
 	u32			bit_xp, bit_xn, bit_yp, bit_yn;
 	u32			inp_xp, inp_xn, inp_yp, inp_yn;
+	u32			step_mask;
 };
=20
 static unsigned int titsc_readl(struct titsc *ts, unsigned int reg)
@@ -196,7 +197,8 @@ static void titsc_step_config(struct titsc *ts_dev)
=20
 	/* The steps1 =E2=80=A6 end and bit 0 for TS_Charge */
 	stepenable =3D (1 << (end_step + 2)) - 1;
-	am335x_tsc_se_set(ts_dev->mfd_tscadc, stepenable);
+	ts_dev->step_mask =3D stepenable;
+	am335x_tsc_se_set(ts_dev->mfd_tscadc, ts_dev->step_mask);
 }
=20
 static void titsc_read_coordinates(struct titsc *ts_dev,
@@ -316,7 +318,7 @@ static irqreturn_t titsc_irq(int irq, void *dev)
=20
 	if (irqclr) {
 		titsc_writel(ts_dev, REG_IRQSTATUS, irqclr);
-		am335x_tsc_se_update(ts_dev->mfd_tscadc);
+		am335x_tsc_se_set(ts_dev->mfd_tscadc, ts_dev->step_mask);
 		return IRQ_HANDLED;
 	}
 	return IRQ_NONE;
--=20
1.7.9.5
