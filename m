From: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Subject: Re: Apple Bluetooth devices: Battery level?
Date: Wed, 10 Jun 2009 15:25:43 +0100
Message-ID: <1244643943.2690.76.camel@cookie.hadess.net>
References: <1244384236.30768.5690.camel@cookie.hadess.net>
	 <alpine.LRH.2.00.0906081530330.31685@twin.jikos.cz>
	 <1244589738.5973.1954.camel@cookie.hadess.net>
	 <alpine.LNX.2.00.0906101023460.7457@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LNX.2.00.0906101023460.7457-B4tOwbsTzaBolqkO4TVVkw@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Cc: linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Wed, 2009-06-10 at 10:25 +0200, Jiri Kosina wrote:
> On Wed, 10 Jun 2009, Bastien Nocera wrote:
<snip>
> > - enabling CONFIG_HID_DEBUG requires rebuilding the kernel
> 
> CONFIG_HID_DEBUG has 'default y' for quite some time, but the defconfigs 
> haven't unfortunately been updated yet.
> 
> > - most distributions build hid into the kernel
> 
> hid.debug=2 on the kernel commandline option does the trick.

Or "echo 2 > /sys/modules/hid/parameters/debug" at run-time.

Seems CONFIG_HID_DEBUG is enabled by default in the builds I use as
well, so I'll quit complaining about that :)

Cheers
