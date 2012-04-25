From: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH] hid: usbhid: fix possible deadlock in __usbhid_submit_report
Date: Wed, 25 Apr 2012 10:08:02 +0200
Message-ID: <201204251008.02537.oneukum@suse.de>
References: <CACVXFVNAZHC2uQCwRak6pRgT1VEgRJt5UTuwAtZM6r_Xdg0dHA@mail.gmail.com> <201204250819.32642.oneukum@suse.de> <CACVXFVMEttnWo34ZxBsm4vdW1y5f5mBjY1s6BVbbsjck-4cSbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACVXFVMEttnWo34ZxBsm4vdW1y5f5mBjY1s6BVbbsjck-4cSbA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ming Lei <ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Am Mittwoch, 25. April 2012, 09:02:58 schrieb Ming Lei:
> On Wed, Apr 25, 2012 at 2:19 PM, Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org> wrote:
> 
> >> @@ -546,8 +557,13 @@ static void __usbhid_submit_report(struct
> >> hid_device *hid, struct hid_report *re
> >>                        * no race because this is called under
> >>                        * spinlock
> >>                        */
> >> -                     if (time_after(jiffies, usbhid->last_out + HZ * 5))
> >> +
> >> +                     if (time_after(jiffies, usbhid->last_out + HZ * 5) &&
> >> +                                     !usbhid->urbout->unlinked) {
> >> +                             spin_unlock(&usbhid->lock);
> >>                               usb_unlink_urb(usbhid->urbout);
> >> +                             spin_lock(&usbhid->lock);
> >> +                     }
> >>               }
> >>               return;
> >>       }
> >
> > Same objection. You are just making the race unlikelier. The flag
> > needs to be set under a lock you hold while checking time_after().
> 
> urb->unlinked is checked with holding both the two lockes, but set with
> holding the unlink lock or the lock or both, looks it is enough to
> avoid the race, isn't it?

That would work. Yet, having a second lock is not the best solution.

> > We'd be back at the original proposal.
> 
> Introducing a new flag to describe 'unlinked' is still OK, but
> borrowing urb->unlinked is better, the bad is that it is private.

And it needs to be explicitly checked. We'd better use urb->reject.
I've posted a patch to do so.

	Regards
		Oliver
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
