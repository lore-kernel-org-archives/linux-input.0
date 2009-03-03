From: David Brownell <david-b@pacbell.net>
Subject: Re: lockdep and threaded IRQs (was: ...)
Date: Mon, 2 Mar 2009 16:33:08 -0800
Message-ID: <200903021633.08736.david-b@pacbell.net>
References: <1235762883-20870-1-git-send-email-me@felipebalbi.com> <200903021542.25153.david-b@pacbell.net> <20090302235327.GB19084@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:32617 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751598AbZCCAdM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 2 Mar 2009 19:33:12 -0500
In-Reply-To: <20090302235327.GB19084@elte.hu>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrew Morton <akpm@linux-foundation.org>, me@felipebalbi.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, felipe.balbi@nokia.com, dmitry.torokhov@gmail.com, sameo@openedhand.com, tglx@linutronix.de

On Monday 02 March 2009, Ingo Molnar wrote:
> >=20
> > The significant omission is lack of support for chaining
> > such threads. =A0Example, an I2C device that exposes
> > several dozen IRQs with mask/ack/... operations that
> > require I2C access.
>=20
> Well, those are rarely used, embedded-only constructs - the main=20
> focus of IRQ threading patches are the more common patterns.

Yes, mostly for embedded, where "system bus" more likely
means I2C than PCI.


> Since you care about them - could you please send patches on top=20
> of the IRQ threading patches to add support for them?

I'll look at that, and try to prepare something on top
of the version of the threading patches that gets into
the -next tree.  I got the impression there was going
to be a v3 of those patches soonish...

I expect there will be two basic parts of that work:

 - One to cope with the upcoming change to handle_irq(),
   insisting that it live in hardirq context instead of
   just an irqs-off context (and thereby preventing use
   of standard chaining calls in irq threads, sigh).

 - Another to set up a chaining thread, since chain
   setup bypasses setup_irq() and friends.

That latter might touch what the v2 patches added,
since I'd want it to share code.

- Dave

p.s. Note that those changes would still leave the
     lockdep bug around ... it will still be breaking
     various drivers that use normal IRQs, by forcibly
     enabling IRQF_DISABLED.

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
