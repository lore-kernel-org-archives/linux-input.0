From: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Subject: Re: Apple Bluetooth devices: Battery level?
Date: Wed, 10 Jun 2009 09:03:06 +0200
Message-ID: <1244617386.3068.22.camel@localhost.localdomain>
References: <1244384236.30768.5690.camel@cookie.hadess.net>
	 <alpine.LRH.2.00.0906081530330.31685@twin.jikos.cz>
	 <1244589738.5973.1954.camel@cookie.hadess.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1244589738.5973.1954.camel-MYKcRh6MmTE/Ra3EetS/fF6hYfS7NtTn@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Cc: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Bastien,

> > > I just got an Apple Bluetooth Mighty Mouse, and was wondering whether 
> > > anyone had information on how to get the battery level from the device 
> > > (the keyboard apparently also allows that): 
> > > http://support.apple.com/kb/TA27118?viewlocale=en_US
> > > 
> > > Anyone with an idea? An unparsed HID event? Does it need "poking"?
> > 
> > If the mouse is standard-compliant, it should be sending the battery level 
> > strength in usage 0x20 of device controls page (0x06).
> > 
> > Could you please obtain HID debug dump (CONFIG_HID_DEBUG + modprobe hid 
> > module with 'debug=2')
> 
> I found that for pretty much all the input problems, I'd need to do
> something like that. Problem is:
> - enabling CONFIG_HID_DEBUG requires rebuilding the kernel
> - most distributions build hid into the kernel
> 
> Wouldn't there be a way to enable the debug at run-time without
> impacting too much on performance or binary size?

there is no real downside in having this all times available since you
have to store that binary record somewhere anyway during runtime. We
should fix that and put it into debugfs, but nobody bothered so far
sending a patch for it. If we worry about code size then the decoding
should of the record should be moved into userspace, but in the end it
really doesn't matter that much.

Regards

Marcel
