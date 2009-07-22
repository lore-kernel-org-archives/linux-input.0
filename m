From: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: Threaded interrupts for synaptic touchscreen in HTC dream
Date: Wed, 22 Jul 2009 18:40:21 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0907221830410.2813@localhost.localdomain>
References: <20090721113642.GC13286@sirena.org.uk> <5d5443650907210518i6ee4df1evdc04d9ae9453707c@mail.gmail.com> <5d5443650907210530x4aaa03d6gd47ef5f79a3ef8a4@mail.gmail.com> <20090721124933.GA5668@rakim.wolfsonmicro.main> <20090721160436.GD4352@dtor-d630.eng.vmware.com>
 <alpine.LFD.2.00.0907212225030.2813@localhost.localdomain> <20090721222547.GA1948@opensource.wolfsonmicro.com> <alpine.LFD.2.00.0907221022190.2813@localhost.localdomain> <20090722121800.GD21171@rakim.wolfsonmicro.main> <alpine.LFD.2.00.0907221427380.2813@localhost.localdomain>
 <20090722155811.GA2775@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090722155811.GA2775-wUGeVx6es1+Q2O5dskk9LyLysJ1jNyTM@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Trilok Soni <soni.trilok-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Arve Hj?nnev?g <arve-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Brian Swetland <swetland-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Joonyoung Shim <jy0922.shim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, t.fujak-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Daniel Ribeiro <drwyrm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Wed, 22 Jul 2009, Dmitry Torokhov wrote:
> > I don't think it belongs into the driver code. It belongs into the
> > platform code which sets up the system and knows what's on which
> > interrupt line.
> >  
> 
> I do think this should be set up by the driver - the platform/arch code
> can't be 100% certain what model of servicing interrupts driver will
> chose, nor the driver can know whether arch code set things up for
> threaded or classic interrupt handling.
> 
> Since handle_level_oneshot_irq requires drivers to use threaded IRQ
> model (in absence of thread interrupt will never be unmasked) it would
> be better if we did set it up automatically, right there in
> request_threaded_irq(). This would reduce maintenance issues between
> platform and driver code.

No, it's the wrong way round. 

The platform code sets up the platform devices. So there is no real
good reason that the platform code does not know about the details.

If it conveys the wrong irq number then it wont work, if it sets the
wrong handler it wont work either. So what ?

If the driver is implemented to use a threaded handler, which it
better is no matter what as it uses a bus, and the interrupt
controller logic is proper implemented as well then the driver does
not care about those details at all. It will magically work with any
interrupt controller you put in front of it.

If the platform maintainer sets the wrong handler or the wrong
platform data then it's not the driver writers problem.

Thanks,

	tglx
