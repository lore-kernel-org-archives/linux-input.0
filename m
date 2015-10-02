From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 02/18] Input: ads7846 - use PTR_ERR_OR_ZERO()
Date: Fri, 2 Oct 2015 11:21:44 -0700
Message-ID: <20151002182144.GO8437@dtor-ws>
References: <1443793229-22363-1-git-send-email-javier@osg.samsung.com>
 <1443793229-22363-3-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1443793229-22363-3-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>
List-Id: linux-input@vger.kernel.org

On Fri, Oct 02, 2015 at 03:40:13PM +0200, Javier Martinez Canillas wrote:
> The PTR_ERR_OR_ZERO() helper function checks if a pointer contains an
> errno code and returns it or return 0 if that's not the case. Use the
> helper instead of open coding the same logic in the driver. This was
> found with make coccicheck that complains with the following warning:
> 
> drivers/input/touchscreen/ads7846.c:532:1-3: WARNING: PTR_ERR_OR_ZERO can be used
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

Applied, thank you.

> ---
> 
>  drivers/input/touchscreen/ads7846.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
> index 0f5f968592bd..727d88c900c1 100644
> --- a/drivers/input/touchscreen/ads7846.c
> +++ b/drivers/input/touchscreen/ads7846.c
> @@ -529,10 +529,8 @@ static int ads784x_hwmon_register(struct spi_device *spi, struct ads7846 *ts)
>  
>  	ts->hwmon = hwmon_device_register_with_groups(&spi->dev, spi->modalias,
>  						      ts, ads7846_attr_groups);
> -	if (IS_ERR(ts->hwmon))
> -		return PTR_ERR(ts->hwmon);
>  
> -	return 0;
> +	return PTR_ERR_OR_ZERO(ts->hwmon);
>  }
>  
>  static void ads784x_hwmon_unregister(struct spi_device *spi,
> -- 
> 2.4.3
> 

-- 
Dmitry
