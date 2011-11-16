From: Daniel Kurtz <djkurtz@google.com>
Subject: Re: [PATCH 5/6] Input: ucb1400_ts - convert to threaded IRQ
Date: Wed, 16 Nov 2011 15:36:37 +0800
Message-ID: <CAGS+omCkC4uwm2XFQmtHC5BwcnyTT5=rGJ9jhJfv7=BwZm8D+g@mail.gmail.com>
References: <1321259771-10925-1-git-send-email-dmitry.torokhov@gmail.com> <1321259771-10925-5-git-send-email-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33369 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754537Ab1KPHg7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Nov 2011 02:36:59 -0500
Received: by iage36 with SMTP id e36so225417iag.19
        for <linux-input@vger.kernel.org>; Tue, 15 Nov 2011 23:36:58 -0800 (PST)
In-Reply-To: <1321259771-10925-5-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>

Hi Dmitry,

On Mon, Nov 14, 2011 at 4:36 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Instead of manually create and handler kernel thread switch to thread=
ed
> IRQ and let kernel IRQ core manage thread for us.
>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
> =A0drivers/input/touchscreen/ucb1400_ts.c | =A0235 +++++++++++++++---=
--------------
> =A0include/linux/ucb1400.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A06 =
+-
> =A02 files changed, 115 insertions(+), 126 deletions(-)
>
> diff --git a/drivers/input/touchscreen/ucb1400_ts.c b/drivers/input/t=
ouchscreen/ucb1400_ts.c
> index 5c6b7b3..1862633 100644
> --- a/drivers/input/touchscreen/ucb1400_ts.c
> +++ b/drivers/input/touchscreen/ucb1400_ts.c
> @@ -20,24 +20,24 @@
>
> =A0#include <linux/module.h>
> =A0#include <linux/init.h>
> -#include <linux/completion.h>
> =A0#include <linux/delay.h>
> +#include <linux/sched.h>
> +#include <linux/wait.h>
> =A0#include <linux/input.h>
> =A0#include <linux/device.h>
> =A0#include <linux/interrupt.h>
> -#include <linux/suspend.h>
> -#include <linux/kthread.h>
> -#include <linux/freezer.h>
> =A0#include <linux/ucb1400.h>
>
> +#define UCB1400_TS_POLL_PERIOD 10 /* ms */
> +
> =A0static int adcsync;
> =A0static int ts_delay =3D 55; /* us */
> =A0static int ts_delay_pressure; =A0/* us */
>
> =A0/* Switch to interrupt mode. */
> -static void ucb1400_ts_mode_int(struct snd_ac97 *ac97)
> +static void ucb1400_ts_mode_int(struct ucb1400_ts *ucb)
> =A0{
> - =A0 =A0 =A0 ucb1400_reg_write(ac97, UCB_TS_CR,
> + =A0 =A0 =A0 ucb1400_reg_write(ucb->ac97, UCB_TS_CR,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0UCB_TS_CR_TSMX_POW | U=
CB_TS_CR_TSPX_POW |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0UCB_TS_CR_TSMY_GND | U=
CB_TS_CR_TSPY_GND |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0UCB_TS_CR_MODE_INT);
> @@ -53,7 +53,9 @@ static unsigned int ucb1400_ts_read_pressure(struct=
 ucb1400_ts *ucb)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0UCB_TS_CR_TSMX_POW | U=
CB_TS_CR_TSPX_POW |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0UCB_TS_CR_TSMY_GND | U=
CB_TS_CR_TSPY_GND |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0UCB_TS_CR_MODE_PRES | =
UCB_TS_CR_BIAS_ENA);
> +
> =A0 =A0 =A0 =A0udelay(ts_delay_pressure);
> +
> =A0 =A0 =A0 =A0return ucb1400_adc_read(ucb->ac97, UCB_ADC_INP_TSPY, a=
dcsync);
> =A0}
>
> @@ -127,26 +129,26 @@ static unsigned int ucb1400_ts_read_yres(struct=
 ucb1400_ts *ucb)
> =A0 =A0 =A0 =A0return ucb1400_adc_read(ucb->ac97, 0, adcsync);
> =A0}
>
> -static int ucb1400_ts_pen_up(struct snd_ac97 *ac97)
> +static int ucb1400_ts_pen_up(struct ucb1400_ts *ucb)
> =A0{
> - =A0 =A0 =A0 unsigned short val =3D ucb1400_reg_read(ac97, UCB_TS_CR=
);
> + =A0 =A0 =A0 unsigned short val =3D ucb1400_reg_read(ucb->ac97, UCB_=
TS_CR);
>
> =A0 =A0 =A0 =A0return val & (UCB_TS_CR_TSPX_LOW | UCB_TS_CR_TSMX_LOW)=
;
> =A0}
>
> -static void ucb1400_ts_irq_enable(struct snd_ac97 *ac97)
> +static void ucb1400_ts_irq_enable(struct ucb1400_ts *ucb)
> =A0{
> - =A0 =A0 =A0 ucb1400_reg_write(ac97, UCB_IE_CLEAR, UCB_IE_TSPX);
> - =A0 =A0 =A0 ucb1400_reg_write(ac97, UCB_IE_CLEAR, 0);
> - =A0 =A0 =A0 ucb1400_reg_write(ac97, UCB_IE_FAL, UCB_IE_TSPX);
> + =A0 =A0 =A0 ucb1400_reg_write(ucb->ac97, UCB_IE_CLEAR, UCB_IE_TSPX)=
;
> + =A0 =A0 =A0 ucb1400_reg_write(ucb->ac97, UCB_IE_CLEAR, 0);
> + =A0 =A0 =A0 ucb1400_reg_write(ucb->ac97, UCB_IE_FAL, UCB_IE_TSPX);
> =A0}
>
> -static void ucb1400_ts_irq_disable(struct snd_ac97 *ac97)
> +static void ucb1400_ts_irq_disable(struct ucb1400_ts *ucb)
> =A0{
> - =A0 =A0 =A0 ucb1400_reg_write(ac97, UCB_IE_FAL, 0);
> + =A0 =A0 =A0 ucb1400_reg_write(ucb->ac97, UCB_IE_FAL, 0);
> =A0}
>
> -static void ucb1400_ts_evt_add(struct input_dev *idev, u16 pressure,=
 u16 x, u16 y)
> +static void ucb1400_ts_report_event(struct input_dev *idev, u16 pres=
sure, u16 x, u16 y)
> =A0{
> =A0 =A0 =A0 =A0input_report_abs(idev, ABS_X, x);
> =A0 =A0 =A0 =A0input_report_abs(idev, ABS_Y, y);
> @@ -162,7 +164,7 @@ static void ucb1400_ts_event_release(struct input=
_dev *idev)
> =A0 =A0 =A0 =A0input_sync(idev);
> =A0}
>
> -static void ucb1400_handle_pending_irq(struct ucb1400_ts *ucb)
> +static void ucb1400_clear_pending_irq(struct ucb1400_ts *ucb)
> =A0{
> =A0 =A0 =A0 =A0unsigned int isr;
>
> @@ -171,32 +173,34 @@ static void ucb1400_handle_pending_irq(struct u=
cb1400_ts *ucb)
> =A0 =A0 =A0 =A0ucb1400_reg_write(ucb->ac97, UCB_IE_CLEAR, 0);
>
> =A0 =A0 =A0 =A0if (isr & UCB_IE_TSPX)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ucb1400_ts_irq_disable(ucb->ac97);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ucb1400_ts_irq_disable(ucb);
> =A0 =A0 =A0 =A0else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&ucb->ts_idev->dev, "ucb1400: u=
nexpected IE_STATUS =3D %#x\n", isr);
> - =A0 =A0 =A0 enable_irq(ucb->irq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&ucb->ts_idev->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "ucb1400: unexpected IE=
_STATUS =3D %#x\n", isr);
> =A0}
>
> -static int ucb1400_ts_thread(void *_ucb)
> +/*
> + * A restriction with interrupts exists when using the ucb1400, as
> + * the codec read/write routines may sleep while waiting for codec
> + * access completion and uses semaphores for access control to the
> + * AC97 bus. Therefore the driver is forced to use threaded interrup=
t
> + * handler.
> + */
> +static irqreturn_t ucb1400_irq(int irqnr, void *devid)
> =A0{
> - =A0 =A0 =A0 struct ucb1400_ts *ucb =3D _ucb;
> - =A0 =A0 =A0 struct task_struct *tsk =3D current;
> - =A0 =A0 =A0 int valid =3D 0;
> - =A0 =A0 =A0 struct sched_param param =3D { .sched_priority =3D 1 };
> + =A0 =A0 =A0 struct ucb1400_ts *ucb =3D devid;
> + =A0 =A0 =A0 unsigned int x, y, p;
> + =A0 =A0 =A0 bool penup;
>
> - =A0 =A0 =A0 sched_setscheduler(tsk, SCHED_FIFO, &param);
> + =A0 =A0 =A0 if (unlikely(irqnr !=3D ucb->irq))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_NONE;
>
> - =A0 =A0 =A0 set_freezable();
> - =A0 =A0 =A0 while (!kthread_should_stop()) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int x, y, p;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 long timeout;
> + =A0 =A0 =A0 ucb1400_clear_pending_irq(ucb);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ucb->ts_restart =3D 0;
> + =A0 =A0 =A0 /* Start with a small delay before checking pendown sta=
te */
> + =A0 =A0 =A0 msleep(UCB1400_TS_POLL_PERIOD);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ucb->irq_pending) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ucb->irq_pending =3D 0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ucb1400_handle_pending_=
irq(ucb);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 while (!ucb->stopped && !(penup =3D ucb1400_ts_pen_up(u=
cb))) {
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ucb1400_adc_enable(ucb->ac97);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0x =3D ucb1400_ts_read_xpos(ucb);
> @@ -204,91 +208,62 @@ static int ucb1400_ts_thread(void *_ucb)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0p =3D ucb1400_ts_read_pressure(ucb);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ucb1400_adc_disable(ucb->ac97);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Switch back to interrupt mode. */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ucb1400_ts_mode_int(ucb->ac97);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 msleep(10);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ucb1400_ts_pen_up(ucb->ac97)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ucb1400_ts_irq_enable(u=
cb->ac97);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* If we spat out a v=
alid sample set last time,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* spit out a "pen of=
f" sample here.
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (valid) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ucb1400=
_ts_event_release(ucb->ts_idev);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 valid =3D=
 0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout =3D MAX_SCHEDUL=
E_TIMEOUT;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 valid =3D 1;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ucb1400_ts_evt_add(ucb-=
>ts_idev, p, x, y);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout =3D msecs_to_ji=
ffies(10);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ucb1400_ts_report_event(ucb->ts_idev, p=
, x, y);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 wait_event_freezable_timeout(ucb->ts_wa=
it,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ucb->irq_pending || ucb=
->ts_restart ||
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kthread_should_stop(), =
timeout);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wait_event_timeout(ucb->ts_wait, ucb->s=
topped,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
msecs_to_jiffies(UCB1400_TS_POLL_PERIOD));
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 /* Send the "pen off" if we are stopping with the pen s=
till active */
> - =A0 =A0 =A0 if (valid)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ucb1400_ts_event_release(ucb->ts_idev);
> + =A0 =A0 =A0 ucb1400_ts_event_release(ucb->ts_idev);
>
> - =A0 =A0 =A0 ucb->ts_task =3D NULL;
> - =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 if (!ucb->stopped) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Switch back to interrupt mode. */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ucb1400_ts_mode_int(ucb);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ucb1400_ts_irq_enable(ucb);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return IRQ_HANDLED;
> =A0}
>
> -/*
> - * A restriction with interrupts exists when using the ucb1400, as
> - * the codec read/write routines may sleep while waiting for codec
> - * access completion and uses semaphores for access control to the
> - * AC97 bus. =A0A complete codec read cycle could take =A0anywhere f=
rom
> - * 60 to 100uSec so we *definitely* don't want to spin inside the
> - * interrupt handler waiting for codec access. =A0So, we handle the
> - * interrupt by scheduling a RT kernel thread to run in process
> - * context instead of interrupt context.
> - */
> -static irqreturn_t ucb1400_hard_irq(int irqnr, void *devid)
> +static void ucb1400_ts_stop(struct ucb1400_ts *ucb)
> =A0{
> - =A0 =A0 =A0 struct ucb1400_ts *ucb =3D devid;
> + =A0 =A0 =A0 /* Signal IRQ thread to stop polling and disable the ha=
ndler. */
> + =A0 =A0 =A0 ucb->stopped =3D true;
> + =A0 =A0 =A0 mb();
> + =A0 =A0 =A0 wake_up(&ucb->ts_wait);
> + =A0 =A0 =A0 disable_irq(ucb->irq);
>
> - =A0 =A0 =A0 if (irqnr =3D=3D ucb->irq) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 disable_irq_nosync(ucb->irq);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ucb->irq_pending =3D 1;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 wake_up(&ucb->ts_wait);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_HANDLED;
> - =A0 =A0 =A0 }
> - =A0 =A0 =A0 return IRQ_NONE;
> + =A0 =A0 =A0 ucb1400_ts_irq_disable(ucb);
> + =A0 =A0 =A0 ucb1400_reg_write(ucb->ac97, UCB_TS_CR, 0);
> +}
> +
> +/* Must be called with ts->lock held */
> +static void ucb1400_ts_start(struct ucb1400_ts *ucb)
> +{
> + =A0 =A0 =A0 /* Tell IRQ thread that it may poll the device. */
> + =A0 =A0 =A0 ucb->stopped =3D false;
> + =A0 =A0 =A0 mb();
> +
> + =A0 =A0 =A0 ucb1400_ts_mode_int(ucb);
> + =A0 =A0 =A0 ucb1400_ts_irq_enable(ucb);
> +
> + =A0 =A0 =A0 enable_irq(ucb->irq);
> =A0}
>
> =A0static int ucb1400_ts_open(struct input_dev *idev)
> =A0{
> =A0 =A0 =A0 =A0struct ucb1400_ts *ucb =3D input_get_drvdata(idev);
> - =A0 =A0 =A0 int ret =3D 0;
> -
> - =A0 =A0 =A0 BUG_ON(ucb->ts_task);
>
> - =A0 =A0 =A0 ucb->ts_task =3D kthread_run(ucb1400_ts_thread, ucb, "U=
CB1400_ts");
> - =A0 =A0 =A0 if (IS_ERR(ucb->ts_task)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(ucb->ts_task);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ucb->ts_task =3D NULL;
> - =A0 =A0 =A0 }
> + =A0 =A0 =A0 ucb1400_ts_start(ucb);
>
> - =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 return 0;
> =A0}
>
> =A0static void ucb1400_ts_close(struct input_dev *idev)
> =A0{
> =A0 =A0 =A0 =A0struct ucb1400_ts *ucb =3D input_get_drvdata(idev);
>
> - =A0 =A0 =A0 if (ucb->ts_task)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 kthread_stop(ucb->ts_task);
> -
> - =A0 =A0 =A0 ucb1400_ts_irq_disable(ucb->ac97);
> - =A0 =A0 =A0 ucb1400_reg_write(ucb->ac97, UCB_TS_CR, 0);
> + =A0 =A0 =A0 ucb1400_ts_stop(ucb);
> =A0}
>
> =A0#ifndef NO_IRQ
> @@ -342,11 +317,11 @@ static int __devinit ucb1400_ts_detect_irq(stru=
ct ucb1400_ts *ucb)
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -static int __devinit ucb1400_ts_probe(struct platform_device *dev)
> +static int __devinit ucb1400_ts_probe(struct platform_device *pdev)
> =A0{
> + =A0 =A0 =A0 struct ucb1400_ts *ucb =3D pdev->dev.platform_data;
> =A0 =A0 =A0 =A0int error, x_res, y_res;
> =A0 =A0 =A0 =A0u16 fcsr;
> - =A0 =A0 =A0 struct ucb1400_ts *ucb =3D dev->dev.platform_data;
>
> =A0 =A0 =A0 =A0ucb->ts_idev =3D input_allocate_device();
> =A0 =A0 =A0 =A0if (!ucb->ts_idev) {
> @@ -362,21 +337,13 @@ static int __devinit ucb1400_ts_probe(struct pl=
atform_device *dev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_free_devs;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 printk(KERN_DEBUG "UCB1400: found IRQ %d\n", ucb->irq);
>
> =A0 =A0 =A0 =A0init_waitqueue_head(&ucb->ts_wait);
>
> - =A0 =A0 =A0 error =3D request_irq(ucb->irq, ucb1400_hard_irq, IRQF_=
TRIGGER_RISING,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "UCB140=
0", ucb);
> - =A0 =A0 =A0 if (error) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "ucb1400: unable to gra=
b irq%d: %d\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ucb->ir=
q, error);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_devs;
> - =A0 =A0 =A0 }
> - =A0 =A0 =A0 printk(KERN_DEBUG "UCB1400: found IRQ %d\n", ucb->irq);
> -
> =A0 =A0 =A0 =A0input_set_drvdata(ucb->ts_idev, ucb);
>
> - =A0 =A0 =A0 ucb->ts_idev->dev.parent =A0 =A0 =A0 =A0=3D &dev->dev;
> + =A0 =A0 =A0 ucb->ts_idev->dev.parent =A0 =A0 =A0 =A0=3D &pdev->dev;
> =A0 =A0 =A0 =A0ucb->ts_idev->name =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D "UCB=
1400 touchscreen interface";
> =A0 =A0 =A0 =A0ucb->ts_idev->id.vendor =A0 =A0 =A0 =A0 =3D ucb1400_re=
g_read(ucb->ac97,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0AC97_VENDOR_ID1);
> @@ -404,6 +371,17 @@ static int __devinit ucb1400_ts_probe(struct pla=
tform_device *dev)
> =A0 =A0 =A0 =A0input_set_abs_params(ucb->ts_idev, ABS_Y, 0, y_res, 0,=
 0);
> =A0 =A0 =A0 =A0input_set_abs_params(ucb->ts_idev, ABS_PRESSURE, 0, 0,=
 0, 0);
>
> + =A0 =A0 =A0 ucb1400_ts_stop(ucb);
> +
> + =A0 =A0 =A0 error =3D request_threaded_irq(ucb->irq, NULL, ucb1400_=
irq,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0"UCB1400", ucb);
> + =A0 =A0 =A0 if (error) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "ucb1400: unable to gra=
b irq%d: %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ucb->ir=
q, error);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_devs;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0error =3D input_register_device(ucb->ts_idev);
> =A0 =A0 =A0 =A0if (error)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_free_irq;
> @@ -418,9 +396,9 @@ err:
> =A0 =A0 =A0 =A0return error;
> =A0}
>
> -static int __devexit ucb1400_ts_remove(struct platform_device *dev)
> +static int __devexit ucb1400_ts_remove(struct platform_device *pdev)
> =A0{
> - =A0 =A0 =A0 struct ucb1400_ts *ucb =3D dev->dev.platform_data;
> + =A0 =A0 =A0 struct ucb1400_ts *ucb =3D pdev->dev.platform_data;
>
> =A0 =A0 =A0 =A0free_irq(ucb->irq, ucb);
> =A0 =A0 =A0 =A0input_unregister_device(ucb->ts_idev);
> @@ -429,24 +407,37 @@ static int __devexit ucb1400_ts_remove(struct p=
latform_device *dev)
> =A0}
>
> =A0#ifdef CONFIG_PM_SLEEP
> +static int ucb1400_ts_suspend(struct device *dev)
> +{
> + =A0 =A0 =A0 struct ucb1400_ts *ucb =3D dev->platform_data;
> + =A0 =A0 =A0 struct input_dev *idev =3D ucb->ts_idev;
> +
> + =A0 =A0 =A0 mutex_lock(&idev->mutex);
> +
> + =A0 =A0 =A0 if (idev->users)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ucb1400_ts_start(ucb);
> +
> + =A0 =A0 =A0 mutex_unlock(&idev->mutex);
> + =A0 =A0 =A0 return 0;
> +}
> +
> =A0static int ucb1400_ts_resume(struct device *dev)
> =A0{
> =A0 =A0 =A0 =A0struct ucb1400_ts *ucb =3D dev->platform_data;
> + =A0 =A0 =A0 struct input_dev *idev =3D ucb->ts_idev;
>
> - =A0 =A0 =A0 if (ucb->ts_task) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Restart the TS thread to ensure th=
e
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* TS interrupt mode is set up again
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* after sleep.
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ucb->ts_restart =3D 1;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 wake_up(&ucb->ts_wait);
> - =A0 =A0 =A0 }
> + =A0 =A0 =A0 mutex_lock(&idev->mutex);
> +
> + =A0 =A0 =A0 if (idev->users)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ucb1400_ts_stop(ucb);
> +
> + =A0 =A0 =A0 mutex_unlock(&idev->mutex);
> =A0 =A0 =A0 =A0return 0;
> =A0}
> =A0#endif

Do you need an #else here to set *_suspend/resume to NULL when
CONFIG_PM_SLEEP is not defined?
It seems to have gotten lost somewhere.

>
> -static SIMPLE_DEV_PM_OPS(ucb1400_ts_pm_ops, NULL, ucb1400_ts_resume)=
;
> +static SIMPLE_DEV_PM_OPS(ucb1400_ts_pm_ops,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ucb1400_ts_suspend, =
ucb1400_ts_resume);
>
> =A0static struct platform_driver ucb1400_ts_driver =3D {
> =A0 =A0 =A0 =A0.probe =A0=3D ucb1400_ts_probe,
> diff --git a/include/linux/ucb1400.h b/include/linux/ucb1400.h
> index 5c75153..d21b33c 100644
> --- a/include/linux/ucb1400.h
> +++ b/include/linux/ucb1400.h
> @@ -96,13 +96,11 @@ struct ucb1400_gpio {
>
> =A0struct ucb1400_ts {
> =A0 =A0 =A0 =A0struct input_dev =A0 =A0 =A0 =A0*ts_idev;
> - =A0 =A0 =A0 struct task_struct =A0 =A0 =A0*ts_task;
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 id;
> - =A0 =A0 =A0 wait_queue_head_t =A0 =A0 =A0 ts_wait;
> - =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0ts_restart:1;
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq;
> - =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0irq_pending; =A0 =A0=
/* not bit field shared */
> =A0 =A0 =A0 =A0struct snd_ac97 =A0 =A0 =A0 =A0 *ac97;
> + =A0 =A0 =A0 wait_queue_head_t =A0 =A0 =A0 ts_wait;
> + =A0 =A0 =A0 bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0stopped;
> =A0};
>
> =A0struct ucb1400 {
> --
> 1.7.6.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Daniel Kurtz=A0|=A0Software Engineer=A0|=A0djkurtz@google.com=A0|=A0650=
=2E204.0722
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
