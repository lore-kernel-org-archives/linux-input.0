From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 07/18] Input: cap11xx - simplify function return logic
Date: Fri, 2 Oct 2015 11:09:26 -0700
Message-ID: <20151002180926.GH8437@dtor-ws>
References: <1443793229-22363-1-git-send-email-javier@osg.samsung.com>
 <1443793229-22363-8-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:32774 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751919AbbJBSJ3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 2 Oct 2015 14:09:29 -0400
Content-Disposition: inline
In-Reply-To: <1443793229-22363-8-git-send-email-javier@osg.samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Daniel Mack <linux@zonque.org>, linux-input@vger.kernel.org, Matt Ranostay <mranostay@gmail.com>

On Fri, Oct 02, 2015 at 03:40:18PM +0200, Javier Martinez Canillas wrote:
> The invoked function already returns zero on success or a negative
> errno code so there is no need to open code the logic in the caller.
> 
> This also fixes the following make coccicheck warning:
> 
> drivers/input/keyboard/cap11xx.c:475:1-6: WARNING: end returns can be simplified
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> ---
> 
>  drivers/input/keyboard/cap11xx.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/cap11xx.c
> index 378db10001df..7240316ddfe3 100644
> --- a/drivers/input/keyboard/cap11xx.c
> +++ b/drivers/input/keyboard/cap11xx.c
> @@ -472,12 +472,8 @@ static int cap11xx_i2c_probe(struct i2c_client *i2c_client,
>  		return -ENXIO;
>  	}
>  
> -	error = devm_request_threaded_irq(dev, irq, NULL, cap11xx_thread_func,
> -					  IRQF_ONESHOT, dev_name(dev), priv);
> -	if (error)
> -		return error;
> -
> -	return 0;
> +	return devm_request_threaded_irq(dev, irq, NULL, cap11xx_thread_func,
> +					 IRQF_ONESHOT, dev_name(dev), priv);
>  }

For cases where we have multiple of potentially failing actions:

	error = action1();
	if (error)
		return error;

	error = action2();
	if (error)
		return error;

	error = action3();
	if (error)
		return error;

	return 0;

I prefer not to compress the last action check to "return action3()".

Thanks.

-- 
Dmitry
