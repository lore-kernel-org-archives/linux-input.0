From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [PATCH 1/1] usbhid: Set Report ID properly for Output reports
 on the Control endpoint.
Date: Tue, 24 Aug 2010 17:49:44 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1008241747570.1019@pobox.suse.cz>
References: <1282020244-25786-1-git-send-email-alan@signal11.us>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1282020244-25786-1-git-send-email-alan-yzvJWuRpmD1zbRFIqnYvSA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Ott <alan-yzvJWuRpmD1zbRFIqnYvSA@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, 17 Aug 2010, Alan Ott wrote:

> When I made commit 29129a98e6fc89, I didn't account for *buf not being
> the report ID anymore, as buf is incremented.
> 
> This applies to 2.6.35 and newer.
> 
> Signed-off-by: Alan Ott <alan-yzvJWuRpmD1zbRFIqnYvSA@public.gmane.org>
> ---
>  drivers/hid/usbhid/hid-core.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> index b729c02..ffd6899 100644
> --- a/drivers/hid/usbhid/hid-core.c
> +++ b/drivers/hid/usbhid/hid-core.c
> @@ -828,6 +828,7 @@ static int usbhid_output_raw_report(struct hid_device *hid, __u8 *buf, size_t co
>  		}
>  	} else {
>  		int skipped_report_id = 0;
> +		int report_id = buf[0];
>  		if (buf[0] == 0x0) {
>  			/* Don't send the Report ID */
>  			buf++;
> @@ -837,7 +838,7 @@ static int usbhid_output_raw_report(struct hid_device *hid, __u8 *buf, size_t co
>  		ret = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
>  			HID_REQ_SET_REPORT,
>  			USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
> -			((report_type + 1) << 8) | *buf,
> +			((report_type + 1) << 8) | report_id,
>  			interface->desc.bInterfaceNumber, buf, count,
>  			USB_CTRL_SET_TIMEOUT);
>  		/* count also the report id, if this was a numbered report. */

Good catch, applied, thank you.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
