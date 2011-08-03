From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4 1/2] Input: enable i8042-level wakeup control
Date: Wed, 3 Aug 2011 11:43:32 -0700
Message-ID: <20110803184332.GA17880@core.coreip.homeip.net>
References: <20110802154916.624619D401C@zog.reactivated.net>
 <20110803065920.GC23399@core.coreip.homeip.net>
 <CAMLZHHTTXvThE5bWfyjJu-UFJbaKAhzORKWV8ay4RZW-ZVifLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:41092 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754230Ab1HCSnk (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Aug 2011 14:43:40 -0400
Received: by yia27 with SMTP id 27so649034yia.19
        for <linux-input@vger.kernel.org>; Wed, 03 Aug 2011 11:43:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMLZHHTTXvThE5bWfyjJu-UFJbaKAhzORKWV8ay4RZW-ZVifLg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-input@vger.kernel.org, linux-pm@lists.linux-foundation.org, rjw@sisk.pl, dilinger@queued.net, pgf@laptop.org

On Wed, Aug 03, 2011 at 09:04:56AM +0100, Daniel Drake wrote:
> On Wed, Aug 3, 2011 at 7:59 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > I am not sure that we should be marking input devices themselves as
> > wakeup capable - they are in no way physical devices. I'd stop at s=
erio
> > level...
>=20
> We need a way to make sure the device state is untouched during
> suspend/resume. Would you be happier if an input device looked at the
> device_may_wakeup() of its parent?

I think we should leave input core out of it completely, see below...

>=20
> >>
> >> diff --git a/drivers/input/input.c b/drivers/input/input.c
> >> index da38d97..639aba7 100644
> >> --- a/drivers/input/input.c
> >> +++ b/drivers/input/input.c
> >> @@ -1588,6 +1588,9 @@ static int input_dev_suspend(struct device *=
dev)
> >> =A0{
> >> =A0 =A0 =A0 struct input_dev *input_dev =3D to_input_dev(dev);
> >>
> >> + =A0 =A0 if (device_may_wakeup(dev))
> >> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> >> +
> >
> > On suspend should we not try to shut off leds and sound?
>=20
> Thats right. The setup is that the system appears to be running as
> normal, our display also remains on during suspend (and wifi, and so
> on). Bar the laptop's power LED which goes from always-on to flashing=
,
> the user is unaware that the laptop has suspended.

No, I do not believe we can do what you are doing in input core. You ar=
e
changing behavior for one platform and one (or 2 drivers) that will not
be matched (at least I don't think so) by anything else out there. What
will happen if you plug a random USB keyboard into OLPC box? Will it ke=
ep
leds powered?

>=20
> >> =A0 =A0 =A0 mutex_lock(&input_dev->mutex);
> >>
> >> =A0 =A0 =A0 if (input_dev->users)
> >> @@ -1602,7 +1605,8 @@ static int input_dev_resume(struct device *d=
ev)
> >> =A0{
> >> =A0 =A0 =A0 struct input_dev *input_dev =3D to_input_dev(dev);
> >>
> >> - =A0 =A0 input_reset_device(input_dev);
> >> + =A0 =A0 if (!device_may_wakeup(dev))
> >> + =A0 =A0 =A0 =A0 =A0 =A0 input_reset_device(input_dev);
> >>
> >
> > Does the controller wakes up the system on key release or only pres=
s? My
> > concern is with cases when we suspend with a key pressed and wake u=
p
> > with it already released.
>=20
> It wakes up on key press, but our EC buffers communication, so both
> the key press and key release event would be delivered in the above
> scenario.

Just to confirm, we 3 events will be delivered in this case:

1 - old key release
2 - wakeup key press
3 - wakeup key release

?

I also wonder what will happen with non-PS2 devices...

Instead of wiring it all through input core could we contain this in
atkbd and hgpk by registering pm_notifiers and ignoring certain request=
s
from input/serio cores during system state transition on OLPC only?

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
