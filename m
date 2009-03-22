From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: Question about usage of RCU in the input layer
Date: Sat, 21 Mar 2009 20:40:45 -0700
Message-ID: <20090321204045.4a9022fd@infradead.org>
References: <20090319071841.63334eff@infradead.org>
	<20090320020750.GA6807@linux.vnet.ibm.com>
	<20090319202032.4c971d92@infradead.org>
	<20090320044541.GE6807@linux.vnet.ibm.com>
	<20090320065058.65d01771@infradead.org>
	<20090320143104.GA6698@linux.vnet.ibm.com>
	<20090320111354.679ab53d@infradead.org>
	<20090321012746.GM6698@linux.vnet.ibm.com>
	<20090321125115.0a76ac27@infradead.org>
	<49C54D60.80306@cosmosbay.com>
	<20090321210745.GE7148@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:41267 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752669AbZCVDkB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 21 Mar 2009 23:40:01 -0400
In-Reply-To: <20090321210745.GE7148@linux.vnet.ibm.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: paulmck@linux.vnet.ibm.com
Cc: Eric Dumazet <dada1@cosmosbay.com>, dipankar@in.ibm.com, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org

On Sat, 21 Mar 2009 14:07:45 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

> On Sat, Mar 21, 2009 at 09:26:08PM +0100, Eric Dumazet wrote:
> > Arjan van de Ven a =C3=A9crit :
> > > On Fri, 20 Mar 2009 18:27:46 -0700
> > > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> > >=20
> > >> On Fri, Mar 20, 2009 at 11:13:54AM -0700, Arjan van de Ven wrote=
:
> > >>> On Fri, 20 Mar 2009 07:31:04 -0700
> > >>> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> > >>>>> that'd be throwing out the baby with the bathwater... I'm
> > >>>>> trying to use the other cpus to do some of the boot work (so
> > >>>>> that the total goes faster); not using the other cpus would b=
e
> > >>>>> counter productive to that. (As is just sitting in
> > >>>>> synchronize_rcu() when the other cpu is working.. hence this
> > >>>>> discussion ;-)
> > >>>> OK, so you are definitely running multiple CPUs when the
> > >>>> offending synchronize_rcu() executes, then?
> > >>> absolutely.=20
> > >>> (and I'm using bootgraph.pl in scripts to track who's stalling
> > >>> etc)
> > >>>> If so, here are some follow-on questions:
> > >>>>
> > >>>> 1.	How many synchronize_rcu() calls are you seeing on
> > >>>> the critical boot path
> > >>> I've seen only this (input) one to take a long time
> > >> Ouch!!!  A -single- synchronize_rcu() taking a full second???
> > >> That indicates breakage.
> > >>
> > >>>>  and what value of HZ are you running?
> > >>> 1000
> > >> K, in absence of readers for RCU_CLASSIC, we should see a handfu=
l
> > >> of milliseconds for synchronize_rcu().
> > >=20
> > > I've attached an instrumented bootgraph of what is going on;
> > > the rcu delays are shown as red blocks inside the regular
> > > functions as they initialize......
> > >=20
> > > (svg can be viewed with inkscape, gimp, firefox and various other
> > > tools)
> >=20
> > Interesting stuff...
> >=20
> > I thought you mentioned i2c drivers being source of the udelays(),
> >  but I cant see them in this svg, unless its async_probe_hard ?
>=20
> Arjan, another thought -- if the udelays() are not under
> rcu_read_lock(), you should be able to finesse this by using
> CONFIG_PREEMPT_RCU, which will happily ignore spinning CPUs as long
> as they are not in an RCU read-side critical section.

I'll play with that
In the mean time I've reduced the "other" function's time significantly=
;
so the urgency has gone away some.

It's still "interesting" that even in the "there is only really one
thread running" case the minimum delay seems to be 2700 microseconds
for classic RCU. Especially during bootup that sounds a bit harsh....
(since that is where many "read mostly" cases actually get their
modifications)

>=20
> 							Thanx, Paul


--=20
Arjan van de Ven 	Intel Open Source Technology Centre
=46or development, discussion and tips for power savings,=20
visit http://www.lesswatts.org
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
