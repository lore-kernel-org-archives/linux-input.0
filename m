From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input/xen-fbfront: advertise either absolute or relative
 coordinates
Date: Mon, 14 Mar 2011 21:47:08 -0700
Message-ID: <20110315044708.GA1046@core.coreip.homeip.net>
References: <alpine.DEB.2.00.1103111124400.2968@kaball-desktop>
 <20110313062411.GB31566@core.coreip.homeip.net>
 <alpine.DEB.2.00.1103141135170.3382@kaball-desktop>
 <20110314150321.GB11244@dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:47013 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808Ab1COErR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Mar 2011 00:47:17 -0400
Content-Disposition: inline
In-Reply-To: <20110314150321.GB11244@dumpdata.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Stefano Stabellini <stefano.stabellini@eu.citrix.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jeremy Fitzhardinge <jeremy@goop.org>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Olaf Hering <olaf@aepfle.de>

On Mon, Mar 14, 2011 at 11:03:21AM -0400, Konrad Rzeszutek Wilk wrote:
> > > BTW, drivers/input is intended for core input and handlers stuff with
> > > drivers suppsed to be in drivers/input/<type>. Would you mind if I moved
> > > this driver to drivers/input/misc?
> > 
> > I am OK with it.
> > Konrad, any comments on this?
> 
> Go for it! Dmitry, were you thinking to do that for 2.6.39 or 2.6.40?
> 

.39 I guess.

> I've two more patches for xen-fbfront (and one for xen-kbdfront) that I was thinking
> could go for 2.6.39:
> 
> http://lists.colo.xensource.com/archives/html/xen-devel/2011-03/msg00383.html
> 
> oh, and they seemed to have not been posted here. I stuck them 
> in
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/konrad/xen.git #devel/fb_kb_front_use_page_gref
> 
> and was testing them. Do you want me to repost them on LKML with you
> on the CC?
> 

Yes, please.

-- 
Dmitry
