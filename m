From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC PATCH 1/1] Input: gpio-keys: export gpio key information
	through sysfs
Date: Mon, 9 Nov 2009 09:18:34 -0800
Message-ID: <20091109171834.GA30386@core.coreip.homeip.net>
References: <cover.1256298993.git.ext-mika.1.westerberg@nokia.com> <937a56e01181bef04c6661dc61032c1d08269cfa.1256298993.git.ext-mika.1.westerberg@nokia.com> <20091028054317.GB2368@core.coreip.homeip.net> <20091028105001.GB26199@esdhcp04058.research.nokia.com> <20091104090628.GG31062@gw.healthdatacare.com> <1257326759.21596.92.camel@localhost> <20091106075220.GC11311@core.coreip.homeip.net> <1257779344.21596.502.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:33431 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753511AbZKIRSh (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Nov 2009 12:18:37 -0500
Received: by pwi3 with SMTP id 3so736823pwi.21
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2009 09:18:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1257779344.21596.502.camel@localhost>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: Mika Westerberg <mika.westerberg@iki.fi>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Artem,

On Mon, Nov 09, 2009 at 05:09:04PM +0200, Artem Bityutskiy wrote:
> On Thu, 2009-11-05 at 23:52 -0800, Dmitry Torokhov wrote:
> > On Wed, Nov 04, 2009 at 11:25:59AM +0200, Artem Bityutskiy wrote:
> > > > > > I think registering a full-blown device for every key is way too much,
> > > > > > given that most consumers of gpio-keys driver are embedded... Besides, I
> > > > > > don't think this should be driven from userspace. Board (platform) code
> > > > > > should know what GPIO make sense as wake up sources for the particular
> > > > > > device and should set up platform data accordingly.
> > > 
> > > For example, on N900 we want to disable the lens cover / proximity / etc
> > > gpios when the phones' screen is locked. Simply because we do not want
> > > the lines to generate interrupts, wakes up the CPU and waste our battery
> > > energy. But we do not want to disable the screen lock gpio, and some
> > > incoming call related gpios.
> > > 
> > > So we really do want this to be userspace-driven.
> > > 
> > 
> > OK, then maybe we should use 2 attributes, one showing gpios that can
> > be used for wakeup and one showing gpios that are currently set up as
> > wakeup sources. These can be built on using bitmap_scnlistprintf() and
> > bitmap_parselist() and can work with either GPIO numbers or keycodes.
> 
> Hi Dmitry,
> 
> could you please elaborate some more?
> 
> * are you talking about per-input device sysfs files?

I am not sure at what level these attributes must be created. While the
easiest way is indeed per-input device attribute (for that particular
driver) the functionality does not really have anything to do with
input... I'd probably prefer having this attribute elsewhere, maybe
we should extend /sys/class/gpio/gpioN for these purposes?

> * could you please give an example of how would I switch off, say, the
>   SW_CAMERA_LENS_COVER gpio by the keycode.

If the code lies in your driver then it is easy (the driver knows the
mapping); otherwsie you'll have to go with GPIO number.

> * why this should be sysfs and not a new ioctl?

Because it makes sense onfy for 1 or 2 devices.

> * should this be something specific to gpio-keys or common for all
>   devices?

I don't see how you can make it common for all input devices... But
maybe there other subsystems (PM?) that would make better sense for such
facility (control of wakeup sources). In fact, there is already power/wakeup
attribute, can you plug in there?

Thanks.

-- 
Dmitry
