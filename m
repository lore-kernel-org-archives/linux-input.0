From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: USB hid blocks USB port in 2.6.28rc3
Date: Wed, 12 Nov 2008 09:53:30 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0811120948480.2336-100000@iolanthe.rowland.org>
References: <20081111210705.GG3810@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20081111210705.GG3810-qrUzlfsMFqo/4alezvVtWx2eb7JE58TQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andi Kleen <andi-Vw/NltI1exuRpAAqCnN02g@public.gmane.org>
Cc: jkosina-AlSwsSmVLrQ@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, 11 Nov 2008, Andi Kleen wrote:

> > It does.  The problem is on the other side: Your power switch presents 
> > itself as an HID device, so when it is _detected_ it binds to usbhid.
> 
> Ok, but it worked in all kernels before. Why has that changed?

I don't know.

> So you're saying that sispm should be changed to not do something?
> What something exactly? And it would work then?

It should be changed either to:

	Not do Set-Configuration, or

	Detach the HID driver before doing the Set-Configuration.

Either of these should allow it to work.

> And why exactly does what it used to do before not work anymore now?

This is a repeat of your first question above.  I still don't know.

If you're interested in finding out the answer, here's what you should
do.  First, as Jiri and I have both suggested, post the contents of
your /proc/bus/usb/devices.  Second, post copies of the full system log
for both old and new kernels with the usbfs_snoop module parameter set.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
