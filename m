From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Poll rate change and closing indication to polled input device
Date: Mon, 12 Oct 2009 18:08:42 -0700
Message-ID: <20091013010841.GB21626@core.coreip.homeip.net>
References: <1255089779.28243.24.camel@4fid08082> <20091009121201.GE5082@sirena.org.uk> <20091009162717.GC1092@core.coreip.homeip.net> <20091009181012.GA21731@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f187.google.com ([209.85.216.187]:33362 "EHLO
	mail-px0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891AbZJMBPY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Oct 2009 21:15:24 -0400
Received: by pxi17 with SMTP id 17so11603661pxi.21
        for <linux-input@vger.kernel.org>; Mon, 12 Oct 2009 18:14:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20091009181012.GA21731@sirena.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Onkalo Samu <samu.p.onkalo@nokia.com>, linux-input@vger.kernel.org

On Fri, Oct 09, 2009 at 07:10:12PM +0100, Mark Brown wrote:
> On Fri, Oct 09, 2009 at 09:27:18AM -0700, Dmitry Torokhov wrote:
> > On Fri, Oct 09, 2009 at 01:12:02PM +0100, Mark Brown wrote:
> 
> > > It'd be really good to have this control exposed to user space in a
> > > standard fashion.
> 
> > I'll take the patches.
> 
> Yes, I was planning on doing some - I've got a touchscreen driver to do
> soon and was hoping to have time to look at this while working on that
> driver.
> 
> > >  Other devices that generate constant data rates like
> > > touchscreens could also benefit from it, changing their output rate
> > > depending on the needs of user space to give a power saving.
> 
> > Not sure if this belongs to the input core as such. It seems that what
> > you want here is dynamic power-management which works on the level below
> > input core (individual devices on particular buses).
> 
> It definitely needs to be implemented in the drivers but they need to
> present an interface to userspace which seems best placed in the core to
> factor out code and help make sure that the interface is standardised.

It seems to me that this kind of functionality belongs to PM core.
Userspace probably does not really care about output rate and other
details but rather wants to putsome devices into a low power mode in
general.

-- 
Dmitry
