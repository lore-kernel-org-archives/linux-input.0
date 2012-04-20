From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] hid: usbhid: fix possible deadlock in __usbhid_submit_report
Date: Fri, 20 Apr 2012 14:59:50 -0700
Message-ID: <3064999.MGqgi6qjvF@dtor-d630.eng.vmware.com>
References: <1334843464-1585-1-git-send-email-ming.lei@canonical.com> <201204200957.34154.oneukum@suse.de> <CACVXFVP42WL2aVDGSn0BF0NJbg824VsU=Fs30XKEif6siOrQvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACVXFVP42WL2aVDGSn0BF0NJbg824VsU=Fs30XKEif6siOrQvw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ming Lei <ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Cc: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Friday, April 20, 2012 06:17:51 PM Ming Lei wrote:
> On Fri, Apr 20, 2012 at 3:57 PM, Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org> wrote:
> > You are racing with hid_irq_out(). It calls hid_submit_out()
> > under lock. So if hid_irq_out() is running between dropping
> > the lock and usb_unlink_urb() you may kill the newly submitted
> > urb, not the old urb that has timed out.
> 
> Yes, it is the race I missed, :-(
> 
> > You must make sure that between the times you check usbhid->last_out
> > and calling unlink hid_submit_out() cannot be called.
> > You can't just drop the lock (at least on SMP)
> 
> Looks it is not easy to avoid the race if the lock is to be dropped.
> 
> So how about not acquiring the lock during unlinking as below?

<skip>

Why don't you do something like this:

	urb_to_unlink = usbhid->urbout;
        usbhid->urbout = NULL;

        spin_unlock(&usbhid->lock);
        usb_unlink_urb(urb_to_unlink);
        spin_lock(&usbhid->lock);

and of course comment it properly.

Thanks.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
