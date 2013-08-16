From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 1/4] input: ti_am335x_tsc: correct step mask update
 after IRQ
Date: Fri, 16 Aug 2013 10:53:50 +0200
Message-ID: <20130816085350.GA26895@linutronix.de>
References: <1376412499-21007-1-git-send-email-zubair.lutfullah@gmail.com>
 <1376412499-21007-2-git-send-email-zubair.lutfullah@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1376412499-21007-2-git-send-email-zubair.lutfullah@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zubair Lutfullah <zubair.lutfullah@gmail.com>
Cc: jic23@cam.ac.uk, dmitry.torokhov@gmail.com, sameo@linux.intel.com, lee.jones@linaro.org, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, Russ.Dill@ti.com
List-Id: linux-input@vger.kernel.org

* Zubair Lutfullah | 2013-08-13 17:48:16 [+0100]:

>diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input=
/touchscreen/ti_am335x_tsc.c
>index e1c5300..e165fcb 100644
>--- a/drivers/input/touchscreen/ti_am335x_tsc.c
>+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
>@@ -52,6 +52,7 @@ struct titsc {
> 	u32			config_inp[4];
> 	u32			bit_xp, bit_xn, bit_yp, bit_yn;
> 	u32			inp_xp, inp_xn, inp_yp, inp_yn;
>+	u32			step_mask;
> };
>=20
> static unsigned int titsc_readl(struct titsc *ts, unsigned int reg)
>@@ -196,7 +197,8 @@ static void titsc_step_config(struct titsc *ts_dev=
)
>=20
> 	/* The steps1 =E2=80=A6 end and bit 0 for TS_Charge */
> 	stepenable =3D (1 << (end_step + 2)) - 1;
>-	am335x_tsc_se_set(ts_dev->mfd_tscadc, stepenable);
>+	ts_dev->step_mask =3D stepenable;
>+	am335x_tsc_se_set(ts_dev->mfd_tscadc, ts_dev->step_mask);
> }
>=20
> static void titsc_read_coordinates(struct titsc *ts_dev,
>@@ -316,7 +318,7 @@ static irqreturn_t titsc_irq(int irq, void *dev)
>=20
> 	if (irqclr) {
> 		titsc_writel(ts_dev, REG_IRQSTATUS, irqclr);
>-		am335x_tsc_se_update(ts_dev->mfd_tscadc);
>+		am335x_tsc_se_set(ts_dev->mfd_tscadc, ts_dev->step_mask);
> 		return IRQ_HANDLED;
> 	}
> 	return IRQ_NONE;

titsc_step_config() computes the mask once since it does not change. It
is then assigned via am335x_tsc_se_set() to ->reg_se_cache() and later
always udpated via am335x_tsc_se_update(). This should ensure that ADC'=
s
and TSC's bits are in sync and clear each other out.
Now you call am335x_tsc_se_set() in every irq which adds the TSC's mask
to ->reg_se_cache but why? It was never removed.

Sebastian
