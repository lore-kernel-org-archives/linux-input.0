From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input-polldev:Check poll_interval range while
 registering input device
Date: Thu, 16 Jul 2015 12:35:10 -0700
Message-ID: <20150716193510.GE32571@dtor-ws>
References: <aksgarg1989@gmail.com>
 <1437069433-76366-1-git-send-email-aksgarg1989@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f195.google.com ([209.85.223.195]:36080 "EHLO
	mail-ie0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753952AbbGPTfP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Jul 2015 15:35:15 -0400
Received: by iectv2 with SMTP id tv2so4571667iec.3
        for <linux-input@vger.kernel.org>; Thu, 16 Jul 2015 12:35:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1437069433-76366-1-git-send-email-aksgarg1989@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anshul Garg <aksgarg1989@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Anshul,

On Thu, Jul 16, 2015 at 10:57:13AM -0700, Anshul Garg wrote:
> Added check for poll_interval range in input_register_polled_device
> function similar to input_polldev_set_poll function.
> 
> Signed-off-by: Anshul Garg <aksgarg1989@gmail.com>
> ---
>  drivers/input/input-polldev.c |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/input/input-polldev.c b/drivers/input/input-polldev.c
> index 3664f81..0e88a9e 100644
> --- a/drivers/input/input-polldev.c
> +++ b/drivers/input/input-polldev.c
> @@ -309,6 +309,12 @@ int input_register_polled_device(struct input_polled_dev *dev)
>  
>  	input_set_drvdata(input, dev);
>  	INIT_DELAYED_WORK(&dev->work, input_polled_device_work);
> +
> +	if (dev->poll_interval > dev->poll_interval_max ||
> +			dev->poll_interval < dev->poll_interval_min) {
> +		pr_err("Poll interval Range incorrect\n");
> +		return -EINVAL;
> +	}

What driver was this change tested with?

Thanks.

-- 
Dmitry
