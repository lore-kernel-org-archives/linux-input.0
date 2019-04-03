From: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH V2] input: keyboard: snvs: initialize necessary driver
 data before enabling IRQ
Date: Wed, 3 Apr 2019 15:15:28 -0700
Message-ID: <20190403221528.GE53104@dtor-ws>
References: <1553666514-21505-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1553666514-21505-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <anson.huang@nxp.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-input@vger.kernel.org

On Wed, Mar 27, 2019 at 06:07:06AM +0000, Anson Huang wrote:
> SNVS IRQ is requested before necessary driver data initialized,
> if there is a pending IRQ during driver probe phase, kernel
> NULL pointer panic will occur in IRQ handler. To avoid such
> scenario, just initialize necessary driver data before enabling
> IRQ. This patch is inspired by NXP's internal kernel tree.
> 
> Fixes: d3dc6e232215 ("input: keyboard: imx: add snvs power key driver")
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thank you.

> ---
> Changes since V1:
> 	- move the platform data initialization to before IRQ enable instead of moving the IRQ enable
> 	  to the end of probe function.
> ---
>  drivers/input/keyboard/snvs_pwrkey.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/snvs_pwrkey.c
> index effb632..4c67cf3 100644
> --- a/drivers/input/keyboard/snvs_pwrkey.c
> +++ b/drivers/input/keyboard/snvs_pwrkey.c
> @@ -148,6 +148,9 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
>  		return error;
>  	}
>  
> +	pdata->input = input;
> +	platform_set_drvdata(pdev, pdata);
> +
>  	error = devm_request_irq(&pdev->dev, pdata->irq,
>  			       imx_snvs_pwrkey_interrupt,
>  			       0, pdev->name, pdev);
> @@ -163,9 +166,6 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
>  		return error;
>  	}
>  
> -	pdata->input = input;
> -	platform_set_drvdata(pdev, pdata);
> -
>  	device_init_wakeup(&pdev->dev, pdata->wakeup);
>  
>  	return 0;
> -- 
> 2.7.4
> 

-- 
Dmitry
