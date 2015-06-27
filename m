From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH][RFC] usbhid: enable autosuspend for internal devices
Date: Fri, 26 Jun 2015 18:29:59 -0700
Message-ID: <20150627012959.GA15207@kroah.com>
References: <20150626221517.GB2761@kroah.com>
 <Pine.LNX.4.44L0.1506262113240.31192-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1506262113240.31192-100000@netrider.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Tom Gundersen <teg@jklm.no>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
List-Id: linux-input@vger.kernel.org

On Fri, Jun 26, 2015 at 09:20:19PM -0400, Alan Stern wrote:
> On Fri, 26 Jun 2015, Greg Kroah-Hartman wrote:
> 
> > > This doesn't do what the patch title says.  USB_DEVICE_FIXED means that
> > > the device can't be unplugged from its upstream port.  It doesn't mean
> > > the device is internal to the computer.
> > > 
> > > As an example, consider a composite Apple keyboard, which has an
> > > internal 3-port USB hub where two of the hub's ports are exposed on the
> > > edge of the keyboard case and the keyboard controller is permanently
> > > attached to the third hub port.  Then the controller device would be
> > > marked USB_DEVICE_FIXED, even though the whole thing is external to
> > > the computer and can be unplugged.
> > > 
> > 
> > Is that really how those devices are marked?  I can't find any of my
> > keyboard with hubs that mark things that way.
> 
> My Apple keyboard isn't here at the moment, and I don't remember
> exactly what its hub descriptor contains.  In theory, it _should_ mark
> the permanently attached port as non-removable.
> 
> I can test it next week, if you would like to see the actual values.

That would be great.

> > > Also, are you really certain this is safe?  Aren't there a number of 
> > > built-in keyboards that will work badly if you allow them to 
> > > autosuspend?
> > 
> > udev has been doing this for a while now by default, with no reports of
> > problems, so I think we should be safe.
> 
> I thought udev used a whitelist of devices known to work okay with 
> autosuspend.  Does it really turn on autosuspend for _every_ USB HID 
> device that is marked as removable?

Yes, it had a tiny whitelist of 3-4 devices, and then would turn on
autosuspend for anything not marked as removable or unknown.  Look at
/usr/lib/udev/rules.d/42-usb-hid-pm.rules on your system for them, it's
these lines:
	ACTION=="add", SUBSYSTEM=="usb", SUBSYSTEMS=="usb", ATTR{../removable}=="removable", GOTO="usb_hid_pm_end"
	ACTION=="add", SUBSYSTEM=="usb", SUBSYSTEMS=="usb", ATTR{../removable}=="unknown", GOTO="usb_hid_pm_end"

> (Come to think of it, given the bug in the hub driver, no device 
> attached directly to the root hub will _ever_ be marked as removable 
> AFAICS.  So maybe that bug is masking possible regressions.)

Maybe that's the issue, don't know, it would be good to figure out as
upstream udev just deleted that whole rules file :)

thanks,

greg k-h
