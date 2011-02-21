From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/2] hid-sony.c: Fix sending Output reports to the
 Sixaxis
Date: Mon, 21 Feb 2011 13:49:18 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1102211349090.2160@pobox.suse.cz>
References: <alpine.LNX.2.00.1102180944590.2160@pobox.suse.cz> <1298222806-19433-1-git-send-email-ospite@studenti.unina.it> <1298222806-19433-2-git-send-email-ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:57504 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753742Ab1BUMtU (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Feb 2011 07:49:20 -0500
In-Reply-To: <1298222806-19433-2-git-send-email-ospite@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-input@vger.kernel.org, linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, "Gustavo F. Padovan" <padovan@profusion.mobi>, Bastien Nocera <hadess@hadess.net>, Alan Ott <alan@signal11.us>, Jim Paris <jim@jtan.com>, "pascal@pabr.org" <pascal@pabr.org>

On Sun, 20 Feb 2011, Antonio Ospite wrote:

> The Sixaxis does not want the report_id as part of the data packet in
> Output reports, so we have to discard buf[0] when sending the actual
> control message.
> 
> Add also some documentation about that and about why
> hdev->hid_output_raw_report needs to be overridden.
> 
> Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>

Applied, thanks Antonio.

> ---
>  drivers/hid/hid-sony.c |   20 ++++++++++++++++++++
>  1 files changed, 20 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index 68d7b36..93819a0 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c
> @@ -46,6 +46,16 @@ static __u8 *sony_report_fixup(struct hid_device *hdev, __u8 *rdesc,
>  	return rdesc;
>  }
>  
> +/*
> + * The Sony Sixaxis does not handle HID Output Reports on the Interrupt EP
> + * like it should according to usbhid/hid-core.c::usbhid_output_raw_report()
> + * so we need to override that forcing HID Output Reports on the Control EP.
> + *
> + * There is also another issue about HID Output Reports via USB, the Sixaxis
> + * does not want the report_id as part of the data packet, so we have to
> + * discard buf[0] when sending the actual control message, even for numbered
> + * reports, humpf!
> + */
>  static int sixaxis_usb_output_raw_report(struct hid_device *hid, __u8 *buf,
>  		size_t count, unsigned char report_type)
>  {
> @@ -55,6 +65,12 @@ static int sixaxis_usb_output_raw_report(struct hid_device *hid, __u8 *buf,
>  	int report_id = buf[0];
>  	int ret;
>  
> +	if (report_type == HID_OUTPUT_REPORT) {
> +		/* Don't send the Report ID */
> +		buf++;
> +		count--;
> +	}
> +
>  	ret = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
>  		HID_REQ_SET_REPORT,
>  		USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
> @@ -62,6 +78,10 @@ static int sixaxis_usb_output_raw_report(struct hid_device *hid, __u8 *buf,
>  		interface->desc.bInterfaceNumber, buf, count,
>  		USB_CTRL_SET_TIMEOUT);
>  
> +	/* Count also the Report ID, in case of an Output report. */
> +	if (ret > 0 && report_type == HID_OUTPUT_REPORT)
> +		ret++;
> +
>  	return ret;
>  }
>  
> -- 
> 1.7.4.1
> 

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
