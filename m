From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 05/10] mfd: max77650: new core mfd driver
Date: Tue, 12 Feb 2019 11:14:03 +0000
Message-ID: <20190212111403.GC20638@dell>
References: <20190205091237.6448-1-brgl@bgdev.pl>
 <20190205091237.6448-6-brgl@bgdev.pl>
 <20190212083642.GT20638@dell>
 <CAMRc=MderQf20_8aG4-otBkCv60FSNSSqV3NVALPkFL-MqmJbg@mail.gmail.com>
 <20190212095457.GA20638@dell>
 <CAMRc=MdyT7nMJ7dUTf6M3PvRdynaCurb_TftMyA4eCwzpR9fVA@mail.gmail.com>
 <20190212101835.GB20638@dell>
 <CAMRc=MfYeVbvY6O03xq4eLN9TVpAKWCAXPk0eP5LSBCU7VU9fA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMRc=MfYeVbvY6O03xq4eLN9TVpAKWCAXPk0eP5LSBCU7VU9fA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Linux LED Subsystem <linux-leds@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-input@vger.kernel.org

On Tue, 12 Feb 2019, Bartosz Golaszewski wrote:

> wt., 12 lut 2019 o 11:18 Lee Jones <lee.jones@linaro.org> napisał(a):
> >
> > On Tue, 12 Feb 2019, Bartosz Golaszewski wrote:
> >
> > > wt., 12 lut 2019 o 10:55 Lee Jones <lee.jones@linaro.org> napisał(a):
> > > >
> > > >  * The declaration of a superfluous struct
> > > >  * 100 lines of additional/avoidable code
> > > >  * Hacky hoop jumping trying to fudge VIRQs into resources
> > > >  * Resources were designed for HWIRQs (unless a domain is present)
> > > >  * Loads of additional/avoidable CPU cycles setting all this up
> > >
> > > While the above may be right, this one is negligible and you know it. :)
> >
> > You have nested for() loops.  You *are* wasting lots of cycles.
> >
> > > > Need I go on? :)
> > > >
> > > > Surely the fact that you are using both sides of an API
> > > > (devm_regmap_init_i2c and regmap_irq_get_*) in the same driver, must
> > > > set some alarm bells ringing?
> > > >
> > > > This whole HWIRQ setting, VIRQ getting, resource hacking is a mess.
> > > >
> > > > And for what?  To avoid passing IRQ data to a child driver?
> > >
> > > What do you propose? Should I go back to the approach in v1 and pass
> > > the regmap_irq_chip_data to child drivers?
> >
> > I'm saying you should remove all of this hackery and pass IRQs as they
> > are supposed to be passed (like everyone else does).
> 
> I'm not sure what you mean by "like everyone else does" - different
> mfd drivers seem to be doing different things. Is a simple struct
> containing virtual irq numbers passed to sub-drivers fine?

How do you plan on deriving the VIRQs to place into the struct?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
