From: David Brownell <david-b@pacbell.net>
Subject: Re: lockdep and threaded IRQs (was: ...)
Date: Fri, 27 Feb 2009 15:18:57 -0800
Message-ID: <200902271518.58246.david-b@pacbell.net>
References: <1235762883-20870-1-git-send-email-me@felipebalbi.com> <200902271350.32380.david-b@pacbell.net> <20090227140907.f159be9b.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from n18.bullet.mail.mud.yahoo.com ([68.142.206.145]:20095 "HELO
	n18.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753744AbZB0XTD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Feb 2009 18:19:03 -0500
In-Reply-To: <20090227140907.f159be9b.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: me@felipebalbi.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, felipe.balbi@nokia.com, dmitry.torokhov@gmail.com, sameo@openedhand.com, a.p.zijlstra@chello.nl, tglx@linutronix.de

On Friday 27 February 2009, Andrew Morton wrote:
>=20
> > There are actually two issues. =A0The lockdep issue is
> > one ... the above #ifdef suffices to work around it
> > for all the TWL4030 (family) IRQs.

(And other similar cases, of course, including those
MMC cases that crap out in the ARM memory management
code when lockdep wrongly disables IRQs.)


> > The other is that Linux needs real support for threaded
> > interrupts. =A0Almost every I2C (or SPI) device that raises
> > an IRQ needs its IRQ handler to run in a thread, and most
> > of them have the same type of workqueue-based hack to
> > get such a thread. =A0(Some others have bugs instead...)
> >=20
> > Obviously, if any threaded IRQ handler grabs a mutex,
> > but lockdep has disabled IRQs, trouble ensues...
>=20
> What's going on here? =A0hardirq handlers cannot take mutexes and can=
not
> sleep, period. =A0

But these handlers are *NOT* running in hardirq context;
so such thought doesn't apply.  The hardirq bit of the
IRQ-handling activity completed quite a bit earlier.

Being able to sleep and grab mutexes is one of the main
reasons for wanting threaded IRQ handlers.  For common
(embedded) I2C hardware, if threaded IRQ handlers can't
sleep they're completely useless.

And something that may eventually matter for mainline:
in RT contexts, thread priority applies to mutex grabbing,
and helps manage priority inversion.  That's equivalent
to sleeping.

This stuff just pokes at some annoying current gaps in the
IRQ framework.  I'll be glad when eventually there's no
need to work around those weaknesses ... that is, when
real threaded IRQ support is available.


> Enabling local interrupts might shut up some warning,=20
> but won't fix the deadlocks which that warning is there to warn us
> about.

Wrong; all such warnings are false, in these cases.

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
