From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] USB: remove info() macro from usb input drivers
Date: Fri, 10 Oct 2008 08:52:21 -0700
Message-ID: <20081010155221.GC20231@kroah.com>
References: <20081010050305.GA32476@kroah.com> <20081010134207.GA10688@anvil.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:53550 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1760153AbYJJQBF (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Oct 2008 12:01:05 -0400
Content-Disposition: inline
In-Reply-To: <20081010134207.GA10688@anvil.corenet.prv>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org

On Fri, Oct 10, 2008 at 09:42:07AM -0400, Dmitry Torokhov wrote:
> On Thu, Oct 09, 2008 at 10:03:05PM -0700, Greg KH wrote:
> > From: Greg Kroah-Hartman <gregkh@suse.de>
> > 
> > USB should not be having it's own printk macros, so remove info() and
> > use the system-wide standard of dev_info() wherever possible.
> > 
> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> > 
> > ---
> > Dmitry, this has been in the USB tree for a few months now, sorry for
> > not sending it to you sooner.  I can easily keep it in my tree and send
> > it to Linus for this merge if you want me to, or you can take it in your
> > tree, which ever you want me to do.
> > 
> 
> Greg, just push it through your tree since it's already there. I don't
> think we have any clashes in this code.

Great, thanks for letting me know.

greg k-h
