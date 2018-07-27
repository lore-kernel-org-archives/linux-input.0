From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: touchscreen: wdt87xx_i2c: Replace mdelay() with
 msleep() in wdt87xx_resume()
Date: Fri, 27 Jul 2018 11:30:41 -0700
Message-ID: <20180727183041.GA72640@dtor-ws>
References: <20180727023216.1467-1-baijiaju1990@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180727023216.1467-1-baijiaju1990@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: rydberg@bitmath.org, gregkh@linuxfoundation.org, andi@etezian.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Jul 27, 2018 at 10:32:16AM +0800, Jia-Ju Bai wrote:
> wdt87xx_resume() is never called in atomic context.
> It calls mdelay() to busily wait, which is not necessary.
> mdelay() can be replaced with msleep().
> 
> This is found by a static analysis tool named DCNS written by myself.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Applied, thank you.

> ---
>  drivers/input/touchscreen/wdt87xx_i2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/wdt87xx_i2c.c b/drivers/input/touchscreen/wdt87xx_i2c.c
> index 20f7f3902757..166edeb77776 100644
> --- a/drivers/input/touchscreen/wdt87xx_i2c.c
> +++ b/drivers/input/touchscreen/wdt87xx_i2c.c
> @@ -1142,7 +1142,7 @@ static int __maybe_unused wdt87xx_resume(struct device *dev)
>  	 * The chip may have been reset while system is resuming,
>  	 * give it some time to settle.
>  	 */
> -	mdelay(100);
> +	msleep(100);
>  
>  	error = wdt87xx_send_command(client, VND_CMD_START, 0);
>  	if (error)
> -- 
> 2.17.0
> 

-- 
Dmitry
