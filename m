From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Question about usage of RCU in the input layer
Date: Sat, 21 Mar 2009 22:18:22 -0700
Message-ID: <20090322051822.GG7148@linux.vnet.ibm.com>
References: <20090320065058.65d01771@infradead.org> <20090320143104.GA6698@linux.vnet.ibm.com> <20090320111354.679ab53d@infradead.org> <20090321012746.GM6698@linux.vnet.ibm.com> <20090321125115.0a76ac27@infradead.org> <49C54D60.80306@cosmosbay.com> <20090321210745.GE7148@linux.vnet.ibm.com> <20090321204045.4a9022fd@infradead.org> <20090322043838.GF7148@linux.vnet.ibm.com> <20090321215109.717a3f12@infradead.org>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753208AbZCVFSl@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090321215109.717a3f12@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Eric Dumazet <dada1@cosmosbay.com>, dipankar@in.ibm.com, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sat, Mar 21, 2009 at 09:51:09PM -0700, Arjan van de Ven wrote:
> On Sat, 21 Mar 2009 21:38:38 -0700
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
>=20
> > On Sat, Mar 21, 2009 at 08:40:45PM -0700, Arjan van de Ven wrote:
> > > On Sat, 21 Mar 2009 14:07:45 -0700
> > > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> > >=20
> > > > On Sat, Mar 21, 2009 at 09:26:08PM +0100, Eric Dumazet wrote:
> > > > > Arjan van de Ven a =E9crit :
> > > > > > On Fri, 20 Mar 2009 18:27:46 -0700
> > > > > > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> > > > > >=20
> > > > > >> On Fri, Mar 20, 2009 at 11:13:54AM -0700, Arjan van de Ven
> > > > > >> wrote:
> > > > > >>> On Fri, 20 Mar 2009 07:31:04 -0700
> > > > > >>> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> > > > > >>>>> that'd be throwing out the baby with the bathwater... I=
'm
> > > > > >>>>> trying to use the other cpus to do some of the boot wor=
k
> > > > > >>>>> (so that the total goes faster); not using the other cp=
us
> > > > > >>>>> would be counter productive to that. (As is just sittin=
g
> > > > > >>>>> in synchronize_rcu() when the other cpu is working..
> > > > > >>>>> hence this discussion ;-)
> > > > > >>>> OK, so you are definitely running multiple CPUs when the
> > > > > >>>> offending synchronize_rcu() executes, then?
> > > > > >>> absolutely.=20
> > > > > >>> (and I'm using bootgraph.pl in scripts to track who's
> > > > > >>> stalling etc)
> > > > > >>>> If so, here are some follow-on questions:
> > > > > >>>>
> > > > > >>>> 1.	How many synchronize_rcu() calls are you seeing
> > > > > >>>> on the critical boot path
> > > > > >>> I've seen only this (input) one to take a long time
> > > > > >> Ouch!!!  A -single- synchronize_rcu() taking a full second=
???
> > > > > >> That indicates breakage.
> > > > > >>
> > > > > >>>>  and what value of HZ are you running?
> > > > > >>> 1000
> > > > > >> K, in absence of readers for RCU_CLASSIC, we should see a
> > > > > >> handful of milliseconds for synchronize_rcu().
> > > > > >=20
> > > > > > I've attached an instrumented bootgraph of what is going on=
;
> > > > > > the rcu delays are shown as red blocks inside the regular
> > > > > > functions as they initialize......
> > > > > >=20
> > > > > > (svg can be viewed with inkscape, gimp, firefox and various
> > > > > > other tools)
> > > > >=20
> > > > > Interesting stuff...
> > > > >=20
> > > > > I thought you mentioned i2c drivers being source of the
> > > > > udelays(), but I cant see them in this svg, unless its
> > > > > async_probe_hard ?
> > > >=20
> > > > Arjan, another thought -- if the udelays() are not under
> > > > rcu_read_lock(), you should be able to finesse this by using
> > > > CONFIG_PREEMPT_RCU, which will happily ignore spinning CPUs as
> > > > long as they are not in an RCU read-side critical section.
> > >=20
> > > I'll play with that
> > > In the mean time I've reduced the "other" function's time
> > > significantly; so the urgency has gone away some.
> >=20
> > Good to hear!
> >=20
> > > It's still "interesting" that even in the "there is only really o=
ne
> > > thread running" case the minimum delay seems to be 2700 microseco=
nds
> > > for classic RCU. Especially during bootup that sounds a bit
> > > harsh.... (since that is where many "read mostly" cases actually
> > > get their modifications)
> >=20
> > OK, I'll bite...  2700 microseconds measures exactly what?
>=20
> I'm measuring the time that the following code takes:
>=20
>         init_completion(&rcu.completion);
>         /* Will wake me after RCU finished. */
>         call_rcu(&rcu.head, wakeme_after_rcu);
>         /* Wait for it. */
>         wait_for_completion(&rcu.completion);
>=20
> in kernel/rcupdate.c:synchronize_rcu();
> (I put markings around it for bootgraph to pick up).
> it looks like this:
> [    0.196157] rcu_waiting @ 1
> [    0.198978] rcu_continuing @ 1 after 2929 usec
> [    0.199585] rcu_waiting @ 1
> [    0.201973] rcu_continuing @ 1 after 2929 usec
> [    0.208132] rcu_waiting @ 1
> [    0.210905] rcu_continuing @ 1 after 2633 usec
> [    0.258025] rcu_waiting @ 1
> [    0.260910] rcu_continuing @ 1 after 2742 usec
> [    0.260988] rcu_waiting @ 1
> [    0.263910] rcu_continuing @ 1 after 2778 usec
> [    0.263987] rcu_waiting @ 1
> [    0.266910] rcu_continuing @ 1 after 2778 usec
> [    0.273030] rcu_waiting @ 1
> [    0.275912] rcu_continuing @ 1 after 2738 usec
> [    0.636267] rcu_waiting @ 1
> [    0.639531] rcu_continuing @ 1 after 3113 usec
> [    0.639611] rcu_waiting @ 1
> [    0.642006] rcu_continuing @ 1 after 2242 usec
> [    0.642086] rcu_waiting @ 1
> [    0.645407] rcu_continuing @ 1 after 3169 usec
> [    0.645487] rcu_waiting @ 1
> [    0.648007] rcu_continuing @ 1 after 2361 usec
> [    1.176323] rcu_waiting @ 1
> [    1.873021] rcu_continuing @ 1 after 680368 usec
> [    1.873108] rcu_waiting @ 1
> [    2.046045] rcu_continuing @ 1 after 168881 usec
>=20
> ok so I was not entirely right; there's a few ones that are a bit
> shorter than 2700...

No, my confusion -- I misread as 2700 milliseconds rather than 2700
-microseconds-.  2700 microseconds (or 2.7 milliseconds) is in the
expected range for synchronize_rcu() on an HZ=3D1000 system.  2.7 secon=
ds
would of course be way out of line.

The last two you captured above are excessive, of course -- more than
100 milliseconds each.

> > Also, "really one thread" means hardware threads or software thread=
s?
>=20
> one software thread. (as per the bootgraph)

OK, then the commit called out below would not help you much anyway.

> > If the former, exactly which kernel are you using?  The single-CPU
> > optimization was added in 2.6.29-rc7, commit ID a682604838.
>=20
> a bit after -rc8, specifically  commit
> 5bee17f18b595937e6beafeee5197868a3f74a06

How many synchronize_rcu() calls are you seeing on the boot path?
Also, are you running with NO_HZ=3Dy?

							Thanx, Paul
