From: Zubair Lutfullah <zubair.lutfullah-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: =?UTF-8?q?=5BPATCH=201/2=5D=20input=3A=20ti=5Fam335x=5Ftsc=3A=20Enable=20shared=20IRQ=20for=20TSC?=
Date: Sun,  1 Sep 2013 12:17:56 +0100
Message-ID: <1378034277-26728-2-git-send-email-zubair.lutfullah@gmail.com>
References: <1378034277-26728-1-git-send-email-zubair.lutfullah@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1378034277-26728-1-git-send-email-zubair.lutfullah-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, zubair.lutfullah-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-input@vger.kernel.org

Enable shared IRQ to allow ADC to share IRQ line from
parent MFD core. Only FIFO0 IRQs are for TSC and handled
on the TSC side.

Step mask would be updated from cached variable only previously.
In rare cases when both TSC and ADC are used, the cached
variable gets mixed up.
The step mask is written with the required mask every time.

Rachna Patil (TI) laid ground work for shared IRQ.

Signed-off-by: Zubair Lutfullah <zubair.lutfullah-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/input/touchscreen/ti_am335x_tsc.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/=
touchscreen/ti_am335x_tsc.c
index e1c5300..24e625c 100644
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
@@ -260,6 +262,10 @@ static irqreturn_t titsc_irq(int irq, void *dev)
 	unsigned int fsm;
=20
 	status =3D titsc_readl(ts_dev, REG_IRQSTATUS);
+	/*
+	 * ADC and touchscreen share the IRQ line.
+	 * FIFO1 interrupts are used by ADC. Handle FIFO0 IRQs here only
+	 */
 	if (status & IRQENB_FIFO0THRES) {
=20
 		titsc_read_coordinates(ts_dev, &x, &y, &z1, &z2);
@@ -316,7 +322,7 @@ static irqreturn_t titsc_irq(int irq, void *dev)
=20
 	if (irqclr) {
 		titsc_writel(ts_dev, REG_IRQSTATUS, irqclr);
-		am335x_tsc_se_update(ts_dev->mfd_tscadc);
+		am335x_tsc_se_set(ts_dev->mfd_tscadc, ts_dev->step_mask);
 		return IRQ_HANDLED;
 	}
 	return IRQ_NONE;
@@ -389,7 +395,7 @@ static int titsc_probe(struct platform_device *pdev=
)
 	}
=20
 	err =3D request_irq(ts_dev->irq, titsc_irq,
-			  0, pdev->dev.driver->name, ts_dev);
+			  IRQF_SHARED, pdev->dev.driver->name, ts_dev);
 	if (err) {
 		dev_err(&pdev->dev, "failed to allocate irq.\n");
 		goto err_free_mem;
--=20
1.7.9.5
