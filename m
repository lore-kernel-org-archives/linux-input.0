From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 6/9 v2] Input: sun4i-ts - constify
 thermal_zone_of_device_ops structures
Date: Mon, 14 Aug 2017 22:10:35 -0700
Message-ID: <20170815051035.GA40695@dtor-ws>
References: <1502204943-20075-1-git-send-email-Julia.Lawall@lip6.fr>
 <1502204943-20075-7-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1502204943-20075-7-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: bhumirks@gmail.com, kernel-janitors@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Aug 08, 2017 at 05:09:00PM +0200, Julia Lawall wrote:
> The thermal_zone_of_device_ops structure is only passed as the fourth
> argument to devm_thermal_zone_of_sensor_register, which is declared
> as const.  Thus the thermal_zone_of_device_ops structure itself can
> be const.
> 
> Done with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Applied, thank you.

> 
> ---
> 
> v2: New patch
> 
>  drivers/input/touchscreen/sun4i-ts.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/sun4i-ts.c b/drivers/input/touchscreen/sun4i-ts.c
> index d07dd29..d2e14d9 100644
> --- a/drivers/input/touchscreen/sun4i-ts.c
> +++ b/drivers/input/touchscreen/sun4i-ts.c
> @@ -206,7 +206,7 @@ static int sun4i_get_tz_temp(void *data, int *temp)
>  	return sun4i_get_temp(data, temp);
>  }
>  
> -static struct thermal_zone_of_device_ops sun4i_ts_tz_ops = {
> +static const struct thermal_zone_of_device_ops sun4i_ts_tz_ops = {
>  	.get_temp = sun4i_get_tz_temp,
>  };
>  
> 

-- 
Dmitry
