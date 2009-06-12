From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: Apple Bluetooth devices: Battery level?
Date: Fri, 12 Jun 2009 15:31:20 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0906121529210.7457@wotan.suse.de>
References: <1244384236.30768.5690.camel@cookie.hadess.net>  <alpine.LRH.2.00.0906081530330.31685@twin.jikos.cz> <1244642769.2690.51.camel@cookie.hadess.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1244642769.2690.51.camel-MYKcRh6MmTE/Ra3EetS/fF6hYfS7NtTn@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Cc: linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Wed, 10 Jun 2009, Bastien Nocera wrote:

> > Could you please obtain HID debug dump (CONFIG_HID_DEBUG + modprobe 
> > hid module with 'debug=2') and look at this usage both in the report 
> > descriptor itself, and also check whether it is present in the 
> > received reports?
> This is the debug output:
> http://pastebin.com/m256a4187
> Doesn't look very useful, and I have no idea what the 00ff.00c0 part 
> does.

It doesn't seem to be sending the battery level in a standard-compliant 
way, at least according to these reports.

Could you also please post the report descriptor data? They should appear 
in a hid debugging mode once the mouse is connected.

Does 00ff.00c0 usage change it's value if you put different batteries into 
the mouse?

If this is not successful, looking at what the driver in other operating 
system does on the transport level might be an option.

-- 
Jiri Kosina
SUSE Labs
