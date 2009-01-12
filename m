From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: new modular hid?
Date: Tue, 13 Jan 2009 00:54:06 +0100 (CET)
Message-ID: <alpine.LRH.1.10.0901130052180.24105@twin.jikos.cz>
References: <496BA275.1080504@msgid.tls.msk.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from twin.jikos.cz ([213.151.79.26]:60298 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752673AbZALXyW (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Jan 2009 18:54:22 -0500
In-Reply-To: <496BA275.1080504@msgid.tls.msk.ru>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: linux-input <linux-input@vger.kernel.org>, Jiri Slaby <jslaby@suse.cz>


[ added Jiri Slaby to CC ]

On Mon, 12 Jan 2009, Michael Tokarev wrote:

> I tried to run a new (2.6.28) kernel today, to discover that
> my keyboard does not work anymore.  After investigation it
> turned out the keyboard is now handled by a hid-sub-driver,
> hid-bright, and it does not work if this (mostly one-liner)
> driver module is not loaded.
>
> udev/m.i.t works fine, it's the initramfs which is broken.
> I.e., there's no keyboard during initramfs stage, only when
> udev runs and loads everything - as much as i hate it, it
> becomes more and more mandatory, but that's another story.
> 
> Before 2.6.28, I used to include usbhid into initramfs.
> Now, it's not sufficient anymore.
> 
> So I've two questions:
> 
> 1) which drivers to include into ramfs and load for a
>  "generic USB keyboard" to work?  Maybe from now on one
>  have to use usbkbd instead of usbhid?  I just want to
>  be able to do some rescue stuff before actual system
>  startup in case a system does not boot for whatever
>  reason (root fs is corrupt or wrong raid1 replacement
>  disk or whatever).
> 
> 2) why all those tiny "subdrivers" in the first place?
>  I looked into several of them, and they're mostly sort
>  of quirks or some additional features or additional key
>  (re)mapping.  Why can't it all be done in the main driver
>  instead, just like it is done for PCI bus for example?
>  The amount of real-work code is tiny, modules are much
>  bigger - both the resulting .ko files and all the
>  init/exit wrappers in .c files...
> 
> Thanks!
> 
> /mjt
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Jiri Kosina
SUSE Labs

