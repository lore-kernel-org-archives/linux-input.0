From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: Question about usage of RCU in the input layer
Date: Sun, 22 Mar 2009 16:16:37 -0700
Message-ID: <20090322161637.056a43c5@infradead.org>
References: <20090321210745.GE7148@linux.vnet.ibm.com>
	<20090321204045.4a9022fd@infradead.org>
	<20090322043838.GF7148@linux.vnet.ibm.com>
	<20090321215109.717a3f12@infradead.org>
	<20090322051822.GG7148@linux.vnet.ibm.com>
	<20090321225318.5b25f0a7@infradead.org>
	<20090322165324.GH7148@linux.vnet.ibm.com>
	<20090322124632.5d5d6266@infradead.org>
	<20090322205212.GI7148@linux.vnet.ibm.com>
	<20090322154433.1b2cb1b1@infradead.org>
	<20090322230331.GM7148@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756988AbZCVXP7@vger.kernel.org>
In-Reply-To: <20090322230331.GM7148@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: paulmck@linux.vnet.ibm.com
Cc: Eric Dumazet <dada1@cosmosbay.com>, dipankar@in.ibm.com, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sun, 22 Mar 2009 16:03:31 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

> On Sun, Mar 22, 2009 at 03:44:33PM -0700, Arjan van de Ven wrote:
> > On Sun, 22 Mar 2009 13:52:12 -0700
> > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> > 
> > > On Sun, Mar 22, 2009 at 12:46:32PM -0700, Arjan van de Ven wrote:
> > > > On Sun, 22 Mar 2009 09:53:24 -0700
> > > > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> > > > 
> > > > > > > How many synchronize_rcu() calls are you seeing on the
> > > > > > > boot path?
> > > > > > 
> > > > > > I see 20 that hit the above code path (eg ones that wait)
> > > > > > until userspace starts.
> > > > > 
> > > > > So with well-behaved readers, the full sequence would be worth
> > > > > something like 50-60 milliseconds.
> > > > 
> > > > yeah it's about 10% if the total kernel boot time.. so it does
> > > > start to matter
> > > 
> > > Half-second boot, eh?  That would indeed be impressive.
> > 
> > half a second until calling init.. that's what I have today (with
> > all drivers built in).. nothing really special needed for it
> > (well a few small patches that are pending for 2.6.30 ;-)
> 
> I thought the measurement was until the desktop was running with no
> more disk activity.  ;-)

yeah that's like 2 seconds after that ;)

> 
> But in any case, I will see what I can do about speeding up
> synchronize_rcu().  I will likely start with TREE_RCU, and I may need
> some sort of indication that boot is in progress.

system_state == SYSTEM_BOOTING is not a very elegant test but it works



-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
