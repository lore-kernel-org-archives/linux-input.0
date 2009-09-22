From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: make gpio-keys use IRQF_SHARED
Date: Tue, 22 Sep 2009 09:42:06 -0700
Message-ID: <20090922164206.GB22639@core.coreip.homeip.net>
References: <1253113398-22751-1-git-send-email-dbaryshkov@gmail.com> <20090916162853.GA4970@core.coreip.homeip.net> <bc64b4640909161141j3dfae8c8ncc02d0fe8c95ee07@mail.gmail.com> <bc64b4640909180444v46f49175ob215ffc43e3d109@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f187.google.com ([209.85.222.187]:46739 "EHLO
	mail-pz0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480AbZIVQmH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Sep 2009 12:42:07 -0400
Received: by mail-pz0-f187.google.com with SMTP id 17so265823pzk.1
        for <linux-input@vger.kernel.org>; Tue, 22 Sep 2009 09:42:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <bc64b4640909180444v46f49175ob215ffc43e3d109@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: linux-input@vger.kernel.org

On Fri, Sep 18, 2009 at 03:44:41PM +0400, Dmitry Eremin-Solenikov wrote=
:
> On Wed, Sep 16, 2009 at 10:41 PM, Dmitry Eremin-Solenikov
> <dbaryshkov@gmail.com> wrote:
> > On Wed, Sep 16, 2009 at 8:28 PM, Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> >> On Wed, Sep 16, 2009 at 07:03:18PM +0400, Dmitry Eremin-Solenikov =
wrote:
> >>> There is nothing that disallows gpio-keys to share it's IRQ line
> >>> w/ other drivers. Make it use IRQF_SHARED in request_irq().
> >>>
> >>> An example of other driver with which I'd like to share IRQ line
> >>> for GPIO buttons is ledtrig-gpio.
> >>>
> >>> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> >>> ---
> >>> =A0drivers/input/keyboard/gpio_keys.c | =A0 =A01 +
> >>> =A01 files changed, 1 insertions(+), 0 deletions(-)
> >>>
> >>> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/k=
eyboard/gpio_keys.c
> >>> index efed0c9..9fc2fab 100644
> >>> --- a/drivers/input/keyboard/gpio_keys.c
> >>> +++ b/drivers/input/keyboard/gpio_keys.c
> >>> @@ -147,6 +147,7 @@ static int __devinit gpio_keys_probe(struct p=
latform_device *pdev)
> >>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >>>
> >>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D request_irq(irq, gpio_keys_=
isr,
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 IRQF_SHARED |
> >>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> >>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 button->desc ? button->desc : "gpio_keys",
> >>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 bdata);
> >>
> >> How will you determine which device generated the interrupt? Becau=
se you
> >> can't return IRQ_HANDLED unconditionally and expect both devices w=
ork
> >> reliably.
> >
> > It's a single device (gpio pin). However I'd like to be able to att=
ach
> > several handlers to it.
> > E.g. one isr is gpio-keys (for reporting event to userspace), anoth=
er
> > isr will be from
> > ledtrig-gpio (controlling the LED). Another can be some kind of
> > battery driver, etc.
> >
> > All these drivers will provide different kinds of response for sing=
le GPIO pin.
>=20
> So, what about this patch?
>=20

OK, will apply.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
