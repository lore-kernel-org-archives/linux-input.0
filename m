From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / sleep / irq: Do not suspend wakeup interrupts
Date: Tue, 15 Jul 2014 14:50:28 +0200
Message-ID: <1776825.8kf9TZPye4@vostro.rjw.lan>
References: <53A2340D.9030503@linux.intel.com> <4679574.kGUnqAuNl9@vostro.rjw.lan> <2067046.JFGH9LUctP@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <2067046.JFGH9LUctP@ws-stein>
Sender: linux-pm-owner@vger.kernel.org
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, "Li, Aubrey" <aubrey.li@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Tuesday, July 15, 2014 02:22:25 PM Alexander Stein wrote:
> On Thursday 10 July 2014 23:37:54, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > If an IRQ has been configured for wakeup via enable_irq_wake(), the
> > driver who has done that must be prepared for receiving interrupts
> > after suspend_device_irqs() has returned, so there is no need to
> > "suspend" such IRQs.  Moreover, if drivers using enable_irq_wake()
> > actually want to receive interrupts after suspend_device_irqs() has
> > returned, they need to add IRQF_NO_SUSPEND to the IRQ flags while
> > requesting the IRQs, which shouldn't be necessary (it also goes a bit
> > too far, as IRQF_NO_SUSPEND causes the IRQ to be ignored by
> > suspend_device_irqs() all the time regardless of whether or not it
> > has been configured for signaling wakeup).
> > 
> > For the above reasons, make __disable_irq() ignore IRQ descriptors
> > with IRQD_WAKEUP_STATE set when its suspend argument is true which
> > effectively causes them to behave like IRQs with IRQF_NO_SUSPEND
> > set.
> > 
> > This also allows IRQs configured for wakeup via enable_irq_wake()
> > to work as wakeup interrupts for the "freeze" (suspend-to-idle)
> > sleep mode automatically just like for any other sleep states.
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  kernel/irq/manage.c |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > Index: linux-pm/kernel/irq/manage.c
> > ===================================================================
> > --- linux-pm.orig/kernel/irq/manage.c
> > +++ linux-pm/kernel/irq/manage.c
> > @@ -385,7 +385,8 @@ setup_affinity(unsigned int irq, struct
> >  void __disable_irq(struct irq_desc *desc, unsigned int irq, bool suspend)
> >  {
> >  	if (suspend) {
> > -		if (!desc->action || (desc->action->flags & IRQF_NO_SUSPEND))
> > +		if (!desc->action || (desc->action->flags & IRQF_NO_SUSPEND)
> > +		    || irqd_has_set(&desc->irq_data, IRQD_WAKEUP_STATE))
> >  			return;
> >  		desc->istate |= IRQS_SUSPENDED;
> >  	}
> 
> Nice, this fixes my wakeup problem from freeze using gpio-keys. Unfortunately my SPI-attached touchscreen controller cannot be used for wakeup from freeze. Using it to wakeup from mem does work instead. Any ideas what might be wrong in this case?

Not without looking at the code in question.

One guess would be a missing call to enable_irq_wake().

Rafael

