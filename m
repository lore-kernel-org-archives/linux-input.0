From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: ABS_PRESSURE and 0 ranges
Date: Thu, 25 Oct 2012 11:34:54 -0700
Message-ID: <20121025183452.GC24594@core.coreip.homeip.net>
References: <2119530.D54ZbrWB3u@devpool02>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:55935 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756494Ab2JYSfB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 25 Oct 2012 14:35:01 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so1362869pad.19
        for <linux-input@vger.kernel.org>; Thu, 25 Oct 2012 11:35:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2119530.D54ZbrWB3u@devpool02>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: linux-input@vger.kernel.org

Hi Rolf,

On Thu, Oct 25, 2012 at 02:59:49PM +0200, Rolf Eike Beer wrote:
> Hi all,
> 
> as I found out the hard way tslib does the detection if a touchscreen has been 
> "clicked" if the kernel driver says it does not support ABS_PRESSURE. But when 
> the kernel says it can do ABS_PRESSURE tslib will not do it's emulation and 
> just pass on whatever pressure value the kernel sends.
> 
> So far, so good. Sadly there are some drivers that do:
> 
> input_set_abs_params(dev, ABS_PRESSURE, 0, 0, 0, 0);
> 

What drivers are doing this?

> Guess what happens: no clicks at all. The question I have is: does the above 
> line make any sense to be in a kernel driver at all? Or is that some voodoo 
> that must be there and it's all tslib fault?
> 
> Now that I know where the problem is coming from the problem is easily 
> fixable, I'm just wondering which patch to make.

Well, the limits are strictly advisory for userspace, input core does
not perform any clamping or discarding the data that falls outside the
limits, so tslib probably should not do that either.

Thanks.

-- 
Dmitry
