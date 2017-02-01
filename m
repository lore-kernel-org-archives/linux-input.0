From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] Input: refuse to register absolute devices without
 absinfo
Date: Wed, 1 Feb 2017 09:35:44 +0100
Message-ID: <20170201083543.GC31658@mail.corp.redhat.com>
References: <20170131231515.GA37218@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56278 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751639AbdBAIft (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 1 Feb 2017 03:35:49 -0500
Content-Disposition: inline
In-Reply-To: <20170131231515.GA37218@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org

On Jan 31 2017 or thereabouts, Dmitry Torokhov wrote:
> If device is supposed to send absolute events (i.e. EV_ABS bit is set in
> dev->evbit) but dev->absinfo is not allocated, then the driver has done
> something wrong, and we should not register such device. Otherwise we'll
> crash later, when driver tries to send absolute event.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---

Looks good to me:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>  drivers/input/input.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/input/input.c b/drivers/input/input.c
> index f0d2d45a68e3..4617f2db9e36 100644
> --- a/drivers/input/input.c
> +++ b/drivers/input/input.c
> @@ -2095,6 +2095,12 @@ int input_register_device(struct input_dev *dev)
>  	const char *path;
>  	int error;
>  
> +	if (test_bit(EV_ABS, dev->evbit) && !dev->absinfo) {
> +		dev_err(&dev->dev,
> +			"Absolute device without dev->absinfo, refusing to register\n");
> +		return -EINVAL;
> +	}
> +
>  	if (dev->devres_managed) {
>  		devres = devres_alloc(devm_input_device_unregister,
>  				      sizeof(struct input_devres), GFP_KERNEL);
> -- 
> 2.11.0.483.g087da7b7c-goog
> 
> 
> -- 
> Dmitry
