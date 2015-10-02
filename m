From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH 07/18] Input: cap11xx - simplify function return logic
Date: Fri, 2 Oct 2015 15:41:47 +0200
Message-ID: <560E899B.8070603@zonque.org>
References: <1443793229-22363-1-git-send-email-javier@osg.samsung.com>
 <1443793229-22363-8-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443793229-22363-8-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>, linux-kernel@vger.kernel.org
Cc: Axel Lin <axel.lin@ingics.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Daniel Mack <linux@zonque.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Matt Ranostay <mranostay@gmail.com>
List-Id: linux-input@vger.kernel.org

On 10/02/2015 03:40 PM, Javier Martinez Canillas wrote:
> The invoked function already returns zero on success or a negative
> errno code so there is no need to open code the logic in the caller.
> 
> This also fixes the following make coccicheck warning:
> 
> drivers/input/keyboard/cap11xx.c:475:1-6: WARNING: end returns can be simplified
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

Acked-by: Daniel Mack <daniel@zonque.org>

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
>  
>  static const struct of_device_id cap11xx_dt_ids[] = {
> 
