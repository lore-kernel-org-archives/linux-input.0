From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: add error handling for da9052_reg_write
Date: Mon, 11 Jun 2018 10:30:17 -0700
Message-ID: <20180611173017.GD251078@dtor-ws>
References: <1528694619-31889-1-git-send-email-jiazhouyang09@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1528694619-31889-1-git-send-email-jiazhouyang09@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhouyang Jia <jiazhouyang09@gmail.com>
Cc: Support Opensource <support.opensource@diasemi.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Zhouyang,

On Mon, Jun 11, 2018 at 01:23:39PM +0800, Zhouyang Jia wrote:
> When da9052_reg_write fails, the lack of error-handling code may
> cause unexpected results.
> 
> This patch adds error-handling code after calling da9052_reg_write.
> 
> Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
> ---
>  drivers/input/touchscreen/da9052_tsi.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/da9052_tsi.c b/drivers/input/touchscreen/da9052_tsi.c
> index b5dfd594..60c82a0 100644
> --- a/drivers/input/touchscreen/da9052_tsi.c
> +++ b/drivers/input/touchscreen/da9052_tsi.c
> @@ -319,8 +319,11 @@ static int da9052_ts_probe(struct platform_device *pdev)
>  static int  da9052_ts_remove(struct platform_device *pdev)
>  {
>  	struct da9052_tsi *tsi = platform_get_drvdata(pdev);
> +	int error;
>  
> -	da9052_reg_write(tsi->da9052, DA9052_LDO9_REG, 0x19);
> +	error = da9052_reg_write(tsi->da9052, DA9052_LDO9_REG, 0x19);
> +	if (error < 0)
> +		return error;

No, this does not help anything. The remove() action must not fail
(really, having it return an int and not void was an API mistake made
long time ago), and thus returning early in and event of error failing
to communicate with the device is a mistake. You really want to release
the interrupts and memory and unregister input device before returning.

>  
>  	da9052_free_irq(tsi->da9052, DA9052_IRQ_TSIREADY, tsi);
>  	da9052_free_irq(tsi->da9052, DA9052_IRQ_PENDOWN, tsi);
> -- 
> 2.7.4
> 

Thanks.

-- 
Dmitry
