From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [patch]fix usbhid using GFP_KERNEL in interrupt
Date: Mon, 21 Sep 2009 23:42:47 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0909212340020.17028@wotan.suse.de>
References: <200909212225.48513.oliver@neukum.org> <4AB7E331.8050209@gmail.com> <200909212237.19281.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:45925 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752065AbZIUVmo (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Sep 2009 17:42:44 -0400
In-Reply-To: <200909212237.19281.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Henk Martijn <h.h.martijn@gmail.com>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, Greg KH <gregkh@suse.de>

On Mon, 21 Sep 2009, Oliver Neukum wrote:

> > > hid:usbhid: fix wrong use of GFP_KERNEL
> > >
> > > hid_input_report() must be told it is called in interrupt context
> > >
> > > Signed-off-by: Oliver Neukum <oliver@neukum.org>
> > >
> > > Hi Jiri, Greg,
> > >
> > > this should go into the current tree and the stable tree.
> >
> > Stable? Interestingly I did not have any problems with 2.6.31......
> 
> OK, Greg, hold your fire. Jiri is this necessary in stable?

Hi,

no, it's not. 2.6.31 doesn't do any allocation in hid_input_report(), this 
is new with HID debugging through debugfs that went to Linus in 2.6.32 
merge window.

The fix for this particular problem is already on its way upstream, 
waiting for Linus to pull.

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
