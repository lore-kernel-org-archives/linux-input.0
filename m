From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v6] Touchscreen driver for FT5x06 based EDT displays
Date: Mon, 25 Jun 2012 18:36:08 -0700
Message-ID: <20120626013608.GC24705@core.coreip.homeip.net>
References: <1333564079-23893-2-git-send-email-simon.budig@kernelconcepts.de>
 <1340408898-491-1-git-send-email-simon.budig@kernelconcepts.de>
 <1340408898-491-2-git-send-email-simon.budig@kernelconcepts.de>
 <20120625085113.GA648@polaris.bitmath.org>
 <4FE82F09.8020203@kernelconcepts.de>
 <20120625113412.GA347@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:40080 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757862Ab2FZBgO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jun 2012 21:36:14 -0400
Received: by pbbrp8 with SMTP id rp8so7320728pbb.19
        for <linux-input@vger.kernel.org>; Mon, 25 Jun 2012 18:36:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120625113412.GA347@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Simon Budig <simon.budig@kernelconcepts.de>, linux-input@vger.kernel.org, olivier@sobrie.be, agust@denx.de, yanok@emcraft.com

Hi Henrik,

On Mon, Jun 25, 2012 at 01:34:12PM +0200, Henrik Rydberg wrote:
> Hi Simon,
> 
> > > I would very much prefer if the driver functioned well without
> > > such settings, since they complicate userspace and are not likely
> > > to ever go away. Oh well.
> > 
> > I would prefer to have the touchscreen adjust itself as well,
> > unfortunately this is not available and you definitely need different
> > settings depending for different touch setups.
> > 
> > Would an ioctl() be more acceptable? Would make it harder to adjust it
> > in startup scripts etc. though.
> 
> The format (ioctl, sysfs or whatnot) is of no consequence, it is the
> a) special handling of certain drivers and b) forcing userspace to
> tune the driver that makes maintenance problematic in the long
> run. With every screen project ending in its own solution, this
> quickly becomes a problem, both in the kernel and in
> userspace. Preventing such predicaments is my concern.

The issue here is that the parameters exposed are truly device-specific
and hard to standardize. We can try adding these parameters to the
platform data so board code could set them up for the users, but I can
see some users wanting to adjust the settings...

Thanks.

-- 
Dmitry
