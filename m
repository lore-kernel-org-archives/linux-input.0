From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 2/2] intel_mid_touch: Resync upstream with the
	development tree
Date: Wed, 1 Sep 2010 08:04:36 -0700
Message-ID: <20100901150436.GA26228@kroah.com>
References: <20100825142200.2831.42013.stgit@localhost.localdomain> <20100825142217.2831.18768.stgit@localhost.localdomain> <20100831221748.GD14846@kroah.com> <20100901062305.GE23585@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:40103 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753731Ab0IAPGH (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 1 Sep 2010 11:06:07 -0400
Content-Disposition: inline
In-Reply-To: <20100901062305.GE23585@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Alan Cox <alan@linux.intel.com>, linux-input@vger.kernel.org

On Tue, Aug 31, 2010 at 11:23:05PM -0700, Dmitry Torokhov wrote:
> On Tue, Aug 31, 2010 at 03:17:48PM -0700, Greg KH wrote:
> > On Wed, Aug 25, 2010 at 03:22:22PM +0100, Alan Cox wrote:
> > > This merges bits from the two diverging trees including code by Andy Ross
> > > and Arjan van de Ven
> > 
> > But it doesn't apply to my staging tree, odd.
> > 
> > Care to respin it against linux-next?  Is there something in linux-next
> > from Dmitry for this driver that might be getting me confused here?
> 
> Well, I collected all patches from Alan and applied to my
> mrst-touchscreen branch (based off 2.6.35) and added a patch moving it
> out of staging and into input. Please take a look and if you do not see
> any issues I'll merge it into my 'next' branch for .37.

Ah, that's great, sorry, I didn't realize this.

> BTW, I took the liberty of tagging the move patch as Acked-by by both of you
> so please shout if you disagree.

It's fine by me, thanks for doing this.

greg k-h
