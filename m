From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: core: assign usbhid to handle EETI PID=0x0001 HID
 device
Date: Tue, 22 Aug 2017 11:33:19 +0200
Message-ID: <20170822093319.GC25370@mail.corp.redhat.com>
References: <20170811074201.2747-1-jam.chen.egalax@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50836 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932205AbdHVJd0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 22 Aug 2017 05:33:26 -0400
Content-Disposition: inline
In-Reply-To: <20170811074201.2747-1-jam.chen.egalax@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: JamChen <jam.chen.egalax@gmail.com>
Cc: jikos@kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, zboszor@pr.hu

On Aug 11 2017 or thereabouts, JamChen wrote:
> From: Jam Chen <jam.chen.egalax@gmail.com>
> 
> The vendor used the same PID(0x0001) for multiple touch IC controllers.
> The newer ICs can support HID class and report the multitouch collection
> in the descriptor. So they were handled by the hid-multitouch driver.
> But some customized firmwares don't support multitouch protocol even if
> driver have got the Win8 blob data.
> 
> Actually, those ICs only support the single touch function, and report
> the mouse protocol by default. We can assign usbhid to handle them all.
> 
> Signed-off-by: Jam Chen <jam.chen.egalax@gmail.com>
> ---

Him

FYI, I'd rather see a full working solution such as the one presented here:
https://patchwork.kernel.org/patch/9876649/

Because this solution is half working as it regresses on some devices
while solving others.

Cheers,
Benjamin

>  drivers/hid/hid-core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 9017dcc14502..df4696022488 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -828,6 +828,10 @@ static int hid_scan_report(struct hid_device *hid)
>  				 */
>  				hid->group = HID_GROUP_RMI;
>  		break;
> +	case USB_VENDOR_ID_DWAV:
> +		if (hid->product == USB_DEVICE_ID_EGALAX_TOUCHCONTROLLER)
> +			hid->group = HID_GROUP_GENERIC;
> +		break;
>  	}
>  
>  	/* fall back to generic driver in case specific driver doesn't exist */
> -- 
> 2.11.0
> 
