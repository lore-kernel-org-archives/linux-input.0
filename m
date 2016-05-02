From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/3] input: touchscreen: mxs-lradc: Add support for
 touchscreen
Date: Mon, 2 May 2016 09:58:18 -0700
Message-ID: <20160502165818.GA37394@dtor-ws>
References: <cover.1461930102.git.ksenija.stanojevic@gmail.com>
 <61fe1da2e8d82921f3222ec939047b6823f695e1.1461930102.git.ksenija.stanojevic@gmail.com>
 <20160429233616.GA13361@dtor-ws>
 <5723F4ED.5060303@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5723F4ED.5060303-ynQEQJNshbs@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: Ksenija Stanojevic <ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-95f8Dae0BrPYtjvyW6yDsg@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Sat, Apr 30, 2016 at 01:57:33AM +0200, Marek Vasut wrote:
> On 04/30/2016 01:36 AM, Dmitry Torokhov wrote:
> > Hi Ksenija,
> 
> Hi all,
> 
> > On Fri, Apr 29, 2016 at 01:49:11PM +0200, Ksenija Stanojevic wrote:
> >> Add mxs-lradc touchscreen driver.
> >>
> >> Signed-off-by: Ksenija Stanojevic <ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >> ---
> >>  drivers/input/touchscreen/Kconfig        |  14 +-
> >>  drivers/input/touchscreen/Makefile       |   1 +
> >>  drivers/input/touchscreen/mxs-lradc-ts.c | 729 +++++++++++++++++++++++++++++++
> >>  3 files changed, 742 insertions(+), 2 deletions(-)
> >>  create mode 100644 drivers/input/touchscreen/mxs-lradc-ts.c
> >>
> >> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> >> index 8ecdc38..d614d248 100644
> >> --- a/drivers/input/touchscreen/Kconfig
> >> +++ b/drivers/input/touchscreen/Kconfig
> >> @@ -566,7 +566,7 @@ config TOUCHSCREEN_HP600
> >>  	depends on SH_HP6XX && SH_ADC
> >>  	help
> >>  	  Say Y here if you have a HP Jornada 620/660/680/690 and want to
> >> -          support the built-in touchscreen.
> >> +	  support the built-in touchscreen.
> >>  
> >>  	  To compile this driver as a module, choose M here: the
> >>  	  module will be called hp680_ts_input.
> >> @@ -685,7 +685,7 @@ config TOUCHSCREEN_UCB1400
> >>  	  This enables support for the Philips UCB1400 touchscreen interface.
> >>  	  The UCB1400 is an AC97 audio codec.  The touchscreen interface
> >>  	  will be initialized only after the ALSA subsystem has been
> >> -	  brought up and the UCB1400 detected.  You therefore have to
> >> +	  brought up and the UCB1400 detected.	You therefore have to
> > 
> > Why do we have the tab in the middle of the text?
> 
> This shouldn't be a part of the patch.
> 
> >>  	  configure ALSA support as well (either built-in or modular,
> >>  	  independently of whether this driver is itself built-in or
> >>  	  modular) for this driver to work.
> 
> [...]
> 
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static struct platform_driver mxs_lradc_ts_driver = {
> >> +	.driver	= {
> >> +		.name = DRIVER_NAME_TS,
> >> +	},
> >> +	.probe	= mxs_lradc_ts_probe,
> >> +	.remove	= mxs_lradc_ts_remove,
> >> +};
> >> +module_platform_driver(mxs_lradc_ts_driver);
> >> +
> >> +MODULE_LICENSE("GPL v2");
> > 
> > "GPL" since you are not limiting to v2 only.
> 

I was just making sure the MODULE_LICENSE() string matches license
notice in the file. But see below.

> The original driver ( drivers/iio/adc/mxs-lradc.c ) is GPLv2 , but

No it is not. From the license notice at the beginning of
drivers/iio/adc/mxs-lradc.c:

> * This program is free software; you can redistribute it and/or modify
> * it under the terms of the GNU General Public License as published by
> * the Free Software Foundation; either version 2 of the License, or
> * (at your option) any later version.

So even the original driver is GPL v2+, MODULE_LICENSE() string
notwithstanding.

> unless the license gets changed to BSD or somesuch, I don't think anyone
> will really complain if it's changed to a more fitting version(s) of
> GPL. I'm fine with any GPL version here.

Me too, as long as we keep license notice and MODULE_LICENSE() in sync.

Thanks.

-- 
Dmitry
