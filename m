From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] pcf8574_keypad: use request_devm_threaded_irq
Date: Mon, 22 Jun 2015 13:55:52 -0700
Message-ID: <20150622205552.GB2350@dtor-ws>
References: <1434710154-25834-1-git-send-email-m.grzeschik@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:35781 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752077AbbFVUz7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Jun 2015 16:55:59 -0400
Received: by igblr2 with SMTP id lr2so40317539igb.0
        for <linux-input@vger.kernel.org>; Mon, 22 Jun 2015 13:55:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1434710154-25834-1-git-send-email-m.grzeschik@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: linux-input@vger.kernel.org

On Fri, Jun 19, 2015 at 12:35:54PM +0200, Michael Grzeschik wrote:
> We can use the devres API here. Remove the extra cleanup codepath.

We could, but not like that (hint: what is the order of releasing
resources with your patch?). Also, calling free_irq() on IRQ requested
by devm_* is not quite valid. Did you test the patch, especially the
remove portion?

> 
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> ---
>  drivers/input/misc/pcf8574_keypad.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/misc/pcf8574_keypad.c b/drivers/input/misc/pcf8574_keypad.c
> index 97f711a..62fcf36 100644
> --- a/drivers/input/misc/pcf8574_keypad.c
> +++ b/drivers/input/misc/pcf8574_keypad.c
> @@ -131,7 +131,8 @@ static int pcf8574_kp_probe(struct i2c_client *client, const struct i2c_device_i
>  
>  	lp->laststate = read_state(lp);
>  
> -	ret = request_threaded_irq(client->irq, NULL, pcf8574_kp_irq_handler,
> +	ret = devm_request_threaded_irq(&client->dev, client->irq,
> +				   NULL, pcf8574_kp_irq_handler,
>  				   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
>  				   DRV_NAME, lp);
>  	if (ret) {
> @@ -142,14 +143,12 @@ static int pcf8574_kp_probe(struct i2c_client *client, const struct i2c_device_i
>  	ret = input_register_device(idev);
>  	if (ret) {
>  		dev_err(&client->dev, "input_register_device() failed\n");
> -		goto fail_free_irq;
> +		goto fail_free_device;
>  	}
>  
>  	i2c_set_clientdata(client, lp);
>  	return 0;
>  
> - fail_free_irq:
> -	free_irq(client->irq, lp);
>   fail_free_device:
>  	input_free_device(idev);
>   fail_allocate:
> -- 
> 2.1.4
> 

Thanks.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" in
