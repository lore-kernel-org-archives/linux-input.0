From: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH] hid: usbhid: fix possible deadlock in __usbhid_submit_report
Date: Thu, 19 Apr 2012 18:11:33 +0200
Message-ID: <201204191811.33994.oneukum@suse.de>
References: <1334843464-1585-1-git-send-email-ming.lei@canonical.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1334843464-1585-1-git-send-email-ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ming Lei <ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Am Donnerstag, 19. April 2012, 15:51:04 schrieb Ming Lei:
> The URB complete handler may be called by usb_unlink_urb directly,
> so deadlock will be triggered in __usbhid_submit_report since
> usbhid->lock is to be acquired in ctrl/out URB complete handler
> but it is hold before calling usb_unlink_urb.
> 
> This patch avoids the deadlock by releasing the lock before
> calling usb_unlink_urb.
> 
> CC: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
> Signed-off-by: Ming Lei <ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
> ---
>  drivers/hid/usbhid/hid-core.c |   16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> index aa1c503..b5d07da 100644
> --- a/drivers/hid/usbhid/hid-core.c
> +++ b/drivers/hid/usbhid/hid-core.c
> @@ -543,11 +543,13 @@ static void __usbhid_submit_report(struct hid_device *hid, struct hid_report *re
>  			 * the queue is known to run
>  			 * but an earlier request may be stuck
>  			 * we may need to time out
> -			 * no race because this is called under
> -			 * spinlock
> +			 * release spinlock to avoid deadlock.
>  			 */
> -			if (time_after(jiffies, usbhid->last_out + HZ * 5))
> +			if (time_after(jiffies, usbhid->last_out + HZ * 5)) {
> +				spin_unlock(&usbhid->lock);
>  				usb_unlink_urb(usbhid->urbout);
> +				spin_lock(&usbhid->lock);

The problem indeed exists on some HCDs.
I am afraid if you drop the lock there you introduce a race whereby
you might unlink the wrong request.

	Regards
		Oliver
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
