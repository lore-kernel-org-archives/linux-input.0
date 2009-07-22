From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Threaded interrupts for synaptic touchscreen in HTC dream
Date: Wed, 22 Jul 2009 09:04:23 -0700
Message-ID: <20090722155811.GA2775@dtor-d630.eng.vmware.com>
References: <20090721113642.GC13286@sirena.org.uk> <5d5443650907210518i6ee4df1evdc04d9ae9453707c@mail.gmail.com> <5d5443650907210530x4aaa03d6gd47ef5f79a3ef8a4@mail.gmail.com> <20090721124933.GA5668@rakim.wolfsonmicro.main> <20090721160436.GD4352@dtor-d630.eng.vmware.com> <alpine.LFD.2.00.0907212225030.2813@localhost.localdomain> <20090721222547.GA1948@opensource.wolfsonmicro.com> <alpine.LFD.2.00.0907221022190.2813@localhost.localdomain> <20090722121800.GD21171@rakim.wolfsonmicro.main> <alpine.LFD.2.00.0907221427380.2813@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.225]:18322 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751900AbZGVQE1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Jul 2009 12:04:27 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0907221427380.2813@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Trilok Soni <soni.trilok@gmail.com>, Pavel Machek <pavel@ucw.cz>, Arve Hj?nnev?g <arve@android.com>, kernel list <linux-kernel@vger.kernel.org>, Brian Swetland <swetland@google.com>, linux-input@vger.kernel.org, Andrew Morton <akpm@osdl.org>, linux-i2c@vger.kernel.org, Joonyoung Shim <jy0922.shim@samsung.com>, m.szyprowski@samsung.com, t.fujak@samsung.com, kyungmin.park@samsung.com, David Brownell <david-b@pacbell.net>, Peter Zijlstra <peterz@infradead.org>, Daniel Ribeiro <drwyrm@gmail.com>

Hi Thomas,

On Wed, Jul 22, 2009 at 02:58:24PM +0200, Thomas Gleixner wrote:
> Mark,
> 
> On Wed, 22 Jul 2009, Mark Brown wrote:
> 
> > On Wed, Jul 22, 2009 at 12:44:01PM +0200, Thomas Gleixner wrote:
> > > On Tue, 21 Jul 2009, Mark Brown wrote:
> > 
> > > > I'll need to have a more detailed look at that but it's not immediately
> > > > clear to me how a driver (or even machine) should use that code - it
> > > > looks more like it's intended to be called from within the IRQ
> > > > infrastructure than from random driver code.
> > 
> > > All it needs is to set handle_level_oneshot_irq for the interrupt line
> > > of your I2C or whatever devices. 
> > 
> > >    set_irq_handler(irq, handle_level_oneshot_irq);
> > 
> > Yeah, I know - the issue I was having was that the use of set_irq_handler()
> > seemed rather rude for driver code.  Grepping around I see that there
> > are actually a small number of drivers using it already but at first
> > glance most of them appear to be implementing interrupt controllers.  It
> > was setting off alarm bells about abstraction layer violation like
> > set_irq_type() does.
> 
> I don't think it belongs into the driver code. It belongs into the
> platform code which sets up the system and knows what's on which
> interrupt line.
>  

I do think this should be set up by the driver - the platform/arch code
can't be 100% certain what model of servicing interrupts driver will
chose, nor the driver can know whether arch code set things up for
threaded or classic interrupt handling.

Since handle_level_oneshot_irq requires drivers to use threaded IRQ
model (in absence of thread interrupt will never be unmasked) it would
be better if we did set it up automatically, right there in
request_threaded_irq(). This would reduce maintenance issues between
platform and driver code.

Thanks.

-- 
Dmitry
