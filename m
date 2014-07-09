From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] GPIO button wth wakeup attribute is supposed to wake the system up
Date: Wed, 09 Jul 2014 14:45:15 +0200
Message-ID: <4301161.i6ArOLmcsg@vostro.rjw.lan>
References: <53A2340D.9030503@linux.intel.com> <18261725.84uqcyZ8CE@vostro.rjw.lan> <20140709005434.GB14935@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140709005434.GB14935@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Tuesday, July 08, 2014 05:54:35 PM Dmitry Torokhov wrote:
> On Wed, Jul 09, 2014 at 02:59:33AM +0200, Rafael J. Wysocki wrote:
> > On Tuesday, July 08, 2014 05:15:06 PM Dmitry Torokhov wrote:
> > > On Wed, Jul 09, 2014 at 01:06:07AM +0200, Rafael J. Wysocki wrote:

[cut]

> > > 
> > > When device driver marks IRQ as a wakeup source I believe it is prepared
> > > to handle it (or it would shut it off explicitly).
> > 
> > I can agree with that.
> > 
> > Are you suggesting that __disable_irq() should check irq_data for
> > IRQD_WAKEUP_STATE and skip the IRQ (in the 'suspend' case) if that is set?
> 
> Yes, something like that.

OK

Aubrey, can you please check if the appended patch helps on the T100?

Rafael

---
 kernel/irq/manage.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-pm/kernel/irq/manage.c
===================================================================
--- linux-pm.orig/kernel/irq/manage.c
+++ linux-pm/kernel/irq/manage.c
@@ -385,7 +385,8 @@ setup_affinity(unsigned int irq, struct
 void __disable_irq(struct irq_desc *desc, unsigned int irq, bool suspend)
 {
 	if (suspend) {
-		if (!desc->action || (desc->action->flags & IRQF_NO_SUSPEND))
+		if (!desc->action || (desc->action->flags & IRQF_NO_SUSPEND)
+		    || irqd_has_set(&desc->irq_data, IRQD_WAKEUP_STATE))
 			return;
 		desc->istate |= IRQS_SUSPENDED;
 	}
