From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch 1/1] TOUCHSCREEN: S3C24XX touchscreen driver from
	Arnaud Patard.
Date: Fri, 27 Nov 2009 08:31:04 +0100
Message-ID: <20091127073103.GA1405@ucw.cz>
References: <20091118232939.201290297@fluff.org.uk> <20091118232948.063635416@fluff.org.uk> <20091119025930.GA20172@core.coreip.homeip.net> <4B052D50.2070002@simtec.co.uk> <20091119171423.GD15647@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20091119171423.GD15647@core.coreip.homeip.net>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ben Dooks <ben@simtec.co.uk>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Simtec Linux Team <linux@simtec.co.uk>, Arnaud Patard <arnaud.patard@rtp-net.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi!

> >>> +/* Per-touchscreen data. */
> >>> +
> >>> +/**
> >>> + * struct s3c2410ts - driver touchscreen state.
> >>> + * @client: The ADC client we registered with the core driver.
> >>> + * @dev: The device we are bound to.
> >>> + * @input: The input device we registered with the input subsystem.
> >>> + * @clock: The clock for the adc.
> >>> + * @io: Pointer to the IO base.
> >>> + * @xp: The accumulated X position data.
> >>> + * @yp: The accumulated Y position data.
> >>> + * @irq_tc: The interrupt number for pen up/down interrupt
> >>> + * @count: The number of samples collected.
> >>> + * @shift: The log2 of the maximum count to read in one go.
> >>> + */
> >>
> >> These sructures are driver-internal and so don't need to be kernel-doc-ed.
> >> Same goes for the driver-private functions.
> >
> > I like having the documentation, and I would much prefer to leave it
> > in as useful.
> 
> Ah, I wasn't requiesting to remove the documentation, I was just saying
> that since these data structures and fucntions are driver-provate they
> don't need to use kernel-doc style.

Well.. consistent style of documentation is nice, be it driver-private
or public stuff.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
