From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: pixcir_i2c_ts - fix receive error
Date: Tue, 16 Jun 2015 15:07:43 -0700
Message-ID: <20150616220743.GB17610@dtor-ws>
References: <1434484984-15418-1-git-send-email-frodo_lai@bcmcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:37372 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752726AbbFPWHr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Jun 2015 18:07:47 -0400
Content-Disposition: inline
In-Reply-To: <1434484984-15418-1-git-send-email-frodo_lai@bcmcom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frodo Lai <frodo.lai@gmail.com>
Cc: rogerq@ti.com, rydberg@bitmath.org, jg1.han@samsung.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jun 16, 2015 at 01:03:04PM -0700, Frodo Lai wrote:
> The i2c_master_recv() uses readsize to receive data from i2c but
> compares to size of rdbuf which is always 27. This would casue
> problem when the max_fingers is not 5. Change the comparison value
> to readsize instead.
> 
> Signed-off-by: Frodo Lai <frodo_lai@bcmcom.com>

Applied, thank you.

> ---
>  drivers/input/touchscreen/pixcir_i2c_ts.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.c b/drivers/input/touchscreen/pixcir_i2c_ts.c
> index 2c21071..8f3e243 100644
> --- a/drivers/input/touchscreen/pixcir_i2c_ts.c
> +++ b/drivers/input/touchscreen/pixcir_i2c_ts.c
> @@ -78,7 +78,7 @@ static void pixcir_ts_parse(struct pixcir_i2c_ts_data *tsdata,
>  	}
>  
>  	ret = i2c_master_recv(tsdata->client, rdbuf, readsize);
> -	if (ret != sizeof(rdbuf)) {
> +	if (ret != readsize) {
>  		dev_err(&tsdata->client->dev,
>  			"%s: i2c_master_recv failed(), ret=%d\n",
>  			__func__, ret);
> -- 
> 1.7.9.5
> 

-- 
Dmitry
