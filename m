From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: aiptek: fix crash on detecting device without
 endpoints
Date: Tue, 1 Dec 2015 13:16:14 -0800
Message-ID: <20151201211614.GB3740@dtor-ws>
References: <1448467088-7703-1-git-send-email-vdronov@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35636 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756437AbbLAVQR (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Dec 2015 16:16:17 -0500
Received: by pacej9 with SMTP id ej9so16878103pac.2
        for <linux-input@vger.kernel.org>; Tue, 01 Dec 2015 13:16:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1448467088-7703-1-git-send-email-vdronov@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Vladis Dronov <vdronov@redhat.com>
Cc: linux-input@vger.kernel.org

Hi Vladis,

On Wed, Nov 25, 2015 at 04:58:08PM +0100, Vladis Dronov wrote:
> The aiptek driver crashes in aiptek_probe() when a specially crafted usb device
> without endpoints is detected. This fix adds a check that the device has proper
> configuration expected by the driver. Also an error return value is changed to
> more matching one in one of the error paths.
> 
> Reported-by: Ralf Spenneberg <ralf@spenneberg.net>
> Signed-off-by: Vladis Dronov <vdronov@redhat.com>
> ---
>  drivers/input/tablet/aiptek.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/input/tablet/aiptek.c b/drivers/input/tablet/aiptek.c
> index e7f966d..78c0732 100644
> --- a/drivers/input/tablet/aiptek.c
> +++ b/drivers/input/tablet/aiptek.c
> @@ -1819,6 +1819,15 @@ aiptek_probe(struct usb_interface *intf, const struct usb_device_id *id)
>  	input_set_abs_params(inputdev, ABS_TILT_Y, AIPTEK_TILT_MIN, AIPTEK_TILT_MAX, 0, 0);
>  	input_set_abs_params(inputdev, ABS_WHEEL, AIPTEK_WHEEL_MIN, AIPTEK_WHEEL_MAX - 1, 0, 0);
>  
> +	/* Verify that a device really has an endpoint
> +	 */
> +	if (intf->altsetting[0].desc.bNumEndpoints < 1) {
> +		dev_warn(&intf->dev,

This should be dev_err as we are aborting device initialization. I know
the driver user warn/info in similar places, but it is not right, we
might want to adjust it at some point.

> +			"interface has %d endpoints, but must have minimum 1\n",
> +			intf->altsetting[0].desc.bNumEndpoints);
> +		err = -ENODEV;

-EINVAL: the device configuration is invalid from the driver point of
view.

> +		goto fail3;
> +	}
>  	endpoint = &intf->altsetting[0].endpoint[0].desc;
>  
>  	/* Go set up our URB, which is called when the tablet receives
> @@ -1861,6 +1870,7 @@ aiptek_probe(struct usb_interface *intf, const struct usb_device_id *id)
>  	if (i == ARRAY_SIZE(speeds)) {
>  		dev_info(&intf->dev,
>  			 "Aiptek tried all speeds, no sane response\n");
> +		err = -ENODEV;

I believe it should be -EINVAL as well. I adjusted the above 3 items and
applied.

Thanks.

-- 
Dmitry
