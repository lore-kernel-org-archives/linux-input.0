From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [patch] Input: lm8323 - missing error check in
 lm8323_set_disable()
Date: Tue, 2 Dec 2014 21:56:15 -0800
Message-ID: <20141203055615.GC7411@dtor-glaptop>
References: <20141202211710.GA19955@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:58455 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982AbaLCF4h (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Dec 2014 00:56:37 -0500
Content-Disposition: inline
In-Reply-To: <20141202211710.GA19955@mwanda>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Jingoo Han <jg1.han@samsung.com>, Fugang Duan <B38611@freescale.com>, Johan Hovold <johan@kernel.org>, Bryan Wu <cooloney@gmail.com>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

On Wed, Dec 03, 2014 at 12:17:10AM +0300, Dan Carpenter wrote:
> The missing error handling here is not especially harmful but static
> checkers complain that "i" can be used uninitialized.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied, thank you.

> 
> diff --git a/drivers/input/keyboard/lm8323.c b/drivers/input/keyboard/lm8323.c
> index cb32e2b..21bea52 100644
> --- a/drivers/input/keyboard/lm8323.c
> +++ b/drivers/input/keyboard/lm8323.c
> @@ -616,6 +616,8 @@ static ssize_t lm8323_set_disable(struct device *dev,
>  	unsigned int i;
>  
>  	ret = kstrtouint(buf, 10, &i);
> +	if (ret)
> +		return ret;
>  
>  	mutex_lock(&lm->lock);
>  	lm->kp_enabled = !i;

-- 
Dmitry
