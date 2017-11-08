From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: tsc200x-core - set INPUT_PROP_DIRECT
Date: Tue, 7 Nov 2017 16:21:08 -0800
Message-ID: <20171108002108.ue5nig27rdriv5zw@dtor-ws>
References: <20171107234000.10236-1-martink@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:55121 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933222AbdKHAVM (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 7 Nov 2017 19:21:12 -0500
Content-Disposition: inline
In-Reply-To: <20171107234000.10236-1-martink@posteo.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Martin Kepplinger <martink@posteo.de>
Cc: keescook@chromium.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Nov 08, 2017 at 12:40:00AM +0100, Martin Kepplinger wrote:
> If INPUT_PROP_DIRECT is set, userspace doesn't have to fall back to old
> ways of identifying touchscreen devices.
> 
> In order to identify a touchscreen device, Android for example, seems to
> already depend on INPUT_PROP_DIRECT to be present in drivers. udev still
> checks for either BTN_TOUCH or INPUT_PROP_DIRECT. Checking for BTN_TOUCH
> however can quite easily lead to false positives; it's a code that not only
> touchscreen device drivers use.
> 
> According to the documentation, touchscreen drivers should have this
> property set and in order to make life easy for userspace, let's set it.
> 
> Signed-off-by: Martin Kepplinger <martink@posteo.de>

Applied, thank you.

> ---
> 
> Still, as a paranoia measure, I'd not do a bulk-patchset adding this bit
> to every driver here. I'll add it to drivers I know of, by using them
> myself or people that report using tslib. Who knows what devices or
> usecases exist out there :)
> 
> 
>  drivers/input/touchscreen/tsc200x-core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/touchscreen/tsc200x-core.c b/drivers/input/touchscreen/tsc200x-core.c
> index 542db26d7fd0..e0fde590df8e 100644
> --- a/drivers/input/touchscreen/tsc200x-core.c
> +++ b/drivers/input/touchscreen/tsc200x-core.c
> @@ -531,6 +531,7 @@ int tsc200x_probe(struct device *dev, int irq, const struct input_id *tsc_id,
>  
>  	input_set_drvdata(input_dev, ts);
>  
> +	__set_bit(INPUT_PROP_DIRECT, input_dev->propbit);
>  	input_set_capability(input_dev, EV_KEY, BTN_TOUCH);
>  
>  	input_set_abs_params(input_dev, ABS_X,
> -- 
> 2.11.0
> 

-- 
Dmitry
