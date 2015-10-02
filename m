From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 15/18] Input: auo-pixcir-ts - simplify function return
 logic
Date: Fri, 2 Oct 2015 11:19:26 -0700
Message-ID: <20151002181926.GL8437@dtor-ws>
References: <1443793229-22363-1-git-send-email-javier@osg.samsung.com>
 <1443793229-22363-16-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36437 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752111AbbJBST3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 2 Oct 2015 14:19:29 -0400
Content-Disposition: inline
In-Reply-To: <1443793229-22363-16-git-send-email-javier@osg.samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-input@vger.kernel.org

On Fri, Oct 02, 2015 at 03:40:26PM +0200, Javier Martinez Canillas wrote:
> The invoked function already returns zero on success or a negative
> errno code so there is no need to open code the logic in the caller.
> 
> This also fixes the following make coccicheck warnings:
> 
> end returns can be simplified and declaration on line 402 can be dropped
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

Applied, thank you.

> ---
> 
>  drivers/input/touchscreen/auo-pixcir-ts.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/auo-pixcir-ts.c b/drivers/input/touchscreen/auo-pixcir-ts.c
> index 38c06f754acd..6592fc5d48b4 100644
> --- a/drivers/input/touchscreen/auo-pixcir-ts.c
> +++ b/drivers/input/touchscreen/auo-pixcir-ts.c
> @@ -399,13 +399,8 @@ static int auo_pixcir_stop(struct auo_pixcir_ts *ts)
>  static int auo_pixcir_input_open(struct input_dev *dev)
>  {
>  	struct auo_pixcir_ts *ts = input_get_drvdata(dev);
> -	int ret;
> -
> -	ret = auo_pixcir_start(ts);
> -	if (ret)
> -		return ret;
>  
> -	return 0;
> +	return auo_pixcir_start(ts);
>  }
>  
>  static void auo_pixcir_input_close(struct input_dev *dev)
> -- 
> 2.4.3
> 

-- 
Dmitry
