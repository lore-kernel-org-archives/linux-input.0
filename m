From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: Threaded interrupts for synaptic touchscreen in HTC dream
Date: Wed, 22 Jul 2009 17:50:42 +0100
Message-ID: <20090722165042.GA21186@rakim.wolfsonmicro.main>
References: <20090714100634.GA4054@elf.ucw.cz>
 <20090721160436.GD4352@dtor-d630.eng.vmware.com>
 <alpine.LFD.2.00.0907212225030.2813@localhost.localdomain>
 <200907220939.33399.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200907220939.33399.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Trilok Soni <soni.trilok-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Arve Hj?nnev?g <arve-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Brian Swetland <swetland-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Joonyoung Shim <jy0922.shim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, t.fujak-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Wed, Jul 22, 2009 at 09:39:32AM -0700, David Brownell wrote:

> The normal model is that boards don't get involved with that level of
> logic ... all IRQs get set up once on generic code, and flow handlers
> don't change.  Or if they do change, it's done when changing the IRQ's
> trigger mode from edge to level, or vice versa.

> Can that be cleaned up a bit, so that the handle_level_oneshot_irq()
> and unmask_oneshot_irq() stuff kicks in automatically when needed,
> instead of requiring board-specific (or driver-specific) code to get
> that stuff right?

Thomas was reluctant to do that but up till now every single user has
been asking for it.  A flag in the driver requesting the behaviour
sounds OK to me, there are devices that can use threaded IRQs while
interacting with the device in the primary handler NAPI style.
