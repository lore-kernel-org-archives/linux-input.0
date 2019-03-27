From: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: keyboard: snvs: make sure irq is handled correctly
Date: Tue, 26 Mar 2019 21:29:03 -0700
Message-ID: <20190327042903.GA40550@dtor-ws>
References: <1553654517-7810-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1553654517-7810-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <anson.huang@nxp.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-input@vger.kernel.org

Hi Anson,

On Wed, Mar 27, 2019 at 02:47:06AM +0000, Anson Huang wrote:
> SNVS IRQ is requested before necessary driver data initialized,
> if there is a pending IRQ during driver probe phase, kernel
> NULL pointer panic will occur in IRQ handler. To avoid such
> scenario, need to move the IRQ request to after driver data
> initialization done. This patch is inspired by NXP's internal
> kernel tree.
> 
> Fixes: d3dc6e232215 ("input: keyboard: imx: add snvs power key driver")
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/input/keyboard/snvs_pwrkey.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/snvs_pwrkey.c
> index effb632..6ff41fd 100644
> --- a/drivers/input/keyboard/snvs_pwrkey.c
> +++ b/drivers/input/keyboard/snvs_pwrkey.c
> @@ -148,15 +148,6 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
>  		return error;
>  	}
>  
> -	error = devm_request_irq(&pdev->dev, pdata->irq,
> -			       imx_snvs_pwrkey_interrupt,
> -			       0, pdev->name, pdev);
> -
> -	if (error) {
> -		dev_err(&pdev->dev, "interrupt not available.\n");
> -		return error;
> -	}
> -
>  	error = input_register_device(input);
>  	if (error < 0) {
>  		dev_err(&pdev->dev, "failed to register input device\n");
> @@ -166,6 +157,14 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
>  	pdata->input = input;
>  	platform_set_drvdata(pdev, pdata);
>  
> +	error = devm_request_irq(&pdev->dev, pdata->irq,
> +				 imx_snvs_pwrkey_interrupt,
> +				 0, pdev->name, pdev);
> +	if (error) {
> +		dev_err(&pdev->dev, "interrupt not available.\n");
> +		return error;
> +	}

Instead of moving devm_request_irq() around could you simply move
pdata->input = input assignment higher? It is perfectly fine to try
calling input_event() on input device that is allocated but not yet
registered.

> +
>  	device_init_wakeup(&pdev->dev, pdata->wakeup);

Unrelated suggestion:

Can you try calling dev_pm_set_wake_irq(&pdev->dev, pdata->irq) here and
I think you will be able to get rid of suspend/resume methods in the
driver.

Thanks.

-- 
Dmitry
