From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] input: xpad.c - Xbox 360 wireless and sysfs support
Date: Mon, 16 Feb 2009 10:59:14 -0800
Message-ID: <20090216185914.GA6239@kroah.com>
References: <5aa163d00902142008g138826br80d3ea989e7af691@mail.gmail.com> <200902160931.34771.oliver@neukum.org> <5aa163d00902160522r3a22412je3f5202076f57a0a@mail.gmail.com> <20090216161331.GB5008@kroah.com> <5aa163d00902161009l15dae120le96436d40f998d33@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5aa163d00902161009l15dae120le96436d40f998d33-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mike Murphy <mamurph-ZCNwHF9ErpZ2icitjWtXSw@public.gmane.org>
Cc: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mon, Feb 16, 2009 at 01:09:00PM -0500, Mike Murphy wrote:
> On Mon, Feb 16, 2009 at 11:13 AM, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org> wrote:
> ...
> >
> > The bigger question is why are you using a struct kobject in the first
> > place?  As you are a device, just use a struct device.  What are you
> > trying to do in sysfs here to make you want to use a "raw" kobject in a
> > driver?
> >
> > thanks,
> >
> > greg k-h
> >
> 
> The purpose of the struct xpad_data (which contains the struct
> kobject) is to expose parameters that can be read and/or tweaked at
> runtime. At the moment, the adjustable parameters are the size of the
> dead zone around the center of the stick, and the choice of whether to
> map to a square axis. Read-only data include a unique identifier for
> each pad (wireless) and an indication as to whether the wireless pad
> is actually connected.

Then hang those parameters off the struct device you already have.

> The idea behind this interface is to enable a future userspace
> application, likely using HAL and D-BUS, to receive events whenever a
> wireless pad connects, and to identify the particular pad in question
> (specifically, the unique ID of the pad). The user could then, for
> example, have a different dead zone size for each pad, based upon the
> actual manufacturing variations in the sticks on that pad (some appear
> more precise at centering than others). Ideally, this functionality
> could be designed in a "common" way so that the userspace code could
> eventually work with other, non-xpad gaming devices.

Have you documented them in Documentation/ABI?

> I didn't use a struct device because of the existing struct usb_xpad
> that was created on a per-gamepad basis (not necessarily per device,
> as the wireless 360 adapter is one physical device but exposes 4
> gamepads by exposing 4 logical devices [and then each gamepad, in
> turn, is technically a USB hub that can have other stuff
> attached...]).

Put it on the logical device, as given to you.

> I tried not to break existing functionality.  Additionally, struct
> usb_xpad contains two device pointers: one to the actual USB device,
> and one to an input device (see source of the in-tree xpad.c). So I
> followed your kobject.txt documentation and samples to create a new
> object whose sole purpose in life is to expose the sysfs interface,
> without interfering with the existing device entries in the driver.
> I'm not sure I see a clean way to use a single struct device here....

Put it on the input device, which is what is the per-device thing.  It's
much simpler than creating a new struct kobject.  You can even create a
subdirectory for your attributes if you use an attribute group (which
you should be doing anyway, it's much simpler that way.)

And document the attributes please.

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
