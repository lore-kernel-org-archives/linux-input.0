From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/1] usb: Remove Vernier devices from lsusb and
 hid_ignore_list
Date: Thu, 28 May 2015 09:24:27 -0700
Message-ID: <20150528162427.GB23837@kroah.com>
References: <555DEEFB.50604@eqware.net>
 <alpine.LNX.2.00.1505281657330.13817@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:49835 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753243AbbE1QYd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 May 2015 12:24:33 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1505281657330.13817@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dennis O'Brien <dennis.obrien@eqware.net>, jminor@vernier.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org

On Thu, May 28, 2015 at 04:58:54PM +0200, Jiri Kosina wrote:
> On Thu, 21 May 2015, Dennis O'Brien wrote:
> 
> > From: Dennis O'Brien <dennis.obrien@eqware.net>
> > 
> > Removes Vernier Software & Technology devices from the ldusb
> > driver and the hid_ignore_list table of the usbhid driver in the
> > Linux tree.  These devices will now be supported via the hidraw
> > driver.
> > 
> > A user space driver for these devices will be found in the
> > Go! Software Development Kit from Vernier at
> > http://www.vernier.com/downloads/software-development-kits/go-sdk/.
> > These devices are also be supported by the LabQuest2 standalone
> > interface shown at http://www.vernier.com/products/interfaces/labq2/
> > and the LoggerPro for Linux software shown at
> > http://www.vernier.com/downloads/logger-pro-linux/.
> 
> Given that the only thing this patch is in principle doing is dropping 
> device support from ldusb driver, I am not applying it before getting Ack 
> from Greg (or even seeing Greg merging it himself through his tree).
> 
> Greg ... ?

No objection from me:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

But if you want me to take it in my tree, I can do that too, just
provide an ack and I will do so.

thanks,

greg k-h
