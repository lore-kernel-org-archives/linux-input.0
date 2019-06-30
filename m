From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] Input: edt-ft5x06 - simplify event reporting code
Date: Sun, 30 Jun 2019 00:05:52 -0700
Message-ID: <20190630070552.GA91171@dtor-ws>
References: <20190623063153.261546-1-dmitry.torokhov@gmail.com>
 <20190623063153.261546-2-dmitry.torokhov@gmail.com>
 <CAHp75VfgR4d7aOG6XPBXisrfa=30pYfCJZ1Yhh2E44bs8vWmVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VfgR4d7aOG6XPBXisrfa=30pYfCJZ1Yhh2E44bs8vWmVw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Marco Felsch <m.felsch@pengutronix.de>, Benoit Parrot <bparrot@ti.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Sun, Jun 23, 2019 at 10:59:18AM +0300, Andy Shevchenko wrote:
> On Sun, Jun 23, 2019 at 9:31 AM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > Now that input_mt_report_slot_state() returns true if slot is active we no
> > longer need a temporary for the slot state.
> 
> 
> > -               down = type != TOUCH_EVENT_UP;
> >
> >                 input_mt_slot(tsdata->input, id);
> > -               input_mt_report_slot_state(tsdata->input, MT_TOOL_FINGER, down);
> 
> > +               if (input_mt_report_slot_state(tsdata->input, MT_TOOL_FINGER,
> > +                                              type != TOUCH_EVENT_UP))
> 
> Can't we simple do somethink like
> -               down = type != TOUCH_EVENT_UP;
> +               down = input_mt_report_slot_state(tsdata->input,
> MT_TOOL_FINGER, type != TOUCH_EVENT_UP);

Why though? The temporary was needed so we did not have to repeat the
expression for "contact down" condition, and now we do not need it. The
whole change was done so that we cab remove the temporary...

Thanks.

-- 
Dmitry
