From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [PATCH] Fix genius pensketch 12x9 tablet
Date: Sat, 13 Dec 2008 14:30:09 +0100 (CET)
Message-ID: <alpine.LNX.1.10.0812131429350.21089@jikos.suse.cz>
References: <1229150548.11171.6.camel@molly>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1229150548.11171.6.camel@molly>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matt Helsley <matt.helsley-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Fri, 12 Dec 2008, Matt Helsley wrote:

> The Genius PenSketch 12x9 tablet has a puck (labeled a "Tablet Mouse") 
> in addition to a pen. Without registering a quirk the tablet appears to 
> be a single input device that reports the wrong axis information in 
> /proc/bus/input/devices, and sends incorrect events (e.g. ABS_Z instead 
> of ABS_Y). This information confuses the X evdev driver and makes the 
> device impossible to use.
> The quirk fixes events and splits the device into multiple input
> event devices so that at least the puck is useful.

I have applied the patch to HID tree, thanks a lot Matt.

-- 
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
