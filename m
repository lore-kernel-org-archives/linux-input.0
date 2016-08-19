From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] input: pixcir_i2c_ts: simplify code with
 of_device_get_match_data
Date: Fri, 19 Aug 2016 10:17:32 -0700
Message-ID: <20160819171732.GH20499@dtor-ws>
References: <1471440134-23896-1-git-send-email-clabbe.montjoie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:32929 "EHLO
        mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754435AbcHSRRt (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 19 Aug 2016 13:17:49 -0400
Content-Disposition: inline
In-Reply-To: <1471440134-23896-1-git-send-email-clabbe.montjoie@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: LABBE Corentin <clabbe.montjoie@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Aug 17, 2016 at 03:22:12PM +0200, LABBE Corentin wrote:
> The usage of of_device_get_match_data reduce the code size a bit.
> Furthermore, it is better to use a standard function for
> getting the match data.
> 
> Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>

Applied, thank you.

> ---
>  drivers/input/touchscreen/pixcir_i2c_ts.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.c b/drivers/input/touchscreen/pixcir_i2c_ts.c
> index d159e14..b0a2dc2 100644
> --- a/drivers/input/touchscreen/pixcir_i2c_ts.c
> +++ b/drivers/input/touchscreen/pixcir_i2c_ts.c
> @@ -431,13 +431,7 @@ static const struct of_device_id pixcir_of_match[];
>  static int pixcir_parse_dt(struct device *dev,
>  			   struct pixcir_i2c_ts_data *tsdata)
>  {
> -	const struct of_device_id *match;
> -
> -	match = of_match_device(of_match_ptr(pixcir_of_match), dev);
> -	if (!match)
> -		return -EINVAL;
> -
> -	tsdata->chip = (const struct pixcir_i2c_chip_data *)match->data;
> +	tsdata->chip = of_device_get_match_data(dev);
>  	if (!tsdata->chip)
>  		return -EINVAL;
>  
> -- 
> 2.7.3
> 

-- 
Dmitry
