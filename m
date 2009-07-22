From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Threaded interrupts for synaptic touchscreen in HTC dream
Date: Wed, 22 Jul 2009 17:15:59 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0907221715260.2813@localhost.localdomain>
References: <20090721160436.GD4352@dtor-d630.eng.vmware.com> <alpine.LFD.2.00.0907212225030.2813@localhost.localdomain> <20090721222547.GA1948@opensource.wolfsonmicro.com> <alpine.LFD.2.00.0907221022190.2813@localhost.localdomain> <20090722121800.GD21171@rakim.wolfsonmicro.main>
 <alpine.LFD.2.00.0907221427380.2813@localhost.localdomain> <1248269443.27058.1449.camel@twins> <alpine.LFD.2.00.0907221615480.2813@localhost.localdomain> <20090722143211.GB29404@rakim.wolfsonmicro.main> <alpine.LFD.2.00.0907221645240.2813@localhost.localdomain>
 <20090722145654.GA4987@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:41107 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752597AbZGVPRO (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Jul 2009 11:17:14 -0400
In-Reply-To: <20090722145654.GA4987@rakim.wolfsonmicro.main>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Trilok Soni <soni.trilok@gmail.com>, Pavel Machek <pavel@ucw.cz>, Arve Hj?nnev?g <arve@android.com>, kernel list <linux-kernel@vger.kernel.org>, Brian Swetland <swetland@google.com>, linux-input@vger.kernel.org, Andrew Morton <akpm@osdl.org>, linux-i2c@vger.kernel.org, Joonyoung Shim <jy0922.shim@samsung.com>, m.szyprowski@samsung.com, t.fujak@samsung.com, kyungmin.park@samsung.com, David Brownell <david-b@pacbell.net>, Daniel Ribeiro <drwyrm@gmail.com>

On Wed, 22 Jul 2009, Mark Brown wrote:

> On Wed, Jul 22, 2009 at 04:52:21PM +0200, Thomas Gleixner wrote:
> > On Wed, 22 Jul 2009, Mark Brown wrote:
> 
> > > The chips I'm deling with can certainly support doing that but I'm not
> > > sure there'd be enormous advantages - a lot of the interrupt handlers
> > > will either be trivial (eg, RTC ticks or alarms) or be serialised by a
> > > need to interact with the chip anyway.  I'd expect this to be generally
> > > true, though ICBW.
> 
> > So in your case it would be possible to run the various subdevice
> > thread_fn handlers from your main interrupt thread one after each
> > other ?
> 
> That's what they're all doing at present outside of genirq.

They just are racy against disable/enable/request/free I guess :)
 
