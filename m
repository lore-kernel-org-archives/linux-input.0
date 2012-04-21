From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] hid: usbhid: fix possible deadlock in __usbhid_submit_report
Date: Sat, 21 Apr 2012 12:25:05 +0200
Message-ID: <201204211225.05846.oliver@neukum.org>
References: <Pine.LNX.4.44L0.1204202032530.19313-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1204202032530.19313-100000-pYrvlCTfrz9XsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Ming Lei <ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Am Samstag, 21. April 2012, 02:37:35 schrieb Alan Stern:
> On Fri, 20 Apr 2012, Oliver Neukum wrote:
> 
> > As I said, I'd very much appreciate sane semantics for usb_unlink_urb().
> 
> Aside from the practicality issue of altering a large number of
> existing drivers, changing the semantics the way you want would be
> difficult because it would force the HCDs to defer some giveback
> operations to a bottom half or timer routine.

Or a work queue, which would have to be dedicated to avoid deadlocks
with storage.

> Think about what happens if the URB being unlinked hasn't been
> presented to the hardware yet.  Once it has been removed from the HCD's
> internal lists, there's no reason not to give it back right away.  And
> there's no natural time to give it back later.

Now. The question is not when, but from which context.
The context should be uniform, so that the requirements
for locking should also be uniform.

	Regards
		Oliver
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
