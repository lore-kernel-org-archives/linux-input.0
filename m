From: Matt Helsley <matt.helsley-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Fix genius pensketch 12x9 tablet
Date: Sat, 13 Dec 2008 01:51:13 -0800
Message-ID: <1229161873.11987.6.camel@molly>
References: <1229150548.11171.6.camel@molly>
	 <20081213075342.GA11346@kroah.com> <1229155530.13862.9.camel@molly>
	 <20081213085556.GB12194@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20081213085556.GB12194-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Sat, 2008-12-13 at 00:55 -0800, Greg KH wrote: 
> On Sat, Dec 13, 2008 at 12:05:30AM -0800, Matt Helsley wrote:
> > On Fri, 2008-12-12 at 23:53 -0800, Greg KH wrote:
> > > On Fri, Dec 12, 2008 at 10:42:28PM -0800, Matt Helsley wrote:
> > > > The Genius PenSketch 12x9 tablet has a puck (labeled a
> > > > "Tablet Mouse") in addition to a pen. Without registering a quirk
> > > > the tablet appears to be a single input device that reports the
> > > > wrong axis information in /proc/bus/input/devices, and sends
> > > > incorrect events (e.g. ABS_Z instead of ABS_Y). This information
> > > > confuses the X evdev driver and makes the device impossible to
> > > > use.
> > > > 
> > > > The quirk fixes events and splits the device into multiple input
> > > > event devices so that at least the puck is useful.
> > > > 
> > > > Signed-off-by: Matt Helsley <matt.helsley-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > > > ---
> > > > NOTE: xinput lists the puck but not the pen. I've been using a
> > > > python script to verify the contents of the events independently
> > > > of X and, as far as I can tell, the remaining problems are in X
> > > > itself.
> > > 
> > > I have a tablet here that I'm having troubles getting to work.  Any
> > > chance I could get a copy of your python script so I can try to debug
> > > what is going wrong, and if it's a X problem or a kernel issue like you
> > > found for your device?
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > Sure. Sometime around 2.6.24 I updated this script (originally by Micah
> > Dowty) to include more evdev #defines, work on 64-bit systems, and
> > decode some bitvectors into their C symbols.
> 
> Thanks, it has helped out, although it doesn't seem to "poll" the device
> properly for some reason to get any events from the device.  I wonder if
> X is grabbing it before this script has a chance to, I'll play around
> with that next...

I've seen that too. If X is running then it intercepts the events
somehow -- not sure if it's a grab or what. I can confirm this by
shutting down X and opening the device with the script from a VT.

Cheers,
	-Matt

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
