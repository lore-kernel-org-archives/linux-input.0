From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [PATCH] HID: Avoid double spin_lock_init on usbhid->lock
 (resend)
Date: Tue, 23 Jun 2009 15:33:45 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0906231532460.7457@wotan.suse.de>
References: <20090623093324.GB3805@localdomain.by>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090623093324.GB3805-AfQBxy1nhrTup4dJKg45FQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergey Senozhatsky <sergey.senozhatsky-A/MS7pq9VAU@public.gmane.org>
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, 23 Jun 2009, Sergey Senozhatsky wrote:

> Trivial: Avoid double spin_lock_init on usbhid->lock.
> 
> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky-A/MS7pq9VAU@public.gmane.org>
> ---
> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> index 76c4bbe..c654b89 100644
> --- a/drivers/hid/usbhid/hid-core.c
> +++ b/drivers/hid/usbhid/hid-core.c
> @@ -987,7 +987,6 @@ static int usbhid_start(struct hid_device *hid)
>  	setup_timer(&usbhid->io_retry, hid_retry_timeout, (unsigned long) hid);
>  
>  	spin_lock_init(&usbhid->lock);
> -	spin_lock_init(&usbhid->lock);
>  
>  	usbhid->intf = intf;
>  	usbhid->ifnum = interface->desc.bInterfaceNumber;

Hi Sergey,

I have applied the patch. Your mail hasn't reached my @suse.cz address 
though, I have digged it from linux-input. Is your SMTP server or some 
blacklist?

Thanks,

-- 
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
