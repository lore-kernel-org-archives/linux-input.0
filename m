From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 2/2] Input: edt-ft5x06 - simplify event reporting code
Date: Mon, 1 Jul 2019 13:41:24 +0300
Message-ID: <CAHp75VfZn6ZuScgQtXt=5_T=LmsodG7NCCo1ABx6v9aON19c0w@mail.gmail.com>
References: <20190623063153.261546-1-dmitry.torokhov@gmail.com>
 <20190623063153.261546-2-dmitry.torokhov@gmail.com> <CAHp75VfgR4d7aOG6XPBXisrfa=30pYfCJZ1Yhh2E44bs8vWmVw@mail.gmail.com>
 <20190630070552.GA91171@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190630070552.GA91171@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Marco Felsch <m.felsch@pengutronix.de>, Benoit Parrot <bparrot@ti.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Sun, Jun 30, 2019 at 10:05 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Sun, Jun 23, 2019 at 10:59:18AM +0300, Andy Shevchenko wrote:
> > On Sun, Jun 23, 2019 at 9:31 AM Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> > >
> > > Now that input_mt_report_slot_state() returns true if slot is active we no
> > > longer need a temporary for the slot state.

> > > -               down = type != TOUCH_EVENT_UP;
> > >
> > >                 input_mt_slot(tsdata->input, id);
> > > -               input_mt_report_slot_state(tsdata->input, MT_TOOL_FINGER, down);
> >
> > > +               if (input_mt_report_slot_state(tsdata->input, MT_TOOL_FINGER,
> > > +                                              type != TOUCH_EVENT_UP))
> >
> > Can't we simple do somethink like
> > -               down = type != TOUCH_EVENT_UP;
> > +               down = input_mt_report_slot_state(tsdata->input,
> > MT_TOOL_FINGER, type != TOUCH_EVENT_UP);
>
> Why though? The temporary was needed so we did not have to repeat the
> expression for "contact down" condition, and now we do not need it. The
> whole change was done so that we cab remove the temporary...

I see. Thanks for explanation.

-- 
With Best Regards,
Andy Shevchenko
