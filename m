From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: Threaded interrupts for synaptic touchscreen in HTC dream
Date: Wed, 22 Jul 2009 13:18:00 +0100
Message-ID: <20090722121800.GD21171@rakim.wolfsonmicro.main>
References: <5d5443650907151033w36008b71pe4b32bcea9489b75@mail.gmail.com>
 <20090721105924.GK4133@elf.ucw.cz>
 <20090721113642.GC13286@sirena.org.uk>
 <5d5443650907210518i6ee4df1evdc04d9ae9453707c@mail.gmail.com>
 <5d5443650907210530x4aaa03d6gd47ef5f79a3ef8a4@mail.gmail.com>
 <20090721124933.GA5668@rakim.wolfsonmicro.main>
 <20090721160436.GD4352@dtor-d630.eng.vmware.com>
 <alpine.LFD.2.00.0907212225030.2813@localhost.localdomain>
 <20090721222547.GA1948@opensource.wolfsonmicro.com>
 <alpine.LFD.2.00.0907221022190.2813@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0907221022190.2813-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Trilok Soni <soni.trilok-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Arve Hj?nnev?g <arve-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Brian Swetland <swetland-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Joonyoung Shim <jy0922.shim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, t.fujak-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Daniel Ribeiro <drwyrm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Wed, Jul 22, 2009 at 12:44:01PM +0200, Thomas Gleixner wrote:
> On Tue, 21 Jul 2009, Mark Brown wrote:

> > I'll need to have a more detailed look at that but it's not immediately
> > clear to me how a driver (or even machine) should use that code - it
> > looks more like it's intended to be called from within the IRQ
> > infrastructure than from random driver code.

> All it needs is to set handle_level_oneshot_irq for the interrupt line
> of your I2C or whatever devices. 

>    set_irq_handler(irq, handle_level_oneshot_irq);

Yeah, I know - the issue I was having was that the use of set_irq_handler()
seemed rather rude for driver code.  Grepping around I see that there
are actually a small number of drivers using it already but at first
glance most of them appear to be implementing interrupt controllers.  It
was setting off alarm bells about abstraction layer violation like
set_irq_type() does.

> > Nothing if the above works, though I guess more documentation wouldn't
> > hurt (and possibly a more friendly wrapper).  From the name and

> Wrapper for what ? 

Something to package up the set_irq_handler() and request_threaded_irq()
(possibly a flag for request_threaded_irq()).  This is such a common
thing and request_threaded_irq() looks so much like it should Just Work
that I'd expect it'll help usability a lot to have a single function
which says "this is the idiomatic way to implement this".

> The irq thread finds out which interrupt(s) are active in the
> device. So it raises the interrupt handlers for those from the thread
> which will wake up the relevant interrupt threads for those
> devices. Once all the thread handlers have finished you return from
> the main thread and the interrupt line gets unmasked again.

Yes, this bit of it isn't too much of a problem, it's what's going on in
all the non-genirq infrastructures, but...

> The driver which controls the interrupt device has to expose the
> demultiplexed interrupts via its own irq_chip implementation. Of
> course the chip functions like mask/ack/unmask cannot run in atomic
> context as they require bus access again.

...as you say this is the tricky bit.

> Here in deed we need to put some thought into common infrastructure
> as it seems that such excellent hardware designs are becoming more
> popular :(

This isn't a new issue - it's more that you're seeing a greater degree
of mainline activity from embedded systems.  

FWIW the hardware tradeoff here is in a large part down to the fact that
many of these devices are heavily size (and therefore pin count)
constrained, often on both the device and CPU end of things.  Adding
more pins would either mean a bigger device or a device that's more
expensive to manufacture and use.  This pushes to minimal wire, low
speed control interfaces and for the sort of low volume control these
things need there's not much operational problem there.  These things
are *normally* either pushing events that either won't happen very often
(eg, RTC alarm expiry) or shouldn't happen at all (eg, power failures)
and so aren't performance critical.

> After that bus_sync_unlock() is called outside the atomic context. Now
> the chip implementation issues the bus commands, waits for completion
> and unlocks the interrupt controller bus.

I'll try to find time to implement some use of it and give it a spin -
it looks good at first glance but I'll need to convert one of my drivers
to genirq in order to test.  Someone working on a chip that already uses
genirq might get there first.
