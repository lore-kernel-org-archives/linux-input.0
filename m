From: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: Threaded interrupts for synaptic touchscreen in HTC dream
Date: Wed, 22 Jul 2009 18:43:32 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0907221841340.2813@localhost.localdomain>
References: <20090714100634.GA4054@elf.ucw.cz> <20090721160436.GD4352@dtor-d630.eng.vmware.com> <alpine.LFD.2.00.0907212225030.2813@localhost.localdomain> <200907220939.33399.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200907220939.33399.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Trilok Soni <soni.trilok-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Arve Hj?nnev?g <arve-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Brian Swetland <swetland-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Joonyoung Shim <jy0922.shim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, t.fujak-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Wed, 22 Jul 2009, David Brownell wrote:
> On Tuesday 21 July 2009, Thomas Gleixner wrote:
> 
> Interesting.  The model is then to switch over to __set_irq_handler(),
> or maybe set_irq_chip_and_handler(), to replace the toplevel dispatch
> code for will-be-threaded IRQs which happen to be hooked up to inputs
> that don't sense edges.  (Agree, that seems like a goof.  But hardware
> designers sometimes have any choices there.)
> 
> The normal model is that boards don't get involved with that level of
> logic ... all IRQs get set up once on generic code, and flow handlers
> don't change.  Or if they do change, it's done when changing the IRQ's
> trigger mode from edge to level, or vice versa.
> 
> Can that be cleaned up a bit, so that the handle_level_oneshot_irq()
> and unmask_oneshot_irq() stuff kicks in automatically when needed,
> instead of requiring board-specific (or driver-specific) code to get
> that stuff right?

The only way I can see is to set a special trigger flag like
IRQF_TRIGGER_RISING & Co. 

i.e. IRQF_TRIGGER_LEVEL | IRQF_TRIGGER_ONESHOT

That might work.

Thanks,

	tglx
