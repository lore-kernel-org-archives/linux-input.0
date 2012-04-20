From: Ming Lei <ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Subject: Re: [PATCH] hid: usbhid: fix possible deadlock in __usbhid_submit_report
Date: Fri, 20 Apr 2012 21:30:41 +0800
Message-ID: <CACVXFVOuS+qU2=DtU3xCj4mJWjjQw832oxH5XoHdvjj_G00k=w@mail.gmail.com>
References: <1334843464-1585-1-git-send-email-ming.lei@canonical.com>
	<201204200957.34154.oneukum@suse.de>
	<CACVXFVP42WL2aVDGSn0BF0NJbg824VsU=Fs30XKEif6siOrQvw@mail.gmail.com>
	<201204201245.44981.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201204201245.44981.oneukum-l3A5Bk7waGM@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Fri, Apr 20, 2012 at 6:45 PM, Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org> wrote:

> To be blunt, I'd prefer a guarantee that allows usb_unlink_urb() to be
> called with spinlocks held.

It is allowed to be called with spinlocks held, but the same lock is not
allowed to be acquired in complete handler.

I understand you mean URB complete handler should be guaranteed
to be run only in IRQ context and can't be called by usb_unlink_urb,
don't I?

If yes, many hc drivers are still involved to be modified.

thanks,
--
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
