From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: new modular hid?
Date: Tue, 13 Jan 2009 01:08:51 -0800
Message-ID: <20090113010658.ZZRA012@mailhub.coreip.homeip.net>
References: <496BA275.1080504@msgid.tls.msk.ru> <alpine.LRH.1.10.0901130052180.24105@twin.jikos.cz> <20090112213924.ZZRA012@mailhub.coreip.homeip.net> <alpine.LNX.1.10.0901130939290.5377@jikos.suse.cz> <alpine.LNX.1.10.0901130958230.5377@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.25]:30896 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754554AbZAMJJd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Jan 2009 04:09:33 -0500
Received: by qw-out-2122.google.com with SMTP id 3so10118983qwe.37
        for <linux-input@vger.kernel.org>; Tue, 13 Jan 2009 01:09:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.10.0901130958230.5377@jikos.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Michael Tokarev <mjt@tls.msk.ru>, linux-input <linux-input@vger.kernel.org>, Jiri Slaby <jslaby@suse.cz>

On Tue, Jan 13, 2009 at 10:00:52AM +0100, Jiri Kosina wrote:
> On Tue, 13 Jan 2009, Jiri Kosina wrote:
> 
> > > I would agree with Michael here, it looks like we went a bit overboard 
> > > with HID quirks. I think sensible solution would be to merge quirks into 
> > > 3-4 files (one per device type) and maybe even compile keyboard quirks 
> > > into hid core.
> > It might seem a too bit too much fine-grained right now, but my 
> > longer-term plan was to have more sophisticated drivers also register 
> > themselves to the HID bus, make use of the common parser, etc (Wacom comes 
> > to mind, for example). 
> > Having the quirks grouped together rather than nicely separate would then 
> > bring us close to the previous total mess, when unrelated quirks were 
> > glued together randomly in the spaghetti-code-way, which I really would 
> > like to avoid as much as possible, it started to become unmaintainable.
> 
> That being said, we of course need to think about the initrd issue brought 
> up by Michael.
> 
> Compiling everything into single driver back again in the end would of 
> course be a solution, but I am afraid that it'd be quite difficult with 
> the bus infrastructure in place.

Not everything, just keyboards so they work even if userspace is not
quite there yet. We just need to make sure we initialize hid bus before
we register sub-drivers.

-- 
Dmitry
