From: Jan-Hendrik Zab <jan@jhz.name>
Subject: Re: Add Sony Vaio VPCZ1 series to the nopnp table
Date: Thu, 22 Apr 2010 11:09:05 +0200
Message-ID: <20100422090905.GA89708@jhz.name>
References: <20100329233257.GA85504@jhz.name>
 <20100421070158.GM4364@core.coreip.homeip.net>
 <20100421081048.GA22357@core.coreip.homeip.net>
 <201004211035.38264.bjorn.helgaas@hp.com>
 <20100421170750.GA10566@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from red.unix-ag.uni-hannover.de ([130.75.176.204]:56257 "EHLO
	jhz.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753165Ab0DVJJV (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 22 Apr 2010 05:09:21 -0400
Content-Disposition: inline
In-Reply-To: <20100421170750.GA10566@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, torvalds@linux-foundation.org, linux-input@vger.kernel.org

On 21/04/10 10:07 -0700, Dmitry Torokhov wrote:
> On Wed, Apr 21, 2010 at 10:35:37AM -0600, Bjorn Helgaas wrote:
> > I think this makes sense, but I think we should also adjust the loop
> > at the end of pnpacpi_add_device() that adds all the CIDs.  As it
> > currently works, I think your patch will cause this device to have
> > two copies of the CID, e.g.,
> > 
> >   PNP0F13 PNP0F13
> > 
> 
> Yep, you are right. I will adjust it after I hear from Jan whether it
> fixes his issue.

Hey,
sorry for the delay. Your patch fixes the problem on my system.

	-jhz
