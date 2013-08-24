From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: as5011 - fix error return code in as5011_probe()
Date: Sat, 24 Aug 2013 16:40:08 -0700
Message-ID: <20130824234007.GD4454@core.coreip.homeip.net>
References: <CAPgLHd_zTAT7hGkcNCBCzKE5TiXfCYzCysbCDANX2vBDyrpH8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:49630 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755911Ab3HXXkL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 24 Aug 2013 19:40:11 -0400
Received: by mail-pd0-f181.google.com with SMTP id g10so2040552pdj.26
        for <linux-input@vger.kernel.org>; Sat, 24 Aug 2013 16:40:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAPgLHd_zTAT7hGkcNCBCzKE5TiXfCYzCysbCDANX2vBDyrpH8A@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: wfp5p@virginia.edu, broonie@opensource.wolfsonmicro.com, shubhrajyoti@ti.com, javier@dowhile0.org, yongjun_wei@trendmicro.com.cn, linux-input@vger.kernel.org

On Fri, Aug 23, 2013 at 10:54:55AM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Fix to return a negative error code from the error handling
> case instead of 0, as done elsewhere in this function.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Applied, thank you.

> ---
>  drivers/input/joystick/as5011.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/joystick/as5011.c b/drivers/input/joystick/as5011.c
> index 121cd63..262ebe2 100644
> --- a/drivers/input/joystick/as5011.c
> +++ b/drivers/input/joystick/as5011.c
> @@ -288,6 +288,7 @@ static int as5011_probe(struct i2c_client *client,
>  	if (irq < 0) {
>  		dev_err(&client->dev,
>  			"Failed to get irq number for button gpio\n");
> +		error = irq;
>  		goto err_free_button_gpio;
>  	}
>  
> 

-- 
Dmitry
