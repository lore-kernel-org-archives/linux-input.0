From: Wan ZongShun <mcuos.com@gmail.com>
Subject: Re: [PATCH] Add support for touch screen on W90P910 ARM platform
Date: Tue, 12 May 2009 09:07:16 +0800
Message-ID: <e68bb3470905111807u1ea9f7dcta9d89e5723ca9332@mail.gmail.com>
References: <e68bb3470904270803q5e69a5f4n74ff58848f397f28@mail.gmail.com>
	 <20090509195446.GA1617@dtor-d630.eng.vmware.com>
	 <4A06ADD4.8010601@gmail.com>
	 <200905101315.45564.dmitry.torokhov@gmail.com>
	 <4A07A283.5080804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.230]:18780 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755508AbZELBHQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 May 2009 21:07:16 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2355871rvb.1
        for <linux-input@vger.kernel.org>; Mon, 11 May 2009 18:07:16 -0700 (PDT)
In-Reply-To: <4A07A283.5080804@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, mcuos.com@gmail.com

Dear Dmitry,

Did you have any else advice given to me about this patch? Can it be
accepted by you now?

2009/5/11 Wan ZongShun <mcuos.com@gmail.com>:
> Dear Dmitry,
>
> Modifying the magic constants to use #defines form,but I forget to re=
-patch it in previous patch,
> so i re-submit this patch again.
>
> about you doubt:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((__raw_readl(w90p910_ts->ts_reg)&ADC_I=
NT) &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0w=
90p910_ts->state =3D=3D CAN_READY) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0w90p910_report=
_event(w90p910_ts);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__raw_writel((=
__raw_readl(w90p910_ts->ts_reg)|
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0ADC_WAITTRIG)&(~ADC_INT|~WT_INT_EN|~ADC_INT_EN),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 w90p910_ts->ts_=
reg);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mod_timer(&w90=
p910_ts->timer, jiffies +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0msecs_to_jiffies(40));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> When changing to wait trigger mode(ADC_WAITTRIG),I have to close wait=
 trigger(WT_INT) and ADC interrupt(ADC_INT), and start the timer to exe=
cute timer function,if pen still keep down,then opening the ADC interru=
pt again,so that it can continue to get values of X and
> Y,but if pen keep up,opening wait trigger interrupt and closing ADC i=
nterrupt,so that we can wait the next pen in down.
>
> MY PATCH text:
>
> Add touchscreen drivers for w90p910 platform.
>
> Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>
>
> diff -Npur linux-2.6.29/drivers/input/touchscreen/Kconfig linux-2.6.3=
0/drivers/input/touchscreen/Kconfig
> --- linux-2.6.29/drivers/input/touchscreen/Kconfig =C2=A0 =C2=A0 =C2=A0=
2009-05-01 12:28:54.000000000 +0800
> +++ linux-2.6.30/drivers/input/touchscreen/Kconfig =C2=A0 =C2=A0 =C2=A0=
2009-05-10 14:47:07.000000000 +0800
> @@ -466,4 +466,11 @@ config TOUCHSCREEN_TSC2007
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0To compile this driver as a module,=
 choose M here: the
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0module will be called tsc2007.
>
> +config TOUCHSCREEN_W90X900
> + =C2=A0 =C2=A0 =C2=A0 tristate "W90P910 touchscreen driver"
> + =C2=A0 =C2=A0 =C2=A0 depends on CPU_W90P910
> + =C2=A0 =C2=A0 =C2=A0 help
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 To compile this driver as a module, cho=
ose M here: the
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 module will be called w90p910-ts.
> +
> =C2=A0endif
> diff -Npur linux-2.6.29/drivers/input/touchscreen/Makefile linux-2.6.=
30/drivers/input/touchscreen/Makefile
> --- linux-2.6.29/drivers/input/touchscreen/Makefile =C2=A0 =C2=A0 200=
9-05-01 12:28:54.000000000 +0800
> +++ linux-2.6.30/drivers/input/touchscreen/Makefile =C2=A0 =C2=A0 200=
9-05-09 07:34:12.000000000 +0800
> @@ -37,3 +37,4 @@ wm97xx-ts-$(CONFIG_TOUCHSCREEN_WM9712) =C2=A0 =C2=A0=
 =C2=A0 =C2=A0+
> =C2=A0wm97xx-ts-$(CONFIG_TOUCHSCREEN_WM9713) +=3D wm9713.o
> =C2=A0obj-$(CONFIG_TOUCHSCREEN_WM97XX_MAINSTONE) =C2=A0 =C2=A0 +=3D m=
ainstone-wm97xx.o
> =C2=A0obj-$(CONFIG_TOUCHSCREEN_WM97XX_ZYLONITE) =C2=A0 =C2=A0 =C2=A0+=
=3D zylonite-wm97xx.o
> +obj-$(CONFIG_TOUCHSCREEN_W90X900) =C2=A0 =C2=A0 =C2=A0+=3D w90p910_t=
s.o
> diff -Npur linux-2.6.29/drivers/input/touchscreen/w90p910_ts.c linux-=
2.6.30/drivers/input/touchscreen/w90p910_ts.c
> --- linux-2.6.29/drivers/input/touchscreen/w90p910_ts.c 1970-01-01 08=
:00:00.000000000 +0800
> +++ linux-2.6.30/drivers/input/touchscreen/w90p910_ts.c 2009-05-11 11=
:12:48.000000000 +0800
> @@ -0,0 +1,272 @@
> +/*
> + * Copyright (c) 2008 Nuvoton technology corporation.
> + *
> + * Wan ZongShun <mcuos.com@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License as published=
 by
> + * the Free Software Foundation;version 2 of the License.
> + *
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +#include <linux/input.h>
> +#include <linux/interrupt.h>
> +
> +#include <mach/hardware.h>
> +
> +/*adc controller bit define*/
> +#define ADC_DELAY =C2=A0 =C2=A0 =C2=A00xf00
> +#define ADC_DOWN =C2=A0 =C2=A0 =C2=A0 0x01
> +#define ADC_TSC_Y =C2=A0 =C2=A0 =C2=A0(0x01 << 8)
> +#define ADC_TSC_X =C2=A0 =C2=A0 =C2=A0(0x00 << 8)
> +#define TSC_FOURWIRE =C2=A0 (~(0x03 << 1))
> +#define ADC_CLK_EN =C2=A0 =C2=A0 (0x01 << 28)/*adc clock*/
> +#define ADC_READ_CON =C2=A0 (0x01 << 12)
> +#define ADC_CONV =C2=A0 =C2=A0 =C2=A0 (0x01 << 13)
> +#define ADC_SEMIAUTO =C2=A0 (0x01 << 14)
> +#define ADC_WAITTRIG =C2=A0 (0x03 << 14)
> +#define ADC_RST1 =C2=A0 =C2=A0 =C2=A0 (0x01 << 16)
> +#define ADC_RST0 =C2=A0 =C2=A0 =C2=A0 (0x00 << 16)
> +#define ADC_EN =C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x01 << 17)
> +#define ADC_INT =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(0x01 << 18)/*adc int status*/
> +#define WT_INT =C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x01 << 20)/*wait trig i=
nt status*/
> +#define ADC_INT_EN =C2=A0 =C2=A0 (0x01 << 21)/*enable ADC_INT irq*/
> +#define LVD_INT_EN =C2=A0 =C2=A0 (0x01 << 22)
> +#define WT_INT_EN =C2=A0 =C2=A0 =C2=A0(0x01 << 23)/*enable WT_INT ir=
q*/
> +#define ADC_DIV =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(0x04 << 1)/*div=3D6*/
> +
> +/*adc state define*/
> +enum ts_state { NO_PRESS, CAN_READX, CAN_READY };
> +
> +struct w90p910drv_ts {
> + =C2=A0 =C2=A0 =C2=A0 struct input_dev *input;
> + =C2=A0 =C2=A0 =C2=A0 struct timer_list timer;
> + =C2=A0 =C2=A0 =C2=A0 int irq_num;
> + =C2=A0 =C2=A0 =C2=A0 int pendown;
> + =C2=A0 =C2=A0 =C2=A0 int clocken;
> + =C2=A0 =C2=A0 =C2=A0 void __iomem *ts_reg;
> + =C2=A0 =C2=A0 =C2=A0 short x;
> + =C2=A0 =C2=A0 =C2=A0 short y;
> + =C2=A0 =C2=A0 =C2=A0 spinlock_t lock;
> + =C2=A0 =C2=A0 =C2=A0 enum ts_state state;
> +};
> +
> +static void w90p910_report_event(struct w90p910drv_ts *w90p910_ts)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct input_dev *dev =3D w90p910_ts->input;
> +
> + =C2=A0 =C2=A0 =C2=A0 w90p910_ts->x =3D __raw_readl(w90p910_ts->ts_r=
eg+0x0c);
> + =C2=A0 =C2=A0 =C2=A0 w90p910_ts->y =3D __raw_readl(w90p910_ts->ts_r=
eg+0x10);
> +
> + =C2=A0 =C2=A0 =C2=A0 input_report_abs(dev, ABS_X, w90p910_ts->x);
> + =C2=A0 =C2=A0 =C2=A0 input_report_abs(dev, ABS_Y, w90p910_ts->y);
> + =C2=A0 =C2=A0 =C2=A0 input_report_key(dev, BTN_TOUCH, w90p910_ts->p=
endown);
> + =C2=A0 =C2=A0 =C2=A0 input_sync(dev);
> +}
> +
> +static void w90p910_ts_interrupt(struct w90p910drv_ts *w90p910_ts)
> +{
> + =C2=A0 =C2=A0 =C2=A0 if ((__raw_readl(w90p910_ts->ts_reg)&WT_INT) &=
&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 w90p910=
_ts->state =3D=3D NO_PRESS) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 w90p910_ts->pendow=
n =3D 1;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __raw_writel(ADC_T=
SC_X, w90p910_ts->ts_reg+0x04);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __raw_writel((__ra=
w_readl(w90p910_ts->ts_reg)|
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ADC_SEMIAUTO|ADC_INT_EN|ADC_CONV)&(~WT_INT|~WT_INT_EN),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 w90p910_ts->ts_reg);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 w90p910_ts->state =
=3D CAN_READX;
> + =C2=A0 =C2=A0 =C2=A0 } else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (__raw_readl(w9=
0p910_ts->ts_reg+0x04)&ADC_DOWN) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 __raw_writel(ADC_TSC_X, w90p910_ts->ts_reg+0x04);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 __raw_writel((__raw_readl(w90p910_ts->ts_reg)|
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ADC_SEMIAUTO|ADC_INT_EN|ADC_CONV)&(=
~WT_INT_EN),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 w90p910_ts->ts_reg);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 w90p910_ts->pendown =3D 1;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 w90p910_ts->state =3D CAN_READX;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 __raw_writel((__raw_readl(w90p910_ts->ts_reg)|
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ADC_WAITTRIG|WT_INT_EN)&(~ADC_INT_E=
N|
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~WT_INT=
|~ADC_INT), w90p910_ts->ts_reg);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 w90p910_ts->pendown =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 w90p910_ts->state =3D NO_PRESS;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 if ((__raw_readl(w90p910_ts->ts_reg)&ADC_INT) =
&&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 w90p910=
_ts->state =3D=3D CAN_READX) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __raw_writel(ADC_T=
SC_Y, w90p910_ts->ts_reg+0x04);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __raw_writel((__ra=
w_readl(w90p910_ts->ts_reg)|ADC_SEMIAUTO|
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ADC_INT_EN|ADC_CONV)&(~ADC_INT|~WT_=
INT_EN),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 w90p910_ts->ts_reg);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 w90p910_ts->state =
=3D CAN_READY;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 if ((__raw_readl(w90p910_ts->ts_reg)&ADC_INT) =
&&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 w90p910=
_ts->state =3D=3D CAN_READY) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 w90p910_report_eve=
nt(w90p910_ts);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __raw_writel((__ra=
w_readl(w90p910_ts->ts_reg)|
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ADC_WAITTRIG)&(~ADC_INT|~WT_INT_EN|~ADC_INT_EN),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0w90p910_ts->ts_r=
eg);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mod_timer(&w90p910=
_ts->timer, jiffies +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 msecs_to_jiffies(40));
> + =C2=A0 =C2=A0 =C2=A0 }
> +}
> +
> +static void w90p910_ts_timer(unsigned long data)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct w90p910drv_ts *w90p910_data =3D (struct=
 w90p910drv_ts *) data;
> + =C2=A0 =C2=A0 =C2=A0 unsigned long flags;
> +
> + =C2=A0 =C2=A0 =C2=A0 spin_lock_irqsave(&w90p910_data->lock, flags);
> +
> + =C2=A0 =C2=A0 =C2=A0 w90p910_ts_interrupt(w90p910_data);
> +
> + =C2=A0 =C2=A0 =C2=A0 spin_unlock_irqrestore(&w90p910_data->lock, fl=
ags);
> +}
> +
> +static irqreturn_t ts_interrupt(int irq, void *dev_id)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct w90p910drv_ts *w90p910_data =3D dev_id;
> +
> + =C2=A0 =C2=A0 =C2=A0 w90p910_ts_interrupt(w90p910_data);
> + =C2=A0 =C2=A0 =C2=A0 return IRQ_HANDLED;
> +}
> +
> +static int __devinit w90x900ts_probe(struct platform_device *pdev)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct w90p910drv_ts *w90p910_ts;
> + =C2=A0 =C2=A0 =C2=A0 struct input_dev *input_dev;
> + =C2=A0 =C2=A0 =C2=A0 int err =3D -ENOMEM;
> + =C2=A0 =C2=A0 =C2=A0 struct resource *res;
> +
> + =C2=A0 =C2=A0 =C2=A0 w90p910_ts =3D kzalloc(sizeof(struct w90p910dr=
v_ts), GFP_KERNEL);
> + =C2=A0 =C2=A0 =C2=A0 input_dev =3D input_allocate_device();
> + =C2=A0 =C2=A0 =C2=A0 if (!w90p910_ts || !input_dev)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto fail1;
> +
> + =C2=A0 =C2=A0 =C2=A0 platform_set_drvdata(pdev, w90p910_ts);
> +
> + =C2=A0 =C2=A0 =C2=A0 w90p910_ts->input =3D input_dev;
> + =C2=A0 =C2=A0 =C2=A0 w90p910_ts->state =3D NO_PRESS;
> + =C2=A0 =C2=A0 =C2=A0 w90p910_ts->clocken =3D (int)W90X900_VA_CLKPWR=
;
> + =C2=A0 =C2=A0 =C2=A0 spin_lock_init(&w90p910_ts->lock);
> + =C2=A0 =C2=A0 =C2=A0 setup_timer(&w90p910_ts->timer, w90p910_ts_tim=
er,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 (unsigned long)w90p910_ts);
> +
> + =C2=A0 =C2=A0 =C2=A0 res =3D platform_get_resource(pdev, IORESOURCE=
_MEM, 0);
> + =C2=A0 =C2=A0 =C2=A0 if (!res) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D -ENXIO;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto fail1;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 if (!request_mem_region(res->start, res->end -=
 res->start + 1,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pdev->name)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D -EBUSY;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto fail1;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 w90p910_ts->ts_reg =3D ioremap(res->start, res=
->end - res->start + 1);
> + =C2=A0 =C2=A0 =C2=A0 if (!w90p910_ts->ts_reg) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D -ENOMEM;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto fail2;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 /* enable the ADC clock */
> + =C2=A0 =C2=A0 =C2=A0 __raw_writel(__raw_readl(w90p910_ts->clocken)|=
ADC_CLK_EN,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 w90p910_ts->clocken);
> +
> + =C2=A0 =C2=A0 =C2=A0 input_dev->name =3D "W90P910 TouchScreen";
> + =C2=A0 =C2=A0 =C2=A0 input_dev->phys =3D "w90p910ts/event0";
> + =C2=A0 =C2=A0 =C2=A0 input_dev->id.bustype =3D BUS_HOST;
> + =C2=A0 =C2=A0 =C2=A0 input_dev->id.vendor =C2=A0 =C2=A0=3D 0x0005;
> + =C2=A0 =C2=A0 =C2=A0 input_dev->id.product =3D 0x0001;
> + =C2=A0 =C2=A0 =C2=A0 input_dev->id.version =3D 0x0100;
> + =C2=A0 =C2=A0 =C2=A0 input_dev->dev.parent =3D &pdev->dev;
> + =C2=A0 =C2=A0 =C2=A0 input_dev->evbit[0] =3D BIT_MASK(EV_KEY)|
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BIT_MASK(EV_ABS) | BIT_MASK(EV_SYN)=
;
> + =C2=A0 =C2=A0 =C2=A0 input_dev->keybit[BIT_WORD(BTN_TOUCH)] =3D BIT=
_MASK(BTN_TOUCH);
> +
> + =C2=A0 =C2=A0 =C2=A0 input_set_abs_params(input_dev, ABS_X, 0, 0x40=
0, 0, 0);
> + =C2=A0 =C2=A0 =C2=A0 input_set_abs_params(input_dev, ABS_Y, 0, 0x40=
0, 0, 0);
> +
> + =C2=A0 =C2=A0 =C2=A0 w90p910_ts->irq_num =3D platform_get_irq(pdev,=
 0);
> + =C2=A0 =C2=A0 =C2=A0 if (request_irq(w90p910_ts->irq_num, ts_interr=
upt, IRQF_DISABLED,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 "w90p910ts", w90p910_ts)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D -EBUSY;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto fail3;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 err =3D input_register_device(w90p910_ts->inpu=
t);
> + =C2=A0 =C2=A0 =C2=A0 if (err)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto fail4;
> +
> + =C2=A0 =C2=A0 =C2=A0 __raw_writel(ADC_RST1, w90p910_ts->ts_reg);
> + =C2=A0 =C2=A0 =C2=A0 msleep(1);
> + =C2=A0 =C2=A0 =C2=A0 __raw_writel(ADC_RST0, w90p910_ts->ts_reg);
> + =C2=A0 =C2=A0 =C2=A0 msleep(1);
> +
> + =C2=A0 =C2=A0 =C2=A0 /* set delay and screen type */
> + =C2=A0 =C2=A0 =C2=A0 __raw_writel(__raw_readl(w90p910_ts->ts_reg+0x=
04) & TSC_FOURWIRE,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 (w90p910_ts->ts_reg+0x04));
> + =C2=A0 =C2=A0 =C2=A0 __raw_writel(ADC_DELAY, (w90p910_ts->ts_reg+0x=
08));
> + =C2=A0 =C2=A0 =C2=A0 /* waitting for trigger mode */
> + =C2=A0 =C2=A0 =C2=A0 __raw_writel((__raw_readl(w90p910_ts->ts_reg)|
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ADC_WAITTRIG|ADC_D=
IV|ADC_EN|WT_INT_EN), w90p910_ts->ts_reg);
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +
> +fail4: free_irq(w90p910_ts->irq_num, w90p910_ts);
> +fail3: iounmap(w90p910_ts->ts_reg);
> +fail2: release_mem_region(res->start, res->end - res->start + 1);
> +fail1: input_free_device(input_dev);
> + =C2=A0 =C2=A0 =C2=A0 kfree(w90p910_ts);
> + =C2=A0 =C2=A0 =C2=A0 return err;
> +}
> +
> +static int __devexit w90x900ts_remove(struct platform_device *pdev)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct w90p910drv_ts *w90p910_ts =3D platform_=
get_drvdata(pdev);
> + =C2=A0 =C2=A0 =C2=A0 struct resource *res;
> +
> + =C2=A0 =C2=A0 =C2=A0 free_irq(w90p910_ts->irq_num, w90p910_ts);
> + =C2=A0 =C2=A0 =C2=A0 del_timer_sync(&w90p910_ts->timer);
> + =C2=A0 =C2=A0 =C2=A0 iounmap(w90p910_ts->ts_reg);
> +
> + =C2=A0 =C2=A0 =C2=A0 res =3D platform_get_resource(pdev, IORESOURCE=
_MEM, 0);
> + =C2=A0 =C2=A0 =C2=A0 release_mem_region(res->start, res->end - res-=
>start + 1);
> +
> + =C2=A0 =C2=A0 =C2=A0 input_unregister_device(w90p910_ts->input);
> + =C2=A0 =C2=A0 =C2=A0 kfree(w90p910_ts);
> +
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +
> +static struct platform_driver w90x900ts_driver =3D {
> + =C2=A0 =C2=A0 =C2=A0 .probe =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D w=
90x900ts_probe,
> + =C2=A0 =C2=A0 =C2=A0 .remove =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D __deve=
xit_p(w90x900ts_remove),
> + =C2=A0 =C2=A0 =C2=A0 .driver =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =3D "=
w90x900-ts",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .owner =C2=A0=3D T=
HIS_MODULE,
> + =C2=A0 =C2=A0 =C2=A0 },
> +};
> +
> +static int __init w90x900ts_init(void)
> +{
> + =C2=A0 =C2=A0 =C2=A0 return platform_driver_register(&w90x900ts_dri=
ver);
> +}
> +
> +static void __exit w90x900ts_exit(void)
> +{
> + =C2=A0 =C2=A0 =C2=A0 platform_driver_unregister(&w90x900ts_driver);
> +}
> +
> +module_init(w90x900ts_init);
> +module_exit(w90x900ts_exit);
> +
> +MODULE_AUTHOR("Wan ZongShun <mcuos.com@gmail.com>");
> +MODULE_DESCRIPTION("w90p910 touch screen driver!");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:w90p910-ts");
>



--=20
embedded forum
http://mcuos.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
