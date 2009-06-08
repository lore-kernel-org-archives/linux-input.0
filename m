From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: Apple Bluetooth devices: Battery level?
Date: Mon, 8 Jun 2009 15:33:34 +0200 (CEST)
Message-ID: <alpine.LRH.2.00.0906081530330.31685@twin.jikos.cz>
References: <1244384236.30768.5690.camel@cookie.hadess.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1244384236.30768.5690.camel-MYKcRh6MmTE/Ra3EetS/fF6hYfS7NtTn@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Cc: linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Sun, 7 Jun 2009, Bastien Nocera wrote:

> I just got an Apple Bluetooth Mighty Mouse, and was wondering whether 
> anyone had information on how to get the battery level from the device 
> (the keyboard apparently also allows that): 
> http://support.apple.com/kb/TA27118?viewlocale=en_US
> 
> Anyone with an idea? An unparsed HID event? Does it need "poking"?

If the mouse is standard-compliant, it should be sending the battery level 
strength in usage 0x20 of device controls page (0x06).

Could you please obtain HID debug dump (CONFIG_HID_DEBUG + modprobe hid 
module with 'debug=2') and look at this usage both in the report 
descriptor itself, and also check whether it is present in the received 
reports?

Thanks,

-- 
Jiri Kosina
SUSE Labs
