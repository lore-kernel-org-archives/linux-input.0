From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [PATCH 1/1] HID: Send Report ID when numbered reports are sent
 over the control endpoint.
Date: Sun, 11 Jul 2010 23:14:01 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1007112313240.4741@pobox.suse.cz>
References: <alpine.LNX.2.00.1006301126130.13809@pobox.suse.cz> <1277905836-3949-2-git-send-email-alan@signal11.us>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1277905836-3949-2-git-send-email-alan-yzvJWuRpmD1zbRFIqnYvSA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Ott <alan-yzvJWuRpmD1zbRFIqnYvSA@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>, Amit Nagal <helloin.amit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, 30 Jun 2010, Alan Ott wrote:

> The Report ID wasn't sent as part of the payload for reports which were sent
> over the control endpoint. This is required by section 8.1 of the HID spec.

We already have a8ab5d58b0238b8199cc699b8dff7c5e1da24138 commit in Linus' 
tree, so I'll take this for .35 still, thanks a lot for fixing it Alan.

> 
> Signed-off-by: Alan Ott <alan-yzvJWuRpmD1zbRFIqnYvSA@public.gmane.org>
> ---
>  drivers/hid/usbhid/hid-core.c |   13 ++++++++++---
>  1 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> index deef816..1697687 100644
> --- a/drivers/hid/usbhid/hid-core.c
> +++ b/drivers/hid/usbhid/hid-core.c
> @@ -854,14 +854,21 @@ static int usbhid_output_raw_report(struct hid_device *hid, __u8 *buf, size_t co
>  				ret++;
>  		}
>  	} else {
> +		int skipped_report_id = 0;
> +		if (buf[0] == 0x0) {
> +			/* Don't send the Report ID */
> +			buf++;
> +			count--;
> +			skipped_report_id = 1;
> +		}
>  		ret = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
>  			HID_REQ_SET_REPORT,
>  			USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
>  			((report_type + 1) << 8) | *buf,
> -			interface->desc.bInterfaceNumber, buf + 1, count - 1,
> +			interface->desc.bInterfaceNumber, buf, count,
>  			USB_CTRL_SET_TIMEOUT);
> -		/* count also the report id */
> -		if (ret > 0)
> +		/* count also the report id, if this was a numbered report. */
> +		if (ret > 0 && skipped_report_id)
>  			ret++;
>  	}

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
