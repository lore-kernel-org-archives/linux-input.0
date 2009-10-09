From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Poll rate change and closing indication to polled input device
Date: Fri, 9 Oct 2009 09:27:18 -0700
Message-ID: <20091009162717.GC1092@core.coreip.homeip.net>
References: <1255089779.28243.24.camel@4fid08082> <20091009121201.GE5082@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:17619 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933591AbZJIQ3N (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 9 Oct 2009 12:29:13 -0400
Received: by fg-out-1718.google.com with SMTP id 22so2255801fge.1
        for <linux-input@vger.kernel.org>; Fri, 09 Oct 2009 09:27:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20091009121201.GE5082@sirena.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Onkalo Samu <samu.p.onkalo@nokia.com>, linux-input@vger.kernel.org

On Fri, Oct 09, 2009 at 01:12:02PM +0100, Mark Brown wrote:
> On Fri, Oct 09, 2009 at 03:02:59PM +0300, Onkalo Samu wrote:
> 
> > I would like to change the polling rate of the polled input device
> > on the fly depending on the use case. One possible way is to directly
> > modify poll_interval from my driver. However, I would like to introduce
> > functions which can be used to set / get polling rate like 
> 
> > input_polled_device_set_rate(...)
> 
> > input_polled_device_get_rate(...)
> 
> > Another missing thing is an indication when the polled device is closed.
> > This can be used to turn off the HW which is not used anymore.
> 

The reason that this is missing is because polled devices are expected
to be extremely dumb. Since even many interrupt-driven devices can't be
shut off I did not expect that polled devices would need it.

> > What do you think, is it ok to introduce these additions to the polled
> > input device?
> 
> It'd be really good to have this control exposed to user space in a
> standard fashion.

I'll take the patches.

>  Other devices that generate constant data rates like
> touchscreens could also benefit from it, changing their output rate
> depending on the needs of user space to give a power saving.

Not sure if this belongs to the input core as such. It seems that what
you want here is dynamic power-management which works on the level below
input core (individual devices on particular buses).

-- 
Dmitry
