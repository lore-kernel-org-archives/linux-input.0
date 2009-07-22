From: David Brownell <david-b@pacbell.net>
Subject: Re: Threaded interrupts for synaptic touchscreen in HTC dream
Date: Wed, 22 Jul 2009 10:34:04 -0700
Message-ID: <200907221034.05410.david-b@pacbell.net>
References: <20090714100634.GA4054@elf.ucw.cz> <200907220939.33399.david-b@pacbell.net> <alpine.LFD.2.00.0907221841340.2813@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754051AbZGVReI@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.0907221841340.2813@localhost.localdomain>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Trilok Soni <soni.trilok@gmail.com>, Pavel Machek <pavel@ucw.cz>, Arve Hj?nnev?g <arve@android.com>, kernel list <linux-kernel@vger.kernel.org>, Brian Swetland <swetland@google.com>, linux-input@vger.kernel.org, Andrew Morton <akpm@osdl.org>, linux-i2c@vger.kernel.org, Joonyoung Shim <jy0922.shim@samsung.com>, m.szyprowski@samsung.com, t.fujak@samsung.com, kyungmin.park@samsung.com, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-input@vger.kernel.org

On Wednesday 22 July 2009, Thomas Gleixner wrote:
> 
> > Can that be cleaned up a bit, so that the handle_level_oneshot_irq()
> > and unmask_oneshot_irq() stuff kicks in automatically when needed,
> > instead of requiring board-specific (or driver-specific) code to get
> > that stuff right?
> 
> The only way I can see is to set a special trigger flag like
> IRQF_TRIGGER_RISING & Co. 
> 
> i.e. IRQF_TRIGGER_LEVEL | IRQF_TRIGGER_ONESHOT
> 
> That might work.

That direction, yes ... request_threaded_irq() can't infer ONESHOT
from IRQF_TRIGGER_{LOW,HIGH} since the hardirq handler might be
able to get Real Work (tm) done in some non-I2C/non-SPI cases.

Another alternative syntax:  magic cookies for the hardirq handler.
Example, pass NULL to get a default punt-to-irqthread behavior, with
ONESHOT set up if it sees IRQF_TRIGGER_HIGH or IRQF_TRIGGER_LOW.
