From: David Brownell <david-b@pacbell.net>
Subject: Re: lockdep and threaded IRQs (was: ...)
Date: Sat, 28 Feb 2009 12:02:36 -0800
Message-ID: <200902281202.36804.david-b@pacbell.net>
References: <1235762883-20870-1-git-send-email-me@felipebalbi.com> <200902280416.26687.david-b@pacbell.net> <alpine.LFD.2.00.0902281741560.29264@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:28730 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752090AbZB1UCk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Feb 2009 15:02:40 -0500
In-Reply-To: <alpine.LFD.2.00.0902281741560.29264@localhost.localdomain>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, me@felipebalbi.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, felipe.balbi@nokia.com, dmitry.torokhov@gmail.com, sameo@openedhand.com, a.p.zijlstra@chello.nl

On Saturday 28 February 2009, Thomas Gleixner wrote:
> > > >=20
> > > > Where you'll observe twl_init_irq() at line 688 setting
> > > > up the thread and the Primary IRQ Handler (PIH) dispatch.
> > > > That's pretty much bog-standard chained IRQ setup code,
> > > > except that it chains through a thread.
> > >=20
> > > So this would be the perfect candidate to test the generic thread=
ed
> > > code I posted a few days ago ?
> >=20
> > Could be. =A0URL?
>=20
> http://lkml.org/lkml/2009/2/26/146

Quick report:

 - patch 2/4 didn't apply, mainline uses GFP_ATOMIC in that
   memory allocation not GFP_KERNEL; obvious fix.

 - patch 4/4 also didn't apply, 5/15 hunks failed ... looks
   like IRQ affinity stuff.  free_irq() changes need rework,
   the others look to have obvious fixes.

Got a version that applies to mainline GIT?


At a quick glance it looks like these patches don't cover
set_irq_chained_handler(), which would be trouble since
__setup_irq() doesn't get called in those cases.

They should however handle simpler cases, like I2C devices
that only expose one IRQ instead of needing to demux several
dozen IRQs going to different drivers and subsystems.

And, not touching lockdep, the original ugliness will still
be needed (re-enabling IRQs in threaded handlers).

- Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
