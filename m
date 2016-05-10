From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v1 1/1] HID: multitouch: enable touchpad on Surface Book
Date: Tue, 10 May 2016 16:21:32 +0200
Message-ID: <20160510142132.GP23234@mail.corp.redhat.com>
References: <1462805821-73087-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57996 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751740AbcEJOVh (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 10 May 2016 10:21:37 -0400
Content-Disposition: inline
In-Reply-To: <1462805821-73087-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>

Hi Andy,

On May 09 2016 or thereabouts, Andy Shevchenko wrote:
> Microsoft Surface Book has HID multitouch connected device. Enable it here.
> 
> The change has been tested on bare metal by reading raw data from
> /dev/input/event4.
> 
> The patch uses HID device ID submitted earlier here:
> http://marc.info/?l=linux-input&m=146280544721389&w=2
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/hid/hid-multitouch.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index c741f5e..c3df02d 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -1377,6 +1377,11 @@ static const struct hid_device_id mt_devices[] = {
>  		MT_USB_DEVICE(USB_VENDOR_ID_ILITEK,
>  			USB_DEVICE_ID_ILITEK_MULTITOUCH) },
>  
> +	/* Microsoft Surface Book */
> +	{ .driver_data = MT_CLS_EXPORT_ALL_INPUTS,
> +		MT_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
> +			USB_DEVICE_ID_MS_SURFACE_BOOK) },
> +

I am a little bit lost here. In your previous patch, you unset the group
MULTITOUCH to the USB_DEVICE_ID_MS_SURFACE_BOOK. But here, you bind a
device to it which will never been present according to
http://marc.info/?l=linux-input&m=146280544721389&w=2

Also, please make sure all features are working on the keyboard (special
functions/LEDs).
The good news is I have been sent a Surface 3 with the typecover. So I
intend to work on either fixing hid-multitouch or enabling multitouch
for hid-microsoft depending on which makes more sense.

Cheers,
Benjamin

>  	/* MosArt panels */
>  	{ .driver_data = MT_CLS_CONFIDENCE_MINUS_ONE,
>  		MT_USB_DEVICE(USB_VENDOR_ID_ASUS,
> -- 
> 2.8.1
> 
