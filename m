From: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: elants_i2c - return real value of
 elants_i2c_initialize()
Date: Thu, 29 Aug 2019 11:29:33 -0700
Message-ID: <20190829182933.GD187474@dtor-ws>
References: <1566958886-25756-1-git-send-email-johnny.chuang@emc.com.tw>
 <000601d55d49$05878160$10968420$@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <000601d55d49$05878160$10968420$@emc.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
To: "Johnny.Chuang" <johnny.chuang@emc.com.tw>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, =?utf-8?B?U1RSRDIt6JSh5oOg5ayL?= <jennifer.tsai@emc.com.tw>, =?utf-8?B?U1RSRDIt6Zmz5bSH5piO57aT55CG?= <james.chen@emc.com.tw>, =?utf-8?B?J+aigeWNmue/lCc=?= <paul.liang@emc.com.tw>, 'jeff' <jeff.chuang@emc.com.tw>
List-Id: linux-input@vger.kernel.org

Hi Johnny,

On Wed, Aug 28, 2019 at 10:33:46AM +0800, Johnny.Chuang wrote:
> The return value of elants_i2c_initialize() was always 0.
> It maybe register input device when initialize fail.

We do not want to return error here, because it will abort probe, and
then we will not be able to initiate firmware flash flow so we can
attempt to recover the device.

If you want to try you can change the ts->iap_mode before trying to
register input device, but then you need to be very careful about
registering and unregistering it later, after flashing or re-flashing
firmware.

> 
> Signed-off-by: Johnny Chuang <johnny.chuang@emc.com.tw>
> ---
>  drivers/input/touchscreen/elants_i2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/elants_i2c.c
> b/drivers/input/touchscreen/elants_i2c.c
> index d4ad24e..9c9816f 100644
> --- a/drivers/input/touchscreen/elants_i2c.c
> +++ b/drivers/input/touchscreen/elants_i2c.c
> @@ -571,7 +571,7 @@ static int elants_i2c_initialize(struct elants_data *ts)
>  	if (error)
>  		ts->iap_mode = ELAN_IAP_RECOVERY;
>  
> -	return 0;
> +	return error;
>  }
>  
>  /*
> -- 
> 2.7.4
> 

Thanks.

-- 
Dmitry
