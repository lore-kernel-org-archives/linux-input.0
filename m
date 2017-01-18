From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 24/33] Input: ar1021_i2c - Drop unnecessary call to
 i2c_set_clientdata and other changes
Date: Wed, 18 Jan 2017 11:21:02 -0800
Message-ID: <20170118192102.GB33920@dtor-ws>
References: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
 <1484761614-12225-25-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33236 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752714AbdARTXM (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 18 Jan 2017 14:23:12 -0500
Content-Disposition: inline
In-Reply-To: <1484761614-12225-25-git-send-email-linux@roeck-us.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jan 18, 2017 at 09:46:45AM -0800, Guenter Roeck wrote:
> There is no call to i2c_get_clientdata() or dev_get_drvdata().
> Drop the unnecessary call to i2c_set_clientdata().

Kept just this part and applied.

> 
> This conversion was done automatically with coccinelle using the
> following semantic patches. The semantic patches and the scripts
> used to generate this commit log are available at
> https://github.com/groeck/coccinelle-patches
> 
> - Replace 'goto l; ... l: return e;' with 'return e;'
> - Drop i2c_set_clientdata()
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/input/touchscreen/ar1021_i2c.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/ar1021_i2c.c b/drivers/input/touchscreen/ar1021_i2c.c
> index 71b5a634cf6d..b289eca2b797 100644
> --- a/drivers/input/touchscreen/ar1021_i2c.c
> +++ b/drivers/input/touchscreen/ar1021_i2c.c
> @@ -35,11 +35,11 @@ static irqreturn_t ar1021_i2c_irq(int irq, void *dev_id)
>  	retval = i2c_master_recv(ar1021->client,
>  				ar1021->data, sizeof(ar1021->data));
>  	if (retval != sizeof(ar1021->data))
> -		goto out;
> +		return IRQ_HANDLED;
>  
>  	/* sync bit set ? */
>  	if ((data[0] & 0x80) == 0)
> -		goto out;
> +		return IRQ_HANDLED;
>  
>  	button = data[0] & BIT(0);
>  	x = ((data[2] & 0x1f) << 7) | (data[1] & 0x7f);
> @@ -50,7 +50,6 @@ static irqreturn_t ar1021_i2c_irq(int irq, void *dev_id)
>  	input_report_key(input, BTN_TOUCH, button);
>  	input_sync(input);
>  
> -out:
>  	return IRQ_HANDLED;
>  }
>  
> @@ -127,7 +126,6 @@ static int ar1021_i2c_probe(struct i2c_client *client,
>  		return error;
>  	}
>  
> -	i2c_set_clientdata(client, ar1021);
>  	return 0;
>  }
>  
> -- 
> 2.7.4
> 

-- 
Dmitry
