From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] Input: add appleir USB driver
Date: Thu, 15 May 2008 11:41:27 -0700
Message-ID: <20080515184127.GC15231@kroah.com>
References: <20080514221519.GA6575@kroah.com> <20080515134046.GA9529@dose.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:50658 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753148AbYEOTuF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 May 2008 15:50:05 -0400
Content-Disposition: inline
In-Reply-To: <20080515134046.GA9529@dose.home.local>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, jkosina@suse.cz, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, May 15, 2008 at 03:40:46PM +0200, Tino Keitel wrote:
> On Wed, May 14, 2008 at 15:15:19 -0700, Greg KH wrote:
> > From: Greg Kroah-Hartman <gregkh@suse.de>
> > 
> > This driver was originally written by James McKenzie but forward ported
> > and cleaned up by me to get it to work with modern kernel versions.
> > 
> > Tested on my mac mini and it actually works!
> 
> Did you test suspend to RAM? Last time I used the original driver, I
> had to reload it after resume, otherwise LIRC didn't receive events
> anymore.

Yes, suspend to ram did seem to work for me with this driver.  But I
haven't tested that in a while, will do so later today.

I don't use LIRC though, so I really can not speak for that chunk of
code at all.

thanks,

greg k-h
