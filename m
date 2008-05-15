From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] Input: add appleir USB driver
Date: Thu, 15 May 2008 11:40:34 -0700
Message-ID: <20080515184034.GB15231@kroah.com>
References: <20080514221519.GA6575@kroah.com> <20080515132108.GA9327@dose.home.local> <20080515094212.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:50655 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752880AbYEOTuD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 May 2008 15:50:03 -0400
Content-Disposition: inline
In-Reply-To: <20080515094212.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: jkosina@suse.cz, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, May 15, 2008 at 09:45:52AM -0400, Dmitry Torokhov wrote:
> Hi Tino,
> 
> On Thu, May 15, 2008 at 03:21:08PM +0200, Tino Keitel wrote:
> > Hi,
> >
> > I'm pretty sure that this breaks the macmini LIRC driver again, see
> > commit 3e1928e8793208802589aae851b6685671187242.
> >
> 
> But with in-kernel driver can't LIRC feed of event device? Ane people
> that dont use LIRC can also have access to the remote?

And, to be blunt, why would an in-kernel driver be concerned about an
out-of-tree-project-that-refuses-to-be-included chunk of code?

thanks,

greg k-h
