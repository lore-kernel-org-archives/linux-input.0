From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: aiptek: fix crash on detecting device without
 endpoints
Date: Thu, 26 Nov 2015 08:36:21 -0800
Message-ID: <20151126163621.GA3075@dtor-ws>
References: <1448467088-7703-1-git-send-email-vdronov@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35874 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309AbbKZQgY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Nov 2015 11:36:24 -0500
Received: by pacdm15 with SMTP id dm15so90392026pac.3
        for <linux-input@vger.kernel.org>; Thu, 26 Nov 2015 08:36:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1448467088-7703-1-git-send-email-vdronov@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Vladis Dronov <vdronov@redhat.com>, stern@rowland.harvard.edu
Cc: linux-input@vger.kernel.org

Hi Vladis,

On Wed, Nov 25, 2015 at 04:58:08PM +0100, Vladis Dronov wrote:
> The aiptek driver crashes in aiptek_probe() when a specially crafted usb device
> without endpoints is detected. This fix adds a check that the device has proper
> configuration expected by the driver. Also an error return value is changed to
> more matching one in one of the error paths.

Hmm, I see quite a few drivers assuming that endpoint 0 will be present.
I wonder if that should not be solved at USB level.

Alan, does it make sense to have drivers probe interface if it does not
have any endpoints?

Thanks.

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
> +			"interface has %d endpoints, but must have minimum 1\n",
> +			intf->altsetting[0].desc.bNumEndpoints);
> +		err = -ENODEV;
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
>  		goto fail3;
>  	}
>  
> -- 
> 2.6.2
> 

-- 
Dmitry
