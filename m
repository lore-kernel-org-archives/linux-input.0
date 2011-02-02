From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: serio - clear serio event queue after sysfs
 driver rebind
Date: Wed, 2 Feb 2011 14:58:42 -0800
Message-ID: <20110202225842.GA25306@core.coreip.homeip.net>
References: <1290467390-25302-1-git-send-email-dlaurie@chromium.org>
 <20101127084153.GC28745@core.coreip.homeip.net>
 <AANLkTik1TE9zgKaiLQZ=1uFgMyZt43xp8VJBWfxdVyMY@mail.gmail.com>
 <20101208051211.GB4140@core.coreip.homeip.net>
 <20110201092126.GC17706@core.coreip.homeip.net>
 <AANLkTiknhubSN37ChYebWxd9Wx=R4dN38ETdZv2BZYee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47231 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755268Ab1BBW6v (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Feb 2011 17:58:51 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTiknhubSN37ChYebWxd9Wx=R4dN38ETdZv2BZYee@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Duncan Laurie <dlaurie@chromium.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Feb 02, 2011 at 02:41:38PM -0800, Duncan Laurie wrote:
> On Tue, Feb 1, 2011 at 1:21 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Tue, Dec 07, 2010 at 09:12:11PM -0800, Dmitry Torokhov wrote:
> >> On Mon, Nov 29, 2010 at 01:37:35PM -0800, Duncan Laurie wrote:
> >> > On Sat, Nov 27, 2010 at 12:41 AM, Dmitry Torokhov
> >> > <dmitry.torokhov@gmail.com> wrote:
> >> > > Hi Duncan,
> >> > >
> >> > > On Mon, Nov 22, 2010 at 03:09:50PM -0800, Duncan Laurie wrote:
> >> > >> When rebinding a serio driver via sysfs drvctl interface it i=
s possible for
> >> > >> an interrupt to trigger after the disconnect of the existing =
driver and
> >> > >> before the binding of the new driver. =A0This will cause the =
serio interrupt
> >> > >> handler to queue a rescan event which will disconnect the new=
 driver
> >> > >> immediately after it is attached.
> >> > >>
> >> > >> This change clears the serio event queue after processing the=
 drvctl
> >> > >> request but before releasing the serio mutex, which will clea=
r any queued
> >> > >> rescans before they can get processed.
> >> > >>
> >> > >> Reproduction involves issuing a rebind of device port from ps=
mouse driver
> >> > >> to serio_raw driver while generating input to trigger interru=
pts. =A0Then
> >> > >> checking to see if the corresponding i8042/serio4/driver is c=
orrectly
> >> > >> attached to the serio_raw driver instead of psmouse.
> >> > >>
> >> > >> Signed-off-by: Duncan Laurie <dlaurie@chromium.org>
> >> > >> ---
> >> > >> =A0drivers/input/serio/serio.c | =A0 =A01 +
> >> > >> =A01 files changed, 1 insertions(+), 0 deletions(-)
> >> > >>
> >> > >> diff --git a/drivers/input/serio/serio.c b/drivers/input/seri=
o/serio.c
> >> > >> index 405bf21..a66307e 100644
> >> > >> --- a/drivers/input/serio/serio.c
> >> > >> +++ b/drivers/input/serio/serio.c
> >> > >> @@ -454,6 +454,7 @@ static ssize_t serio_rebind_driver(struct=
 device *dev, struct device_attribute *
> >> > >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 serio_disconnect_port(serio);
> >> > >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D serio_bind_driver(serio=
, to_serio_driver(drv));
> >> > >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 put_driver(drv);
> >> > >> + =A0 =A0 =A0 =A0 =A0 =A0 serio_remove_pending_events(serio);
> >> > >
> >> > > Hmm, makes sense, although should we limit events being remove=
d to
> >> > > rescan events only?
> >> > >
> >> >
> >> >
> >> > That seems reasonable. =A0It would mean adding a new function or=
 a
> >> > parameter to the existing serio_remove_pending_events function, =
do you
> >> > have a preference?
> >> >
> >>
> >> I wonder if a boolean parameter (rescan_only) would not be the bes=
t
> >> option.
> >>
> >
> > Hi Duncan,
> >
> > I eneded up with the following patch, could you please try and see =
if
> > it still works for you?
> >
>=20
>=20
> Hi Dmitry,
>=20
> I tested the patch on a CR-48 device (which is where I was seeing the
> problem because we switch to serio_raw at boot for the trackpad) and
> it does fix the problem.
>=20
> Thanks for sending this, it had slipped off my todo list.
>=20

Great, thank you for testing.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
