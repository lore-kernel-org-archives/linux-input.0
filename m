From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH] HID: usbhid: get/put around clearing needs_remote_wakeup
Date: Thu, 13 Nov 2014 16:18:47 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1411131611001.945-100000@iolanthe.rowland.org>
References: <CANLzEksGg0KyWOS+WYv_U8GzSJ4C_H0LTpdXvz8Ae-8mH6K41w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CANLzEksGg0KyWOS+WYv_U8GzSJ4C_H0LTpdXvz8Ae-8mH6K41w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benson Leung <bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sameer Nanda <snanda-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Thu, 13 Nov 2014, Benson Leung wrote:

> On Thu, Nov 13, 2014 at 12:41 PM, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org> wrote:
> > usbhid_stop probably doesn't need it.  And it should be possible to fix
> > usbhid_close more easily just by interchanging the two lines:
> >
> > -                       usb_kill_urb(usbhid->urbin);
> >                         usbhid->intf->needs_remote_wakeup = 0;
> > +                       usb_kill_urb(usbhid->urbin);
> >
> > Have you tried this?
> 
> Yes, I tried that as well, and that does work.
> 
> I used the get/put because that's the way it was done in other
> drivers, for example in synusb_close() in
> drivers/input/mouse/synaptics_usb.c

In the patch description, you wrote:

> When a usbhid device that does not support remote wake
> ( i.e. !device_can_wakeup() ) is closed, we fail out of
> autosuspend_check() because the autosuspend check is called
> before the flag is cleared as a result of usb_kill_urb(usbhid->urbin);

If you interchange the two lines then the flag _will_ be cleared before
usb_kill_urb() and autosuspend_check() can run.  This means your patch
description is bogus.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
