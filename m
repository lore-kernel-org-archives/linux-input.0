From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: cyapa: remove redundant assignment to 'pwr_cmd'
Date: Thu, 18 Jan 2018 11:22:25 -0800
Message-ID: <20180118192225.n6scc424psan7iwn@dtor-ws>
References: <20180117104519.19422-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180117104519.19422-1-colin.king@canonical.com>
Sender: kernel-janitors-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Jan 17, 2018 at 10:45:19AM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable pwr_cmd is being assigned to cyapa->suspend_power_mode
> twice, once during the declaration and once after taking an
> interruptible mutex lock.  Remove the redundant first assignment
> since the value is never read and it is outside the mutex lock.
> 
> Cleans up clang warning:
> drivers/input/mouse/cyapa.c:743:5: warning: Value stored to 'pwr_cmd'
> during its initialization is never read
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied, thank you.

> ---
>  drivers/input/mouse/cyapa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/mouse/cyapa.c b/drivers/input/mouse/cyapa.c
> index fd8865c65caf..dfd3873513e4 100644
> --- a/drivers/input/mouse/cyapa.c
> +++ b/drivers/input/mouse/cyapa.c
> @@ -740,7 +740,7 @@ static ssize_t cyapa_show_suspend_scanrate(struct device *dev,
>  					   char *buf)
>  {
>  	struct cyapa *cyapa = dev_get_drvdata(dev);
> -	u8 pwr_cmd = cyapa->suspend_power_mode;
> +	u8 pwr_cmd;
>  	u16 sleep_time;
>  	int len;
>  	int error;
> -- 
> 2.15.1
> 

-- 
Dmitry
