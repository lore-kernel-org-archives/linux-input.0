From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] gpio_keys, twl4030-pwrbutton: stay awake for 1sec on
 resume
Date: Sat, 28 Jun 2014 17:58:39 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1406281755450.6272-100000@netrider.rowland.org>
References: <20140628200410.GA7561@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:51285 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751432AbaF1V6k (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Jun 2014 17:58:40 -0400
In-Reply-To: <20140628200410.GA7561@amd.pavel.ucw.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, Lukas M?rdian <lukas@goldelico.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Marek Belisko <marek@goldelico.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Sat, 28 Jun 2014, Pavel Machek wrote:

> Hi!
>=20
> > >> This gives the userspace (Replicant) a chance to fully handle th=
e
> > >> pm_wakeup_event, before autosleep suspends the system alltogethe=
r
> > >> again.
> > >>=20
> > >> This fixes suspend/resume on the OpenPhoenux GTA04, in combinati=
on with
> > >> the Replicant 4.2.2 userspace, which needs to execute this to st=
ay
> > >> awake: 'echo on > /sys/power/state'
> > >>=20
> > >> Signed-off-by: Lukas M=E4rdian <lukas@goldelico.com>
> > >> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> > >=20
> > > I'm sorry, but we should not be doing this.
> > >=20
> > > You basically put a delay in driver to work around userspace bug.
> >=20
> > Do you think it is a user-space bug if the kernel goes to sleep aga=
in
> > before giving user space any chance to react to an event?
>=20
> Well, who says 1000msec is enough? Some userspace may need
> more. ... for example on PC when you keyboard-handling deamon is
> swapped out.
>=20
> > And the msec parameter is described as:
> >=20
> > @msec: Anticipated event processing time (in milliseconds).
> >=20
> > Isn't calling pm_wakeup_event() with a non-zero msec the standard
> > method to handle this situation? And it is used in other drivers. E=
=2Eg. in
> > _mmc_detect_change() or hub_suspend().
>=20
>  * Notify the PM core of a wakeup event whose source is @ws that will
>    take                   =20
>  * approximately @msec milliseconds to be processed by the kernel.  I=
f
>    @ws is                =20
>  * not active, activate it.  If @msec is nonzero, set up the @ws'
>    timer to                   =20
>  * execute pm_wakeup_timer_fn() in future.                           =
                        =20
>=20
> Will take @msec milliseconds to be processed by the _kernel_. Yes, US=
B
> probing takes a lot of time in kernel. But you are using this
> parameter to wait for userspace...
>=20
> > > There must be better
> > > solution....
> > =20
> > I am not sure how it could look like.
>=20
> Rafael, do you have any idea how this is supposed to work?
>=20
> Original patch is at https://lkml.org/lkml/2014/4/10/156 .

One possibility is not to use autosleep at all.  The user program,
instead of writing "on" to /sys/power/state to stay awake, would have
to write "mem" to go to sleep when no more work remained to be handled.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
