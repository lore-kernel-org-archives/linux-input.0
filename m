From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] input/misc: new ADXL345/346 driver
Date: Thu, 1 Jul 2010 09:08:08 -0700
Message-ID: <20100701160808.GA4152@core.coreip.homeip.net>
References: <1255517680-30733-1-git-send-email-vapier@gentoo.org>
 <1256028039-15044-1-git-send-email-vapier@gentoo.org>
 <20100625071425.GA631@core.coreip.homeip.net>
 <544AC56F16B56944AEC3BD4E3D5917712E66DFEF69@LIMKCMBX1.ad.analog.com>
 <20100701075316.GA14696@core.coreip.homeip.net>
 <544AC56F16B56944AEC3BD4E3D5917712E66DFF76E@LIMKCMBX1.ad.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:62887 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754103Ab0GAQIc (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 1 Jul 2010 12:08:32 -0400
Received: by pwi5 with SMTP id 5so220717pwi.19
        for <linux-input@vger.kernel.org>; Thu, 01 Jul 2010 09:08:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <544AC56F16B56944AEC3BD4E3D5917712E66DFF76E@LIMKCMBX1.ad.analog.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Cc: Mike Frysinger <vapier@gentoo.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>, Chris Verges <chrisv@cyberswitching.com>, Luotao Fu <l.fu@pengutronix.de>, "Song, Barry" <Barry.Song@analog.com>

On Thu, Jul 01, 2010 at 10:15:11AM +0100, Hennerich, Michael wrote:
> Dmitry Torokhov wrote on 2010-07-01:
> > On Fri, Jun 25, 2010 at 02:59:24PM +0100, Hennerich, Michael wrote:
> >> Dmitry Torokhov wrote on 2010-06-25:
> >>> Hi Mike, Michael,
> >>>
> >>> On Tue, Oct 20, 2009 at 04:40:39AM -0400, Mike Frysinger wrote:
> >>>> From: Michael Hennerich <michael.hennerich@analog.com>
> >>>>
> >>>> This is a driver for the ADXL345/346 Three-Axis Digital
> >>>> Accelerometers.
> >>>>
> >>>
> >>> As I mentioned in one of the threads I decided to pull 3-axis
> >>> acceleromenetrs into input and I am finally getting around to
> >>> apply the patch... However I messed a bit with it so I was
> >>> wondering if someone could give it a short spin to see if I broke it or not.
> >>>
> >>> Thanks!
> >>>
> >>
> >> Hi Dmitry,
> >>
> >> Thanks for merging this driver.
> >> I gave it a quick spin. And there is one issue.
> >> There is a code path that is taken with the mutex held, which is
> >> also trying to acquire the mutex.
> >>
> >> Take a look at
> >>
> >> adxl34x_input_close() -> __adxl34x_disable() or
> >> adxl34x_disable() -> __adxl34x_disable()
> >>
> >> I think __adxl34x_disable() should not acquire the mutex!
> >>
> >
> > Yes, indeed it shoudl not have. I fixed it up and applied the patch.
> > Could you also please try the following patch - hopefully it also works
> > ;)
> >
> > Thank you in advance.
> >
> 
> Hi Dmitry,
> 
> A few minor things.
> See patch below.
> 
> -adxl34x is on startup not disabled - otherwise user must reset disable sysfs
> hook before the driver delivers any data.
> -restore erroneously dropped line in adxl34x_calibrate_store()
> -fix typo in adxl34x-i2c.c (l versus 1)
> 

Folded and applied, thank you Michael.

-- 
Dmitry
