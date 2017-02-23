From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/4] input:touchscreen:ad7879-spi.c: Remove bits_per_word
 = 16 enforcement
Date: Thu, 23 Feb 2017 00:41:18 -0800
Message-ID: <20170223084118.GH18639@dtor-ws>
References: <1487780078-18510-1-git-send-email-michael.hennerich@analog.com>
 <1487780078-18510-3-git-send-email-michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1487780078-18510-3-git-send-email-michael.hennerich@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
To: michael.hennerich@analog.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Feb 22, 2017 at 05:14:36PM +0100, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> Using regmap this is no longer required.
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>

This gave me warnings about unused "err" variable, I removed it and
applied, thank you.

> ---
>  drivers/input/touchscreen/ad7879-spi.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/ad7879-spi.c b/drivers/input/touchscreen/ad7879-spi.c
> index b995891..904a2c2 100644
> --- a/drivers/input/touchscreen/ad7879-spi.c
> +++ b/drivers/input/touchscreen/ad7879-spi.c
> @@ -42,13 +42,6 @@ static int ad7879_spi_probe(struct spi_device *spi)
>  		return -EINVAL;
>  	}
>  
> -	spi->bits_per_word = 16;
> -	err = spi_setup(spi);
> -	if (err) {
> -		dev_dbg(&spi->dev, "spi master doesn't support 16 bits/word\n");
> -		return err;
> -	}
> -
>  	regmap = devm_regmap_init_spi(spi, &ad7879_spi_regmap_config);
>  	if (IS_ERR(regmap))
>  		return PTR_ERR(regmap);
> -- 
> 2.7.4
> 

-- 
Dmitry
