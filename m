From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Question about usage of RCU in the input layer
Date: Sun, 22 Mar 2009 18:27:37 -0700
Message-ID: <20090323012737.GO7148@linux.vnet.ibm.com>
References: <20090322043838.GF7148@linux.vnet.ibm.com> <20090321215109.717a3f12@infradead.org> <20090322051822.GG7148@linux.vnet.ibm.com> <20090321225318.5b25f0a7@infradead.org> <20090322165324.GH7148@linux.vnet.ibm.com> <20090322124632.5d5d6266@infradead.org> <20090322205212.GI7148@linux.vnet.ibm.com> <20090322154433.1b2cb1b1@infradead.org> <20090322230331.GM7148@linux.vnet.ibm.com> <20090322161637.056a43c5@infradead.org>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from e2.ny.us.ibm.com ([32.97.182.142]:43927 "EHLO e2.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753524AbZCWB1h (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 22 Mar 2009 21:27:37 -0400
Content-Disposition: inline
In-Reply-To: <20090322161637.056a43c5@infradead.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Eric Dumazet <dada1@cosmosbay.com>, dipankar@in.ibm.com, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org

On Sun, Mar 22, 2009 at 04:16:37PM -0700, Arjan van de Ven wrote:
> On Sun, 22 Mar 2009 16:03:31 -0700
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> 
> > On Sun, Mar 22, 2009 at 03:44:33PM -0700, Arjan van de Ven wrote:
> > > On Sun, 22 Mar 2009 13:52:12 -0700
> > > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> > > 
> > > > On Sun, Mar 22, 2009 at 12:46:32PM -0700, Arjan van de Ven wrote:
> > > > > On Sun, 22 Mar 2009 09:53:24 -0700
> > > > > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> > > > > 
> > > > > > > > How many synchronize_rcu() calls are you seeing on the
> > > > > > > > boot path?
> > > > > > > 
> > > > > > > I see 20 that hit the above code path (eg ones that wait)
> > > > > > > until userspace starts.
> > > > > > 
> > > > > > So with well-behaved readers, the full sequence would be worth
> > > > > > something like 50-60 milliseconds.
> > > > > 
> > > > > yeah it's about 10% if the total kernel boot time.. so it does
> > > > > start to matter
> > > > 
> > > > Half-second boot, eh?  That would indeed be impressive.
> > > 
> > > half a second until calling init.. that's what I have today (with
> > > all drivers built in).. nothing really special needed for it
> > > (well a few small patches that are pending for 2.6.30 ;-)
> > 
> > I thought the measurement was until the desktop was running with no
> > more disk activity.  ;-)
> 
> yeah that's like 2 seconds after that ;)

I must confess that I still dream of it booting faster than I perceive.
Of course, this is becoming ever easier to achieve as I continue to
grow older...  ;-)

> > But in any case, I will see what I can do about speeding up
> > synchronize_rcu().  I will likely start with TREE_RCU, and I may need
> > some sort of indication that boot is in progress.
> 
> system_state == SYSTEM_BOOTING is not a very elegant test but it works

Fair enough...  This would be until init, correct?

							Thanx, Paul
