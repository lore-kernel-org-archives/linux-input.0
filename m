From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Question about usage of RCU in the input layer
Date: Sat, 21 Mar 2009 21:38:38 -0700
Message-ID: <20090322043838.GF7148@linux.vnet.ibm.com>
References: <20090319202032.4c971d92@infradead.org> <20090320044541.GE6807@linux.vnet.ibm.com> <20090320065058.65d01771@infradead.org> <20090320143104.GA6698@linux.vnet.ibm.com> <20090320111354.679ab53d@infradead.org> <20090321012746.GM6698@linux.vnet.ibm.com> <20090321125115.0a76ac27@infradead.org> <49C54D60.80306@cosmosbay.com> <20090321210745.GE7148@linux.vnet.ibm.com> <20090321204045.4a9022fd@infradead.org>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from e9.ny.us.ibm.com ([32.97.182.139]:42855 "EHLO e9.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751160AbZCVEil (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 22 Mar 2009 00:38:41 -0400
Content-Disposition: inline
In-Reply-To: <20090321204045.4a9022fd@infradead.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Eric Dumazet <dada1@cosmosbay.com>, dipankar@in.ibm.com, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org

On Sat, Mar 21, 2009 at 08:40:45PM -0700, Arjan van de Ven wrote:
> On Sat, 21 Mar 2009 14:07:45 -0700
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
>=20
> > On Sat, Mar 21, 2009 at 09:26:08PM +0100, Eric Dumazet wrote:
> > > Arjan van de Ven a =E9crit :
> > > > On Fri, 20 Mar 2009 18:27:46 -0700
> > > > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> > > >=20
> > > >> On Fri, Mar 20, 2009 at 11:13:54AM -0700, Arjan van de Ven wro=
te:
> > > >>> On Fri, 20 Mar 2009 07:31:04 -0700
> > > >>> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> > > >>>>> that'd be throwing out the baby with the bathwater... I'm
> > > >>>>> trying to use the other cpus to do some of the boot work (s=
o
> > > >>>>> that the total goes faster); not using the other cpus would=
 be
> > > >>>>> counter productive to that. (As is just sitting in
> > > >>>>> synchronize_rcu() when the other cpu is working.. hence thi=
s
> > > >>>>> discussion ;-)
> > > >>>> OK, so you are definitely running multiple CPUs when the
> > > >>>> offending synchronize_rcu() executes, then?
> > > >>> absolutely.=20
> > > >>> (and I'm using bootgraph.pl in scripts to track who's stallin=
g
> > > >>> etc)
> > > >>>> If so, here are some follow-on questions:
> > > >>>>
> > > >>>> 1.	How many synchronize_rcu() calls are you seeing on
> > > >>>> the critical boot path
> > > >>> I've seen only this (input) one to take a long time
> > > >> Ouch!!!  A -single- synchronize_rcu() taking a full second???
> > > >> That indicates breakage.
> > > >>
> > > >>>>  and what value of HZ are you running?
> > > >>> 1000
> > > >> K, in absence of readers for RCU_CLASSIC, we should see a hand=
ful
> > > >> of milliseconds for synchronize_rcu().
> > > >=20
> > > > I've attached an instrumented bootgraph of what is going on;
> > > > the rcu delays are shown as red blocks inside the regular
> > > > functions as they initialize......
> > > >=20
> > > > (svg can be viewed with inkscape, gimp, firefox and various oth=
er
> > > > tools)
> > >=20
> > > Interesting stuff...
> > >=20
> > > I thought you mentioned i2c drivers being source of the udelays()=
,
> > >  but I cant see them in this svg, unless its async_probe_hard ?
> >=20
> > Arjan, another thought -- if the udelays() are not under
> > rcu_read_lock(), you should be able to finesse this by using
> > CONFIG_PREEMPT_RCU, which will happily ignore spinning CPUs as long
> > as they are not in an RCU read-side critical section.
>=20
> I'll play with that
> In the mean time I've reduced the "other" function's time significant=
ly;
> so the urgency has gone away some.

Good to hear!

> It's still "interesting" that even in the "there is only really one
> thread running" case the minimum delay seems to be 2700 microseconds
> for classic RCU. Especially during bootup that sounds a bit harsh....
> (since that is where many "read mostly" cases actually get their
> modifications)

OK, I'll bite...  2700 microseconds measures exactly what?

Also, "really one thread" means hardware threads or software threads?
If the former, exactly which kernel are you using?  The single-CPU
optimization was added in 2.6.29-rc7, commit ID a682604838.

							Thanx, Paul
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
