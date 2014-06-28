From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] gpio_keys, twl4030-pwrbutton: stay awake for 1sec on
 resume
Date: Sat, 28 Jun 2014 22:04:10 +0200
Message-ID: <20140628200410.GA7561@amd.pavel.ucw.cz>
References: <1403906118-23517-1-git-send-email-lukas@goldelico.com>
 <20140628170820.GF23634@xo-6d-61-c0.localdomain>
 <BD5D0538-BD03-4CD8-8E12-2344AD7ED669@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <BD5D0538-BD03-4CD8-8E12-2344AD7ED669@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Lukas M?rdian <lukas@goldelico.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Marek Belisko <marek@goldelico.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, stern@rowland.harvard.edu
List-Id: linux-input@vger.kernel.org

Hi!

> >> This gives the userspace (Replicant) a chance to fully handle the
> >> pm_wakeup_event, before autosleep suspends the system alltogether
> >> again.
> >>=20
> >> This fixes suspend/resume on the OpenPhoenux GTA04, in combination=
 with
> >> the Replicant 4.2.2 userspace, which needs to execute this to stay
> >> awake: 'echo on > /sys/power/state'
> >>=20
> >> Signed-off-by: Lukas M=E4rdian <lukas@goldelico.com>
> >> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> >=20
> > I'm sorry, but we should not be doing this.
> >=20
> > You basically put a delay in driver to work around userspace bug.
>=20
> Do you think it is a user-space bug if the kernel goes to sleep again
> before giving user space any chance to react to an event?

Well, who says 1000msec is enough? Some userspace may need
more. ... for example on PC when you keyboard-handling deamon is
swapped out.

> And the msec parameter is described as:
>=20
> @msec: Anticipated event processing time (in milliseconds).
>=20
> Isn't calling pm_wakeup_event() with a non-zero msec the standard
> method to handle this situation? And it is used in other drivers. E.g=
=2E in
> _mmc_detect_change() or hub_suspend().

 * Notify the PM core of a wakeup event whose source is @ws that will
   take                   =20
 * approximately @msec milliseconds to be processed by the kernel.  If
   @ws is                =20
 * not active, activate it.  If @msec is nonzero, set up the @ws'
   timer to                   =20
 * execute pm_wakeup_timer_fn() in future.                             =
                      =20

Will take @msec milliseconds to be processed by the _kernel_. Yes, USB
probing takes a lot of time in kernel. But you are using this
parameter to wait for userspace...

> > There must be better
> > solution....
> =20
> I am not sure how it could look like.

Rafael, do you have any idea how this is supposed to work?

Original patch is at https://lkml.org/lkml/2014/4/10/156 .
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
