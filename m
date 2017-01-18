From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 14/33] Input: gpio_decoder - Drop unnecessary call to
 platform_set_drvdata and other changes
Date: Wed, 18 Jan 2017 11:40:34 -0800
Message-ID: <20170118194034.GH33920@dtor-ws>
References: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
 <1484761614-12225-15-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1484761614-12225-15-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, Vignesh R <vigneshr@ti.com>
List-Id: linux-input@vger.kernel.org

On Wed, Jan 18, 2017 at 09:46:35AM -0800, Guenter Roeck wrote:
> There is no call to platform_get_drvdata() or dev_get_drvdata().
> Drop the unnecessary call to platform_set_drvdata().
> 
> This conversion was done automatically with coccinelle using the
> following semantic patches. The semantic patches and the scripts
> used to generate this commit log are available at
> https://github.com/groeck/coccinelle-patches
> 
> - Drop platform_set_drvdata()
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Applied, thank you.

> ---
>  drivers/input/misc/gpio_decoder.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/input/misc/gpio_decoder.c b/drivers/input/misc/gpio_decoder.c
> index ca7e0bacb2d8..1dca526e6f1a 100644
> --- a/drivers/input/misc/gpio_decoder.c
> +++ b/drivers/input/misc/gpio_decoder.c
> @@ -110,7 +110,6 @@ static int gpio_decoder_probe(struct platform_device *pdev)
>  		dev_err(dev, "failed to register polled  device\n");
>  		return err;
>  	}
> -	platform_set_drvdata(pdev, decoder);
>  
>  	return 0;
>  }
> -- 
> 2.7.4
> 

-- 
Dmitry
