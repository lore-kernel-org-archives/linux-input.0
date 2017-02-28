From: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2] HID: hiddev: allocate minor number hiddev's USB
 interface is bound to
Date: Tue, 28 Feb 2017 18:05:07 +0100
Message-ID: <20170228170507.GA7064@mail.corp.redhat.com>
References: <1487152516-12335-1-git-send-email-climbbb.kim@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1487152516-12335-1-git-send-email-climbbb.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jaejoong Kim <climbbb.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Feb 15 2017 or thereabouts, Jaejoong Kim wrote:
> When HID device connected to the PC, HID device driver announces which
> driver is loaded with a kernel info message. In this case, hiddev's minor
> number is always '0' even though hiddev's real minor number is not zero.
> 
> To display hiddev with minor number asked from usb core, we need
> to fill hiddev's minor number this interface is bound to.
> 
> Signed-off-by: Jaejoong Kim <climbbb.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---

That's a single line of code, and I get into some headaches :)

So, the commit that broke this (.minor not being set) is actually commit
bd25f4dd69727555 ("HID: hiddev: use usb_find_interface, get rid of
BKL"), from 2010-07-11...

And this patch reverts to the intended behavior. But I am wondering if we
should really store the minor in struct hid_device if it is only used by
hiddev. hidraw does use a minor too, but stores it in struct hidraw
directly, so IMO it would make sense to store this in struct hiddev. The
problem is that this struct is not exported, and it's going to be some
refactoring work to do so.

So, in a way, I am tempted to give my:
Acked-by: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

But if Jiri feels that a cleanup of hiddev would be required instead, I
would follow him :)

Cheers,
Benjamin

> Changes in v2:
>  - fix typo in commit message
> ---
> 
>  drivers/hid/usbhid/hiddev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
> index 700145b..27e1f8d 100644
> --- a/drivers/hid/usbhid/hiddev.c
> +++ b/drivers/hid/usbhid/hiddev.c
> @@ -910,6 +910,7 @@ int hiddev_connect(struct hid_device *hid, unsigned int force)
>  		kfree(hiddev);
>  		return -1;
>  	}
> +	hid->minor = usbhid->intf->minor;
>  	return 0;
>  }
>  
> -- 
> 2.7.4
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
