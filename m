From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH][RFC] usbhid: enable autosuspend for internal devices
Date: Fri, 26 Jun 2015 21:20:19 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1506262113240.31192-100000@netrider.rowland.org>
References: <20150626221517.GB2761@kroah.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150626221517.GB2761-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Tom Gundersen <teg-B22kvLQNl6c@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Fri, 26 Jun 2015, Greg Kroah-Hartman wrote:

> > This doesn't do what the patch title says.  USB_DEVICE_FIXED means that
> > the device can't be unplugged from its upstream port.  It doesn't mean
> > the device is internal to the computer.
> > 
> > As an example, consider a composite Apple keyboard, which has an
> > internal 3-port USB hub where two of the hub's ports are exposed on the
> > edge of the keyboard case and the keyboard controller is permanently
> > attached to the third hub port.  Then the controller device would be
> > marked USB_DEVICE_FIXED, even though the whole thing is external to
> > the computer and can be unplugged.
> > 
> 
> Is that really how those devices are marked?  I can't find any of my
> keyboard with hubs that mark things that way.

My Apple keyboard isn't here at the moment, and I don't remember
exactly what its hub descriptor contains.  In theory, it _should_ mark
the permanently attached port as non-removable.

I can test it next week, if you would like to see the actual values.

> > Also, are you really certain this is safe?  Aren't there a number of 
> > built-in keyboards that will work badly if you allow them to 
> > autosuspend?
> 
> udev has been doing this for a while now by default, with no reports of
> problems, so I think we should be safe.

I thought udev used a whitelist of devices known to work okay with 
autosuspend.  Does it really turn on autosuspend for _every_ USB HID 
device that is marked as removable?

(Come to think of it, given the bug in the hub driver, no device 
attached directly to the root hub will _ever_ be marked as removable 
AFAICS.  So maybe that bug is masking possible regressions.)

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
