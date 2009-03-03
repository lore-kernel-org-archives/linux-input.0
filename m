From: Ingo Molnar <mingo@elte.hu>
Subject: Re: lockdep and threaded IRQs (was: ...)
Date: Tue, 3 Mar 2009 01:44:27 +0100
Message-ID: <20090303004427.GA8638@elte.hu>
References: <1235762883-20870-1-git-send-email-me@felipebalbi.com> <200903021542.25153.david-b@pacbell.net> <20090302235327.GB19084@elte.hu> <200903021633.08736.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:56967 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751183AbZCCApA (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 2 Mar 2009 19:45:00 -0500
Content-Disposition: inline
In-Reply-To: <200903021633.08736.david-b@pacbell.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrew Morton <akpm@linux-foundation.org>, me@felipebalbi.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, felipe.balbi@nokia.com, dmitry.torokhov@gmail.com, sameo@openedhand.com, tglx@linutronix.de


* David Brownell <david-b@pacbell.net> wrote:

> On Monday 02 March 2009, Ingo Molnar wrote:
> > >=20
> > > The significant omission is lack of support for chaining
> > > such threads. =A0Example, an I2C device that exposes
> > > several dozen IRQs with mask/ack/... operations that
> > > require I2C access.
> >=20
> > Well, those are rarely used, embedded-only constructs - the main=20
> > focus of IRQ threading patches are the more common patterns.
>=20
> Yes, mostly for embedded, where "system bus" more likely
> means I2C than PCI.
>=20
>=20
> > Since you care about them - could you please send patches on top=20
> > of the IRQ threading patches to add support for them?
>=20
> I'll look at that, and try to prepare something on top
> of the version of the threading patches that gets into
> the -next tree.  I got the impression there was going
> to be a v3 of those patches soonish...

Great! We'll sort out any conflicts so dont worry about that -=20
you can pick up v2 just fine and post patches.

> I expect there will be two basic parts of that work:
>=20
>  - One to cope with the upcoming change to handle_irq(),
>    insisting that it live in hardirq context instead of
>    just an irqs-off context (and thereby preventing use
>    of standard chaining calls in irq threads, sigh).
>=20
>  - Another to set up a chaining thread, since chain
>    setup bypasses setup_irq() and friends.

If you mean to push the chaining bits into the IRQ thread too, i=20
think the chaining bits actually should never be threaded. Is=20
there a good reason to do that? It's not like they will really=20
be preemptible (preempting a chaining thread would mean the=20
whole demuxing chain is held up =3D> bad).

> That latter might touch what the v2 patches added,
> since I'd want it to share code.

Sure.

>=20
> - Dave
>=20
> p.s. Note that those changes would still leave the
>      lockdep bug around ... it will still be breaking
>      various drivers that use normal IRQs, by forcibly
>      enabling IRQF_DISABLED.

it's not a bug - and i think Peter explained that already. It's=20
not really breaking things either - we've had this for more than=20
2 years.

	Ingo
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
