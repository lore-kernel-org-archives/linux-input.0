From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: touchscreen: AD7879: prevent invalid finger data
 reports
Date: Fri, 22 Oct 2010 09:30:49 -0700
Message-ID: <20101022163049.GA20816@core.coreip.homeip.net>
References: <1287408804-19789-1-git-send-email-michael.hennerich@analog.com>
 <20101022050007.GB10493@core.coreip.homeip.net>
 <544AC56F16B56944AEC3BD4E3D59177130945B1763@LIMKCMBX1.ad.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64185 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754468Ab0JVQa5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Oct 2010 12:30:57 -0400
Received: by iwn34 with SMTP id 34so1123902iwn.19
        for <linux-input@vger.kernel.org>; Fri, 22 Oct 2010 09:30:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <544AC56F16B56944AEC3BD4E3D59177130945B1763@LIMKCMBX1.ad.analog.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>, Drivers <Drivers@analog.com>

On Fri, Oct 22, 2010 at 08:16:48AM +0100, Hennerich, Michael wrote:
> Dmitry Torokhov wrote on 2010-10-22:
> > Hi Michael,
> >
> > On Mon, Oct 18, 2010 at 03:33:24PM +0200, michael.hennerich@analog.com
> > wrote:
> >> From: Michael Hennerich <michael.hennerich@analog.com>
> >>
> >> Considering following scenario - the touch is present on the screen at
> >> the beginning of the last conversion sequence, but by the time the last
> >> sequence is finished, the finger is lift off. The AD7879 data available
> >> interrupt signals (DAV) completion, however some X,Y values are not
> >> valid because the screen inputs were floating during the acquisition.
> >>
> >> The AD7877 acts differently here, since it only asserts DAV if the
> >> touch is still present when the conversion sequence finished.
> >>
> >> Based on the fact that this can only happen in the last sample of the
> >> repeated conversion sequence. We simply skip the last. (Short glitches
> >> are filtered by the AD7879 internal median and average filters) This
> >> doesn't cause noticeable side effects, since the minimum conversion
> >> interval is 9.44ms. We receive ~100 waypoint samples per second, so we
> >> simply delay the result by 9.44ms.
> >>
> >> Actually this patch repeats the first waypoint twice and then skips
> > the last.
> >
> > Input core won't actually pass the 2nd instance through. I think the
> > whole thing should look like the patch below.
> 
> I know input core suppresses identical events.
> Your patch looks nicer, however it will delay the first response by one
> Interrupt. Considering the minimum automatic conversion interval of 9.44ms
> - Not sure how much this really matters.
> 
> Acked-by: Michael Hennerich <michael.hennerich@analog.com>
> 

Thanks Michael. I think 10-15ms delay should not be noticeable for user
input, however you have the hardware, any chance you could try and see?

-- 
Dmitry
