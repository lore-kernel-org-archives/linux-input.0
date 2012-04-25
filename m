From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH] hid: usbhid: fix possible deadlock in __usbhid_submit_report
Date: Wed, 25 Apr 2012 11:19:18 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1204251113330.1471-100000@iolanthe.rowland.org>
References: <201204251252.55901.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201204251252.55901.oneukum-l3A5Bk7waGM@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
Cc: Ming Lei <ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, 25 Apr 2012, Oliver Neukum wrote:

> From 9ff6b78dc59c98b9844dc9922549fd338828a889 Mon Sep 17 00:00:00 2001
> From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
> Date: Wed, 25 Apr 2012 12:50:37 +0200
> Subject: [PATCH] usbhid: prevent deadlock during timeout
> 
> On some HCDs usb_unlink_urb() can directly call the
> completion handler. That limits the spinlocks that can
> be taken in the handler to locks not held while calling
> usb_unlink_urb()
> To prevent a race with resubmission, this patch exposes
> usbcore's infrastructure for blocking submission, uses it
> and so drops the lock without causing a race in usbhid.

Simply preventing resubmission is a good idea.

> Signed-off-by: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
> ---
>  drivers/hid/usbhid/hid-core.c |   61 +++++++++++++++++++++++++++++++++++++----
>  drivers/usb/core/urb.c        |   30 ++++++++++++++++++++
>  include/linux/usb.h           |    2 +
>  3 files changed, 87 insertions(+), 6 deletions(-)

This should be split into two patches: one for usbhid and one for 
usbcore.

> +void usb_block_urb(struct urb *urb)
> +{
> +        if (!urb)
> +                return;
> +
> +        atomic_inc(&urb->reject);
> +}
> +EXPORT_SYMBOL_GPL(usb_block_urb);

Personally, I prefer

	if (urb)
		atomic_inc(&urb->reject);

It's a matter of taste; do what you want.

> +void usb_unblock_urb(struct urb *urb)
> +{
> +        if (!urb)
> +                return;
> +
> +        atomic_dec(&urb->reject);
> +}
> +EXPORT_SYMBOL_GPL(usb_unblock_urb);

As was pointed out, this could be eliminated by...

> +
> +/**
>   * usb_kill_anchored_urbs - cancel transfer requests en masse
>   * @anchor: anchor the requests are bound to
>   *
> diff --git a/include/linux/usb.h b/include/linux/usb.h
> index 73b68d1..23df8ae 100644
> --- a/include/linux/usb.h
> +++ b/include/linux/usb.h
> @@ -1379,6 +1379,8 @@ extern int usb_unlink_urb(struct urb *urb);
>  extern void usb_kill_urb(struct urb *urb);
>  extern void usb_poison_urb(struct urb *urb);
>  extern void usb_unpoison_urb(struct urb *urb);
> +extern void usb_block_urb(struct urb *urb);
> +extern void usb_unblock_urb(struct urb *urb);

changing this to

#define usb_unblock_urb usb_unpoison_urb

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
