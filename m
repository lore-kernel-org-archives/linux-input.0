From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/1] HID: usbhid: add usb_clear_halt determination for
 next hid_start_in
Date: Fri, 22 Aug 2014 02:45:40 -0500 (CDT)
Message-ID: <alpine.LNX.2.00.1408220240430.23162@pobox.suse.cz>
References: <1408692913-12336-1-git-send-email-vichy.kuo@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:53874 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755212AbaHVHpm (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Aug 2014 03:45:42 -0400
In-Reply-To: <1408692913-12336-1-git-send-email-vichy.kuo@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: CheChun Kuo <vichy.kuo@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org

On Fri, 22 Aug 2014, CheChun Kuo wrote:

> 	HID IR device will not response to any command send from host when 
> it is finishing paring and tring to reset itself. During this period of 
> time, usb_cleaer_halt will be fail and if hid_start_in soon again, we 
> has the possibility trap in infinite loop.
> 
> Signed-off-by: CheChun Kuo <vichy.kuo@gmail.com>
> ---
>  drivers/hid/usbhid/hid-core.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> index 79cf503..256b102 100644
> --- a/drivers/hid/usbhid/hid-core.c
> +++ b/drivers/hid/usbhid/hid-core.c
> @@ -122,7 +122,8 @@ static void hid_reset(struct work_struct *work)
>  		dev_dbg(&usbhid->intf->dev, "clear halt\n");
>  		rc = usb_clear_halt(hid_to_usb_dev(hid), usbhid->urbin->pipe);
>  		clear_bit(HID_CLEAR_HALT, &usbhid->iofl);
> -		hid_start_in(hid);
> +		if (rc == 0)
> +			hid_start_in(hid);
>  	}

I'd need a more detailed explanation for this patch, as I don't understand 
neither the text in the changelog nor the patch itself. Namely:

- which IR devices are showing this behavior?
- where does the infinite loop come from? hid_reset() should error out 
  properly if usb_clear_halt() fails and HID_IN_RUNNING flag is not set

Thanks,

-- 
Jiri Kosina
SUSE Labs
