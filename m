From: David Brownell <david-b@pacbell.net>
Subject: Re: lockdep and threaded IRQs (was: ...)
Date: Tue, 17 Mar 2009 19:00:30 -0700
Message-ID: <200903171900.30800.david-b@pacbell.net>
References: <1235762883-20870-1-git-send-email-me@felipebalbi.com> <200903021633.08736.david-b@pacbell.net> <20090303004427.GA8638@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756839AbZCRDGl@vger.kernel.org>
In-Reply-To: <20090303004427.GA8638@elte.hu>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrew Morton <akpm@linux-foundation.org>, me@felipebalbi.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, felipe.balbi@nokia.com, dmitry.torokhov@gmail.com, sameo@openedhand.com, tglx@linutronix.de
List-Id: linux-input@vger.kernel.org

On Monday 02 March 2009, Ingo Molnar wrote:
>=20
> > > Since you care about them - could you please send patches on top=20
> > > of the IRQ threading patches to add support for them?
> >=20
> > I'll look at that, and try to prepare something on top
> > of the version of the threading patches that gets into
> > the -next tree. =A0I got the impression there was going
> > to be a v3 of those patches soonish...
>=20
> Great! We'll sort out any conflicts so dont worry about that -=20
> you can pick up v2 just fine and post patches.

One such patch is about to come, with different $SUBJECT
and trimmed CC list.

Note however that it's completely independent of Thomas'
patches.  It only affects the IRQ dispatch sub-problem;
other bits seem to be needed too.


> If you mean to push the chaining bits into the IRQ thread too, i=20
> think the chaining bits actually should never be threaded. Is=20
> there a good reason to do that?=20

The chaining bits *MUST* be threaded.  The lack of that
support was a key issue with Thomas' patch.  The issue
being that access to the IRQ status registers, as needed
to dispatch the IRQ, is only possible in contexts that
can sleep.  That seems like a good reason.  :)


> It's not like they will really =20
> be preemptible (preempting a chaining thread would mean the=20
> whole demuxing chain is held up =3D> bad).

See above.  The reason to thread this IRQ handling is
that it can't be done outside of threads ... there's
no other way to access registers via I2C (or SPI, etc).

Accordingly there's no way to avoid preemption ... but
since these IRQs aren't on performance-critical paths,
that's really no bother.
