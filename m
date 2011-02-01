From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: serio - clear serio event queue after sysfs
 driver rebind
Date: Tue, 1 Feb 2011 01:21:26 -0800
Message-ID: <20110201092126.GC17706@core.coreip.homeip.net>
References: <1290467390-25302-1-git-send-email-dlaurie@chromium.org>
 <20101127084153.GC28745@core.coreip.homeip.net>
 <AANLkTik1TE9zgKaiLQZ=1uFgMyZt43xp8VJBWfxdVyMY@mail.gmail.com>
 <20101208051211.GB4140@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20101208051211.GB4140@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Duncan Laurie <dlaurie@chromium.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Dec 07, 2010 at 09:12:11PM -0800, Dmitry Torokhov wrote:
> On Mon, Nov 29, 2010 at 01:37:35PM -0800, Duncan Laurie wrote:
> > On Sat, Nov 27, 2010 at 12:41 AM, Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> > > Hi Duncan,
> > >
> > > On Mon, Nov 22, 2010 at 03:09:50PM -0800, Duncan Laurie wrote:
> > >> When rebinding a serio driver via sysfs drvctl interface it is p=
ossible for
> > >> an interrupt to trigger after the disconnect of the existing dri=
ver and
> > >> before the binding of the new driver. =A0This will cause the ser=
io interrupt
> > >> handler to queue a rescan event which will disconnect the new dr=
iver
> > >> immediately after it is attached.
> > >>
> > >> This change clears the serio event queue after processing the dr=
vctl
> > >> request but before releasing the serio mutex, which will clear a=
ny queued
> > >> rescans before they can get processed.
> > >>
> > >> Reproduction involves issuing a rebind of device port from psmou=
se driver
> > >> to serio_raw driver while generating input to trigger interrupts=
=2E =A0Then
> > >> checking to see if the corresponding i8042/serio4/driver is corr=
ectly
> > >> attached to the serio_raw driver instead of psmouse.
> > >>
> > >> Signed-off-by: Duncan Laurie <dlaurie@chromium.org>
> > >> ---
> > >> =A0drivers/input/serio/serio.c | =A0 =A01 +
> > >> =A01 files changed, 1 insertions(+), 0 deletions(-)
> > >>
> > >> diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/s=
erio.c
> > >> index 405bf21..a66307e 100644
> > >> --- a/drivers/input/serio/serio.c
> > >> +++ b/drivers/input/serio/serio.c
> > >> @@ -454,6 +454,7 @@ static ssize_t serio_rebind_driver(struct de=
vice *dev, struct device_attribute *
> > >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 serio_disconnect_port(serio);
> > >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D serio_bind_driver(serio, t=
o_serio_driver(drv));
> > >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 put_driver(drv);
> > >> + =A0 =A0 =A0 =A0 =A0 =A0 serio_remove_pending_events(serio);
> > >
> > > Hmm, makes sense, although should we limit events being removed t=
o
> > > rescan events only?
> > >
> >=20
> >=20
> > That seems reasonable.  It would mean adding a new function or a
> > parameter to the existing serio_remove_pending_events function, do =
you
> > have a preference?
> >=20
>=20
> I wonder if a boolean parameter (rescan_only) would not be the best
> option.
>=20

Hi Duncan,

I eneded up with the following patch, could you please try and see if
it still works for you?=20

Thanks.

--=20
Dmitry

Input: serio - clear pending rescans after sysfs driver rebind

=46rom: Duncan Laurie <dlaurie@chromium.org>

When rebinding a serio driver via sysfs drvctl interface it is
possible for an interrupt to trigger after the disconnect of the
existing driver and before the binding of the new driver.  This will
cause the serio interrupt handler to queue a rescan event which will
disconnect the new driver immediately after it is attached.

This change removes pending rescans from the serio event queue after
processing the drvctl request but before releasing the serio mutex.

Reproduction involves issuing a rebind of device port from psmouse
driver to serio_raw driver while generating input to trigger
interrupts.  Then checking to see if the corresponding
i8042/serio4/driver is correctly attached to the serio_raw driver
instead of psmouse.

Signed-off-by: Duncan Laurie <dlaurie@chromium.org>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/serio/serio.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)


diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
index db5b0bc..7c38d1f 100644
--- a/drivers/input/serio/serio.c
+++ b/drivers/input/serio/serio.c
@@ -188,7 +188,8 @@ static void serio_free_event(struct serio_event *ev=
ent)
 	kfree(event);
 }
=20
-static void serio_remove_duplicate_events(struct serio_event *event)
+static void serio_remove_duplicate_events(void *object,
+					  enum serio_event_type type)
 {
 	struct serio_event *e, *next;
 	unsigned long flags;
@@ -196,13 +197,13 @@ static void serio_remove_duplicate_events(struct =
serio_event *event)
 	spin_lock_irqsave(&serio_event_lock, flags);
=20
 	list_for_each_entry_safe(e, next, &serio_event_list, node) {
-		if (event->object =3D=3D e->object) {
+		if (object =3D=3D e->object) {
 			/*
 			 * If this event is of different type we should not
 			 * look further - we only suppress duplicate events
 			 * that were sent back-to-back.
 			 */
-			if (event->type !=3D e->type)
+			if (type !=3D e->type)
 				break;
=20
 			list_del_init(&e->node);
@@ -245,7 +246,7 @@ static void serio_handle_event(struct work_struct *=
work)
 			break;
 		}
=20
-		serio_remove_duplicate_events(event);
+		serio_remove_duplicate_events(event->object, event->type);
 		serio_free_event(event);
 	}
=20
@@ -436,10 +437,12 @@ static ssize_t serio_rebind_driver(struct device =
*dev, struct device_attribute *
 	} else if (!strncmp(buf, "rescan", count)) {
 		serio_disconnect_port(serio);
 		serio_find_driver(serio);
+		serio_remove_duplicate_events(serio, SERIO_RESCAN_PORT);
 	} else if ((drv =3D driver_find(buf, &serio_bus)) !=3D NULL) {
 		serio_disconnect_port(serio);
 		error =3D serio_bind_driver(serio, to_serio_driver(drv));
 		put_driver(drv);
+		serio_remove_duplicate_events(serio, SERIO_RESCAN_PORT);
 	} else {
 		error =3D -EINVAL;
 	}
