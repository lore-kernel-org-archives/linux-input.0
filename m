From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: new modular hid?
Date: Mon, 12 Jan 2009 21:43:44 -0800
Message-ID: <20090112213924.ZZRA012@mailhub.coreip.homeip.net>
References: <496BA275.1080504@msgid.tls.msk.ru> <alpine.LRH.1.10.0901130052180.24105@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.30]:45978 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752056AbZAMFoY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Jan 2009 00:44:24 -0500
Received: by yw-out-2324.google.com with SMTP id 9so3576234ywe.1
        for <linux-input@vger.kernel.org>; Mon, 12 Jan 2009 21:44:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.LRH.1.10.0901130052180.24105@twin.jikos.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Michael Tokarev <mjt@tls.msk.ru>, linux-input <linux-input@vger.kernel.org>, Jiri Slaby <jslaby@suse.cz>

On Tue, Jan 13, 2009 at 12:54:06AM +0100, Jiri Kosina wrote:
> 
> [ added Jiri Slaby to CC ]
> 
> On Mon, 12 Jan 2009, Michael Tokarev wrote:
> 
> > I tried to run a new (2.6.28) kernel today, to discover that
> > my keyboard does not work anymore.  After investigation it
> > turned out the keyboard is now handled by a hid-sub-driver,
> > hid-bright, and it does not work if this (mostly one-liner)
> > driver module is not loaded.
> >
> > udev/m.i.t works fine, it's the initramfs which is broken.
> > I.e., there's no keyboard during initramfs stage, only when
> > udev runs and loads everything - as much as i hate it, it
> > becomes more and more mandatory, but that's another story.
> > 
> > Before 2.6.28, I used to include usbhid into initramfs.
> > Now, it's not sufficient anymore.
> > 
> > So I've two questions:
> > 
> > 1) which drivers to include into ramfs and load for a
> >  "generic USB keyboard" to work?  Maybe from now on one
> >  have to use usbkbd instead of usbhid?  I just want to
> >  be able to do some rescue stuff before actual system
> >  startup in case a system does not boot for whatever
> >  reason (root fs is corrupt or wrong raid1 replacement
> >  disk or whatever).
> > 
> > 2) why all those tiny "subdrivers" in the first place?
> >  I looked into several of them, and they're mostly sort
> >  of quirks or some additional features or additional key
> >  (re)mapping.  Why can't it all be done in the main driver
> >  instead, just like it is done for PCI bus for example?
> >  The amount of real-work code is tiny, modules are much
> >  bigger - both the resulting .ko files and all the
> >  init/exit wrappers in .c files...
> > 

I would agree with Michael here, it looks like we went a bit
overboard with HID quirks. I think sensible solution would be to
merge quirks into 3-4 files (one per device type) and maybe even
compile keyboard quirks into hid core.

Of course if we see that there are big sub-drivers appear we can
still have them split out.

-- 
Dmitry
