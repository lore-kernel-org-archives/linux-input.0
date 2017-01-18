From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 22/33] Input: at32psif - Drop unnecessary error messages
 and other changes
Date: Wed, 18 Jan 2017 11:13:52 -0800
Message-ID: <20170118191352.GB9584@dtor-ws>
References: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
 <1484761614-12225-23-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34682 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751076AbdARTN4 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 18 Jan 2017 14:13:56 -0500
Content-Disposition: inline
In-Reply-To: <1484761614-12225-23-git-send-email-linux@roeck-us.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jan 18, 2017 at 09:46:43AM -0800, Guenter Roeck wrote:
> Error messages after memory allocation failures are unnecessary and
> can be dropped.
> 
> This conversion was done automatically with coccinelle using the
> following semantic patches. The semantic patches and the scripts
> used to generate this commit log are available at
> https://github.com/groeck/coccinelle-patches
> 
> - Drop unnecessary braces around conditional return statements
> - Drop error message after devm_kzalloc() failure
> - Replace 'goto l; ... l: return e;' with 'return e;'
> - Replace 'val = e; return val;' with 'return e;'
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/input/serio/at32psif.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/input/serio/at32psif.c b/drivers/input/serio/at32psif.c
> index 2e4ff5bac754..e420fd781d44 100644
> --- a/drivers/input/serio/at32psif.c
> +++ b/drivers/input/serio/at32psif.c
> @@ -159,13 +159,12 @@ static int psif_open(struct serio *io)
>  
>  	retval = clk_enable(psif->pclk);
>  	if (retval)
> -		goto out;
> +		return retval;
>  
>  	psif_writel(psif, CR, PSIF_BIT(CR_TXEN) | PSIF_BIT(CR_RXEN));
>  	psif_writel(psif, IER, PSIF_BIT(RXRDY));
>  
>  	psif->open = true;
> -out:
>  	return retval;
>  }
>  
> @@ -210,16 +209,12 @@ static int __init psif_probe(struct platform_device *pdev)
>  	int ret;
>  
>  	psif = kzalloc(sizeof(struct psif), GFP_KERNEL);
> -	if (!psif) {
> -		dev_dbg(&pdev->dev, "out of memory\n");

I guess nobody will see these messages unless actively debugging, so I'm
OK with these gone.

> -		ret = -ENOMEM;
> -		goto out;
> -	}
> +	if (!psif)
> +		return -ENOMEM;
>  	psif->pdev = pdev;
>  
>  	io = kzalloc(sizeof(struct serio), GFP_KERNEL);
>  	if (!io) {
> -		dev_dbg(&pdev->dev, "out of memory\n");
>  		ret = -ENOMEM;
>  		goto out_free_psif;
>  	}
> @@ -297,7 +292,6 @@ static int __init psif_probe(struct platform_device *pdev)
>  	kfree(io);
>  out_free_psif:
>  	kfree(psif);
> -out:
>  	return ret;
>  }
>  
> -- 
> 2.7.4
> 

Applied, thanks.

-- 
Dmitry
