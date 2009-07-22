From: David Brownell <david-b@pacbell.net>
Subject: Re: Threaded interrupts for synaptic touchscreen in HTC dream
Date: Wed, 22 Jul 2009 10:41:18 -0700
Message-ID: <200907221041.19027.david-b@pacbell.net>
References: <20090714100634.GA4054@elf.ucw.cz> <20090721160436.GD4352@dtor-d630.eng.vmware.com> <alpine.LFD.2.00.0907212225030.2813@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from n18.bullet.mail.mud.yahoo.com ([68.142.206.145]:36087 "HELO
	n18.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754069AbZGVRlT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Jul 2009 13:41:19 -0400
In-Reply-To: <alpine.LFD.2.00.0907212225030.2813@localhost.localdomain>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Trilok Soni <soni.trilok@gmail.com>, Pavel Machek <pavel@ucw.cz>, Arve Hj?nnev?g <arve@android.com>, kernel list <linux-kernel@vger.kernel.org>, Brian Swetland <swetland@google.com>, linux-input@vger.kernel.org, Andrew Morton <akpm@osdl.org>, linux-i2c@vger.kernel.org, Joonyoung Shim <jy0922.shim@samsung.com>, m.szyprowski@samsung.com, t.fujak@samsung.com, kyungmin.park@samsung.com, Peter Zijlstra <peterz@infradead.org>

On Tuesday 21 July 2009, Thomas Gleixner wrote:
> > >  - Multi-function devices like the twl4030 which have an interrupt
> > >    controller on them and would like to expose that interrupt controller
> > >    via the generic IRQ subsystem.  This was a large part of the
> > >    discussion in the thread above is a much trickier problem.
> 
> Why ?

Because the current threaded IRQ framework stops short of supporting
the relevant IRQ chaining mechanisms.

It handles the first level IRQ.  Not the second or third level
which needs to be dispatched from that one.

- Dave

