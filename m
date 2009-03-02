From: Ingo Molnar <mingo@elte.hu>
Subject: Re: lockdep and threaded IRQs (was: ...)
Date: Tue, 3 Mar 2009 00:58:17 +0100
Message-ID: <20090302235817.GC19084@elte.hu>
References: <1235762883-20870-1-git-send-email-me@felipebalbi.com> <200903021520.30826.david-b@pacbell.net> <20090302232650.GA14515@elte.hu> <200903021548.19504.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:45526 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751580AbZCBX6h (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 2 Mar 2009 18:58:37 -0500
Content-Disposition: inline
In-Reply-To: <200903021548.19504.david-b@pacbell.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrew Morton <akpm@linux-foundation.org>, me@felipebalbi.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, felipe.balbi@nokia.com, dmitry.torokhov@gmail.com, sameo@openedhand.com, tglx@linutronix.de


* David Brownell <david-b@pacbell.net> wrote:

> On Monday 02 March 2009, Ingo Molnar wrote:
> >=20
> > > > > What's unfortunate is that you prefer not to fix that
> > > > > IRQF_DISABLED bug in lockdep, which you co-"maintain".
> > > > > When running with lockdep, that bug (a) introduces bugs
> > > > > in some drivers and (b) hides bugs in others. =A0You've
> > > > > rejected even a minimal warning fix, to help minimize
> > > > > the amount of time developers waste on (a) and (b).
> > > >=20
> > > > I've come to the conclusion that the only technically sound sol=
ution is
> > > > to do as I proposed today, utterly eliminate !IRQF_DISABLED han=
dlers.
> > >=20
> > > As you announced today. =A0If you truly believe that, then
> > > you should at least submit a warning patch for 2.6.29-rc
> > > ("driver X isn't setting IRQF_DISABLED, reimplement!")
> >=20
> > i have changed the BUG_ON() to a WARN_ONCE() message so the=20
> > warning is in place now.
>=20
> The patch Peter sent doesn't relate in the least to removing=20
> the IRQF_DISABLED flag though.  Patches addressing that would=20
> be in setup_irq() code paths not IRQ dispatch.

yes, i referred to the BUG_ON(!irq_irq()) patch.

	Ingo
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
