From: Alan Ott <alan@signal11.us>
Subject: Re: [RFC, PATCH] HID: hid-sony, override usbhid_output_raw_report  for Sixaxis
Date: Wed, 13 Oct 2010 19:23:52 -0400
Message-ID: <4CB63F88.9080300@signal11.us>
References: <4CB62F69.1070809@signal11.us> <1287010481-8356-1-git-send-email-ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from core.signal11.us ([64.251.29.136]:41543 "EHLO core.signal11.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753717Ab0JMXXu (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Oct 2010 19:23:50 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by core.signal11.us (Postfix) with SMTP id B030F1CCAAAC
	for <linux-input@vger.kernel.org>; Wed, 13 Oct 2010 19:23:49 -0400 (EDT)
In-Reply-To: <1287010481-8356-1-git-send-email-ospite@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Jim Paris <jim@jtan.com>, Ranulf Doswell <ralf@ranulf.net>, =?ISO-8859-1?Q?Mikko_Virkkil=E4?= <mvirkkil@cc.hut.fi>, falktx@gmail.com

On 10/13/2010 06:54 PM, Antonio Ospite wrote:
> Sony Sixaxis wants output reports on the control endpoint rather than
> interrupt endpoint, so override usbhid_output_raw_report in order to
> force this behaviour.
>
> Signed-off-by: Antonio Ospite<ospite@studenti.unina.it>
> ---
>
> This works indeed but there is obviously quite some code duplication with
> usbhid_output_raw_report, if a change would be made there it had to be ported
> here too. I still like the quirk approach better, but I am open to
> suggestions.
>
> Patch is on top of the previous series.
>
> Thanks,
>     Antonio
>
>   drivers/hid/hid-sony.c |   34 +++++++++++++++++++++++++++++++++-
>   1 files changed, 33 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index 7b0c70a..d1007f4 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c
> @@ -46,6 +46,38 @@ static void sony_report_fixup(struct hid_device *hdev, __u8 *rdesc,
>   	}
>   }
>
> +static int sixaxis_usb_output_raw_report(struct hid_device *hid, __u8 *buf,
> +		size_t count, unsigned char report_type)
> +{
> +	struct usb_interface *intf = to_usb_interface(hid->dev.parent);
> +	struct usb_device *dev = interface_to_usbdev(intf);
> +	struct usb_host_interface *interface = intf->cur_altsetting;
> +
> +	int ret;
> +	int skipped_report_id = 0;
> +	int report_id = buf[0];
> +
> +	printk(KERN_DEBUG "%s: Overriding usbhid_output_raw_report\n", __func__);
> +
> +	if (buf[0] == 0x0) {
> +		/* Don't send the Report ID */
> +		buf++;
> +		count--;
> +		skipped_report_id = 1;
> +	}
> +	ret = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
> +		HID_REQ_SET_REPORT,
> +		USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
> +		((report_type + 1)<<  8) | report_id,
> +		interface->desc.bInterfaceNumber, buf, count,
> +		USB_CTRL_SET_TIMEOUT);
> +	/* count also the report id, if this was a numbered report. */
> +	if (ret>  0&&  skipped_report_id)
> +		ret++;
> +
> +	return ret;
> +}
> +
>   /*
>    * Sending HID_REQ_GET_REPORT changes the operation mode of the ps3 controller
>    * to "operational".  Without this, the ps3 controller will not report any
> @@ -111,8 +143,8 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
>   	}
>
>   	if (sc->quirks&  SIXAXIS_CONTROLLER_USB) {
> +		hdev->hid_output_raw_report = sixaxis_usb_output_raw_report;
>   		ret = sixaxis_set_operational_usb(hdev);
> -		hdev->quirks |= HID_QUIRK_FORCE_OUT_CONTROL_EP;
>   	}
>   	else if (sc->quirks&  SIXAXIS_CONTROLLER_BT)
>   		ret = sixaxis_set_operational_bt(hdev);
>    

I think as far as code duplication goes, you can get rid of the 
skipped_report stuff and the buf[0] = 0x0 section (since you _know_ the 
sixaxis uses numbered reports). Once you've done that, you're basically 
down to one function call.

I think maybe I'm confused a bit. Is this patch against Jiri's hid tree 
in the for-next branch[1]? If so is there another patch which is 
required for this to make sense (I looked in linux-input, but didn't see 
any appropriate ones)? In Jiri's tree, sixaxis_set_operational_usb() 
already calls usb_control_msg() instead of hid_output_raw_report(), so I 
clearly must be looking at the wrong thing. Please help me understand 
what I'm supposed to be looking at.

Alan.

[1] 
http://git.kernel.org/?p=linux/kernel/git/jikos/hid.git;a=blob_plain;f=drivers/hid/hid-sony.c;hb=816651a7d4a32664261e5f9f88ad0d558faed4cc



