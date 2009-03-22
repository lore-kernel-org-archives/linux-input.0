From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: Question about usage of RCU in the input layer
Date: Sat, 21 Mar 2009 22:53:18 -0700
Message-ID: <20090321225318.5b25f0a7@infradead.org>
References: <20090320065058.65d01771@infradead.org>
	<20090320143104.GA6698@linux.vnet.ibm.com>
	<20090320111354.679ab53d@infradead.org>
	<20090321012746.GM6698@linux.vnet.ibm.com>
	<20090321125115.0a76ac27@infradead.org>
	<49C54D60.80306@cosmosbay.com>
	<20090321210745.GE7148@linux.vnet.ibm.com>
	<20090321204045.4a9022fd@infradead.org>
	<20090322043838.GF7148@linux.vnet.ibm.com>
	<20090321215109.717a3f12@infradead.org>
	<20090322051822.GG7148@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:56815 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837AbZCVFwW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 22 Mar 2009 01:52:22 -0400
In-Reply-To: <20090322051822.GG7148@linux.vnet.ibm.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: paulmck@linux.vnet.ibm.com
Cc: Eric Dumazet <dada1@cosmosbay.com>, dipankar@in.ibm.com, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org

On Sat, 21 Mar 2009 22:18:22 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

> > I'm measuring the time that the following code takes:
> > 
> >         init_completion(&rcu.completion);
> >         /* Will wake me after RCU finished. */
> >         call_rcu(&rcu.head, wakeme_after_rcu);
> >         /* Wait for it. */
> >         wait_for_completion(&rcu.completion);
> > 

> 
> No, my confusion -- I misread as 2700 milliseconds rather than 2700
> -microseconds-.  2700 microseconds (or 2.7 milliseconds) is in the
> expected range for synchronize_rcu() on an HZ=1000 system.  2.7
> seconds would of course be way out of line.

> > > If the former, exactly which kernel are you using?  The single-CPU
> > > optimization was added in 2.6.29-rc7, commit ID a682604838.
> > 
> > a bit after -rc8, specifically  commit
> > 5bee17f18b595937e6beafeee5197868a3f74a06
> 
> How many synchronize_rcu() calls are you seeing on the boot path?

I see 20 that hit the above code path (eg ones that wait) until
userspace starts.


> Also, are you running with NO_HZ=y?

of course...  is there any other way ? ;-)

-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
