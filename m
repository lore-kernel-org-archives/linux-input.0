From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH 1/1] HID: usbhid: add usb_clear_halt determination for
 next hid_start_in
Date: Mon, 25 Aug 2014 10:26:26 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1408251025000.1385-100000@iolanthe.rowland.org>
References: <CAOVJa8FT_KvjNS=EPuxNmetmyicDX0jnPOv3A5Hb9rCOiaN47A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOVJa8FT_KvjNS=EPuxNmetmyicDX0jnPOv3A5Hb9rCOiaN47A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: vichy <vichy.kuo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mon, 25 Aug 2014, vichy wrote:

> hi Oliver:
> 
> 2014-08-25 18:21 GMT+08:00 Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>:
> > On Fri, 2014-08-22 at 14:23 -0400, Alan Stern wrote:
> >> On Sat, 23 Aug 2014, vichy wrote:
> >>
> >> > from your patch, I have some questions:
> >> > a. in Alan's version, if both HID_CLEAR_HALT and HID_RESET_PENDING are
> >> > set, hid_reset will both "clear ep halt" and "reset devcie".
> >> > But in original one, even HID_CLEAR_HALT and HID_RESET_PENDING are
> >> > both set, hid_reset only do one of them.
> >>
> >> Yes.  In my patch, the clear-halt handler will turn on the
> >> HID_RESET_PENDING bit if something goes wrong.  In that case we want to
> >> do both things.
> >
> > Why? If we reset, why bother clearing a halt? Especially as this
> > may mean waiting the full 5 seconds for a timeout.
> I think what Alan mean is IF CLEAR HALT fail, we reset the device.
> That is what below "In that case" mean.
>  "In that case we want to do both things."

Exactly.  Suppose initially HID_CLEAR_HALT is set and HID_RESET_PENDING 
is off.  If the usb_clear_halt call fails, we want to recover by 
performing a reset.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
