From: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: keyboard: snvs: use dev_pm_set_wake_irq() to
 simplify code
Date: Wed, 3 Apr 2019 15:16:42 -0700
Message-ID: <20190403221642.GF53104@dtor-ws>
References: <1553666576-21621-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1553666576-21621-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <anson.huang@nxp.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-input@vger.kernel.org

On Wed, Mar 27, 2019 at 06:08:05AM +0000, Anson Huang wrote:
> With calling dev_pm_set_wake_irq() to set SNVS ON/OFF button
> as wakeup source for suspend, generic wake irq mechanism
> will automatically enable it as wakeup source when suspend,
> then the enable_irq_wake()/disable_irq_wake() can be removed
> in suspend/resume callback, it simplifies the code.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thank you.

> ---
>  drivers/input/keyboard/snvs_pwrkey.c | 30 ++++--------------------------
>  1 file changed, 4 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/snvs_pwrkey.c
> index 4c67cf3..5342d8d 100644
> --- a/drivers/input/keyboard/snvs_pwrkey.c
> +++ b/drivers/input/keyboard/snvs_pwrkey.c
> @@ -15,6 +15,7 @@
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_wakeirq.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/regmap.h>
>  
> @@ -167,28 +168,9 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
>  	}
>  
>  	device_init_wakeup(&pdev->dev, pdata->wakeup);
> -
> -	return 0;
> -}
> -
> -static int __maybe_unused imx_snvs_pwrkey_suspend(struct device *dev)
> -{
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct pwrkey_drv_data *pdata = platform_get_drvdata(pdev);
> -
> -	if (device_may_wakeup(&pdev->dev))
> -		enable_irq_wake(pdata->irq);
> -
> -	return 0;
> -}
> -
> -static int __maybe_unused imx_snvs_pwrkey_resume(struct device *dev)
> -{
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct pwrkey_drv_data *pdata = platform_get_drvdata(pdev);
> -
> -	if (device_may_wakeup(&pdev->dev))
> -		disable_irq_wake(pdata->irq);
> +	error = dev_pm_set_wake_irq(&pdev->dev, pdata->irq);
> +	if (error)
> +		dev_err(&pdev->dev, "irq wake enable failed.\n");
>  
>  	return 0;
>  }
> @@ -199,13 +181,9 @@ static const struct of_device_id imx_snvs_pwrkey_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(of, imx_snvs_pwrkey_ids);
>  
> -static SIMPLE_DEV_PM_OPS(imx_snvs_pwrkey_pm_ops, imx_snvs_pwrkey_suspend,
> -				imx_snvs_pwrkey_resume);
> -
>  static struct platform_driver imx_snvs_pwrkey_driver = {
>  	.driver = {
>  		.name = "snvs_pwrkey",
> -		.pm     = &imx_snvs_pwrkey_pm_ops,
>  		.of_match_table = imx_snvs_pwrkey_ids,
>  	},
>  	.probe = imx_snvs_pwrkey_probe,
> -- 
> 2.7.4
> 

-- 
Dmitry
