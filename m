From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: mousedev - add a schedule point in
 mousedev_write()
Date: Thu, 4 Oct 2018 15:54:55 -0700
Message-ID: <20181004225455.GC233675@dtor-ws>
References: <20181004154749.111595-1-edumazet@google.com>
 <20181004185949.GA233675@dtor-ws>
 <20181004193407.GK2674@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181004193407.GK2674@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: Eric Dumazet <edumazet@google.com>, linux-kernel <linux-kernel@vger.kernel.org>, Eric Dumazet <eric.dumazet@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Oct 04, 2018 at 12:34:07PM -0700, Paul E. McKenney wrote:
> On Thu, Oct 04, 2018 at 11:59:49AM -0700, Dmitry Torokhov wrote:
> > Hi Eric,
> > 
> > On Thu, Oct 04, 2018 at 08:47:49AM -0700, Eric Dumazet wrote:
> > > syzbot was able to trigger rcu stalls by calling write()
> > > with large number of bytes.
> > > 
> > > Add a cond_resched() in the loop to avoid this.
> > 
> > I think this simply masks a deeper issue. The code fetches characters
> > from userspace in a loop, takes a lock, quickly places response in an
> > output buffer, and releases interrupt. I do not see why this should
> > cause stalls as we do not hold spinlock/interrupts off for extended
> > period of time.
> > 
> > Adding Paul so he can straighten me out...
> 
> If you are running a !PREEMPT kernel, then you need the cond_resched()
> to allow the scheduler to choose someone else to run if needed and
> to let RCU know that grace periods can end.  Without the cond_resched(),
> if you stay in that loop long enough you will get excessive scheduling
> latencies and eventually even RCU CPU stall warning splats.
> 
> In a PREEMPT (instead of !PREEMPT) kernel, you would be right.  When
> preemption is enabled, the scheduler can preempt and RCU can sense
> lack of readers from the scheduling-clock interrupt handler.  Which
> is why cond_resched() is nothingness in a PREEMPT kernel.
> 
> But because people run !PREEMPT as well as PREEMPT kernels, if that loop
> can run for a long time, you need that cond_resched().

OK, I see. I'll apply the patch then.

I think evdev.c needs similar treatment as it will keep looping while
there is data...

Thanks.

-- 
Dmitry
