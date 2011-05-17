From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/5] tsc2007: Debounce pressure measurement.
Date: Mon, 16 May 2011 23:32:47 -0700
Message-ID: <20110517063247.GD20428@core.coreip.homeip.net>
References: <1305534783-4917-1-git-send-email-thierry.reding@avionic-design.de>
 <20110517060241.GC20428@core.coreip.homeip.net>
 <20110517062715.GA16262@avionic-0098.mockup.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:50450 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752602Ab1EQGcw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 May 2011 02:32:52 -0400
Received: by pvg12 with SMTP id 12so98601pvg.19
        for <linux-input@vger.kernel.org>; Mon, 16 May 2011 23:32:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110517062715.GA16262@avionic-0098.mockup.avionic-design.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: linux-input@vger.kernel.org, Kwangwoo Lee <kwangwoo.lee@gmail.com>

On Tue, May 17, 2011 at 08:27:16AM +0200, Thierry Reding wrote:
> [Cc'ing Kwangwoo via the alternate email address]
> 
> * Dmitry Torokhov wrote:
> > On Mon, May 16, 2011 at 10:32:59AM +0200, Thierry Reding wrote:
> > > When the controller signals a pen-down event via the platform-specific
> > > GPIO, while the sample values indicate an invalid measurement, the
> > > measurement needs to be repeated.
> > > 
> > 
> > Would not we be interrupted again and take another sample then?
> 
> Not necessarily. The problem is that if the pendown GPIO reports pendown, it
> doesn't necessarily mean that the pressure measurement will be valid. This is
> especially true if max_rt is configurable (as introduced by one of the
> follow-up patchs).
> 
> What happens is that we are interrupted, check the GPIO to see that the pen
> is indeed down and then read the values and compute the pressure to see that
> it is invalid and we stop sampling. The TSC2007's nPEN_IRQ line never goes
> high again after that because the pen is still down (according to the GPIO).
> 
> The comment in the old code of the (rt > max_rt) even says "[...] repeat at
> least once more the measurement", which the old code actually doesn't.
> 

I see. I am concerned with resubmitting work over and over when we do
not have ts->get_pendown_state method.

-- 
Dmitry
