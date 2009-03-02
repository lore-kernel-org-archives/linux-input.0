From: David Brownell <david-b@pacbell.net>
Subject: Re: lockdep and threaded IRQs (was: ...)
Date: Mon, 2 Mar 2009 15:48:18 -0800
Message-ID: <200903021548.19504.david-b@pacbell.net>
References: <1235762883-20870-1-git-send-email-me@felipebalbi.com> <200903021520.30826.david-b@pacbell.net> <20090302232650.GA14515@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp122.sbc.mail.sp1.yahoo.com ([69.147.64.95]:47019 "HELO
	smtp122.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754448AbZCBXsX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 2 Mar 2009 18:48:23 -0500
In-Reply-To: <20090302232650.GA14515@elte.hu>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrew Morton <akpm@linux-foundation.org>, me@felipebalbi.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, felipe.balbi@nokia.com, dmitry.torokhov@gmail.com, sameo@openedhand.com, tglx@linutronix.de

On Monday 02 March 2009, Ingo Molnar wrote:
>=20
> > > > What's unfortunate is that you prefer not to fix that
> > > > IRQF_DISABLED bug in lockdep, which you co-"maintain".
> > > > When running with lockdep, that bug (a) introduces bugs
> > > > in some drivers and (b) hides bugs in others. =A0You've
> > > > rejected even a minimal warning fix, to help minimize
> > > > the amount of time developers waste on (a) and (b).
> > >=20
> > > I've come to the conclusion that the only technically sound solut=
ion is
> > > to do as I proposed today, utterly eliminate !IRQF_DISABLED handl=
ers.
> >=20
> > As you announced today. =A0If you truly believe that, then
> > you should at least submit a warning patch for 2.6.29-rc
> > ("driver X isn't setting IRQF_DISABLED, reimplement!")
>=20
> i have changed the BUG_ON() to a WARN_ONCE() message so the=20
> warning is in place now.

The patch Peter sent doesn't relate in the least to removing
the IRQF_DISABLED flag though.  Patches addressing that
would be in setup_irq() code paths not IRQ dispatch.


> > with a Documentation/feature-removal-schedule.txt plan for=20
> > removing that mechanism. [...]
>=20
> you are misunderstanding the workings and purpose of=20
> feature-removal-schedule.txt. It is mainly used for=20
> functionality that is user-visible.

If by "user" you include "kernel developers", yes;
otherwise, I'd dispute "mainly".  The first several
entries right now relate to kernel interfaces, as
do quite a lot of the others.


> It is sometimes used for =20
> functionality that a subsystem has exported to a lot of drivers=20
> consciously and which is being removed.

The IRQ framework has very consciously exported IRQF_DISABLED.
That functionality has been around for a very long time; I'm
thinking at least ten years now.

So removing IRQF_DISABLED -- if it's even agreed to be
a good idea, which seems to be a minority opinion so far
on this thread -- is very much the sort of thing one would
expect to appear in that schedule.

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
