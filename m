From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Fix genius pensketch 12x9 tablet
Date: Fri, 12 Dec 2008 23:53:42 -0800
Message-ID: <20081213075342.GA11346@kroah.com>
References: <1229150548.11171.6.camel@molly>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1229150548.11171.6.camel@molly>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matt Helsley <matt.helsley-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Fri, Dec 12, 2008 at 10:42:28PM -0800, Matt Helsley wrote:
> The Genius PenSketch 12x9 tablet has a puck (labeled a
> "Tablet Mouse") in addition to a pen. Without registering a quirk
> the tablet appears to be a single input device that reports the
> wrong axis information in /proc/bus/input/devices, and sends
> incorrect events (e.g. ABS_Z instead of ABS_Y). This information
> confuses the X evdev driver and makes the device impossible to
> use.
> 
> The quirk fixes events and splits the device into multiple input
> event devices so that at least the puck is useful.
> 
> Signed-off-by: Matt Helsley <matt.helsley-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
> NOTE: xinput lists the puck but not the pen. I've been using a
> python script to verify the contents of the events independently
> of X and, as far as I can tell, the remaining problems are in X
> itself.

I have a tablet here that I'm having troubles getting to work.  Any
chance I could get a copy of your python script so I can try to debug
what is going wrong, and if it's a X problem or a kernel issue like you
found for your device?

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
