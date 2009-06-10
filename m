From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: Apple Bluetooth devices: Battery level?
Date: Wed, 10 Jun 2009 10:25:17 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0906101023460.7457@wotan.suse.de>
References: <1244384236.30768.5690.camel@cookie.hadess.net>  <alpine.LRH.2.00.0906081530330.31685@twin.jikos.cz> <1244589738.5973.1954.camel@cookie.hadess.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1244589738.5973.1954.camel-MYKcRh6MmTE/Ra3EetS/fF6hYfS7NtTn@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Cc: linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Wed, 10 Jun 2009, Bastien Nocera wrote:

> > > I just got an Apple Bluetooth Mighty Mouse, and was wondering whether 
> > > anyone had information on how to get the battery level from the device 
> > > (the keyboard apparently also allows that): 
> > > http://support.apple.com/kb/TA27118?viewlocale=en_US
> > > Anyone with an idea? An unparsed HID event? Does it need "poking"?
> > If the mouse is standard-compliant, it should be sending the battery level 
> > strength in usage 0x20 of device controls page (0x06).
> > Could you please obtain HID debug dump (CONFIG_HID_DEBUG + modprobe hid 
> > module with 'debug=2')
> I found that for pretty much all the input problems, I'd need to do
> something like that. Problem is:
> - enabling CONFIG_HID_DEBUG requires rebuilding the kernel

CONFIG_HID_DEBUG has 'default y' for quite some time, but the defconfigs 
haven't unfortunately been updated yet.

> - most distributions build hid into the kernel

hid.debug=2 on the kernel commandline option does the trick.

> Wouldn't there be a way to enable the debug at run-time without 
> impacting too much on performance or binary size?

Absolutely. I have a migration of all this stuff to debugfs on my TODO 
list.

Thanks,

-- 
Jiri Kosina
SUSE Labs
