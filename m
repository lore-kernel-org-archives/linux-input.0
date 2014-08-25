From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH 1/1] HID: usbhid: add usb_clear_halt determination for
 next hid_start_in
Date: Mon, 25 Aug 2014 10:35:06 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1408251033470.1385-100000@iolanthe.rowland.org>
References: <CAOVJa8F6cn1+pDz09B9LUMinV4iUOiyZn8SEjmx=ttMsWe5+Zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOVJa8F6cn1+pDz09B9LUMinV4iUOiyZn8SEjmx=ttMsWe5+Zg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: vichy <vichy.kuo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mon, 25 Aug 2014, vichy wrote:

> hi Alan:
> >> "usb_unbind_and_rebind_marked_interfaces" is called if config
> >> parameter is not null,
> >> it seems no matter post_reset routine fail or not.
> >
> > Yes, that's right.  I should have said: "Because the post_reset routine
> > failed, usb_unbind_and_rebind_marked_interfaces indirectly calls
> > usbhid_disconnect.
> 
> Even post_reset routine failed,
> usb_unbind_and_rebind_marked_interfaces will still indirectly calls
> usbhid_disconnect, right?

If the pre_reset and post_reset routines both return 0, 
usb_unbind_and_rebind_marked_interfaces will _not_ call 
usbhid_disconnect.  Otherwise it will.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
