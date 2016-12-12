From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH] Input: drv260x - fix initializing overdrive voltage
Date: Mon, 12 Dec 2016 07:00:29 -0600
Message-ID: <584E9F6D.1080209@ti.com>
References: <20161211065956.GA17809@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161211065956.GA17809@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Dmitry

On 12/11/2016 12:59 AM, Dmitry Torokhov wrote:
> We were accidentally initializing haptics->rated_voltage twice, and did not
> initialize overdrive voltage.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/misc/drv260x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
> index 2adfd86c..9789d4f 100644
> --- a/drivers/input/misc/drv260x.c
> +++ b/drivers/input/misc/drv260x.c
> @@ -521,7 +521,7 @@ static int drv260x_probe(struct i2c_client *client,
>  	if (!haptics)
>  		return -ENOMEM;
>  
> -	haptics->rated_voltage = DRV260X_DEF_OD_CLAMP_VOLT;
> +	haptics->overdrive_voltage = DRV260X_DEF_OD_CLAMP_VOLT;
>  	haptics->rated_voltage = DRV260X_DEF_RATED_VOLT;
>  
>  	if (pdata) {
Thanks for the fix

Acked-by: Dan Murphy <dmurphy@ti.com>

-- 
------------------
Dan Murphy
