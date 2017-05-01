From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: ar1021_i2c: add previously wrongly removed ABS_X
 parameter
Date: Mon, 1 May 2017 10:11:43 -0700
Message-ID: <20170501171143.GB7851@dtor-ws>
References: <20170501145709.9803-1-martink@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36053 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750729AbdEARLv (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 1 May 2017 13:11:51 -0400
Content-Disposition: inline
In-Reply-To: <20170501145709.9803-1-martink@posteo.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Martin Kepplinger <martink@posteo.de>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, May 01, 2017 at 04:57:09PM +0200, Martin Kepplinger wrote:
> The recent change
> 
> commit 2098cc15d9a0 ("Input: ar1021_i2c - enable touch mode during open")
> 
> also removed the ABS_X input code to be set. This must have been done
> by mistake; so we bring back the X axis!
> 
> Signed-off-by: Martin Kepplinger <martink@posteo.de>
> ---
> 
> Dmitry,
> 
> this must have slipped in somehow. I didn't have this mistake included:
> https://www.spinics.net/lists/linux-input/msg51103.html

I must have fat-fingered it somehow. I fixed up the original commit
since it wasn't buried too deep.

Thanks.

> 
> thanks
>                          martin
> 
> 
>  drivers/input/touchscreen/ar1021_i2c.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/touchscreen/ar1021_i2c.c b/drivers/input/touchscreen/ar1021_i2c.c
> index ff59c3a383d6..3f55f673f661 100644
> --- a/drivers/input/touchscreen/ar1021_i2c.c
> +++ b/drivers/input/touchscreen/ar1021_i2c.c
> @@ -118,6 +118,7 @@ static int ar1021_i2c_probe(struct i2c_client *client,
>  	input->close = ar1021_i2c_close;
>  
>  	input_set_capability(input, EV_KEY, BTN_TOUCH);
> +	input_set_abs_params(input, ABS_X, 0, AR1021_MAX_X, 0, 0);
>  	input_set_abs_params(input, ABS_Y, 0, AR1021_MAX_Y, 0, 0);
>  
>  	input_set_drvdata(input, ar1021);
> -- 
> 2.11.0
> 

-- 
Dmitry
