From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] edt-ft5x06: fix reset pin behaviour
Date: Mon, 9 Oct 2017 20:58:01 -0700
Message-ID: <20171010035801.GC4601@dtor-ws>
References: <1507217501.7345.9.camel@kernelconcepts.de>
 <20171005153508.32127-1-simon.budig@kernelconcepts.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33962 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754906AbdJJD6E (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 9 Oct 2017 23:58:04 -0400
Received: by mail-pf0-f193.google.com with SMTP id b85so12085613pfj.1
        for <linux-input@vger.kernel.org>; Mon, 09 Oct 2017 20:58:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20171005153508.32127-1-simon.budig@kernelconcepts.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon.budig@kernelconcepts.de
Cc: linux-input@vger.kernel.org

On Thu, Oct 05, 2017 at 05:35:06PM +0200, simon.budig@kernelconcepts.de wrote:
> From: Simon Budig <simon.budig@kernelconcepts.de>
> 
> For some reason the reset pin no longer gets toggeled when initializing
> the touch. Fix that and restore the old behaviour.

Hmm, the GPIO is requested as GPIOD_OUT_HIGH, so it should be driven low
to being with and then released... I am not sure why we need to drive it
low explicitly again.

> 
> Signed-off-by: Simon Budig <simon.budig@kernelconcepts.de>
> ---
>  drivers/input/touchscreen/edt-ft5x06.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
> index 5bf63f7..867a61e 100644
> --- a/drivers/input/touchscreen/edt-ft5x06.c
> +++ b/drivers/input/touchscreen/edt-ft5x06.c
> @@ -936,8 +936,12 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
>  
>  	if (tsdata->reset_gpio) {
>  		usleep_range(5000, 6000);
> -		gpiod_set_value_cansleep(tsdata->reset_gpio, 0);
> +		/* note that the reset pin needs to be registered as
> +		 * active low in the devicetree.
> +		 */
> +		gpiod_set_value_cansleep(tsdata->reset_gpio, 1);
>  		msleep(300);
> +		gpiod_set_value_cansleep(tsdata->reset_gpio, 0);
>  	}
>  
>  	input = devm_input_allocate_device(&client->dev);
> -- 
> 2.1.4
> 

Thanks.

-- 
Dmitry
