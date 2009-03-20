From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Question about usage of RCU in the input layer
Date: Thu, 19 Mar 2009 19:07:50 -0700
Message-ID: <20090320020750.GA6807@linux.vnet.ibm.com>
References: <20090318215812.15496a86@infradead.org> <20090319085628.GA6167@in.ibm.com> <20090319071841.63334eff@infradead.org>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from e7.ny.us.ibm.com ([32.97.182.137]:48149 "EHLO e7.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752206AbZCTCHy (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Mar 2009 22:07:54 -0400
Content-Disposition: inline
In-Reply-To: <20090319071841.63334eff@infradead.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: dipankar@in.ibm.com, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org

On Thu, Mar 19, 2009 at 07:18:41AM -0700, Arjan van de Ven wrote:
> On Thu, 19 Mar 2009 14:26:28 +0530
> Dipankar Sarma <dipankar@in.ibm.com> wrote:
> 
> > On Wed, Mar 18, 2009 at 09:58:12PM -0700, Arjan van de Ven wrote:
> > > Hi,
> > > 
> > > the input layer does a "synchronize_rcu()" after a
> > > list_add_tail_rcu(), which is costing me 1 second of boot time.....
> > > And based on my understanding of the RCU concept, you only need to
> > > synchronize on delete, not on addition... so I think the
> > > synchronize is entirely redundant here...
> > 
> > The more appropriate question is - why is synchronize_rcu() taking
> > 1 second ? Any idea what the other CPUs are doing at the time
> > of calling synchronize_rcu() ?
> 
> one cpu is doing a lot of i2c traffic which is a bunch of udelay()s
> in loops.. then it does quite a bit of uncached memory access, and
> the lot takes quite while.
> 
> > What driver is this ? How early
> > in the boot is this happening ? 
> 
> during kernel boot.
> 
> I suppose my question is also more generic.. why synchronize when it's
> not needed? At least based on my understanding of RCU (but you're the
> expert), you don't need to synchronize for an add, only between a
> delete and a (k)free.....

I don't claim to understand the code in question, so it is entirely
possible that the following is irrelevant.  But one other reason for
synchronize_rcu() is:

1.	Make change.

2.	synchronize_rcu()

3.	Now you are guaranteed that all CPUs/tasks/whatever currently
	running either are not messing with you on the one hand, or
	have seen the change on the other.

It sounds like you are seeing these delays later in boot, however,
if this this is instead happening before the scheduler is operational,
please check to make sure that the following patch is applied:

	http://lkml.org/lkml/2009/2/25/558

This patch will also -greatly- improve performance on single-CPU systems,
as in the patch makes synchronize_rcu() be essentially a no-op in the
single-CPU case for Classic RCU.

Alternatively, again assuming a single-CPU system, the following patch
also effectively makes synchronize_rcu() be a no-op while also cutting
down the kernel's memory footprint:

	http://lkml.org/lkml/2009/2/3/333

							Thanx, Paul
