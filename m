From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] HID: add quirk for Freescale i.MX23 ROM recovery
Date: Mon, 14 Jan 2013 22:02:21 +0100
Message-ID: <201301142202.21408.marex@denx.de>
References: <1353734157-9119-1-git-send-email-marex@denx.de> <201301122122.48856.marex@denx.de> <20130114205821.GA24751@kroah.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:57928 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756459Ab3ANVCY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Jan 2013 16:02:24 -0500
In-Reply-To: <20130114205821.GA24751@kroah.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, Chen Peter <B29397@freescale.com>

Hi Greg,

> On Sat, Jan 12, 2013 at 09:22:48PM +0100, Marek Vasut wrote:
> > Hi Jirka,
> > 
> > > On Sat, 24 Nov 2012, Marek Vasut wrote:
> > > > The USB recovery mode present in i.MX23 ROM emulates USB HID.
> > > > It needs this quirk to behave properly.
> > > > 
> > > > Even if the official branding of the chip is Freescale i.MX23,
> > > > I named it Sigmatel STMP3780 since that's what the chip really
> > > > is and it even reports itself as STMP3780.
> > > 
> > > Applied, thanks Marek.
> > 
> > Can we possibly push this into -stable please?
> 
> What is the git commit id of it in Linus's tree?  I need that before it
> can go into a stable release.

This 436136cec650d661eb662fcb508a99878606d050 should be it, right ?

Thank you! I'll remember to supply the ID next time I prod anyone about stable 
stuff.

Best regards,
Marek Vasut
