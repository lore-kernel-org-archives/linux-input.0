From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [Device-drivers-devel] [PATCH 3/3] Input: touchscreen: ad7877
 filter events where pressure is beyond the maximum
Date: Mon, 18 Oct 2010 01:22:09 -0700
Message-ID: <20101018082209.GD8655@core.coreip.homeip.net>
References: <1287139250-24777-1-git-send-email-michael.hennerich@analog.com>
 <1287139250-24777-3-git-send-email-michael.hennerich@analog.com>
 <AANLkTimg2Uv26dcU7noSGCX7SHOn2+p6-LH_q=h9NtWc@mail.gmail.com>
 <20101018040810.GB7782@core.coreip.homeip.net>
 <20101018042428.GA23778@core.coreip.homeip.net>
 <20101018042541.GB23778@core.coreip.homeip.net>
 <544AC56F16B56944AEC3BD4E3D5917713094520E3C@LIMKCMBX1.ad.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:41896 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343Ab0JRIWQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Oct 2010 04:22:16 -0400
Received: by ywi6 with SMTP id 6so206574ywi.19
        for <linux-input@vger.kernel.org>; Mon, 18 Oct 2010 01:22:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <544AC56F16B56944AEC3BD4E3D5917713094520E3C@LIMKCMBX1.ad.analog.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Cc: Mike Frysinger <vapier.adi@gmail.com>, Drivers <Drivers@analog.com>, "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Mon, Oct 18, 2010 at 09:13:14AM +0100, Hennerich, Michael wrote:
> Dmitry Torokhov wrote on 2010-10-18:
> > On Sun, Oct 17, 2010 at 09:24:28PM -0700, Dmitry Torokhov wrote:
> >> On Sun, Oct 17, 2010 at 09:08:10PM -0700, Dmitry Torokhov wrote:
> >>> On Fri, Oct 15, 2010 at 09:51:12PM -0400, Mike Frysinger wrote:
> >>>> On Fri, Oct 15, 2010 at 06:40,  <michael.hennerich@analog.com>
> > wrote:
> >>>>> Suppress events where pressure > pressure_max.
> >>>>> These events come typically along with inaccurate X and Y
> > samples.
> >>>>
> >>>> were you going to commit to the blackfin tree ?
> >>>>
> >>>>> --- a/drivers/input/touchscreen/ad7877.c
> >>>>> +++ b/drivers/input/touchscreen/ad7877.c
> >>>>> @@ -360,6 +360,13 @@ static int ad7877_rx(struct ad7877 *ts)
> >>>>>                Rt /= z1;
> >>>>>                Rt = (Rt + 2047) >> 12;
> >>>>>
> >>>>> +               /* +                * Sample found inconsistent,
> >>>>> pressure is beyond +                * the maximum. Don't report it
> >>>>> to user space. +                */ +               if (Rt >
> >>>>> ts->pressure_max) +                       return -EINVAL;
> >>>>
> >>>> this has spaces in the middle of your tab indents ...
> >>>
> >>> I took care of that on my side...
> >>>
> >>
> >> BTW, I have a couple more small patches to the driver... Here is the
> >> first:
> >>
> >
> > And here is second:
> >
> > Input: ad7877 - switch to using threaded IRQ
> >
> > Instead of using asynchronous SPI API and then spinning waiting for
> > SPI transfer to complete when disabling the device, let's use threaded
> > IRQ model and spi_sync().
> 
> Tested on hardware - works great!
> 

Thanks Michael, I'll also add a tested-by tag too then.

> >
> > Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> Acked-by: Michael Hennerich <michael.hennerich@analog.com>

Thanks.

-- 
Dmitry
