From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] HID: add quirk for Freescale i.MX23 ROM recovery
Date: Mon, 14 Jan 2013 12:58:21 -0800
Message-ID: <20130114205821.GA24751@kroah.com>
References: <1353734157-9119-1-git-send-email-marex@denx.de>
 <alpine.LNX.2.00.1211261421050.12570@pobox.suse.cz>
 <201301122122.48856.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:53761 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758783Ab3ANU6Y (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Jan 2013 15:58:24 -0500
Content-Disposition: inline
In-Reply-To: <201301122122.48856.marex@denx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, Chen Peter <B29397@freescale.com>

On Sat, Jan 12, 2013 at 09:22:48PM +0100, Marek Vasut wrote:
> Hi Jirka,
> 
> > On Sat, 24 Nov 2012, Marek Vasut wrote:
> > > The USB recovery mode present in i.MX23 ROM emulates USB HID.
> > > It needs this quirk to behave properly.
> > > 
> > > Even if the official branding of the chip is Freescale i.MX23,
> > > I named it Sigmatel STMP3780 since that's what the chip really
> > > is and it even reports itself as STMP3780.
> > 
> > Applied, thanks Marek.
> 
> Can we possibly push this into -stable please?

What is the git commit id of it in Linus's tree?  I need that before it
can go into a stable release.

thanks,

greg k-h
