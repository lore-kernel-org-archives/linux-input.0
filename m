From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Threaded interrupts for synaptic touchscreen in HTC dream
Date: Tue, 21 Jul 2009 09:04:37 -0700
Message-ID: <20090721160436.GD4352@dtor-d630.eng.vmware.com>
References: <20090714100634.GA4054@elf.ucw.cz> <5d5443650907140320w334864f4uc1ee13ed32fdb874@mail.gmail.com> <20090715133627.GA2538@elf.ucw.cz> <5d5443650907151033w36008b71pe4b32bcea9489b75@mail.gmail.com> <20090721105924.GK4133@elf.ucw.cz> <20090721113642.GC13286@sirena.org.uk> <5d5443650907210518i6ee4df1evdc04d9ae9453707c@mail.gmail.com> <5d5443650907210530x4aaa03d6gd47ef5f79a3ef8a4@mail.gmail.com> <20090721124933.GA5668@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090721124933.GA5668-HF5t3jzXg/6ND3a5+9QAFujbO/Zr0HzV@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Trilok Soni <soni.trilok-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Arve Hj?nnev?g <arve-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Brian Swetland <swetland-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Joonyoung Shim <jy0922.shim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, t.fujak-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Tue, Jul 21, 2009 at 01:49:33PM +0100, Mark Brown wrote:
> On Tue, Jul 21, 2009 at 06:00:07PM +0530, Trilok Soni wrote:
> 
> > Hopefully, this thread can give all details about threaded irq discussion.
> 
> > http://lkml.org/lkml/2009/2/27/255
> 
> Yes, I'm aware of that - I read it at the time.  It seemed to peter out
> without any satisfactory solution, unfortunately.  There's two separate
> issues here:
> 
>  - Ordinary devices on interrupt driven or slow buses like I2C.  These
>    need something along the lines of request_threaded_irq() that's allows
>    them to schedule the main IRQ handler outside hardirq context so
>    that they can interact with the device.  They need to do something in
>    hardirq context to disable the interrupt if it's level triggered but
>    most of the time the only option they've got is to disable the IRQ
>    and reenable it when the worker thread is done.  This is the issue
>    here.
> 
>    My immediate thought when I noticed this was that we should probably
>    fix request_threaded_irq() so that it's useful for them; I'd been
>    intending to do some digging and try to understand why it is
>    currently implemented as it is.
> 
>  - Multi-function devices like the twl4030 which have an interrupt
>    controller on them and would like to expose that interrupt controller
>    via the generic IRQ subsystem.  This was a large part of the
>    discussion in the thread above is a much trickier problem.
> 
> I've added the folks from Samsung posting the MELFAS MCS-5000 driver to
> the thread since they're running into the same issue.
> 

Let's also add Thomas and David since I believe they worked on the
feature.

>From my part I would like to have the threaded IRQ available to all
drivers since it seens to be hanlding driver shutdown cleanly and
without races which is a big plus for me since very few drivers get it
right.

-- 
Dmitry
