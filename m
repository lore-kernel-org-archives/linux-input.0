From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH] usbmouse: random freeze/hangup; synchronize irq completion
Date: Tue, 15 Feb 2011 10:04:15 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1102150949520.1852-100000@iolanthe.rowland.org>
References: <201102151130.30998.jordipujolp@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201102151130.30998.jordipujolp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jordi Pujol <jordipujolp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, 15 Feb 2011, Jordi Pujol wrote:

> A Dilluns 14 Febrer 2011 16:00:24, Alan Stern va escriure:
> > 	It calls mutex_lock(), which can sleep, from within an URB
> > 	completion routine, which runs with interrupts disabled.
> > 
> > 	It doesn't synchronize the completion _with_ anything else,
> > 	i.e., it calls mutex_lock() in only one place.
> this routine is synchronized with himself.

No.  The code you added does not perform _any_ additional 
synchronization.  If it did, you'd see a big fat error message in the 
kernel log because the mutex_lock call would try to sleep while in 
interrupt context.

> I said synchronize thinking about synchronized routines that are pieces of 
> code scheduled to be executed only in a single thread simultaneously; 
> therefore a new call to this routine can not be executed until a previous call 
> has been completed.

That is true even without your patch.  Go ahead and add a pair of
debugging printouts to the usb_mouse_irq() routine (without your
patch); print the value of urb upon entry and exit.  You'll see that
there are never two instances of the routine running comcurrently for
the same URB.  In fact, if you have only one USB mouse, you'll see that
there are never two instances of the routine running concurrently at
all.

> > Whatever is causing your problem, this is not the proper solution.
> Yes, that this is not a patch to be included in the kernel, it's only a 
> testing patch, but it solves the hangup. and so this probes that there is some 
> kind of problem related to the urb update process; I think the problem should 
> be external to this routine.
> 
> searching the web, some people has found problems like this, example:
> - [ubuntu] Ubuntu 10.04 (Lucid Lynx) Random Freeze / Hang-up
> 
> Consider this as an idea to point out the problem and, if possible, someone 
> more expert help to look for a good solution.

More to the point, why are you using the usbmouse driver in the first
place?  You should be using usbhid instead.  See the warnings in the
Kconfig help text for USB_MOUSE.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
