From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: usb/gadget: stalls in dummy_timer
Date: Tue, 12 Sep 2017 10:06:37 -0700
Message-ID: <20170912170637.GA37632@dtor-ws>
References: <CAAeHK+y-gycNCJv3XEZ4hwv_BndB590UWVqCYWd-Y8URDbH+vg@mail.gmail.com>
 <Pine.LNX.4.44L0.1709110920020.27275-100000@netrider.rowland.org>
 <CAAeHK+yMO9v8SeSkqeoDy=FV8gZ9672iDEw3OadHh0cdg-9T_g@mail.gmail.com>
 <CAKdAkRQFmKpKWqh4JenNZcs22D4QZbyo+Rhh9Y5jOQk=z0uKCw@mail.gmail.com>
 <CAAeHK+yDjw3sh=7nCEZTRqHPWUwxKNfQ1-WVq5=K2PWK5E2FFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAAeHK+yDjw3sh=7nCEZTRqHPWUwxKNfQ1-WVq5=K2PWK5E2FFw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrey Konovalov <andreyknvl-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Henrik Rydberg <rydberg-FFUHeuDi6mxAfugRpC6u6w@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>, Yuyang Du <yuyang.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dmitry Vyukov <dvyukov-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Kostya Serebryany <kcc-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, syzkaller <syzkaller-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Tue, Sep 12, 2017 at 05:48:51PM +0200, Andrey Konovalov wrote:
> On Mon, Sep 11, 2017 at 8:54 PM, Dmitry Torokhov
> <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > On Mon, Sep 11, 2017 at 8:15 AM, Andrey Konovalov <andreyknvl-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org> wrote:
> >> On Mon, Sep 11, 2017 at 3:25 PM, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org> wrote:
> >>> On Mon, 11 Sep 2017, Andrey Konovalov wrote:
> >>>
> >>>> Hi!
> >>>>
> >>>> I've been getting stall reports like this one while fuzzing the USB
> >>>> stack with gadgetfs. I'm wondering whether this is a bug in gadgetfs
> >>>> or is this report induced by the changes I've made to the USB core
> >>>> code. I didn't touch gadgetfs code though (except for adding a few
> >>>> printk's).
> >>>>
> >>>> I'm on commit 81a84ad3cb5711cec79f4dd53a4ce026b092c432
> >>>
> >>> It's possible that this was caused by commit f16443a034c7 ("USB:
> >>> gadgetfs, dummy-hcd, net2280: fix locking for callbacks").  I've been
> >>> meaning to repair the commit but haven't done it yet.
> >>>
> >>> Can you test with that commit reverted?  You may end up seeing other
> >>> problems instead -- the ones that commit was intended to solve -- but
> >>> perhaps the stalls won't occur.
> >>
> >> So I've reverted both: the changes I made to USB core and the commit
> >> you mentioned, still saw the stalls.
> >>
> >> I've manged to find a way to reproduce this and now I'm not sure the
> >> problem is actually in gadgetfs, it might be the usbtouchscreen
> >> driver.
> >>
> >> The crash log is below.
> >>
> >> Thanks!
> >>
> >> gadgetfs: bound to dummy_udc driver
> >> usb 1-1: new full-speed USB device number 2 using dummy_hcd
> >> gadgetfs: connected
> >> gadgetfs: disconnected
> >> gadgetfs: connected
> >> usb 1-1: config 8 interface 0 altsetting 9 endpoint 0x8F has an
> >> invalid bInterval 0, changing to 10
> >> usb 1-1: config 8 interface 0 altsetting 9 endpoint 0x8F has invalid
> >> maxpacket 839, setting to 64
> >> usb 1-1: config 8 interface 0 altsetting 9 endpoint 0x7 has invalid
> >> maxpacket 1839, setting to 64
> >> usb 1-1: config 8 interface 0 has no altsetting 0
> >> usb 1-1: New USB device found, idVendor=0403, idProduct=f9e9
> >> usb 1-1: New USB device strings: Mfr=4, Product=8, SerialNumber=255
> >> usb 1-1: Product: a
> >> usb 1-1: Manufacturer: a
> >> usb 1-1: SerialNumber: a
> >> gadgetfs: configuration #8
> >> input: a a as /devices/platform/dummy_hcd.0/usb1/1-1/1-1:8.0/input/input8
> >> evbug: Connected device: input8 (a a at usb-dummy_hcd.0-1/input0)
> >> kworker/0:0: page allocation failure: order:0,
> >> mode:0x1280020(GFP_ATOMIC|__GFP_NOTRACK), nodemask=(null)
> >> kworker/0:0 cpuset=/ mems_allowed=0
> >
> > It seems you are running out of memory.
> >
> >> Swap cache stats: add 0, delete 0, find 0/0
> >> Free swap  = 0kB
> >> Total swap = 0kB
> >
> > And no swap. I think you need to give the box a bit more memory (or
> > there might be a leak somewhere).
> 
> Increasing the amount of memory doesn't help. It looks like
> usbtouch_irq() gets called in an infinite loop, and calls
> usb_submit_urb on each iteration, until the kernel runs out of memory.

Yes, that is exactly how USB interrupt-driven devices work. Their URB
completion routine handles the data and immediately resubmits URB to get
more data. The device/HCD will signal interrupt once more data is
available and the process starts over again. The only time we stop
resubmitting URBs if we get one of the following errors:

	case -ETIME:
		/* this urb is timing out */
		dev_dbg(dev,
			"%s - urb timed out - was the device unplugged?\n",
			__func__);
		return;
	case -ECONNRESET:
	case -ENOENT:
	case -ESHUTDOWN:
	case -EPIPE:
		/* this urb is terminated, clean up */
		dev_dbg(dev, "%s - urb shutting down with status: %d\n",
			__func__, urb->status);
		return;

So I'd start looking into dummy_hcd and see why it does not discard
processed URBs fast enough in your setup.

Thanks.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
