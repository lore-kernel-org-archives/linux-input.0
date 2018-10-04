From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH] Input: mousedev - add a schedule point in
 mousedev_write()
Date: Thu, 4 Oct 2018 12:34:07 -0700
Message-ID: <20181004193407.GK2674@linux.ibm.com>
References: <20181004154749.111595-1-edumazet@google.com>
 <20181004185949.GA233675@dtor-ws>
Reply-To: paulmck@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181004185949.GA233675@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, linux-kernel <linux-kernel@vger.kernel.org>, Eric Dumazet <eric.dumazet@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Oct 04, 2018 at 11:59:49AM -0700, Dmitry Torokhov wrote:
> Hi Eric,
> 
> On Thu, Oct 04, 2018 at 08:47:49AM -0700, Eric Dumazet wrote:
> > syzbot was able to trigger rcu stalls by calling write()
> > with large number of bytes.
> > 
> > Add a cond_resched() in the loop to avoid this.
> 
> I think this simply masks a deeper issue. The code fetches characters
> from userspace in a loop, takes a lock, quickly places response in an
> output buffer, and releases interrupt. I do not see why this should
> cause stalls as we do not hold spinlock/interrupts off for extended
> period of time.
> 
> Adding Paul so he can straighten me out...

If you are running a !PREEMPT kernel, then you need the cond_resched()
to allow the scheduler to choose someone else to run if needed and
to let RCU know that grace periods can end.  Without the cond_resched(),
if you stay in that loop long enough you will get excessive scheduling
latencies and eventually even RCU CPU stall warning splats.

In a PREEMPT (instead of !PREEMPT) kernel, you would be right.  When
preemption is enabled, the scheduler can preempt and RCU can sense
lack of readers from the scheduling-clock interrupt handler.  Which
is why cond_resched() is nothingness in a PREEMPT kernel.

But because people run !PREEMPT as well as PREEMPT kernels, if that loop
can run for a long time, you need that cond_resched().

							Thanx, Paul

> > Link: https://lkml.org/lkml/2018/8/23/1106
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Reported-by: syzbot+9436b02171ac0894d33e@syzkaller.appspotmail.com
> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Cc: linux-input@vger.kernel.org
> > ---
> >  drivers/input/mousedev.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/input/mousedev.c b/drivers/input/mousedev.c
> > index e08228061bcdd2f97aaadece31d6c83eb7539ae5..412fa71245afe26a7a8ad75705566f83633ba347 100644
> > --- a/drivers/input/mousedev.c
> > +++ b/drivers/input/mousedev.c
> > @@ -707,6 +707,7 @@ static ssize_t mousedev_write(struct file *file, const char __user *buffer,
> >  		mousedev_generate_response(client, c);
> >  
> >  		spin_unlock_irq(&client->packet_lock);
> > +		cond_resched();
> >  	}
> >  
> >  	kill_fasync(&client->fasync, SIGIO, POLL_IN);
> > -- 
> > 2.19.0.605.g01d371f741-goog
> > 
> 
> Thanks.
> 
> -- 
> Dmitry
> 
