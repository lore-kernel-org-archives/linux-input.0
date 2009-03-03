From: David Brownell <david-b@pacbell.net>
Subject: Re: lockdep and threaded IRQs (was: ...)
Date: Mon, 2 Mar 2009 18:37:08 -0800
Message-ID: <200903021837.08635.david-b@pacbell.net>
References: <1235762883-20870-1-git-send-email-me@felipebalbi.com> <200903021633.08736.david-b@pacbell.net> <20090303004427.GA8638@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from n15a.bullet.mail.mud.yahoo.com ([68.142.207.125]:36355 "HELO
	n15a.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752501AbZCCChN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 2 Mar 2009 21:37:13 -0500
In-Reply-To: <20090303004427.GA8638@elte.hu>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrew Morton <akpm@linux-foundation.org>, me@felipebalbi.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, felipe.balbi@nokia.com, dmitry.torokhov@gmail.com, sameo@openedhand.com, tglx@linutronix.de

On Monday 02 March 2009, Ingo Molnar wrote:
> >=20
> > p.s. Note that those changes would still leave the
> > =A0 =A0 =A0lockdep bug around ... it will still be breaking
> > =A0 =A0 =A0various drivers that use normal IRQs, by forcibly
> > =A0 =A0 =A0enabling IRQF_DISABLED.
>=20
> it's not a bug - and i think Peter explained that already.=20

No.  But I did get a non-response that didn't include any
explanation, and relied totally on unfounded assertions
combined with the presumption that someday IRQF_DISABLED
will be forced on in all drivers.


> It's =20
> not really breaking things either - we've had this for more than=20
> 2 years.

I happened across two MMC host adapter drivers which it
broke.  They preceded the patch whereby lockdep changes
request_irq() semantics.  The drivers break only with
lockdep ... so platforms relying on those can't use lockdep.
No reason to think there aren't more such bugs lurking.

We also wasted quite a few months tracking down USB bugs
that were masked by that patch ... the indeterminacy of
IRQF_DISABLED behavior given IRQF_SHARED was hidden by
enabling lockdep.  Led to a lot of totally crapulous oops
traces, I assure you.

So ... it has most certainly broken things.  There has
seemed to be a bit of stick-fingers-in-ears going on, that
prevents hearing about such problems though.

- Dave



--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
