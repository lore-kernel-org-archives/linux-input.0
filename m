From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH] Input: usbtouchscreen - initialize eGalax devices
Date: Fri, 31 Aug 2012 16:04:58 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1208311555140.1328-100000@iolanthe.rowland.org>
References: <20120831192632.GA30202@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120831192632.GA30202-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>, Forest Bond <forest-B/PTSs0AgtP3p6jHtUh95NHuzzzSOjJt@public.gmane.org>, Daniel Ritz <daniel.ritz-OI3hZJvNYWs@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Fri, 31 Aug 2012, Dmitry Torokhov wrote:

> > > +		/* Send a "check active" packet. The response will be read
> > > +		 * later and ignored. */
> > > +		ret = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
> > > +				      0,
> > > +				      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
> > > +				      0, 0, "\x0A\x01A", 0,
> > 
> >    You probably can't send data from the .const section (as well as off the
> > stack) -- they can be DMA'ed and there'll be issues with cache consistency on
> > non-x86 arches. You should allocate the data with kmalloc().
> >    Although, on the second thought, maybe I'm wrong in this case... not really
> > sure about sending -- receiving (to the .data section) could certainly be harmful...
> 
> Hmm, do we actually send anything here? The "size" passed to
> usb_control_msg() is 0 so I don't think we use that data at all...

Good point.  Perhaps the 0 is a typo, in which case data does get sent
and the buffer must be kmalloc'ed.  If the 0 is correct then the buffer
should be NULL, not "\x0A\x01A" (and what's the purpose of the leading
'0' in the second byte?).

In addition, although the bRequestType specifies USB_DIR_OUT, the pipe
value is usb_rcvctrlpipe.  Is this transfer meant to be IN or OUT?

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
