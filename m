From: David Jander <david.jander@protonic.nl>
Subject: Re: [PATCH v4 3/3] Input: gpio_keys.c: Enable use with non-local
 GPIO chips.
Date: Fri, 16 Mar 2012 12:08:03 +0100
Message-ID: <20120316120803.13b2fcc2@archvile>
References: <1308042491-20203-1-git-send-email-david@protonic.nl>
	<1308042491-20203-4-git-send-email-david@protonic.nl>
	<20120316072004.GB16291@core.coreip.homeip.net>
	<20120316101815.GE32060@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([213.84.116.84]:11114 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750950Ab2CPLH4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Mar 2012 07:07:56 -0400
In-Reply-To: <20120316101815.GE32060@trinity.fluff.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ben Dooks <ben@trinity.fluff.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Jander <david@protonic.nl>, Grant Likely <grant.likely@secretlab.ca>, linux-input@vger.kernel.org, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>

On Fri, 16 Mar 2012 10:18:15 +0000
Ben Dooks <ben@trinity.fluff.org> wrote:

> On Fri, Mar 16, 2012 at 12:20:04AM -0700, Dmitry Torokhov wrote:
> > Hi David,
> >=20
> > On Tue, Jun 14, 2011 at 11:08:11AM +0200, David Jander wrote:
> > > Use a threaded interrupt handler in order to permit the handler t=
o use
> > > a GPIO driver that causes things like I2C transactions being done=
 inside
> > > the handler context.
> > > Also, gpio_keys_init needs to be declared as a late_initcall, to =
make sure
> > > all needed GPIO drivers have been loaded if the drivers are built=
 into the
> > > kernel.
> >=20
> > Don't want to resurrect the whole initcall discussion, but could yo=
u
> > tell me again why the interrup handler needs to be threaded? We do =
not
> > access hardware from it, hardware is accessed from workqueue contex=
t.
> > Here is the ISR in its entirety:
> >=20
> > static irqreturn_t gpio_keys_isr(int irq, void *dev_id)
> > {
> >         struct gpio_button_data *bdata =3D dev_id;
> >         const struct gpio_keys_button *button =3D bdata->button;
> >=20
> >         BUG_ON(irq !=3D gpio_to_irq(button->gpio));
>=20
> Why on earth do we need this? this looks like something that is not
> necessary and in my view a waste of cpu cycles.

No idea... catch some weird (hardware-/setup-)bug? Not _that_ many CPU =
cycles
anyway, plus I am not the author of that line.... maybe ask Uwe Kleine-=
K=C3=B6nig
(CC'd)?

> >         if (bdata->timer_debounce)
> >                 mod_timer(&bdata->timer,
> >                         jiffies + msecs_to_jiffies(bdata->timer_deb=
ounce));
> >         else
> >                 schedule_work(&bdata->work);
> >=20
> >         return IRQ_HANDLED;
> > }
> >=20
> > It looks to me that non-threaded handler would work as well? Or
> > gpio_to_irq() can sleep with certain chips?
>=20
> See above comment, I'd go with just remove it and unthread.

Not unthread, but use request_any_context_irq(), please!

Best regards,

--=20
David Jander
Protonic Holland.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
