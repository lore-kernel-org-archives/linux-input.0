From: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH][RFC] usbhid: enable autosuspend for internal devices
Date: Sat, 27 Jun 2015 08:31:30 -0700
Message-ID: <20150627153130.GA19417@kroah.com>
References: <20150626221517.GB2761@kroah.com>
 <Pine.LNX.4.44L0.1506262113240.31192-100000@netrider.rowland.org>
 <20150627012959.GA15207@kroah.com>
 <alpine.LNX.2.00.1506270825010.10183@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1506270825010.10183-ztGlSCb7Y1iN3ZZ/Hiejyg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Tom Gundersen <teg-B22kvLQNl6c@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Sat, Jun 27, 2015 at 08:29:16AM +0200, Jiri Kosina wrote:
> On Fri, 26 Jun 2015, Greg Kroah-Hartman wrote:
> 
> > > I thought udev used a whitelist of devices known to work okay with 
> > > autosuspend.  Does it really turn on autosuspend for _every_ USB HID 
> > > device that is marked as removable?
> > 
> > Yes, it had a tiny whitelist of 3-4 devices, and then would turn on
> > autosuspend for anything not marked as removable or unknown.  Look at
> > /usr/lib/udev/rules.d/42-usb-hid-pm.rules on your system for them, it's
> > these lines:
> > 	ACTION=="add", SUBSYSTEM=="usb", SUBSYSTEMS=="usb", ATTR{../removable}=="removable", GOTO="usb_hid_pm_end"
> > 	ACTION=="add", SUBSYSTEM=="usb", SUBSYSTEMS=="usb", ATTR{../removable}=="unknown", GOTO="usb_hid_pm_end"
> > 
> > > (Come to think of it, given the bug in the hub driver, no device 
> > > attached directly to the root hub will _ever_ be marked as removable 
> > > AFAICS.  So maybe that bug is masking possible regressions.)
> > 
> > Maybe that's the issue, don't know, it would be good to figure out as
> > upstream udev just deleted that whole rules file :)
> 
> Last time we were testing this, autosuspend for USB HID devices was quite 
> a disaster.
> 
> Do you have any idea whether udev developers tested the "autosuspend on by 
> default for USB HID devices" on reasonable set of devices?

That's accidentally turned on for all HID devices due to a bug in a udev
rule in the latest version of udev/systemd and yes, it is a trainwreck.
We can't do that at all, we need a real whitelist.  Because of that, the
udev developers wanted to just delete the whole rule file as it should
be done in a real whitelist.

But I noticed that it did have the 'autosuspend for connected devices'
was in the udev rule file that was removed, and it had been there for a
while, so we should add that to the kernel as we don't want to degrade
in power usage if possible.

> The culrpits that I remember from top of my head (it's been long time 
> ago):
> 
> - the LEDs for suspended device go off. This is very confusing at least on 
>   keyboards, and brings really bad user experience
> 
> - many keyboards were losing first keystroke when waking up from suspend. 
>   We've been debugging this with Alan, and never root-caused it to a 
>   problem in our code, it seems to be the property of the HW
> 
> I really do want to keep the autosuspend disabled by default on USB HID 
> devices (at least keyboards), and enable it based on whitelist. If udev is 
> not going to do this any more, I am afraid we'll have to move the default 
> into the kernel.

We can add the whitelist to udev, that's the way to do it, but that's
not what this patch does.  Or at least that's not what it should be
doing :)

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
