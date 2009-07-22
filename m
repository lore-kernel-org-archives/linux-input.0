From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: Threaded interrupts for synaptic touchscreen in HTC dream
Date: Wed, 22 Jul 2009 10:13:31 -0700
Message-ID: <200907221013.32087.david-b@pacbell.net>
References: <20090721113642.GC13286@sirena.org.uk> <20090722155811.GA2775@dtor-d630.eng.vmware.com> <alpine.LFD.2.00.0907221830410.2813@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LFD.2.00.0907221830410.2813-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Trilok Soni <soni.trilok-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Arve Hj?nnev?g <arve-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Brian Swetland <swetland-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Joonyoung Shim <jy0922.shim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, t.fujak-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Daniel Ribeiro <drwyrm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Wednesday 22 July 2009, Thomas Gleixner wrote:
> 
> > I do think this should be set up by the driver - the platform/arch code
> > can't be 100% certain what model of servicing interrupts driver will
> > chose, nor the driver can know whether arch code set things up for
> > threaded or classic interrupt handling.
> > 
> > Since handle_level_oneshot_irq requires drivers to use threaded IRQ
> > model (in absence of thread interrupt will never be unmasked) it would
> > be better if we did set it up automatically, right there in
> > request_threaded_irq(). This would reduce maintenance issues between
> > platform and driver code.
> 
> No, it's the wrong way round. 
> 
> The platform code sets up the platform devices. So there is no real
> good reason that the platform code does not know about the details.

Except for the "development board" family of exceptions to
such rules ... or the "Processor-on-Card" model, where the
same platform/card gets used in a variety of different
chassis configurations, with different peripherals.

It may not be possible to know *which* configuration is
being used at board setup time.  However it most certainly
is known by the time a driver is configuring.
