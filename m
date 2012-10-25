From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: ABS_PRESSURE and 0 ranges
Date: Thu, 25 Oct 2012 13:51:59 -0700
Message-ID: <2450762.pYR3zhxxMr@dtor-d630.eng.vmware.com>
References: <2119530.D54ZbrWB3u@devpool02> <20121025183452.GC24594@core.coreip.homeip.net> <2331954.qazEWXyvNO@donald.sf-tec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:43161 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934995Ab2JYUwR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 25 Oct 2012 16:52:17 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so2283250pbb.19
        for <linux-input@vger.kernel.org>; Thu, 25 Oct 2012 13:52:16 -0700 (PDT)
In-Reply-To: <2331954.qazEWXyvNO@donald.sf-tec.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: linux-input@vger.kernel.org

On Thursday, October 25, 2012 10:11:27 PM Rolf Eike Beer wrote:
> You wrote:
> > Hi Rolf,
> > 
> > On Thu, Oct 25, 2012 at 02:59:49PM +0200, Rolf Eike Beer wrote:
> > > Hi all,
> > > 
> > > as I found out the hard way tslib does the detection if a touchscreen
> > > has
> > > been "clicked" if the kernel driver says it does not support
> > > ABS_PRESSURE. But when the kernel says it can do ABS_PRESSURE tslib will
> > > not do it's emulation and just pass on whatever pressure value the
> > > kernel
> > > sends.
> > > 
> > > So far, so good. Sadly there are some drivers that do:
> > > 
> > > input_set_abs_params(dev, ABS_PRESSURE, 0, 0, 0, 0);
> > 
> > What drivers are doing this?
> 
> git grep 'ABS_PRESSURE, 0, 0, 0, 0' drivers/input/
> 
> > > Guess what happens: no clicks at all. The question I have is: does the
> > > above line make any sense to be in a kernel driver at all? Or is that
> > > some voodoo that must be there and it's all tslib fault?
> > > 
> > > Now that I know where the problem is coming from the problem is easily
> > > fixable, I'm just wondering which patch to make.
> > 
> > Well, the limits are strictly advisory for userspace, input core does
> > not perform any clamping or discarding the data that falls outside the
> > limits, so tslib probably should not do that either.
> 
> My main concern is that if the driver says it will only ever give pressure
> values from 0 to 0, what useful stuff may that ever be? And since the driver
> says it supports presure touchscreen will wait for the driver to report it.
> Since it will never do it (or could at most return a 0), then there is
> nothing that could ever become a valid click event.

Once again, the limits are simply advisory and can even be adjusted from
userspace (EVIOCSABS).

So ucb1400_ts does report true pressure so all is good there, but tsc40 is
not. I think the claim for ABS_PRESSURE is left over from time when tslib
did not think that device without ABS_PRESSURE was a touchscreen. I'll
remove it from the driver.

Thanks.

-- 
Dmitry
