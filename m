From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: New USB core API to change interval and max packet size
Date: Wed, 2 Oct 2013 12:38:14 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1310021234510.1293-100000@iolanthe.rowland.org>
References: <20131002131550.38f90611@samsung.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131002131550.38f90611-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mauro Carvalho Chehab <m.chehab-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Xenia Ragiadakou <burzalodowa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, 2 Oct 2013, Mauro Carvalho Chehab wrote:

> > > So, there's no need to call usb_change_ep_bandwidth().
> > 
> > That's right.
> > 
> > > If so, then usb_change_ep_bandwidth() as a quirk, if bInterval
> > > or wMaxPacketSize were improperly filled.
> > > 
> > > Right?
> > 
> > Or if the values are correct, but the driver wants to use something 
> > different for its own reasons (for example, to get lower latency or 
> > because it knows that it will never use packets as large as the 
> > descriptor allows).  Right.
> 
> Ok, so, in this case, usb_change_ep_bandwidth() could be called
> just before usb_alloc_urb(), in order to make it to use the packet
> size that would be expected for that kind of ISOC traffic that
> userspace indirectly selected, by adjusting the streaming
> video resolution selected, right?

We haven't decided on the final API yet.  However, note that
usb_alloc_urb() doesn't depend on the packet size.  It requires you to
specify only the number of packets, not their sizes.  Therefore it
doesn't matter whether you call usb_change_ep_bandwidth() before or
after usb_alloc_urb().

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
