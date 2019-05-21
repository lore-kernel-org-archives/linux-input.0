From: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: imx6ul_tsc: use devm_platform_ioremap_resource()
 to simplify code
Date: Mon, 20 May 2019 22:13:00 -0700
Message-ID: <20190521051300.GF183429@dtor-ws>
References: <1554095712-15413-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1554095712-15413-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <anson.huang@nxp.com>
Cc: "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-input@vger.kernel.org

On Mon, Apr 01, 2019 at 05:19:55AM +0000, Anson Huang wrote:
> Use the new helper devm_platform_ioremap_resource() which wraps the
> platform_get_resource() and devm_ioremap_resource() together, to
> simplify the code.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thank you.

> ---
>  drivers/input/touchscreen/imx6ul_tsc.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/imx6ul_tsc.c b/drivers/input/touchscreen/imx6ul_tsc.c
> index c10fc59..e04eecd 100644
> --- a/drivers/input/touchscreen/imx6ul_tsc.c
> +++ b/drivers/input/touchscreen/imx6ul_tsc.c
> @@ -364,8 +364,6 @@ static int imx6ul_tsc_probe(struct platform_device *pdev)
>  	struct device_node *np = pdev->dev.of_node;
>  	struct imx6ul_tsc *tsc;
>  	struct input_dev *input_dev;
> -	struct resource *tsc_mem;
> -	struct resource *adc_mem;
>  	int err;
>  	int tsc_irq;
>  	int adc_irq;
> @@ -403,16 +401,14 @@ static int imx6ul_tsc_probe(struct platform_device *pdev)
>  		return err;
>  	}
>  
> -	tsc_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	tsc->tsc_regs = devm_ioremap_resource(&pdev->dev, tsc_mem);
> +	tsc->tsc_regs = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(tsc->tsc_regs)) {
>  		err = PTR_ERR(tsc->tsc_regs);
>  		dev_err(&pdev->dev, "failed to remap tsc memory: %d\n", err);
>  		return err;
>  	}
>  
> -	adc_mem = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -	tsc->adc_regs = devm_ioremap_resource(&pdev->dev, adc_mem);
> +	tsc->adc_regs = devm_platform_ioremap_resource(pdev, 1);
>  	if (IS_ERR(tsc->adc_regs)) {
>  		err = PTR_ERR(tsc->adc_regs);
>  		dev_err(&pdev->dev, "failed to remap adc memory: %d\n", err);
> -- 
> 2.7.4
> 

-- 
Dmitry
