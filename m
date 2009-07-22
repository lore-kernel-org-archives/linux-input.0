From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Threaded interrupts for synaptic touchscreen in HTC dream
Date: Wed, 22 Jul 2009 18:08:37 +0100
Message-ID: <20090722170837.GC21186@rakim.wolfsonmicro.main>
References: <20090721113642.GC13286@sirena.org.uk>
 <alpine.LFD.2.00.0907221427380.2813@localhost.localdomain>
 <20090722133131.GA28355@rakim.wolfsonmicro.main>
 <200907221004.11100.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754013AbZGVRIm@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200907221004.11100.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Trilok Soni <soni.trilok@gmail.com>, Pavel Machek <pavel@ucw.cz>, Arve Hj?nnev?g <arve@android.com>, kernel list <linux-kernel@vger.kernel.org>, Brian Swetland <swetland@google.com>, linux-input@vger.kernel.org, Andrew Morton <akpm@osdl.org>, linux-i2c@vger.kernel.org, Joonyoung Shim <jy0922.shim@samsung.com>, m.szyprowski@samsung.com, t.fujak@samsung.com, kyungmin.park@samsung.com, Peter Zijlstra <peterz@infradead.org>, Daniel Ribeiro <drwyrm@gmail.com>
List-Id: linux-input@vger.kernel.org

On Wed, Jul 22, 2009 at 10:04:10AM -0700, David Brownell wrote:
> On Wednesday 22 July 2009, Mark Brown wrote:

> > source for a PMIC then we've got generic code that expects to just take
> > a gpio/irq and interact with it.

> Is there a problem with how it works now?  GPIO calls come in
> sleeping (e.g. over I2C or SPI) and non-sleeping (classic SoC
> GPIOs) varieties.  And it's not gpiolib which would handle any

I don't think there's any problem at all with gpiolib at all, it's just
an example user here.

> IRQ support ... it's the driver for the GPIO chip, which would
> expose both irq_chip and gpio_chip facets.  (Just like classic
> SoC GPIO drivers.)

Ah, yeah.  If the chip IRQ driver handles the waking of the core thread 
then this'd not be a problem.  For some reason I was thinking of the
driver using gpiolib when I read Thomas' post.
