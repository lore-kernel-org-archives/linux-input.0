From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH -next] keyboard: remove set but not used variables 'sts'
Date: Tue, 16 Jul 2019 20:17:06 +0200
Message-ID: <20190716181706.GA1140@penguin>
References: <20190716085423.19443-1-maowenan@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190716085423.19443-1-maowenan@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mao Wenan <maowenan@huawei.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Jul 16, 2019 at 04:54:23PM +0800, Mao Wenan wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/input/keyboard/applespi.c: In function applespi_set_bl_level:
> drivers/input/keyboard/applespi.c:902:6: warning: variable sts set but not used [-Wunused-but-set-variable]
> 
> Fixes: b426ac0452093d ("Input: add Apple SPI keyboard and trackpad driver")
> 
> Signed-off-by: Mao Wenan <maowenan@huawei.com>

Applied, thank you.

> ---
>  drivers/input/keyboard/applespi.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/applespi.c
> index c1a6843..548737e 100644
> --- a/drivers/input/keyboard/applespi.c
> +++ b/drivers/input/keyboard/applespi.c
> @@ -899,7 +899,6 @@ static void applespi_set_bl_level(struct led_classdev *led_cdev,
>  	struct applespi_data *applespi =
>  		container_of(led_cdev, struct applespi_data, backlight_info);
>  	unsigned long flags;
> -	int sts;
>  
>  	spin_lock_irqsave(&applespi->cmd_msg_lock, flags);
>  
> @@ -916,7 +915,7 @@ static void applespi_set_bl_level(struct led_classdev *led_cdev,
>  			 KBD_BL_LEVEL_MIN);
>  	}
>  
> -	sts = applespi_send_cmd_msg(applespi);
> +	applespi_send_cmd_msg(applespi);
>  
>  	spin_unlock_irqrestore(&applespi->cmd_msg_lock, flags);
>  }
> -- 
> 2.7.4
> 

-- 
Dmitry
