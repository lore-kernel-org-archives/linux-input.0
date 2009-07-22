From: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: Threaded interrupts for synaptic touchscreen in HTC dream
Date: Wed, 22 Jul 2009 16:52:21 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0907221645240.2813@localhost.localdomain>
References: <5d5443650907210530x4aaa03d6gd47ef5f79a3ef8a4@mail.gmail.com> <20090721124933.GA5668@rakim.wolfsonmicro.main> <20090721160436.GD4352@dtor-d630.eng.vmware.com> <alpine.LFD.2.00.0907212225030.2813@localhost.localdomain> <20090721222547.GA1948@opensource.wolfsonmicro.com>
 <alpine.LFD.2.00.0907221022190.2813@localhost.localdomain> <20090722121800.GD21171@rakim.wolfsonmicro.main> <alpine.LFD.2.00.0907221427380.2813@localhost.localdomain> <1248269443.27058.1449.camel@twins> <alpine.LFD.2.00.0907221615480.2813@localhost.localdomain>
 <20090722143211.GB29404@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090722143211.GB29404-HF5t3jzXg/6ND3a5+9QAFujbO/Zr0HzV@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Trilok Soni <soni.trilok-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Arve Hj?nnev?g <arve-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Brian Swetland <swetland-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Joonyoung Shim <jy0922.shim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, t.fujak-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Daniel Ribeiro <drwyrm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Wed, 22 Jul 2009, Mark Brown wrote:

> On Wed, Jul 22, 2009 at 04:18:26PM +0200, Thomas Gleixner wrote:
> > On Wed, 22 Jul 2009, Peter Zijlstra wrote:
> 
> > > Also, how important is it that subhandler1..n run in their own thread?
> > > That is, can't we let them run from the thread that is otherwise waiting
> > > for the completino anyway?
> 
> > In those cases I suspect we can do that. I guess there can be async
> > handling as well: the main handler queries the pending interrupts,
> > masks them, wakes the handlers and returns. No wait for all threads to
> > finish necessary before unmasking the main interrupt line.
> 
> The chips I'm deling with can certainly support doing that but I'm not
> sure there'd be enormous advantages - a lot of the interrupt handlers
> will either be trivial (eg, RTC ticks or alarms) or be serialised by a
> need to interact with the chip anyway.  I'd expect this to be generally
> true, though ICBW.

So in your case it would be possible to run the various subdevice
thread_fn handlers from your main interrupt thread one after each
other ?

Well, that indeed makes it a candidate for a nested structure
handling, where your main thread calls handle_nested_irq(irq) which
simply runs the thread function of that nested interrupt while keeping
the semantics vs. disable/enable ... intact.

Thanks,

	tglx
