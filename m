From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [Patch 1/1] Input: edt-ft5x06 - disable irq handling during
 suspend
Date: Mon, 1 Jul 2019 00:32:33 -0700
Message-ID: <20190701073233.GA172968@dtor-ws>
References: <20190621185124.28966-1-bparrot@ti.com>
 <CAHp75VdcAfmn8u0du-Y95SjMcmuJa2402tdXCNHMcme1Y925xg@mail.gmail.com>
 <20190623055940.GA204275@dtor-ws>
 <20190624122457.seiezk4cla2gjh5u@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190624122457.seiezk4cla2gjh5u@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benoit Parrot <bparrot@ti.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Marco Felsch <m.felsch@pengutronix.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-input <linux-input@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Mon, Jun 24, 2019 at 07:24:57AM -0500, Benoit Parrot wrote:
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote on Sat [2019-Jun-22 22:59:40 -0700]:
> > On Sat, Jun 22, 2019 at 01:37:10PM +0300, Andy Shevchenko wrote:
> > > On Fri, Jun 21, 2019 at 9:53 PM Benoit Parrot <bparrot@ti.com> wrote:
> > > >
> > > > As a wakeup source when the system is in suspend there is little point
> > > > trying to access a register across the i2c bus as it is probably still
> > > > inactive. We need to prevent the irq handler from being called during
> > > > suspend.
> > > >
> > > 
> > > Hmm... But how OS will know what the event to handle afterwards?
> > > I mean shouldn't we guarantee somehow the delivery of the event to the
> > > input, in this case, subsystem followed by corresponding user space?
> > 
> > If we are using level interrupts then it will work OK, however it is
> > really easy to lose edge here, as replaying disabled edge triggered
> > interrupts is not really reliable.
> > 
> > Benoit, what kind of interrupt do you use in your system?
> 
> Dmitry,
> 
> On our systems we currently used edge trigger. One example is available in
> mainline: arch/arm/boot/dts/am437x-sk-evm.dts
> 632:              interrupts = <31 IRQ_TYPE_EDGE_FALLING>;

Does your device still work if you switch to level-triggered interrupt?

Regarding your patch I am uncomfortable with disabling interrupts if
interrupt is edge-triggered, as replaying edge interrupts after enabling
is not very reliable. So we should either only disable interrupt if it
is level-triggered, or make sure we read and process data from the
device after re-enabling interrupt to rearm it. We'll need to make sure
suspend does not race with interrupt handler than and also make sure we
handle case when device does not actually has data to report.

Thanks.

-- 
Dmitry
