From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: serio - clear serio event queue after sysfs
 driver rebind
Date: Tue, 7 Dec 2010 21:12:11 -0800
Message-ID: <20101208051211.GB4140@core.coreip.homeip.net>
References: <1290467390-25302-1-git-send-email-dlaurie@chromium.org>
 <20101127084153.GC28745@core.coreip.homeip.net>
 <AANLkTik1TE9zgKaiLQZ=1uFgMyZt43xp8VJBWfxdVyMY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTik1TE9zgKaiLQZ=1uFgMyZt43xp8VJBWfxdVyMY@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Duncan Laurie <dlaurie@chromium.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Nov 29, 2010 at 01:37:35PM -0800, Duncan Laurie wrote:
> On Sat, Nov 27, 2010 at 12:41 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > Hi Duncan,
> >
> > On Mon, Nov 22, 2010 at 03:09:50PM -0800, Duncan Laurie wrote:
> >> When rebinding a serio driver via sysfs drvctl interface it is pos=
sible for
> >> an interrupt to trigger after the disconnect of the existing drive=
r and
> >> before the binding of the new driver. =A0This will cause the serio=
 interrupt
> >> handler to queue a rescan event which will disconnect the new driv=
er
> >> immediately after it is attached.
> >>
> >> This change clears the serio event queue after processing the drvc=
tl
> >> request but before releasing the serio mutex, which will clear any=
 queued
> >> rescans before they can get processed.
> >>
> >> Reproduction involves issuing a rebind of device port from psmouse=
 driver
> >> to serio_raw driver while generating input to trigger interrupts. =
=A0Then
> >> checking to see if the corresponding i8042/serio4/driver is correc=
tly
> >> attached to the serio_raw driver instead of psmouse.
> >>
> >> Signed-off-by: Duncan Laurie <dlaurie@chromium.org>
> >> ---
> >> =A0drivers/input/serio/serio.c | =A0 =A01 +
> >> =A01 files changed, 1 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/ser=
io.c
> >> index 405bf21..a66307e 100644
> >> --- a/drivers/input/serio/serio.c
> >> +++ b/drivers/input/serio/serio.c
> >> @@ -454,6 +454,7 @@ static ssize_t serio_rebind_driver(struct devi=
ce *dev, struct device_attribute *
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 serio_disconnect_port(serio);
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D serio_bind_driver(serio, to_=
serio_driver(drv));
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 put_driver(drv);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 serio_remove_pending_events(serio);
> >
> > Hmm, makes sense, although should we limit events being removed to
> > rescan events only?
> >
>=20
>=20
> That seems reasonable.  It would mean adding a new function or a
> parameter to the existing serio_remove_pending_events function, do yo=
u
> have a preference?
>=20

I wonder if a boolean parameter (rescan_only) would not be the best
option.

Thanks.

--=20
Dmitry
