From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [Patch 1/1] Input: edt-ft5x06 - disable irq handling during
 suspend
Date: Sat, 22 Jun 2019 22:59:40 -0700
Message-ID: <20190623055940.GA204275@dtor-ws>
References: <20190621185124.28966-1-bparrot@ti.com>
 <CAHp75VdcAfmn8u0du-Y95SjMcmuJa2402tdXCNHMcme1Y925xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VdcAfmn8u0du-Y95SjMcmuJa2402tdXCNHMcme1Y925xg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Benoit Parrot <bparrot@ti.com>, Henrik Rydberg <rydberg@bitmath.org>, Marco Felsch <m.felsch@pengutronix.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-input <linux-input@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Sat, Jun 22, 2019 at 01:37:10PM +0300, Andy Shevchenko wrote:
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

If we are using level interrupts then it will work OK, however it is
really easy to lose edge here, as replaying disabled edge triggered
interrupts is not really reliable.

Benoit, what kind of interrupt do you use in your system?

Thanks.

-- 
Dmitry
