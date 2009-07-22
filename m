From: David Brownell <david-b@pacbell.net>
Subject: Re: Threaded interrupts for synaptic touchscreen in HTC dream
Date: Wed, 22 Jul 2009 10:04:10 -0700
Message-ID: <200907221004.11100.david-b@pacbell.net>
References: <20090721113642.GC13286@sirena.org.uk> <alpine.LFD.2.00.0907221427380.2813@localhost.localdomain> <20090722133131.GA28355@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753932AbZGVREP@vger.kernel.org>
In-Reply-To: <20090722133131.GA28355@rakim.wolfsonmicro.main>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Trilok Soni <soni.trilok@gmail.com>, Pavel Machek <pavel@ucw.cz>, Arve Hj?nnev?g <arve@android.com>, kernel list <linux-kernel@vger.kernel.org>, Brian Swetland <swetland@google.com>, linux-input@vger.kernel.org, Andrew Morton <akpm@osdl.org>, linux-i2c@vger.kernel.org, Joonyoung Shim <jy0922.shim@samsung.com>, m.szyprowski@samsung.com, t.fujak@samsung.com, kyungmin.park@samsung.com, Peter Zijlstra <peterz@infradead.org>, Daniel Ribeiro <drwyrm@gmail.com>
List-Id: linux-input@vger.kernel.org

On Wednesday 22 July 2009, Mark Brown wrote:
> Yes, I think that'll be required for users like gpiolib. =A0If someon=
e's
> done something like have a button implemented by attaching switch to =
a
> GPIO input on for something like jack detect on an audio CODEC or a w=
ake
> source for a PMIC then we've got generic code that expects to just ta=
ke
> a gpio/irq and interact with it.

Is there a problem with how it works now?  GPIO calls come in
sleeping (e.g. over I2C or SPI) and non-sleeping (classic SoC
GPIOs) varieties.  And it's not gpiolib which would handle any
IRQ support ... it's the driver for the GPIO chip, which would
expose both irq_chip and gpio_chip facets.  (Just like classic
SoC GPIO drivers.)

So if a handler uses only non-sleeping calls, it needs at most
minor tweaks to make sure it can be used from a threaded context.

If it uses sleeping calls, it already has to arrange that it
runs in a threaded context. =20
