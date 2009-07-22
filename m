From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: Threaded interrupts for synaptic touchscreen in HTC dream
Date: Wed, 22 Jul 2009 14:31:31 +0100
Message-ID: <20090722133131.GA28355@rakim.wolfsonmicro.main>
References: <20090721113642.GC13286@sirena.org.uk>
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
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0907221427380.2813-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Trilok Soni <soni.trilok-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Arve Hj?nnev?g <arve-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Brian Swetland <swetland-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Joonyoung Shim <jy0922.shim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, t.fujak-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Daniel Ribeiro <drwyrm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Wed, Jul 22, 2009 at 02:58:24PM +0200, Thomas Gleixner wrote:
> On Wed, 22 Jul 2009, Mark Brown wrote:
> > On Wed, Jul 22, 2009 at 12:44:01PM +0200, Thomas Gleixner wrote:

> > >    set_irq_handler(irq, handle_level_oneshot_irq);

> > Yeah, I know - the issue I was having was that the use of set_irq_handler()
> > seemed rather rude for driver code.  Grepping around I see that there

> I don't think it belongs into the driver code. It belongs into the
> platform code which sets up the system and knows what's on which
> interrupt line.

Yeah, that is doable - but it'd be good for usability if it could be
handled transparently by the driver.  Even in board code it's fairly
rare to need to explicitly set the handler if you're not actually
implementing an interrupt controller.  Most of the board-specific code
doing this is doing so for a CPLD, FPGA or similar on the board rather
than configuring a preexisting IRQ for use by a leaf device.

Half the trouble is that if you're not implementing interrupt controller
code then calling set_irq_*() is normally a sign that you're doing
something wrong (for example, for set_irq_type() you should be using
flags on request_irq()).

> Thinking further we should even provide some infrastructure for that
> in the common code which would handle the completion and attach it to
> the interrupts in question, so the driver authors would not have to
> deal with that at all. They just would return from thread_fn and let
> the generic code deal with the notification. The notification has to
> be set up by the interrupt controller code. That way you can use the
> same device driver code w/o knowledge of the interrupt controller
> implementation it is attached to.

Yes, I think that'll be required for users like gpiolib.  If someone's
done something like have a button implemented by attaching switch to a
GPIO input on for something like jack detect on an audio CODEC or a wake
source for a PMIC then we've got generic code that expects to just take
a gpio/irq and interact with it.
