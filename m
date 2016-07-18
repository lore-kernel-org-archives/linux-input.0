From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: sony: disable descriptor fixup for FutureMax Dance
 Mat
Date: Mon, 18 Jul 2016 16:28:37 +0200
Message-ID: <20160718142837.GK4663@mail.corp.redhat.com>
References: <20160717172533.8777-1-mikko.perttunen@kapsi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41626 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752185AbcGRO2n (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Jul 2016 10:28:43 -0400
Content-Disposition: inline
In-Reply-To: <20160717172533.8777-1-mikko.perttunen@kapsi.fi>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Cc: jikos@kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Mikko Perttunen <mperttunen@nvidia.com>

On Jul 17 2016 or thereabouts, Mikko Perttunen wrote:
> From: Mikko Perttunen <mperttunen@nvidia.com>
> 
> The FutureMax Dance Mat claims to be a SixAxis controller
> but breaks if descriptor fixups are applied. Detect the
> device using its USB product string and disable fixups
> when it is detected.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  drivers/hid/hid-sony.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index 310436a..4c976f7 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c
> @@ -36,6 +36,9 @@
>  #include <linux/list.h>
>  #include <linux/idr.h>
>  #include <linux/input/mt.h>
> +#include <linux/usb.h>
> +
> +#include "usbhid/usbhid.h"

I spent a lot of effort 2 years ago to remove the usb dependency, I'd
prefer not adding a strong deps on it again.

>  
>  #include "hid-ids.h"
>  
> @@ -51,6 +54,7 @@
>  #define NAVIGATION_CONTROLLER_USB BIT(9)
>  #define NAVIGATION_CONTROLLER_BT  BIT(10)
>  #define SINO_LITE_CONTROLLER      BIT(11)
> +#define FUTUREMAX_DANCE_MAT       BIT(12)
>  
>  #define SIXAXIS_CONTROLLER (SIXAXIS_CONTROLLER_USB | SIXAXIS_CONTROLLER_BT)
>  #define MOTION_CONTROLLER (MOTION_CONTROLLER_USB | MOTION_CONTROLLER_BT)
> @@ -1125,7 +1129,7 @@ static u8 *sony_report_fixup(struct hid_device *hdev, u8 *rdesc,
>  {
>  	struct sony_sc *sc = hid_get_drvdata(hdev);
>  
> -	if (sc->quirks & SINO_LITE_CONTROLLER)
> +	if (sc->quirks & (SINO_LITE_CONTROLLER | FUTUREMAX_DANCE_MAT))
>  		return rdesc;
>  
>  	/*
> @@ -2288,6 +2292,15 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  	unsigned long quirks = id->driver_data;
>  	struct sony_sc *sc;
>  	unsigned int connect_mask = HID_CONNECT_DEFAULT;
> +	struct usb_device *usb_dev;
> +
> +	if (quirks & SIXAXIS_CONTROLLER_USB) {
> +		usb_dev = hid_to_usb_dev(hdev);
> +		if (usb_dev && usb_dev->product &&
> +		    !strcmp(usb_dev->product, "FutureMax Dance Mat")) {i

If they decided to reuse the same PID than one existing, and you have no
other choice but to rely on the name, you can simply have a match on
hdev->name instead of adding the USB dependency.

Also, I think it would be better to have a check on the existing report
descriptor instead of blindly fixing it. Other drivers make sure they
are fixing the correct region before overriding it, but I think using a
md5sum might be just easier (though that's not required for your patch I
think).

Cheers,
Benjamin

> +			quirks |= FUTUREMAX_DANCE_MAT;
> +		}
> +	}
>  
>  	sc = devm_kzalloc(&hdev->dev, sizeof(*sc), GFP_KERNEL);
>  	if (sc == NULL) {
> -- 
> 2.8.2
> 
