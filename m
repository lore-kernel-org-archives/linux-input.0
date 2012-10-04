From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: samsung-keypad: add clk_prepare and clk_unprepare
Date: Thu, 4 Oct 2012 00:25:45 -0700
Message-ID: <20121004072545.GF14217@core.coreip.homeip.net>
References: <1349220712-2516-1-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1349220712-2516-1-git-send-email-thomas.abraham@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: linux-input@vger.kernel.org, kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Oct 03, 2012 at 08:31:52AM +0900, Thomas Abraham wrote:
> Add calls to clk_prepare and clk_unprepare as required by commom clock
> framework.
> 
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>

Applied, thank you Thomas. 

> ---
>  drivers/input/keyboard/samsung-keypad.c |   11 ++++++++++-
>  1 files changed, 10 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/input/keyboard/samsung-keypad.c b/drivers/input/keyboard/samsung-keypad.c
> index 277e26d..9d7a111 100644
> --- a/drivers/input/keyboard/samsung-keypad.c
> +++ b/drivers/input/keyboard/samsung-keypad.c
> @@ -431,6 +431,12 @@ static int __devinit samsung_keypad_probe(struct platform_device *pdev)
>  		goto err_unmap_base;
>  	}
>  
> +	error = clk_prepare(keypad->clk);
> +	if (error) {
> +		dev_err(&pdev->dev, "keypad clock prepare failed\n");
> +		goto err_put_clk;
> +	}
> +
>  	keypad->input_dev = input_dev;
>  	keypad->pdev = pdev;
>  	keypad->row_shift = row_shift;
> @@ -461,7 +467,7 @@ static int __devinit samsung_keypad_probe(struct platform_device *pdev)
>  					   keypad->keycodes, input_dev);
>  	if (error) {
>  		dev_err(&pdev->dev, "failed to build keymap\n");
> -		goto err_put_clk;
> +		goto err_unprepare_clk;
>  	}
>  
>  	input_set_capability(input_dev, EV_MSC, MSC_SCAN);
> @@ -503,6 +509,8 @@ err_free_irq:
>  	pm_runtime_disable(&pdev->dev);
>  	device_init_wakeup(&pdev->dev, 0);
>  	platform_set_drvdata(pdev, NULL);
> +err_unprepare_clk:
> +	clk_unprepare(keypad->clk);
>  err_put_clk:
>  	clk_put(keypad->clk);
>  	samsung_keypad_dt_gpio_free(keypad);
> @@ -531,6 +539,7 @@ static int __devexit samsung_keypad_remove(struct platform_device *pdev)
>  	 */
>  	free_irq(keypad->irq, keypad);
>  
> +	clk_unprepare(keypad->clk);
>  	clk_put(keypad->clk);
>  	samsung_keypad_dt_gpio_free(keypad);
>  
> -- 
> 1.7.4.1
> 

-- 
Dmitry
