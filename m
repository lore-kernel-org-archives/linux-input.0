From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Poll rate change and closing indication to polled input device
Date: Fri, 9 Oct 2009 19:10:12 +0100
Message-ID: <20091009181012.GA21731@sirena.org.uk>
References: <1255089779.28243.24.camel@4fid08082>
 <20091009121201.GE5082@sirena.org.uk>
 <20091009162717.GC1092@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:33700 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932914AbZJISKv (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 9 Oct 2009 14:10:51 -0400
Content-Disposition: inline
In-Reply-To: <20091009162717.GC1092@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Onkalo Samu <samu.p.onkalo@nokia.com>, linux-input@vger.kernel.org

On Fri, Oct 09, 2009 at 09:27:18AM -0700, Dmitry Torokhov wrote:
> On Fri, Oct 09, 2009 at 01:12:02PM +0100, Mark Brown wrote:

> > It'd be really good to have this control exposed to user space in a
> > standard fashion.

> I'll take the patches.

Yes, I was planning on doing some - I've got a touchscreen driver to do
soon and was hoping to have time to look at this while working on that
driver.

> >  Other devices that generate constant data rates like
> > touchscreens could also benefit from it, changing their output rate
> > depending on the needs of user space to give a power saving.

> Not sure if this belongs to the input core as such. It seems that what
> you want here is dynamic power-management which works on the level below
> input core (individual devices on particular buses).

It definitely needs to be implemented in the drivers but they need to
present an interface to userspace which seems best placed in the core to
factor out code and help make sure that the interface is standardised.
