From: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: Threaded interrupts for synaptic touchscreen in HTC dream
Date: Wed, 22 Jul 2009 15:30:43 +0200
Message-ID: <1248269443.27058.1449.camel@twins>
References: <5d5443650907151033w36008b71pe4b32bcea9489b75@mail.gmail.com>
	 <20090721105924.GK4133@elf.ucw.cz> <20090721113642.GC13286@sirena.org.uk>
	 <5d5443650907210518i6ee4df1evdc04d9ae9453707c@mail.gmail.com>
	 <5d5443650907210530x4aaa03d6gd47ef5f79a3ef8a4@mail.gmail.com>
	 <20090721124933.GA5668@rakim.wolfsonmicro.main>
	 <20090721160436.GD4352@dtor-d630.eng.vmware.com>
	 <alpine.LFD.2.00.0907212225030.2813@localhost.localdomain>
	 <20090721222547.GA1948@opensource.wolfsonmicro.com>
	 <alpine.LFD.2.00.0907221022190.2813@localhost.localdomain>
	 <20090722121800.GD21171@rakim.wolfsonmicro.main>
	 <alpine.LFD.2.00.0907221427380.2813@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LFD.2.00.0907221427380.2813-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Trilok Soni <soni.trilok-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Arve Hj?nnev?g <arve-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Brian Swetland <swetland-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Joonyoung Shim <jy0922.shim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, t.fujak-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Daniel Ribeiro <drwyrm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Wed, 2009-07-22 at 14:58 +0200, Thomas Gleixner wrote:
>  One
> thing which I definitely want to change is the thread_eoi function. We
> probably want to have it customizable for the following reason:
> 
> main interrupt
>      hardirq handler wakes main thread handler
> 
> main thread handler
>     bus magic
>    	subdevice1 "hardirq" handler wakes subdevice1 irq thread
>    	subdevice2 "hardirq" handler wakes subdevice2 irq thread
>     main thread handler waits for subdevice1/2 handlers to complete
> 
> subdevice1 thread handler
>     bus magic
>     ....
>     thread_fn returns
>     signal main thread handler via completion
> 
> subdevice2 thread handler
>     bus magic
>     ....
>     thread_fn returns
>     signal main thread handler via completion
> 
> main thread handler resumes
>     bus magic
>     main thread handler returns from thread_fn
>     unmask main interrupt
> 
> So the thread_eoi function is useful for both the main and the
> subdevice handlers. The main handler probably just issues the unmask
> while the subdevice handlers probably want to call a completion to
> notify the main thread handler that they are done. That would be a
> fairly proper design I think and would encourage driver writers to
> follow the common scheme instead of doing their own black magic.
> 
> Thinking further we should even provide some infrastructure for that
> in the common code which would handle the completion and attach it to
> the interrupts in question, so the driver authors would not have to
> deal with that at all. They just would return from thread_fn and let
> the generic code deal with the notification. The notification has to
> be set up by the interrupt controller code. That way you can use the
> same device driver code w/o knowledge of the interrupt controller
> implementation it is attached to.

Wouldn't it be better if we could express the nesting property from
within genirq, so that we can do things like:

  register_chip_nested(parent_chip, parent_irq, slave_chip);

And let genirq set-up the needed magic to make the nesting work.


Also, how important is it that subhandler1..n run in their own thread?
That is, can't we let them run from the thread that is otherwise waiting
for the completino anyway?
