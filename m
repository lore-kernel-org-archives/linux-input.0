From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Synchronizing evdev readers and drivers?
Date: Fri, 3 Dec 2010 15:05:52 -0800
Message-ID: <20101203230552.GA22969@core.coreip.homeip.net>
References: <AANLkTik8X-Xe9fvYUtRObRBP1PyedOu+zwb1SKKf+kgy@mail.gmail.com>
 <20101202212223.GA9864@core.coreip.homeip.net>
 <AANLkTi=vc0b5Zcy=TuVq3=6yZ8eHCEwLQ0hkkk-x-AyZ@mail.gmail.com>
 <20101203124240.GH3182@sirena.org.uk>
 <AANLkTimFoyFksd1orc9Bf8y5y7xQf14i_hhDoRyR3vnE@mail.gmail.com>
 <20101203135346.GI3182@sirena.org.uk>
 <AANLkTimKyU9dhxE5pkwTZ_0m7C1z+KjB-FMqLkA_UsNf@mail.gmail.com>
 <20101203185250.GA730@opensource.wolfsonmicro.com>
 <AANLkTimG0t-1e1s+t-ytXf7e-ZpXFq32C_XVZY6vh59n@mail.gmail.com>
 <20101203222744.GA15995@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f42.google.com ([74.125.83.42]:33306 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884Ab0LCXGC (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 Dec 2010 18:06:02 -0500
Received: by gwb20 with SMTP id 20so5005749gwb.1
        for <linux-input@vger.kernel.org>; Fri, 03 Dec 2010 15:06:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101203222744.GA15995@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Bill Gatliff <bgat@billgatliff.com>, linux-input@vger.kernel.org

On Fri, Dec 03, 2010 at 10:27:45PM +0000, Mark Brown wrote:
> On Fri, Dec 03, 2010 at 01:41:37PM -0600, Bill Gatliff wrote:
> > On Fri, Dec 3, 2010 at 12:52 PM, Mark Brown
> 
> I'm only going to reply to a couple of specific things that weren't
> covered in what Dimitry said here:
> 
> > It isn't a hypothetical situation: as far as I can tell right now,
> > most Android ports are already pacing their input device sampling in
> > userspace already.  That in itself doesn't justify implementing the
> > read callback, but it does suggest that there are situations (ok, at
> > least one) where users can truly benefit from that control.
> 
> When looking at Android phones it's important to remember how these
> things are typically made: Android devices are put together by teams
> that frequently have little prior Linux experience, and are often
> produced under great time pressure.  They're a great source of data
> about problems people are experiencing but you do have to really look
> to make sure you're addressing the root problem.
> 
> For example, in this case I would imagine that the thought process of
> people implementing the code you're looking at is something like "The
> data is coming in too quickly.  How can I slow it down?  Oh, I can't.
> Well, I'll just slow down my reading and worry about it later if that
> turns out to be a problem.".  It's most likely to be the lack of any
> current way to manage the data flow that is the underlying problem here,
> the implementations are just a convenient way for applications to bodge
> around the problem with the limited tools available to them.

Another possibility for an app design like this could have nothing to do
with hardware rate limiting:

We have N inputs that we want to get events from but the latency is not
that important. We do not want to lose events but we can afford to
postpone their processing. We know that on average, we are getting data
from input every X. Therefore, instead of being woken up as soon as we
get an event on any of the inputs, potentially several times per X
interval, schedule nonblocking reads every X and process all accumulated
events from all inputs at once.

-- 
Dmitry
