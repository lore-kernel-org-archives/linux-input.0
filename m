From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] Wakeup for PNP
Date: Wed, 3 Mar 2010 10:29:09 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1003031019040.2821-100000@iolanthe.rowland.org>
References: <20100302213105.GB13499@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:36963 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751709Ab0CCP3L (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Mar 2010 10:29:11 -0500
In-Reply-To: <20100302213105.GB13499@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Li Shaohua <shaohua.li@intel.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-input@vger.kernel.org

On Tue, 2 Mar 2010, Dmitry Torokhov wrote:

> > @@ -656,7 +658,7 @@ static struct pnp_device_id pnp_kbd_devi
> >  };
> >  
> >  static struct pnp_driver i8042_pnp_kbd_driver = {
> > -	.name           = "i8042 kbd",
> > +	.name           = "i8042-kbd",
> 
> Why is this needed? I don't think spaces are more dangerous than a colon
> which we do use...

This string becomes the name of a directory in sysfs.  Having a ' '
character in a directory name just doesn't seem like a good idea; at
the very least it's likely to confuse shell scripts.  (A ':' character
is a lot less subject to misinterpretation.)  I could change the '-' to 
':' if you prefer.

> Other than that - looks reasonable to me...

Thanks.  I'll separate out the driver name change from the rest of the 
patch.

There are a couple of questions remaining.  The patch enables wakeup on 
the i8042-aux device -- is this a good idea?  I haven't tested that 
part of it yet, but we wouldn't want suspended systems waking up just 
because somebody moves the mouse around.  On the other hand, on some 
machines (like mine!) it may not be possible to enable keyboard-wakeup 
without also enabling mouse-wakeup, since they use the same GPE.

Also, the patch effectively tells the kernel that ISAPNP and PNPBIOS 
devices are incapable of issuing wakeup requests.  Is that going to 
cause trouble for people?  Would it be better to change the patch so 
that it doesn't call device_set_wakeup_capable() if 
dev->protocol->can_wakeup isn't defined?

Alan Stern

