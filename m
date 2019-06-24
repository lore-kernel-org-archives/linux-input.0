From: Benoit Parrot <bparrot@ti.com>
Subject: Re: [Patch 1/1] Input: edt-ft5x06 - disable irq handling during
 suspend
Date: Mon, 24 Jun 2019 07:21:20 -0500
Message-ID: <20190624122120.hq7of57loegwudiv@ti.com>
References: <20190621185124.28966-1-bparrot@ti.com>
 <CAHp75VdcAfmn8u0du-Y95SjMcmuJa2402tdXCNHMcme1Y925xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VdcAfmn8u0du-Y95SjMcmuJa2402tdXCNHMcme1Y925xg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Marco Felsch <m.felsch@pengutronix.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-input <linux-input@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Andy Shevchenko <andy.shevchenko@gmail.com> wrote on Sat [2019-Jun-22 13:37:10 +0300]:
> On Fri, Jun 21, 2019 at 9:53 PM Benoit Parrot <bparrot@ti.com> wrote:
> >
> > As a wakeup source when the system is in suspend there is little point
> > trying to access a register across the i2c bus as it is probably still
> > inactive. We need to prevent the irq handler from being called during
> > suspend.
> >
> 
> Hmm... But how OS will know what the event to handle afterwards?
> I mean shouldn't we guarantee somehow the delivery of the event to the
> input, in this case, subsystem followed by corresponding user space?

I am not sure I understand, do you mean that you want the input wake up event
being processed by the edt_ft50x6 driver as it happens? How can we do that
if we can't access the device through the bus? Are we trying to capture
specific gesture here (given that the display should be off during
sleep/suspend)?

Anyhow here I am just trying to eliminate the runtime error caused by
trying to access a resource which we know is unavailable at the time.
What method would you suggest we use to achieve this? 

Benoit

> 
> > Without this modification upon wakeup you would see the following kernel
> > error:
> >
> > [ 118.733717] PM: Wakeup source GPIO0
> > [ 118.751933] edt_ft5x06 1-0038: Unable to fetch data, error: -13
> >
> > Signed-off-by: Benoit Parrot <bparrot@ti.com>
> > ---
> >  drivers/input/touchscreen/edt-ft5x06.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
> > index c639ebce914c..c885bfe783a4 100644
> > --- a/drivers/input/touchscreen/edt-ft5x06.c
> > +++ b/drivers/input/touchscreen/edt-ft5x06.c
> > @@ -1200,8 +1200,10 @@ static int __maybe_unused edt_ft5x06_ts_suspend(struct device *dev)
> >  {
> >         struct i2c_client *client = to_i2c_client(dev);
> >
> > -       if (device_may_wakeup(dev))
> > +       if (device_may_wakeup(dev)) {
> >                 enable_irq_wake(client->irq);
> > +               disable_irq(client->irq);
> > +       }
> >
> >         return 0;
> >  }
> > @@ -1210,8 +1212,10 @@ static int __maybe_unused edt_ft5x06_ts_resume(struct device *dev)
> >  {
> >         struct i2c_client *client = to_i2c_client(dev);
> >
> > -       if (device_may_wakeup(dev))
> > +       if (device_may_wakeup(dev)) {
> >                 disable_irq_wake(client->irq);
> > +               enable_irq(client->irq);
> > +       }
> >
> >         return 0;
> >  }
> > --
> > 2.17.1
> >
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
