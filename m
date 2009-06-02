From: Wan ZongShun <mcuos.com@gmail.com>
Subject: Re: [PATCH] Add support for touch screen on W90P910 ARM platform
Date: Tue, 2 Jun 2009 19:13:20 +0800
Message-ID: <e68bb3470906020413m3c817fbdu59d9741ea825741a@mail.gmail.com>
References: <e68bb3470904270803q5e69a5f4n74ff58848f397f28@mail.gmail.com>
	 <e68bb3470905111807u1ea9f7dcta9d89e5723ca9332@mail.gmail.com>
	 <e68bb3470905172007i47a5435x7b87383323a1cf1a@mail.gmail.com>
	 <200905181600.07651.dmitry.torokhov@gmail.com>
	 <e68bb3470905182054g6d9dba05kabc6c588d35b3548@mail.gmail.com>
	 <20090527141220.GA18589@dtor-d630.eng.vmware.com>
	 <4A24C0A4.3040704@gmail.com>
	 <20090602092031.GA2647@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.168]:33600 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760306AbZFBLNS (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 2 Jun 2009 07:13:18 -0400
Received: by wf-out-1314.google.com with SMTP id 26so2786097wfd.4
        for <linux-input@vger.kernel.org>; Tue, 02 Jun 2009 04:13:20 -0700 (PDT)
In-Reply-To: <20090602092031.GA2647@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Vincent Wan <mcuos.com@gmail.com>

Dear Dmitry ,

Thank you for giving me help again.

2009/6/2, Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> Hi Wan,
>
> On Tue, Jun 02, 2009 at 02:03:16PM +0800, Wan ZongShun wrote:
> > Dear Dmitry,
> >
> > Thank you for your clear patch,it looks much better than mine.
> >
> > For to make this driver work well,I have modified a piece of code
> > and made a patch based on your patch given me.
> >
> > Hope to get some advice from you again. thanks a lot.
> >
> > ---
> > w90p910 touch screen driver patch.
> >
> > Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>
> >
> > --- linux-2.6.29/drivers/input/touchscreen/w90p910_ts.c
> > +++ linux-2.6.30/drivers/input/touchscreen/w90p910_ts.c
> > @@ -76,7 +76,7 @@
> >       __raw_writel(ADC_TSC_X, w90p910_ts->ts_reg + 0x04);
> >       ctlreg = __raw_readl(w90p910_ts->ts_reg);
> >       ctlreg |= ADC_SEMIAUTO | ADC_INT_EN | ADC_CONV;
> > -     ctlreg &= ~(ADC_WAITTRIG | WT_INT_EN);
> > +     ctlreg &= ~(WT_INT|ADC_WAITTRIG | WT_INT_EN);
>
> Do we really need to reset WT_INT bit? I would think it was a read-only
> bit set by the hardware...

>From the w90p910 spec ,WT_INT should be clear by soft, and set by hardware,
so I have to add code to clear it here.

>
> >       __raw_writel(ctlreg, w90p910_ts->ts_reg);
> >
> >       w90p910_ts->state = TS_WAIT_X_COORD;
> > @@ -89,7 +89,7 @@
> >       __raw_writel(ADC_TSC_Y, w90p910_ts->ts_reg + 0x04);
> >       ctlreg = __raw_readl(w90p910_ts->ts_reg);
> >       ctlreg |= ADC_SEMIAUTO | ADC_INT_EN | ADC_CONV;
> > -     ctlreg &= ~(ADC_WAITTRIG | WT_INT_EN);
> > +     ctlreg &= ~(ADC_INT|ADC_WAITTRIG | WT_INT_EN);
>
> Same here with ADC_INT.

>From the w90p910 spec ,ADC_INT should be clear by soft, and set by hardware,
so I have to add code to clear it here too.

>
> >       __raw_writel(ctlreg, w90p910_ts->ts_reg);
> >
> >       w90p910_ts->state = TS_WAIT_Y_COORD;
> > @@ -110,21 +110,14 @@
> >  static irqreturn_t w90p910_ts_interrupt(int irq, void *dev_id)
> >  {
> >       struct w90p910_ts *w90p910_ts = dev_id;
> > -     unsigned long flags;
> > +     unsigned long flags, val;
> >
> >       spin_lock_irqsave(&w90p910_ts->lock, flags);
> >
> >       switch (w90p910_ts->state) {
> >       case TS_WAIT_NEW_PACKET:
> > -             if (__raw_readl(w90p910_ts->ts_reg + 0x04) & ADC_DOWN) {
> > -                     w90p910_prepare_x_reading(w90p910_ts);
> > -             } else {
> > -                     w90p910_report_event(w90p910_ts, false);
> > -                     del_timer(&w90p910_ts->timer);
> > -                     w90p910_prepare_next_packet(w90p910_ts);
> > -             }
> > +             w90p910_prepare_x_reading(w90p910_ts);
>
> OK, so it is not possible to get an interrupt when pen leaves the
> screen, it only generates interrupts while we are touching it,
> correct?

Okay,you are right, according to the spec,only the interrupt can occur
when touching it .

>
> >               break;
> > -
> >
> >       case TS_WAIT_X_COORD:
> >               w90p910_prepare_y_reading(w90p910_ts);
> > @@ -132,7 +125,15 @@
> >
> >       case TS_WAIT_Y_COORD:
> >               w90p910_report_event(w90p910_ts, true);
> > -             w90p910_prepare_next_packet(w90p910_ts);
> > +
> > +             /* When timer starts,it should disable all ts
> > +             *  interrupt and change mode to wait trigger.
> > +             */
> > +             val = __raw_readl(w90p910_ts->ts_reg);
> > +             val |= ADC_WAITTRIG;
> > +             val &= ~(ADC_INT | ADC_INT_EN | WT_INT_EN);
> > +             __raw_writel(val, w90p910_ts->ts_reg);
> > +
>
> I am not sure about this... are you positive that we can't continue
> working the device in interrupt mode and have to resort to polling
> after the first touch has been registered?

After the first touch occur, with the help of the timer callback
function, I want to know if the pen still keep down.and if it keep
up,I will think the first touch has finished and I will close timer,
change mode to wait trigger and enable the WT interrupt for waitting
next touch, so next touch also rely on the WT interrupt.

I assume a situation that I make a line by pen in my touchscreen and
get all values of x and y to user regarding the line,for that,I need
to press my pen and keep it down and moving for making the line,then I
put up my pen,so the lines has been finished.

I think the timer should be in one shot mode and only does the judge
whether my pen still keep down or up. and if pen keep down, we can
enable the ADC interrupt and continue to read values (x and y) of the
line,contrarily(if pen up),I think the line has been finished and have
to change to wait trigger mode and enable WT interrupt and wait next
touch occur.

>
> >               mod_timer(&w90p910_ts->timer, jiffies + msecs_to_jiffies(40));
> >               break;
> >
> > @@ -152,11 +153,11 @@
> >
> >       spin_lock_irqsave(&w90p910_ts->lock, flags);
> >
> > -     if (w90p910_ts->state == TS_WAIT_NEW_PACKET &&
> > -         !(__raw_readl(w90p910_ts->ts_reg + 0x04) & ADC_DOWN)) {
> > -
> > +     if (!(__raw_readl(w90p910_ts->ts_reg + 0x04) & ADC_DOWN)) {
> >               w90p910_report_event(w90p910_ts, false);
> >               w90p910_prepare_next_packet(w90p910_ts);
> > +     } else {
> > +             w90p910_prepare_x_reading(w90p910_ts);
> >       }
> >
> >       spin_unlock_irqrestore(&w90p910_ts->lock, flags);
> > @@ -185,6 +186,9 @@
> >       val = __raw_readl(w90p910_ts->ts_reg);
> >       val |= ADC_WAITTRIG | ADC_DIV | ADC_EN | WT_INT_EN;
> >       __raw_writel(val, w90p910_ts->ts_reg);
> > +
> > +     /* set a waitting new press state */
> > +     w90p910_ts->state = TS_WAIT_NEW_PACKET;
> >
> >       return 0;
> >  }
> >
>
> Thanks!
>
> --
> Dmitry
>

-- 
embedded forum
http://mcuos.com
