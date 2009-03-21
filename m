From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Question about usage of RCU in the input layer
Date: Sat, 21 Mar 2009 11:58:11 -0700
Message-ID: <20090321185811.GA7148@linux.vnet.ibm.com>
References: <20090318215812.15496a86@infradead.org> <20090320020750.GA6807@linux.vnet.ibm.com> <20090319202032.4c971d92@infradead.org> <200903202246.15772.dmitry.torokhov@gmail.com> <49C4AFC2.500@cosmosbay.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from e7.ny.us.ibm.com ([32.97.182.137]:51679 "EHLO e7.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752522AbZCUS6P (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 21 Mar 2009 14:58:15 -0400
Content-Disposition: inline
In-Reply-To: <49C4AFC2.500@cosmosbay.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Arjan van de Ven <arjan@infradead.org>, dipankar@in.ibm.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Mar 21, 2009 at 10:13:38AM +0100, Eric Dumazet wrote:
> Dmitry Torokhov a =E9crit :
> > On Thursday 19 March 2009 20:20:32 Arjan van de Ven wrote:
> >>> I don't claim to understand the code in question, so it is entire=
ly
> >>> possible that the following is irrelevant.  But one other reason =
for
> >>> synchronize_rcu() is:
> >>>
> >>> 1.    Make change.
> >>>
> >>> 2.    synchronize_rcu()
> >>>
> >>> 3.    Now you are guaranteed that all CPUs/tasks/whatever
> >>> currently running either are not messing with you on the one hand=
, or
> >>>       have seen the change on the other.
> >> ok so this is for the case where someone is already iterating the =
list.
> >>
> >> I don't see anything in the code that assumes this..
> >=20
> > This is something that input core guarantees to its users: by the t=
ime
> > input core calls hander->start() or, in its absence, by the time
> > input_register_handle() returns, events from input drivers will be
> > passed into the handle being registered, i.e. the presence of the
> > new item in the list is noticed by all CPUs.
> >=20
> > Now, it is possible to stop using RCU primitives in the input core
> > but I think that you'd want to figure out why synchronize_rcu()
> > takes so long first, otheriwse you may find another "abuser"
> > down the road.
> >=20
>=20
> If a cpu does a loop, it nearly impossible that synchronize_rcu() can
> be fast.
>=20
> We had same problem in ksoftirqd(), where I had to add a call
> to rcu_qsctr_inc() to unblock other threads blocked in synchronize_rc=
u()
>=20
> http://git2.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=
=3Dcommit;h=3D64ca5ab913f1594ef316556e65f5eae63ff50cee
>=20
> If a driver does a loop with no call to scheduler, it might have same=
 problem

And hopefully Arjan's promised bootgraph will give us some insights
as to what might be holding up the grace period.

							Thanx, Paul
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
